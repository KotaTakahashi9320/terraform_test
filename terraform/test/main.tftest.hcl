run "deploy" {}

run "request" {
  module {
    source = "./test/request"
  }

  variables {
    server_url = run.deploy.server_url
  }

  assert {
    condition     = chomp(data.http.request.response_body) == "Hello, World!"
    error_message = "Response body is not \"Hello, World!\""
  }
}
