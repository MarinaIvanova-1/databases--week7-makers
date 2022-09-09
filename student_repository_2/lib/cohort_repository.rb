require_relative './cohort'
require_relative './student'
require_relative './database_connection'

class CohortRepository
  def find_with_students(id)
    sql = 'SELECT cohorts.id, cohorts.starting_date, cohorts.name AS "cohort_name", students.name AS "students_name"
              FROM cohorts
              JOIN students
              ON cohorts.id = students.cohort_id
              WHERE cohorts.id = $1;'

    result_set = DatabaseConnection.exec_params(sql, [id])
    cohort = Cohort.new
    cohort.name = result_set.first['cohort_name']
    cohort.id = result_set.first['id']
    cohort.starting_date = result_set.first['starting_date']
    result_set.each do |record|
      student = Student.new
      student.name = record['students_name']
      cohort.students << student
    end
    return cohort
  end
end