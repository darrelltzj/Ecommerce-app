# About

This web application is developed for a software developer test.

Heroku Link: https://dioworksecommerceapp.herokuapp.com/

Contact me for the seller code.

## Installing

To run locally:

You will also need a PostgreSQL database, an Amazon Web Services S3 account and a Stripe account.

Fork / clone this repository and bundle install the dependencies when inside the directory.

```
bundle install
```

Note the .env.sample file for the environment variables. Fill in the variables in the .env file and save it in the main directory of this repository.

Migrate the database

```
rails db:migrate
```

Set a seller code (example: 'sellercode')

```
rails c
Code.create(code:BCrypt::Password.create("sellercode"))
```

To run application on localhost:3000

```
foreman run rails s
```
