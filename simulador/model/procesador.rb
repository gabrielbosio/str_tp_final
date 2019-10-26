class Procesador
  attr_reader :tareas_a_ejecutar

  def initialize
    @tareas_a_ejecutar = []
  end

  def asignar_tarea(tarea)
    @tareas_a_ejecutar << tarea
  end
end
