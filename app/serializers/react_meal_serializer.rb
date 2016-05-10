class ReactMealSerializer < ActiveModel::Serializer
  attributes :meal,
             :residents

  def meal
    {
      id: object.id,
      description: object.description,
      date: object.date.inspect,
      epoch: object.epoch,
      max: object.max,
      auto_close: object.auto_close,
      closed_in_database: object.closed,
      reconciled: object.reconciled?,
      prevId: object.prev? ? object.prev.id  : '',
      nextId: object.next? ? object.next.id : ''
    }
  end

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
      sprintf('%0.02f', object.amount_cents.to_f / 100)
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
end
