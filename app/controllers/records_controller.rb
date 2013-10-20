class RecordsController < ApplicationController

  # PATCH/PUT /records/1
  # WARNING: This does not work like a typical update - it's updating an array-like data structure.
  def update
    @record = Record.find(params[:id])
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /records.json
  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        format.json { render action: 'show', status: :created, location: @record }
      else
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end


  private

  def record_params
    params.permit(:table_id, :index, :value)
  end
end
