class Plan < ActiveRecord::Base
    validates :role, presence: true
    validates_inclusion_of :funding, :in => [true, false]
    validates_inclusion_of :people, :in => [true, false]
    validates_inclusion_of :space, :in => [true, false]
    validates :partnerships, presence: true
    validates :scale, presence: true
    validates :opportunity, presence: true
    validates :timescale, presence: true
    validates :familiarity, presence: true
    validates_inclusion_of :past_projects, :in => [true, false]
end
