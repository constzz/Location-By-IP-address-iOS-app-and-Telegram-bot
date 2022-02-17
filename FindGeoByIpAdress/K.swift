import Foundation

struct K {
    struct BaseUrls {
        static let ipAdressProviderUrl = URL(string: "https://api.ipify.org/?format=json")!
        static let telegramApi = "https://api.telegram.org"
        static let ipInfo = "https://ipinfo.io"
    }
    struct TelegramBot {
        static let chatId = "" //Insert your chat id here
        static let botToken = "5047203831:AAEgWQ9feZ5TEb1vG0YC5RJ5NK-_Ly_wKzc"
        static let urlToSendMessage = URL(string: "\(BaseUrls.telegramApi)/bot\(botToken)/sendMessage")!
        struct QueryKey {
            static let chatId = "chat_id"
            static let text = "text"
        }
    }
    struct GeolocationService {
        func getUrlForGeolocationInfo(ipAdress: String) -> URL {
            return URL(string: "https://ipinfo.io/\(ipAdress)/geo")!
        }
    }
}
