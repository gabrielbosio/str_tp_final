class Scheduler
  attr_reader :tareas

  def initialize(tareas)
    @tareas = tareas
  end

  def planificar
    tareas_planificadas = []
    indice_tarea_actual = 0
    hiperperiodo = calcular_hiperperiodo
    tiempo_actual = 0
    cantidad_tareas_evaluadas = 0

    while tiempo_actual < hiperperiodo
      tarea_actual = tareas[indice_tarea_actual]

      if tarea_actual.lista_para_ejecutarse?(tiempo_actual) &&
         tarea_actual.tiene_tiempo_para_ejecutarse?(tiempo_actual)
        instancia_tarea = tarea_actual.crear_instancia(tiempo_actual)
        tareas_planificadas << instancia_tarea
        tiempo_actual += tarea_actual.tiempo_de_computo
        cantidad_tareas_evaluadas = 0

      else
        cantidad_tareas_evaluadas += 1
      end

      indice_tarea_actual = (indice_tarea_actual + 1) % @tareas.size

      if cantidad_tareas_evaluadas == @tareas.size
        tiempo_actual += 1
        cantidad_tareas_evaluadas = 0
      end
    end
    tareas_planificadas
  end

  def calcular_hiperperiodo
    periodos = []
    @tareas.each do |tarea|
      periodos << tarea.periodo
    end

    periodos.reduce(:lcm)
  end
end
