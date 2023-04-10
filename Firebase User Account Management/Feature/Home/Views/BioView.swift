//
//  ProfileView.swift
//  Firebase User Account Management
//
//  Created by Derek Le on 3/21/23.
//

import Foundation
import SwiftUI


struct BioView: View
{
    @EnvironmentObject var service: SessionServiceImpl
    @State private var showProfilePhotoSelectorView = false
    var body: some View
    {
        NavigationView
        {
            ScrollView(.vertical)
            {
                headerView
                
                descriptionView
                
            }
            .navigationTitle(Text("\(service.userDetails?.firstName ?? "N/A")")) // Change to username
            .navigationBarTitleDisplayMode(.inline)
            .toolbar
            {
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Button(action:{service.logout()}) {
                        Image(systemName:"rectangle.portrait.and.arrow.forward")
                            .foregroundColor(Color(.systemGray))
                    }
                }
//                ToolbarItem(placement: .navigationBarLeading)
//                {
//                    Image(systemName: "chevron.left")
//                }
            }
        }
    }
    private var headerView: some View
    {
        
        HStack
        {
           
            Button {
                showProfilePhotoSelectorView.toggle()
            } label: {
                Image("image5")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().strokeBorder(Color.orange, lineWidth: 2))
            }
            .fullScreenCover(isPresented: $showProfilePhotoSelectorView) {
                ProfilePhotoSelectorView()
            }

            VStack(spacing:12)
            {
                HStack
                {
                    Spacer()
                    VStack
                    {
                        Text("4,300")
                            .fontWeight(.semibold)
                        Text("posts")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack
                    {
                        Text("14,300")
                            .fontWeight(.semibold)
                        Text("followers")
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    VStack
                    {
                        Text("4,300")
                            .fontWeight(.semibold)
                        Text("following")
                            .foregroundColor(.gray)
                    }
                }
                HStack(spacing: 8)
                {
                    Text("Messages")
                        .padding(4)
                        .frame(height: 30)
                        .frame(maxWidth:  .infinity)
                        .background(RoundedRectangle(cornerRadius: 4).stroke(Color.gray))
                        .padding(.leading, 8)
                    
                    HStack
                    {
                        Image(systemName: "person")
                        Image(systemName: "checkmark")
                        
                    }
                    .padding(4)
                    .frame(height: 30)
                    .background(RoundedRectangle(cornerRadius: 4).stroke(Color.gray))
                    
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.footnote)
                        .padding(4)
                        .padding(.horizontal, 4)
                        .frame(height: 30)
                        .background(RoundedRectangle(cornerRadius: 4).stroke(Color.gray))
                }
            }
        }.padding(.horizontal)
    }//.padding(.horizontal)
    
    private var descriptionView: some View
    {
        VStack(alignment: .leading, spacing: 4)
        {
            Text("Placeholder")
                .fontWeight(.semibold)
            
            Text("placehold")
                
            
            Text("place")
                .foregroundColor(.gray)
            HStack
            {
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    private var imageView: some View
    {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 0)
        {
            ForEach(0..<15)
            {
                index in
                Image("image\(index)")
                    .resizable()
                    .scaledToFill()
                frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3)
                clipped()
            }
        }
    
    }
}



struct BioView_Previews: PreviewProvider
{
    static var previews: some View
    {
        BioView()
            .environmentObject(SessionServiceImpl())
    }
}
