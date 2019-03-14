require 'spec_helper'

describe 'Rkhunter::PortWhitelist' do
  context 'with valid parameters' do
    it { is_expected.to allow_value( 'TCP:135' ) }
    it { is_expected.to allow_value( 'UDP:1526' ) }
    it { is_expected.to allow_value( 'TCP:135 UDP:1526' ) }
  end
  context 'with invalid parameters' do
    it { is_expected.not_to allow_value( '*' ) }
    it { is_expected.not_to allow_value( 'tcp:135' ) }
    it { is_expected.not_to allow_value( 'udp:2516' ) }
    it { is_expected.not_to allow_value( 'UDP:2516,TCP:459' ) }
    it { is_expected.not_to allow_value( 'TCP:135   UDP:1526' ) }
  end
  context 'with silly things' do
    it { is_expected.not_to allow_value( [] ) }
    it { is_expected.not_to allow_value( '.' ) }
    it { is_expected.not_to allow_value( '' ) }
    it { is_expected.not_to allow_value( :undef ) }
  end
end
