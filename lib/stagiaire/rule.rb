class Stagiaire
  class Rule
    def files(directory)
      file_targets.inject([]) do |files, file_target|
        files << Dir[File.join(directory, file_target)]
      end.flatten
    end

    def changes(files)
      files.inject([]) do |changes, file|
        File.open(file).each_line do |line|
          line_rules.each do |line_rule|
            if line_rule.first.match(line)
              changes << [line.chomp, line.gsub(line_rule.first, line_rule.last).chomp]
            end
          end
        end

        changes
      end
    end
  end
end
