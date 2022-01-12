# helper function to open product images
def open_asset(fn)
  File.open(Rails.root.join("db", "seed_assets", fn))
end