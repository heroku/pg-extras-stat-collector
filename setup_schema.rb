#!/usr/bin/env ruby

require 'sequel'

DB = Sequel.connect(ENV['DATABASE_URL'])

DB.run("CREATE TABLE commands(
  command character varying(50),
  \"timestamp\" timestamp with time zone default now()
)")
