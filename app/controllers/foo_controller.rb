class FooController < ApplicationController
  def foo
    render 'foo', layout: 'foo_layout'
  end
end
