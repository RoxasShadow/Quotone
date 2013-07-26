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

class Quotone

  get '/admin/login' do
    only_for_users!
    
    @title = 'Login'
    renderize :login
  end
  
  post '/admin/login' do
    only_for_users!
    
    if params['username'] == settings.username && params['password'] == settings.password
      set_cookie settings.username, settings.token
      redirect ?/
    end
    
    @error = 'Invalid login.'
    renderize :error
  end
  
  get '/admin/logout' do
    only_for_admin!
    
    delete_cookie settings.username
    redirect ?/
  end
  
end
