# Base HTTP Python image

Serves the WSGI app in /app/wsgi.py on port 80.

Uses Gunicorn and Python 3.5.

## Installation
```console
# siren pull git+https://github.com/LEW21/sirenfiles.git#http.python
```

## Usage in sirenfiles as a base image
```sirenfile
FROM http.python git+https://github.com/LEW21/sirenfiles.git#http.python
```
