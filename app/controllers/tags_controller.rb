class TagsController < ApplicationController
  include ApplicationHelper
  before_action :set_tag, except: [ :index, :create ]

  def index
    @tags = Tag.all
    @tags = @tags.order(set_order_from_params(params: params, default_attribute: "name"))
    render json: @tags
  end

  def create
    @tag = Tag.create!(tag_params)
    render json: @tag
  end

  def update
    @tag.update!(tag_params)
    render json: @tag
  end

  def show
    render json: @tag
  end

  def destroy
    @tag.destroy
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :tag_type)
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end
end
