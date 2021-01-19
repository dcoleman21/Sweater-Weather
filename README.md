![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a) ![](https://img.shields.io/badge/Ruby-2.5.3-orange)

# Sweater Weather

## About This Project:

Sweater Weather is the back-end portion of a hypothetical applicition to plan road trips. This project is part of a service-oriented architecture design pattern where the front-end would communicate with this back-end portion through an API. The main responsibility of this project is to expose the API in a way that fulfills the front-ends needs/requirements. Ultimately, this app will allow users to see the current weather as well as the forecasted weather at the destination of their choosen road trip.  

## Table of Contents
- [Learning Goals](#learning-goals)
- [Local Setup](#local-setup)
- [APIs](#apis)
- [Testing](#testing)
- [Endpoints](#endpoints)
  - [Testing Tools](#testing-tools)
  - [GET Forecast](#get-forecast---weather-for-location)
  - [GET Background](#get-backgrounds---image-for-location)
  - [POST Users](#post-users---create-new-user)
  - [POST Sessions](#post-sessions---user-authentication)
  - [POST Road Trip](#post-road_trip---road-trip-information)
- [Authors](https://github.com/dcoleman21/Sweater-Weather/blob/main/README.md#authors)

## Learning Goals:

  * Expose an API that aggregates data from multiple external APIs
  * Expose an API that requires an authentication token
  * Expose an API for CRUD functionality
  * Determine completion criteria based on the needs of other developers
  * Research, select, and consume an API based on your needs as a developer
  
## Local Setup:

This project requires:
- Ruby 2.5.3.
- Rails 5.2.4.3

If you want to make your own changes and push them up, fork this repo and clone your fork into the directory of your choosing. 
You will then `cd` into your project. Open up your project in `Atom` or your prefered console. 
You will then want to delete the `Gemfile.lock` in your main directory. From the terminal, run `bundle install` to install all the needed gems. 

You will also need to setup the database. To do so, from your terminal, run these commands:
```
rails db:create
```
```
rails db:migrate
```
```
rails db:seed
```

* Ensure the following gems are within the `:developement, :test do` block:
   * `gem 'rspec-rails'`
   * `gem 'capybara'`
   * `gem 'pry'`
   * `gem 'shoulda-matchers'`
   * `gem 'simplecov'`
   
* Example:
```
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'capybara'
  gem 'pry'
  gem 'shoulda-matchers'
  gem 'simplecov'
end
```
* Ensure that the following gems exist outside of any blocks: (I like to put them just above the `group :developement, :test do` block:
 * `gem 'faraday'`
 * `gem 'figaro'`
 * `gem 'fast_jsonapi'`
 
* Example:
```
...
gem 'figaro'
gem 'faraday'
gem 'fast_jsonapi'

group :development, :test do
...
```

* Install Figaro with `bundle exec figaro install` to create an application.yml file locally (this will need to be updated with any needed ENV variables!!!)(example: SOMETHING_API_KEY: 89798273429sadlfj332)

#### Sweater Weather utilizes the following gems and libraries in testing:

- [RSpec](https://github.com/rspec/rspec-rails)
- [ShouldaMatchers](https://github.com/thoughtbot/shoulda-matchers)
- [Capybara](https://github.com/teamcapybara/capybara)
- [SimpleCov](https://github.com/simplecov-ruby/simplecov)

## APIs

You will need to read through the documentation and get `api_keys` from the following resources:

  * [MapQuest's Geocoding API](https://developer.mapquest.com/documentation/geocoding-api/)
  * [OpenWeather One Call API](https://openweathermap.org/api/one-call-api)
  * For Enpoints #2, you will need to chose an API that gives you access to photos 

Once you have successfully received your `api_keys`, you will want to store them as `Environment Variables` in your `/config/.application.yml` file. To generate that file:

  * Install Figaro with `bundle exec figaro install` to create an application.yml file locally (this will need to be updated with any needed ENV variables!!!)
  
  ```
  example: SOMETHING_API_KEY: PLACE YOUR KEY HERE
  ```
  
  * You can read more [here](https://github.com/laserlemon/figaro)

## Testing

To run a specific suite of tests, include the file path. See the following:
```
bundle exec rspec spec/requests/api/v1/something_request_spec.rb
```
To run a specific test, include the file path and test line number. See the following:
```
bundle exec rspec ./spec/poros/munchie_spec.rb:4
```
To run the entrire suite of tests(located in the /spec directory), run the following:
```
bundle exec rspec
```



## Enpoints

### Testing Tools

1. One of the best tools for testing out whether or not your calls are responding the way that you expect is [Postman](https://www.postman.com/). 
2. You will also at times need to run `rails s` in your command line so that you can test that call in Postman.
  * Example: in Postman run `GET` `http://localhost:3000/api/v1/forecast?location=arvada,co` to see the serialized response for that endpoint.
 
<img width="855" alt=" Landing Page" src="https://user-images.githubusercontent.com/60626984/105092563-a107ca00-5a5e-11eb-895e-1d02915cc60f.png"> 

###  ```GET /forecast``` - weather for location
  
* Request Example:
```ruby
  GET /api/v1/forecast?location=denver,co
  Content-Type: application/json
 Accept: application/json
```
  
* Response Example: (this should be in a serialized JSON format)
```json
  {
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-01-19T12:52:11.000-07:00",
                "sunrise": "2021-01-19T07:17:40.000-07:00",
                "sunset": "2021-01-19T17:04:17.000-07:00",
                "temperature": 35.49,
                "feels_like": 22.62,
                "humidity": 35,
                "uvi": 1.82,
                "visibility": 10000,
                "conditions": "few clouds",
                "icon": "02d"
            },
            "daily_weather": [
                {
                    "date": "2021-01-19",
                    "sunrise": "2021-01-19T07:17:40.000-07:00",
                    "sunset": "2021-01-19T17:04:17.000-07:00",
                    "max_temp": 35.49,
                    "min_temp": 27.61,
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {...}
            ],
            "hourly_weather": [
                {
                    "time": "12:00:00",
                    "temperature": 35.49,
                    "wind_speed": "5.19 mph",
                    "wind_direction": "from SE",
                    "conditions": "few clouds",
                    "icon": "02d"
                },
                {...}
            ]
        }
    }
}
```

### ```GET /backgrounds``` - image for location
  
* Request Example: 
```ruby
  GET /api/v1/backgrounds?location=denver,co
  Content-Type: application/json
  Accept: application/json
```
  
* Response Example: (this should be in a serialized JSON format)
  
* This should return the url of an appropriate background image for a loation.
```json
     {
      "data": {
          "id": null,
          "type": "image",
          "attributes": {
              "image": {
                  "location": "arvada,co",
                  "image_url": "https://images.unsplash.com/photo-1601065867490-72e75c02cc11?   crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MXwxOTkzNDJ8MHwxfHNlYXJjaHwxfHxhcnZhZGEsY298ZW58MHx8fA&ixlib=rb-1.2.1&q=80&w=1080",
                  "credit": {
                      "source": "https://api.unsplash.com/photos/3Lc_fcUm3eA",
                      "author": "camiah"
                  }
              }
          }
      }
  }
```

### ```POST /users``` - create new user

Returns JSON information of newly created user. Must pass parameters in body in json format. See example below. Returns appropriate 400-status code if user is not created in system.

Request Example:
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

Response Example:
```json
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

Use Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list and paste the hash with email, password and password_confirmation inside before hitting send.

### ```POST /sessions``` - user authentication

Returns JSON information of existing user if user exists and their password is correct. Must pass parameters in body in json format. See example below. Returns appropriate 400-status code if user's credentials are incorrect.

Request Example:
```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "whatever@example.com",
  "password": "password"
}
```

Response Example:
```json
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```

Use Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list and paste the hash with email, password and password_confirmation inside before hitting send.

### ```POST /road_trip``` - road trip information

Returns JSON information of road trip. Weather data returned is the predicted temperature and conditions when arriving at destination. Must pass parameters in body in json format. See example below. Returns 401 code if api_key is incorrect.

Request Example:
```
POST /api/v1/road_trip
Content-Type: application/json
Accept: application/json

body:

{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

Response Example:
```json
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Pueblo, CO",
      "travel_time": "1 hours, 44 minutes"
      "weather_at_eta": {
        "temperature": 34.4,
        "conditions": "sunny"
      }
    }
  }
}
```

Use Postman, under the address bar, click on “Body”, select “raw”, which will show a dropdown that probably says “Text” in it, choose “JSON” from the list and paste the hash with origin, destination, api_key inside before hitting send.

## Authors
- **Dani Coleman** - *Turing Student* - [GitHub Profile](https://github.com/dcoleman21) - [Turing Alum Profile](https://alumni.turing.io/alumni/dani-coleman) - [LinkedIn](https://www.linkedin.com/in/dcoleman-21/)
