Label.create_with(name: 'Administrator').find_or_create_by! id: 1
Staff.create_with(label_id: 1, password: 'masa1436L').find_or_create_by! email: 'munky69rock@gmail.com', role: :admin # FIXME
