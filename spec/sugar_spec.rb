require 'ostruct'
require_relative 'spec_helper'
require_relative '../lib/proto_cat/with_sugar'

RSpec.describe ProtoCat do
  before do
    IsCat ||= ProtoCat.define_protocol do |p|
      p.has_method(:meow)
      p.has_method(:leg)
    end

    @cat = OpenStruct.new(meow: 'meow', leg: 4)
    @dog = OpenStruct.new(bark: 'bark', leg: 4)
  end

  describe '===' do
    it 'behaves like #satisfied_by?' do
      expect( IsCat === @cat ).to eq(true)
      expect( IsCat === @dog ).to eq(false)
    end
  end

  describe 'must ===' do
    it 'behaves like #satisfied_by!' do
      expect( IsCat.must === @cat ).to eq(true)
      expect{ IsCat.must === @dog }.to raise_error(ProtoCat::NotImplementedError)
    end
  end
end
