//
//  StockDetailsVC.swift
//  ZeusApp
//
//  Created by Macbook Pro 15 on 1/29/20.
//  Copyright © 2020 SamuelFolledo. All rights reserved.
//

import UIKit
import Charts

struct WhyModel {
    let title: String
    let description: String
}

protocol StockDetailProtocol {
    /* parameters here is what the parent class will receive */
    func didUpdateStock(stock: Stock)
}

class StockDetailsVC: UIViewController {
//MARK: Properties
    var user: User!
    var delegate: StockDetailProtocol!
    var stock: Stock!
    lazy var dummyWhyData: [WhyModel] = [
        WhyModel(title: "Because Trump sold all his \(stock.name) shares multiple lines multiple lines", description: "sdjsfj sljfksjkf sjfklsjf "),
        WhyModel(title: "\(stock.name) release an update", description: "Update your app and invest ment"),
        WhyModel(title: "Tesla increase may affect \(stock.name) prices", description: "sdjsfj sljfksjkf sjfklsjf "),
        WhyModel(title: "\(stock.name) raise $5 million on 2nd round", description: "Update your app and invest ment")
    ]
    var dataEntries: [ChartDataEntry] = []
    var time: [Double] = [9,10,11,12,1,2,3,4,5,6]
    //    let timeStamps: [Int] = [9, 10, 11, 12, 1, 2, 3, 4, 5, 6]
    let timeStamps: [String] = ["9:00", "9:05", "9:10", "9:15", "9:20", "9:25", "9:30", "9:35", "9:40", "9:45", "9:50", "9:55", "10:00",  "10:05", "10:10", "10:15", "10:20", "10:25", "10:30", "10:35", "10:40", "10:45", "10:50", "10:55", "11:00", "11:05", "11:10", "11:15", "11:20", "11:25", "11:30", "11:35", "11:40", "11:45",  "11:50", "11:55", "12:00", "12:05", "12:10", "12:15", "12:20", "12:25", "12:30", "12:35", "12:40", "12:45", "12:50", "12:55","1:00", "1:05", "1:10", "1:15", "1:20", "1:25", "1:30", "1:35", "1:40", "1:45", "1:50", "1:55", "2:00", "2:05", "2:10", "2:15", "2:20", "2:25", "2:30", "2:35", "2:40", "2:45", "2:50", "2:55", "3:00", "3:05", "3:10", "3:15", "3:20", "3:25", "3:30", "3:35", "3:40", "3:45", "3:50", "3:55", "4:00", "4:05", "4:10", "4:15", "4:20", "4:25", "4:30", "4:35", "4:40", "4:45", "4:50", "4:55", "5:00", "5:05", "5:10", "5:15", "5:20", "5:25", "5:30", "5:35", "5:40", "5:45", "5:50", "5:55", "6:00"]
    let stockPrices: [Double] = [24.01, 39.77, 0.81, -10.00, -13.00, -25.01, -50.91, 50.21, 64.31, 32.44, 43.09, 99.18, 25.50, 81.90, 79.67, 45.99, 39.87, 89.09, 67.09, 45.88, 103.89, 56.09, 34.98, 45.88, 24.01, 39.77, 0.81, -19.00, 13.00, 25.01, -90.91, 50.21, 64.31, 32.44, 42.09, 99.18, 25.50, 81.90, 74.67, 15.99, 39.87, 9.09, 6.09, 45.08, 13.89, 56.99, 34.98, 45.88,24.01, 39.77, 0.81, -1.00, -15.00, 25.01, -0.91, 51.21, 14.31, 42.44, 41.09, 98.18, 25.50, 81.90, 79.67, 45.99, 39.87, 89.09, 37.09, 42.88, 13.89, 46.99, 31.98, 44.88]
    
//MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pricePercentLabel: UILabel!
    @IBOutlet weak var predictedLabel: UILabel!
    @IBOutlet weak var predictedPercentLabel: UILabel!
    @IBOutlet weak var graphView: LineChartView!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var month3Button: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var year5Button: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var decisionStackView: UIStackView!
    @IBOutlet weak var decisionLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var ceoLabel: UILabel!
    @IBOutlet weak var headquartersLabel: UILabel!
    @IBOutlet weak var followButton_bottomConstraint: NSLayoutConstraint!
    
//MARK: App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
//MARK: Private Methods
    fileprivate func setupViews() {
        if let user = getCurrentUser() {
            self.user = user
            self.followButton.isHidden = false
        } else {
            self.followButton.isHidden = true
        }
        self.view.backgroundColor = SettingsService.mainColor
        self.navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.tintColor = SettingsService.grayColor //button color
        navigationController?.setStatusBarColor(backgroundColor: kMAINCOLOR)
        self.title = stock.name
        setupFollowButton()
        setupTopLabels()
        populateWhyStackView()
        setupDescriptionView()
        setupChartView()
        setupScrollView()
    }
    
