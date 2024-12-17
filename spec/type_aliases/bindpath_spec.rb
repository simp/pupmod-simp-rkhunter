require 'spec_helper'

describe 'Rkhunter::BindPath' do
  context 'with valid parameters' do
    it { is_expected.to allow_value('+/this/is/fine') }
    it { is_expected.to allow_value('+/this/is/fine /this/too') }
    it { is_expected.to allow_value('/this/is/fine +/also/fine') }
  end
  context 'with invalid parameters' do
    it { is_expected.not_to allow_value('no/bueno') }
    it { is_expected.not_to allow_value('../no/bueno/still') }
    it { is_expected.not_to allow_value('*/still/no/bueno/') }
  end
  context 'with silly things' do
    it { is_expected.not_to allow_value([]) }
    it { is_expected.not_to allow_value('.') }
    it { is_expected.not_to allow_value('') }
    it { is_expected.not_to allow_value(:undef) }
  end
end
