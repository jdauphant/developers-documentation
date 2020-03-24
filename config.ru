require 'rack/jekyll'
require 'rack/rewrite'

use Rack::Rewrite do
  rewrite %r{/(.+)}, lambda { |match, rack_env|
    if File.exists?('_site/' + match[1] + '.html')
      return '/' + match[1] + '.html'
    else
      return '/' + match[1]
    end
  }
end

if ENV['BASIC_AUTH_ENABLED']
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    [username, password] == ENV['BASIC_AUTH'].split(":")
  end
end

run Rack::Jekyll.new
