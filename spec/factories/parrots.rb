FactoryGirl.define do
  factory :parrot do
    sex %w(male female)[Random.rand(1)]
    age (1 + Random.rand(100))

    transient do
      color_name %w(red green blue)[Random.rand(3)]
    end

    # Assigns a proper color based on 'color_name'
    # I couldn't find a better way
    after(:build) do |parrot, evaluator|
      parrot.color = ((color = Color.find_by_name(evaluator.color_name)) ? color : create("color_#{evaluator.color_name}".to_sym))
    end
  end

end
