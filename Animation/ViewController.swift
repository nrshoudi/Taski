
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var menuView: UIViewX!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pencilButton: UIButton!
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var clockButton: UIButton!
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var longDateLabel: UILabel!
    @IBOutlet weak var weatherImageIcon: UIImageView!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var tableData: [Model] = []
    var DayWeatherData: DayWeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        Data.getDayAndWeather { (data) in
            if let data = data {
                self.dayLabel.text = data.dayName
                self.longDateLabel.text = data.longDate
                self.weatherImageIcon.image = data.weatherIcon
                self.tempretureLabel.text = data.tempreture
                self.cityLabel.text = data.city
            }
        }
        
        Data.getData { (data) in
            self.tableData = data
            self.tableView.reloadData()
        }
        
        closeMenu()
        setupAnimatedControls()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.dayView.transform = .identity
            self.weatherView.transform = .identity
        }) { (success) in
            
        }
    }
    
    @IBAction func menuTapped(_ sender: FloatingActionButton) {
        UIView.animate(withDuration: 0.3, animations: {
            if self.menuView.transform == .identity {
                self.closeMenu()
            } else {
                self.menuView.transform = .identity
            }
        })
        
        UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            if self.menuView.transform == .identity {
                self.pencilButton.transform = .identity
                self.chatButton.transform = .identity
                self.clockButton.transform = .identity
            }
            })
        
    }
    
    func closeMenu() {
        menuView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        pencilButton.transform = CGAffineTransform(translationX: 0, y: 15)
        chatButton.transform = CGAffineTransform(translationX: 11, y: 11)
        clockButton.transform = CGAffineTransform(translationX: 15, y: 0)
    }
    
    func setupAnimatedControls() {
        dayView.transform = CGAffineTransform(translationX: -dayView.frame.width, y: 0)
        weatherView.transform = CGAffineTransform(translationX: weatherView.frame.width, y: 0)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! TableViewCell
        cell.setup(model: tableData[indexPath.row])
        return cell
    }
}
