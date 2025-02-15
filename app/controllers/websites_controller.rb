class WebsitesController < ApplicationController
  before_action :set_website, only: %i[show edit update destroy]
  before_action :authenticate_user!
  
  # GET /websites or /websites.json
  def index
    @websites = Website.all
    @websites = current_user.websites
  end

  # GET /websites/1 or /websites/1.json
  def show
    @website = Website.find(params[:id])
    @status_pings = StatusPing.where(website_id: @website.id).order(created_at: :desc).limit(25).reverse
  end

  # GET /websites/new
  def new
    @website = Website.new
  end

  # GET /websites/1/edit
  def edit
  end

  # POST /websites or /websites.json
  def create
    @website = current_user.websites.new(website_params)
    respond_to do |format|
      if @website.save
        start_pinging(@website)
        
        
        format.html { redirect_to @website, notice: "Website was successfully created." }
        format.json { render :show, status: :created, location: @website }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /websites/1 or /websites/1.json
  def update
    respond_to do |format|
      if @website.update(website_params)
        if @website.saved_change_to_body? || @website.saved_change_to_time?
          PingUrlJob.perform_later(@website.id)
        end
  
        format.html { redirect_to @website, notice: "Website was successfully updated." }
        format.json { render :show, status: :ok, location: @website }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @website.destroy

    respond_to do |format|
      format.html { redirect_to websites_path, status: :see_other, notice: "Website was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_website
    @website = Website.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def website_params
    params.require(:website).permit(:title, :body, :time)
  end

  # Start the pinging process in the background
  def start_pinging(website)
    PingUrlJob.perform_later(website.id) if website.time.present?
    StatusPing.create(website: website, status_number: 1) if website.time.present?

  end
end
