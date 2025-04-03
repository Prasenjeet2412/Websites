//
//  ContentView.swift
//  Websites
//
//  Created by Prasenjeet Pandagale on 02/04/25.
//

import SwiftUI

struct ContentView: View {
    @State private var title: String = ""
    @State private var category: String = "Local Business"
    @State private var subdomain: String = ""
    @State private var city: String = ""
    @State private var phone: String = ""
    @State private var address: String = ""
    @State private var postalCode: String = ""
    @State private var showAddress: Bool = true
    @State private var isSubmitting: Bool = false
    @State private var errorMessage: String?
    
    let categories = ["Local Business", "E-commerce", "Portfolio", "Blog"]
    let countryCodes = ["+91 (IN)", "+1 (US)", "+44 (UK)"]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Let's setup your Website")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                Group {
                    Text("Website Title")
                        .font(.headline)
                    TextField("Enter your Website Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Group {
                    Text("Website Category")
                        .font(.headline)
                    Picker("Select Category", selection: $category) {
                        ForEach(categories, id: \..self) { Text($0) }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                
                Group {
                    Text("Your Free Website Subdomain")
                        .font(.headline)
                    HStack {
                        TextField("Enter Subdomain", text: $subdomain)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text(".websites.co.in")
                            .foregroundColor(.gray)
                    }
                }
                
                Group {
                    Text("City")
                        .font(.headline)
                    TextField("Enter your city", text: $city)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Group {
                    Text("Phone")
                        .font(.headline)
                    HStack {
                        Picker("Code", selection: $phone) {
                            ForEach(countryCodes, id: \..self) { Text($0) }
                        }
                        .pickerStyle(MenuPickerStyle())
                        TextField("Enter phone number", text: $phone)
                            .keyboardType(.phonePad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                
                Group {
                    Text("Address")
                        .font(.headline)
                    TextField("Enter your address", text: $address)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Toggle("Show address on your website", isOn: $showAddress)
                }
                
                Group {
                    Text("Postal Code / Pin Code / Zip Code")
                        .font(.headline)
                    TextField("Enter postal code", text: $postalCode)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button(action: submitForm) {
                    Text("Launch Your Website")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()
        }
    }
    
    func submitForm() {
            isSubmitting = true
            errorMessage = nil
            
            let formData: [String: Any] = [
                "title": title,
                "category": category,
                "subdomain": subdomain,
                "city": city,
                "phone": phone,
                "address": address,
                "postalCode": postalCode,
                "showAddress": showAddress
            ]
            
            APIService.submitForm(data: formData) { result in
                DispatchQueue.main.async {
                    isSubmitting = false
                    switch result {
                    case .success:
                        print("Form submitted successfully!")
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
