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