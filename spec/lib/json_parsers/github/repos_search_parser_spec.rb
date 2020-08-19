require 'rails_helper'

RSpec.describe JsonParsers::Github::ReposSearchParser do
  describe '#parse' do
    it 'parses the received json' do
      repositories = described_class.parse(response_body)

      expect(repositories).to eq({
        repositories: [
          {
            name: "bundler",
            description: "Manage your Ruby application's gem dependencies",
            stars: 4810,
            forks: 2131,
            author: "rubygems"
          }
        ]
      })
    end
  end

  def response_body
    {
      "items":[
        {
          "id":488514,
          "name":"bundler",
          "full_name":"rubygems/bundler",
          "private":false,
          "owner":{
            "login":"rubygems",
            "id":208761,
            "node_id":"MDEyOk9yZ2FuaXphdGlvbjIwODc2MQ==",
            "avatar_url":"https://avatars0.githubusercontent.com/u/208761?v=4",
          },
          "html_url":"https://github.com/rubygems/bundler",
          "description":"Manage your Ruby application's gem dependencies",
          "fork":false,
          "stargazers_count":4810,
          "watchers_count":4810,
          "language":"Ruby",
          "open_issues_count":22,
          "license":{
            "key":"mit",
            "name":"MIT License",
            "spdx_id":"MIT",
            "url":"https://api.github.com/licenses/mit",
            "node_id":"MDc6TGljZW5zZTEz"
          },
          "forks":2131,
          "open_issues":22,
          "watchers":4810,
          "default_branch":"master",
          "score":1.0
        }
      ]
    }.to_json
  end
end
