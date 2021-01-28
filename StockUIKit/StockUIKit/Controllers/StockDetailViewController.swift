//
//  StockDetailViewController.swift
//  StockUIKit
//
//  Created by William Alvarez on 1/26/21.
//  Copyright © 2021 alvaro.torrez. All rights reserved.
//

import UIKit
import Charts

class StockDetailViewController: UIViewController {

    @IBOutlet weak var detailChart: CandleStickChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailChart.delegate = self

        detailChart.chartDescription?.enabled = false

        detailChart.dragEnabled = false
        detailChart.setScaleEnabled(true)
        detailChart.maxVisibleCount = 200
        detailChart.pinchZoomEnabled = true

        detailChart.legend.horizontalAlignment = .right
        detailChart.legend.verticalAlignment = .top
        detailChart.legend.orientation = .vertical
        detailChart.legend.drawInside = false
        detailChart.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!

        detailChart.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        detailChart.leftAxis.spaceTop = 0.3
        detailChart.leftAxis.spaceBottom = 0.3
        detailChart.leftAxis.axisMinimum = 0

        detailChart.rightAxis.enabled = false

        detailChart.xAxis.labelPosition = .bottom
        detailChart.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        setDataCount(Int(10),range: UInt32(50))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let yVals1 = (0..<count).map { (i) -> CandleChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(40) + mult)
            let high = Double(arc4random_uniform(9) + 8)
            let low = Double(arc4random_uniform(9) + 8)
            let open = Double(arc4random_uniform(6) + 1)
            let close = Double(arc4random_uniform(6) + 1)
            let even = i % 2 == 0
            
            return CandleChartDataEntry(x: Double(i), shadowH: val + high, shadowL: val - low, open: even ? val + open : val - open, close: even ? val - close : val + close, icon: UIImage(named: "icon")!)
        }
        
        let set1 = CandleChartDataSet(entries: yVals1, label: "Data Set")
        set1.axisDependency = .left
        set1.setColor(UIColor(white: 80/255, alpha: 1))
        set1.drawIconsEnabled = false
        set1.shadowColor = .darkGray
        set1.shadowWidth = 0.7
        set1.decreasingColor = .red
        set1.decreasingFilled = true
        set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
        set1.increasingFilled = false
        set1.neutralColor = .blue
        
        let data = CandleChartData(dataSet: set1)
        detailChart.data = data
    }
}

extension StockDetailViewController: ChartViewDelegate {

}
