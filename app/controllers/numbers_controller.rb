class NumbersController < ApplicationController

  # GET /numbers
  # GET /numbers.json
  def index
    @number = Number.last
  end

  # GET /numbers/new
  def new
    @number = Number.last
  end

  # POST /numbers
  # POST /numbers.json
  def create
    if NumberRunning.count == 0
      running = NumberRunning.new
      running.counter = 1111111111
      running.save!
    else
      running = NumberRunning.first
    end

    @number = Number.new

    can_use_unique = false
    unless params["value"].nil?
      newvalue = params["value"].to_i
      unless Number.any? {|n| n.value == newvalue }
        can_use_unique = true
      end
    end

    if can_use_unique
      @number.value = newvalue
    else
      @number.value = running.counter
      running.counter += 1
      running.save!
    end

    @number.save!

    render :index
  end
end
