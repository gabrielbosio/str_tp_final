class PlanDeEjecucion
  attr_reader :instancias_planificadas, :instancias_sin_ejecutar

  def initialize(instancias_planificadas, instancias_sin_ejecutar)
    @instancias_planificadas = instancias_planificadas
    @instancias_sin_ejecutar = instancias_sin_ejecutar
  end
end
