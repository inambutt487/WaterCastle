import Foundation
import CoreLocation

class AddressService {
    static func fetchAddress(for coordinate: CLLocationCoordinate2D, completion: @escaping (Address?) -> Void) {
        let urlString = "http://15.185.247.216/area-management/point_api_ajax/?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)"
        guard let url = URL(string: urlString) else { completion(nil); return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let errorValue = json["error"] as? Bool, !errorValue else { completion(nil); return }
            let newAddress = Address(
                add_id: UUID().uuidString,
                sap_id: nil,
                user_id: nil,
                add_area: json["area_id"] as? Int,
                add_name: json["formatted_address"] as? String,
                add_detail: json["formatted_address"] as? String,
                add_street_name: nil,
                add_latitude: String(coordinate.latitude),
                add_longitude: String(coordinate.longitude),
                add_building: nil,
                add_block: nil,
                add_floor: nil,
                add_google_address: nil,
                add_city: String(describing: json["city_id"] ?? ""),
                add_type: 1,
                add_country: String(describing: json["country_id"] ?? ""),
                route_id: json["route_id"] as? String,
                lable: nil
            )
            completion(newAddress)
        }.resume()
    }
}