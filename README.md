# README

List of APIs

- Users
  - Sign Up
  - Confirm User Registration
  - Sign In
  - Update Existing User

- Activities
  - Get activities
  - withdraw amount
  - deposit amount

- Customers
  - Create
  - Get customers
  - Update customers

## How to test APIs?
- load `Ally.postman_collection.json` to Postman

- Create Postman Environment settings as follow:
  - BASE_URL: http://localhost:3000/api/v1
  - AUTH_TOKEN: Bearer anything

- Signup Account (check log to collect confirmation token)
- Confirm user registration (use confirmationtoken to confirm)

- Now you can use rest apis, please check headers
  - `Authorization: {{AUTH_TOKEN}}`
  - `Content-Type: application/json`