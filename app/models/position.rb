class Position < ApplicationRecord
  belongs_to :device

  after_create_commit {
    PublishPositionJob.perform_later(self)
  }

end
