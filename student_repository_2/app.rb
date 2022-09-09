require_relative './lib/cohort_repository'
require_relative './lib/database_connection'
require_relative './lib/cohort.rb'
require_relative './lib/student.rb'

class Application
  def initialize(database_name, io, cohort_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @cohort_repository = cohort_repository
  end

  def run
    print_header
    print_cohort_with_students(@io.gets.chomp)    
  end

  def print_header
    @io.puts "Welcome to the student directory"
    @io.puts "Which cohort would you like to print?"
  end

  def print_cohort_with_students(id)    
    cohort =  @cohort_repository.find_with_students(id)
    @io.puts "#{cohort.name} cohort, starting date #{cohort.starting_date}"
    @io.puts "Students in this cohort:"
    num = 1
    cohort.students.each do |student|
      @io.puts "#{num}. #{student.name}"
      num +=1
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'student_directory_2',
    Kernel,
    CohortRepository.new
  )
  app.run
end