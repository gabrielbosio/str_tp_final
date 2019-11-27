class InstanciaTarea
  attr_reader :nombre, :instancia, :tiempo_inicial, :tiempo_final

  def initialize(nombre, instancia, tiempo_inicial, tiempo_final)
    @nombre = nombre
    @instancia = instancia
    @tiempo_inicial = tiempo_inicial
    @tiempo_final = tiempo_final
  end

  def ejecutar
    Simulacion.instance.registrar_ejecucion(@nombre, @tiempo_inicial, @tiempo_final)
  end
end
