//
//  ContentView.swift
//  SignUpForm
//
//  Created by Peter Friese on 27.12.21.
//

import SwiftUI

// MARK: - View
struct SignUpFormScreen: View {
  @StateObject private var viewModel = SignUpFormViewModel()
  
  var body: some View {
    Form {
      // Username
      Section {
        TextField("Username", text: $viewModel.username)
          .autocapitalization(.none)
          .disableAutocorrection(true)
        
        // remove this later?
        Button("Check if username is available") {
          viewModel.isUsernameAvailable(username: viewModel.username)
        }
      } footer: {
        Text(viewModel.usernameMessage)
          .foregroundColor(.red)
      }
      
      // Password
      Section {
        SecureField("Password", text: $viewModel.password)
        SecureField("Repeat password", text: $viewModel.passwordConfirmation)
      } footer: {
        VStack(alignment: .leading) {
          ProgressView(value: viewModel.passwordStrengthValue, total: 1)
//            .foregroundColor(viewModel.passwordStrengthColor)
            .tint(viewModel.passwordStrengthColor)
            .progressViewStyle(.linear)
          Text(viewModel.passwordMessage)
            .foregroundColor(.red)
        }
      }
      
      // Submit button
      Section {
        Button("Sign up") {
          print("Signing up as \(viewModel.username)")
        }
        .disabled(!viewModel.isValid)
      }
    }
  }
}

// MARK: - Preview
struct SignUpForm_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SignUpFormScreen()
        .navigationTitle("Sign up")
    }
  }
}