require 'rspec'
require_relative '../model/simulacion'

describe Simulacion do
  after(:each) { described_class.limpiar_ejecuciones }

  describe 'registrar_ejecucion' do
    it 'debe registrar la ejecucion de la Tarea 1 en dos unidades de tiempo' do
      described_class.registrar_ejecucion('Tarea 1', 2)
      expect(described_class.ejecuciones[0]).to eq 'Tarea 1'
      expect(described_class.ejecuciones[1]).to eq 'Tarea 1'
    end
  end

  describe 'limpiar_ejecuciones' do
    it 'debe vaciar la lista de ejecuciones' do
      described_class.registrar_ejecucion('Tarea 1', 1)
      described_class.limpiar_ejecuciones
      expect(described_class.ejecuciones).to eq []
    end
  end
end
