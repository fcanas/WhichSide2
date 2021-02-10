//
//  ComplicationController.swift
//  Sides WatchKit Extension
//
//  Created by Fabián Cañas on 2/2/21.
//

import ClockKit
import SwiftUI

class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Complication Configuration

    func getComplicationDescriptors(handler: @escaping ([CLKComplicationDescriptor]) -> Void) {
        let descriptors = [
            CLKComplicationDescriptor(identifier: "complication", displayName: "Sides", supportedFamilies: [CLKComplicationFamily.graphicRectangular])
        ]
        
        // Call the handler with the currently supported complication descriptors
        handler(descriptors)
    }
    
    func handleSharedComplicationDescriptors(_ complicationDescriptors: [CLKComplicationDescriptor]) {
        // Do any necessary work to support these newly shared complication descriptors
    }

    // MARK: - Timeline Configuration
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        // Call the handler with the last entry date you can currently provide or nil if you can't support future timelines
        
        handler(Date(timeIntervalSinceNow: 4.hours))
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        // Call the handler with your desired behavior when the device is locked
        handler(.showOnLockScreen)
    }

    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        
        handler(CLKComplicationTimelineEntry(date: Date(), complicationTemplate: CLKComplicationTemplateGraphicRectangularFullView(ComplicationView())))
    }
    
    
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        
        let intoTheFuture = (1..<limit).map({ date.addingTimeInterval(TimeInterval($0).minutes) })
        let entries = intoTheFuture.map( { date -> CLKComplicationTimelineEntry in
                            CLKComplicationTimelineEntry(date: date, complicationTemplate: CLKComplicationTemplateGraphicRectangularFullView(ComplicationView(referenceDate: date)))
            }
        )
        
        handler(entries)
        
    }

    // MARK: - Sample Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        handler(CLKComplicationTemplateGraphicRectangularFullView(ComplicationView()))
    }

}



struct ComplicationController_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            
            CLKComplicationTemplateGraphicExtraLargeCircularView(ComplicationView()).previewContext()
            
            CLKComplicationTemplateGraphicRectangularFullView(ComplicationView()).previewContext(faceColor: .red)
            
            CLKComplicationTemplateGraphicCornerCircularView(ComplicationView())
                .previewContext()
        }
    }
}
