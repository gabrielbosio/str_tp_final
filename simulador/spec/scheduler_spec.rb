require 'rspec'
require_relative '../model/scheduler'
require_relative '../model/plan_de_ejecucion'
require_relative '../model/tarea'
require_relative '../model/instancia_tarea'

describe Scheduler do
  after(:each) { Simulacion.instance.limpiar_log }

  let(:tarea_1) { Tarea.new('t1', 3, 5, 2) }
  let(:tarea_1_comenzando_en_cero) { Tarea.new('t1', 3, 5) }
  let(:tarea_2) { Tarea.new('t2', 2, 8) }
  let(:tarea_3) { Tarea.new('t3', 1, 4) }

  describe 'planificar' do
    it 'debe planificar una sola instancia de la tarea1 si ingresa una sola tarea' do
      scheduler = described_class.new([tarea_1])
      plan = scheduler.planificar
      expect(plan.instancias_planificadas.size).to eq 1
      expect(plan.instancias_planificadas[0].nombre).to eq 't1'
    end

    it 'la ultima instancia planificada de una tarea debe finalizar
     en un tiempo igual al hiperperiodo' do
      scheduler = described_class.new([tarea_1, tarea_2])
      plan = scheduler.planificar
      expect(plan.instancias_planificadas[-1].tiempo_final).to eq 40
    end

    it 'planificacion con dos tareas t1(3,5) y t2(2,8) primeras 7 instacias' do
      scheduler = described_class.new([tarea_1_comenzando_en_cero, tarea_2])
      instancias_planificadas = scheduler.planificar.instancias_planificadas
      instancias_planificadas_esperadas = %w[t1 t2 t1 t2 t1 t1 t2]
      (0..6).each do |i|
        expect(instancias_planificadas[i].nombre).to eq(instancias_planificadas_esperadas[i])
      end
    end

    it 'planificacion con dos tareas t1(3,5,2) y t2(2,8) primeras 7 instancias' do
      scheduler = described_class.new([tarea_1, tarea_2])
      instancias_planificadas = scheduler.planificar.instancias_planificadas
      instancias_planificadas_esperadas = %w[t2 t1 t1 t2 t1 t2 t1]
      (0..6).each do |i|
        expect(instancias_planificadas[i].nombre).to eq(instancias_planificadas_esperadas[i])
      end
    end

    it 'planificacion con tareas t1(3,5,2), t2(2,8) y t3(1,4) primeras 7 instancias' do
      scheduler = described_class.new([tarea_1, tarea_2, tarea_3])
      instancias_planificadas = scheduler.planificar.instancias_planificadas
      instancias_planificadas_esperadas = %w[t2 t1 t3 t1 t2 t1 t3]
      (0..6).each do |i|
        expect(instancias_planificadas[i].nombre).to eq(instancias_planificadas_esperadas[i])
      end
    end
  end
end
