//
//  ViewController.swift
//  TrendingEvent
//
//  Created by Luong Ngoc Thuyet on 6/25/21.
//  Copyright © 2021 thuyetln. All rights reserved.
//

import UIKit
import Alamofire

enum Direction {
    case up
    case down
}

class ViewController: UIViewController {
    
    var selectedCountry = 241
    var foundCharacters = ""
    var items: [ItemTrending] = []
    var itemTrendingSelected: ItemTrending?
    var toolBar: UIToolbar!
    var picker: UIPickerView!
    
    private var direction: Direction = .down
    private var lastContentOffset: CGFloat = 0
    
    @IBOutlet weak var countryStackView: UIStackView!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var alpha2CountryLB: UILabel!
    @IBOutlet weak var dateTimeLB: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var noDataLB: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData(fromCountry: allCountries[selectedCountry].alpha2)
    }
    
    private func setupUI() {
        title = "Top Trending"
        
        noDataLB.isHidden = true
        
        setupTableView()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd/MM/yyyy"
        dateTimeLB.text = dateFormatter.string(from: date)
        
        countryImage.image = UIImage(named: "vn")
        alpha2CountryLB.text = "VN"
        
        countryStackView.setOnClickListener {
            self.showPicker()
        }
        
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "TrendingItemCell", bundle: nil), forCellReuseIdentifier: "TrendingItem")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchData(fromCountry: String) {
        activityIndicator.isHidden = false
        TrendingService().fetchAllItem(fromUrl: "https://trends.google.com/trends/trendingsearches/daily/rss?geo=\(fromCountry)") {
            [weak self] in
            self?.items = $1
            DispatchQueue.main.async {
                if let items = self?.items, items.isEmpty {
                    self?.noDataLB.isHidden = false
                    self?.tableView.isHidden = true
                    self?.activityIndicator.isHidden = true
                } else {
                    self?.activityIndicator.isHidden = true
                    self?.noDataLB.isHidden = true
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                }
            }
        }
        
    }
    
    @IBAction func reloadData(_ sender: UIBarButtonItem) {
        items.removeAll()
        tableView.reloadData()
        fetchData(fromCountry: allCountries[selectedCountry].alpha2)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showVideoYoutube") {
            if let view = segue.destination as? ShowVideoYoutubeController {
                view.itemTrending = self.itemTrendingSelected
                view.alpha2Code = self.alpha2CountryLB.text
            }
        }
    }
    
    
    private func showPicker() {
        if let p = picker, (self.view.subviews.contains(p)) { return }
        picker = UIPickerView(frame: CGRect(x: 0, y: self.view.bounds.height - 300, width: self.view.bounds.width, height: 300))
        picker.backgroundColor = .white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.delegate = self
        picker.dataSource = self
        picker.selectRow(selectedCountry, inComponent: 0, animated: true)
        
        self.view.addSubview(picker)
        
        toolBar = UIToolbar(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        
        toolBar.items = [
                        UIBarButtonItem.init(title: "Huỷ", style: .done, target: self, action: #selector(onCancelButtonTapped)),
                        UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
                        UIBarButtonItem.init(title: "Hoàn tất", style: .done, target: self, action: #selector(onDoneButtonTapped))
        ]

        self.view.addSubview(toolBar)
        
        picker.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        toolBar.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        
        UIView.animate(withDuration: 0.3) {
            self.picker.transform = .identity
            self.toolBar.transform = .identity
        }
    }
    
    
    @objc func onDoneButtonTapped() {
        selectedCountry = picker.selectedRow(inComponent: 0)
        countryImage.image = UIImage(named: allCountries[selectedCountry].image)
        alpha2CountryLB.text = allCountries[selectedCountry].alpha2
        
        UIView.animate(withDuration: 0.3, animations: {
            self.picker.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            self.toolBar.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
        }) { _ in
            self.toolBar.removeFromSuperview()
            self.picker.removeFromSuperview()
            self.items.removeAll()
            self.tableView.reloadData()
            self.fetchData(fromCountry: allCountries[self.selectedCountry].alpha2)
        }
    }
    
    
    @objc func onCancelButtonTapped() {
        UIView.animate(withDuration: 0.3, animations: {
               self.picker.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
               self.toolBar.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
           }) { _ in
               self.toolBar.removeFromSuperview()
               self.picker.removeFromSuperview()
           }
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingItem", for: indexPath) as! TrendingItemCell
        cell.setCell(item: items[indexPath.row]);
//        cell.alpha = 0
//     
//        cell.transform = direction == .down ? CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height) : CGAffineTransform(translationX: 0, y: -cell.frame.height)
//        
//        UIView.animate(withDuration: 0.3) {
//            cell.alpha = 1
//            cell.transform = .identity
//        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemTrendingSelected = items[indexPath.row]
        self.performSegue(withIdentifier: "showVideoYoutube", sender: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (lastContentOffset > scrollView.contentOffset.y) {
            direction = .up
        }
       else if (lastContentOffset < scrollView.contentOffset.y) {
            direction = .down
        }

        lastContentOffset = scrollView.contentOffset.y
    }
}

extension ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCountries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allCountries[row].name
    }
    
}
