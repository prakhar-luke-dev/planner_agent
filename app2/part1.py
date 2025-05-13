from baml_client import b
from baml_client.types import Add, Subtract, Divide, Multiply, Planner, Executor
import asyncio
from dotenv import load_dotenv, find_dotenv
import os
from baml_client.config import reset_baml_env_vars

# Load environment variables only once
load_dotenv(override=True)
API_KEY = str(os.getenv("OPENAI_API"))

reset_baml_env_vars({ "OPENAI_API_KEY":  API_KEY})


def main():
    tools = b.UseTool("Get the sum of ten and twenty, then multiply it by hundred")

    for tool in tools:
        if isinstance(tool, Planner):
            print(f"\n\nPART 1 ANSWER : \n{tool.ans_part1}")
        elif isinstance(tool, Executor):
            print(f"\n\nPART 2 ANSWER : \nFinal answer : {tool.ans_part2}")


if __name__ == '__main__':
    main()
