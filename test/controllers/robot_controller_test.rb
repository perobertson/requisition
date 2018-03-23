# frozen_string_literal: true

class RobotControllerTest < ActionController::TestCase
  describe 'allowed robots' do
    before do
      ENV['ALLOW_ROBOTS'] = 'true'
    end

    after do
      ENV['ALLOW_ROBOTS'] = nil
    end

    it 'must not block spiders' do
      get :show, format: :text
      lines = response.body.split "\n"

      lines.each_with_index do |line, i|
        next unless line == 'User-agent: *'
        lines.length.must_be :>, i + 1
        lines[i + 1].wont_be_empty
        lines[i + 1].must_equal 'Disallow:'
      end
    end
  end

  describe 'blocked robots' do
    it 'must block spiders' do
      ENV['ALLOW_ROBOTS'].must_be_nil

      get :show, format: :text
      lines = response.body.split "\n"

      lines.each_with_index do |line, i|
        next unless line == 'User-agent: *'
        lines.length.must_be :>, i + 1
        lines[i + 1].wont_be_empty
        lines[i + 1].must_equal 'Disallow: /'
      end
    end
  end
end
