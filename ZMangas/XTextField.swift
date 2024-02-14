//  XTextField.swift

import SwiftUI

struct XTextField: View {
    let title: String?
    let placeholder: String
    @Binding var text: String
//    var validator: (String) -> String = Validators.shared.isEmpty
    @State private var errorMsg = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            if let title {
                Text(title)
                    .font(.headline)
                    .padding(.leading, 10)
            }
            HStack {
                TextField(placeholder, text: $text)
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark")
                        .symbolVariant(.fill)
                        .symbolVariant(.circle)
                }
                .buttonStyle(.plain)
                .opacity(text.isEmpty ? 0 : 0.5)
            }
            .padding(10)
            .background {
                Color(white: 0.95)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .fill(.red)
                    .opacity(errorMsg.isEmpty ? 0 : 1)
            }
//            if !errorMsg.isEmpty {
//                Text("\(lbl.capitalized) \(errorMsg).")
//                    .bold()
//                    .font(.caption)
//                    .padding(.leading, 10)
//                    .foregroundStyle(.red)
//                    .opacity(errorMsg.isEmpty ? 0 : 1)
//                    .transition(.opacity)
//            }
        }
        .animation(.default, value: errorMsg)
//        .onChange(of: text, initial: true) {
//            errorMsg = validator(text)
//            print("errorMsg: \(errorMsg)")
//        }
        
    }
}

#Preview {
    XTextField(title: "Nombre", placeholder: "Escribe", text: .constant("Miguel"))
        .padding()
}
