import requests
from rich import print
from rich.console import Console
from rich.prompt import Prompt
import os
import call_clerkie

# Set the base URL of the Flask app
base_url = "https://clerkieserverchromeextensionv1.krrishdholakia.repl.co/"
error_log_path = os.path.expanduser("~") + "/.clerkie-cli/clerkie-src/c.log"
user_email_path = os.path.expanduser("~") + "/.clerkie-cli/clerkie-src/clerkie.txt"


def user_q():
  console = Console()
  returned = False
  user_id = call_clerkie.get_user_id()

  user_query = Prompt.ask("[bold green]:robot: How can I help you?")
  if user_query.strip() == "":
    return

  with console.status("[bold green] Clerkie Thinking :robot:") as status:
      while not returned:
        response = requests.get(base_url + "/term", params={"user_query": user_query, "user_id": user_id})
        returned = True

  # Check the status code of the response
  if response.status_code == 200:
    # Print the response body
    clerkie_resp = response.json()["response"].strip()
    print("[bold green]\nClerkie:robot:: " + clerkie_resp)
    return response.json()["response"]
  else:
    # Print an error message
    return


clerkie_resp = user_q()


