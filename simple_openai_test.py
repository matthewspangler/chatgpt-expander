import openai
import os
from dotenv import load_dotenv
load_dotenv()

# Set up your OpenAI API key
openai.api_key = os.getenv("openai_api_key")

# Define the prompt you want to send to ChatGPT
pre_prompt = "I need to do the following task on my computer, I need you to break it down into clear steps."

user_prompt = "How do I update my computer?"

full_prompt = "{} {}".format(pre_prompt, user_prompt)

# Define the parameters for the API request
model = "gpt-3.5-turbo"
params = {
    "model": model,
    "messages": [{"role": "user", "content": full_prompt}],
    "temperature": 0.7
}

# Send the request to the OpenAI API
response = openai.ChatCompletion.create(**params)
print(response)

# Print the response from ChatGPT
#print(response.choices[0].text.strip())
print(response.choices[0].message['content'])