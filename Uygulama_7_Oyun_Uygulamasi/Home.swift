

import SwiftUI

struct Home: View {
    @State var ara = ""
    @State var index = 0
    @State var sutunlar = Array(repeating: GridItem(.flexible() , spacing: 15), count: 2)
    
    var body: some View {
        ScrollView {
            
            LazyVStack {
                HStack {
                    Text("Oyun Pazarı").font(.title).fontWeight(.bold)
                    Spacer()
                }.padding(.horizontal)
                
                TextField("Oyun adını yazınız..." , text: self.$ara)
                    .padding(.vertical ,10).padding(.horizontal)
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top , 25)
                    .foregroundColor(.black)
                
                TabView (selection : self.$index) {
                    ForEach (0...5 , id:\.self){
                        index in
                        Image("p\(index)").resizable()
                            .frame(height: self.index == index ? 230 : 180)
                            .cornerRadius(15)
                            .padding(.horizontal)
                            .tag(index)
                    }
                }.frame(height: 230)
                    .padding(.top , 25)
                    .tabViewStyle(PageTabViewStyle())
                    .animation(.easeOut)
                
                HStack {
                    Text("Popüler").font(.title).fontWeight(.bold)
                    Spacer()
                    Button {
                        withAnimation{
                            if self.sutunlar.count == 2 {
                                self.sutunlar.removeLast()
                            }
                            else {
                                self.sutunlar.append(GridItem(.flexible(),spacing:15))
                            }
                        }
                    } label : {
                        Image(systemName: self.sutunlar.count == 2 ? "rectangle.grid.1x2" : "square.grid.2x2")
                            .font(.system(size: 24))
                            .foregroundColor(.black)
                    }
                }.padding(.horizontal)
                    .padding(.top , 25)
                
                LazyVGrid (columns : sutunlar , spacing: 25) {
                    ForEach (oyunVerileri) { oyun in
                        GridView(oyun: oyun, sutunlar: self.$sutunlar)
                    }
                }.padding([.horizontal, .top])
                
            }.padding(.vertical)
        }.background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.all))
    }
}

struct GridView : View {
    var oyun : Oyun
    @Binding var sutunlar : [GridItem]
    @Namespace var namespace
    
    var body: some View {
        VStack {
            
            if self.sutunlar.count == 2 {
                VStack (spacing:15) {
                    ZStack (alignment : Alignment(horizontal: .trailing, vertical: .top)) {
                        Image(oyun.goruntu)
                            .resizable()
                            .frame(width: 180 , height: 200)
                            .cornerRadius(15)
                        
                        Button{ } label: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(.all ,10)
                                .background(Color.white)
                                .clipShape(Circle())
                        }.padding(.all , 10)
                    }.matchedGeometryEffect(id: "goruntu", in: self.namespace)
                    
                    Text(oyun.adi).fontWeight(.bold).lineLimit(1)
                        .matchedGeometryEffect(id: "baslik", in: self.namespace
                        )
                    
                    Button{ } label: {
                        Text("Satın Al").foregroundColor(.white)
                            .padding(.vertical , 10)
                            .padding(.horizontal , 25)
                            .background(Color.red)
                            .cornerRadius(10)
                    }.matchedGeometryEffect(id: "satinal", in: self.namespace
                    )
                }
            }else {
                HStack (spacing:15) {
                    ZStack (alignment : Alignment(horizontal: .trailing, vertical: .top)) {
                        Image(oyun.goruntu).resizable()
                            .frame(width: (UIScreen.main.bounds.width - 45) / 2 , height: 250).cornerRadius(15)
                        
                        Button{ } label: {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .padding(.all , 10)
                                .background(Color.white)
                                .clipShape(Circle())
                        }.padding(.all , 10)
                    }.matchedGeometryEffect(id: "goruntu", in: self.namespace)
                    
                    VStack (alignment:.leading , spacing: 10) {
                        Text(oyun.adi).fontWeight(.bold)
                            .matchedGeometryEffect(id: "baslik", in: namespace)
                        HStack {
                            ForEach (1...5 , id:\.self) {
                                oy in
                                Image(systemName: "star.fill")
                                    .foregroundColor(self.oyun.oy >= oy ? .yellow : .gray)
                            }
                            Spacer()
                        }
                        
                        Button { } label: {
                            Text("Satın al")
                                .foregroundColor(.white)
                                .padding(.vertical , 10)
                                .padding(.horizontal , 25)
                                .background(Color.red)
                                .cornerRadius(10)
                        }.padding(.top , 10)
                            .matchedGeometryEffect(id: "satinal", in: self.namespace)
                    }
                }
                .padding(.trailing)
                .background(Color.white)
                .cornerRadius(15)
            }
        }
    }
}


#Preview {
    Home()
}
