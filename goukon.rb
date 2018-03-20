# Gale-Shapleyアルゴリズム
class Compa
  attr_accessor :women, :mens
  
  def initialize(w, m)
    @women = w
    @mens = m
  end

  def print_result
    women.each do |woman|
      puts "#{woman.name} - #{woman.keep_man.name}"
    end
  end

  def loop_algorism
    while(!check_match(mens))
      try_proposal(women, mens)
    end
  end

  private

  def check_match(mens)
    mens.each do |man|
      return false unless man.keeped
    end
    true
  end

  def try_proposal(women, mens)
    mens.each do |man|
      man.propose(women) unless man.keeped
    end
  end
end

class Woman
  attr_accessor :keep_man, :ranking, :name

  def initialize(name, ranking)
    @name = name
    @ranking = ranking
    @keep_man = nil
  end

  def judge(man)
    if keep_man == nil || upper_man?(man)
      keep_man&.free
      self.keep_man = man
      return true
    else
      return false
    end
  end

  private

  def upper_man?(man)
    keep_man_index = ranking.index(keep_man.name)
    new_man_index = ranking.index(man.name)
    new_man_index < keep_man_index
  end

end

class Man
  attr_accessor :ranking, :keeped, :name, :bad_list

  def initialize(name, ranking)
    @name = name
    @ranking = ranking
    @keeped = false
    @bad_list = []
  end

  def free
    self.keeped = false
  end

  def propose(women)
    ranking.each do |woman|
      next if bad_list.include?(woman)
      target = women.select{|w| w.name == woman }[0]
      result = target.judge(self)
      if result
        self.keeped = true
      else
        bad_list << woman
      end
      break
    end
  end
end

# create woman
women = []
women << Woman.new("a", ["x", "y", "z"])
women << Woman.new("b", ["y", "z", "x"])
women << Woman.new("c", ["x", "z", "y"])


# create man
mens = []
mens << Man.new("x", ["a", "b", "c"])
mens << Man.new("y", ["c", "b", "a"])
mens << Man.new("z", ["a", "b", "c"])

compa = Compa.new(women, mens)
compa.loop_algorism
compa.print_result