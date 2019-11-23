require 'rspec/core/formatters'

module RSpec
  module GitHub
    class Formatter
      RSpec::Core::Formatters.register self, :start, :close, :example_failed, :example_pending

      def initialize(output)
        @output = output || StringIO.new
      end

      def start(notification)
        start_sync_output
      end

      def close(_notification)
        restore_sync_output
      end

      def example_failed(failed_example_notification)
        metadata = failed_example_notification.example.metadata
        error = error(file: metadata[:file_path], line_number: metadata[:line_number], message: failed_example_notification.message_lines.join("\r\n"))
        output << "\n#{error}\n"
      end

      def example_pending(examle_notification)

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

      def error(file:, line_number:, message:)
        "::error file=#{file},line=#{line_number}::#{message}"
      end

      def warning()

      end
    end
  end
end
