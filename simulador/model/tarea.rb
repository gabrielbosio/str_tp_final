require_relative 'instancia_tarea'

class Tarea
  attr_reader :nombre
  attr_reader :tiempo_de_computo, :periodo

  def initialize(nombre, tiempo_de_computo, periodo)
    @nombre = nombre
    @tiempo_de_computo = tiempo_de_computo
    @periodo = periodo
    @instancia = 0
    @instancias_por_periodo = {}
  end

  def tiene_tiempo_para_ejecutarse?(tiempo_actual)
    periodo_actual = (tiempo_actual / @periodo).floor + 1
    (tiempo_actual + @tiempo_de_computo) <= (@periodo * periodo_actual)
  end

  def lista_para_ejecutarse?(tiempo_actual)
    periodo_actual = (tiempo_actual / @periodo).floor + 1
    !@instancias_por_periodo.key?(periodo_actual)
  end

  def crear_instancia(tiempo_actual)
    nueva_instancia = InstanciaTarea.new(@nombre, @instancia, @tiempo_de_computo)
    periodo_actual = (tiempo_actual / @periodo).floor + 1
    @instancias_por_periodo[periodo_actual] = @instancia
    @instancia += 1

    nueva_instancia
  end
end
