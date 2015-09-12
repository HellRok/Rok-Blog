RokBlog::Engine.routes.draw do
  resources :sites do
    resources :posts, shallow: true
    resources :comments, shallow: true
  end
end
