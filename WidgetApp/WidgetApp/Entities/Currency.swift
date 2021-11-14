//
//  Currency.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import Foundation

public struct Currency: Hashable {
    public static let BYN = Currency(string: "933")
    public static let USD = Currency(string: "840")
    public static let EUR = Currency(string: "978")
    public static let RUB = Currency(string: "643")
    public static let RUR = Currency(string: "810")

    public var code: String = ""
    public var iso: String = ""
    public var symbol: String?
    public var fraction: Int = 2
    public var imageName: String?
    
    var isEmpty: Bool { return self.code.isEmpty }

    public init(string: String? = "") {
        self = Currency.currency(forString: string)
    }
}

extension Currency: Equatable {
    public static func == (l: Currency, r: Currency) -> Bool {
        return (l.code == r.code)
    }
}

extension Currency {
    public init(_ code: String, _ iso: String, _ symbol: String? = nil, _ fraction: Int = 2) {
        self.code = code
        self.iso = iso
        self.imageName = self.iso.lowercased()
        self.symbol = symbol
        self.fraction = fraction
    }
        
    static private func currency(forString string:String?) -> Currency {
        let string = string ?? ""
        return allCurrencies.first { ($0.code == string) || ($0.iso == string) } ?? Currency("", "")
    }
    
    static var allCurrencies : [Currency] =
        [
            Currency("974", "BYR", "Br", 0),
            Currency("978", "EUR", "€"),
            Currency("840", "USD", "$"),
            Currency("643", "RUB", "\u{20BD}"),
            Currency("810", "RUR", "\u{20BD}"),
            Currency("933", "BYN", "Br"),
            Currency("276", "DEM"),
            Currency("4", "AFA"),
            Currency("8", "ALL", "L"),
            Currency("12", "DZD", "د.,ج"),
            Currency("20", "ADP"),
            Currency("31", "AZM"),
            Currency("32", "ARS", "$"),
            Currency("36", "AUD", "$"),
            Currency("40", "ATS"),
            Currency("44", "BSD", "$"),
            Currency("48", "BHD"),
            Currency("50", "BDT"),
            Currency("51", "AMD", "֏"),
            Currency("52", "BBD"),
            Currency("56", "BEF"),
            Currency("60", "BMD"),
            Currency("64", "BTN"),
            Currency("68", "BOB"),
            Currency("72", "BWP"),
            Currency("84", "BZD"),
            Currency("90", "SBD"),
            Currency("96", "BND"),
            Currency("100", "BGL"),
            Currency("104", "MMK"),
            Currency("108", "BIF", nil, 0),
            Currency("112", "BYB"),
            Currency("116", "KHR"),
            Currency("124", "CAD", "$"),
            Currency("132", "CVE"),
            Currency("136", "KYD"),
            Currency("144", "LKR"),
            Currency("152", "CLP", nil, 0),
            Currency("156", "CNY", "¥"),
            Currency("170", "COP"),
            Currency("174", "KMF", nil, 0),
            Currency("188", "CRC"),
            Currency("191", "HRK"),
            Currency("192", "CUP"),
            Currency("196", "CYP"),
            Currency("203", "CZK", "Kč"),
            Currency("208", "DKK", "kr"),
            Currency("214", "DOP"),
            Currency("218", "ECS"),
            Currency("222", "SVC"),
            Currency("230", "ETB"),
            Currency("232", "ERN"),
            Currency("233", "EEK"),
            Currency("238", "FKP"),
            Currency("242", "FJD"),
            Currency("246", "FIM"),
            Currency("250", "FRF"),
            Currency("262", "DJF", nil, 0),
            Currency("270", "GMD"),
            Currency("288", "GHC"),
            Currency("292", "GIP"),
            Currency("300", "GRD"),
            Currency("320", "GTQ"),
            Currency("324", "GNF", nil, 0),
            Currency("328", "GYD"),
            Currency("332", "HTG"),
            Currency("340", "HNL"),
            Currency("344", "HKD", "$"),
            Currency("348", "HUF", "Ft"),
            Currency("352", "ISK", "kr", 0),
            Currency("356", "INR", "₹"),
            Currency("360", "IDR"),
            Currency("364", "IRR", "﷼"),
            Currency("368", "IQD", nil, 3),
            Currency("372", "IEP"),
            Currency("376", "ILS"),
            Currency("380", "ITL"),
            Currency("388", "JMD"),
            Currency("392", "JPY", "¥", 0),
            Currency("398", "KZT", "₸"),
            Currency("400", "JOD", nil, 3),
            Currency("404", "KES"),
            Currency("408", "KPW"),
            Currency("410", "KRW", "₩", 0),
            Currency("414", "KWD", "\u{062F}.\u{0643}", 3),
            Currency("417", "KGS", "с"),
            Currency("418", "LAK"),
            Currency("422", "LBP"),
            Currency("426", "LSL"),
            Currency("428", "LVL"),
            Currency("430", "LRD"),
            Currency("434", "LYD", nil, 3),
            Currency("440", "LTL"),
            Currency("442", "LUF"),
            Currency("446", "MOP"),
            Currency("450", "MGF"),
            Currency("454", "MWK"),
            Currency("458", "MYR"),
            Currency("462", "MVR"),
            Currency("470", "MTL"),
            Currency("478", "MRO"),
            Currency("480", "MUR"),
            Currency("484", "MXN"),
            Currency("496", "MNT"),
            Currency("498", "MDL", "L"),
            Currency("504", "MAD"),
            Currency("508", "MZM"),
            Currency("512", "OMR", nil, 3),
            Currency("516", "NAD"),
            Currency("524", "NPR"),
            Currency("528", "NLG"),
            Currency("532", "ANG"),
            Currency("533", "AWG"),
            Currency("548", "VUV", nil, 0),
            Currency("554", "NZD", "$"),
            Currency("558", "NIO"),
            Currency("566", "NGN"),
            Currency("578", "NOK", "kr"),
            Currency("586", "PKR"),
            Currency("590", "PAB"),
            Currency("598", "PGK"),
            Currency("600", "PYG"),
            Currency("604", "PEN"),
            Currency("608", "PHP"),
            Currency("620", "PTE"),
            Currency("624", "GWP"),
            Currency("626", "TPE"),
            Currency("634", "QAR"),
            Currency("642", "ROL"),
            Currency("646", "RWF", nil, 0),
            Currency("654", "SHP"),
            Currency("678", "STD"),
            Currency("682", "SAR"),
            Currency("690", "SCR"),
            Currency("694", "SLL"),
            Currency("702", "SGD", "$"),
            Currency("703", "SKK"),
            Currency("704", "VND", nil, 0),
            Currency("705", "SIT"),
            Currency("706", "SOS"),
            Currency("710", "ZAR","R"),
            Currency("716", "ZWD"),
            Currency("724", "ESP"),
            Currency("736", "SDD"),
            Currency("740", "SRG"),
            Currency("748", "SZL"),
            Currency("752", "SEK", "kr"),
            Currency("756", "CHF", "₣"),
            Currency("760", "SYP"),
            Currency("762", "TJR"),
            Currency("764", "THB"),
            Currency("776", "TOP"),
            Currency("780", "TTD"),
            Currency("784", "AED"),
            Currency("788", "TND", nil, 3),
            Currency("792", "TRL"),
            Currency("795", "TMM"),
            Currency("800", "UGX"),
            Currency("807", "MKD"),
            Currency("818", "EGP"),
            Currency("826", "GBP", "£"),
            Currency("834", "TZS"),
            Currency("858", "UYU"),
            Currency("860", "UZS", "so’m"),
            Currency("862", "VEB"),
            Currency("882", "WST"),
            Currency("886", "YER"),
            Currency("891", "YUM"),
            Currency("894", "ZMK"),
            Currency("901", "TWD"),
            Currency("950", "XAF", nil, 0),
            Currency("951", "XCD"),
            Currency("952", "XOF", nil, 0),
            Currency("953", "XPF", nil, 0),
            Currency("960", "XDR"),
            Currency("972", "TJS", "с.,"),
            Currency("973", "AOA"),
            Currency("975", "BGN", "лв"),
            Currency("976", "CDF"),
            Currency("977", "BAM"),
            Currency("980", "UAH", "₴"),
            Currency("981", "GEL", "\u{20BE}"),
            Currency("985", "PLN", "zł"),
            Currency("986", "BRL", "$"),
            Currency("954", "XEU"),
            Currency("987", "BRK"),
            Currency("971", "AFN"),
            Currency("728", "SSP"),
            Currency("931", "CUC"),
            Currency("932", "ZWL", "Z$"),
            Currency("934", "TMT", "m"),
            Currency("936", "GHS"),
            Currency("937", "VEF"),
            Currency("938", "SDG"),
            Currency("940", "UYI"),
            Currency("941", "RSD", "din"),
            Currency("943", "MZN"),
            Currency("944", "AZN", "\u{20BC}"),
            Currency("946", "RON"),
            Currency("947", "CHE"),
            Currency("948", "CHW"),
            Currency("949", "TRY", "₺"),
            Currency("968", "SRD"),
            Currency("969", "MGA", nil, 1),
            Currency("970", "COU"),
            Currency("979", "MXV"),
            Currency("984", "BOV"),
            Currency("990", "CLF"),
            Currency("997", "USN", "$"),
            Currency("998", "USS", "$")
        ]
}
