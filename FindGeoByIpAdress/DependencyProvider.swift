import Foundation

struct DependencyProvider {
    private static var jsonDecoder: JSONDecoder {
        return JSONDecoder()
    }
    private static var urlSession: URLSession {
        return URLSession(configuration: .default)
    }
    private static var telegramService: TelegramService {
        return TelegramService(urlSession: urlSession)
    }
    private static var locationManager: LocationService {
        return LocationService(urlSession: urlSession, jsonDecoder: jsonDecoder)
    }
    private static var ipAdressManager: IpAdressService {
        return IpAdressService(urlSession: urlSession, jsonDecoder: jsonDecoder)
    }
    static var mainScreenViewController: MainScreenViewController {
        let mainScreenPresenter = MainScreenPresenter(ipAdressManager: ipAdressManager, locationService: locationManager, telegramService: telegramService)
        let mainScreenViewController = MainScreenViewController(mainScreenPresenter: mainScreenPresenter)

        return mainScreenViewController
    }
}
