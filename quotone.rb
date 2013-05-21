#--
# Copyright(C) 2013 Giovanni Capuano <webmaster@giovannicapuano.net>
#
# This file is part of Quotone.
#
# Quotone is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Quotone is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Quotone.  If not, see <http://www.gnu.org/licenses/>.
#++

require 'sinatra/base'
require 'rack/csrf'
require 'data_mapper'
require 'dm-mysql-adapter'
require 'dm-pager'
require 'digest/md5'

class Quotone < Sinatra::Base
  
  db = YAML::load File.read('config/db.yml')
  DataMapper.setup(:default, "mysql://#{db['username']}:#{db['password']}@#{db['hostname']}/#{db['database']}")
  
  configure {
    set :method_override, true
    
    set :username, 'ambrogio'
    set :token,    'rfvklklfklmvlfked'
    set :password, 'hurrdurr'
    
    use Rack::Session::Cookie,
      :path   => '/',
      :secret => 'dafuq are u doing? pls stahp'
  
    use Rack::Csrf,
      :raise => true,
      :field => '_csrf'
  }
  
  Dir.glob("#{Dir.pwd}/app/helpers/*.rb") { |m| require m.chomp }
  Dir.glob("#{Dir.pwd}/app/models/*.rb") { |m| require m.chomp }; DataMapper.finalize
  Dir.glob("#{Dir.pwd}/app/controllers/*.rb") { |m| require m.chomp }

  DataMapper.auto_upgrade!
end
