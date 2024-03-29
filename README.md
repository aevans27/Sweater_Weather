# Sweater Weather - Project README
# By Allan Evans

## Setup
- Ruby 3.2.2
- Rails 7.0.7.2
- [Faraday](https://github.com/lostisland/faraday) A gem to interact with APIs
- [SimpleCov](https://github.com/simplecov-ruby/simplecov) A gem for code coverage tracking
- [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers) A gem for testing assertions

## Installation Instructions
 - Fork Repository
 - `git clone <repo_name>`
 - `cd <repo_name>`
 - `bundle install`   
 - `rails db:{drop,create,migrate}`
 - VCR cassettes may need to be refreshed to get proper test results

## Project Description
Capstone project for Mod 3 at Turing, combines weather and map api's and works as a backend.
Uses apis from:
  - [MapQuest Geocoding](https://developer.mapquest.com/documentation/geocoding-api/)
  - [Weather API](https://www.weatherapi.com/)
  - [Pexels](https://www.pexels.com/api/)