require_relative('../db/sql_runner')



class House
  attr_reader :id
  attr_accessor :name
    def initialize(options)
      @id = options["id"].to_i if options["id"]
      @name = options["name"]
    end

    def save()
      sql = "INSERT INTO houses
      (name)
      VALUES
      ($1)
      RETURNING id"
      values = [@name]
      house = SqlRunner.run(sql, values)
      @id = house.first()['id'].to_i
    end

    def self.delete_all()
      sql = "DELETE FROM houses;"
      SqlRunner.run(sql)
    end

    def find_all_students
      sql = "SELECT students.* FROM houses INNER JOIN students ON houses.id = students.house_id WHERE houses.id = $1"
      values = [@id]
      student_hash = SqlRunner.run(sql, values)
      return Student.map_items(student_hash)
    end

    def self.map_items(house_array)
      result = house_array.map{ |house_hash| self.new(house_hash)}
      return result
    end

    def self.all()
      sql = "SELECT * FROM houses"
      houses_array = SqlRunner.run( sql )
      result = houses_array.map { |house_hash| House.new( house_hash ) }
      return result
    end

    def self.find(id)
      sql = "SELECT * FROM houses WHERE id = $1"
      values = [id]
      houses = SqlRunner.run(sql, values)
      result = House.new(houses.first)
      return result
      # return self.map_items(student_array)
    end


end
