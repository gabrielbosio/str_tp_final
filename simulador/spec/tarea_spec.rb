require 'rspec'
require_relative '../model/tarea'

describe Tarea do
  describe 'modelo' do
    let(:tiempo_de_computo) { 10 }
    let(:nombre) { 'Tarea1' }
    let(:tarea) { described_class.new(nombre, tiempo_de_computo) }

    it 'al inicializar una tarea, debe almacenar su tiempo de computo' do
      expect(tarea.tiempo_de_computo).to eq tiempo_de_computo
    end

    it 'al inicializar una tarea, debe almacenar su nombre' do
      expect(tarea.nombre).to eq nombre
    end
  end
end
