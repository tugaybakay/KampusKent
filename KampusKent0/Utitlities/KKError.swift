//
//  KKError.swift
//  KampusKent0
//
//  Created by MacOS on 17.05.2024.
//

import Foundation

enum KKError: String, Error {
    case emptyUsernamePassword = "Email or Password field is empty! We need to know who you are 😀"
    case incorrectUsernameOrPassword = "Invalid email or password! Please check again."
    case errorFetchingData = "We can not connect to our server! Please check your internet connection."
    case emptyStation = "We need to know where you want to go 🧑‍✈️"
    case stationsSame = "Are you sure that you chose right stations"
}

