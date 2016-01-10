FactoryGirl.define do
  factory :color do
    factory :color_red do
      name 'red'
      hex_value '#FF0000'
    end

    factory :color_green do
      name 'green'
      hex_value '#00FF00'
    end

    factory :color_blue do
      name 'blue'
      hex_value '#0000FF'
    end
  end
end
