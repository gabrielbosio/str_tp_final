require 'rspec'
require_relative '../model/tarea'

describe Tarea do
  describe 'modelo' do
    tiempo_de_computo = 10
    tarea = described_class.new(tiempo_de_computo)

    it 'al inicializar una tarea, debe almacenar su tiempo de computo' do
      expect(tarea.tiempo_de_computo).to eq tiempo_de_computo
    end
  end
end
