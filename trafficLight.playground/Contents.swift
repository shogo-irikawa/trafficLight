import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class TrafficLight{
    var timer: Timer?
    var count: Int = 0
    var limit: Int = 0
    var lightTimeList: [Int] = [7,4,2]
    enum LightColor {
        case red
        case blue
        case yellow
        
        var durationTime: Int{
            switch self{
            case .red: return 7
            case .blue: return 4
            case .yellow: return 2
            }
        }
    }
    
    var lightColorRed = LightColor.red
    var lightColorBlue = LightColor.blue
    var lightColorYellow = LightColor.yellow
    
    func start(lightColor: LightColor) {
        switch lightColor {
        case .red :
            print("信号が赤です")
            let type: LightColor = .red
            limit = type.durationTime//lightTimeList[0]
        case .blue:
            print("信号が青です")
            let type: LightColor = .blue
            limit = type.durationTime//lightTimeList[0]
        default:
            print("信号が黄です")
            let type: LightColor = .yellow
            limit = type.durationTime//lightTimeList[0]
        }
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(countup),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func countup() {
        count += 1
        print("残り\(limit-count)秒です")
        if limit <= count {
            print("信号が変わります")
            let isCountEnd: Bool = limit == count
            count = 0
            switch lightColor {
            case .red:
                lightColor = LightColor.blue
            case .blue:
                lightColor = LightColor.yellow
            default:
                lightColor = LightColor.red
            }
            timer?.invalidate()
            if isCountEnd {
                let nextLight = NextLight()
                nextLight.roop(lightColor: lightColor)
            }
        }
    }
}

class NextLight {
    let trafficLight = TrafficLight()
    func roop(lightColor: TrafficLight.LightColor) {
        print("\(lightColor)")
        trafficLight.start(lightColor: lightColor)
    }
}

let trafficLight = TrafficLight()
var lightColor = TrafficLight.LightColor.red
trafficLight.start(lightColor: lightColor)

