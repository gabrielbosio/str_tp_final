require 'rspec'
require_relative '../model/procesador'

describe Procesador do
  after(:each) { Simulacion.limpiar_ejecuciones }

  let(:procesador) { described_class.new }
  let(:tarea1) do
    t1 = double
    allow(t1).to receive(:nombre).and_return('T1')
    t1
  end
  let(:tarea2) do
    t2 = double
    allow(t2).to receive(:nombre).and_return('T2')
    t2
  end

  describe 'asignar_tarea' do
    it 'la tarea T1 debe encolarse como tarea a ejecutar' do
      allow(tarea1).to receive(:nombre).and_return('T1')
      procesador.asignar_tarea(tarea1)
      expect(procesador.tareas_a_ejecutar.length).to eq 1
      expect(procesador.tareas_a_ejecutar[0].nombre).to eq 'T1'
    end

    it 'las tareas T1 y T2 deben encolarse como tareas a ejecutar' do
      procesador.asignar_tarea(tarea1)
      procesador.asignar_tarea(tarea2)
      expect(procesador.tareas_a_ejecutar.length).to eq 2
      expect(procesador.tareas_a_ejecutar[0].nombre).to eq 'T1'
      expect(procesador.tareas_a_ejecutar[1].nombre).to eq 'T2'
    end
  end
end
