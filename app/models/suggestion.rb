class Suggestion < ActiveRecord::Base
    has_many :user_suggestions, dependent: :destroy
    has_many :users, through: :user_suggestions
end
