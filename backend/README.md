# README

## development flow
```bash
rails new backend -d mysql
cd backend
rails g model journal uid:primary_key:uniq content:text
rails g controller journals
rails g migration journals uid:primary_key:uniq content:text
rails db:create
rake db:migrate
```