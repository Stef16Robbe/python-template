PYTHON_BINARY := "python3"
VIRTUAL_ENV := ".venv"
VIRTUAL_BIN := VIRTUAL_ENV / "bin"
PROJECT_NAME := "project_name"
TEST_DIR := "test"

# Scans the project for security vulnerabilities
bandit:
    {{VIRTUAL_BIN}}/bandit -r {{PROJECT_NAME}}/

# Builds the project in preparation for release
build:
    {{VIRTUAL_BIN}}/python -m build

# Test the project and generate an HTML coverage report
coverage:
    {{VIRTUAL_BIN}}/pytest --cov={{PROJECT_NAME}} --cov-branch --cov-report=html --cov-report=lcov --cov-report=term-missing --cov-fail-under=90

# Cleans the project
clean:
    rm -rf {{VIRTUAL_ENV}} dist *.egg-info .coverage htmlcov .*cache
    find . -name '*.pyc' -delete
    rm -f *.lcov

# Install the project locally
install:
    {{PYTHON_BINARY}} -m venv {{VIRTUAL_ENV}}
    {{VIRTUAL_BIN}}/pip install --upgrade pip
    {{VIRTUAL_BIN}}/pip install -e ."[dev]"

# Run mypy type checking on the project
mypy:
    {{VIRTUAL_BIN}}/mypy {{PROJECT_NAME}}/ {{TEST_DIR}}/

# Test the project
test:
    {{VIRTUAL_BIN}}/pytest

# Lints the project
lint:
    {{VIRTUAL_BIN}}/ruff check --fix {{PROJECT_NAME}}/ {{TEST_DIR}}/
