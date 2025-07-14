//
//  StartViewModel.swift
//  WaterCastle
//
//  Created by Mac on 23/06/2025.
//

import Foundation


class StartViewModel: BaseViewModel {
    @Published var showStartButton = false
    
    @MainActor
    func fetchCompanySettings() async {
        self.isLoading = true
        let request = CompanySettingsRequest(location_date: "2025-05-01", country_id: "2229")
        let headers = [
            "Authorization": Constants.API.companySettingsAuthKeyDefault
        ]
     
        let result: Result<CompanySettingsResponse, Error> = await APIService.shared.postRequest(
            endpoint: Constants.API.companySettingsEndpoint,
            body: request,
            headers: headers
        )
        
        self.isLoading = false
        switch result {
        case .success(let decoded):
            CompanySettingsManager.shared.settings = decoded.rows
            LocalDatabase.saveCompanySettings(decoded.rows)
            self.showStartButton = true
        case .failure(let error):
            self.handleError(error)
        }
    }

}
