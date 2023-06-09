import Foundation
import Alamofire
import SwiftyJSON

final class APIService {
    static let shared = APIService()
    
    typealias ChatGPTResult = (Message) -> Void
    typealias DallaBannerResult = (Any) -> Void
    typealias DallaRoomListResult = (Any) -> Void
    typealias RequestResult = (Result<Data, Error>) -> Void
    typealias ResponseResult = (Result<Response, Error>) -> Void
    
    
    let mock: [DallaBannerInfo] = [
        DallaBannerInfo(memNick: "하나", title: "하나제목", imageBackground: "https://s.pstatic.net/static/www/mobile/edit/20230422/cropImg_728x360_124104332765696105.jpeg", badgeSpecial: true),
        DallaBannerInfo(memNick: "둘", title: "둘제목", imageBackground: "https://s.pstatic.net/static/www/mobile/edit/20230422/cropImg_728x360_124104265093256215.jpeg", badgeSpecial: false),
        DallaBannerInfo(memNick: "셋", title: "셋제목", imageBackground: "https://s.pstatic.net/dthumb.phinf/?src=%22https%3A%2F%2Fsports-phinf.pstatic.net%2F20230423_163%2F16822610444117scsF_PNG%2F%25BD%25BA%25C5%25A9%25B8%25B0%25BC%25A6_2023-04-23_%25BF%25C0%25C8%25C4_11.43.51.png%22&type=nf728_360", badgeSpecial: false),
        DallaBannerInfo(memNick: "넷", title: "넷제목", imageBackground: "https://s.pstatic.net/dthumb.phinf/?src=%22https%3A%2F%2Fsports-phinf.pstatic.net%2F20230423_273%2F1682236731250zQknt_JPEG%2F%25C3%25D6%25C0%25BA%25BF%25EC%25B4%25AB%25B9%25B0.jpg%22&type=nf464_260", badgeSpecial: true),
        DallaBannerInfo(memNick: "다섯", title: "다섯제목", imageBackground: "https://s.pstatic.net/dthumb.phinf/?src=%22https%3A%2F%2Fs.pstatic.net%2Fpost.phinf%2FMjAyMzA0MThfMjU5%2FMDAxNjgxNzk2MjA5OTg2.JDfy8iZ2z1uFEdMpj28cunfu5Qi9ZS2EFYfQEwTXrksg.6xWtd5WgmMRZ5MbJQwYX9gmvMHRqZ_uGfQpMCmPO2xsg.PNG%2FIA6kbE2Yj1TTuy35BCm_NyGmtVio.jpg%3Ftype%3Df339_222_q90%22&type=nf340_228", badgeSpecial: true),
        DallaBannerInfo(memNick: "여섯", title: "여섯제목", imageBackground: "https://s.pstatic.net/dthumb.phinf/?src=%22https%3A%2F%2Fs.pstatic.net%2Fpost.phinf%2FMjAyMzA0MjFfMTg3%2FMDAxNjgyMDM4Mzg1MDA0.fRDFU5HOmhFStaEXAGa8idzceKExNR3Uz69uyr-TwLsg.5XVurh48fh8wa-JotzFGojzuzBEhFqwaKEqPfKFvRAMg.PNG%2FIBgvmMbyleTqUwNimVkz4mDRm5bw.jpg%3Ftype%3Df339_222_q90%22&type=nf340_228", badgeSpecial: false)
    ]
    
    private var session = URLSession(configuration: .default)
    
    private enum NetworkError: Error {
        case unauthorized
        case requestTimeout
        case noData
        case unexpectedData
        case badRequest
        case notFound
        case unknownError
       
