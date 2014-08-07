#!/usr/bin/env ruby

module MindReader
  class Question
    def initialize(question, yes_answer=nil, no_answer=nil, animal)
      @name   = question
      @animal = animal
      @yes    = yes_answer
      @no     = no_answer
    end

    def guess
      puts "#{@name} (y or n)"
      question_answer = gets.chomp

      if question_answer == 'y'
        if @yes.nil?
          @yes = MindReader.read_new_animal(@animal)
        else
          @yes = @yes.guess
        end
      elsif question_answer == 'n'
        if @no.nil?
          @no = MindReader.read_new_animal(@animal)
        else
          @no = @no.guess
        end
      end

      self
    end
  end

  class Guess
    def initialize(animal)
      @animal = animal
    end

    def guess
      puts "Is it an #{@animal}? (y or n)"
      answer = gets.chomp

      if answer == 'y'
        puts "I win. Pretty smart, aren' t I?"
        # We need to return something so we can start the game again
        self
      elsif answer == 'n'
        MindReader.read_new_animal(@animal)
      end
    end
  end

  def self.read_new_animal(animal)
    puts 'You win. Help me learn from my mistake before you go...'
    puts 'What animal were you thinking of?'
    user_animal = gets.chomp
    puts "Give me a question to distinguish a #{user_animal} from a #{animal}."
    user_question = gets.chomp
    puts "For a #{user_animal}, what is the answer to your question? (y or n)"
    user_answer = gets.chomp
    puts 'Thanks.'

    if user_answer == 'y'
      Question.new(user_question, Guess.new(user_animal), Guess.new(animal), user_animal)
    elsif user_answer == 'n'
      Question.new(user_question, Guess.new(animal), Guess.new(user_animal), user_animal)
    end
  end

end

require 'json'
object = MindReader::Guess.new("elephant")
loop do
  puts "Think of an animal..."
  object = object.guess

  puts "Play again? (y or n)"
  break if gets.chomp == 'n'
end

