//
//  SPBookingRequestDetailsTopTableViewCell.swift
//  PamperMoi
//
//  Created by Vizteck on 19/02/2018.
//  Copyright © 2018 Umair Afzal. All rights reserved.
//

import UIKit

protocol SampleTableViewCellDelegate {
    func didTapAcceptButton(cell: SampleTableViewCell)
    func didTapRejectButton(cell: SampleTableViewCell)
}

class SampleTableViewCell: UITableViewCell {

    @IBOutlet weak var buttonsStackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var serviceLocationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var buttonsStackView: UIStackView!

    var delegate: SampleTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    class func cellForTableView(tableView: UITableView) -> SampleTableViewCell {
        let kSamleTableViewCellIdentifier = "kSampleTableViewCellIdentifier"
        tableView.register(UINib(nibName: "SampleTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: kSamleTableViewCellIdentifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: kSamleTableViewCellIdentifier) as! SampleTableViewCell
        return cell
    }

    func setupCell(name: String) { // pass required data like this
        nameLabel.text = name
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        delegate?.didTapAcceptButton(cell: self)
    }

    @IBAction func rejectButtonTapped(_ sender: Any) {
        delegate?.didTapRejectButton(cell: self)
    }
}
