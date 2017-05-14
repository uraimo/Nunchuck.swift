/*
   Nunchuck.swift

   Copyright (c) 2017 Umberto Raimondi
   Licensed under the MIT license, as follows:

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.)
*/

import SwiftyGPIO  //Comment this when not using the package manager


public class Nunchuck{
    var i2c: I2CInterface
    let address: Int
    let type: NunchuckType

    public init(_ i2c: I2CInterface, address: Int = 0x52, type: NunchuckType = .Original) {
       self.i2c = i2c
       self.address = address
       self.type = type
       enable(type)
    }
 
 
    public var AccelX: Int {
        var rv = UInt16( dec(i2c.readByte(address, command: 0x02)) ) << 2
        rv |= UInt16( ( dec(i2c.readByte(address, command: 0x05)) & 0xc) >> 2 )   
        return Int(rv)
    }

    public var AccelY: Int {
        var rv = UInt16( dec(i2c.readByte(address, command: 0x03)) ) << 2
        rv |= UInt16( ( dec(i2c.readByte(address, command: 0x05)) & 0x30) >> 4 ) 
        return Int(rv)
    }

    public var AccelZ: Int {
        var rv = UInt16( dec(i2c.readByte(address, command: 0x04)) ) << 2
        rv |= UInt16( ( dec(i2c.readByte(address, command: 0x05)) & 0xc0) >> 6 )     
        return Int(rv)
    }

    public var AnalogX: Int {
        let rv = dec(i2c.readByte(address, command: 0x0))
        return Int(rv)
    }

    public var AnalogY: Int {
        let rv = dec(i2c.readByte(address, command: 0x1))
        return Int(rv)
    }
 
    /// 3= no button pressed, 1=C button only, 2=Z button only, 0= both buttons
    public var Buttons: Int {
        let rv = UInt16( i2c.readByte(address, command: 0x5) & 0x3)     
        return Int(rv)
    }

    public func getAll() -> (AccelX: Int, AccelY: Int, AccelZ: Int, AnalogX: Int, AnalogY: Int, Buttons: Int) {
        return (self.AccelX,self.AccelY,self.AccelZ,self.AnalogX,self.AnalogY,self.Buttons)
    }

    private func enable(_ type: NunchuckType){
        switch type{
            case .Original:
                i2c.writeByte(address, command: 0x40, value: 0)
            case .Knockoff1:
                i2c.writeByte(address, command: 0xF0, value: 0x55)
            case .Knockoff2:
                i2c.writeByte(address, command: 0xFB, value: 0)
        }
    }

    // The bytes read are encoded
    // Not sure if valid for all versions of the controller
    private func dec(_ byte:UInt8) -> UInt16 {
        return UInt16(byte ^ 0x17) + 0x17    
    }

    public enum NunchuckType{
        case Original
        case Knockoff1
        case Knockoff2
    }

}
