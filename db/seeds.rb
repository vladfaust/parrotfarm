if Color.table_exists? && Color.count == 0
  Color.create name: 'red',    hex_value: '#FF0000'
  Color.create name: 'green',  hex_value: '#00FF00'
  Color.create name: 'blue',   hex_value: '#0000FF'
  Color.create name: 'orange', hex_value: '#FF4500'
  Color.create name: 'gold',   hex_value: '#FFD700'
  Color.create name: 'violet', hex_value: '#8A2BE2'
  Color.create name: 'sienna', hex_value: '#A0522D'
end

if Parrot.table_exists? && Parrot.count == 0
  Parrot.create! name: 'Billy',  sex: 'male',   age: 6,  color: Color.find_by_name('red')
  Parrot.create! name: 'Willy',  sex: 'male',   age: 3,  color: Color.find_by_name('violet'), tribal: true
  Parrot.create! name: 'Kelly',  sex: 'female', age: 16, color: Color.find_by_name('green'), tribal: true
  Parrot.create! name: 'Trelly', sex: 'male',   age: 28, color: Color.find_by_name('green'), tribal: true
  Parrot.create! name: 'Fred',   sex: 'male',   age: 14, color: Color.find_by_name('gold')

  mark  = Parrot.create! name: 'Mark',  sex: 'male',   age: 93, color: Color.find_by_name('orange'), tribal: true
  wenny = Parrot.create! name: 'Wenny', sex: 'female', age: 48, color: Color.find_by_name('orange'), tribal: true
  marry = Parrot.create! name: 'Marry', sex: 'female', age: 36, color: Color.find_by_name('sienna'), mother_id: wenny.id, father_id: mark.id, tribal: true

  john = Parrot.create! name: 'John',  sex: 'male',   age: 85, color: Color.find_by_name('blue'), tribal: true
  katy = Parrot.create! name: 'Katy',  sex: 'female', age: 56, color: Color.find_by_name('blue'), tribal: true
  joty = Parrot.create! name: 'Joty',  sex: 'male',   age: 44, color: Color.find_by_name('sienna'), mother_id: katy.id, father_id: john.id, tribal: true

  matty = Parrot.create! name: 'Matty', sex: 'male', age: 24, color: Color.find_by_name('gold'), mother_id: marry.id, father_id: joty.id, tribal: true

  exy  = Parrot.create! name: 'Exy',  sex: 'female', age: 38, color: Color.find_by_name('orange'), tribal: true
  sean = Parrot.create! name: 'Sean', sex: 'male',   age: 25, color: Color.find_by_name('orange'), tribal: true
  exan = Parrot.create! name: 'Exan', sex: 'female', age: 20, color: Color.find_by_name('gold'), mother_id: exy.id, father_id: sean.id, tribal: true

  exanny = Parrot.create! name: 'Exanny', sex: 'female', age: 8, color: Color.find_by_name('orange'), mother_id: exan.id, father_id: matty.id, tribal: true
end

