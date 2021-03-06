class Plan < ActiveRecord::Base
    serialize :resources
    serialize :partnerships

    validates :role, presence: true
    validates :scale, presence: true
    validates :opportunity, presence: true
    validates :timescale, presence: true
    validates :familiarity, presence: true
    validates :past_projects, presence: true
    validates :resources, presence: true
end
