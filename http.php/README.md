# Base HTTP PHP image

Serves the files in /app/http directory on port 80.

Uses Apache 2.5 with PHP 7.

## Installation
```console
# siren pull git+https://github.com/LEW21/sirenfiles.git#http.php
```

## Usage in sirenfiles as a base image
```sirenfile
FROM http.php git+https://github.com/LEW21/sirenfiles.git#http.php
```
