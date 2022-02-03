class User < ApplicationRecord
    validates_presence_of :firstname, :lastname
end
