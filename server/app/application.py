import pymysql
import os
import requests
from dotenv import load_dotenv
import openai
from flask import Flask, jsonify

# OpenAI API key
load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

print("Api key loaded")

application = app = Flask(__name__)

def get_connection():
    connection = pymysql.connect(
        host="mysql-db",
        user="root",
        password="root",
        db="chataii",
        port=3306,
        charset="utf8mb4",
        cursorclass=pymysql.cursors.DictCursor,
    )
    return connection


@app.route("/", methods=["GET"])
def shorten():
    return "Welcome to Chataii API"



# ? OPENAI API REQUEST


def openAI(question):
    completion = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[{"role": "user", "content": question}],
    )
    print(completion.choices[0].message.content)


#! Users routes
# Get all users
app.route("/users", methods=["GET"])
def getUsers():
    cursor = get_connection.cursor()
    cursor.execute("SELECT * FROM user")
    return jsonify(cursor.fetchall())


# # Get one User
# app.route("/users/<id>", methods=["GET"])


# def getUser(id):
#     cursor = db.cursor()
#     cursor.execute("SELECT * FROM user WHERE id = %s", (id))
#     return jsonify(cursor.fetchone())


# # Create User
# app.route("/users", methods=["POST"])


# def createUser():
#     username = requests.json["name"]
#     password = requests.json["password"]
#     cursor = db.cursor()
#     cursor.execute(
#         "INSERT INTO user (username, password) VALUES (%s, %s)", (username, password)
#     )
#     db.commit()
#     return jsonify({"message": "User created successfully"})


# # Update User
# app.route("/users/<id>", methods=["PUT"])


# def updateUser(id):
#     username = requests.json["name"]
#     password = requests.json["password"]
#     cursor = db.cursor()
#     cursor.execute(
#         "UPDATE user SET username = %s, password = %s WHERE id = %s",
#         (username, password, id),
#     )
#     db.commit()
#     return jsonify({"message": "User updated successfully"})


# # Login and get token
# app.route("/auth", methods=["POST"])


# def login():
#     username = requests.json["username"]
#     password = requests.json["password"]
#     cursor = db.cursor()
#     cursor.execute(
#         "SELECT * FROM user WHERE username = %s AND password = %s", (username, password)
#     )
#     user = cursor.fetchone()
#     if user is not None:
#         return jsonify({"message": "Login successful", "token": user[3]})
#     else:
#         return jsonify({"message": "Login failed"})


# #! Universes routes
# # Get all universes
# app.route("/universes", methods=["GET"])


# def getUniverses():
#     cursor = db.cursor()
#     cursor.execute("SELECT * FROM universe")
#     return jsonify(cursor.fetchall())


# # Get one universe
# app.route("/universes/<id>", methods=["GET"])


# def getUniverse(id):
#     cursor = db.cursor()
#     cursor.execute("SELECT * FROM universe WHERE id = %s", (id))
#     return jsonify(cursor.fetchone())


# # Create universe
# app.route("/universes", methods=["POST"])


# def createUniverse():
#     name = requests.json["name"]
#     cursor = db.cursor()
#     cursor.execute("INSERT INTO universe (name) VALUES (%s)", (name))
#     db.commit()
#     return jsonify({"message": "Universe created successfully"})


# # Update universe name
# app.route("/universes/<id>", methods=["PUT"])


# def updateUniverse(id):
#     name = requests.json["name"]
#     cursor = db.cursor()
#     cursor.execute("UPDATE universe SET name = %s WHERE id = %s", (name, id))
#     db.commit()
#     return jsonify({"message": "Universe updated successfully"})


# #! Characters routes
# # Get all characters of an universe
# app.route("/universes/<id>/characters", methods=["GET"])


# def getCharacters(id):
#     cursor = db.cursor()
#     cursor.execute("SELECT * FROM character WHERE id_universe = %s", (id))
#     return jsonify(cursor.fetchall())


# # Get one character
# app.route("/universes/<iduniverse>/characters/<idcharacter>", methods=["GET"])


