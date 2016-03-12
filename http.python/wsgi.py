from datetime import datetime

page = """
<!DOCTYPE html>
<html>
	<head>
		<title>http.python container works!</title>
	</head>
	<body>
		<h1>http.python container works!</h1>
		<p>Current server time: {0}</p>
		<p>See <a href="https://github.com/LEW21/sirenfiles">LEW21/sirenfiles</a> for more Sirenfiles.</p>
	</body>
</html>
"""

def application(environ, start_response):
	status = '200 OK'
	response_headers = [('Content-type', 'text/html')]
	start_response(status, response_headers)
	return [page.format(datetime.now()).encode("utf-8")]
