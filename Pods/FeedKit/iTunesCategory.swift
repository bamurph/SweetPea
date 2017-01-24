//
//  iTunesCategory.swift
//  Pods
//
//  Created by Ben Murphy on 1/24/17.
//
//

import Foundation

public enum ITunesCategory {
    case arts(ArtsSubcategory?)
    case business(BusinessSubcategory?)
    case comedy
    case education(EducationSubcategory?)
    case gamesHobbies(GamesHobbiesSubcategory?)
    case governmentOrganizations(GovernmentOrganizationsSubcategory?)
    case health(HealthSubcategory?)
    case kidsFamily
    case music
    case newsPolitics
    case religionSpirituality(ReligionSpritualitySubcategory?)
    case scienceMedicine(ScienceMedicineSubcategory?)
    case societyCulture(SocietyCultureSubcategory?)
    case sportsRecreation(SportsRecreationSubcategory?)
    case technology(TechnologySubcategory?)
    case tvFilm

    public enum ArtsSubcategory: String {
        case design
        case fashionBeauty = "Fashion & Beauty"
        case food
        case literature
        case performingArts
        case visualArts
    }

    public enum BusinessSubcategory: String {
        case businessNews
        case careers
        case investing
        case managementMarketing = "Management & Marketing"
        case shopping
    }

    public enum EducationSubcategory: String {
        case educationalTechnology
        case higherEducation
        case k12 = "K-12"
        case languageCourses
        case training
    }

    public enum GamesHobbiesSubcategory: String {
        case automotive
        case aviation
        case gamesHobbies
        case otherGames
        case videoGames
    }

    public enum GovernmentOrganizationsSubcategory: String {
        case local
        case national
        case nonProfit = "Non-Profit"
        case regional
    }

    public enum HealthSubcategory: String {
        case alternativeHealth
        case fitnessNutrition = "Fitness & Nutrition"
        case selfHelp = "Self-Help"
        case sexuality
    }

    public enum ReligionSpritualitySubcategory: String {
        case buddhism
        case christianity
        case hinduism
        case islam
        case judaism
        case other
        case spirituality
    }

    public enum ScienceMedicineSubcategory: String {
        case medicine
        case naturalSciences
        case socialSciences
    }

    public enum SocietyCultureSubcategory: String {
        case history
        case personalJournals
        case philosophy
        case placesTravel = "Places & Travel"
    }

    public enum SportsRecreationSubcategory: String {
        case amateur
        case collegeHighSchool = "College & High School"
        case outdoor
        case professional
    }

    public enum TechnologySubcategory: String {
        case gadgets
        case techNews
        case podcasting
        case softwareHowTo = "Software How-To"
    }

    init?(category: String) {
        if category == "Arts" { self = .arts(nil) }
        if category == "Business" { self = .business(nil) }
        if category == "Comedy" { self = .comedy }
        if category == "Education" { self = .education(nil) }
        if category == "Games &  Hobbies" { self = .education(nil) }
        if category == "Government & Organizations" { self = .gamesHobbies(nil) }
        if category == "Health" { self = .health(nil) }
        if category == "Kids & Family" { self = .kidsFamily }
        if category == "Music" { self = .music }
        if category == "News & Politics" { self = .newsPolitics }
        if category == "Religion & Spirituality" { self = .religionSpirituality(nil) }
        if category == "Science & Medicine" { self = .scienceMedicine(nil) }
        if category == "Society & Culture" { self = .societyCulture(nil) }
        if category == "Sports & Recreation" { self = .sportsRecreation(nil) }
        if category == "Technology" { self = .technology(nil) }
        if category == "TV & Film" { self = .tvFilm }

        return nil
    }

    init?(category: ITunesCategory, subCategory: String?) {
        guard let s = subCategory else { self = category; return }

        switch category {
        case .arts(_):
            self = .arts(ArtsSubcategory(rawValue: s))
        case .business(_):
            self = .business(BusinessSubcategory(rawValue: s))
        case .comedy: self = .comedy
        case .education(_):
            self = .education(EducationSubcategory(rawValue: s))
        case .gamesHobbies(_):
            self = .gamesHobbies(GamesHobbiesSubcategory(rawValue: s))
        case .governmentOrganizations(_):
            self = .governmentOrganizations(GovernmentOrganizationsSubcategory(rawValue: s))
        case .health(_):
            self = .health(HealthSubcategory(rawValue: s))
        case .kidsFamily: self = .kidsFamily
        case .music: self = .music
        case .newsPolitics: self = .newsPolitics
        case .religionSpirituality(_):
            self = .religionSpirituality(ReligionSpritualitySubcategory(rawValue: s))
        case .scienceMedicine(_):
            self = .scienceMedicine(ScienceMedicineSubcategory(rawValue: s))
        case .societyCulture(_):
            self = .societyCulture(SocietyCultureSubcategory(rawValue: s))
        case .sportsRecreation(_):
            self = .sportsRecreation(SportsRecreationSubcategory(rawValue: s))
        case .technology(_):
            self = .technology(TechnologySubcategory(rawValue: s))
        case .tvFilm: self = .tvFilm
        }
    }

    init?(category: String, subCategory: String?) {
        guard let justCat = ITunesCategory(category: category) else { return nil }

        let fullCat = ITunesCategory(category: justCat, subCategory: subCategory)

        if fullCat != nil { self = fullCat! }

        return nil

    

    }
        
        
        
        
}


