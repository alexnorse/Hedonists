//
//  Constants.swift
//  PresnyaHedonist
//
//  Created by Alexandr L. on 7/13/21.
//

import UIKit

enum VControllersID {
    static let FEED_VC              = "FeedVC"
    static let DETAILS_VC           = "DetailsVC"
    static let MAP_VC               = "MapVC"
    static let INFO_VC              = "InfoVC"
    static let NOTELIST_VC          = "NoteListVC"
    static let NEWNOTE_VC           = "NewNoteVC"
    static let FULLMAP_VC           = "FullmapVC"
    static let TABBAR_VC            = "TabBarVC"
}


enum CellsID {
    static let FEED_CELL            = "feedCell"
    static let NOTES_CELL           = "notesCell"
}


enum FirstLaunchCheck {
    static let PRELOAD_DATA         = "Preload"
}


enum UISettings {
    static let cornerRadius: CGFloat    = 15
    static let regionZoom: Double       = 500
}


enum Errors {
    static let databaseError    = "В настоящий момент невозможно получить доступ к базе данных.\nПожалуста, попробуйте чуть позже."
    static let fetchError       = "Ошибка загрузки.\nПожалуста, попробуйте еще раз."
    static let faillURL         = "Неверный или устаревший адрес ссылки"
}


enum AlertTitle {
    static let error    = "☹️"
    static let success  = "✌️"
}


enum EmptyStates {
    static let notesEmpty       = "У Вас пока нет заметок об этом месте. \nДобавьте свои впечатления 🖋"
}


enum VCTitles {
    static let feedTitle    = "Лента"
    static let mapTitle     = "Карта"
}


enum Fonts {
    static let vcHeads          = UIFont(name: "LabGrotesque-Black", size: 30)
    static let tabBarItems      = UIFont(name: "LabGrotesque-Black", size: 14)
        
    static let headlines        = UIFont(name: "LabGrotesque-Bold", size: 24)
    static let keyAccents       = UIFont(name: "LabGrotesque-Bold", size: 20)
        
    static let bodyText         = UIFont(name: "LabGrotesque-Regular", size: 16)
    static let bodyAccents      = UIFont(name: "LabGrotesque-Medium", size: 16)
}


