# Troubleshooting

## Pytest discovered no tests

### Symptom
Running `python -m pytest -v` reported:
"collected 0 items" and "no tests ran".

### Cause
The file was named `test-health.py`.
It did not match pytest's default test filename patterns.

### Fix
Renamed the file to `test_health.py` and ran:
python -m pytest -v

### Verification
Pytest discovered the health endpoint test and it passed.

### Lesson
Check test filenames and discovery rules before reinstalling tools.
## Docker Hub connection failures from WSL

### Symptom
Image pulls from the Docker engine inside Ubuntu failed
with connection timeouts or connection refused.

### Investigation
A Windows request explicitly using QuickQ's local proxy
reached Docker Hub and returned the expected HTTP 401.
The proxy listened only on Windows localhost.
Ubuntu could not reach it through the Windows gateway.

### Resolution
Used Docker Desktop with its system proxy setting.
Stopped the separate Ubuntu Docker service and socket,
then enabled Docker Desktop integration for Ubuntu.

### Verification
- Ubuntu's docker info reported Docker Desktop.
- Built fashsyst-api:0.1 successfully.
- Started the container.
- GET /health returned HTTP 200 and {"status":"ok"}.
- Container logs confirmed successful requests.

### Lesson
Check which Docker engine the CLI uses.
Windows proxy settings do not automatically configure
a separate Docker daemon running inside Ubuntu.