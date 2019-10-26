require 'rspec'
require_relative '../model/procesador'

describe Procesador do
  after(:each) { Simulacion.limpiar_ejecuciones }

  let(:procesador) { described_class.new }
  let(:tarea) { double }

  describe 'asignar_tarea' do
    it 'la tarea T1 debe encolarse como tarea a ejecutar' do
      allow(tarea).to receive(:nombre).and_return('T1')
      procesador.asignar_tarea(tarea)
      expect(procesador.tareas_a_ejecutar.length).to eq 1
      expect(procesador.tareas_a_ejecutar[0].nombre).to eq 'T1'
    end
  end
end
