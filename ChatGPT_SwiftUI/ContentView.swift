//
//  ContentView.swift
//  ChatGPT_SwiftUI
//
//  Created by M H on 29/12/2022.
//

import SwiftUI
import OpenAISwift

class ChatGPTViewModel: ObservableObject {
	init () {}
	
	private var client: OpenAISwift?
	
	func setup() {
		client = OpenAISwift(authToken: "")
	}
	
	func send(text: String, completion: @escaping (String) -> ()) {
		client?.sendCompletion(with: text, maxTokens: 1000, completionHandler: { result in
			switch result {
				case .success(let model):
					let output = model.choices.first?.text ?? ""
					completion(output)
				case .failure:
					break
			}
		})
	}
}


struct ContentView: View {
	
	@ObservedObject var vm = ChatGPTViewModel()
	@State var text = ""
	@State var models = [MessageModel]()
	
	var body: some View {
		
		ScrollViewReader { reader in
			VStack {
				Image("gpt")
					.resizable()
					.scaledToFit()
					.frame(width: 150)
				//				Text("ChatGTP")
				//					.font(.title)
				//					.bold()
				//					.foregroundColor(.blue)
				
				Divider()
				
				ScrollView {
					VStack {
						ForEach(models, id: \.self) { model in
							withAnimation {
								MessageView(model: model)
							}
						}
					}.id("ChatScrollView")
				}
				.onChange(of: models) { _ in
					withAnimation {
						reader.scrollTo("ChatScrollView", anchor: .bottom)
					}
				}
				Spacer()
				
				
				HStack {
					TextField("Type here...", text: $text, axis: .vertical)
						.padding()
					
					Button("SEND") {
						send()
					}
					.padding(.trailing)
				}
				.background(
					RoundedRectangle(cornerRadius: 10)
						.fill(.blue.opacity(0.2))
				)
				
				.padding(.horizontal)
				.padding(.vertical, 3)
				
				
			}
			.onAppear {
				vm.setup()
			}
		}
	}
	
	func send() {
		guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {return}
		
		models.append(MessageModel(message: text.trimmingCharacters(in: .whitespaces), myMessage: true))
		
		models.append(MessageModel(message: "...", myMessage: false))
		
		vm.send(text: text) { message in
			models.removeLast()
			models.append(MessageModel(message: message.trimmingCharacters(in: .whitespaces), myMessage: false))
		}
		
		text = ""
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
