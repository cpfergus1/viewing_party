# <div align="center"> Viewing Party



<div align="center"><img src = "https://raw.githubusercontent.com/zisiszikos/the-movie-db-example/master/tmdb.png"/></div>

## Development Team
[Curtis Bartell](https://github.com/c-bartell) <br>
[Connor Ferguson](https://github.com/cpfergus1) <br>
[Brian Liu](https://github.com/the-color-bliu) <br>

## Viewing Party Functionality
Viewing Party is a Ruby on Rails application that allows users to explore movie options and create multiple viewing parties with their friends. Users can search for movies or discover new ones and upon creating a viewing party, the user's friends will receive an email with viewing party details. The application consumes [The Movie Database (TMDB) API](https://developers.themoviedb.org/3/getting-started/introduction) endpoints.

## Deployment Link

[Viewing Party Heroku Deployment](https://agile-retreat-25350.herokuapp.com/)

## Requirements
 ### Testing Dependencies
  * This app utilizes `gem mailcatcher` to test functionality of mailing system
  * This app utilizes `gem rack_session_access ` to emulate user sessions
  * This app utilizes `gem webmock` and `gem vcr` to handle and reduce API calls - VCR casettes should be deleted prior to running rspec for the first       time.
  * capybara, rspec-rails, launchy, simplecov, should-matchers, factory_bot_rails
  
 ### Development Dependencies
  * rubocop-rails


## How to Install Viewing Party

1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Setup the database: `rails db:{drop,create,merge}`
4. Delete root/spec/fixtures/vcr_cassettes
5. obtain and API key from https://www.themoviedb.org/
6. In CLI run `figaro install`
7. navigate to config/application.yml and open in your preferred editor.
8. create a variable at the end of the document called TMDB_API_KEY: <Your API Key Here>
9. Run Test suite with `bundle exec rspec`. There should be 61 passing tests
10. Run your development server with `rails s`. Visit [localhost:3000/merchants](http://localhost:3000/merchants) to see the app in action.

<h3>Dev Environment</h3>

The development environment is run with `rails s` and can be viewed at **localhost:3000**


## Features

- Search for registered friends by email and add them to their friends list.
- Discover the 40 top-rated movies from TMDB.
- Search for movies by keyword.
- Explore recommended and similar movie options.
- Create viewing parties and send party details to invited friends.


## Statistics

   ![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Code-Ruby-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)   ![](https://img.shields.io/badge/Code-HTML-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Code-CSS-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)

## Schema Design

![image](https://user-images.githubusercontent.com/67594471/101731065-4d29be80-3a78-11eb-8e1e-ce28283ce6e6.png)
