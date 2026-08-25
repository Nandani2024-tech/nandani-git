from http.server import HTTPServer, BaseHTTPRequestHandler

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello world from Python!")


server = HTTPServer(("0.0.0.0", 8000), Handler)


print("Python server running on port 8081")
server.serve_forever()









