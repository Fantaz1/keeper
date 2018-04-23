require 'spec_helper'

describe Keeper do
  it 'has a version number' do
    expect(Keeper::VERSION).not_to be nil
  end

  context 'debuggability' do
    class Base < Keeper::Base
      store(:base) { [1, 2, 3] }
    end

    class Child < Base
      store(:child) { [4, 5, 6] }
    end

    it 'puts stores in correct order' do
      expect(Child.ancestors).to include(
        Child,
        Child::CHILD_KEEPER_STORE,
        Base,
        Base::BASE_KEEPER_STORE,
        Keeper::Base,
        Object,
        Kernel,
        BasicObject
      )
    end
  end
end
