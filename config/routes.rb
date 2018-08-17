Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :course_stats, only: %i[create update] do
    resources :section_stats, only: %i[create update] do
      resources :quiz_stats, only: %i[create update] do
        resources :answer_stats, only: %i[create update]
      end
      resources :task_stats, only: %i[create update]
      resources :material_stats, only: %i[create update]
    end
  end
end
