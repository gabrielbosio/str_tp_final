require_relative 'model/instancia_tarea'
require_relative 'model/procesador'
require_relative 'model/scheduler'
require_relative 'model/simulacion'
require_relative 'model/tarea'

t1 = Tarea.new('t1', 3, 5)
t2 = Tarea.new('t2', 2, 8)
t3 = Tarea.new('t3', 1, 4)

scheduler = Scheduler.new([t1, t2, t3])

scheduler.planificar.each { |instancia| puts instancia.nombre }
puts 'Termine'
