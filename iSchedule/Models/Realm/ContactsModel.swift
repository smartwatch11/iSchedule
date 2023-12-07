//
//  ContactsModel.swift
//  iSchedule
//
//  Created by Egor Rybin on 03.12.2023.
//

import RealmSwift

class ContactsModel: Object {
    
    @Persisted var contactName: String = "Name"
    @Persisted var contactPhone: String = "Phone"
    @Persisted var contactEmail: String = "Email"
    @Persisted var contactType: String = "Type"
    @Persisted var contactAvatar: Data?
}

