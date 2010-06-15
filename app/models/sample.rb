class Sample < ActiveRecord::Base
  default_scope :order => "sampled_at"
  
  def currency=(c)
    self.unit = c
  end

  def timestamp=(t)
    self.sampled_at = Time.at(t)
  end

  def self.create_from_webpush(d,secret)
    user = secret.user
    source = Source.find_or_create_by_identifier_and_user_id(d['identifier'], user.id)
    d['source_id'] = source.id
    create(d.delete_if{|k,v| ['type', 'identifier'].member?(k)})
  end

end
