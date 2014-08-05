#!/usr/bin/env ruby

module MindReader
  class Question
    def initialize(question, answer, animal)
      @name   = question
      @answer = answer
      @animal = animal
      @yes    = nil
      @no     = nil

      if @answer == 'y'
        @yes = Guess.new(@animal)
      elsif @answer == 'n'
        @no = Guess.new(@animal)
      end
    end

    def guess
      puts "#{@name} (y or n)"
      question_answer = gets.chomp

      if question_answer == 'y'
        if @yes.nil?
          @yes = MindReader.read_new_animal(@animal)
        elsif !@yes.nil?
          @yes = @yes.guess
        end
      elsif question_answer == 'n'
        if @no.nil?
          @no = MindReader.read_new_animal(@animal)
        elsif !@no.nil?
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

    Question.new(user_question, user_answer, user_animal)
  end

end

object = MindReader::Guess.new("elephant")
loop do
  puts "Think of an animal..."
  object = object.guess
  puts object.inspect

  puts "Play again? (y or n)"
  break if gets.chomp == 'n'
end

