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

  before do
    @language     = (request.env['HTTP_ACCEPT_LANGUAGE'] || 'en')[0..1]
    @current_page = request.env['REQUEST_URI']
    @current_url  = "http://#{request.env['HTTP_HOST']}#{request.env['REQUEST_URI']}"
    @domain       = "http://#{request.env['HTTP_HOST']}"
    @admin_email  = 'webmaster@giovannicapuano.net'
    @ip           = request.ip
  end
	
  get '/:page?' do |page|
    @page     = (page || 1).to_i
    @quotes   = Quote.all.page(@page, :per_page => 5)
    @previous = @page > 1
    @next     = @page <= (Quote.all.length / 5)
    
    HtmlPress.press(erb :'index')
  end
	
  get '/source/:source/?:page?' do |source, page|
    @page     = (page || 1).to_i
    @quotes   = Quote.all(:source => source).page(@page, :per_page => 5)
    @previous = @page > 1
    @next     = @page <= (Quote.all(:source => source).length / 5)
    @title    = source
    
    HtmlPress.press(erb :'index')
  end
	
  get '/tag/:tag/?:page?' do |tag, page|
    @page     = (page || 1).to_i
    @quotes   = Quote.all(:tags.like => "%#{tag}%").page(@page, :per_page => 5)
    @previous = @page > 1
    @next     = @page <= (Quote.all(:tags.like => "%#{tag}%").length / 5)
    @title    = 'Tag: ' + tag
    
    HtmlPress.press(erb :'index')
  end
	
  get '/get/:id' do |id|
    @quotes = Quote.all(:id => id.to_i)
    @title  = 'Quote #' + id
    
    HtmlPress.press(erb :'index')
  end
   
  not_found do
    @error = 'Content not found.'
    HtmlPress.press(erb :'error')
  end

  error do
    @error = env['sinatra.error']
    HtmlPress.press(erb :'error')
  end

end
