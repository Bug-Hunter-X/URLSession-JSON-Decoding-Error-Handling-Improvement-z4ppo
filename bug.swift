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
            // Attempt to decode the JSON data here. If it fails, this will throw an error.
            let decodedData = try JSONDecoder().decode([Data].self, from: data)
            completion(.success(decodedData))
        } catch {
            //Handle Decoding Errors Appropriately
            completion(.failure(error))
        }
    }
    task.resume()
}