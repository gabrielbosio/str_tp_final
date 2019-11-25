require_relative 'instancia_tarea'

class Tarea
  attr_accessor :fue_planificada
  attr_reader :nombre
  attr_reader :tiempo_de_computo, :tiempo_hasta_deadline, :periodo, :tiempo_de_computo_restante,
              :tiempo_de_inicio

  def initialize(nombre, tiempo_de_computo, periodo, tiempo_de_inicio = 0)
    @nombre = nombre
    @tiempo_de_computo = tiempo_de_computo
    @periodo = periodo
    @tiempo_hasta_deadline = periodo
    @tiempo_de_computo_restante = tiempo_de_computo
    @instancia = 0
    @fue_planificada = false
    @tiempo_de_inicio = tiempo_de_inicio
  end

  def crear_instancia(tiempo_actual)
    tiempo_final = tiempo_actual + @tiempo_de_computo
    nueva_instancia = InstanciaTarea.new(@nombre, @instancia, tiempo_actual, tiempo_final)
    @instancia += 1

    nueva_instancia
  end

  def decrementar_tiempo_hasta_deadline(tiempo)
    @tiempo_hasta_deadline -= tiempo
    reiniciar if @tiempo_hasta_deadline.zero?
  end

  def decrementar_tiempo_de_computo_restante(tiempo)
    @tiempo_de_computo_restante -= tiempo
  end

  def periodo_actual(tiempo_actual)
    @tiempo_de_inicio + (tiempo_actual / @periodo).floor + 1
  end

  private

  def reiniciar
    @tiempo_hasta_deadline = @periodo
    @tiempo_de_computo_restante = @tiempo_de_computo
    @fue_planificada = false
  end
end
