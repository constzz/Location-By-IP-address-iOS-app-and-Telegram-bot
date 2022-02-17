import Foundation

class LocationService {
        
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession, jsonDecoder: JSONDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func getLocation(
        by ipAdress: IpAdress,
        completionHandler: @escaping ((Result<LocationData, Error>) -> Void)
    ) {
        let dataTask = createDataTask(urlRequest: URLRequest(url: ipAdress.urlForGeoInfo)) {
            (result) in
                completionHandler(result)
        }
        dataTask.resume()
    }
    
    private func createDataTask(
        urlRequest: URLRequest,
        completionHandler: @escaping (Result<LocationData, Error>) -> Void
    ) -> URLSessionDataTask {
        return urlSession.dataTask(with: urlRequest)
            { [weak self] (data, urlResponse, error) in
                if let error = error {
                    completionHandler(.failure(error))
                    return
                }
                guard let data = data else { return }
                guard let locationData = try? self?.jsonDecoder.decode(
                            LocationData.self,
                            from: data
                        ) else {
                    completionHandler(.failure(JsonDecoderError.decodingFailure))
                    return
                }
                completionHandler(.success(locationData))
                
        }
    }
    
    private func formUrlRequest(ipAdress: String) -> URLRequest{
        return URLRequest(url: URL(string: "\(K.BaseUrls.ipInfo)/\(ipAdress)/geo")!)
    }
}

extension Location {
    var latitude: Double {
        return (self.components(separatedBy: ",").first! as NSString).doubleValue
    }
    var longitude: Double {
        return (self.components(separatedBy: ",").last! as NSString).doubleValue
    }
}
