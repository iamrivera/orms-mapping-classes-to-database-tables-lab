require 'pry'

class Student
  attr_accessor :name, :grade
  attr_reader :id 
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn].execute(drop variable here)/apply to every SQL related methd 

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table 
    sql = 'CREATE TABLE students ( id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);'

    DB[:conn].execute(sql)
  end 

  def self.drop_table
    sql = 'DROP TABLE students;'

    DB[:conn].execute(sql)
  end

  def save
    sql = 'INSERT INTO students (name, grade) VALUES (?,?);'

    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0] #mess around with compact
  end

  def self.create(attributes)
    var = self.new(attributes[:name], attributes[:grade])
    # binding.pry 
    var.save 
    var
  end
  
end

