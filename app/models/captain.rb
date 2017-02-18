class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(:boats => :classifications).where("classifications.name = 'Catamaran'")
  end

  def self.sailors
    self.joins(:boats => :classifications).where("classifications.name = 'Sailboat'").uniq
  end

  def self.motorboaters
    self.joins(:boats => :classifications).where("classifications.name = 'Motorboat'").uniq
  end


  def self.talented_seamen
    sailors = self.sailors.pluck("captains.id")
    motorboaters = self.motorboaters.pluck("captains.id")
    self.where(id: (sailors & motorboaters))
  end

  def self.non_sailors
    sailors = self.sailors.pluck("captains.id")
    self.where.not(id: sailors)  
  end
end
