import Foundation

class TelegramService {
    
    private let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    ///Sends the message to bot in telegram bot
    func sendMessageToBot(message: String) {
        let urlRequest = formPostUrlRequest(
            url: K.TelegramBot.urlToSendMessage,
            httpBody: formSendMessagePostData(message: message))
        let dataTask = createDataTask(urlRequest: urlRequest)
        dataTask.resume()
    }
    
    private func formPostUrlRequest(url: URL, httpBody: Data) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = httpBody
        return urlRequest
    }
    
    private func createDataTask(urlRequest: URLRequest) -> URLSessionDataTask {
        return urlSession.dataTask(with: urlRequest) {
            (data, urlRespone, error) in
                guard error == nil else {
                    print(error?.localizedDescription ?? "")
                    return
                }
                if let data = data, let responseDataString = String(data: data, encoding: .utf8) {
                    print("Response: \(responseDataString)")
                }
        }
    }
    
    private func formSendMessagePostData(message: String) -> Data {
        return "\(K.TelegramBot.QueryKey.chatId)=\(K.TelegramBot.chatId)&\(K.TelegramBot.QueryKey.text)=\(message)"
            .data(using: .utf8)!
    }
    
}
