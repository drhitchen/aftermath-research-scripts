from http.server import SimpleHTTPRequestHandler, HTTPServer
import urllib.parse

class PhishingHandler(SimpleHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        data = urllib.parse.parse_qs(post_data.decode('utf-8'))

        # Log the collected data
        print("Collected Data:")
        for key, value in data.items():
            print(f"{key}: {value}")

        # Send response back to the browser
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()
        self.wfile.write(b"<html><body><h2>Thank you for your submission!</h2></body></html>")

def run(server_class=HTTPServer, handler_class=PhishingHandler, port=80):
    server_address = ('', port)
    httpd = server_class(server_address, handler_class)
    print(f'Starting mock phishing server on port {port}...')
    httpd.serve_forever()

if __name__ == "__main__":
    run()
