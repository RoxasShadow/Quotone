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

  get '/new' do
    @title = 'New quote'
    
    HtmlPress.press(erb :new)
  end
  
  post '/new' do
    @title = 'New quote'
    
    inputs = {
      :source   => params[:source],
      :tags     => params[:tags],
      :quote    => params[:quote],
    }
    
    inputs.delete_if { |key, val| val.nil? || val.empty? }
    
    quote = Quote.new(
      :ip       => @ip,
      :source   => inputs[:source],
      :tags     => inputs[:tags],
      :quote    => inputs[:quote],
      :language => @language
    )
    
    @output = quote.save ? 'ok' : 'fail'
    @errors = quote.errors
    
    HtmlPress.press(erb :new)
  end
	
  get '/vote/:id' do |id|
    quote = Quote.get(id.to_i)
    quote.votes << Vote.new(:ip => @ip)
    
    @output = quote.save ? 'ok' : 'fail'
    @errors = quote.errors
    
    redirect back
  end
  
end
