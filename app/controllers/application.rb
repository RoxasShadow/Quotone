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
	
  get '/' do
    @page     = 1
    quotes    = Quote.all
    @quotes   = quotes.page(@page, :per_page => 5)
    @previous = @page > 1
    @next     = @page <= ((quotes.length - 1) / 5)
    
    renderize :index
  end
	
  get '/page/:page' do |page|
    @page     = page.to_i
    quotes    = Quote.all
    @quotes   = quotes.page(@page, :per_page => 5)
    @previous = @page > 1
    @next     = @page <= ((quotes.length - 1) / 5)
    @title    = "Page #{@page}"
    
    renderize :index
  end
	
  get '/favorites' do
    # Why cannot use pagination and implement the API: #page requires DataMapper:Collection, but #sort_by returns Array
    @quotes   = Quote.all.sort_by { |a| [-a.n_votes, -a.id] }[0..20]
    @title    = 'Favorites'
    
    renderize :index
  end
	
  get '/source/:source/?:page?' do |source, page|
    @page     = (page || 1).to_i
    quotes    = Quote.all(:source.like => "%#{source}%")
    @quotes   = quotes.page(@page, :per_page => 5)
    @previous = @page > 1
    @next     = @page <= (quotes.length / 5)
    @title    = "Source: #{source} (#{@page || 1})"
    
    renderize :index
  end
	
  get '/tag/:tag/?:page?' do |tag, page|
    @page     = (page || 1).to_i
    quotes    = Quote.all(:tags.like => "%#{tag}%")
    @quotes   = quotes.page(@page, :per_page => 5)
    @previous = @page > 1
    @next     = @page <= (quotes.length / 5)
    @title    = "Tag: #{tag} (#{@page || 1})"
    
    renderize :index
  end
	
  post '/search/?:page?' do |page|
    @page     = (page || 1).to_i
    quotes    = Quote.all(:quote.like => "%#{params['query']}%")
    @quotes   = quotes.page(@page, :per_page => 5)
    @previous = @page > 1
    @next     = @page <= (quotes.length / 5)
    @title    = "Search: #{params['query']} (#{@page || 1})"
    
    renderize :index
  end
	
  get '/get/:id' do |id|
    @quotes = Quote.all(:id => id.to_i)
    
    renderize :index
  end
   
  not_found do
    @error = 'Content not found.'
    renderize :error
  end

  error do
    @error = env['sinatra.error']
    renderize :error
  end

end
