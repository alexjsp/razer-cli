import Foundation
import ArgumentParser
import librazer

@main
struct RazerCommand: ParsableCommand {

    @Option(help: "The mode to set all devices to.")
    var mode: RazerMode

    @Flag(help: "Whether to output debugging information")
    var debug: Bool = false

    @Option(help: "The color to use when setting devices to a color mode.")
    var color: String?

    mutating func run() throws {
        if mode == .color && color == nil {
            print("You must supply a color with --color when setting mode to color")
            return
        }

        if !debug {
            fclose(stdout)
        }
        let allDevices = getAllRazerDevices()
        let devices = allDevices.devices
        print("Razer device(s) found: ", allDevices.size)

        for i in 0...Int(allDevices.size - 1) {
            let device = devices![i]
            print("Device: ", String(format:"%06X", device.productId))

            switch (mode) {
                case .off:
                    razer_attr_write_scroll_mode_none(device.usbDevice, "1", 0)
                    razer_attr_write_left_mode_none(device.usbDevice, "1", 0)
                    razer_attr_write_right_mode_none(device.usbDevice, "1", 0)
                    razer_attr_write_logo_mode_none(device.usbDevice, "1", 0)
                    razer_mouse_mat_attr_write_mode_none(device.usbDevice, "1", 0)

                case .spectrum:
                    razer_attr_write_scroll_mode_spectrum(device.usbDevice, "1", 0)
                    razer_attr_write_left_mode_spectrum(device.usbDevice, "1", 0)
                    razer_attr_write_right_mode_spectrum(device.usbDevice, "1", 0)
                    razer_attr_write_logo_mode_spectrum(device.usbDevice, "1", 0)
                    razer_mouse_mat_attr_write_mode_spectrum(device.usbDevice, "1", 0)
                case .color:
                    let colorBytes: [Int8] = parseColorString(color!).map { Int8(bitPattern: UInt8($0)) }
                    razer_attr_write_scroll_mode_static(device.usbDevice, colorBytes, 3)
                    razer_attr_write_left_mode_static(device.usbDevice, colorBytes, 3)
                    razer_attr_write_right_mode_static(device.usbDevice, colorBytes, 3)
                    razer_attr_write_logo_mode_static(device.usbDevice, colorBytes, 3)
                    razer_mouse_mat_attr_write_mode_static(device.usbDevice, colorBytes, 3)
            }
        }

        closeAllRazerDevices(allDevices)
    }
}

enum RazerMode: String, ExpressibleByArgument {
    case off, spectrum, color
}

