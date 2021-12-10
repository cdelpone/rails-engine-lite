# [Rails Engine Lite](https://github.com/cdelpone/rails-engine-lite)
<hr>

## Table of Contents
- [Overview](#overview)
- [Setup](#setup)
- [Endpoints](#endpoints)
- [Technologies](#technologies)
- [Contributors](#contributors)

### <ins>Overview</ins>

An API for a fictitious business.

The project spec can be found [here](https://backend.turing.edu/module3/projects/rails_engine_lite/)

### <ins>Setup</ins>
Fork and clone the repo:

`git clone git@github.com:cdelpone/rails-engine-lite.git`

Install gem packages:

`bundle install`

Setup the database:

`rails db:{drop,create,migrate,seed}`

Run test suite:

 `bundle exec rspec`

### <ins>Endpoints</ins>

<b><u>Merchant Endpoints</u></b><br>
GET `/api/v1/merchants/:id`<br>
GET `/api/v1/merchants`<br>

<b><u>Item Endpoints</u></b><br>
GET `/api/v1/items`<br>
GET `/api/v1/items/:id`<br>
POST `/api/v1/items`<br>
PATCH `/api/v1/items/:id`<br>
DELETE `/api/v1/items/:id`<br>

<b><u>Relationship Endpoints</u></b><br>
GET `/api/v1/merchants/:id/items`<br>
GET `/api/v1/items/:id/merchant`<br>

<b>Serialized Output</b><br>
•	 GET `/api/v1/merchants/#{merchant.id}/items`<br>
<b>Serialized Output</b><br>
•	 GET `/api/v1/items/#{item.id}/merchant`<br>

<b><u>Search Endpoints</u></b><br>
GET `/api/vi/items/find_all`<br>
GET `/api/vi/merchants/find`<br>

<b>Serialized Output</b></b><br>
•	 GET `/api/v1/items/find_all?name=#{query_param}`<br>
<b>Serialized Output</b><br>
•	GET `/api/v1/merchants/find?name=#{query_param}`<br>


### <ins>Technologies</ins>

#### Versions
- Ruby 2.7.2
- Rails 5.2.6

#### Development
![Atom][Atom-img]
<!-- ![OAuth][Bcrypt-img] -->
![Git][Git-img]
![Github][Github-img]
![Markdown][Markdown-img]
![PostgreSQL][PostgreSQL-img]
![Postman][Postman-img]
![Ruby on Rails][Ruby on Rails-img]

#### Languages
![ActiveRecord][ActiveRecord-img]
![Ruby][Ruby-img]

#### Testing
![Pry][Pry-img]
![RSPEC][RSPEC-img]
![Shoulda Matchers][Shoulda Matchers-img]
![Simplecov][Simplecov-img]

#### Dependencies
gem 'jsonapi-serializer'

#### Development Principles
![OOP][OOP-img]
![TDD][TDD-img]
![MVC][MVC-img]
![REST][REST-img]

### <ins>Contributors</ins>
![LinkedIn][LinkedIn-img] [Christina Delpone](https://www.linkedin.com/in/christinadelpone)

![Github][Github-img] [Christina Delpone](https://github.com/cdelpone)

<!-- Markdown link & img dfn's -->
[Github-img]: https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white

<!-- #### Development -->
[Atom-img]: https://img.shields.io/badge/Atom-66595C.svg?&style=flaste&logo=atom&logoColor=white
[Git-img]: https://img.shields.io/badge/Git-F05032.svg?&style=flaste&logo=git&logoColor=white
[Github-img]: https://img.shields.io/badge/GitHub-181717.svg?&style=flaste&logo=github&logoColor=white
[Markdown-img]: https://img.shields.io/badge/Markdown-000000?style=for-the-badge&logo=markdown&logoColor=white
[PostgreSQL-img]: https://img.shields.io/badge/PostgreSQL-4169E1.svg?&style=flaste&logo=postgresql&logoColor=white
[Postman-img]: https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=Postman&logoColor=white
[Ruby on Rails-img]: https://img.shields.io/badge/Ruby%20On%20Rails-b81818.svg?&style=flat&logo=rubyonrails&logoColor=white

<!-- #### Languages -->
[ActiveRecord-img]: https://img.shields.io/badge/ActiveRecord-CC0000.svg?&style=flaste&logo=rubyonrails&logoColor=white
[Ruby-img]: https://img.shields.io/badge/Ruby-CC0000.svg?&style=flaste&logo=ruby&logoColor=white

<!-- #### Testing -->
[Pry-img]: https://img.shields.io/badge/pry-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[RSPEC-img]: https://img.shields.io/badge/rspec-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Shoulda Matchers-img]: https://img.shields.io/badge/shoulda--matchers-b81818.svg?&style=flaste&logo=rubygems&logoColor=white
[Simplecov-img]: https://img.shields.io/badge/simplecov-b81818.svg?&style=flaste&logo=rubygems&logoColor=white

<!-- #### Development Principles -->
[OOP-img]: https://img.shields.io/badge/OOP-b81818.svg?&style=flaste&logo=OOP&logoColor=white
[TDD-img]: https://img.shields.io/badge/TDD-b87818.svg?&style=flaste&logo=TDD&logoColor=white
[MVC-img]: https://img.shields.io/badge/MVC-b8b018.svg?&style=flaste&logo=MVC&logoColor=white
[REST-img]: https://img.shields.io/badge/REST-33b818.svg?&style=flaste&logo=REST&logoColor=white

<!-- ### <ins>Contributors</ins> -->
[LinkedIn-img]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
