from discord_webhook import DiscordWebhook, DiscordEmbed
from rich import print

clerkie_url = 'https://discord.com/api/webhooks/1061836745060139048/K_Eg2IinJCgB-MvgkB1fvEfdCXvaH1hyR6onG4FEo29lMhBoImLM3IofTKuLUkpE-lQV'
SERVER_ID = 1030897552586973265
def post_user_experience(error, clerkie_suggestion, user_name="Default User"):
    webhook = DiscordWebhook(url=clerkie_url, username="cli-bot")
    embed = DiscordEmbed(
        title="Debug Error from CLI", description="", color='03b2f8'
    )
    embed.set_author(
        name=user_name,
        icon_url="https://avatars0.githubusercontent.com/u/14542790",
    )
    embed.set_timestamp()
    # Set `inline=False` for the embed field to occupy the whole line
    embed.add_embed_field(name="Stacktrace", value=error, inline=False)
    embed.add_embed_field(name="Clerkie Response #1", value=clerkie_suggestion, inline=False)

    webhook.add_embed(embed)
    response = webhook.execute()
    if response.status_code == 200:
        data = response.json()
        channel_id = data['channel_id']
        m_id = data['id']
        print("[bold green] You can continue your conversation on discord, I posted information about the error here:")
        print(f'[bold green] https://discordapp.com/channels/{SERVER_ID}/{channel_id}/{m_id}')

test_error = """
Traceback (most recent call last):
  File "message_hook.py", line 4, in <module>
    response = webhook.execute()
  File "/Users/daddyish/Library/Python/3.8/lib/python/site-packages/discord_webhook/webhook.py", line 435, in execute
    response = self.api_post_request()

"""
response = """
you can check that the URL is valid and includes the schema by using the Python requests library. 
You can use the "requests.utils.urlparse" method to check the URL format, and add the schema if needed.
"""
# post_user_experience(test_error, response)


    