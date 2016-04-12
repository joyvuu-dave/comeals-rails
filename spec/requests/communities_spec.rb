# == Schema Information
# Schema version: 20160324173111
#
# Table name: communities
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  cap             :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  rotation_length :integer
#  time_zone       :string           default("UTC"), not null
#
# Indexes
#
#  index_communities_on_name  (name) UNIQUE
#

require 'rails_helper'

RSpec.describe "Communities", type: :request do
  pending "add some examples to (or delete) #{__FILE__}"
end
