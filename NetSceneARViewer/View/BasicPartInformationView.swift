//
//  BasicPartInformationView.swift
//  NetSceneARViewer
//
//  Created by Taha Moujtahid on 08.03.22.
//

import SwiftUI
import SwiftUICharts

struct BasicPartInformationView: View {
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .leading){
                Text("PartID: SEGMENT_15")
                    .font(Font.largeTitle).bold()
                    .foregroundColor(.white)
                    .padding()
                LineChartView(data: [8,23,54,32,12,37,7,23,43], title: "Temperatur Level").padding()
            }.frame(width: geometry.size.width, height: geometry.size.height)
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
