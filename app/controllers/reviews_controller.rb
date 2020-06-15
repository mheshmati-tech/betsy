class ReviewsController < ApplicationController

    before_action :find_review, only:[:show]

    def show
    end

    def new
        @review = Review.new
    end

    def create
        @review = Review.create(review_params)

        if @review.save
            flash[:sucess] = "Successfully created review"
            redirect_to root_path
            return
        else
            flash.now[:error] = "Could not save review. Errors: #{@review.errors.messages}"
            render :new
            return
        end
    end

    def edit
        if @review.nil?
            head :not_found
            return
          end
    end

    def update
        if @review.update(review_params)
            flash[:success] = "review successfully edited"
            redirect_to root_path
            return
        else
            flash.now[:error] = "Unable to edit review. Errors: #{@review.errors.messages}"
            render :edit
            return
        end
    end

    def destroy
        if @review.nil?
            head :not_found
            return
          end
      
          @review.destroy
      
          redirect_to root_path
          return
    end

    private

    def find_review
        @review = Review.find_by(id: params[:id])
        if @review.nil?
            head :not_found
            return
        end
    end

    def review_params
        return params.require(:review).permit(:rating, :text, product_ids: [])
    end
end
