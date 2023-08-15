scope "/facilities" do
  scope module: "master_security/facility_views" do
    get "/PCC", to: "brief#pcc"
  end
  resources :facilities, controller: "master_security/facilities", path: "" do
    collection do
      get "census", to: "census"
      get "multiple_rdo", to: "master_security/user_access_to_facilities#index"
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
      get "/:Coserial/book_balance", controller: "cash/procedures", action: "book_balance"
      get "/:Coserial/bank_balance", controller: "cash/procedures", action: "bank_balance"
      get "/:Coserial/outstanding_checks", controller: "cash/procedures", action: "outstanding_checks"
    end
  end
  scope module: "it" do
    get "/:id/inventory", to: "inventory#facility_items"
    post "/:id/inventory", to: "inventory#create"
    get "/:id/tg_inventory", to: "inventory#tg_facility_items"
  end
  scope module: "gen_info" do
    get "/:Coserial/record_requests", to: "record_requests#index"
    get "/:Coserial/lawsuits", to: "lawsuits#index"
    get "/:Coserial/lrr", to: "lawsuits#lrr"
    post "/:Coserial/lawsuits", to: "lawsuits#create"
    patch "/:Coserial/lawsuits/:id", to: "lawsuits#update"
  end
end
