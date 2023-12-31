//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Nicky Taylor on 10/22/23.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    
    @StateObject var paletteStore = PaletteStore(name: "Main")
    
    var body: some Scene {
        DocumentGroup(newDocument: { EmojiArtDocument() }) { config in
            
            EmojiArtDocumentView(document: config.document)
                .environmentObject(paletteStore)
        }
    }
}



//😀😃😄😁😆🥹😅😂🤣😍😌😉🙃🙂😇😊☺️🥲🥰😘😗😙😚😋😛😝😜😏🥳🤩🥸😎🤓🧐🤨🤪😒😞😔😟😕🙁☹️😣😖🤬😡😠😤😭😢🥺😩😫🤯😳🥵🥶😶‍🌫️😱😨😰😥🫠🤫🫡🫢🤭🫣🤔🤗😓🤥😶🫥😐🫤😑😬🙄😯😮‍💨😪🤤😴🥱😲😮😧😦😵😵‍💫🤐🥴🤢🤮🤧😷🤒💩🤡👺👹👿😈🤠🤑🤕👻💀☠️👽👾🤖🎃😺😸🤲🫶😾😿🙀😽😼😻😹👐🙌👏🤝👍👎✊🤛👊🤏🤌👌🤘🤟🫰✌️🤞🤜🫳🫴👈👉👆👇☝️✋🤚🖕🦾💪🫱🫲🤙👋🖖🖐✍️🙏🫵🦶🦵🦿💄💋👄👀👁👣👃🦻👂👅🦷🫦🫀🫁🧠🗣👤👥🫂👶👧👩‍🦰👨‍🦱🧑‍🦱👩‍🦱👨🧑👩👦🧒🧑‍🦰👨‍🦰👱‍♀️👱👱‍♂️👩‍🦳🧑‍🦳👨‍🦳👩‍🦲👲👴🧓👵🧔‍♂️🧔🧔‍♀️👨‍🦲🧑‍🦲👳‍♀️👳👳‍♂️🧕👮‍♀️👮👮‍♂️👷‍♀️👷🧑‍⚕️👩‍⚕️🕵️‍♂️🕵️🕵️‍♀️💂‍♂️💂💂‍♀️👷‍♂️👨‍⚕️👩‍🌾🧑‍🌾👩‍🍳🧑‍🍳👨‍🍳👩‍🎓🧑‍🎓👨‍🌾🧑‍🏭👩‍🏭👨‍🏫🧑‍🏫👩‍🏫👨‍🎤🧑‍🎤👩‍🎤👨‍🎓👨‍🏭👩‍💻🧑‍💻👨‍💻👩‍💼🧑‍💼👨‍💼👩‍🔧🧑‍🔧🧑‍🚒👩‍🚒👨‍🎨🧑‍🎨👩‍🎨👨‍🔬🧑‍🔬👩‍🔬👨‍🔧👨‍🚒👩‍✈️🧑‍✈️👨‍✈️👩‍🚀🧑‍🚀👨‍🚀👩‍⚖️🧑‍⚖️🫅👸🤵‍♂️🤵🤵‍♀️👰‍♂️👰👰‍♀️👨‍⚖️🤴🥷🦸‍♀️🦸🦸‍♂️🦹🦹‍♂️🤶🦹‍♀️🧌🧝‍♂️🧝🧝‍♀️🧙‍♂️🧙🧙‍♀️🎅🧑‍🎄🧛‍♀️🧛🧛‍♂️🧟‍♀️🧟🧟‍♂️🧞‍♀️🧞🧞‍♂️🫄🤰👼🧚‍♂️🧚🧚‍♀️🧜‍♂️🧜🧜‍♀️🫃🤱👩‍🍼🧑‍🍼👨‍🍼🙇‍♀️🙇🙇‍♂️💁‍♀️🙋‍♀️🙆‍♂️🙆🙆‍♀️🙅‍♂️🙅🙅‍♀️💁‍♂️💁🙋🙋‍♂️🧏‍♀️🧏🧏‍♂️🤦‍♀️🤦🤦‍♂️🤷‍♀️💇‍♀️🙍‍♂️🙍🙍‍♀️🙎‍♂️🙎🙎‍♀️🤷‍♂️🤷💇💇‍♂️💆‍♀️💆💆‍♂️🧖‍♀️🧖🧖‍♂️💅🧑‍🦽👩‍🦽🕴👯‍♂️👯👯‍♀️🕺💃🤳👨‍🦽🧑‍🦼👨‍🦼🚶‍♀️🚶🚶‍♂️👩‍🦯🧑‍🦯🧍🧍‍♀️🏃‍♂️🏃🏃‍♀️🧎‍♂️🧎🧎‍♀️👨‍🦯🧍‍♂️👫👭👬👩‍❤️‍👨👩‍❤️‍👩💑👨‍❤️‍👨👩‍❤️‍💋‍👨👩‍👩‍👦👨‍👩‍👧‍👧👨‍👩‍👦‍👦👨‍👩‍👧‍👦👨‍👩‍👧👨‍👩‍👦👨‍❤️‍💋‍👨💏👩‍❤️‍💋‍👩👩‍👩‍👧👩‍👩‍👧‍👦👩‍👩‍👦‍👦👩‍👩‍👧‍👧👨‍👨‍👦👨‍👨‍👧👨‍👨‍👧‍👦👨‍👨‍👦‍👦👨‍👨‍👧‍👧👨‍👦‍👦👨‍👧‍👦👨‍👧👨‍👦👩‍👧‍👧👩‍👦‍👦👩‍👧‍👦👩‍👧👩‍👦👨‍👧‍👧🪢🧶🧵🪡🧥🥼🦺👚👘🩱👙👗👔🩳🩲👖👕🥻🩴🥿👠👡👢👞👟🥾🪖⛑👒🎓🧢🎩🧣🧤🧦👑💍👝👛👜💼🎒🧳👓🌂🥽🕶❤️🧡💛💚💙💜🤎🖤🤍💖💗💓💞💕❣️❤️‍🩹❤️‍🔥💔💘💝♡♥︎❥❦❧☙❢এლდღɞʚෆᰔᩚᰔঞଓᜊᥫ᭡ꨄஐᦗ🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🙈🐵🐸🐽🐷🐮🦁🐯🐨🙉🙊🐒🐔🐧🐦🐤🐣🐥🐝🦄🐴🐗🐺🦇🦉🦅🦆🪱🐛🦋🐌🐞🐜🪰🪲🪳🦖🦎🐍🐢🦂🕸🕷🦗🦟🦕🐙🦑🦐🦞🦀🐡🐠🐟🦓🐆🐅🐊🦭🦈🐋🐳🐬🦍🦧🦣🐘🦛🦏🐪🐫🦒🐑🐏🐖🐎🐄🐂🐃🦬🦘🦙🐐🦌🐕🐩🦮🐕‍🦺🐈🐈‍⬛🕊🦩🦢🦜🦚🦤🦃🐓🪶🐇🦝🦨🦡🦫🦦🦥🐁🐀🌳🌲🎄🌵🐲🐉🐾🦔🐿🌴🪵🌱🌿☘️🍀🎍🪴🎋🪨🪸🐚🍄🪹🪺🍁🍂🍃🌾💐🌷🌹🥀🪷🌺🌸🌼🌗🌖🌕🌚🌜🌛🌝🌞🌻🌘🌑🌒🌓🌔🌙🌎🌍🌏🔥💥☄️⚡️✨🌟⭐️💫🪐🌪🌈☀️🌤⛅️🌥☁️🌦🌧💧💨🌬⛄️☃️❄️🌨🌩⛈💦🫧☔️☂️🌊🍏🍎🍐🍊🍋🍌🍉🍇🍓🍅🥝🥥🍍🥭🍑🍒🍈🫐🍆🥑🥦🥬🥒🌶🫑🌽🥕🥖🍞🥯🥐🍠🥔🧅🧄🫒🥨🧀🥚🍳🧈🥞🧇🥓🥩🥪🫓🍕🍟🍔🌭🦴🍖🍗🥙🧆🌮🌯🫔🥗🥘🫕🥫🦪🥟🍱🍣🍛🍲🍜🍝🫙🍤🍙🍚🍘🍥🥠🥮🍢🍡🍭🍮🎂🍰🧁🥧🍦🍨🍧🍬🍫🍿🍩🍪🌰🥜🫘🍯🧋🥤🧃🍵☕️🫖🍼🫗🥛🍶🍺🍻🥂🍷🥃🍸🍹🧉🧂🥢🥡🥣🍽🍴🥄🧊🍾⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🪃🏏🥍🏑🏒🏸🏓🪀🎱🥅⛳️🪁🛝🏹🎣🤿🥊🥋🏂⛷🎿🥌⛸🛷🛼🛹🎽🪂🏋️‍♀️🏋️🏋️‍♂️🤼‍♀️🤼🤼‍♂️🤸‍♀️🤸🏌️‍♀️🤾‍♂️🤾🤾‍♀️🤺⛹️‍♂️⛹️⛹️‍♀️🤸‍♂️🏌️🏌️‍♂️🏇🧘‍♀️🧘🧘‍♂️🏄‍♀️🏄🏄‍♂️🚣‍♂️🚣🚣‍♀️🤽‍♂️🤽🤽‍♀️🏊‍♂️🏊🏊‍♀️🧗‍♀️🧗🧗‍♂️🚵‍♀️🚵🚵‍♂️🚴‍♀️🚴🚴‍♂️🎫🎗🏵🎖🏅🥉🥈🥇🏆🎟🎪🤹‍♀️🤹🤹‍♂️🎭🩰🎨🎬🪗🎺🎷🪘🥁🎹🎼🎧🎤🎸🪕🎻🎲♟🎯🎳🎮🎰🧩🚗🚕🚙🚌🚎🏎🚓🚑🚒🩼🦼🦽🦯🚜🚛🚚🛻🚐🛴🚲🛵🏍🛺🛞🚨🚔🚍🚝🚞🚋🚃🚟🚠🚡🚖🚘🚄🚅🚈🚂🚆🚇🚊🚉✈️🛶🚁🛸🚀🛰💺🛩🛬🛫⛵️🚤🛥🛳🚢🛟⛴⚓️🪝🗼🗽🗿🗺🚏🚥🚦🚧⛽️🏰🏯🏟🎡🎢🎠⛲️⛱🏖🛖⛺️🏕🗻🏔⛰🌋🏜🏝🏠🏡🏘🏚🏗🏭🏢🏬🏣🏛💒🏩🏫🏪🏨🏦🏥🏤⛪️🕌🕍🛕🕋⛩🛤🛣🗾🌆🌇🎆🎇🌠🌄🌅🏞🎑🏙🌃🌌🌉🌁⌚️📱📲💻⌨️🖥🖨🖱🖲📸📷📼📀💿💾💽🗜🕹📹🎥📽🎞📞☎️📟📠📺🕰⏰⏲⏱🧭🎛🎚🎙📻⌛️⏳📡🔋🪫🔌💡🔦🕯🪙💷💶💴💵💸🛢🧯🪔💰💳🪪💎⚖️🪜🧰🪛🔧🧱🪤⚙️🔩🪚⛏🛠⚒🔨⛓🧲🔫💣🧨🪓🔪🗡⚔️🧿📿🔮🏺⚱️🪦⚰️🚬🛡🪬💈⚗️🔭🔬🕳🩻🩹🩺🧹🌡🧪🧫🦠🧬🩸💉💊🪠🧺🧻🚽🚰🚿🛁🛀🧼🚪🗝🔑🛎🧴🪣🧽🪒🪥🪑🛋🛏🛌🧸🪆🖼🪞🪟🎊🪅🪄🎀🎏🎈🎁🛒🛍🎉🎎🏮🎐🪩🧧✉️📩📨📫📪🪧🏷📦📤📥💌📧📬📭📮📯📜📃📄📑🧾📇🗑📅📆🗓🗒📉📈📊🗃🗳🗄📋📂📁🗂🗞📰📖📚📙📘📗📕📒📔📓🔖🧷🔗📎🖇📐📏🧮📌✏️📝🖍🖌✒️🖋🖊✂️📍🔍🔎🔏🔐🔒🔓❤️🧡💛💚💙💜🤎🖤🤍⚪️⚫️🟤🟣🔵🟢🟡🟠🔴🟥🟧🟨🟩🟦🟫⬛️⬜️❤️‍🩹❣️❤️‍🔥💔🏿🏾🏽🏼🏻💕💞💓💗💖💘💝💟☮️☦️☯️🕎🔯✡️☸️🕉☪️✝️🛐⛎♈️♉️♊️♋️♌️♍️♎️⚛️🆔♓️♒️♑️♐️♏️🉑☢️📴📳🈶🈚️🈸🈺🈷️✴️🈲🈹🈵🈴㊗️㊙️🉐💮🆚🅰️🅱️🆎🅾️🆑🆘