# def getCharacter(iduniverse, idcharacter):
#     cursor = db.cursor()
#     cursor.execute(
#         "SELECT * FROM character WHERE id = %s AND id_universe = %s",
#         (idcharacter, iduniverse),
#     )
#     return jsonify(cursor.fetchone())


# # Create character
# app.route("/universes/<id>/characters", methods=["POST"])


# def createCharacter(id):
#     name = requests.json["name"]
#     universe = getUniverse(id)
#     description = openAI("Describe " + name + "from " + universe + " in 50 words.")
#     cursor = db.cursor()
#     cursor.execute(
#         "INSERT INTO character (name, description, id_universe) VALUES (%s, %s, %s)",
#         (name, description, id),
#     )
#     db.commit()
#     return jsonify({"message": "Character created successfully"})


# # Generate new description for character
# app.route("/universes/<iduniverse>/characters/<idcharacter>", methods=["PUT"])


# def updateCharacter(iduniverse, idcharacter):
#     name = requests.json["name"]
#     universe = getUniverse(iduniverse)
#     description = openAI("Describe " + name + "from " + universe + " in 50 words.")
#     cursor = db.cursor()
#     cursor.execute(
#         "UPDATE character SET name = %s, description = %s WHERE id = %s AND id_universe = %s",
#         (name, description, idcharacter, iduniverse),
#     )
#     db.commit()
#     return jsonify({"message": "Character updated successfully"})


# #! Conversations routes

# # Get all conversations
# app.route("/conversations", methods=["GET"])


# def getConversations():
#     cursor = db.cursor()
#     cursor.execute("SELECT * FROM conversation")
#     return jsonify(cursor.fetchall())


# # Get one conversation
# app.route("/conversations/<id>", methods=["GET"])


# def getConversation(id):
#     cursor = db.cursor()
#     cursor.execute("SELECT * FROM conversation WHERE id = %s", (id))
#     return jsonify(cursor.fetchone())


# # Create conversation
# app.route("/conversations", methods=["POST"])


# def createConversation():
#     idcharacter = requests.json["idcharacter"]
#     iduser = requests.json["iduser"]
#     cursor = db.cursor()
#     cursor.execute(
#         "INSERT INTO conversation (id_character, id_user) VALUES (%s, %s)",
#         (idcharacter, iduser),
#     )
#     db.commit()
#     return jsonify({"message": "Conversation created successfully"})


# # Delete conversation
# app.route("/conversations/<id>", methods=["DELETE"])


# def deleteConversation(id):
#     cursor = db.cursor()
#     cursor.execute("DELETE FROM conversation WHERE id = %s", (id))
#     db.commit()
#     return jsonify({"message": "Conversation deleted successfully"})


# #! Messages routes

# # Get all messages of a conversation
# app.route("/conversations/<id>/messages", methods=["GET"])


# def getMessages(id):
#     cursor = db.cursor()
#     cursor.execute("SELECT * FROM message WHERE id_conversation = %s", (id))
#     return jsonify(cursor.fetchall())


# # Get one message of a conversation
# app.route("/conversations/<idconv>/messages/<idmsg>", methods=["GET"])


# def getMessage(idconv, idmsg):
#     cursor = db.cursor()
#     cursor.execute(
#         "SELECT * FROM message WHERE id = %s AND id_conversation = %s", (idmsg, idconv)
#     )
#     return jsonify(cursor.fetchone())


# # Send message in a conversation TODO: Send message in a conversation
# app.route("/conversations/<id>/messages", methods=["POST"])


# def sendMessage(id):
#     message = requests.json["message"]
#     cursor = db.cursor()
#     cursor.execute(
#         "INSERT INTO message (message, id_conversation) VALUES (%s, %s)", (message, id)
#     )
#     db.commit()
#     return jsonify({"message": "Message sent successfully"})


# # TODO : Regenerate last message of a conversation


if __name__ == "__main__":
    application.run(host="0.0.0.0", debug=True)
