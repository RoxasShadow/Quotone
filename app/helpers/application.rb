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
		
		def owner_of?(quote)
		  @ip == quote.ip && quote.created_at.today?
		end
		
		def exclude_ua?(excluded_ua, useragent)
		  excluded_ua.each { |ua|
		    if ua.start_with?('*') && ua.end_with?('*')
		      return true if useragent.match /#{ua[1..-2]}/i
		    else
		      return true if useragent.match ua
		    end
		  }
		  false
	  end
		
		def add_visitor(quote)
		  return if exclude_ua? settings.excluded_ua, @useragent
		  
		  if quote.is_a?(DataMapper::Collection) || quote.is_a?(Array)
        quote.each { |q|
          q.visitors.create(:ip => @ip) unless Visitor.visited? q.id, @ip
        }
      elsif quote.is_a? Quote
        quote.visitors.create(:ip => @ip) unless Visitor.visited? quote.id, @ip
      end
    end
		
		def renderize(wat, format = nil)
		  if wat.is_a? Symbol
		    add_visitor(@quotes) if @quotes
		    @thumbnails = get_thumbnail("#{@quotes.first.source} #{@quotes.first.tags}") if settings.thumbnails && @quotes.one?
		    
		    if settings.minify
		      require 'html_press'
		      HtmlPress.press(erb wat)
		    else
		      erb wat
		    end
		  elsif wat.nil? || (wat.is_a?(Array) && wat.empty?)
		    '{}'
		  else
		    add_visitor wat
        case format
          when 'xml'  then wat.to_xml  :exclude => [:ip], :methods => [:n_votes, :n_visitors]
          when 'csv'  then wat.to_csv  :exclude => [:ip], :methods => [:n_votes, :n_visitors]
          when 'yaml' then wat.to_yaml :exclude => [:ip], :methods => [:n_votes, :n_visitors]
          else             wat.to_json :exclude => [:ip], :methods => [:n_votes, :n_visitors]
        end
      end
    end
    
    def get_thumbnail(keyword, position = 0)
      require 'cgi'
      require 'open-uri'
      require 'json'
      
      url = "http://ajax.googleapis.com/ajax/services/search/images?rsz=large&start=#{position}&v=1.0&q=#{CGI.escape(keyword)}"
      json_results = open(url) {|f| f.read };
      return JSON.parse(json_results)['responseData']['results'] # :thumbnail => image['tbUrl'], :original => image['unescapedUrl'], :name => keyword
    end
		
	end
	
end
