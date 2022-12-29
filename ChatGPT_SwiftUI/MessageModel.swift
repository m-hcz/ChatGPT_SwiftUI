//
//  MessageModel.swift
//  ChatGPT_SwiftUI
//
//  Created by M H on 29/12/2022.
//

import Foundation

struct MessageModel: Hashable {
	var id = UUID().uuidString
	var message: String
	var myMessage: Bool
	var time: Date = Date()
}
