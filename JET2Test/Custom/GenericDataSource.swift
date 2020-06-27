//
//  GenericDataSource.swift
//  JET2Test
//
//  Created by VB Padey on 25/06/20.
//  Copyright © 2020 com.JET2.Test. All rights reserved.
//
import Foundation

class GenericDataSource<T> : NSObject {
  var data: Box<[T]> = Box([]) //Array of Data

}
