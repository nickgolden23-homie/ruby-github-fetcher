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
    puts "=== GitHub User: #{user['login']} ==="
    puts "Name:       #{user['name']}"
    puts "Bio:        #{user['bio']}"
    puts "Location:   #{user['location']}"
    puts "Public Repos: #{user['public_repos']}"
    puts "Followers:  #{user['followers']}"
    puts "Profile:    #{user['html_url']}"
  else
    puts "Error: #{response.code} - #{response.message}"
  end
end

def fetch_repos(username)
  url = "https://api.github.com/users/#{username}/repos?sort=updated&per_page=5"
  response = HTTParty.get(url, headers: { "User-Agent" => "Ruby Script" })

  if response.success?
    repos = response.parsed_response
    puts "\n=== Top 5 Recently Updated Repos ==="
    repos.each do |repo|
      puts "- #{repo['name']} (#{repo['language'] || 'N/A'}) ⭐ #{repo['stargazers_count']}"
      puts "  #{repo['description']}"
    end
  else
    puts "Error: #{response.code} - #{response.message}"
  end
end

# Main
username = ARGV[0] || "octocat"
puts "Fetching GitHub data for '#{username}'...\n\n"
fetch_user(username)
fetch_repos(username)
