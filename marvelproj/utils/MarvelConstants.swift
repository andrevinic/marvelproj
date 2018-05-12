//
//  MarvelConstants.swift
//  marvelproj
//
//  Created by Andre Nogueira on 10/05/18.
//  Copyright © 2018 Andre Nogueira. All rights reserved.
//

import Foundation

////////////////////////////////////////////////////////////////
//MARK:-
//MARK: Constants for table view cells
//MARK:-
////////////////////////////////////////////////////////////////
let NUMBER_OF_TABLEVIEW_SECTIONS = 5
let HEIGHT_FOR_HEADER_IN_SECTION = 50
let FONT_CIRCULAR_FOR_SECTION = "CircularSTD-Black"
let SIZE_FOR_HEADER_VIEW_SECTION = 20
let HEIGHT_FOR_COLLECTION_VIEW_DETAIL_CELL = 250
let HEIGHT_FOR_TABLE_VIEW_DETAIL_CELL = 120
let LIMIT_OF_COLLECTION_VIEW_CELLS_PER_CELL = 3
let LIMIT_OF_TABLE_VIEW_CELLS_STORIES = 3

let LIMIT_OF_FETCH_COLLECTION_VIEW_COMICS = 3
let LIMIT_OF_FETCH_COLLECTION_VIEW_SERIES = 3
let LIMIT_OF_FETCH_COLLECTION_VIEW_EVENTS = 3
let LIMIT_OF_FETCH_COLLECTION_VIEW_STORIES = 3

let SIZE_FOR_COLLECTION_VIEW_LAYOUT_WIDTH = 135
let SIZE_FOR_COLLECTION_VIEW_LAYOUT_HEIGHT = 300
let CENTER_CONSTANT_CELL_WIDTH_VALUE = 100 * LIMIT_OF_COLLECTION_VIEW_CELLS_PER_CELL
let CELL_SPACING_BETWEEN_COLLECTION_VIEW_CELL = 10 * (LIMIT_OF_COLLECTION_VIEW_CELLS_PER_CELL - 1)
let NUMBER_OF_CELLS_IN_COLLECTION_VIEW_IN_CHARACTERS = 2
let NUMBER_OF_CELLS_IN_COLLECTION_VIEW_IN_SEARCH_CHARACTERS = 1

////////////////////////////////////////////////////////////////
//MARK:-
//MARK: Fetch http constants
//MARK:-
////////////////////////////////////////////////////////////////

let LIMIT_FETCH = 20

let BASE_URL = "gateway.marvel.com"
let CHARACTER_EXT = "/v1/public/characters"
