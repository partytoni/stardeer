require 'rails_helper'

RSpec.describe User do
  it "is not valid with just name" do
    user=User.new(name: "antonio")
    expect(user).not_to be_valid
  end

  it "is not valid with just name and email" do
    user=User.new(name: "antonio", email: "martemmuccio@gmail.com")
    expect(user).not_to be_valid
  end

  it "is not valid with just name, email and role" do
    user=User.new(name: "antonio", email: "martemmuccio@gmail.com", superadmin_role:true)
    expect(user).not_to be_valid
  end
end
