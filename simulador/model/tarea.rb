class Tarea
  attr_reader :nombre
  attr_reader :tiempo_de_computo

  def initialize(nombre, tiempo_de_computo)
    @nombre = nombre
    @tiempo_de_computo = tiempo_de_computo
  end
end
