//
//  BasicPartInformationView.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 08.03.22.
//

import SwiftUI
import Charts

struct BasicPartInformationView: View {
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading){
                Text("Part ID: XYZ!")
                    .font(Font.title)
                    .foregroundColor(.white)
                /*Chart(data: [0.1, 0.9, 0.1, 0.5, 0.4, 0.9, 0.1])
                    .chartStyle(
                        LineChartStyle(.quadCurve, lineColor: .white, lineWidth: 5)
                    ).frame(width: geometry.size.width, height: geometry.size.height/5)*/
                
            }.frame(width: geometry.size.width, height: geometry.size.height).background(.blue)
        }.ignoresSafeArea()
    }
}

struct BasicPartInformationView_Previews: PreviewProvider {
    static var previews: some View {
        BasicPartInformationView()
            .previewDevice("iPad Pro (9.7-inch)")
    }
}

extension View {
    func saveAsImage(width: CGFloat, height: CGFloat, _ completion: @escaping (UIImage) -> Void) {
        let size = CGSize(width: width, height: height)
        
        let controller = UIHostingController(rootView: self)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        let image = controller.view.asImage()
        
        completion(image)
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}