        var errorMessage: String {
            switch self {
            case .unauthorized:
                return "인증 정보가 잘못되었습니다."
            case .requestTimeout:
                return "응답 시간이 초과하였습니다."
            case .noData:
                return "연결 중 오류가 발생했습니다. - 데이터 없음"
            case .unexpectedData:
                return "연결 중 오류가 발생했습니다. - 잘못된 데이터 수신"
            case .badRequest:
                return "연결 중 오류가 발생했습니다. - 잘못된 데이터 송신"
            case .notFound:
                return "연결 중 오류가 발생했습니다. - 잘못된 API 주소"
            case .unknownError:
                return "알 수 없는 오류"
            }
        }
    }
    
    private enum DefaultSettings {
        static let serverUrl = "https://api.openai.com"                         // API server Url
        static let endPoint = "/v1/chat/completions"                        // API endpoint url
        static let model = "gpt-3.5-turbo"                                  // 사용할 GPT 모델
        static let authorizationMethod = AuthMethod.bearer                  // 사용할 인증 방식
        static let method = "POST"                                          // request method
        
        static let tokenLimit = 500                                          // 응답의 최대 토큰 수
    }
    
    private enum AuthMethod {
        case bearer
        case none
    }
    
    private var isLoading = false
    
    
    /// 주어진 Auth 방식으로 헤더 생성
    private func makeHeader(authMethod: AuthMethod, key: String) -> [String : String] {
        var result = ["Content-Type": "application/json"]
        
        
        switch authMethod {
        case .bearer:
            result["Authorization"] = "Bearer \(key)"
        case _:
            break
        }
        
        return result
    }
    
    
    /// URLRequest 생성
    private func makeDataRequest(
        serverUrl: String       = DefaultSettings.serverUrl,
        endpoint: String        = DefaultSettings.endPoint,
        method: String          = DefaultSettings.method,
        authMethod: AuthMethod  = DefaultSettings.authorizationMethod,
        authKey: String,
        bodyData: [String: Any]
    ) -> URLRequest? {
        let url = URL(string: serverUrl + endpoint)
        
        var request = URLRequest(url: url!)
        
        request.httpMethod = method
        request.allHTTPHeaderFields = makeHeader(authMethod: authMethod, key: authKey)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: bodyData)
        else {
            return nil }
        
        request.httpBody = jsonData
        
        return request
    }
    
    private func handleNetworkError(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 400:
            return NetworkError.badRequest
        case 401:
            return NetworkError.unauthorized
        case 404:
            return NetworkError.notFound
        default:
            return NetworkError.unknownError
        }
    }
    
    private func makeDataTask(
        with request: URLRequest,
        completion: @escaping RequestResult
    ) -> URLSessionDataTask {
        let dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
               !(200...299).contains(statusCode)
            {
                completion(.failure( self.handleNetworkError(statusCode: statusCode) ))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            completion(.success(data))
        }
        return dataTask
    }
    
//    private func makeDataTasks(request: URLRequest?, completion: @escaping ResponseResult) -> URLSessionDataTask? {
//
//    }
    
    private func makeDataTasks(request: URLRequest? = nil,
                               data: [String: Any] = [:],
                               completion: @escaping ResponseResult
    ) -> URLSessionDataTask? {
        guard !isLoading else {
            return nil
        }
        
        guard request != nil,
              let request = makeDataRequest(authKey: APIKey.value, bodyData: data)
        else {
            completion(.failure(NetworkError.badRequest))
            return nil
        }
        
        isLoading = true
        
        let dataTask = makeDataTask(with: request) { result in
            defer { self.isLoading = false }
            
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } catch let DecodingError.dataCorrupted(context) {
                    print("하나: \(context)")
                    completion( .failure(NetworkError.unexpectedData))
                } catch let DecodingError.keyNotFound(key, context) {
                    print("둘Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion( .failure(NetworkError.unexpectedData))
                } catch let DecodingError.valueNotFound(value, context) {
                    print("셋Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion( .failure(NetworkError.unexpectedData))
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("넷Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion( .failure(NetworkError.unexpectedData))
                } catch {
                    print("다섯error: ", error)
                    completion( .failure(NetworkError.unexpectedData))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    if let error = error as? NetworkError {
                        completion( .failure(error) )
                    } else {
                        completion( .failure(error) )
                    }
                }
            }
        }

        dataTask.resume()
        
        return dataTask
    }
}

