require 'rails_helper'

RSpec.describe "PageViews" do
    it 'show the number of page views' do
        visit '/welcome'
        expect(page.text).to match(/This page has been viewed [0-9]+ times?!/)
    end

    it 'is enhanced with javascript on', js: true do
        visit '/welcome'
        expect(page.text).to have_text('ENHANCED!')
    end
end
