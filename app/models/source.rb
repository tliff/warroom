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
  
  def reduced_data_pg(i,date)
    samples.select("AVG(value) AS value, TIMESTAMP 'epoch' + AVG((FLOOR(EXTRACT('epoch' FROM sampled_at)))) * INTERVAL '1 second' AS sampled_at").
    where(["sampled_at > ?", date]).
    group("(FLOOR(EXTRACT('epoch' FROM sampled_at)/#{i}))").
    order('sampled_at ASC').map{|s|
      [s.sampled_at.to_i*1000, s.value]
    }
  end

  def reduced_data_mysql(i,date)
    samples.select("AVG(value) AS value,  AVG((FLOOR(sampled_at))) AS sampled_at").
    where(["sampled_at > ?", date]).
    group("(FLOOR(sampled_at/#{i}))").
    order('sampled_at ASC').map{|s|
      [s.sampled_at.to_i*1000, s.value]
    }    
  end
  
  def reduced_data(i,date)
    if self.connection.adapter_name == 'PostgreSQL'
      reduced_data_pg(i,date)
    elsif self.connection.adapter_name == 'MySQL'
      reduced_data_mysql(i,date)
    else
      raise 'Unimplemented!'
    end
  end

end
