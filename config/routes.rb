Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1', defaults: { format: :json } do
      resources :courses, only: [:index, :show, :create]
    end
  end
end
