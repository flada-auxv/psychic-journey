module Embulk
  module Parser

    class TenhouLog < ParserPlugin
      Plugin.register_parser("tenhou_log", self)

      def self.transaction(config, &control)
        decoder_task = config.load_config(Java::LineDecoder::DecoderTask)

        task = {
          "decoder" => DataSource.from_java(decoder_task.dump)
        }

        columns = [
          Column.new(0, "time", :string),
          Column.new(1, "game_time", :string),
          Column.new(2, "player_count", :string),
          Column.new(3, "grade", :string),
          Column.new(4, "game_length", :string),
          Column.new(5, "kuitan", :string),
          Column.new(6, "aka", :string),
          Column.new(7, "player1", :string),
          Column.new(8, "player2", :string),
          Column.new(9, "player3", :string),
          Column.new(10, "player4", :string),
        ]

        yield(task, columns)
      end

      def init
        @decoder = task.param("decoder", :hash).load_task(Java::LineDecoder::DecoderTask)
      end

      def run(file_input)
        decoder = Java::LineDecoder.new(file_input.to_java, @decoder)

        while decoder.nextFile
          while line = decoder.poll
            page_builder.add(parse(line))
          end
        end
        page_builder.finish
      end

      private

      def parse(line)
        time, game_time, category, players = line.split(" | ")

        [time, game_time, parse_category(category), parse_players(players)].flatten
      end

      def parse_category(str)
        str.chars[0..4]
      end

      def parse_players(str)
        str.split
      end
    end
  end
end
