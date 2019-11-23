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
      @tarea_en_planificacion = nil if @tarea_en_planificacion&.tiempo_de_computo_restante&.zero?

      @tareas.each do |tarea|
        registrar_si_tarea_pudo_planificarse(tarea, tiempo_actual, tareas_planificadas)

        next unless tarea.tiempo_de_computo_restante >= tarea.tiempo_hasta_deadline &&
                    !tarea.fue_planificada &&
                    !tareas_no_planificadas[tarea.nombre].key?(tarea.periodo_actual(tiempo_actual))

        tareas_no_planificadas[tarea.nombre][tarea.periodo_actual(tiempo_actual)] = tiempo_actual
      end
      tiempo_actual += 1
      @tareas.each { |tarea| tarea.decrementar_tiempo_hasta_deadline(1) }
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

  def registrar_si_tarea_pudo_planificarse(tarea, tiempo_actual, tareas_planificadas)
    if tarea.tiempo_de_computo_restante <= tarea.tiempo_hasta_deadline &&
       !tarea.fue_planificada && @tarea_en_planificacion.nil?

      instancia_tarea = tarea.crear_instancia(tiempo_actual)
      tareas_planificadas << instancia_tarea
      tarea.fue_planificada = true
      @tarea_en_planificacion = tarea
    end
  end
end
