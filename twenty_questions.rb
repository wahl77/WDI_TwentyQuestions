require "pry"
require "pry-debugger"
require "pry-stack_explorer"

class Node
  attr_accessor :text, :is_answer, :prv, :nxt
 
  def initialize(data)
    self.text = data
    self.nxt = nil  # Right, No
    self.prv = nil  # Left, Yes
  end

  def is_answer
    return self.prv == nil && self.nxt == nil
  end
 
end

class Tree

  attr_accessor :root

  def initialize
  end

  #def insert(new_node, r=self.root)
  #  if self.root.nil?
  #    self.root = new_node
  #  else
  #    if r.data < new_node.data
  #      if r.nxt.nil?
  #        r.nxt = new_node
  #      else
  #        insert(new_node, r.nxt)
  #      end
  #    else
  #      if r.prv.nil?
  #        r.prv = new_node
  #      else
  #        insert(new_node, r.prv)
  #      end
  #    end
  #  end
  #end
end

node = Node.new("Is it a cat?")
node.prv = Node.new("Bear")
node.nxt = Node.new("Max")
@tree = Tree.new
@tree.insert(node)

def prompt_question
  puts "Please enter yes or no" 
  while true
    answer = gets.chomp
    return answer if (answer == "y" || answer == "n")
    puts "Sorry, no understood, please enter yes or no"
  end
  
end

def play_game(node)
  puts node.text
  answer = prompt_question

  return if node.is_answer && answer == "y"

  if node.is_answer && answer == "n"
    old_answer = node.dup
    puts "What was it?"
    solution = gets.chomp
    puts "What should I have asked to differenciate"
    query = gets.chomp
    puts "Should that have been the yes or no answer(y/n)"
    answer = gets.chomp
    node.text = query
    if (answer == "y")
      node.prv = Node.new(solution)
      node.nxt = old_answer
    else
      node.prv = old_answer
      node.nxt = Node.new(solution)
    end
    puts "OK, noted"
    return
  end
  
  if ( answer == "y")
    play_game(node.prv)
  else
    play_game(node.nxt) 
  end
end

def start
  puts "Do you want to play a game y to play, anything else to quit"
  answer = gets.chomp 
  while (answer == "y")
    play_game(@tree.root) 
    puts "Do you want to play a game y to play, anything else to quit"
    answer = gets.chomp
  end
end

start
