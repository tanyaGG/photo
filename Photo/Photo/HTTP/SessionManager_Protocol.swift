import Foundation
import Alamofire

protocol SessionManager_Protocol {
    func request(_ request: URLRequestConvertible, completionHandler: @escaping (AFDataResponse<Data>) -> Void)
}

extension Session: SessionManager_Protocol {
    func request(_ request: URLRequestConvertible, completionHandler: @escaping (AFDataResponse<Data>) -> Void) {
        self.request(request).responseData(completionHandler: completionHandler)
    }
}
