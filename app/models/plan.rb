class Plan < ActiveRecord::Base
    validates :role, presence: true
    validates :funding, presence: true
    validates :people, presence: true
    validates :space, presence: true
    validates :partnerships, presence: true
    validates :scale, presence: true
    validates :opportunity, presence: true
    validates :timescale, presence: true
    validates :familiarity, presence: true
    validates :past_projects, presence: true
end
