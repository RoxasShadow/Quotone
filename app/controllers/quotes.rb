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
    
    renderize :new
  end
  
  post '/new' do
    @title = 'New quote'
    inputs = {
      :source  => params[:source],
      :tags    => params[:tags],
      :quote   => params[:quote],
      :spoiler => params[:spoiler]
    }
    
    inputs.delete_if { |key, val| val.nil? || val.empty? }
    
    quote = Quote.new(
      :ip       => @ip,
      :source   => inputs[:source],
      :tags     => inputs[:tags],
      :quote    => inputs[:quote],
      :language => @language,
      :spoiler  => inputs[:spoiler] == 'on'
    )
    
    @output = quote.save ? 'ok' : 'fail'
    @errors = quote.errors
    
    renderize :new
  end
  
  get '/vote/:id' do |id|
		redirect back if exclude_ua? settings.excluded_ua, @useragent
    redirect back unless quote = Quote.get(id.to_i)
    
    redirect back if Vote.count(:quote_id => quote.id, :ip => @ip) > 0
    
    quote.votes.create(:ip => @ip)
    redirect back
  end

  get '/edit/:id' do |id|    
    unless @quote = Quote.get(id.to_i)
      @error = 'Quote not found.'
      renderize :error
    end
    
    only_for_admin! unless owner_of? @quote
    
    @title = 'Edit quote'
    renderize :new
  end

  post '/edit/:id' do |id|
    unless quote = Quote.get(id.to_i)
      @error = 'Quote not found.'
      renderize :error
    end
    
    only_for_admin! unless owner_of? quote
    
    inputs = {
      :source   => params[:source],
      :tags     => params[:tags],
      :quote    => params[:quote],
      :spoiler  => params[:spoiler]
    }
    
    inputs.delete_if { |key, val| val.nil? || val.empty? }
    
    updated = quote.update(
      :source   => inputs[:source],
      :tags     => inputs[:tags],
      :quote    => inputs[:quote],
      :language => @language,
      :spoiler  => inputs[:spoiler] == 'on'
    )
    
    unless updated
      @error = 'Quote editing failed.'
      renderize :error
    else
      redirect "/get/#{id}"
    end
  end
  
  get '/delete/:id' do |id|    
    unless quote = Quote.get(id.to_i)
      @error = 'Quote not found.'
      renderize :error
    end
    
    only_for_admin! unless owner_of? quote
    
    unless quote.destroy
      @error = 'Quote deletion failed.'
      renderize :error
    else
      redirect back
    end
  end
  
end
