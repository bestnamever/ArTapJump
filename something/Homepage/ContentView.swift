//
//  ContentView.swift
//  leadership_widgit
//
//  Created by Yu Hong on 2020/12/14.
//

import SwiftUI

var scores:ScoreHelper = ScoreHelper()

struct ContentView: View {
    @AppStorage("lastest",store: UserDefaults(suiteName: "group.poc-scene.leadership-widgit"))
    var data1 : Int = Int()
    @AppStorage("highest",store: UserDefaults(suiteName: "group.poc-scene.leadership-widgit"))
    var data2 : Int = Int()
    
    
    
    @State var showView: Bool = false
    @State var leaderboard:Bool = false
    
    
    let gradient1 = [Color("gradient2"),Color("gradient3"),Color("gradient4")]
    
    let gradient = [Color("gradient1"),Color("gradient2"),Color("gradient3"),Color("gradient4")]
    
    func save(){
        let lastest = scores.getLastestScore()
        self.data1 = lastest
        let highest = scores.getHighestScore()
        self.data2 = highest
    }
    
    var body: some View {
//        if(showView){
//            ARControllerView()
//        }
//        else{

        VStack(){
            VStack{
                Text("Tap Jump").font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.top,40).onTapGesture {
                        save()
                    }
                
                Spacer()
                
            }
            .frame(height:UIScreen.main.bounds.height / 3.3)
            .onAppear(){
                save()
            }
            .onTapGesture {
                save()
            }
            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                    
                LinearGradient(gradient: .init(colors: gradient1), startPoint: .top, endPoint: .bottom)
                    .clipShape(CustomShape())
                Button(action:{
                    showView = true
                },label:{
                    VStack(spacing:10){
                        Image(systemName: "power")
                            .font(.system(size: 70))
                            .foregroundColor(Color("power"))
                        
                        Text("START")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding(50)
                    .background(LinearGradient(gradient: .init(colors: [Color("pgradient1"),Color("pgradient2")]), startPoint: .leading, endPoint: .trailing))
                    .clipShape(Circle())
                    .padding(15)
                    .background(Color("power1").opacity(0.7))
                    .clipShape(Circle())
                    .padding(15)
                    .background(Color("gradient2").opacity(0.7))
                    .clipShape(Circle())
                }
                ).sheet(isPresented: $showView, content: {
                    ARControllerView()
                })
                .offset(y: -65)
                .padding(.bottom,-65)
                
            
                
                Spacer()
                
                Button(action: {self.leaderboard = true}, label: {
                    CardView(subTitle: "LeaderBoard")
                        .background(Color.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .foregroundColor(.white)
                        .padding()
                }).padding(.top,300)
                .sheet(isPresented: $leaderboard, content: {
                    JumpView()
                })
                .onTapGesture {
                    save()
                }
            })
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(
            ZStack{
                LinearGradient(gradient: .init(colors: gradient), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                Spacer()
                Color.black.opacity(0.1)
                    .ignoresSafeArea(.all,edges: .top)
            }
        )
        .onTapGesture {
            save()
        }
//        }
    }
        
    
}


struct JumpView: View {
    let gradient1 = [Color("gradient2"),Color("gradient3"),Color("gradient4")]
    
    let gradient = [Color("gradient1"),Color("gradient2"),Color("gradient3"),Color("gradient4")]
    
    var array = ScoreHelper.shared.readAllSocre()
    
    
    var body: some View{
        if(!array.isEmpty)
        {
            VStack{
                if array.isEmpty{
                    ScoresView(number: "\(array.count + 1)", score: "empty",index: 1)
                                            .background(Color.orange.opacity(0.6))
                                            .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                                            .foregroundColor(.white)
                                            .padding()
                }
                else{
                    if(array.count <= 6){
                        ForEach(0..<array.endIndex-1){ index in
                            ScoresView(number: "\(index+1).", score: "\(array[index])",index: index+1)
                                                    .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                                                    .foregroundColor(.white)
                                                    .padding()
                    }
                    }
                    else{
                    ForEach(0..<6){ index in
                        ScoresView(number: "\(index+1).", score: "\(array[index])",index: index+1)
                                                .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                                                .foregroundColor(.white)
                                                .padding()
                    }
                    }
                }
                    
                }
                    
                }
        else{
            VStack{
                ScoresView(number: "empty", score: "empty",index: 1)
                                        .background(Color.orange.opacity(0.6))
                                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
                                        .foregroundColor(.white)
                                        .padding()
            }
        }
    }
}
//                ScoresView(number: "1", score: "\(ScoreHelper.shared.getHighestScore())")
//                        .background(Color.orange.opacity(0.6))
//                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
//                        .foregroundColor(.white)
//                        .padding()
//
//                ScoresView(number: "2", score: "\(ScoreHelper.shared.getLastestScore())")
//                        .background(Color.orange.opacity(0.4))
//                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
//                        .foregroundColor(.white)
//                        .padding()
//
//               ScoresView(number: "3", score: "200")
//                        .background(Color.orange.opacity(0.3))
//                        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
//                        .foregroundColor(.white)
//                        .padding()
//            }



