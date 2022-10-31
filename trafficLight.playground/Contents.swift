import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class TrafficLight{
    var timer: Timer?
    var count: Int = 0
    var limit: Int = 0
    var lightTimeList: [Int] = [7,4,2]
    enum LightColor{
        case red//(limit: Int)
        case blue
        case yellow
    }
    
    var lightColorRed = LightColor.red
    var lightColorBlue = LightColor.blue
    var lightColorYellow = LightColor.yellow
    
    func start(lightColor: LightColor) {
        switch lightColor {
        case LightColor.red :
            print("信号が赤です")
            limit = lightTimeList[0]
        case LightColor.blue:
            print("信号が青です")
            limit = lightTimeList[1]
        default:
            print("信号が黄です")
            limit = lightTimeList[2]
        }
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(countup),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func countup(){
        count += 1
        print("残り\(limit-count)秒です")
        if limit <= count{
            print("信号が変わります")
            let isCountEnd: Bool = limit == count
            count = 0
            switch lightColor{
            case LightColor.red:
                lightColor = LightColor.blue
            case LightColor.blue:
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

class NextLight{
    let trafficLight = TrafficLight()
    func roop(lightColor: TrafficLight.LightColor){
        print("\(lightColor)")
        trafficLight.start(lightColor: lightColor)
    }
}

let trafficLight = TrafficLight()
var lightColor = TrafficLight.LightColor.red
trafficLight.start(lightColor: lightColor)

