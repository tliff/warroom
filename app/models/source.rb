class Source < ActiveRecord::Base
  has_many :samples, :dependent => :destroy 
  belongs_to :user

  def self.tree
    tmptree = []
    sources = find(:all, :select => "identifier, id")
    sources.map{|s| s.identifier.to_s.split(':')}.sort{|a,b| a.length <=> b.length}.each do |source|
      i = tmptree
      while source.length > 0 do
        k = source.shift
        if ! i.select{|item| item[:data] == k}.empty?
          logger.info{'found'}
        else
          logger.info{'not found'}
          i << {:data => k, :children => []}
        end
        i = i.select{|item| item[:data] == k}.first[:children]
      end
    end
    tmptree
  end
end
