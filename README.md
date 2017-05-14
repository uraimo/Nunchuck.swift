# Nunchuck.swift

*A Swift library for the Wii Nunchuck Controller*

<p>
<img src="https://img.shields.io/badge/os-linux-green.svg?style=flat" alt="Linux-only" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Swift 3 compatible" /></a>
<a href="https://raw.githubusercontent.com/uraimo/Nunchuck.swift/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>
 
![Nunchuck connector](https://github.com/uraimo/Nunchuck.swift/raw/master/nunchuck.png)

# Summary

This library reads accelerometer, joystick and button values from a Wii nunchuck controller connected via I2C to you board.

## Hardware Details

There are a few cheap clones of this controller on the market, and they differ from the original for the initialization sequence required to enable the controller. 
The few defaults provided should cover most of the available models.

The controller requires 3.3V to work but should be 5V tolerant, and you'll likely need an adapter for the proprietary connector, to make the various pins easier to access. I was using an ICSP adapter for Olimex boards, but as long as you can connect stuff to it (e.g. Dupont female connectors), every adapter will work.

If you want to tinker with the controller via terminal, its I2C address is 0x52 (not decimal, like many guides report).  

## Usage
  
To initialize the `Nunchuck` class of this library you'll need an `I2CInterface` instance from SwiftyGPIO, and you'll need to specify the controller type if it's not original (try all the enums until you find one that works). Optionally, an I2C address can also be specified for non-standard controllers.

```
import SwiftyGPIO
import Nunchuck
import Foundation

let i2cs = SwiftyGPIO.hardwareI2Cs(for:.RaspberryPi2)!
let i2c = i2cs[1]

let mp = Nunchuck(i2c, type: .Knockoff1)
```

The values read from the controller (accelerometer values, analog joystick position and buttons status) can be read as single properties:

```
public var AccelX: Int
public var AccelY: Int
public var AccelZ: Int
public var AnalogX: Int
public var AnalogY: Int
public var Buttons: Int
```

Or all in one go, calling the `getAll()` method:

```
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
```



## Supported Boards

Every board supported by [SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO): RaspberryPis, BeagleBones, C.H.I.P., etc...

To use this library, you'll need a Linux ARM board with Swift 3.x.

The example below will use a RaspberryPi 2 board but you can easily modify the example to use one the other supported boards, a full working demo projects for the RaspberryPi2 is available in the `Examples` directory.


## Installation

Please refer to the [SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO) readme for Swift installation instructions.

Once your board runs Swift, if your version support the Swift Package Manager, you can simply add this library as a dependency of your project and compile with `swift build`:

```swift
  let package = Package(
      name: "MyProject",
      dependencies: [
        .Package(url: "https://github.com/uraimo/Nunchuck.swift.git", majorVersion: 1),
      ]
  ) 
```

The directory `Examples` contains sample projects that uses SPM, compile it and run the sample with `./.build/debug/TestNunchuck`.

If SPM is not supported, you'll need to manually download the library and its dependencies: 

    wget https://raw.githubusercontent.com/uraimo/Nunchuck.swift/master/Sources/Nunchuck.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/SwiftyGPIO.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/Presets.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/I2C.swift https://raw.githubusercontent.com/uraimo/SwiftyGPIO/master/Sources/SunXi.swift  

And once all the files have been downloaded, create an additional file that will contain the code of your application (e.g. main.swift). When your code is ready, compile it with:

    swiftc *.swift

The compiler will create a **main** executable.

