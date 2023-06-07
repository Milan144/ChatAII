import pymysql
import os
from dotenv import load_dotenv
import openai
from flask import Flask, jsonify, request

# OpenAI API key
load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

print("Api key loaded")

application = app = Flask(__name__)


def create_db_connection():
    connection = pymysql.connect(
        host="mysql-db",
        user="root",
        password="root",
        database="chataii",
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor
    )
    return connection


@app.route("/", methods=["GET"])
def shorten():
    return "Welcome to Chataii API"


# TODO : Implement LOGIN TOKEN

# ? OPENAI API REQUEST
def openai_request(prompt):
    completion = openai.ChatCompletion.create(model="gpt-3.5-turbo",
                                              messages=[
                                                  {"role": "user", "content": prompt}])
    return completion.choices[0].message.content


# ! Users routes

# Get all users
@app.route("/users", methods=["GET"])
def getUsers():
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM user")
            result = cursor.fetchall()
            return jsonify(result)
    finally:
        connection.close()


# Get one User
@app.route("/users/<id>", methods=["GET"])
def getUser(id):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM user WHERE id = %s", (id))
            result = cursor.fetchone()
            return jsonify(result)
    finally:
        connection.close()


# Create User
@app.route("/users", methods=["POST"])
def createUser():
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            username = request.json["username"]
            password = request.json["password"]
            cursor.execute(
                "INSERT INTO user (username, password) VALUES (%s, %s)",
                (username, password),
            )
            connection.commit()
            return jsonify({"message": "User created successfully"})
    finally:
        connection.close()


# Update User
@app.route("/users/<id>", methods=["PUT"])
def updateUser(id):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            username = request.json["username"]
            password = request.json["password"]
            cursor.execute(
                "UPDATE user SET username = %s, password = %s WHERE id = %s",
                (username, password, id),
            )
            connection.commit()
            return jsonify({"message": "User updated successfully"})
    finally:
        connection.close()


# Login and get token
@app.route("/auth", methods=["POST"])
def login():
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            username = request.json["username"]
            password = request.json["password"]
            cursor.execute(
                "SELECT * FROM user WHERE username = %s AND password = %s",
                (username, password),
            )
            result = cursor.fetchone()
            if result:
                return jsonify({"token": result["id"]})
            else:
                return jsonify({"message": "Wrong credentials"})
    finally:
        connection.close()


# ! Universes routes
# Get all universes
@app.route("/universes", methods=["GET"])
def getUniverses():
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM universe")
            result = cursor.fetchall()
            return jsonify(result)
    finally:
        connection.close()


# Get one universe
@app.route("/universes/<universeId>", methods=["GET"])
def getUniverse(universeId):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM universe WHERE universeId = %s", universeId)
            result = cursor.fetchone()
            return jsonify(result)
    finally:
        connection.close()


# Create universe
@app.route("/universes", methods=["POST"])
def createUniverse():
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            name = request.json["name"]
            cursor.execute("INSERT INTO universe (name) VALUES (%s)", (name))
            connection.commit()
            return jsonify({"message": "Universe created successfully"})
    finally:
        connection.close()


# Update universe name
@app.route("/universes/<universeId>", methods=["PUT"])
def updateUniverse(universeId):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            name = request.json["name"]
            cursor.execute("UPDATE universe SET name = %s WHERE universeId = %s", (name, universeId))
            connection.commit()
            return jsonify({"message": "Universe updated successfully"})
    finally:
        connection.close()


# ! Characters routes
# Get all characters of a universe
@app.route("/universes/<id>/characters", methods=["GET"])
def getCharacters(id):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM characterai WHERE universeId = %s", (id))
            result = cursor.fetchall()
            return jsonify(result)
    finally:
        connection.close()


# Get one character
@app.route("/universes/<iduniverse>/characters/<idcharacter>", methods=["GET"])
def getCharacter(iduniverse, idcharacter):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT * FROM characterai WHERE universeId = %s AND id = %s",
                (iduniverse, idcharacter),
            )
            result = cursor.fetchone()
            return jsonify(result)
    finally:
        connection.close()


# Create character
@app.route("/universes/<universeId>/characters", methods=["POST"])
def createCharacter(universeId):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            name = request.json["name"]
            universe = getUniverse(universeId).json["name"]

            prompt = "Describe the story of " + name + " from " + universe + " in 100 words max."
            history = openai_request(prompt)

            cursor.execute(
                "INSERT INTO `characterai` (name, history, universeId) VALUES (%s, %s, %s)",
                (name, history, universeId),
            )
            connection.commit()
            return jsonify({"message": "Character created successfully"})
    finally:
        connection.close()


# Generate new description for character
@app.route("/universes/<iduniverse>/characters/<idcharacter>", methods=["PUT"])
def updateCharacter(iduniverse, idcharacter):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            name = request.json["name"]
            universe = getUniverse(iduniverse)
            history = openai_request("Describe " + name + "from " + universe + " in 50 words.")
            cursor.execute(
                "UPDATE characterai SET name = %s, history = %s WHERE id = %s",
                (name, history, idcharacter),
            )
            connection.commit()
            return jsonify({"message": "Character updated successfully"})
    finally:
        connection.close()


# ! Conversations routes

# Get all conversations
@app.route("/conversations", methods=["GET"])
def getConversations():
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM conversation")
            result = cursor.fetchall()
            return jsonify(result)
    finally:
        connection.close()


# Get one conversation
@app.route("/conversations/<conversationId>", methods=["GET"])
def getConversation(conversationId):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM conversation WHERE conversationId = %s", (conversationId))
            result = cursor.fetchone()
            return jsonify(result)
    finally:
        connection.close()


# Create conversation
@app.route("/conversations", methods=["POST"])
def createConversation():
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            userId = request.json["userId"]
            characterId = request.json["characterId"]
            cursor.execute(
                "INSERT INTO conversation (userId, characterId) VALUES (%s, %s)",
                (userId, characterId),
            )
            connection.commit()
            return jsonify({"message": "Conversation created successfully"})
    finally:
        connection.close()


# ! Messages routes

# Get all messages of a conversation
@app.route("/conversations/<id>/messages", methods=["GET"])
def getMessages(id):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT * FROM message WHERE id_conversation = %s", (id))
            result = cursor.fetchall()
            return jsonify(result)
    finally:
        connection.close()


# Get one message of a conversation
@app.route("/conversations/<idconv>/messages/<idmsg>", methods=["GET"])
def getMessage(idconv, idmsg):
    connection = create_db_connection()
    try:
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT * FROM message WHERE id_conversation = %s AND id = %s",
                (idconv, idmsg),
            )
            result = cursor.fetchone()
            return jsonify(result)
    finally:
        connection.close()


# TODO: Send message in a conversation


# TODO : Regenerate last message of a conversation


if __name__ == "__main__":
    application.run(host="0.0.0.0", debug=True)