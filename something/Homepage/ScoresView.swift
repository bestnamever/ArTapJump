//
//  ScoresView.swift
//  ARtapjump
//
//  Created by Yu Hong on 2021/1/5.
//
//
//  CardView.swift
//  leadership_widgit
//
//  Created by Yu Hong on 2020/12/15.
//

import SwiftUI

struct ScoresView: View {
    var number: String
    var score: String
    var index: Int
    
    var body: some View {
        
        HStack(spacing: 10){
            
            
            VStack(alignment: .leading, spacing: 4, content: {
                
                Text(number)
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.leading,20)
            })
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4, content: {
                
                Text(score)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.trailing,20)
            })
        }
        .padding(.leading,10)
        .padding(.trailing)
        .padding(.vertical)
        .background((Color.orange.opacity(0.9 - Double((index+1))/10)))
    }
}


