func fetchData(completion: @escaping (Result<[Data], Error>) -> Void) {
    let url = URL(string: "https://api.example.com/data")!
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let data = data else {
            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            return
        }
        do {
            let decodedData = try JSONDecoder().decode([Data].self, from: data)
            completion(.success(decodedData))
        } catch let decodingError {
            //Improved Error Handling: Provide more context
            let userInfo = [NSLocalizedDescriptionKey: "JSON Decoding Error", NSLocalizedFailureReasonErrorKey: decodingError.localizedDescription, "originalData": data]
            let customError = NSError(domain: "JSONDecodingErrorDomain", code: 1, userInfo: userInfo)
            completion(.failure(customError))
        }
    }
    task.resume()
}