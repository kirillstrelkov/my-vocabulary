[![Build Status](https://travis-ci.org/kirillstrelkov/my-vocabulary.svg?branch=master)](https://travis-ci.org/kirillstrelkov/my-vocabulary)

# Introduction

Rails application which gives ability to learn new word by playing quiz game and add your own words.

Uses Yandex Dictionary API - https://tech.yandex.com/dictionary/

## Technology Stack & Tools Used

### Core Framework & Infrastructure

- **Ruby on Rails**: The main web application framework.
- **PostgreSQL**: Primary relational database for storing users, words, and quiz data.
- **Redis**: In-memory data structure store, typically used for caching or background job processing.
- **Heroku**: Cloud platform used for application deployment and hosting.

### Frontend

- **HAML**: HTML abstraction markup language used for concise and readable view templates.
- **HTML / CSS / SASS**: Markup and styling, utilizing SASS for maintainable stylesheets.
- **Bootstrap**: Frontend framework utilized for responsive design and pre-built UI components.
- **jQuery / CoffeeScript**: Used for frontend interactivity, DOM manipulation, and dynamic client-side behavior.

### Testing Stack

- **RSpec**: Primary testing framework used for unit testing.
- **Cucumber**: Tool for running automated tests written in plain language (Behavior-Driven Development).
- **Capybara**: Integration testing tool that simulates how users interact with the web application.

### Key Gems

- **Devise**: Flexible authentication solution for handling user sign up, login, and sessions.
- **Rails Admin**: Provides a ready-to-use admin interface for managing data and application models.
- **Omniauth**: Library for integrating third-party authentication (e.g., social media login).
- **Will-paginate**: Pagination library for efficiently splitting large lists of items (like vocabularies) across multiple pages.
- **Factory girl**: Used within the testing suite to set up test data and fixtures easily.
- **better_errors**: Replaces the standard Rails error page with a more useful and detailed error page for developers.

Live site examples:

- https://simple-vocabulary.herokuapp.com/
