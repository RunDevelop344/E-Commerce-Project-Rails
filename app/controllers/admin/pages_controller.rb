class Admin::PagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_page, only: [ :edit, :update ]

  def index
    @pages = Page.all
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to admin_pages_path, notice: "#{@page.title} updated successfully."
    else
      render :edit
    end
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :content)
  end
end
