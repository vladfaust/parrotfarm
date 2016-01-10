if Color.table_exists? && Color.count == 0
  Color.create name: 'red',   hex_value: '#FF0000'
  Color.create name: 'green', hex_value: '#00FF00'
  Color.create name: 'blue',  hex_value: '#0000FF'
end

if Parrot.table_exists? && Parrot.count == 0
  Parrot.create! name: 'Billy', sex: 'male',   age: 1,  color: Color.find_by_name('red')
  Parrot.create! name: 'Willy', sex: 'male',   age: 15, color: Color.find_by_name('green')
  Parrot.create! name: 'Kelly', sex: 'female', age: 19, color: Color.find_by_name('green')
end

