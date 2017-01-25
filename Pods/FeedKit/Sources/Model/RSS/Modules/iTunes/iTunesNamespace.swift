//
//  iTunesNamespace.swift
//
//  Copyright (c) 2017 Ben Murphy
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import Foundation

/** 
 
 iTunes Podcasting Tags are de facto standard for podcast syndication. For more information see https://help.apple.com/itc/podcasts_connect/#/itcb54353390
 
*/

open class ITunesNamespace {

    /**
 
     The content you specify in the <itunes:author> tag appears in the Artist column on the iTunes Store. If the tag is not present, the iTunes Store uses the contents of the <author> tag. If <itunes:author> is not present at the RSS feed level, the iTunes Store uses the contents of the <managingEditor> tag.

     */
    open var iTunesAuthor: String?

    /**
 
     Specifying the <itunes:block> tag with a Yes value in:

     - A <channel> tag (podcast), prevents the entire podcast from appearing on the iTunes Store podcast directory
     - An <item> tag (episode), prevents that episode from appearing on the iTunes Store podcast directory

     For example, you might want to block a specific episode if you know that its content would otherwise cause the entire podcast to be removed from the iTunes Store. Specifying any value other than Yes has no effect.

    */
    open var iTunesBlock: Bool?

    /**
 
     Users can browse podcast subject categories in the iTunes Store by choosing a category from the Podcasts pop-up menu in the navigation bar. Use the <itunes:category> tag to specify the browsing category for your podcast.

     You can also define a subcategory if one is available within your category. Although you can specify more than one category and subcategory in your feed, the iTunes Store only recognizes the first category and subcategory. For a complete list of categories and subcategories, see Podcasts Connect categories.

     Note: When specifying categories and subcategories, be sure to properly escape ampersands:

     Single category:

     <itunes:category text="Music" />
     Category with ampersand:

     <itunes:category text="TV &amp; Film" />
     Category with subcategory:

     <itunes:category text="Society &amp; Culture">
     <itunes:category text="History" />
     </itunes:category>
     Multiple categories:

     <itunes:category text="Society &amp; Culture">
     <itunes:category text="History" />
     </itunes:category>
     <itunes:category text="Technology">
     <itunes:category text="Gadgets" />
     </itunes:category>
 
     */
    open var iTunesCategory: ITunesCategory?

    /**
 
     Specify your podcast artwork using the <a href> attribute in the<itunes:image> tag. If you do not specify the <itunes:image> tag, the iTunes Store uses the content specified in the RSS feed image tag and Apple does not consider your podcast for feature placement on the iTunes Store or Podcasts.

     Depending on their device, subscribers see your podcast artwork in varying sizes. Therefore, make sure your design is effective at both its original size and at thumbnail size. Apple recommends including a title, brand, or source name as part of your podcast artwork. For examples of podcast artwork, see the Top Podcasts. To avoid technical issues when you update your podcast artwork, be sure to:

     Change the artwork file name and URL at the same time
     Verify the web server hosting your artwork allows HTTP head requests
     The <itunes:image> tag is also supported at the <item> (episode) level. For best results, Apple recommends embedding the same artwork within the metadata for that episode’s media file prior to uploading to your host server; using Garageband or another content-creation tool to edit your media file if needed.

     Note: Artwork must be a minimum size of 1400 x 1400 pixels and a maximum size of 3000 x 3000 pixels, in JPEG or PNG format, 72 dpi, with appropriate file extensions (.jpg, .png), and in the RGB colorspace. These requirements are different from the standard RSS image tag specifications.
 
     */
    open var iTunesImage: ITunesImage? 



}
