class BirdEyeScoreSerializer < ActiveModel::Serializer
  attributes :id, :EffectiveDate, :Co_serial, :ReviewCount, :AvgerageRating, :LastEdit_Who, :LastEdit_When
end
