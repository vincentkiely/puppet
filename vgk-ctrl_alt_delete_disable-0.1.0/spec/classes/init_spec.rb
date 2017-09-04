require 'spec_helper'
describe 'ctrl_alt_delete_disable' do

  context 'with defaults for all parameters' do
    it { should contain_class('ctrl_alt_delete_disable') }
  end
end
