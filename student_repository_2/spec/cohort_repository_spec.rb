require 'cohort_repository'
require 'cohort'
require 'student'


def reset_cohorts_table
  seed_sql = File.read('spec/seeds_student_directory.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_2_test' })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do 
    reset_cohorts_table
  end

  it 'finds a cohort with all its students if given the id' do

    repo = CohortRepository.new
    cohort = repo.find_with_students('1')

    expect(cohort.name).to eq 'April 2022'
    expect(cohort.starting_date).to eq '2022-04-15'
    expect(cohort.students.length).to eq 2
  end
end

