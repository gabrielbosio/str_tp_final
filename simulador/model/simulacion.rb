class Simulacion
  @@ejecuciones = []

  def self.ejecuciones
    @@ejecuciones
  end

  def self.registrar_ejecucion(nombre_tarea, unidades_de_tiempo)
    unidades_de_tiempo.times { @@ejecuciones << nombre_tarea }
  end

  def self.limpiar_ejecuciones
    @@ejecuciones = []
  end
end
