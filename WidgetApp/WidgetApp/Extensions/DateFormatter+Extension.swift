//
//  DateFormatter+Extension.swift
//  WidgetApp
//
//  Created by Татьяна Балашенко on 29.09.21.
//

import Foundation

public extension DateFormatter {
    enum Format: String {
        case YYYY_MM_dd_HH_mm_ss        = "yyyy-MM-dd HH:mm:ss"
        case YYYY_MM_dd                 = "yyyy-MM-dd"
        case dd_MM_YYYY_HH_mm_ss        = "dd.MM.yyyy HH:mm:ss"
        case dd_MM_YYYY                 = "dd.MM.yyyy"
        case dd_MM_yyyy_HH_mm           = "dd.MM.yyyy HH:mm"
        case EE                         = "EE"
        case dd_MMMM_yyyy               = "dd MMMM yyyy"
        case dd_MMMM_yyyy1              = "dd MMMM, yyyy"
        case dd_MM_YYYY_slash           = "dd/MM/yyyy"
        case MM_YY                      = "MM/YY"
        case HH_mm                      = "HH:mm"
        case history_card_complat       = "dd/MM/yyyy HH:mm:ss"
        case iso8601                    = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case dd_MMM_yyyy                = "dd MMM yyyy"
        case dd_MMM_yyyy_HH_mm          = "dd MMM yyyy HH:mm"
        case yyyy_MM_dd_HH_mm_ss_slash  = "yyyy/MM/dd HH:mm:ss"
        case yyyy_MM_dd_HH_mm_ss_SSS    = "yyyy/MM/dd HH:mm:ssSSS"
    }
}

public extension DateFormatter {
    static func initwithRuLocale() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Europe/Minsk")
        formatter.locale = Locale(identifier: "ru_RU")
        
        return formatter
    }

    static func initwithRuLocale(formatString:String) -> DateFormatter {
        let formatter = self.initwithRuLocale()
        formatter.dateFormat = formatString
        return formatter
    }
    
    static func dateFormatterFromType(_ format:DateFormatter.Format) -> DateFormatter? {
        let formatString = format.rawValue
        let formatter = DateFormatter.initwithRuLocale(formatString: formatString)
        return formatter
    }
}

public extension DateFormatter {
    static func string(fromDate date: Date, with format: DateFormatter.Format) -> String? {
        guard let formatter = DateFormatter.dateFormatterFromType(format) else { return nil }

        return formatter.string(from: date)
    }
    
    static func date(fromString string:String, with format: DateFormatter.Format) -> Date? {
        guard let formatter = DateFormatter.dateFormatterFromType(format) else { return nil }

        return formatter.date(from: string)
    }
}
