require 'rspec'
require_relative '../model/tarea'

describe Tarea do
  after(:each) { Simulacion.limpiar_ejecuciones }

  let(:tiempo_de_computo) { 10 }
  let(:nombre) { 'Tarea1' }
  let(:tarea) { described_class.new(nombre, tiempo_de_computo) }

  describe 'modelo' do
    it 'al inicializar una tarea, debe almacenar su tiempo de computo' do
      expect(tarea.tiempo_de_computo).to eq tiempo_de_computo
    end

    it 'al inicializar una tarea, debe almacenar su nombre' do
      expect(tarea.nombre).to eq nombre
    end
  end

  describe 'ejecutar' do
    it 'debe llamar a registrar_ejecucion de Simulacion' do
      expect(Simulacion).to receive(:registrar_ejecucion)
      tarea.ejecutar
    end
  end
end
