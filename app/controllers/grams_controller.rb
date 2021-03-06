class GramsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

	def new
		@gram = Gram.new
	end

	def index
		@grams = Gram.all
	end

	def show
    @gram = Gram.find_by_id(params[:id])
   	return render_not_found if @gram.blank?
  end

  def destroy
  	@gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user
    @gram.destroy
    redirect_to root_path
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

	def edit
    @gram = Gram.find_by_id(params[:id])
     return render_not_found if @gram.blank?
     return render_not_found(:forbidden) if @gram.user != current_user
  end

   def update
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user

    @gram.update_attributes(gram_params)
     if @gram.valid?
    redirect_to root_path
  		else
    		return render :edit, status: :unprocessable_entity
  		end

  end
	
private


# Whenever we have a form, we need to pull 
# the submitted form data from the params
	def gram_params
		params.require(:gram).permit(:message, :picture)
	end

end