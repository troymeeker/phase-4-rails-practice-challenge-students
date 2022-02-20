class Student < ApplicationRecord
    belongs_to :instructor

    validates :name, presence: :true
    validates :age, :inclusion => 0..18
end
