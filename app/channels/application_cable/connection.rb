module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

    def connect
      self.current_player = find_player
    end

    private

    def find_player
      Player.find_by(connection_secret: request.params[:connection_secret]) ||
        reject_unauthorized_connection
    end
  end
end
