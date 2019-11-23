require 'rspec/core/formatters'

module RSpec
  module GitHub
    class Formatter
      RSpec::Core::Formatters.register self, :start, :close, :dump_failures

      def initialize(output)
        @output = output || StringIO.new
      end

      def start(notification)
        start_sync_output
      end

      def close(_notification)
        restore_sync_output
      end

      def dump_failures(examples_notification)
        examples_notification.failure_notifications.each do |failure_notification|
          location = failure_notification.example.location
          message = failure_notification.message_lines.join("\r\n")

          output << "\n#{location} | #{message}\n"
        end
      end

      private

      attr_reader :output

      def start_sync_output
        @old_sync, output.sync = output.sync, true if output_supports_sync
      end

      def restore_sync_output
        output.sync = @old_sync if output_supports_sync && !output.closed?
      end

      def output_supports_sync
        output.respond_to?(:sync=)
      end
    end
  end
end
