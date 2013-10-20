class DatabasesController < ApplicationController
  before_action :set_database, only: [:show, :edit, :update, :destroy]
  helper DatabasesHelper

  # GET /databases
  # GET /databases.json
  def index
    @databases = Database.all
  end

  # GET /databases/1
  # GET /databases/1.json
  def show
    @table = @database.tables.first
  end

  # GET /databases/new
  def new
    @database = Database.new
  end

  # GET /databases/1/edit
  def edit
  end

  # POST /databases
  # POST /databases.json
  def create
    @database = Database.new

    respond_to do |format|
      if @database.save
        format.html { redirect_to @database, notice: 'Database was successfully created.' }
        format.json { render action: 'show', status: :created, location: @database }
      else
        format.html { render action: 'new' }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /databases/1
  # PATCH/PUT /databases/1.json
  def update
    respond_to do |format|
      if @database.update(database_params)
        format.html { redirect_to @database, notice: 'Database was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @database.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /databases/1
  # DELETE /databases/1.json
  def destroy
    @database.destroy
    respond_to do |format|
      format.html { redirect_to databases_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_database
      @database = Database.includes(:tables).find(params[:id])
    end

    def database_params
      params[:database].permit(:name)
    end
end
