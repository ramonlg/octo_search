# Octo Search
This application integrates with the GitHub API. Through it, the user can consult public GitHub repositories.


## Versions:
* **Ruby**: 2.7.1
* **Rails**: 6.0.3.2
* **PostgreSQL**: 11.4


## Project setup:

1. Install the dependencies above
2. Clone this project: `$ git clone git@github.com:ramonlg/octo_search.git`
3. Go into the project folder: `$ cd octo_search`
4. Setup database: `$ rails db:create && rails db:migrate && rails db:seed` or `rails db:setup`


## Running the Project:

* First create a new User on `rails console`:
```shell
$ rails console
```
```ruby
User.create(username: 'my_username' , password: 'my_password' , password_confirmation: 'my_password')
```

* You can add a new user on the `seeds.rb` file and run `$ rails db:seed` on `rails console`

* After creating the `new User` we can start the rails server and use the application.


### Sending requests:

#### Sessions:

##### Creating a new Session:

```
POST /api/v1/session
```

* To authenticate the user we need to inform the `username` and `password`

```shell
curl -H "Content-Type: application/json" -X POST -d '{"username":"my_username", "password":"my_password"}' http://localhost:3000/api/v1/session
```

* If the user is successfully authenticated we will have a return similar to this:

```json
{
  "auth_token": "2uw8uu8dus8dus8dufhh.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTc3MDM2NTZ9.aiIDNjArrozOvosoaojdjoaejjojdowodjdmznmnw12"
}
```

* If the user cannot be authenticated:

```json
{
  "error": {
    "user_authentication": "Invalid username or password"
  }
}
```

#### Repositories:

##### Searching for GitHub repositories:

```
GET /api/v1/github/repositories
```

* To perform a search, it is necessary to inform the token generated in the user authentication process.
* We can filter the repositories with the following attributes:
  * `q`: Some keyword that must be present on the repository
  * `username`: Name of the author / owner of the repository
  * `language`: Repository programming language. (If the language is not informed, `Ruby` will be used as the default)
  * `sort`: Attribute by which the result will be ordered. The value informed for this attribute could be:
    * `stars`: sort by number of stars;
    * `forks`: sort by number of forks;
    * `updated`: sort by update date;
    * If no value is given, `stars` will be used by default
  * `order`: By which order the resulto will be sorted could be: `asc` or `desc` (default: `desc`)
  * `page`: Which results list page will be returned
  * `per_page`: Number of items per page (default: `10`)


* Request example:

```shell
curl --location --request GET 'localhost:3000/api/v1/github/repositories' \
--header 'Authorization: 2uw8uu8dus8dus8dufhh.eyJ1c2VyX2lkIjoyLCJleHAiOjE1OTc3MDM2NTZ9.aiIDNjArrozOvosoaojdjoaejjojdowodjdmznmnw12' \
--data-raw '{ "q":"awesome", "username":"defunkt", "language":"rails", "sort":"forks", "order":"asc", "page":"1", "per_page":"20" }'
```

* Response example:

```json
{
  "repositories": [
    {
      "name": "lacampfire",
      "description": "Logical Awesome Campfire userscript.",
      "stars": 5,
      "forks": 5,
      "author": "defunkt"
    },
    {
      "name": "my-awesome-framework",
      "description": "A simple demonstration of how to effectively use Git submodules.",
      "stars": 6,
      "forks": 6,
      "author": "defunkt"
    },
    {
      "name": "textmate.el",
      "description": "Basic emulation of awesome TextMate features for Emacs.",
      "stars": 359,
      "forks": 68,
      "author": "defunkt"
    }
  ]
}
```


### Docs:

##### API/V1:
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/c473a7e30b5166df9a78)