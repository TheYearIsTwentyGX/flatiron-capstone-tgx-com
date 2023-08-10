scope path: "/tgsetup", module: "it" do
  resources :tg_setup_profiles, path: "profiles" do
    collection do
      get "/profiles/:id/programs", to: "tg_setup_profiles#programs"
    end
  end
  resource :tg_setup_reg_edits, path: "regedits" do
    collection do
      get "/universal", to: "tg_setup_reg_edits#universal"
    end
  end
  resource :registry, controller: "tg_setup_reg_edits", only: %i[show] do
    get "universal", to: "tg_setup_reg_edits#universal"
  end
  resource :programs, controller: "tg_setup_programs", only: %i[show] do
    get "universal", to: "tg_setup_programs#universal"
  end
end
