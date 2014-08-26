class EntriesController < ApplicationController

  def index
    @entries = Entry.all
  end

  def new
    @entry = create_entry_object_from_params
    if @entry.nil?
      @entry = Entry.new
      @entry.contest = Contest.current
      cp = @entry.cosplays.build
      cp.build_owner
      cp.build_character
    end
  end

  def create
    begin
      entry = create_entry_object_from_params
      EntriesHelper.configure_for_exhibition!(entry)
      entry.save!

      flash[:success] = "Awesome!"
      respond_to do |format|
        format.html { redirect_to new_entry_path }
      end
    rescue => e
      flash[:error] = "There was an error saving the entry. #{e.message}"
      redirect_to new_entry_path(entry: params[:entry])
    end
  end

  private

  def create_entry_object_from_params
    begin
      entry = Entry.new entry_params
      cosplay_params[:cosplays_attributes].each do |k, cosplay|
        owner =  Person.where(cosplay[:owner_attributes]).first_or_create
        character = Character.where(cosplay[:character_attributes]).first_or_create
        entry.cosplays.build(owner: owner, character: character)
      end
    rescue ActionController::ParameterMissing => e

    end
    entry
  end

  def cosplay_params
    params.require(:entry).permit(:cosplays_attributes => [owner_attributes: [:first_name, :last_name, :phonetic_spelling, :email], character_attributes: [:name, :property]])
  end

  def entry_params
    # contest id should not be permitted, it should be set by the system
    params.require(:entry).permit(
      :judging_time_id,
      :contest_id,
      :skill_level,
      :hot_or_bulky?,
      :group_name,
      :handler_count,
      :category_ids => []
    )
  end

end
