require_relative "../app"
require 'cohort_repository'
RSpec.describe Application do
  def reset_cohorts_table
    seed_sql = File.read('spec/seeds_student_directory.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
    connection.exec(seed_sql)
  end

  describe  do
    before(:each) do 
      reset_cohorts_table
    end

    it 'prints out the data of one cohort with its students' do
      io = double(:io)
      expect(io).to receive(:puts).with("Welcome to the student directory")
      expect(io).to receive(:puts).with("Which cohort would you like to print?")
      expect(io).to receive(:gets).and_return("1")
      expect(io).to receive(:puts).with("April 2022 cohort, starting date 2022-04-15")
      expect(io).to receive(:puts).with("Students in this cohort:")
      expect(io).to receive(:puts).with("1. David")
      expect(io).to receive(:puts).with("2. Anna")
      app = Application.new('student_directory_2', io, CohortRepository.new)
      app.run
    end
  end
end