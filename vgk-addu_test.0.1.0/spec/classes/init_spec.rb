require 'spec_helper'
describe 'addu_test' do

  context 'with defaults for all parameters' do
    it { should contain_class('addu_test') }
  end
end
