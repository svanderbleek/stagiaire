require 'spec_helper'
require 'tmpdir'

describe 'Stagiaire script' do
  it 'runs in current directory by default' do
    output = `./bin/stagiaire`

    expect(output).to include(Dir.pwd)
  end

  let(:directory) { Dir.tmpdir }

  it 'runs in directory if argument given' do
    output = `./bin/stagiaire #{directory}`

    expect(output).to include(directory)
  end
end
