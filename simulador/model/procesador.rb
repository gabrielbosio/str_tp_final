class Procesador
  attr_reader :instancias_a_ejecutar

  def initialize
    @instancias_a_ejecutar = []
  end

  def asignar_instancia(instancia)
    @instancias_a_ejecutar << instancia
  end

  def ejecutar
    @instancias_a_ejecutar.each(&:ejecutar)
    @instancias_a_ejecutar = []
  end
end
