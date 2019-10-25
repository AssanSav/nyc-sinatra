class FiguresController < ApplicationController
  
  get '/figures' do 
    @figures = Figure.all
    erb :'/figures/index'
  end
  
  get '/figures/new' do 
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end
  
  get '/figures/:id' do 
    @figure = Figure.find_by(params[:id])
    erb :'/figures/show'
  end
  
  post '/figures' do 
      @figure = Figure.create(params[:figure])
    if !params[:title]["name"].empty? 
      title = Title.create(name: params[:title]["name"])
      @figure.titles << title
    end
    if !params[:landmark]["name"].empty?
      landmark = Landmark.create(params[:landmark])
      @figure.landmarks << landmark
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/edit'
  end
  
  patch '/figures/:id' do
    @figure = Figure.find_by(params[:id])
    if @figure
      @figure.name = params[:figure][:name]
    end
    if !params[:title]["name"].empty? 
      title = Title.create(name: params[:title]["name"])
      @figure.titles << title
    end
    if !params[:landmark]["name"].empty?
      landmark = Landmark.create(params[:landmark])
      @figure.landmarks << landmark
    end
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
  
end
