class GramsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create]

	def new
		@gram = Gram.new
		 	
	end

	def index
	end


#In order to save the gram 
#into our database add a call to the Gram.create method
	def create
		@gram = current_user.grams.create(gram_params)
		if @gram.valid?
    	redirect_to root_path
  	else
    	render :new, status: :unprocessable_entity
  	end
		
	end
	
end

private


# Whenever we have a form, we need to pull 
# the submitted form data from the params
	def gram_params
		params.require(:gram).permit(:message)
	end