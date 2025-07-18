import Foundation
import CoreLocation

class AddAddressViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var error: String?
    
    func confirmAddress(coordinate: CLLocationCoordinate2D, completion: @escaping (Address?) -> Void) {
        isLoading = true
        error = nil
        AddressService.fetchAddress(for: coordinate) { address in
            DispatchQueue.main.async {
                self.isLoading = false
                if let address = address {
                    var addresses = LocalDatabase.loadAddresses() ?? []
                    addresses.append(address)
                    LocalDatabase.saveAddresses(addresses)
                    LocalDatabase.saveHomeAddress(address)
                    completion(address)
                } else {
                    self.error = "Failed to fetch address from API."
                    completion(nil)
                }
            }
        }
    }
}