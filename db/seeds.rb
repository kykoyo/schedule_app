# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#coding: utf-8

User.create(:username =>'いとう', :email=>'ito@gmail.com', :user_type=>'社員', :password => 'itoitoito')
User.create(:username =>'さとう', :email=>'sato@gmail.com', :user_type=>'社員', :password => 'satosato')
User.create(:username =>'かとう', :email=>'kato@gmail.com', :user_type=>'インターン', :password => 'katokato')
