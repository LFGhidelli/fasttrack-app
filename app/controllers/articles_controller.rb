class ArticlesController < ApplicationController
  def index
    @articles = Article.new
    @client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      secret_token: ENV['IEX_API_SECRET_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:name)
  end
end
