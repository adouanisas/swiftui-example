//
//  MonHoroscope .swift
//  LeProto
//
//  Created by Ahmed Adouani on 11/02/2023.
//

import SwiftUI

struct MonHoroscope: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var opData: OpData
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                    .frame(width: 50*UIConstants.scalingFactor, height: 50*UIConstants.scalingFactor)
                    Spacer()
                }.padding(.leading, UIConstants.screenHorizontalPadding)
                
                Text("Mon Horoscope")
                    .appFontH2()
                
            }.frame(height: 57*UIConstants.scalingFactor)
            
            ScrollView {
                ZStack {
                    ExtendScrollViewToAllWidth()
                    VStack(spacing: 0) {
                        ContentScrollableTodayPart1()  .padding(.top, 10)
                        ContentScrollableTodayPart2().padding(.top, 72)
                    }.padding(.bottom, 150)
                }
                .background(
                    Image("Homepage_bg")
                        .resizable()
                        .scaledToFill()
                        .padding(.top, -150)
                        .padding(.bottom, -200)
                )
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
            .modifier(HideScrollIndicators())
        }.background(Color.white)
        
    }
}

private struct ContentScrollableTodayPart1: View {
    var body: some View {
        VStack(spacing: 0) {
            Image("Hompepage-libra")
                .resizable()
                .frame(width: 270, height: 270)
                .padding(.top, 40)
                .padding(.bottom, 46)
            HStack(spacing: 16*UIConstants.scalingFactor) {
                VStack(spacing: 0) {
                    Text("Signe solaire")
                        .appFontH2(16)
                        .frame(height: 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Saggitaire")
                        .appFontBody()
                        .padding(.top, 3)
                        .frame(height: 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(spacing: 0) {
                    Text("Signe lunaire")
                        .appFontH2(16)
                        .frame(height: 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Cancer")
                        .appFontBody()
                        .padding(.top, 3)
                        .frame(height: 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(spacing: 0) {
                    Text("Ascendant")
                        .appFontH2(16)
                        .frame(height: 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Balance")
                        .appFontBody()
                        .padding(.top, 3)
                        .frame(height: 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }.padding(.bottom, 19)
            
            HStack(spacing: 16*UIConstants.scalingFactor) {
                VStack(spacing: 0) {
                    Text("Modalité")
                        .appFontH2(16)
                        .frame(height: 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Cardinale")
                        .appFontBody()
                        .padding(.top, 3)
                        .frame(height: 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(spacing: 0) {
                    Text("Polarité")
                        .appFontH2(16)
                        .frame(height: 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Masculine")
                        .appFontBody()
                        .padding(.top, 3)
                        .frame(height: 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(spacing: 0) {
                    Text("Élement")
                        .appFontH2(16)
                        .frame(height: 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Air")
                        .appFontBody()
                        .padding(.top, 3)
                        .frame(height: 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }.padding(.horizontal, UIConstants.screenHorizontalPadding)
    }
}

private struct ContentScrollableTodayPart2: View {
    
    @State private var currentSubPage = 0
    
    @State var offset: CGPoint = .zero
    
    //5
    let subPageMenuWidths: [CGFloat] = [76.0, 51.0, 101.0, 59.0, 45.0]
    
    let subPageMenuXCoordinates: [CGFloat]
    
    init() {
        var subPageMenuXCoordinates = [CGFloat]()
        
        var X = 0.0
        for index in 0...4 {
            subPageMenuXCoordinates.append((subPageMenuWidths[index]/2.0)+X)
            X += subPageMenuWidths[index]+20.0
        }
        
        self.subPageMenuXCoordinates = subPageMenuXCoordinates
    }
    
    let colorGray2 = Color(UIColor(red: 0.31, green: 0.31, blue: 0.31, alpha: 1))
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color.black.frame(maxWidth: .infinity)
                    .frame(height: 2)
                
                Color.clear.frame(height: 24)
                    .background(
                        Image("makroud")
                            .resizable()
                            .frame(width: 15, height: 24)
                            .offset(x: UIConstants.screenHorizontalPadding+subPageMenuXCoordinates[currentSubPage]-offset.x-7.5/*15/2*/)
                        , alignment: .topLeading
                    )
                    .animation(Animation.linear)
                OffsetObservingScrollView(offset: $offset) {
                    HStack(spacing: 0) {
                        Button {
                            withAnimation {
                                self.currentSubPage = 0
                            }
                        } label: {
                            Text("Quotidien")
                                .appFontBody()
                                .foregroundColor(currentSubPage == 0 ? Color.black: colorGray2)
                        }
                        .frame(width: subPageMenuWidths[0])
                        .padding(.trailing, 20)
                        
                        Button {
                            withAnimation {
                                self.currentSubPage = 1
                            }
                        } label: {
                            Text("Demain")
                                .appFontBody()
                                .foregroundColor(currentSubPage == 1 ? Color.black: colorGray2)
                        }
                        .frame(width: subPageMenuWidths[1])
                        .padding(.trailing, 20)
                        
                        Button {
                            self.currentSubPage = 2
                        } label: {
                            Text("Hebdomadaire")
                                .appFontBody()
                                .foregroundColor(currentSubPage == 2 ? Color.black: colorGray2)
                        }
                        .frame(width: subPageMenuWidths[2])
                        .padding(.trailing, 20)
                        
                        Button {
                            self.currentSubPage = 3
                        } label: {
                            Text("Mensuel")
                                .appFontBody()
                                .foregroundColor(currentSubPage == 3 ? Color.black: colorGray2)
                        }
                        .frame(width: subPageMenuWidths[3])
                        .padding(.trailing, 20)
                        
                        Button {
                            self.currentSubPage = 4
                        } label: {
                            Text("2023")
                                .appFontBody(14)
                                .foregroundColor(currentSubPage == 4 ? Color.black: colorGray2)
                        }.frame(width: subPageMenuWidths[4])
                        
                    }
                }
                .frame(height: 24)
                .padding(.bottom, 40)
                .padding(.leading, 24)
            }
            .frame(height: UIConstants.screenHorizontalPadding)
            .frame(maxWidth: .infinity)
            
            VStack(spacing: 0) {
                PagerView(pageCount: 5, currentIndex: $currentSubPage) {
                    QuotidienSubPage()
                    ZStack {
                        Color.white.opacity(0.1)
                        VStack(spacing: 0) {
                            Text("Demain").appFontMenu(14)
                            Spacer()
                        }
                    }.frame(maxHeight: .infinity)
                    ZStack {
                        Color.white.opacity(0.1)
                        VStack(spacing: 0) {
                            Text("Hebdomadaire").appFontMenu(14)
                            Spacer()
                        }
                    }
                    ZStack {
                        Color.white.opacity(0.1)
                        VStack(spacing: 0) {
                            Text("Mensuel").appFontMenu(14)
                            Spacer()
                        }
                    }
                    ZStack {
                        Color.white.opacity(0.1)
                        VStack(spacing: 0) {
                            Text("2023").appFontMenu(14)
                            Spacer()
                        }
                    }
                }.frame(maxHeight: .infinity)
            }
        }
    }
}


struct QuotidienSubPage: View {
    var body: some View {
        VStack(spacing: 0) {
            QuotidienSubPageTop()
                .padding(.horizontal, UIConstants.screenHorizontalPadding)
            
            CarousselContentView()
                .padding(.top, 24*UIConstants.scalingFactor)
            
            QuotidienSubPageBottom()
                .padding(.top, 24*UIConstants.scalingFactor)
                .padding(.horizontal, UIConstants.screenHorizontalPadding)
            
        }
    }
}

struct QuotidienSubPageTop: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Votre journée")
                    .appFontH2()
                Spacer()
                Text("07 décembre 2022")
                    .foregroundColor(Color(UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1)))
                    .appFontBody()
                    .frame(width: 150*UIConstants.scalingFactor)
                    .padding(.leading, 4*UIConstants.scalingFactor)
            }.frame(height: 24*UIConstants.scalingFactor)
                .padding(.top, 32*UIConstants.scalingFactor)
            
            Text("Personne ne pourra vous reprocher de manquer de suite dans les idées. Vous aurez au contraire beaucoup de ténacité et une telle détermination à réussir vos projets qu'aucun obstacle ne vous paraîtra insurmontable. Vous mènerez votre journée avec lucidité et intelligence.")
                .appFontBody()
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 14*UIConstants.scalingFactor)
            
            Text("Conseils de la journée")
                .appFontH1()
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.top, 56*UIConstants.scalingFactor)
        }
    }
}

struct QuotidienSubPageBottom: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Amour")
                    .appFontH2()
                Spacer()
                ZStack {
                    Color("CustomProgressBarGrayColor")
                        .overlay(
                                    RoundedRectangle(cornerRadius: 1)
                                        .stroke(Color("CustomProgressBarGrayColor"), lineWidth: 1)
                                )
                    Color("CustomProgressBarBlackColor")
                        .overlay(
                                    RoundedRectangle(cornerRadius: 1)
                                        .stroke(Color("CustomProgressBarBlackColor"), lineWidth: 1)
                                )
                        .padding(.trailing, 20)
                }.frame(width: 109*UIConstants.scalingFactor, height: 1)
                Text("82%")
                    .appFontBody()
                    .frame(width: 50*UIConstants.scalingFactor)
                    .padding(.leading, 4)
            }.frame(height: 24*UIConstants.scalingFactor)
                .padding(.top, 32*UIConstants.scalingFactor)
            
            Text("Voilà une Harmonique dans votre Ciel Astral du jour, ami(e)s Balances. Et c'est de très bon augure, puisqu'il s'agit en plus de Neptune, qui vous enverra des ondes positives surtout sur le plan sentimental. Aussi, que vous soyez en couple ou célibataire, vous parviendrez à faire ce que vous avez parfois du mal à faire : exprimer vos sentiments. Et vous constaterez avec plaisir que les retours seront à la hauteur de vos espérances...")
                .appFontBody()
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 14*UIConstants.scalingFactor)
            
            HStack(spacing: 0) {
                Text("Vie professionnelle")
                    .appFontH2()
                Spacer()
                ZStack {
                    Color("CustomProgressBarGrayColor")
                        .overlay(
                                    RoundedRectangle(cornerRadius: 1)
                                        .stroke(Color("CustomProgressBarGrayColor"), lineWidth: 1)
                                )
                    Color("CustomProgressBarBlackColor")
                        .overlay(
                                    RoundedRectangle(cornerRadius: 1)
                                        .stroke(Color("CustomProgressBarBlackColor"), lineWidth: 1)
                                )
                        .padding(.trailing, 0.23*109*UIConstants.scalingFactor)
                }.frame(width: 109*UIConstants.scalingFactor, height: 1)
                Text("77%")
                    .appFontBody()
                    .frame(width: 50*UIConstants.scalingFactor)
                    .padding(.leading, 4*UIConstants.scalingFactor)
            }.frame(height: 24*UIConstants.scalingFactor)
                .padding(.top, 32*UIConstants.scalingFactor)
            
            Text("Une journée fort agréable, pour les natifs qui travaillent. Certains d'entre vous pourraient bénéficier de belles opportunités pour tout ce qui concerne d'éventuels partenariats. Ouvrez grand les oreilles, car certains pourraient se révéler fructueux. Demandeur d'emploi ? C'est une journée au cours de laquelle vous avez tout intérêt à parler de votre situation autour de vous.")
                .appFontBody()
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 14*UIConstants.scalingFactor)
            
            
            HStack(spacing: 0) {
                Text("Santé")
                    .appFontH2()
                Spacer()
                ZStack {
                    Color("CustomProgressBarGrayColor")
                        .overlay(
                                    RoundedRectangle(cornerRadius: 1)
                                        .stroke(Color("CustomProgressBarGrayColor"), lineWidth: 1)
                                )
                    Color("CustomProgressBarBlackColor")
                        .overlay(
                                    RoundedRectangle(cornerRadius: 1)
                                        .stroke(Color("CustomProgressBarBlackColor"), lineWidth: 1)
                                )
                        .padding(.trailing, 0.14*109*UIConstants.scalingFactor)
                }.frame(width: 109*UIConstants.scalingFactor, height: 1)
                Text("86%")
                    .appFontBody()
                    .frame(width: 50*UIConstants.scalingFactor)
                    .padding(.leading, 4*UIConstants.scalingFactor)
            }.frame(height: 24*UIConstants.scalingFactor)
                .padding(.top, 32*UIConstants.scalingFactor)
            
            Text("Votre entourage sera ravi de vous voir avec un beau sourire, ce vendredi. Surtout que certains d'entre vous faisaient grise mine depuis un certain temps déjà. Alors ? Ce n'est pas plus agréable d'être souriant(e) ? Vous constaterez que vous avez tout à y gagner. Après, on vous l'accorde, il ne s'agit pas de se forcer.")
                .appFontBody()
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 14*UIConstants.scalingFactor)
            
        }
    }
}

struct MonHoroscope_Previews: PreviewProvider {
    static var previews: some View {
        MonHoroscope()
    }
}


struct OffsetObservingScrollView<Content: View>: View {
    var axes: Axis.Set = [.horizontal]
    var showsIndicators = true
    @Binding var offset: CGPoint
    @ViewBuilder var content: () -> Content
    
    // The name of our coordinate space doesn't have to be
    // stable between view updates (it just needs to be
    // consistent within this view), so we'll simply use a
    // plain UUID for it:
    private let coordinateSpaceName = UUID()
    
    var body: some View {
        ScrollView(axes, showsIndicators: showsIndicators) {
            PositionObservingView(
                coordinateSpace: .named(coordinateSpaceName),
                position: Binding(
                    get: { offset },
                    set: { newOffset in
                        offset = CGPoint(
                            x: -newOffset.x,
                            y: -newOffset.y
                        )
                        print(offset)
                    }
                ),
                content: content
            )
        }
        .coordinateSpace(name: coordinateSpaceName)
    }
}

struct PositionObservingView<Content: View>: View {
    var coordinateSpace: CoordinateSpace
    @Binding var position: CGPoint
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .background(GeometryReader { geometry in
                Color.clear.preference(
                    key: PreferenceKey.self,
                    value: geometry.frame(in: coordinateSpace).origin
                )
            })
            .onPreferenceChange(PreferenceKey.self) { position in
                self.position = position
            }
    }
}

private extension PositionObservingView {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGPoint { .zero }
        
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
            // No-op
        }
    }
}
