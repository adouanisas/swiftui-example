//
//  TodayPage.swift
//  LeProto
//
//  Created by Ahmed Adouani on 06/02/2023.
//

import SwiftUI

struct TodayPage: View {
    
    @EnvironmentObject var opData: OpData
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button(action: {
                        print("action left")
                    }) {
                        Image("HomePage_Group11").resizable()
                            .frame(width: 50*UIConstants.scalingFactor, height: 48*UIConstants.scalingFactor)
                    }.padding(.leading, UIConstants.screenHorizontalPadding)
                    
                    Spacer()
                    Button(action: {
                        print("action right")
                    }) {
                        Image("Homepage_Frame9").resizable()
                            .frame(width: 50*UIConstants.scalingFactor, height: 50*UIConstants.scalingFactor)
                    }.padding(.trailing, UIConstants.screenHorizontalPadding)
                }.frame(height: 57*UIConstants.scalingFactor)
                ScrollView {
                    ZStack {
                        ExtendScrollViewToAllWidth()
                        VStack(spacing: 0) {
                            ContentScrollableTodayPart1()  .padding(.top, 10)
                            ContentScrollableTodayPart2() .padding(.top, 56)
                            ContentScrollableTodayPart3().padding(.top, 56).padding(.bottom, 24)
                        }.padding(.bottom, 100)
                        .padding(.horizontal, UIConstants.screenHorizontalPadding)
                    }
                    .background(
                        Image("Homepage_bg")
                            .resizable()
                            .scaledToFill()
                            .padding(.top, -150)
                            .padding(.bottom, -200)
                            .offset(CGSize(width: 00, height: 0))
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
}

struct TodayPage_Previews: PreviewProvider {
    static var previews: some View {
        TodayPage()
    }
}

struct HideScrollIndicators: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            return content.scrollIndicators(.hidden)
        } else {
            return content.tag(1) // tag added for compiling fix
        }
    }
}

private struct ContentScrollableTodayPart1: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Bonjour Marc, nous sommes le 07 Décembre. Aujourd’hui en un coup d’oeil :")
                .appFontBody(14)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 16*UIConstants.scalingFactor)
            Text("Le malheur, comme la piété, peut devenir une habitude")
                .appFontH1()
                .fixedSize(horizontal: false, vertical: true)
                .frame(height: 54*UIConstants.scalingFactor)
                .multilineTextAlignment(.center)
                .padding(.top, 24*UIConstants.scalingFactor)
            Image("Hompepage-libra")
                .resizable()
                .frame(width: 270*UIConstants.scalingFactor, height: 270*UIConstants.scalingFactor)
                .padding(.top, 32*UIConstants.scalingFactor)
            
            HStack(spacing: 0) {
                Text("Votre journée")
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
                        .padding(.trailing, 0.18*109*UIConstants.scalingFactor)
                }.frame(width: 109*UIConstants.scalingFactor, height: 1)
                Text("82%")
                    .appFontBody()
                    .frame(width: 50*UIConstants.scalingFactor)
                    .padding(.leading, 4)
            }.frame(height: 24*UIConstants.scalingFactor)
                .padding(.top, 24*UIConstants.scalingFactor)
            
            Text("Personne ne pourra vous reprocher de manquer de suite dans les idées. Vous aurez au contraire beaucoup de ténacité et une telle détermination à réussir vos projets qu'aucun obstacle ne vous paraîtra insurmontable. Vous mènerez votre journée avec lucidité et intelligence.")
                .appFontBody()
                .fixedSize(horizontal: false, vertical: true)
                .padding(.top, 14*UIConstants.scalingFactor)
            
            
            NavigationLink(destination: MonHoroscope()) {
                HStack(spacing: 0) {
                    Spacer()
                    Text("Voir mon horoscope complet")
                        .appFontMenu(14)
                        .underline()
                }
            }.padding(.top, 32*UIConstants.scalingFactor)
        }
    }
}

