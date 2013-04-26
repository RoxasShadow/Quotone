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
# MyGameList is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Quotone.  If not, see <http://www.gnu.org/licenses/>.
#++

class Quote
  include DataMapper::Resource

  property	:id,          Serial
  property  :ip,          String, :required => true
  property	:source,      String, :required => true
  property	:tags,        String
  property  :language,    String, :required => true
  property	:quote,       Text,   :required => true
  property	:created_at,  DateTime
  property	:updated_at,  DateTime
  has n, :votes
  
  before :save, :purge
  
  attr_accessor :n_votes
  
  def purge
  	self.source = Rack::Utils.escape_html self.source
  	self.tags   = Rack::Utils.escape_html self.tags
  	self.quote  = Rack::Utils.escape_html self.quote
  end
  
  protected
  def method_missing(m, *args)
    false
  end
  
end
