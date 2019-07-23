class Folder < ApplicationRecord
  has_many :contents, dependent: :destroy
end
