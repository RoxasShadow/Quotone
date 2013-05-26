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
		
		def csrf_token
			Rack::Csrf.csrf_token(env)
		end
		
		def csrf_tag
			Rack::Csrf.csrf_tag(env)
		end
		
		def admin?
		  get_cookie(settings.username) == settings.token
		end
		
		def only_for_admin!
		  halt [ 401, 'Not Authorized' ] unless admin?
		end
		
		def only_for_users!
		  halt [ 401, 'Not Authorized' ] if admin?
		end
		
		def owner_of? quote
		  @ip == quote.ip && quote.created_at.today?
		end
		
		def renderize(quote, format)
      case format
        when 'xml'  then quote.to_xml  :exclude => [:ip], :methods => [:n_votes]
        when 'csv'  then quote.to_csv  :exclude => [:ip], :methods => [:n_votes]
        when 'yaml' then quote.to_yaml :exclude => [:ip], :methods => [:n_votes]
        else             quote.to_json :exclude => [:ip], :methods => [:n_votes]
      end
    end
		
	end
	
end
