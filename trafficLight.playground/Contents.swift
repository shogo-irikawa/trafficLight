import UIKit
import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class TrafficLight{
    var timer: Timer?
    var count: Int = 0
    var lightColor: String = ""
    var limit: Int = 0
    var lightTimeList: [Int] = [7,4,2]
    func start(lightColor: String){
        self.lightColor = lightColor//self.lightColorとしないといけない
//       while totalCount <= 5//ここで繰り返してしまうとtimerが重複してしまう。さらにinvalidateは1つを残して消滅
            switch lightColor {
            case "red":
                print("信号が赤です")
                limit = lightTimeList[0]
            case "blue":
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
    }//func start閉じる
    
    @objc func countup(){//引数は渡せれない。(シンタックシュガー勉強しよう)
//間違い⇨ @objc func countup(lightColor: String){
        count += 1
        print("残り\(limit-count)秒です")
        if limit <= count{
            print("信号が変わります")
            let countEnd: Bool = limit == count
            count = 0
            switch lightColor{
            case "red":
                self.lightColor = "blue" //なんでself必要??
            case "blue":
                self.lightColor = "yellow"
            default:
                self.lightColor = "red"
            }
            timer?.invalidate()
            if countEnd == true{
                let nextLight = NextLight()
                nextLight.roop(lightColor: self.lightColor)
            }
        }
    }
}

class NextLight{
    let trafficLight = TrafficLight()
    func roop(lightColor: String){
        print("\(lightColor)")//確認用
        trafficLight.start(lightColor: lightColor)
    }
}

let lightColor: String = "red"
let trafficLight = TrafficLight()
trafficLight.start(lightColor: lightColor)

