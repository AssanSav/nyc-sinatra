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
    if !params[:figure]["name"].empty?
      @figure = Figure.create(name: params[:figure]["name"])
    end

    if !params[:title]["name"].empty? 
      title = Title.create(name: params[:title]["name"])
      @figure.titles << title
    end
    if params[:figure][:title_ids]
    params["figure"][:title_ids].each do |id|
      new_id = Title.find_by_id(id)
      @figure.titles << new_id
       end
    end
    
    if !params[:landmark]["name"].empty? && !params[:landmark]["year"].empty?
      landmark = Landmark.create(name: params[:landmark]["name"], year_completed: params[:landmark]["year"])
      @figure.landmarks << landmark
    end
   # binding.pry
    if params[:figure][:landmark_ids]
      @figure.landmark_ids = params[:figure][:landmark_ids]  
      @figure.save
      #binding.pry
    end
    
    @figure.save
    redirect to "/figures/#{@figure.id}"
  end
  
end
