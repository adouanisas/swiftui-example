//
//  TextValuesPicker.swift
//  LeProto
//
//  Created by Ahmed Adouani on 04/02/2023.
//

import SwiftUI
import UIKit

struct TextValuesPicker: UIViewRepresentable {
    @Binding var dataArray : [String]
    @Binding var selectedValue: String
    var textSize: CGFloat = 18.6*UIConstants.scalingFactor
    var itemHeight: CGFloat = 18.6*1.7*UIConstants.scalingFactor
    var itemWidth: CGFloat = 101*UIConstants.scalingFactor
    var isBold = true
    
    //makeCoordinator()
    func makeCoordinator() -> TextValuesPicker.Coordinator {
        return TextValuesPicker.Coordinator(self, textSize: textSize, itemHeight: itemHeight, itemWidth: itemWidth, isBold: isBold)
    }

    //makeUIView(context:)
    func makeUIView(context: UIViewRepresentableContext<TextValuesPicker>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        picker.selectRow(dataArray.firstIndex(of: selectedValue) ?? 0, inComponent: 0, animated:true)
        return picker
    }

    //updateUIView(_:context:)
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<TextValuesPicker>) {
    }

    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        
        var textSize: CGFloat
        var itemHeight: CGFloat
        var itemWidth: CGFloat
        var isBold: Bool
        var parent: TextValuesPicker
        init(_ pickerView: TextValuesPicker, textSize: CGFloat, itemHeight: CGFloat, itemWidth: CGFloat, isBold: Bool) {
            self.parent = pickerView
            self.textSize = textSize
            self.itemHeight = itemHeight
            self.itemWidth = itemWidth
            self.isBold = isBold
        }
        
        // Number Of Rows In Component 0:
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return parent.dataArray.count
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            1
        }
        
        //Width for component:
        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return itemWidth
        }

        //Row height:
        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return itemHeight
        }

        //View for Row
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {

            if #available(iOS 14.0, *) {
                  let height: CGFloat = 0.5
                  for subview in pickerView.subviews {
                    /* smaller than the row height plus 20 point, such as 40 + 20 = 60*/
                    if subview.frame.size.height < itemHeight {
                      if subview.subviews.isEmpty {
                        let topLineView = UIView()
                        topLineView.frame = CGRect(x: 0.0, y: 0.0, width: subview.frame.size.width, height: height)
                        topLineView.backgroundColor = .lightGray
                        subview.addSubview(topLineView)
                        let bottomLineView = UIView()
                        bottomLineView.frame = CGRect(x: 0.0, y: subview.frame.size.height - height, width: subview.frame.size.width, height: height)
                        bottomLineView.backgroundColor = .lightGray
                        subview.addSubview(bottomLineView)
                      }
                    }
                    subview.backgroundColor = .clear
                  }
                }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: textSize+2))

            let pickerLabel = UILabel(frame: view.bounds)

            pickerLabel.text = parent.dataArray[row]

            pickerLabel.adjustsFontSizeToFitWidth = true
            pickerLabel.textAlignment = .center
            pickerLabel.lineBreakMode = .byWordWrapping
            pickerLabel.numberOfLines = 0
            if isBold {
                pickerLabel.appFontH1Bold(textSize)
            } else {
                pickerLabel.appFontH1(textSize)
            }
            view.addSubview(pickerLabel)
            return view
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            parent.selectedValue = parent.dataArray[row]
        }
    }
}


struct TextValuesPicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private struct ContentView: View {
    @State var selectedArray = [
                        "C’est compliqué",
                        "00  :  00", "00  :  30",
                        "01  :  00", "01  :  30",
                        "02  :  00", "02  :  30",
                        "03  :  00", "03  :  30",
                        "04  :  00", "04  :  30",
                        "05  :  00", "05  :  30",
                        "06  :  00", "06  :  30",
                        "07  :  00", "07  :  30",
                        "08  :  00", "08  :  30",
                        "09  :  00", "09  :  30",
                        "10  :  00", "10  :  30",
                        "11  :  00", "11  :  30",
                        "12  :  00", "12  :  30",
                        "13  :  00", "13  :  30",
                        "14  :  00", "14  :  30",
                        "15  :  00", "15  :  30",
                        "16  :  00", "16  :  30",
                        "17  :  00", "17  :  30",
                        "18  :  00", "18  :  30",
                        "19  :  00", "19  :  30",
                        "20  :  00", "20  :  30",
                        "21  :  00", "21  :  30",
                        "22  :  00", "22  :  30",
                        "23  :  00", "23  :  30",
    ] // 1

    @State var selectedSituation = "C’est compliqué" // 2
    
    var body: some View {
        VStack(spacing: 0) {
            Text(selectedSituation)
            TextValuesPicker(dataArray: $selectedArray, selectedValue: $selectedSituation)
                .frame(width: 101*UIConstants.scalingFactor, height: 224*UIConstants.scalingFactor)
        }
        
    }
}
