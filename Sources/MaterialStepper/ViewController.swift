//
//  ViewController.swift
//  MaterialStepper
//
//  Created by julien on 16/05/2018.
//  Copyright © 2018 juliensimmer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /// Header IBOutlets
    @IBOutlet weak var headerTableView: UITableView!
    @IBOutlet weak var headerMainView: UIView!
    @IBOutlet weak var headerArrowImageView: UIImageView!
    @IBOutlet weak var headerNumberLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var topMainViewK: NSLayoutConstraint!
    
    var data: [Section] = []
    var dataListed: [Any] = []
    var isHeaderDisplay = false
    var firstSectionVisible = 0
    let nbrSectionToPreview = 3, sectionRowHeight = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = Section.initStatic()
        
        // init dataListed
        for section in data {
            dataListed.append(section)
            for element in section.elements {
                dataListed.append(element)
            }
        }
        
        // init view state
        headerTableView.isHidden = true
        updateHeaderFor(section: data[0])
        topMainViewK.constant = 0
        self.headerArrowImageView.transform = CGAffineTransform(rotationAngle: .pi/2)
    }
    
    private func animateDisplayingHeader(to: Bool) {
        if isHeaderDisplay == to {
            headerTableView.reloadData()
            headerTableView.alpha = to ? 1 : 0
            headerTableView.isHidden = to
            headerMainView.alpha = to ? 0 : 1
            headerMainView.isHidden = !to
            topMainViewK.constant = to ? 0 : CGFloat(sectionRowHeight * (nbrSectionToPreview - 1))
            UIView.animate(withDuration: 0.3, animations: {
                self.headerTableView.alpha = to ? 0 : 1
                self.headerMainView.alpha = to ? 1 : 0
                self.headerArrowImageView.transform = CGAffineTransform(rotationAngle: to ? .pi/2 : -.pi/2 + 0.001)
                self.view.layoutIfNeeded()
            }) { (_) in
                self.headerTableView.isHidden = to
                self.headerMainView.isHidden = !to
                self.isHeaderDisplay = !to
            }
        }
    }
    
    @IBAction func buttonActionToDisplayHeader(_ sender: Any) {
        animateDisplayingHeader(to: false)
    }
    
    @IBAction func buttonActionToHideHeader(_ sender: Any) {
        animateDisplayingHeader(to: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == headerTableView ? data.count : dataListed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == headerTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SectionCell
            let firstSectionVisible = detectFirstSectionVisible()
            let highlight = firstSectionVisible != nil ? firstSectionVisible! == indexPath.row : false
            cell.setup(forTitle: data[indexPath.row].title, atIndexRow: indexPath.row, over: data.count, highlight: highlight)
            return cell
        } else if tableView == mainTableView {
            if let section = dataListed[indexPath.row] as? Section {
                let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell") as! SectionCellInElementTable
                cell.setup(title: section.title)
                return cell
            } else {
                let element = dataListed[indexPath.row] as! Element
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ElementCell
                cell.delegate = self
                cell.setup(forElement: element, indexRow: indexPath.row)
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension ViewController: ElementCellDelegate {
    func didSwitch(to isOn: Bool, indexRow: Int) {
        if let element = dataListed[indexRow] as? Element {
            dataListed.remove(at: indexRow)
            let newElement = Element(title: element.title, isActivate: isOn)
            dataListed.insert(newElement, at: indexRow)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == headerTableView {
            animateDisplayingHeader(to: true)
            var countSection = -1, indexToScroll = 0
            for i in 0..<dataListed.count {
                if dataListed[i] is Section {
                    countSection += 1
                }
                if countSection == indexPath.row {
                    indexToScroll = i
                    break
                }
            }
            mainTableView.scrollToRow(at: IndexPath(row: indexToScroll, section: 0), at: .top, animated: true)
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == mainTableView {
            if let indexInData = detectFirstSectionVisible() {
                if indexInData != firstSectionVisible {
                    firstSectionVisible = indexInData
                    updateHeaderFor(section: data[indexInData])
                    headerTableView.reloadSections(IndexSet(integer: 0), with: .fade)
                }
            }
        }
    }
    
    private func detectFirstSectionVisible() -> Int? {
        if let firstVisibleRow = mainTableView.indexPathsForVisibleRows?.first?.row {
            if let section = dataListed[firstVisibleRow] as? Section {
                if let indexFound = data.index(where: { $0.index == section.index }) {
                    return indexFound
                }
            } else {
                for i in stride(from: firstVisibleRow - 1, to: -1, by: -1) {
                    if let section = dataListed[i] as? Section {
                        if let indexFound = data.index(where: { $0.index == section.index }) {
                            return indexFound
                        }
                        break
                    }
                }
            }
        }
        return nil
    }
    
    private func updateHeaderFor(section: Section) {
        UIView.animate(withDuration: 0.3, animations: {
            self.headerNumberLabel.text = "\(section.index + 1)/\(self.data.count)"
            self.headerLabel.text = section.title
        })
    }
}