    fileprivate func setupDescriptionView() {
        ceoLabel.text = "\(stock.name) CEO"
        volumeLabel.text = "1,400,398"
        headquartersLabel.text = "San Francisco, CA"
    }
    
    fileprivate func populateWhyStackView() {
        for whyData in dummyWhyData { //add to decision stack a view with title and decriptions each news from whyData'
            var label = UILabel(frame: .zero)
            label.numberOfLines = 0
            SettingsService.isMediumLabel(label: &label)
            label.text = "• " + whyData.title
            decisionStackView.addArrangedSubview(label)
        }
    }
    
    fileprivate func setupTopLabels() {
        SettingsService.isMediumLabel(label: &priceLabel, color: SettingsService.greenColor, weight: .semibold)
        SettingsService.isSmallLabel(label: &pricePercentLabel, color: SettingsService.greenColor, weight: .semibold)
        SettingsService.isMediumLabel(label: &predictedLabel, color: SettingsService.whiteColor, weight: .semibold)
        SettingsService.isSmallLabel(label: &predictedPercentLabel, color: SettingsService.whiteColor, weight: .semibold)
        priceLabel.text = "$1078.32"
        pricePercentLabel.text = "+25%"
        predictedLabel.text = "$1203.98"
        predictedPercentLabel.text = "+34%"
    }
    
    fileprivate func setupFollowButton() {
        followButton.isWhiteButton()
        updateFollowButton(senderIsButton: false)
    }
    
///update follow button. If it's a setup, then update title. If it's not a setup, delete or create stock in user
    fileprivate func updateFollowButton(senderIsButton: Bool) {
        var buttonTitle: String = ""
        let index = user.getStockIndex(stock: stock) //get index of stock
        if stock.isFollowing { //stock is in favorites
            buttonTitle = "Unfollow"
            if senderIsButton { //if it is not initial set up, meaning user tapped on button
                user.createNewStock(stock: stock)
            }
        } else {
            buttonTitle = "Follow"
            if senderIsButton { //if user tapped unfollow button
                user.deleteStock(index)
            }
        }
        followButton.setTitle(buttonTitle, for: .normal)
    }
    
//MARK: IBActions
    @IBAction func followButtonTapped(_ sender: UIButton) {
        stock.isFollowing = !stock.isFollowing
        updateFollowButton(senderIsButton: true)
    }
    
    @IBAction func dateButtonTap(_ sender: UIButton) {
        if sender == dayButton {
            print("Day 1")
        } else if sender == weekButton {
            print("Week 1")
        }
        else if sender == monthButton {
            print("Month 1")
        }
        else if sender == month3Button {
            print("Month 3")
        }
        else if sender == yearButton {
            print("Year 1")
        }
        else if sender == year5Button {
            print("Year 5")
        }
        else if sender == allButton {
            print("All")
        }
    }
    
//MARK: Helpers
}

//MARK: Extensions
/// Line Chart Codes
extension StockDetailsVC {
    fileprivate func setupChartView() {
        setupLineChartView()
        populateChartData()
        dayButton.isDateButton()
        weekButton.isDateButton()
        monthButton.isDateButton()
        month3Button.isDateButton()
        yearButton.isDateButton()
        year5Button.isDateButton()
        allButton.isDateButton()
    }
}

//MARK: ScrollView Delegate
extension StockDetailsVC: UIScrollViewDelegate {
    fileprivate func setupScrollView() {
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //make button appear whenever the navController's large title disappears, and it disappears when scrollView.contentOffset.y > 10
        if scrollView.contentOffset.y <= scrollView.verticalOffsetForTop + 10 {
            if followButton_bottomConstraint.constant < 60 {
                self.followButton_bottomConstraint.constant += 10
            }
        } else { //if large title disappears, make the button show up
            if followButton_bottomConstraint.constant > -10 { //if not at the position we want, keep decrementing the constraint
                self.followButton_bottomConstraint.constant -= 10
            }
        }
    }
}

