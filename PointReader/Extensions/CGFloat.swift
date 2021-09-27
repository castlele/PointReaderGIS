//
//  CGFloat.swift
//  PointReader
//
//  Created by Nikita Semenov on 27.09.2021.
//

import Foundation

extension CGFloat {
	init?(_ strNum: String) {
		guard let doubleNum = Double(strNum) else {
			return nil
		}
		self.init(doubleNum)
	}
}
