module Lita
  module Handlers
    # Send a message to multiple channels simultaneously.
    class Broadcast < Handler
      route(/^tell\s+(?<channels>[^:]+):\s*(?<message>.+)/i,
            :broadcast,
            command: true,
            help: { t('help.broadcast_key') => t('help.broadcast_value') })

      def broadcast(response)
        channels = response.match_data['channels'].strip.split
        message = response.match_data['message']

        channels.each do |identifier|
          target = channel_for(identifier)
          return response.reply(t('broadcast.not_found', channel: identifier)) if target.nil?

          robot.send_message(target, render_template('broadcast',
                                                     user: response.user,
                                                     says: t('broadcast.says'),
                                                     message: message))
        end
      end

      private

      def channel_for(identifier)
        room = Lita::Room.fuzzy_find(identifier)
        Source.new(room: room) if room
      end

      Lita.register_handler(self)
    end
  end
end
