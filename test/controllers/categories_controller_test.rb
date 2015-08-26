require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  describe 'unauthenticated' do
    describe 'index' do
      it 'must be redirected to login' do
        get :index
        response.status.must_equal 302
      end
    end

    describe 'show' do
      it 'must be redirected to login' do
        get :show, id: Category.all.sample.id
        response.status.must_equal 302
      end
    end

    describe 'new' do
      it 'must be redirected to login' do
        get :new
        response.status.must_equal 302
      end
    end

    describe 'edit' do
      it 'must be redirected to login' do
        get :edit, id: Category.all.sample.id
        response.status.must_equal 302
      end
    end

    describe 'create' do
      it 'must be redirected to login' do
        post :create
        response.status.must_equal 302
      end
    end

    describe 'update' do
      it 'must be redirected to login' do
        put :update, id: Category.all.sample.id
        response.status.must_equal 302
      end
    end

    describe 'destroy' do
      it 'must be redirected to login' do
        delete :destroy, id: Category.all.sample.id
        response.status.must_equal 302
      end
    end
  end

  describe 'authenticated' do
    describe 'unauthorized' do
      before do
        switch_login users(:user_no_abilities)
      end

      describe 'index' do
        it 'must get index' do
          get :index
          assert_response :see_other
        end
      end
    end

    describe 'authorized' do
      let(:category) { Category.all.sample }
      before do
        switch_login users(:user1)
      end

      describe 'index' do
        it 'must get index' do
          get :index
          assert_response :success
          assert_not_nil assigns(:categories)
        end

        it 'must create category' do
          assert_difference('Category.count') do
            post :create, category: { name: 'New Category' }
          end

          assert_redirected_to category_path(assigns(:category))
        end

        it 'must show category' do
          get :show, id: category.id
          assert_response :success
        end

        it 'must get edit' do
          get :edit, id: category.id
          assert_response :success
        end

        it 'must update category' do
          patch :update, id: category.id, category: { name: 'Updated Category' }
          assert_redirected_to category_path(assigns(:category))
        end

        it 'must destroy category' do
          category = categories :category_empty
          assert_difference('Category.not_deleted.count', -1) do
            delete :destroy, id: category.id
          end

          assert_redirected_to categories_path
        end
      end
    end
  end
end
