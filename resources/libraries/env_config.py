"""
Environment configuration loader for Robot Framework.
Loads variables from YAML files and .env file.
"""
import os
import yaml
from dotenv import load_dotenv

def get_variables(env="dev"):
    """
    Load environment and test data variables.
    Credentials are loaded from .env file (not committed to repo).

    Args:
        env: Environment name (dev, staging, prod). Defaults to 'dev'.

    Returns:
        Dictionary of variables for Robot Framework.
    """
    # Get the project root directory
    current_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(os.path.dirname(current_dir))

    # Load credentials from .env file
    env_path = os.path.join(project_root, ".env")
    load_dotenv(env_path)

    email = os.getenv("GLOP_EMAIL")
    password = os.getenv("GLOP_PASSWORD")

    if not email or not password:
        raise ValueError("Missing credentials. Please set GLOP_EMAIL and GLOP_PASSWORD in .env file")

    # Load the environment config
    config_path = os.path.join(project_root, "data", "environments", f"{env}.yaml")
    with open(config_path, "r") as f:
        config = yaml.safe_load(f)

    # Load vacancy test data
    vacancy_data_path = os.path.join(project_root, "data", "test_data", "vacancy_data.yaml")
    with open(vacancy_data_path, "r") as f:
        vacancy_data = yaml.safe_load(f)

    vacancy = vacancy_data["vacancy"]

    # Force headless mode in CI (GitHub Actions sets CI=true)
    is_ci = os.getenv("CI", "false").lower() == "true"
    headless = True if is_ci else config["browser"]["headless"]

    # Return variables in Robot Framework format
    return {
        # Credentials from .env
        "EMAIL": email,
        "PASSWORD": password,
        # Environment config from YAML
        "BASE_URL": config["base_url"],
        "VACANCY_CREATE_URL": config["vacancy_create_url"],
        "BROWSER_TYPE": config["browser"]["type"],
        "HEADLESS": headless,
        "TIMEOUT": config["browser"]["timeout"],
        # Vacancy test data
        "JOB_TITLE": vacancy["job_title"],
        "SKILLS": vacancy["skills"],
        "DEGREE": vacancy["education"]["degree"],
        "AREA_OF_STUDY": vacancy["education"]["area"],
        "LANGUAGE": vacancy["language"],
        "LOCATION_CITY": vacancy["location"]["city"],
        "LOCATION_TYPE": vacancy["location"]["type"],
        "RATE_CLICKS": vacancy["employment"]["rate_clicks"],
        "JOB_DESCRIPTION": vacancy["description"],
    }
