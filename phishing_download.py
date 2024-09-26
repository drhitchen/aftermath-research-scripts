from http.server import SimpleHTTPRequestHandler, HTTPServer
import urllib.parse

class PhishingHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/download/eicar_com.zip":
            # Serve the EICAR test file as a download
            self.send_response(200)
            self.send_header('Content-type', 'application/zip')
            self.send_header('Content-Disposition', 'attachment; filename="eicar_com.zip"')
            self.end_headers()
            with open('eicar_com.zip', 'rb') as file:
                self.wfile.write(file.read())
        else:
            super().do_GET()

def run(server_class=HTTPServer, handler_class=PhishingHandler, port=80):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting mock phishing server on port {port}...')
    httpd.serve_forever()

if __name__ == "__main__":
    run()