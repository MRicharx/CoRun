//
//  PrifileVIew.swift
//  CoRun
//
//  Created by Marselus Richard on 26/03/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView{
            VStack(alignment:.leading,spacing: 24){
                //MARK: Title
                Text("My Profile")
                    .modifier(MView.safePadding())
                    .modifier(MColor.Text())
                    .modifier(MFont.Title())
                
                //MARK: Biodata
                CProfileBiodata()
                
                //MARK: Coach
                CProfileCoach(coach: "Budi")
                
                //MARK: Reminder
                CProfileReminder()
                
                //MARK: Trainee List
                VStack{
                    HStack{
                        Group{
                            Image(systemName: "person.crop.rectangle.stack.fill")
                                .modifier(MColor.Primary())
                            Text("My Trainee List")
                                .modifier(MColor.Text())
                        }.modifier(MFont.Headline())
                    }.modifier(MView.FillToLeftFrame())
                }.padding(18)
                .modifier(MView.Card())
                
                //MARK: Sign Out
                Button{
                    //TODO: Sign Out Button
                }label:{
                    VStack{
                        Text("Sign Out")
                            .modifier(MFont.Headline(size: 18))
                            .modifier(MColor.Danger())
                    }.modifier(MView.FillFrame())
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
