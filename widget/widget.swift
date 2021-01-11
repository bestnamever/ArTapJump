//
//  widget.swift
//  widget
//
//  Created by Yu Hong on 2021/1/10.
//

import WidgetKit
import SwiftUI


struct LeadershipEntry:TimelineEntry {
    var date : Date
    var lastestScore: Int
    var highestScore: Int
}

struct Provider:TimelineProvider {
    @AppStorage("lastest",store: UserDefaults(suiteName: "group.poc-scene.leadership-widgit"))
    var data1 : Int = Int()
    @AppStorage("highest",store: UserDefaults(suiteName: "group.poc-scene.leadership-widgit"))
    var data2 : Int = Int()
    
    
    
    func placeholder(in context: Context) -> LeadershipEntry {
        let lastest = data1
        let highest = data2
        return LeadershipEntry(date: Date(),lastestScore: lastest,highestScore: highest)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (LeadershipEntry) -> Void) {
        let lastest = data1
        let highest = data2
        let entry = LeadershipEntry(date: Date(),lastestScore: lastest,highestScore: highest)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<LeadershipEntry>) -> Void) {
        let lastest = data1
        let highest = data2
        let entry = LeadershipEntry(date: Date(),lastestScore: lastest,highestScore: highest)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

}


struct WidgetEntryView: View {
    
    var scoreHelper : ScoreHelper = ScoreHelper()
    
    
    let entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    var body: some View{
        if family == .systemSmall
        {
        ZStack{
            Color.orange.opacity(0.6)
            VStack{
                Spacer()
                Text("Last Score").font(.headline).fontWeight(.bold)
                Spacer()
                Text("\(entry.lastestScore)").font(.headline).fontWeight(.semibold)
                Spacer()
                ZStack(alignment: .leading){
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.5))
                        .frame(width:130)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.orange.opacity(0.9))
                        .frame(width:CGFloat( Float(entry.lastestScore) / Float(entry.highestScore) * 130))
                }.frame(height:20).padding(.horizontal)
                Spacer()
            }.foregroundColor(.white)
            Spacer()
        }
        }
        else{
            if( entry.highestScore == 0)
            {
                HStack{
                    ZStack{
                        Color.orange.opacity(0.6)
                        VStack{
                            Spacer()
                            Text("Last Score").font(.headline).fontWeight(.bold)
                            Spacer()
                            Text("\(entry.lastestScore)").font(.headline).fontWeight(.semibold)
                            Spacer()
                            ZStack(alignment:.leading){
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.5))
                                    .frame(width:130)
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.orange.opacity(0.9))
                                    .frame(width:130)
                            }.frame(height:20).padding(.horizontal)
                            Spacer()
                        }.foregroundColor(.white)
                        Spacer()
                    }
                    ZStack{
                        Color.blue.opacity(0.6)
                        VStack{
                            Spacer()
                            Text("Best Score").font(.headline).fontWeight(.bold)
                            Spacer()
                            Text("\(entry.highestScore)").font(.headline).fontWeight(.semibold)
                            Spacer()
                            ZStack(alignment:.center){
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white.opacity(0.5))
                                    .frame(width:130)
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue.opacity(0.9))
                                    .frame(width: 130)
                            }.frame(height:20).padding(.horizontal)
                            Spacer()
                        }.foregroundColor(.white)
                        Spacer()
                    }
                }
            }
            else{
            HStack{
                ZStack{
                    Color.orange.opacity(0.6)
                    VStack{
                        Spacer()
                        Text("Last Score").font(.headline).fontWeight(.bold)
                        Spacer()
                        Text("\(entry.lastestScore)").font(.headline).fontWeight(.semibold)
                        Spacer()
                        ZStack(alignment:.leading){
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.5))
                                .frame(width:130)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.orange.opacity(0.9))
                                .frame(width:CGFloat( Float(entry.lastestScore) / Float(entry.highestScore) * 130))
                        }.frame(height:20).padding(.horizontal)
                        Spacer()
                    }.foregroundColor(.white)
                    Spacer()
                }
                ZStack{
                    Color.blue.opacity(0.6)
                    VStack{
                        Spacer()
                        Text("Best Score").font(.headline).fontWeight(.bold)
                        Spacer()
                        Text("\(entry.highestScore)").font(.headline).fontWeight(.semibold)
                        Spacer()
                        ZStack(alignment:.center){
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.white.opacity(0.5))
                                .frame(width:130)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue.opacity(0.9))
                                .frame(width: 130)
                        }.frame(height:20).padding(.horizontal)
                        Spacer()
                    }.foregroundColor(.white)
                    Spacer()
                }
            }
            }
        }
    }
}

@main
struct MyWidget: Widget {
    private let kind = "Mywidget"
    var body: some WidgetConfiguration{
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetEntryView(scoreHelper: ScoreHelper(), entry: entry)
        }.supportedFamilies([.systemSmall, .systemMedium]).configurationDisplayName("AR TapJump")
        .description("Check your lastest and best scores")
    }
}
