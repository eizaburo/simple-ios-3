//
//  ContactView.swift
//  practice-ios-1
//
//  Created by Eizaburo Tamaki on 2025/08/17.
//

import SwiftUI

struct ContactView: View {
    
    //for title
    @State private var title: String = ""
    @State private var titleEdited: Bool = false
    
    //for email
    @State private var email: String = ""
    @State private var emailEdited: Bool = false
    
    //for message
    @State private var message: String = ""
    @State private var messageEdited: Bool = false
    
    //for alert
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    //submitting
    @State private var isSubmitting: Bool = false
    
    var body: some View {
        VStack {
            //hero
            VStack {
                Text("お問合せフォーム")
                    .foregroundColor(.white)
                Text("お気軽にお問合せ下さい。")
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 120)
            .background(Color.gray)
            
            //form(wrapper)
            ScrollView {
                //form
                VStack(alignment: .leading, spacing: 10) {
                    
                    //title
                    Text("お問合せタイトル")
                    TextField("お問合せタイトル", text: $title)
                        .padding(16)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .onChange(of: title){
                            if(isSubmitting){
                                titleEdited = false
                            }else{
                                titleEdited = true
                            }
                        }
                    if !validateTitle {
                        Text("お問合せタイトルは必須です。")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    //email
                    Text("Email")
                    TextField("Email", text: $email)
                        .padding(16)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .autocapitalization(.none)
                        .onChange(of: email){
                            if(isSubmitting){
                                emailEdited = false
                            }else{
                                emailEdited = true
                            }
                        }
                    
                    if !validateEmail {
                        Text("Emailを正しく入力して下さい。")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    //message
                    Text("お問合せ内容")
                    ZStack {
                        Color.gray.opacity(0.2)
                        TextEditor(text: $message)
                            .frame(height: 100)
                            .padding(8)
                            .background(Color.clear)
                            .scrollContentBackground(.hidden)
                            .cornerRadius(8)
                            .autocapitalization(.none)
                            .onChange(of: message){
                                if(isSubmitting){
                                    messageEdited = false
                                }else{
                                    messageEdited = true
                                }
                            }
                    }
                    .cornerRadius(8)
                    if !validateMessage {
                        Text("お問合せ内容を正しく入力して下さい。")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                    
                    
                    //button
                    Button(action: {
                        
                        //強制的に編集済みへ
                        titleEdited = true
                        emailEdited = true
                        messageEdited = true
                        
                        if validateForm {
                            sendFormData()
                        }
                        
                    }) {
                        Text("送信")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .foregroundColor(.white)
                            .background(isSubmitting ? Color.gray.opacity(0.3) : Color.gray)
                            .cornerRadius(8)
                    }
                    .padding(.top, 30)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("送信完了"), message: Text(alertMessage), dismissButton: .default(Text("OK"),action:{
                            
                            //編集フラグを元に戻す
                            titleEdited = false
                            emailEdited = false
                            messageEdited = false
                            
                            isSubmitting = false
                        }))
                    }
                    .disabled(isSubmitting)
                    
                }
                .padding(30)
            }
            
            //
            Spacer()
        }
    }
    
    //title validation
    var validateTitle: Bool {
        return !titleEdited || !title.isEmpty
    }
    
    //email validation
    var validateEmail: Bool {
        let pattern = #"^[^@\s]+@[^@\s]+\.[^@\s]+$"#
        if !emailEdited || email.range(of: pattern, options: .regularExpression) != nil{
            return true
        }
        return false
    }
    
    //message validation
    var validateMessage: Bool {
        return !messageEdited || (message.count >= 1 && message.count <= 10)
    }
    
    //form validation
    var validateForm: Bool {
        return validateEmail && validateTitle && validateMessage
    }
    
    func sendFormData() {
        
        isSubmitting = true
        
        let url = Env.gasApiUrl
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let bodyData = "title=\(title)&email=\(email)&message=\(message)".data(using: .utf8)
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Error: \(error.localizedDescription)"
                }else if let data = data {
                    if let dataString = String(data: data, encoding: .utf8) {
                        alertMessage = dataString
                    }
                }
                
                //値をリセット
                title = ""
                email = ""
                message = ""
                
                //alert表示
                showAlert = true
            }
        }.resume()
    }
}

#Preview {
    ContactView()
}