func parseColorString(_ colorString: String) -> [Int] {
    switch (colorString) {
        case "black":
            return [0,0,0]
        case "silver":
            return [192,192,192]
        case "gray":
            return [128,128,128]
        case "white":
            return [255,255,255]
        case "maroon":
            return [128,0,0]
        case "red":
            return [255,0,0]
        case "purple":
            return [128,0,128]
        case "fuchsia":
            return [255,0,255]
        case "green":
            return [0,255,0]
        case "lime":
            return [0,255,0]
        case "olive":
            return [128,128,0]
        case "yellow":
            return [255,255,0]
        case "navy":
            return [0,0,128]
        case "blue":
            return [0,0,255]
        case "teal":
            return [0,128,128]
        case "aqua":
            return [0,255,255]
        case "aliceblue":
            return [240,248,255]
        case "antiquewhite":
            return [250,235,215]
        case "aquamarine":
            return [127,255,212]
        case "azure":
            return [240,255,255]
        case "beige":
            return [245,245,220]
        case "bisque":
            return [255,228,196]
        case "blanchedalmond":
            return [255,235,205]
        case "blueviolet":
            return [138,43,226]
        case "brown":
            return [165,42,42]
        case "burlywood":
            return [222,184,135]
        case "cadetblue":
            return [95,158,160]
        case "chartreuse":
            return [127,255,0]
        case "chocolate":
            return [210,105,30]
        case "coral":
            return [255,127,80]
        case "cornflowerblue":
            return [100,149,237]
        case "cornsilk":
            return [255,248,220]
        case "crimson":
            return [220,20,60]
        case "cyan":
            return [0,255,255]
        case "darkblue":
            return [0,0,139]
        case "darkcyan":
            return [0,139,139]
        case "darkgoldenrod":
            return [184,134,11]
        case "darkgray":
            return [169,169,169]
        case "darkgreen":
            return [0,100,0]
        case "darkgrey":
            return [169,169,169]
        case "darkkhaki":
            return [189,183,107]
        case "darkmagenta":
            return [139,0,139]
        case "darkolivegreen":
            return [85,107,47]
        case "darkorange":
            return [255,140,0]
        case "darkorchid":
            return [153,50,204]
        case "darkred":
            return [139,0,0]
        case "darksalmon":
            return [233,150,122]
        case "darkseagreen":
            return [143,188,143]
        case "darkslateblue":
            return [72,61,139]
        case "darkslategray":
            return [47,79,79]
        case "darkslategrey":
            return [47,79,79]
        case "darkturquoise":
            return [0,206,209]
        case "darkviolet":
            return [148,0,211]
        case "deeppink":
            return [255,20,147]
        case "deepskyblue":
            return [0,191,255]
        case "dimgray":
            return [105,105,105]
        case "dimgrey":
            return [105,105,105]
        case "dodgerblue":
            return [30,144,255]
        case "firebrick":
            return [178,34,34]
        case "floralwhite":
            return [255,250,240]
        case "forestgreen":
            return [34,139,34]
        case "gainsboro":
            return [220,220,220]
        case "ghostwhite":
            return [248,248,255]
        case "gold":
            return [255,215,0]
        case "goldenrod":
            return [218,165,32]
        case "greenyellow":
            return [173,255,47]
        case "grey":
            return [128,128,128]
        case "honeydew":
            return [240,255,240]
        case "hotpink":
            return [255,105,180]
        case "indianred":
            return [205,92,92]
        case "indigo":
            return [75,0,130]
        case "ivory":
            return [255,255,240]
        case "khaki":
            return [240,230,140]
        case "lavender":
            return [230,230,250]
        case "lavenderblush":
            return [255,240,245]
        case "lawngreen":
            return [124,252,0]
        case "lemonchiffon":
            return [255,250,205]
        case "lightblue":
            return [173,216,230]
        case "lightcoral":
            return [240,128,128]
        case "lightcyan":
            return [224,255,255]
        case "lightgoldenrodyellow":
            return [250,250,210]
        case "lightgray":
            return [211,211,211]
        case "lightgreen":
            return [144,238,144]
        case "lightgrey":
            return [211,211,211]
        case "lightpink":
            return [255,182,193]
        case "lightsalmon":
            return [255,160,122]
        case "lightseagreen":
            return [32,178,170]
        case "lightskyblue":
            return [135,206,250]
        case "lightslategray":
            return [119,136,153]
        case "lightslategrey":
            return [119,136,153]
        case "lightsteelblue":
            return [176,196,222]
        case "lightyellow":
            return [255,255,224]
        case "limegreen":
            return [50,205,50]
        case "linen":
            return [250,240,230]
        case "magenta":
            return [255,0,255]
        case "mediumaquamarine":
            return [102,205,170]
        case "mediumblue":
            return [0,0,205]
        case "mediumorchid":
            return [186,85,211]
        case "mediumpurple":
            return [147,112,219]
        case "mediumseagreen":
            return [60,179,113]
        case "mediumslateblue":
            return [123,104,238]
        case "mediumspringgreen":
            return [0,250,154]
        case "mediumturquoise":
            return [72,209,204]
        case "mediumvioletred":
            return [199,21,133]
        case "midnightblue":
            return [25,25,112]
        case "mintcream":
            return [245,255,250]
        case "mistyrose":
            return [255,228,225]
        case "moccasin":
            return [255,228,181]
        case "navajowhite":
            return [255,222,173]
        case "oldlace":
            return [253,245,230]
        case "olivedrab":
            return [107,142,35]
        case "orange":
            return [255,165,0]
        case "orangered":
            return [255,69,0]
        case "orchid":
            return [218,112,214]
        case "palegoldenrod":
            return [238,232,170]
        case "palegreen":
            return [152,251,152]
        case "paleturquoise":
            return [175,238,238]
        case "palevioletred":
            return [219,112,147]
        case "papayawhip":
            return [255,239,213]
        case "peachpuff":
            return [255,218,185]
        case "peru":
            return [205,133,63]
        case "pink":
            return [255,192,203]
        case "plum":
            return [221,160,221]
        case "powderblue":
            return [176,224,230]
        case "rosybrown":
            return [188,143,143]
        case "royalblue":
            return [65,105,225]
        case "saddlebrown":
            return [139,69,19]
        case "salmon":
            return [250,128,114]
        case "sandybrown":
            return [244,164,96]
        case "seagreen":
            return [46,139,87]
        case "seashell":
            return [255,245,238]
        case "sienna":
            return [160,82,45]
        case "skyblue":
            return [135,206,235]
        case "slateblue":
            return [106,90,205]
        case "slategray":
            return [112,128,144]
        case "slategrey":
            return [112,128,144]
        case "snow":
            return [255,250,250]
        case "springgreen":
            return [0,255,127]
        case "steelblue":
            return [70,130,180]
        case "tan":
            return [210,180,140]
        case "thistle":
            return [216,191,216]
        case "tomato":
            return [255,99,71]
        case "turquoise":
            return [64,224,208]
        case "violet":
            return [238,130,238]
        case "wheat":
            return [245,222,179]
        case "whitesmoke":
            return [245,245,245]
        case "yellowgreen":
            return [154,205,50]
        default:
            break
    }

    let hexString = colorString.replacingOccurrences(of: "#", with: "")

    guard hexString.count == 6 else { return [255,255,255] }

    var r: UInt64 = 0
    Scanner(string: String(hexString.prefix(2))).scanHexInt64(&r)

    var g: UInt64 = 0
    let start = hexString.index(hexString.startIndex, offsetBy: 2)
    let end = hexString.index(hexString.endIndex, offsetBy: -2)
    let range = start..<end
    Scanner(string: String(hexString[range])).scanHexInt64(&g)

    var b: UInt64 = 0
    Scanner(string: String(hexString.suffix(2))).scanHexInt64(&b)

    return [Int(r),Int(g),Int(b)]
}
