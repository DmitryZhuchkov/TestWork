//
//  ViewController.swift
//  TestWork
//
//  Created by Дмитрий Жучков on 28.09.2020.
//
import SwiftUI
import SwiftyJSON
import Alamofire
import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var imageText: UILabel!
    @IBOutlet weak var jsonImage: UIImageView!
    @IBOutlet weak var Massive: UILabel!
    @IBOutlet weak var id: UILabel!
    var data = [Selections]()
    override func viewDidLoad() {
        super.viewDidLoad()
        dowloadJSON()
    }
    func dowloadJSON(){
        AF.request("https://pryaniky.com/static/json/sample.json").responseJSON { response in
            let json = JSON(response.value!)
            let picture = json["data"][1]["data"]["text"].string
            let pictureurl = json["data"][1]["data"]["url"].url
            var n = 0
            repeat {
                let id = json["data"][2]["data"]["variants"][n]["id"].int
                let text = json["data"][2]["data"]["variants"][n]["text"].string
                let datas = Selections(id: String(id!), variant: text!)
                self.data.append(datas)
                n = n + 1
            } while ((json["data"][2]["data"]["variants"][n]["id"].int) != nil)
            for t in 0...(self.data.count - 1) {
                self.Massive.text?.append("ID: " + self.data[t].id + " ")
                self.Massive.text?.append(self.data[t].variant + "\n")
            }
            self.imageText.text = picture
            self.jsonImage.image = UIImage(data: try! Data(contentsOf: pictureurl!))
            
        }

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = ""
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        id.text = "ID: "
    }
}

