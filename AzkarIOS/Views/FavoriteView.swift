//
//  FavoriteView.swift
//  AzkarStore
//
//  Created by Mohamed Shemy on Thu 4 Mar 2021.
//  Copyright © 2021 Mohamed Shemy. All rights reserved.
//

import SwiftUI

struct FavoriteView : View
{
    @EnvironmentObject var store: FavoritesStore
    
    var body: some View
    {
        VStack(spacing: 10)
        {
            NavigationTitle(title: "المفضله")
            ScrollView(.vertical, showsIndicators: false)
            {
                LazyVStack(spacing: 15)
                {
                    ForEach(store.favorites)
                    { fav in
                        
                        FavoriteCell(favorite: fav)
                            .contextMenu
                            {
                                Button("حذف", action: { deleteItem(fav) })
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
                .padding(.top, 10)
                .toolbar
                {
                    EditButton()
                }
            }
        }
        .padding([.leading, .trailing])
        .navigationBarHidden(true)
        .islamicBackground()
    }
    
    private func deleteItems(offsets: IndexSet)
    {
        withAnimation
        {
            store.delete(offsets: offsets)
        }
    }
    
    private func deleteItem(_ fav: Favorite)
    {
        withAnimation
        {
            store.delete(fav)
        }
    }
}

struct FavoriteView_Previews : PreviewProvider
{
    static var previews: some View
    {
        FavoriteView()
            .environmentObject(FavoritesStore())
            .environmentObject(AzkarStore())
    }
}

struct FavoriteCell : View
{
    let favorite: Favorite
    @EnvironmentObject var azkarStore: AzkarStore
    
    var body: some View
    {
        NavigationLink(destination: AzkarContentView(subSection: azkarStore.getSubSection(for: favorite)))
        {
            Text(favorite.title ?? "")
                .padding(10)
                .font(.title2)
                .minimumScaleFactor(0.5)
                .foregroundColor(.background)
                .lineLimit(1)
                .frame(maxWidth: .infinity, minHeight: 48)
                .linearGradientBackground()
                .clipShape(Capsule())
                .cellBackgroundStyle(Capsule())
                .padding([.leading, .trailing], 10)
                .animation(.spring(response: 1, dampingFraction: 0.5, blendDuration: 1))
        }
    }
}
