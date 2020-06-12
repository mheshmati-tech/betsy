class CategoriesController < ApplicationController
    # check that user is logged in before creating a category
    def new
        @category = Category.new
    end
    
    def create
        @category = Category.create(category_params)
        if @category.save
            flash[:sucess] = "Successfully created category"
            redirect_to root_path
            return
        else
            flash.now[:error] = "Could not save category. Errors: #{@category.errors.messages}"
            render :new
            return
        end
    end

    # def edit  
    # end

    # def update
    #     # TODO: verify that category belongs to product with current user_id
    #     if @category.update(
    #         category_params
    #       )
    #         flash[:success] = "Category successfully edited"
    #         redirect_to root_path
            
    #         return
    #       else
    #         flash.now[:error] = "Unable to edit category. Errors: #{@category.errors.messages}"
    #         render :edit
    #         return
    #       end
    # end

    private

    def category_params
        return params.require(:category).permit(:name)
    end
end
