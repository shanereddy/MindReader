#!/usr/bin/env ruby

module MindReader
  class Answer
    def initialize(input)
      @answer = input
    end

    def yes?
      @answer == 'y'
    end

    def no?
      @answer == 'n'
    end
  end

  class Question
    def initialize(question, yes_answer, no_answer, animal)
      @name   = question
      @animal = animal
      @yes    = yes_answer
      @no     = no_answer
    end

    def guess
      puts "#{@name} (y or n)"
      question = Answer.new(gets.chomp)

      if question.yes?
        @yes = @yes.guess
      else
        @no = @no.guess
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
      answer = Answer.new(gets.chomp)

      if answer.yes?
        puts "I win. Pretty smart, aren' t I?"
        # We need to return something so we can start the game again
        self
      else
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
    user_answer = Answer.new(gets.chomp)
    puts 'Thanks.'

    if user_answer.yes?
      Question.new(user_question, Guess.new(user_animal), Guess.new(animal), user_animal)
    else
      Question.new(user_question, Guess.new(animal), Guess.new(user_animal), user_animal)
    end
  end

end

object = MindReader::Guess.new("elephant")
loop do
  puts "Think of an animal..."
  object = object.guess

  puts "Play again? (y or n)"
  break if MindReader::Answer.new(gets.chomp).no?
end

