//
//  CardView.swift
//  leadership_widgit
//
//  Created by Yu Hong on 2020/12/15.
//

import SwiftUI

struct CardView: View {
    var subTitle: String
    
    var body: some View {
        
        HStack(spacing: 10){
            
            
            VStack(alignment: .leading, spacing: 4, content: {
                
                Text(subTitle)
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding(.leading,20)
            })
            
            Spacer()
            
            Image(systemName: "chevron.up")
                .font(.system(size: 24))
                .foregroundColor(.white)
                .padding(.trailing,20)
        }
        .padding(.leading,10)
        .padding(.trailing)
        .padding(.vertical)
    }
}

