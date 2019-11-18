class InstanciaTarea
  attr_reader :nombre, :instancia, :tiempo_de_computo

  def initialize(nombre, instancia, tiempo_de_computo)
    @nombre = nombre
    @instancia = instancia
    @tiempo_de_computo = tiempo_de_computo
  end

  def ejecutar
    Simulacion.registrar_ejecucion(@nombre, @tiempo_de_computo)
  end
end
