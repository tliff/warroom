class Source < ActiveRecord::Base
  def self.tree
    tmptree = {}
    find(:all, :select => "identifier").each{|source|
      i =  source.identifier.to_s.split(':')
      p = tmptree
      while key = i.shift do
        p = (p[key.to_sym] ||= {})
      end
      p[:source] = source
    }
    tmptree
  end
end
