# frozen_string_literal: true

class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_event, only: %i[show edit update destroy]
  before_action :set_event_categories, only: %i[show edit update destroy]
  before_action :set_all_categories, only: %i[new edit]
  include CategoriesHelper
  # GET /events
  # GET /events.json
  def index
    @categories = Category.all

    if (category_id = params[:category])
      # TBD: check if id is present
      @category = Category.find(category_id)
      @events = @category.events
    else
      @events = Event.all
    end

    s = @events.size - 1
    m = s / 2
    @events_left = @events[0..m]
    @events_right = @events[(m + 1)..s]
  end

  def planning
    @events = Event.all
    @events.each { |e| e.planning_state ||= e.build_planning_state }
  end

  # GET /events/1
  # GET /events/1.json
  def show; end

  # GET /events/new
  def new
    @event = Event.new
    @planning_state = @event.build_planning_state
  end

  # GET /events/1/edit
  def edit; end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.categories = s_to_categories(params[:categories])
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        @event.categories = s_to_categories(params[:categories])
        @event.save
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
    @planning_state = @event.planning_state || @event.create_planning_state
  end

  def set_all_categories
    names_alphabetically = Category.names_alphabetically
    @categories_all = names_alphabetically.join(', ')
    @categories_js = names_to_js(names_alphabetically)
  end

  def set_event_categories
    @categories = @event.categories
    @categories_s = categories_to_s(@categories)
  end

  # only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :start_date, :end_date, :location,
                                  :description,
                                  planning_state_attributes:
                                  %i[id date_set room_booked announced notes])
  end
end
