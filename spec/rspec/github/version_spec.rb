require 'spec_helper'

describe RSpec::GitHub do
  it 'contains a version string' do
    expect(described_class::VERSION).to match %r{\d+.\d+.\d+}
  end
end
