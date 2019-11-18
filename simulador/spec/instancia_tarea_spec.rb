require 'rspec'
require_relative '../model/instancia_tarea'

describe InstanciaTarea do
  after(:each) { Simulacion.limpiar_ejecuciones }

  let(:tiempo_de_computo) { 10 }
  let(:nombre) { 'tarea1_instancia1' }
  let(:instancia) { 1 }
  let(:instancia_t1) { described_class.new(nombre, instancia, tiempo_de_computo) }

  describe 'ejecutar' do
    it 'debe llamar a registrar_ejecucion de Simulacion' do
      expect(Simulacion).to receive(:registrar_ejecucion)
      instancia_t1.ejecutar
    end
  end
end
