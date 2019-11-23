require_relative 'model/instancia_tarea'
require_relative 'model/procesador'
require_relative 'model/scheduler'
require_relative 'model/simulacion'
require_relative 'model/tarea'

t1 = Tarea.new('t1', 3, 5)
t2 = Tarea.new('t2', 2, 8)
t3 = Tarea.new('t3', 1, 4)

# t1 = Tarea.new('t1', 1, 2)
# t2 = Tarea.new('t2', 2, 3)
# t3 = Tarea.new('t3', 2, 3)

ruta_log = './log.txt'
simulacion = Simulacion.new
simulacion.ejecutar([t1, t2, t3], ruta_log)
puts Simulacion.log
