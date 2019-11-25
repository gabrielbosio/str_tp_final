require_relative 'instancia_tarea'

class Tarea
  attr_accessor :fue_planificada
  attr_reader :nombre
  attr_reader :tiempo_de_computo, :tiempo_hasta_deadline, :periodo, :tiempo_de_computo_restante

  def initialize(nombre, tiempo_de_computo, periodo)
    @nombre = nombre
    @tiempo_de_computo = tiempo_de_computo
    @periodo = periodo
    @tiempo_hasta_deadline = periodo
    @tiempo_de_computo_restante = tiempo_de_computo
    @instancia = 0
    @instancias_por_periodo = {}
    @fue_planificada = false
  end

  def tiene_tiempo_para_ejecutarse?(tiempo_actual)
    (tiempo_actual + @tiempo_de_computo) <= (@periodo * periodo_actual(tiempo_actual))
  end

  def lista_para_ejecutarse?(tiempo_actual)
    !@instancias_por_periodo.key?(periodo_actual(tiempo_actual))
  end

  def crear_instancia(tiempo_actual)
    tiempo_final = tiempo_actual + @tiempo_de_computo
    nueva_instancia = InstanciaTarea.new(@nombre, @instancia, tiempo_actual, tiempo_final)
    @instancias_por_periodo[periodo_actual(tiempo_actual)] = @instancia
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
    (tiempo_actual / @periodo).floor + 1
  end

  private

  def reiniciar
    @tiempo_hasta_deadline = @periodo
    @tiempo_de_computo_restante = @tiempo_de_computo
    @fue_planificada = false
  end
end
