require 'rspec'
require_relative '../model/instancia_tarea'

describe InstanciaTarea do
  after(:each) { Simulacion.instance.limpiar_log }

  let(:tiempo_inicial) { 0 }
  let(:tiempo_final) { 10 }
  let(:nombre) { 'tarea1_instancia1' }
  let(:instancia) { 1 }
  let(:instancia_t1) { described_class.new(nombre, instancia, tiempo_inicial, tiempo_final) }

  describe 'ejecutar' do
    it 'debe llamar a registrar_ejecucion de Simulacion' do
      expect(Simulacion.instance).to receive(:registrar_ejecucion)
      instancia_t1.ejecutar
    end
  end
end
