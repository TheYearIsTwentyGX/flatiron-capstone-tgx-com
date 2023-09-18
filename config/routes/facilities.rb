scope "/facilities" do
  scope module: "facility_views" do
    get "/PCC", to: "brief#pcc"
  end
  resources :facilities, controller: "facilities", path: "" do
    collection do
      get "census", to: "census"
      get "multiple_rdo", to: "user_access_to_facilities#index"
      get "/owners", action: "owners"
      # Facility Staff
      get "/:id/regionals", action: "regionals"
      get "/:id/facility_staff", action: "facility_staff"
      # Facility Info
      get "/:id/contact", action: "contact_info"
      get "/:id", action: "show"
    end
    # Cash Sheets
    collection do
      get "/:id/book_balance", controller: "cash/procedures", action: "book_balance"
      get "/:id/bank_balance", controller: "cash/procedures", action: "bank_balance"
      get "/:id/outstanding_checks", controller: "cash/procedures", action: "outstanding_checks"
    end
  end
  scope module: "it" do
    get "/:id/inventory", to: "inventory#facility_items"
    post "/:id/inventory", to: "inventory#create"
    get "/:id/tg_inventory", to: "inventory#tg_facility_items"
  end
  scope module: "gen_info" do
    get "/:id/record_requests", to: "record_requests#index"
    get "/:id/lawsuits", to: "lawsuits#index"
    get "/:id/lrr", to: "lawsuits#lrr"
    post "/:id/lawsuits", to: "lawsuits#create"
    patch "/:id/lawsuits/:id", to: "lawsuits#update"
  end
end
