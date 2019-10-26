require 'rspec'
require_relative '../model/simulacion'

describe Simulacion do
  describe 'registrar_ejecucion' do
    it 'debe registrar la ejecucion de la Tarea 1 en dos unidades de tiempo' do
      described_class.registrar_ejecucion('Tarea 1', 2)
      expect(described_class.ejecuciones[0]).to eq 'Tarea 1'
      expect(described_class.ejecuciones[1]).to eq 'Tarea 1'
    end
  end
end
