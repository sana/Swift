# Swift

Learning Swift the hard way!

This repository contains a bunch of projects I've hacked, while trying to
learn the Swift programming language. The language itself is nice, although
I noticed a few problems:
* The toolchain is still under development
* Alot of confusion around Swift 1.0 and Swift 2.0
* Swift 5 solved alot of pain points I've seen in the past.

Most of the projects are actually online programming challanges.

* CommonMarkExample is a simple Swift wrapper over cmark, a C library
https://commonmark.org/
* DesignPatterns contains implementations of various design patterns
(Design Patterns: Elements of Reusable Object-Oriented Software) and
standard algorithms studied in CS, and that are popular in interview
questions;
* Update FlickrSearch
* HitList is a simple app that uses CoreData to persist the state of
the app. You can alter the state via a navigation item and the table
view updates intelligently, via tableView.insertRows:with:, instead
of calling reloadData.
Note that the data is exposed to Spotlight search.
* SimpleTableView is a project that implements simple functionality
of a table view controller, a table view, by implementing a custom
table view datasource and delegate.

