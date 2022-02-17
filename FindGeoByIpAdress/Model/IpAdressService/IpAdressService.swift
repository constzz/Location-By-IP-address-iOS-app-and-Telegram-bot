import Foundation

class IpAdressService {
            
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession, jsonDecoder: JSONDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func getIpAdress(completionHandler: @escaping (Result<IpData, Error>) -> Void) {
        let urlRequeust = URLRequest(url: K.BaseUrls.ipAdressProviderUrl)
        let task = createDataTask(urlRequest:  urlRequeust) { (result) in
            completionHandler(result)
        }
        task.resume()
    }
    
    private func createDataTask(
        urlRequest: URLRequest,
        completionHandler: @escaping (Result<IpData, Error>) -> Void
    ) -> URLSessionDataTask {
        return urlSession.dataTask(
            with: K.BaseUrls.ipAdressProviderUrl
        ) { (data, urlResponse, error) in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            guard let data = data else { return }
            guard let ipData = try? JSONDecoder().decode(IpData.self, from: data) else {
                completionHandler(.failure(JsonDecoderError.decodingFailure))
                return
            }
            completionHandler(.success(ipData))
        }
    }
}
