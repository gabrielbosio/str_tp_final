require 'rspec'
require_relative '../model/simulacion'

describe Simulacion do
  after(:each) { described_class.instance.limpiar_log }

  describe 'registrar_ejecucion' do
    it 'debe registrar la ejecucion de la Tarea 1 en dos unidades de tiempo' do
      described_class.instance.registrar_ejecucion('Tarea 1', 0, 2)
      expect(described_class.instance.log).to include('0 a 2 -> Tarea 1')
    end
  end

  describe 'limpiar_log' do
    it 'debe vaciar la lista de ejecuciones' do
      described_class.instance.registrar_ejecucion('Tarea 1', 0, 1)
      described_class.instance.limpiar_log
      expect(described_class.instance.log).to eq ''
    end
  end
end
