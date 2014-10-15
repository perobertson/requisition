require 'test_helper'

describe UserAbility do

  describe "Sanity" do
    it "must start with valid fixtures" do
      UserAbility.all.each do |user_ability|
        user_ability.valid?.must_equal true, user_ability.errors.messages
      end
    end
  end

end
