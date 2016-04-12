# == Schema Information
# Schema version: 20160330153936
#
# Table name: meals
#
#  id                        :integer          not null, primary key
#  date                      :date             not null
#  cap                       :integer
#  meal_residents_count      :integer          default(0), not null
#  guests_count              :integer          default(0), not null
#  cost                      :integer          default(0), not null
#  meal_residents_multiplier :integer          default(0), not null
#  guests_multiplier         :integer          default(0), not null
#  description               :text
#  max                       :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  reconciliation_id         :integer
#  closed                    :boolean          default(FALSE), not null
#  time_zone                 :string
#  auto_close                :boolean          default(FALSE), not null
#
# Indexes
#
#  index_meals_on_reconciliation_id  (reconciliation_id)
#
# Foreign Keys
#
#  fk_rails_4ac0d4ffd3  (reconciliation_id => reconciliations.id)
#

class Meal < ApplicationRecord
  scope :unreconciled, -> { where(reconciliation_id: nil) }

  attr_readonly :cap

  has_many :bills, dependent: :destroy
  has_many :meal_residents, inverse_of: :meal, dependent: :destroy
  has_many :guests, inverse_of: :meal, dependent: :destroy

  validates :date, uniqueness: true, presence: true
  validates :max, numericality: { only_integer: true }, unless: "max.nil?"

  accepts_nested_attributes_for :meal_residents, allow_destroy: true
  accepts_nested_attributes_for :guests, allow_destroy: true
  accepts_nested_attributes_for :bills, allow_destroy: true

  def extras
    max.present? ? max - attendees : 0
  end

  def extras=(value)
    unless closed
      return errors[:base] << "Can't set extras for open meal"
    end

    self.max = attendees + value
  end

  def cap
    read_attribute(:cap) || Float::INFINITY
  end

  def epoch
    hour = date.sunday? ? 18 : 19 # 7pm, but 6pm on Sundays
    original_time_zone = Time.zone.name
    Time.zone = time_zone
    time = Time.zone.parse("#{date.iso8601} #{hour}:00:00")
    ms = (time.to_f * 1000).to_i
    Time.zone = original_time_zone
    ms
  end

  # DERIVED DATA
  def multiplier
    meal_residents_multiplier + guests_multiplier
  end

  def attendees
    meal_residents_count + guests_count
  end

  def chargeable_unit_cost
    if attendees == 0
      0
    else
      fraction = cost / multiplier.to_f
      [(fraction.nan? ? 0 : fraction).ceil, cap].min
    end
  end

  def subsidized?
    return false if attendees == 0
    chargeable_unit_cost * multiplier - cost < 0
  end

  def reconciled?
    reconciliation_id.present?
  end

  def next?
    Meal.where("date > ?", date).count > 0
  end

  def next
    Meal.where("date > ?", date).first if next?
  end

  def prev?
    Meal.where("date < ?", date).count > 0
  end

  def prev
    Meal.where("date < ?", date).first if prev?
  end

  # Report Methods
  def self.unreconciled_ave_cost
    val = 2 * ((Meal.unreconciled.pluck(:cost).reduce(&:+).to_i / Meal.unreconciled.reduce(0) { |sum, meal| sum + meal.multiplier }.to_f) / 100.to_f)
    "$#{sprintf('%0.02f', val)}/adult"
  end

  def self.unreconciled_ave_number_of_attendees
    (Meal.unreconciled.reduce(0) { |sum, meal| sum + meal.attendees } / Meal.unreconciled.count.to_f).round(1)
  end

  def self.create_templates(start_date, end_date, alternating_dinner_day, num_meals_created)
    # Are we finished?
    return num_meals_created if start_date > end_date

    # Is it a common dinner day?
    if [alternating_dinner_day, 2, 4].any? { |num| num == start_date.wday }
      # Flip if alternating dinner day
      if start_date.wday == alternating_dinner_day
        alternating_dinner_day = (alternating_dinner_day - 1) ** 2
      end

      if Meal.new(date: start_date, cap: Community.first.cap).save
        num_meals_created += 1
      end

      # If common dinner was on a Sunday, we
      # don't have dinner the next day
      start_date += 24.hour if start_date.wday == 0

      start_date += 24.hour
      return create_templates(start_date, end_date, alternating_dinner_day, num_meals_created)
    end

    start_date += 24.hour
    return create_templates(start_date, end_date, alternating_dinner_day, num_meals_created)
  end
end
