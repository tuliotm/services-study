require "rails_helper"

RSpec.describe(Users::Organizers::Search) do
  describe ".call" do
    # databse cleaner
    User.delete_all

    context "when search is successful" do
      User.create!(name: "Jackson Pires", email: "jackson.pires@jack.com")
      User.create!(name: "John Bauer", email: "john@bauer")

      it "returns a list of users" do
        allow(Rails.logger).to(receive(:info).once)

        result = Users::Organizers::Search.call(term: "jackson", user: "Jackson Pires")

        expect(Rails.logger).to(have_received(:info).with("[INFO] A new search was made by 'Jackson Pires' with term 'jackson'"))

        expect(result.success?).to(be(true))
        expect(result.users.count).to(eq(1))
        expect(result.users.first.name).to(eq("Jackson Pires"))
      end

      it "returns a list of all users when term is empty" do
        allow(Rails.logger).to(receive(:info).once)

        result = Users::Organizers::Search.call(term: "", user: "Jackson Pires")

        expect(Rails.logger).to(have_received(:info).with("[INFO] A new search was made by 'Jackson Pires' with term ''"))

        expect(result.success?).to(be(true))
        expect(result.users.count).to(eq(2))
        expect(result.users.map { _1.name }).to(match_array(["Jackson Pires", "John Bauer"]))
      end
    end
  end
end
