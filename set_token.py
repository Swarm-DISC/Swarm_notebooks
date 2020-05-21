from viresclient import set_token
from dotenv import load_dotenv
import os

load_dotenv()

if __name__ == "__main__":
    set_token(
        "https://vires.services/ows", set_default=True, token=os.getenv("VIRES_TOKEN"),
    )