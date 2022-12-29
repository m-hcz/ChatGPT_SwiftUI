//
//  MessageView.swift
//  ChatGPT_SwiftUI
//
//  Created by M H on 29/12/2022.
//

import SwiftUI

struct MessageView: View {
	
	let model: MessageModel
	
	var body: some View {
		VStack {
			HStack {
				if model.myMessage {
					Spacer(minLength: 0)
					VStack {
						Spacer()
						Text(model.message)
							.padding(5)
							.background(
								RoundedRectangle(cornerRadius: 10)
									.fill(.blue.opacity(0.2))
							)
					}
				} else {
					VStack {
						Spacer()
						Image(systemName: "brain.head.profile")
							.resizable()
							.scaledToFit()
							.frame(width: 35)
							.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
							.padding(8)
							.background(
								Circle()
									.fill(.black.opacity(0.2))
							)
					}
					VStack {
						Spacer()
						Text(model.message)
							.padding(5)
							.background(
								RoundedRectangle(cornerRadius: 10)
									.fill(.black.opacity(0.2))
							)
					}
					Spacer(minLength: 0)
				}
				
			}
			HStack {
				model.myMessage ? Spacer() : nil
				Text(model.time.formatted(date: .omitted, time: .shortened))
					.font(.caption)
					.foregroundColor(.gray)
				!model.myMessage ? Spacer() : nil
			}
		}
		.padding()
	}
}

struct MessageView_Previews: PreviewProvider {
	
	static let model : MessageModel = MessageModel(message: "Lorem Ipsum is simply dummy", myMessage: true)
	static var previews: some View {
		MessageView(model: model)
	}
}
