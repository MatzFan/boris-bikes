class Bike

  def initialize
    fix
  end

  def broken?
    @broken
  end

  def break
    @broken = true
    return self
  end

  def fix
    @broken = false
    return self
  end

end # of class
