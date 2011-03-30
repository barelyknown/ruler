class Float
  attr_accessor :measurements

  def to_ruler(options={})
    # Converts a float into a string representing its approximate ruler equivalent if the float were inches
    
    inches_base = options[:base] || 32 # The :base options param enables you to change the base of the ruler from the deafult of 32
    self.measurements = {
      :feet => (self.floor/12).to_f.floor,
      :inches => (((self.floor.to_f/12.to_f) % 1)*12.to_f).round,
      :numerator => ((self % 1) * inches_base).round,
      :denominator => inches_base
    }
    
    # Reduce the numerator and denominator using their largest common denominator
    while self.measurements[:numerator] % 2 == 0 && self.measurements[:numerator] > 0
      self.measurements[:numerator] /= 2
      self.measurements[:denominator] /= 2
    end

    # Format the measurements into a nicely formatted string
    ruler = ""
    if self.measurements[:feet] > 0
      ruler << self.measurements[:feet].to_s + "\'"
    end
    if self.measurements[:inches] > 0
      ruler << " " if self.measurements[:feet] > 0 
      ruler << self.measurements[:inches].to_s
    end
    if self.measurements[:numerator] > 0
      ruler << " " unless self.measurements[:feet] == 0 and self.measurements[:inches] == 0
      ruler << self.measurements[:numerator].to_s + "/" + self.measurements[:denominator].to_s
    end
    ruler << "\"" unless self.measurements[:inches] == 0 and self.measurements[:numerator] == 0
    ruler
  end
end