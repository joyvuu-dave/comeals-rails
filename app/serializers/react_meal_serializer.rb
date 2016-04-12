class ReactMealSerializer < ActiveModel::Serializer
  attributes :id,
             :description,
             :date,
             :epoch,
             :max,
             :auto_close,
             :closed,
             :reconciled,
             :hasNext,
             :hasPrev,
             :residents

  def residents
    ActiveModelSerializers::SerializableResource.new(Resident.all, each_serializer: ReactResidentSerializer).as_json
  end
  class ReactResidentSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :unit,
               :vegetarian

    def unit
      object.unit.name
    end
  end

  has_many :bills
  class BillSerializer < ActiveModel::Serializer
    attributes :id,
               :resident_id,
               :amount

    def amount
      (object.amount_cents.to_f/100).to_s
    end
  end

  has_many :meal_residents
  class MealResidentSerializer < ActiveModel::Serializer
    attributes :id,
               :resident_id,
               :vegetarian,
               :late
  end

  has_many :guests
  class GuestSerializer < ActiveModel::Serializer
    attributes :id,
               :resident_id,
               :multiplier,
               :vegetarian
  end


  def date
    object.date.inspect
  end

  def reconciled
    object.reconciled?
  end

  # FIXME: should return the actual id
  def hasNext
    object.next?
  end

  # FIXME: should return the actual id
  def hasPrev
    object.prev?
  end
end
