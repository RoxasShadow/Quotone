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
	
  get '/api/get/:id.?:format?' do |id, format|
    quote = Quote.get(id.to_i)
    '{}' unless quote
    
    quote = [ quote ].add_votes.first
    case format
      when 'xml'  then quote.to_xml  :exclude => [:ip], :methods => [:n_votes]
      when 'csv'  then quote.to_csv  :exclude => [:ip], :methods => [:n_votes]
      when 'yaml' then quote.to_yaml :exclude => [:ip], :methods => [:n_votes]
      else             quote.to_json :exclude => [:ip], :methods => [:n_votes]
    end
  end

end
