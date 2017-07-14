exchange 'exchange1' do
  description 'exchange1-description'

  options do
    durable true
  end

  queue 'queue1' do
    description 'queue1 description'
    routing_key 'my-custom-routing-key'
    options do
      durable true
      my_custom_option 'two'
    end
  end
end

exchange 'exchange2' do
  description 'exchange2-description'
  options do
    durable false
    ex1_option2 'test2'
  end

  queue 'queue3' do
    description 'queue3 description'
    options do
      durable true
      my_custom_option 'two'
    end
  end

  queue 'queue2' do
    description 'queue2 description'
    options do
      durable true
      my_custom_option 'two'
    end
  end
end