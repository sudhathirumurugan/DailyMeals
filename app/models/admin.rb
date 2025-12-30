class Admin < User
  def self.ransackable_attributes(auth_object = nil)
    super + ["email"]
  end
  
end
