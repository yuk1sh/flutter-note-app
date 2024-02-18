# README

## development flow
```bash
rails new backend -d mysql
cd backend
rails g model journal uid:primary_key:uniq content:text created_at:timestamp
rails g controller journals
rails db:create
rake db:migrate
```