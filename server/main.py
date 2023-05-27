import os
from dotenv import load_dotenv
import openai
load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")



# OpenAi request 
def sendMessage (question):
   completion = openai.ChatCompletion.create(
      model="gpt-3.5-turbo",
      messages=[
         {"role": "user", "content": question}
      ],
   )
   print(completion.choices[0].message.content)
   

