//
//  PostComponent.swift
//  Firebase User Account Management
//
//  Created by Aban Domingo on 3/8/23.
//

import SwiftUI

struct PostComponent: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top, spacing: 12){
                Circle()
                    .frame(width: 56, height: 56)
                    .foregroundColor(.gray)
                VStack(alignment: .leading, spacing: 4){
                    HStack{
                        Text("Aban Domingo")
                            .font(.subheadline)
                        Text("@adomingo")
                            .foregroundColor(.gray)
                            .font(.caption)
                        Text("2d")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                    
                    Text("Insert Text in here")
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
            }
            HStack{
                Button{
                    //add like
                } label:{
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                }
                Button{
                    //add comment
                } label:{
                    Image(systemName: "bubble.left")
                        .foregroundColor(.gray)
                }
                .padding(5)
                Text("")
                Spacer()
                Text("")

            }
            .padding()
        }
        .padding()
        
    }
}

struct PostComponent_Previews: PreviewProvider {
    static var previews: some View {
        PostComponent()
    }
}
