# LTCData

* This is a project I've been working on for my current job. I've been developing the Rails backend for my company, so I've just thrown a frontend onto a chunk of what I've done for work.
* LTCData stands for Long Term Care Data.

## How to Run This Project

* Clone this repository
* In the root directory, run the following commands:
  *  `bundle install`
  *  `rails db:migrate`
  *  `rails db:seed`
  *  `rails s`
* In the `/ltcdata-frontend/` folder, run the following commands:
  * `npm install`
  * `npm start`

## Functionality
As this is intended to be an internal tool, there is no manual sign-up functionality. However, when you are logged in, you are able to create new users.

Users can also be assigned to facilities, as well as given a position, title, and credentials.

Selecting users in the User List will allow you to edit said user.

The home page allows you to view and edit info about the facilities. You are only able to view facilities that you have been assigned to.
