import UIKit

protocol MainScreenView: AnyObject {
    func showLocationData(_ locationData: LocationData)
    func showInfoDialog(title: String, message: String, canBeCancelled: Bool)
}

protocol MainScreenPreseneterProtocol {
    var view: MainScreenView? { get set }
    func getLocationData()
}

class MainScreenPresenter: MainScreenPreseneterProtocol {
    private let ipAdressManager: IpAdressService
    private let locationService: LocationService
    private let telegramService: TelegramService
    
    weak var view: MainScreenView?

    init(ipAdressManager: IpAdressService,
        locationService: LocationService,
         telegramService: TelegramService) {
        self.ipAdressManager = ipAdressManager
        self.locationService = locationService
        self.telegramService = telegramService
    }
    
    ///It detects your approxiamte location based on ip adress and. It sends it to telegram bot
    func getLocationData() {
        ipAdressManager.getIpAdress { [weak self] result in
            switch result {
            case .success(let ipData):
                self?.locationService.getLocation(by: ipData.ip) { (result) in
                    switch result {
                    case .success(let locationData):
                        self?.telegramService.sendMessageToBot(message: "Approximate location coordinates of the device: \(locationData.loc), city: \(locationData.city), country:\(locationData.country). Ip adress was: \(ipData.ip).")
                        DispatchQueue.main.async {
                            self?.view?.showLocationData(locationData)
                        }
                    case .failure(let error):
                        print("Error when getting location info: \(error)")
                        self?.view?.showInfoDialog(title: "Error occured", message: "Faild to get your location", canBeCancelled: true)
                    }
                }
            case .failure(let error):
                print("Error when getting ip data: \(error)")
                self?.view?.showInfoDialog(title: "Error occured", message: "Faild to get your ip adress", canBeCancelled: true)
            }
        }
    }
}
