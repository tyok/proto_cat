require 'ostruct'
require 'simplecov'
SimpleCov.start
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

  describe 'Protocol' do

    describe '#satisfied_by?' do

      it 'returns true when the protocol is satisfied' do
        expect( IsCat.satisfied_by? @cat ).to eq(true)
      end

      it 'returns false when the protocol is not fully satisfied' do
        expect( IsCat.satisfied_by? @dog ).to eq(false)
      end

    end

    describe '#satisfied_by!' do

      it 'returns true when the protocol is satisfied' do
        expect( IsCat.satisfied_by! @cat ).to eq(true)
      end

      it 'raise error when the protocol is not satisfied' do
        expect{ IsCat.satisfied_by! @dog }.to raise_error(ProtoCat::NotImplementedError)
      end

    end

  end

  describe 'Object' do

    describe '#satisfy?' do

      it 'returns true when the object satisfies the protocol' do
        expect( ProtoCat.object(@cat).satisfy? IsCat ).to eq(true)
      end

      it 'returns false when the object doesn\'t satisfy the protocol'  do
        expect( ProtoCat.object(@dog).satisfy? IsCat ).to eq(false)
      end

    end

    describe '#satisfy!' do

      it 'returns true when the object satisfies the protocol' do
        expect( ProtoCat.object(@cat).satisfy! IsCat ).to eq(true)
      end

      it 'raise error when the object doesn\'t satisfy the protocol'  do
        expect{ ProtoCat.object(@dog).satisfy! IsCat }.to raise_error(ProtoCat::NotImplementedError)
      end

    end

  end

  describe 'Module' do

    it 'doesn\'t raise error when the including class satisfies the protocol' do
      define_class = proc do

        cat_class = Class.new do
          def meow
            'meow'
          end

          def leg
            4
          end
        end
        cat_class.include(IsCat)

      end

      expect(&define_class).not_to raise_error
    end

    it 'raises error when the including class doesn\'t satisfy the protocol' do
      define_class = proc do

        cat_class = Class.new do
          def meow
            'meow'
          end
        end
        cat_class.include(IsCat)

      end

      expect(&define_class).to raise_error(ProtoCat::NotImplementedError)
    end

    it 'doesn\'t raise error when the extending object satisfies the protocol' do
      expect{ @cat.extend(IsCat) }.not_to raise_error
    end

    it 'raises error when the extending object doesn\'t satisfy the protocol' do
      expect{ @dog.extend(IsCat) }.to raise_error(ProtoCat::NotImplementedError)
    end

  end

end
