//  Created by Viktor Kuzmanov on 3/23/18.
//  Copyright © 2018 Code X Team. All rights reserved.
//

import UIKit

class CategorijaTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonAudio: UIButton!
    @IBOutlet weak var labelCategorijaIme: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
