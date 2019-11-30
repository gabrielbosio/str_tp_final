require_relative './plan_de_ejecucion'

class Scheduler
  attr_reader :tareas

  def initialize(tareas)
    @tareas = tareas
  end

  def planificar
    tareas_planificadas = []
    tareas_no_planificadas = {}
    hiperperiodo = calcular_hiperperiodo
    tiempo_actual = 0

    @tareas.each { |tarea| tareas_no_planificadas[tarea.nombre] = {} }

    @tarea_en_planificacion = nil

    while tiempo_actual < hiperperiodo

      @tarea_en_planificacion&.decrementar_tiempo_de_computo_restante(1)
      if @tarea_en_planificacion&.tiempo_de_computo_restante&.zero?
        @tarea_en_planificacion.reiniciar_tiempo_de_computo_restante
        @tarea_en_planificacion = nil
      end

      sondear_tareas(tiempo_actual, tareas_planificadas, tareas_no_planificadas)

      decrementar_tiempo_hasta_deadline_tareas(tiempo_actual)
      tiempo_actual += 1

    end
    PlanDeEjecucion.new(tareas_planificadas, tareas_no_planificadas)
  end

  def calcular_hiperperiodo
    periodos = []
    @tareas.each do |tarea|
      periodos << tarea.periodo
    end

    periodos.reduce(:lcm)
  end

  private

  def sondear_tareas(tiempo_actual, tareas_planificadas, tareas_no_planificadas)
    @tareas.each do |tarea|
      if tiempo_actual >= tarea.tiempo_de_inicio
        registrar_si_tarea_pudo_planificarse(tarea, tiempo_actual, tareas_planificadas)
        registrar_si_tarea_no_pudo_planificarse(tarea, tiempo_actual, tareas_no_planificadas)
      end
    end
  end

  def registrar_si_tarea_pudo_planificarse(tarea, tiempo_actual, tareas_planificadas)
    if tarea.tiempo_de_computo_restante <= tarea.tiempo_hasta_deadline &&
       !tarea.fue_planificada && @tarea_en_planificacion.nil?

      instancia_tarea = tarea.crear_instancia(tiempo_actual)
      tareas_planificadas << instancia_tarea
      tarea.fue_planificada = true
      @tarea_en_planificacion = tarea
    end
  end

  def registrar_si_tarea_no_pudo_planificarse(tarea, tiempo_actual, tareas_no_planificadas)
    if tarea.tiempo_de_computo_restante >= tarea.tiempo_hasta_deadline &&
       !tarea.fue_planificada &&
       !tareas_no_planificadas[tarea.nombre].key?(tarea.periodo_actual(tiempo_actual))
      tareas_no_planificadas[tarea.nombre][tarea.periodo_actual(tiempo_actual)] = tiempo_actual
    end
  end

  def decrementar_tiempo_hasta_deadline_tareas(tiempo_actual)
    @tareas.each do |tarea|
      tarea.decrementar_tiempo_hasta_deadline(1) if tiempo_actual >= tarea.tiempo_de_inicio
    end
  end
end
