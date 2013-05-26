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
	
  get '/api/page/:page.?:format?' do |page, format|
    quote = Quote.all.page(page, :per_page => 5)
    quote ? renderize(quote, format) : '{}'
  end
	
  get '/api/favorites/:page.?:format?' do |page, format|
    quote = Quote.all.page(page, :per_page => 5).sort_by { |a| [-a.n_votes, -a.id] }
    quote ? renderize(quote, format) : '{}'
  end
	
  get '/api/source/:source/:page.?:format?' do |source, page, format|
    quote = Quote.all(:source.like => "%#{source}%").page(page, :per_page => 5)
    quote ? renderize(quote, format) : '{}'
  end
	
  get '/api/tag/:tag/:page.?:format?' do |tag, page, format|
    quote = Quote.all(:tags.like => "%#{tag}%").page(page, :per_page => 5)
    quote ? renderize(quote, format) : '{}'
  end
	
  get '/api/get/latest.?:format?' do |format|
    quote = Quote.all.last
    quote ? renderize(quote, format) : '{}'
  end
	
  get '/api/get/:id.?:format?' do |id, format|
    quote = Quote.get(id.to_i)
    quote ? renderize(quote, format) : '{}'
  end

end
