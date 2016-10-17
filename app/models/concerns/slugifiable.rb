module Slugifiable
  module InstanceMethods
    def slug
      name.gsub(" ", "-").downcase
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      name = slug.split("-").join(" ")
      self.where("lower(name) = ?", name).first
    end
  end
end