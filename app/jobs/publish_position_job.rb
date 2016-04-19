class PublishPositionJob < ApplicationJob
  queue_as :default

  def perform(position)
    ActionCable.server.broadcast("position_channel", position.to_json)
  end
end
