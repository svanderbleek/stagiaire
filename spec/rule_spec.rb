require 'spec_helper'
require 'stagiaire/rule'
require 'tmpdir'
require 'tempfile'

describe Stagiaire::Rule do
  class TestRule < Stagiaire::Rule
    def file_targets
      ['matching*']
    end

    def line_rules
      {/test/ => 'tested'}
    end
  end

  let(:matching_line) { 'test line' }
  let(:not_matching_line) { 'line' }
  let!(:matching) do 
    file = Tempfile.new('matching')
    file.write([matching_line, not_matching_line].join("\n"))
    file.rewind
    file
  end
  let!(:not_matching) { Tempfile.new('not_matching') }
  let(:directory) { Dir.tmpdir }

  it 'finds matching files' do
    expect(TestRule.new.files(directory)).to include(matching.path)
  end

  it 'does not find files that do not match' do
    expect(TestRule.new.files(directory)).to_not include(not_matching.path)
  end

  context 'with files' do
    let(:files) { [matching] }

    it 'run on matching lines in matching files' do
      expect(TestRule.new.changes(files).flatten).to include(matching_line, matching_line.gsub(*TestRule.new.line_rules.to_a.flatten))
    end

    it 'does not run on lines that do not match in matching files' do
      expect(TestRule.new.changes(files).flatten).to_not include(not_matching_line)
    end
  end
end