extension APIService {
    private func makeGPTRequestBody(data: [Message]) -> [String: Any] {
        var messages: [[String: String]] = []
        
        //body 생성
        for (index, datum) in data.enumerated() {
            guard datum.role != "error" else { continue }
            if index + 1 < data.count && data[index + 1].role == "error" { continue }
            
            let tmpArr: [String : String] = ["role" : datum.role, "content" : datum.content]
            
            messages.append(tmpArr)
        }
        
        let jsonBody: [String : Any] = [
            "model": DefaultSettings.model,
            "messages": messages,
            "max_tokens": DefaultSettings.tokenLimit
        ]
        
        return jsonBody
    }
    
    private func makeDallaRequest() -> URLRequest? {
        return makeDataRequest(
            serverUrl: "http://61.80.148.23:3000/", endpoint: "RqBannerList", method: "GET", authMethod: .none, authKey: "", bodyData: ["pageNo": 2]
        )
    }
    
    private func makeAFHeader() -> HTTPHeaders {
        var result = HTTPHeaders()
        
        result.add(name: "Content-Type", value: "application/json")
        return result
    }
    
    private func makeDallaRequestUsingAlarmofire() {
        
    }
    
}

// 외부와 연결되는 곳
extension APIService {
    func sendChat(text: [Message], completion: @escaping ChatGPTResult) -> URLSessionDataTask? {
        
        let body = makeGPTRequestBody(data: text)
        
        //요청 송신
        return makeDataTasks(data: body) { result in
            switch result {
            case .success(let data):
                guard let message = data.choices.first?.message else {
                    completion( Message(role: "error", content: NetworkError.unexpectedData.errorMessage) )
                    return
                }

//                DispatchQueue.main.async {
                    completion(message)
//                }
            case .failure(let error):
                completion( Message(role: "error", content: error.localizedDescription) )
            }
        }
    }
    
    func getDallaBannerData(completion: @escaping DallaBannerResult) {
        AF.request("http://61.80.148.23:3000/RqBannerList",
                          method: .get,
                          parameters: ["pageNo": 2],
                          headers: makeAFHeader())
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                var result: [DallaBannerInfo] = []
                let data = JSON(data)
                data["BannerList"].forEach { (string, data) in
                    result.append(
                        DallaBannerInfo.init(
                            memNick: data["mem_nick"].stringValue,
                            title: data["title"].stringValue,
                            imageBackground: data["image_background"].stringValue,
                            badgeSpecial: data["badgeSpecial"].intValue == 1
                        )
                    )
                }
                
                result.append(contentsOf: self.mock)
                
                completion(result)
                
                break
            case .failure(let error):
                completion(error)
                break
            }
        }
    }
    
    func getDallaRoomListData(completion: @escaping DallaRoomListResult) {
        AF.request("http://61.80.148.23:3000/RqRoomList",
                          method: .post,
                          parameters: ["pageNo": 2],
                          headers: makeAFHeader())
        .validate(statusCode: 200..<300)
        .responseJSON { response in
            switch response.result {
            case .success(let data):
                var result: [DallaBannerInfo] = []
                let data = JSON(data)
                data["BannerList"].forEach { (string, data) in
                    result.append(
                        DallaBannerInfo.init(
                            memNick: data["mem_nick"].stringValue,
                            title: data["title"].stringValue,
                            imageBackground: data["image_background"].stringValue,
                            badgeSpecial: data["badgeSpecial"].intValue == 1
                        )
                    )
                }
                
                completion(result)
                break
            case .failure(let error):
                completion(error)
                break
            }
        }
    }
    
    func cancelRequest() {
        session.invalidateAndCancel()
        session = URLSession(configuration: .default)
    }
    
    
}
