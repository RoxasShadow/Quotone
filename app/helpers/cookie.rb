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

  helpers do
  
	  def set_cookie(key, value)
		  response.set_cookie(key, { :value => value, :path => '/', :expires => Time.now + 24 * 60 * 60 })
	  end
	
	  def delete_cookie(key)
	    response.set_cookie(key, { :value => '', :path => '/', :expires => Time.now })
	  end
	
	  def get_cookie(key)
		  request.cookies[key]
	  end
	
	  def cookie_exists?(key)
		  !(get_cookie(key).nil? || get_cookie(key).empty?)
	  end
		  
  end
  
end