extension StockDetailsVC: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry:
     ChartDataEntry, highlight: Highlight) { //selected chart
        print("Time: ",entry.x, " = Cost: ", entry.y)
        priceLabel.text = "$" + String(entry.y)
    }
    
    fileprivate func setupLineChartView() {
        self.graphView.delegate = self
        self.graphView.doubleTapToZoomEnabled = false
        self.graphView.legend.enabled = false //remove legend label
        self.graphView.pinchZoomEnabled = false
//        graphView.leftAxis.drawZeroLineEnabled = false
        self.graphView.xAxis.axisMaxLabels = timeStamps.count
        self.graphView.xAxis.setLabelCount(timeStamps.count, force: true)
        self.graphView.xAxis.labelPosition = .bottom //put xAxis labels at the bottom, default at top
        self.graphView.xAxis.drawLabelsEnabled = false //bottom axis labels
        self.graphView.xAxis.drawGridLinesEnabled = false //remove graph's vertical line
//        self.graphView.xAxis.drawAxisLineEnabled = false
//        self.graphView.leftAxis.drawLabelsEnabled = false
        self.graphView.leftAxis.labelTextColor = SettingsService.whiteColor
        self.graphView.leftAxis.drawAxisLineEnabled = false
        self.graphView.rightAxis.drawLabelsEnabled = false
        self.graphView.rightAxis.drawAxisLineEnabled = false
        print(graphView.xAxis.entries)
    }
    
    fileprivate func populateChartData() {
        //get stocks
        struct StockPrice {
            var timestamp: Int
            var price: Double
        }
        var prices: [StockPrice] = []
        for i in 0..<stockPrices.count {
            let stockPrice = StockPrice(timestamp: i+9, price: self.stockPrices[i])
            prices.append(stockPrice)
        }
        
        graphView.xAxis.axisMaximum = Double(timeStamps.count)
        var chartEntries: [ChartDataEntry] = []
        var xStrings: [String] = []
        //        let sortedStockPrices = prices.sorted { (s1: Stock, s2: Stock) -> Bool in
        //            return s1.
        //        }
        let sortedentriesData = prices.sorted { (s1: StockPrice, s2: StockPrice) -> Bool in //sort by timestamp
            return s1.timestamp < s2.timestamp
        }
        for (i, price) in sortedentriesData.enumerated() {
            let newStock = ChartDataEntry(x: Double(i), y: price.price)
            chartEntries.append(newStock) //populate chartEntries - yAxis
            //            let dateFormatter = DateFormatter()
            //            dateFormatter.timeStyle = .medium
            //            dateFormatter.dateStyle = .none
            //            xStrings.append("\(dateFormatter.string(from: Date.init(timeIntervalSince1970: TimeInterval(entry.timestamp))))") //populate xAxis
            xStrings.append(String(price.timestamp))
        }
        let set: LineChartDataSet = LineChartDataSet(entries: chartEntries, label: nil)
        set.drawValuesEnabled = false //remove values in the chart
        //        let mainColor = NSUIColor.init().SettingsService.mainColor
        //        set.setColor(NSUIC)
        set.setColor(NSUIColor.white, alpha: CGFloat(1))
        set.circleColors = [NSUIColor.init(cgColor: SettingsService.grayColor.cgColor)]
        set.circleRadius = 2
        set.mode = LineChartDataSet.Mode.linear
        let data: LineChartData = LineChartData(dataSet: set)
        //        self.graphView.xAxis.labelRotationAngle = -90 //tilts label
        //        self.graphView.xAxis.valueFormatter = DefaultAxisValueFormatter(block: { (index, axis) -> String in
        //            print("Index = \(index) --- Axis \(axis)")
        //            return String(self.timeStamps[Int(index)])
        //        })
        self.graphView.xAxis.valueFormatter = DefaultAxisValueFormatter(block: { (index, axis) -> String in
            //            print("Axis = \(axis?.axisMaxLabels)")
            return String(self.timeStamps[Int(index)]) //goes out of index if changed
        })
        graphView.data = data
    }
}
