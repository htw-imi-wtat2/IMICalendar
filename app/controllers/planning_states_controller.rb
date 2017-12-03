# frozen_string_literal: true

class PlanningStatesController < ApplicationController
  before_action :set_planning_state, only: %i[show edit update destroy]

  # GET /planning_states
  # GET /planning_states.json
  def index
    @planning_states = PlanningState.all
  end

  # GET /planning_states/1
  # GET /planning_states/1.json
  def show; end

  # GET /planning_states/new
  def new
    @planning_state = PlanningState.new
  end

  # GET /planning_states/1/edit
  def edit; end

  # POST /planning_states
  # POST /planning_states.json
  def create
    @planning_state = PlanningState.new(planning_state_params)

    respond_to do |format|
      if @planning_state.save
        format.html { redirect_to @planning_state, notice: 'Planning state was successfully created.' }
        format.json { render :show, status: :created, location: @planning_state }
      else
        format.html { render :new }
        format.json { render json: @planning_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /planning_states/1
  # PATCH/PUT /planning_states/1.json
  def update
    respond_to do |format|
      if @planning_state.update(planning_state_params)
        format.html { redirect_to @planning_state, notice: 'Planning state was successfully updated.' }
        format.json { render :show, status: :ok, location: @planning_state }
      else
        format.html { render :edit }
        format.json { render json: @planning_state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /planning_states/1
  # DELETE /planning_states/1.json
  def destroy
    @planning_state.destroy
    respond_to do |format|
      format.html { redirect_to planning_states_url, notice: 'Planning state was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_planning_state
    @planning_state = PlanningState.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def planning_state_params
    params.require(:planning_state).permit(:event_id, :date_set, :room_booked, :announced, :notes)
  end
end
