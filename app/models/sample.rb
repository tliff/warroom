class Sample < ActiveRecord::Base
  def currency=(c)
    self.unit = c
  end

  def timestamp=(t)
    self.sampled_at = t
  end

  def self.create_from_webpush(d)
    source = Source.find_or_create_by_identifier(d['identifier'])
    d['source_id'] = source.id
    if d['type']
      d['sample_type'] = d['type']
    end
    create(d.delete_if{|k,v| ['type', 'identifier'].member?(k)})
  end

end
