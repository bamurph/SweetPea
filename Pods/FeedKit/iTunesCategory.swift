//
//  iTunesCategory.swift
//  Pods
//
//  Created by Ben Murphy on 1/24/17.
//
//

import Foundation


/// Categories and Subcategories for Itunes Podcasts
/// see: https://help.apple.com/itc/podcasts_connect/#/itc9267a2f12
public struct ITunesCategory {
    let category: Category
    let subcategory: Subcategory?

    /// Initialize and validate that subcategories and categories match
    init?(with categoryString: String?, subcategoryString: String?) {
        guard
            categoryString != nil,
            let category = Category(rawValue: categoryString!)
            else { return nil }
        guard
            subcategoryString != nil,
            let subcategory = Subcategory(rawValue: subcategoryString!),
            ITunesCategory.validate(category: category, subcategory: subcategory)
            else { self = ITunesCategory(with: category); return}

        self = ITunesCategory(with: category, subcategory: subcategory)

    }

    init(with category: Category, subcategory: Subcategory? = nil) {
        self.category = category
        self.subcategory = subcategory
    }

    static func validate(category: Category, subcategory: Subcategory) -> Bool {
        guard let validSubcategories = validCombinations[category] else { return false }
        return validSubcategories.contains(subcategory)
    }



    static let validCombinations: [Category: Set<Subcategory>] =
        [.arts:                     [.design, .fashionBeauty, .food, .literature, .performingArts, .visualArts],
         .business:                 [.businessNews, .careers, .investing, .managementMarketing, .shopping],
         .education:                [.educationalTechnology, .higherEducation, .k12, .languageCourses, .training],
         .gamesHobbies:             [.automotive, .aviation, .hobbies, .otherGames, .videoGames],
         .governmentOrganizations:  [.local, .national, .nonProfit, .regional],
         .health:                   [.alternativeHealth, .fitnessNutrition, .selfHelp, .sexuality],
         .religionSpirituality:     [.buddhism, .christianity, .hinduism, .islam, .judaism, .other, .spirituality],
         .scienceMedicine:          [.medicine, .naturalSciences, .socialSciences],
         .societyCulture:           [.history, .personalJournals, .philosophy, .placesTravel],
         .sportsRecreation:         [.amateur, .collegeHighSchool, .outdoor, .professional],
         .technology:               [.gadgets, .techNews, .podcasting, .softwareHowTo]
    ]


    public enum Category: String {
        case arts
        case business
        case comedy
        case education
        case gamesHobbies = "Games & Hobbies"
        case governmentOrganizations = "Government & Organizations"
        case health
        case kidsFamily = "Kids & Family"
        case music
        case newsPolitics = "News & Politics"
        case religionSpirituality = "Religion & Spirituality"
        case scienceMedicine = "Science & Medicine"
        case societyCulture = "Society & Culture"
        case sportsRecreation = "Sports & Recreation"
        case technology
        case tvFilm = "TV & Film"
    }

    public enum Subcategory: String {

        // Arts
        case design
        case fashionBeauty = "Fashion & Beauty"
        case food
        case literature
        case performingArts
        case visualArts
        // Business
        case businessNews
        case careers
        case investing
        case managementMarketing = "Management & Marketing"
        case shopping
        // Education
        case educationalTechnology
        case higherEducation
        case k12 = "K-12"
        case languageCourses
        case training
        // Games & Hobbies
        case automotive
        case aviation
        case hobbies
        case otherGames
        case videoGames
        // Government & Organizations
        case local
        case national
        case nonProfit = "Non-Profit"
        case regional
        // Health
        case alternativeHealth
        case fitnessNutrition = "Fitness & Nutrition"
        case selfHelp = "Self-Help"
        case sexuality
        // Religion & Spirituality
        case buddhism
        case christianity
        case hinduism
        case islam
        case judaism
        case other
        case spirituality
        // Science & Medicine
        case medicine
        case naturalSciences
        case socialSciences
        // Society & Culture
        case history
        case personalJournals
        case philosophy
        case placesTravel = "Places & Travel"
        // Sports & Recreation
        case amateur
        case collegeHighSchool = "College & High School"
        case outdoor
        case professional
        // Technology
        case gadgets
        case techNews
        case podcasting
        case softwareHowTo = "Software How-To"
    }



}





