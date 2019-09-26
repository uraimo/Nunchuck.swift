import SwiftyGPIO
import Nunchuck
import Foundation

let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi2)!
let i2c = i2cs[1]

let mp = Nunchuck(i2c, type: .Knockoff1)

while(true){
    let (ax,ay,az,jx,jy,b) = mp.getAll()
    print("Accelerometer - x:\(ax),y:\(ay),z:\(az)")
    print("Analog Joystick - x:\(jx),y:\(jy)")
    switch b {
        case 0:
            print("Buttons: Both pressed")
        case 1:
            print("Buttons: C pressed")
        case 2:
            print("Buttons: Z pressed")
        default:
            print("Buttons: None pressed")
    }
    sleep(1)
}
