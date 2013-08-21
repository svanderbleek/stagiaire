require 'spec_helper'
require 'stagiaire/rule'

describe Stagiaire::Rule do
  class TestRule < Stagiaire::Rule
    def file_targets
      ['*.rb']
    end

    def line_rules
      {/test/ => 'tested'}
    end
  end

  let(:matching_line) { 'test line' }
  let(:not_matching_line) { 'line' }
  let(:matching) {}
  let(:not_matching) {}

  it 'finds matching files' do
    expect(TestRule.new.files).to include(matching)
  end

  it 'does not find files that do not match' do
    expect(TestRule.new.files).to_not include(not_matching)
  end

  it 'run on matching lines in matching files' do
    expect(TestRule.new.changes).to include(matching_line, matching_line.gsub(*TestRule.line_rules.to_a.flatten))
  end

  it 'does not run on lines that do not match in matching files' do
    expect(TestRule.new.changes).to_not include(not_matching_line)
  end
end
