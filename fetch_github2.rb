require 'httparty'
require 'json'

def fetch_user(username)
  url = "https://api.github.com/users/#{username}"
  response = HTTParty.get(url, headers: { 
    "User-Agent" => "Ruby Script",
    "Accept" => "application/vnd.github.v3+json",
    "X-GitHub-Api-Version" => "2022-11-28"
  })

  if response.success?
    user = response.parsed_response
    puts "=== User Information ==="
    puts "- Login: #{user['login']}"
    puts "- Name: #{user['name']}"
    puts "- Bio: #{user['bio']}"
  else
    puts "Error: #{response.code} - #{response.message}"
  end
end