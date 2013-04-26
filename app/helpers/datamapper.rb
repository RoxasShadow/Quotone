module DataMapper

  class Collection
    def add_votes
      self.each { |quote|
        quote.n_votes = Vote.count(:quote_id => quote.id)
      }.sort { |a, b| [a.n_votes, a.id] <=> [-b.n_votes, -b.id] }
    end
  end
  
  module Resource
    def add_votes
      self.each { |quote|
        quote.n_votes = Vote.count(:quote_id => quote.id)
      }.sort { |a, b| [a.n_votes, a.id] <=> [-b.n_votes, -b.id] }
    end
  end
  
end

class Array
  def add_votes
    self.each { |quote|
      quote.n_votes = Vote.count(:quote_id => quote.id)
    }.sort { |a, b| [a.n_votes, a.id] <=> [-b.n_votes, -b.id] }
  end
end
