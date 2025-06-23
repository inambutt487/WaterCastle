class StartViewModel: BaseViewModel {
    @Published var showStartButton = false
    
    func fetchCompanySettings() async {
        self.isLoading = true
        let body: [String: Any] = [
            "location_date": "2025-05-01",
            "country_id": "2229"
        ]
        let headers = [
            "Authorization": Constants.API.companySettingsAuthKey
        ]
        let result: Result<CompanySettingsResponse, Error> = await APIService.shared.postRequest(
            endpoint: Constants.API.companySettingsEndpoint,
            body: body,
            headers: headers
        )
        DispatchQueue.main.async {
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
}