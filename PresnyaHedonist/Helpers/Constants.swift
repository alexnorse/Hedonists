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
    static let FAVORITES_VC         = "FavoritesVC"
    static let ALLPLACESMAP_VC      = "AllPlacesMapVC"
    static let TABBAR_VC            = "TabBarVC"
}


enum CellsID {
    static let FEED_CELL            = "feedCell"
    static let FAVS_CELL            = "favsCell"
    static let NOTES_CELL           = "notesCell"
}


enum FirstLaunchCheck {
    static let PRELOAD_DATA         = "Preload"
}


enum UISettings {
    static let cornerRadius: CGFloat            = 15
    static let regionZoomDetails: Double        = 500
    static let regionZoom: Double               = 1500
}


enum Errors {
    static let databaseError    = "В настоящий момент невозможно получить доступ к базе данных.\nПожалуйста, попробуйте позже"
    static let fetchError       = "Ошибка загрузки.\nПожалуста, попробуйте еще раз"
    static let faillURL         = "Неверный или устаревший адрес ссылки"
    static let favsFail         = "Произошла ошибка при добавлении в Избранное"
    static let imageError       = "Ошибка загрузки изображения ☹️"
}


enum Alerts {
    static let addedToFavorites = "Место добавлено в Избранное"
}


enum AlertTitle {
    static let error    = "☹️"
    static let success  = "✌️"
}


enum EmptyStates {
    static let notesEmpty       = "У Вас пока нет заметок об этом месте. \nДобавьте свои впечатления 🖋"
    static let favsEmpty        = "У Вас пока еще нет мест в Избранном \nПосмотрите, что есть в нашей ленте 🧐"
}


enum VCTitles {
    static let feedTitle     = "Все локации"
    static let favsTitle     = "Избранное"
}


enum Fonts {
    static let vcHeads          = UIFont(name: "LabGrotesque-Black", size: 28)
    static let headlines        = UIFont(name: "LabGrotesque-Bold", size: 24)
    static let keyAccents       = UIFont(name: "LabGrotesque-Bold", size: 20)
    static let bodyAccents      = UIFont(name: "LabGrotesque-Medium", size: 16)
    static let bodyText         = UIFont(name: "LabGrotesque-Regular", size: 16)
}