private struct ContentScrollableTodayPart2: View {
    var body: some View {
        VStack(spacing: 0) {
            
            CustomSegmentedControl()
            
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Image("Homepage-Frame17")
                                .resizable()
                                .frame(width: 82*UIConstants.scalingFactor, height: 68*UIConstants.scalingFactor)
                                .padding(.top, 7*UIConstants.scalingFactor)
                                .padding(.bottom, 7*UIConstants.scalingFactor)
                        }
                        Text("Bélier")
                            .appFontH2()
                            .frame(height: 24*UIConstants.scalingFactor)
                            .padding(.top, 14*UIConstants.scalingFactor)
                    }.frame(maxWidth: .infinity)
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Image("Homepage-Frame18")
                                .resizable()
                                .frame(width: 68*UIConstants.scalingFactor, height: 82*UIConstants.scalingFactor)
                        }
                        
                        Text("Lion")
                            .appFontH2()
                            .frame(height: 24*UIConstants.scalingFactor)
                            .padding(.top, 14*UIConstants.scalingFactor)
                    }.frame(maxWidth: .infinity)
                    
                }.frame(height: 136*UIConstants.scalingFactor)
                
                Text("Jupiter dans votre ciel aujourd'hui, offre aux Balances et Béliers de belles opportunités en termes de bien-être et de vivre ensemble. Saturne, planète de la sécurité et de la sagesse offre aux Balances, un avenir serein, surtout avec les Lions.")
                    .appFontBody()
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 8*UIConstants.scalingFactor)
                
                Text("Voir plus")
                    .underline()
                    .appFontMenu(14)
                    .padding(.top, 16*UIConstants.scalingFactor)
                
            }.padding(.top, 24*UIConstants.scalingFactor)
            
            
            ZStack {
                RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor, style: .continuous).fill(.black)
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Image("Group-12")
                            .resizable()
                            .foregroundColor(Color.white)
                            .frame(width: 72*UIConstants.scalingFactor, height: 82*UIConstants.scalingFactor)
                        Spacer()
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Image("Group-12-near1")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 32*UIConstants.scalingFactor, height: 43*UIConstants.scalingFactor)
                                Spacer()
                            }
                            VStack(spacing: 0) {
                                Image("Group-12-near2")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 32*UIConstants.scalingFactor, height: 43*UIConstants.scalingFactor)
                            }.offset(CGSize(width: -1, height: 0))
                        }.frame(width: 72*UIConstants.scalingFactor, height: 82*UIConstants.scalingFactor)
                    }.padding(.top, 24*UIConstants.scalingFactor)
                        .padding(.horizontal, 24*UIConstants.scalingFactor)
                    
                    Text("Consulter votre calendrier lunaire")
                        .foregroundColor(.white)
                        .appFontH2()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16*UIConstants.scalingFactor)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 12*UIConstants.scalingFactor)
                    
                    Text("Découvres ce que la lune révèle sur toi. ")
                        .appFontBody()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16*UIConstants.scalingFactor)
                        .foregroundColor(.white)
                }.padding(.bottom, 24*UIConstants.scalingFactor)
            }.frame(height: 180*UIConstants.scalingFactor)
                .padding(.top, 56*UIConstants.scalingFactor)
            
        }
        
    }
}

struct ContentScrollableTodayPart3: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Biorythme")
                .appFontH1()
                .frame(maxWidth: .infinity, alignment: .leading)
                .multilineTextAlignment(.leading)
                
            HStack(spacing: 16*UIConstants.scalingFactor) {
                CommonBiorithmItem(title: "Physique", percent: 96)
                CommonBiorithmItem(title: "Émotif", percent: -100)
                CommonBiorithmItem(title: "Intellectuel", percent: -45)
            }.padding(.top, 24*UIConstants.scalingFactor)
            
            
            if #available(iOS 16.0, *) {
                BiorythmeChart()
                    .frame(height: 200*UIConstants.scalingFactor)
                    .padding(.top, 56*UIConstants.scalingFactor)
                Text("Aujourd'hui")
                    .appFontMenu(14)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 21*UIConstants.scalingFactor)
            } else {
                // Fallback on earlier versions
                Image("Group-6")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .padding(.top, 56*UIConstants.scalingFactor)
                Text("Aujourd'hui")
                    .appFontMenu(14)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(CGSize(width: 0, height: -20*UIConstants.scalingFactor))
            }
            
            HStack {
            }.frame(height: 130*UIConstants.scalingFactor)
        }
    }
}


struct ContentScrollableTodayPart4: View {
    var body: some View {
        TabView {
            ScrollHorizentalCardPart()
            ScrollHorizentalCardPart()
            ScrollHorizentalCardPart()
            ScrollHorizentalCardPart()
        }.frame(width: 320*UIConstants.scalingFactor, height: 140*UIConstants.scalingFactor)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
        
    }
}

struct ScrollHorizentalCardPart: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor, style: .continuous)
                .fill(.white)
            
            VStack(spacing: 0) {
                Text("ddddd")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Text("card.answer")
                    .font(.title)
                    .foregroundColor(.gray)
            }
            .padding(20*UIConstants.scalingFactor)
            .multilineTextAlignment(.center)
        }
        .background(
            RoundedRectangle(cornerRadius: 15*UIConstants.scalingFactor)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 2, x: 0, y: 0)
            
        )
        .frame(width: 220*UIConstants.scalingFactor, height: 136*UIConstants.scalingFactor)
        .padding()
        
    }
}

struct ExtendScrollViewToAllWidth: View {
    var body: some View {
        Text("                                                                                                                  ")
    }
}
