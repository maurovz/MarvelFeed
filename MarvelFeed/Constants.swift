import Foundation

struct Constants {
  // NOTE: For demo purposes
  private static let timestamp = "ts2020"
  private static let publicKey = "0c5a611113f2aa779e8988bb6a0e8447"
  private static let baseURL = "https://gateway.marvel.com:443/v1/public/characters?"
  private static let hash = "cb0c0b92b46b5a48de738ca8d92470e6"
  private static let params = "limit=100&"

  static let url = URL(string: "\(baseURL)\(params)&ts=\(timestamp)&apikey=\(publicKey)&hash=\(hash)")!
}
