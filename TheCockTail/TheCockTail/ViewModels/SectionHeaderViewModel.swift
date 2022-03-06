//
//  SectionHeaderViewModel.swift
//  TheCockTail
//
//  Created by Jageloo Yadav on 24/02/22.
//

import Foundation

class SectionHeaderViewModel: CollectionViewSectionHeaderDataSource {
    var buttonTitle: String { "See All" }
    var title: String?
    
    init(title: String?) {
        self.title = title
    }
}
 
