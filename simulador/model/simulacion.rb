require 'singleton'

class Simulacion
  include Singleton

  attr_reader :log

  def initialize
    @log = ''
  end

  def registrar_ejecucion(nombre_tarea, tiempo_inicial, tiempo_final)
    @log += "#{tiempo_inicial} a #{tiempo_final} -> #{nombre_tarea}\n"
  end

  def limpiar_log
    @log = ''
  end

  def ejecutar(tareas, ruta_archivo)
    scheduler = Scheduler.new(tareas)
    procesador = Procesador.new

    plan = scheduler.planificar
    plan.instancias_planificadas.each { |instancia| procesador.asignar_instancia(instancia) }
    procesador.ejecutar

    registrar_tareas_no_ejecutadas(plan.instancias_sin_ejecutar)
    guardar_salida(ruta_archivo)
  end

  private

  def registrar_tareas_no_ejecutadas(instancias_sin_ejecutar)
    instancias_sin_ejecutar.each do |nombre_tarea, hash_periodos|
      next if hash_periodos.empty?

      @log += "La instancia de la tarea #{nombre_tarea} no se ejecutó en:\n"
      hash_periodos.each do |periodo, tiempo|
        @log += "\tsu período #{periodo}, detectado en el tiempo #{tiempo}\n"
      end
    end
  end

  def guardar_salida(ruta_archivo)
    File.open(ruta_archivo, 'w') do |f|
      f.puts @log
    end
  end
end
