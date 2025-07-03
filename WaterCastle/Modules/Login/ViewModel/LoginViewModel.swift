//
//  LoginViewModel.swift
//  WaterCastle
//
//  Created by Mac on 02/07/2025.
//


import Foundation
import Combine

@MainActor
class LoginViewModel: ObservableObject {
    @Published var phone: String = ""
    @Published var otp: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showOTP: Bool = false
    @Published var loginResponse: LoginResponse?
    @Published var otpResponse: OTPResponse?
    
    // Save auth_key after OTP verification
    func saveAuthKey(_ key: String) {
        Constants.API.companySettingsAuthKey = key
    }
    
    func login(skKey: String) async -> Result<LoginResponse, Error> {
        isLoading = true
        errorMessage = nil
        let request = LoginRequest(
            mobile: "966" + phone,
            language: "en",
            sk_key: skKey,
            country_id: 2229
        )
        let headers = [
            "Authorization": Constants.API.companySettingsAuthKey
        ]
        let result: Result<LoginResponse, Error> = await APIService.shared.postRequest(
            endpoint: "/LoginRegister",
            body: request,
            headers: headers
        )
        isLoading = false
        switch result {
        case .success(let response):
            self.loginResponse = response
            self.showOTP = true
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
        return result
    }
    
    func verifyOTP() async -> Result<OTPResponse, Error> {
        isLoading = true
        errorMessage = nil
        let request = OTPRequest(
            mobile: "966" + phone,
            otp: otp
        )
        let headers = [
            "Authorization": Constants.API.companySettingsAuthKey
        ]
        let result: Result<OTPResponse, Error> = await APIService.shared.postRequest(
            endpoint: Constants.API.verifyOTPEndpoint,
            body: request,
            headers: headers
        )
        isLoading = false
        switch result {
        case .success(let response):
            self.otpResponse = response
            if let user = response.user?.first, let authKey = user.authKey, !authKey.isEmpty {
                saveAuthKey(authKey)
            } else if let token = response.getToken?.auth, !token.isEmpty {
                saveAuthKey(token)
            }
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        }
        return result
    }
}
