//
//  Constants.swift
//  DrinkersApp
//
//  Created by Preeteesh Remalli on 14/06/18.
//  Copyright © 2018 Preeteesh Remalli. All rights reserved.
//

import Foundation
//Menu iteams array
 var iteamsArray = ["My Orders","Please Order","SignOut"]
var images = ["1.jpeg","2.jpeg","3.jpeg","4.jpeg","5.jpeg"]
let googleKey = "AIzaSyCUyziYISlAi5fhzDQQ0YLW0Oyj1cXfDIM"

struct PaytmConstants{
    public static let MID               = "KrXKny61602156009193"
    public static let CHANNEL_ID        = "WAP"
    public static let INDUSTRY_TYPE_ID  = "Retail"
    public static let WEBSITE           = "WEBSTAGING"
    //public static let CALLBACK_URL      = "https://pguat.paytm.com/paytmchecksum/paytmCallback.jsp"
    public static let CALLBACK_URL      = "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID="
}
