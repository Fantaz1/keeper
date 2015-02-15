require 'spec_helper'

describe Keeper do
  class Post
    attr_accessor :title, :id
    attr_accessor :coments

    def initialize id, title

    end
  end

  class Address

  end

  class User
    def posts
      [
        {id: 1, title: 'FirstTitle'},
        {id: 2, title: 'SecondTitle'},
        {id: 3, title: 'ThirdTitle'}
      ]
    end
  end

  class MyKeeper << Keeper::Base
    def initialize user
      @user = user
    end

    store :posts do

    end

    store :comments do

    end

    store :addresses do

    end
  end

  it 'has a version number' do
    expect(Keeper::VERSION).not_to be nil
  end

  context "#getter" do

  end

  context "#setter" do

  end

  context "find an array of objects in collection" do

  end

  context 'find a object in collection' do

  end

  context 'array of IDs' do

  end
end
