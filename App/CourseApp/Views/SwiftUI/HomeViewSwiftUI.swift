//
//  HomeViewSwiftUI.swift
//  CourseApp
//
//  Created by Marcel Mravec on 16.05.2024.
//

// TODO: Not used atm - remove?
import os
import SwiftUI

struct HomeViewSwiftUI: View {
    @StateObject private var dataProvider = MockDataProvider()
    let logger = Logger()
    
    var body: some View {
#if DEBUG
    Self._printChanges()
#endif
    return
        List {
            ForEach(dataProvider.data, id: \.self) { section in
                Section {
                    VStack {
                        ForEach(section.jokes) { joke in
                            ZStack(alignment: .bottomLeading) {
                                Image(uiImage: joke.image ?? UIImage())
                                    .resizableBordered(cornerRadius: UIConstants.normalImageRadius)
                                    .onTapGesture {
                                        logger.log("Tapped joke \(joke.text)")
                                    }
                                
                                imagePanel
                            }
                        }
                    }
                    .background(.bg)
                    .padding(.leading, UIConstants.smallPadding)
                    .padding(.trailing, UIConstants.smallPadding)
                } header: {
                    Text(section.title)
                        .foregroundColor(.white)
                        .padding(.leading, UIConstants.smallPadding)
                        .padding(.trailing, UIConstants.smallPadding)
                }
                .background(.bg)
                .listRowInsets(EdgeInsets())
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(.bg)
    }
    
    private var imagePanel: some View {
        HStack {
            Text("Text")
                .foregroundStyle(.white)
            
            Spacer()
            
            Button {
                logger.log("tapped button 💖")
            } label: {
                Image(systemName: "heart")
            }
            .buttonStyle(SelectableButtonStyle(isSelected: .constant(false), color: .gray))
        }
        .padding(UIConstants.smallPadding)
    }
}


#Preview {
    HomeViewSwiftUI()
}
