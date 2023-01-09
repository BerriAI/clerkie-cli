import requests
from rich import print
from rich.console import Console
import os
import message_hook

# Set the base URL of the Flask app
base_url = "https://clerkieserverchromeextensionv1.krrishdholakia.repl.co/"
error_log_path = os.path.expanduser("~") + "/.clerkie-cli/clerkie-src/c.log"
user_email_path = os.path.expanduser("~") + "/.clerkie-cli/clerkie-src/clerkie.txt"

def get_user_id():
  if not os.path.exists(user_email_path): # if user has not gone through email setup
    return "default_user"
  user_id_file = open(user_email_path, 'r')
  email = ""
  for line in user_id_file:
    line = line.strip()
    if line != "":
      email = line
  return email

def debug_terminal():
  f = open(error_log_path,'r')
  i = 0
  error_msg =""
  for line in f:
      if i > 50:
          break
      error_msg += line.replace('\x00', '') # handle empty bytes, don't send in req
      i+=1
  f.close()

  # clear file
  f = open(error_log_path,'w')
  f.seek(0)
  f.close()
  if len(error_msg.strip())==0: # don't send empty stacktraces
    return

  # Send a GET request to the app with the user_query argument
  console = Console()
  returned = False
  user_id = get_user_id()
  with console.status("[bold green] Clerkie noticed an error. Thinking :robot:") as status:
      while not returned:
        response = requests.get(base_url + "/term", params={"user_query": error_msg, "user_id": user_id})
        returned = True

  # Check the status code of the response
  if response.status_code == 200:
    # Print the response body
    clerkie_resp = response.json()["response"].strip()

    print("[bold green]\nClerkie:robot:: " + clerkie_resp)
    message_hook.post_user_experience(error_msg, clerkie_resp, user_id)
    return response.json()["response"]
  else:
    # Print an error message
    return
    # print("Failed to query the app. Status code: " + str(response.status_code))

clerkie_resp = debug_terminal()

