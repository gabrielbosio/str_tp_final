require 'rspec'
require_relative '../model/procesador'

describe Procesador do
  after(:each) { Simulacion.limpiar_log }

  let(:procesador) { described_class.new }
  let(:instancia_1) do
    i1 = double
    allow(i1).to receive(:nombre).and_return('instancia1')
    allow(i1).to receive(:ejecutar)
    i1
  end
  let(:instancia_2) do
    i2 = double
    allow(i2).to receive(:nombre).and_return('instancia2')
    allow(i2).to receive(:ejecutar)
    i2
  end

  describe 'asignar_instancia' do
    it 'la instancia i1 debe encolarse como instancia a ejecutar' do
      procesador.asignar_instancia(instancia_1)
      expect(procesador.instancias_a_ejecutar.length).to eq 1
      expect(procesador.instancias_a_ejecutar[0].nombre).to eq 'instancia1'
    end

    it 'las instancias i1 y i2 deben encolarse como instancias a ejecutar' do
      procesador.asignar_instancia(instancia_1)
      procesador.asignar_instancia(instancia_2)
      expect(procesador.instancias_a_ejecutar.length).to eq 2
      expect(procesador.instancias_a_ejecutar[0].nombre).to eq 'instancia1'
      expect(procesador.instancias_a_ejecutar[1].nombre).to eq 'instancia2'
    end
  end

  describe 'ejecutar' do
    it 'al estar pendientes las instancias i1 y i2, deben ejecutarse' do
      procesador.asignar_instancia(instancia_1)
      procesador.asignar_instancia(instancia_2)
      expect(instancia_1).to receive(:ejecutar)
      expect(instancia_2).to receive(:ejecutar)
      procesador.ejecutar
    end

    it 'al ejecutarse las instancias i1 y i2, deben limpiarse' do
      procesador.asignar_instancia(instancia_1)
      procesador.asignar_instancia(instancia_2)
      procesador.ejecutar
      expect(procesador.instancias_a_ejecutar).to eq []
    end
  end
end
