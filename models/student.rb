require_relative('../db/sql_runner')
require("pry")

class Student
  attr_reader :id
  attr_accessor :first_name, :last_name, :age, :house_id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @age = options["age"].to_i
    @house_id = options["house_id"].to_i
  end


  def save()
    sql = "INSERT INTO students
    (first_name, last_name, age, house_id)
    VALUES
    ($1, $2, $3, $4)
    RETURNING id"
    values = [@first_name, @last_name, @age, @house_id]
    student = SqlRunner.run(sql, values)
    @id = student.first()['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM students;"
    SqlRunner.run(sql)
  end

  def self.map_items(student_array)
    result = student_array.map{ |student_hash| self.new(student_hash)}
    return result
  end

  def self.find(id)
    sql = "SELECT * FROM students WHERE id = $1"
    values = [id]
    student = SqlRunner.run(sql, values)
    result = Student.new(student.first)
    return result
    # return self.map_items(student_array)
  end

  def self.all()
    sql = "SELECT * FROM students"
    students_array = SqlRunner.run( sql )
    result = students_array.map { |student_hash| Student.new( student_hash ) }
    return result
  end

  def house_name
    sql = "SELECT houses.name FROM students INNER JOIN houses ON houses.id = students.house_id WHERE students.id = $1"
    values = [@id]
    house_array = SqlRunner.run(sql, values)
    return house_array[0]["name"]

  end

end
