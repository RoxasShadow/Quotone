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

require 'data_mapper'
require 'dm-mysql-adapter'
require 'dm-pager'
require 'dm-serializer'

require 'rack/csrf'
require 'digest/md5'

class Quotone < Sinatra::Base
  
  config = YAML::load File.read('config/config.yml')
  DataMapper.setup(:default, "mysql://#{config['database']['username']}:#{config['database']['password']}@#{config['database']['hostname']}/#{config['database']['database']}")
  
  configure {
    set :method_override, true
    
    set :username,    config['admin']['username']
    set :password,    config['admin']['password']
    set :token,       config['admin']['token']
    set :minify,      config['miscs']['minify']     == 'enable'
    set :thumbnails,  config['miscs']['thumbnails'] == 'enable'
    set :excluded_ua, config['miscs']['excluded_ua']
    
    use Rack::Session::Cookie,
      :path   => '/',
      :secret => config['miscs']['cookie']
  
    use Rack::Csrf,
      :raise => true,
      :field => config['miscs']['csrf']
  }
  
  Dir.glob("#{Dir.pwd}/app/helpers/*.rb") { |m| require m.chomp }
  Dir.glob("#{Dir.pwd}/app/models/*.rb") { |m| require m.chomp }; DataMapper.finalize
  Dir.glob("#{Dir.pwd}/app/controllers/*.rb") { |m| require m.chomp }

  DataMapper.auto_upgrade!
end
