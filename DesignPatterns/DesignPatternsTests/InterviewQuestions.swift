//
//  InterviewQuestions.swift
//  DesignPatternsTests
//
//  Created by Laurentiu Dascalu on 2/6/21.
//  Copyright © 2021 Laurentiu Dascalu. All rights reserved.
//

import Foundation
import XCTest

class InterviewQuestions : XCTestCase {

    func testFirstArrayProblem() {
        // Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
        let nums = [1, 2, 3, 4, 5, 4, 3, 2]
        let n = nums.count

        var left = [Int](repeating: 0, count: n)
        var right = [Int](repeating: 0, count: n)

        for i in 0..<n {
            if i == 0 {
                left[i] = nums[i]
                right[n - i - 1] = nums[n - i - 1]
            } else {
                left[i] = nums[i] * left[i - 1]
                right[n - i - 1] = nums[n - i - 1] * right[n - i]
            }
        }

        var output = [Int](repeating: 0, count: n)
        for i in 0..<n {
            if i == 0 {
                output[i] = right[i + 1]
            } else if i == n - 1 {
                output[i] = left[i - 1]
            } else {
                output[i] = left[i - 1] * right[i + 1]
            }
        }

        let allProduct = nums.reduce(into: 1, { (x, y) in x *= y })
        let expectedResult = nums.map { allProduct / $0 }

        XCTAssertEqual(output, expectedResult)
    }

    func testSecondArrayQuestion() {
        //Given a non-empty string s, you may delete at most one character. Judge whether you can make it a palindrome
        XCTAssert(InterviewQuestions.stringIsPalindromeDeletingAtMostOneChar("12321"))
        XCTAssert(InterviewQuestions.stringIsPalindromeDeletingAtMostOneChar("1232"))
        XCTAssertFalse(InterviewQuestions.stringIsPalindromeDeletingAtMostOneChar("12325"))
    }

    func testThirdArrayQuestion() {
        //Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers
        var array = [1, 2, 3]
        InterviewQuestions.nextPermutation(&array)
        XCTAssertEqual(array, [1, 3, 2])


        var array2 = [3, 2, 1]
        InterviewQuestions.nextPermutation(&array2)
        XCTAssertEqual(array2, [1, 2, 3])

        var array3 = [1, 1, 5]
        InterviewQuestions.nextPermutation(&array3)
        XCTAssertEqual(array3, [1, 5, 1])

        var array4 = [1]
        InterviewQuestions.nextPermutation(&array4)
        XCTAssertEqual(array4, [1])

        var array5 = [3, 5, 4, 1]
        InterviewQuestions.nextPermutation(&array5)
        XCTAssertEqual(array5, [4, 1, 3, 5])

        var array6 = [1, 3, 2]
        InterviewQuestions.nextPermutation(&array6)
        XCTAssertEqual(array6, [2, 1, 3])
    }

    func testFourthArrayQuestion() {
        //Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).
        XCTAssertEqual(InterviewQuestions.minimumWindow("abcda", t: "cb"), "bc")
        XCTAssertEqual(InterviewQuestions.minimumWindow("abcda", t: "cba"), "abc")
        XCTAssertEqual(InterviewQuestions.minimumWindow("ADOBECODEBANC", t: "ABC"), "BANC")
        XCTAssertEqual(InterviewQuestions.minimumWindow("a", t: "aa"), "")
        XCTAssertEqual(InterviewQuestions.minimumWindow("a", t: "ab"), "")

        XCTAssertEqual(InterviewQuestions.minimumWindow("aa", t: "aa"), "aa")
    }

    func testFifthArrayQuestion() {
        //Given an array of strings strs, group the anagrams together
        let strings = ["eat", "tea", "tan", "ate", "nat", "bat"]
        let expectedResult = [["bat"], ["eat", "tea", "ate"], ["tan", "nat"]]
        XCTAssertEqual(InterviewQuestions.groupAnagrams(strings), expectedResult)

        XCTAssertEqual(InterviewQuestions.groupAnagrams(["", ""]), [["", ""]])
    }

    func testSixthArrayQuestion() {
        //Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid
        XCTAssert(InterviewQuestions.validateInput("(){}[{}]"))
        XCTAssertFalse(InterviewQuestions.validateInput("[(){}[{}]"))
    }

    func testSeventhArrayQuestion() {
        //Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero
        XCTAssertEqual(InterviewQuestions.threeSum([-1, 0, 1, 2, -1, -4]), [[-1, 0, 1], [-1, -1, 2]])
        XCTAssertEqual(InterviewQuestions.threeSum([0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]), [[0, 0, 0]])
    }

    func testReverseDigits() {
        XCTAssertEqual(InterviewQuestions.reverseDigits(123), 321)
        XCTAssertEqual(InterviewQuestions.reverseDigits(-432), -234)

        XCTAssert(InterviewQuestions.palindrome(121))
        XCTAssert(InterviewQuestions.palindrome(-323))
        XCTAssertFalse(InterviewQuestions.palindrome(122))
    }

    func testSwapBits() {
        // 01001001 = 1 + 8 + 64 = 73
        // 00001011 = 1 + 2 + 8 = 11
        XCTAssertEqual(InterviewQuestions.swapBits(73, i: 1, j: 6), 11)
    }

    func testNumberParity() {
        // 1001
        XCTAssert(BitsLookupTable.parity(5))

        // 10000000
        XCTAssertFalse(BitsLookupTable.parity(512))

        XCTAssertFalse(BitsLookupTable.parity(1 << 63))

        XCTAssert(BitsLookupTable.parity((1 << 63) | (1 << 62)))
    }
}

class BitsLookupTable {
    /*
     Compute the parity of a word, coming in as an Int64;
     Use a lookup table, but not for the whole 2^64 numbers.
     */
    private var map: [UInt64 : Int]

    init(withWordSize: Int) {
        map = [UInt64 : Int]()
        for i: UInt64 in 0..<(1 << withWordSize - 1) {
            map[i] = computeParity(i)
        }
    }

    func parity(_ number: UInt64) -> Int {
        return map[number] ?? 0
    }

    private func computeParity(_ i: UInt64) -> Int {
        var x = i
        var result: Int = 0
        while x > 0 {
            x = x & (x - 1)
            result = result ^ 1
        }
        return result
    }
}

extension BitsLookupTable {

    static func parity(_ number: UInt64) -> Bool {
        let kWordSize = 8
        let mask: UInt64 = (1 << kWordSize) - 1

        let table = BitsLookupTable(withWordSize: kWordSize)

        var result = 0
        for i in 0..<8 {
            let currentChunk = (number >> (i * kWordSize)) & mask
            result ^= table.parity(currentChunk)
        }
        return result == 0
    }

}

extension InterviewQuestions {
    static func swapBits(_ number: UInt64, i: Int, j: Int) -> UInt64 {
        // x & (x - 1) clears the least significant bit
        // x & ~(x - 1) clears the least significant bit
        let leftBit = (number >> i) & 1
        let rightBit = (number >> j) & 1
        var result = number
        if leftBit != rightBit {
            result = result ^ UInt64(1 << i | i << j)
        }
        return result
    }

    static func reverseDigits(_ x: Int64) -> Int64 {
        var result: Int64 = 0
        let negativeNumber = x < 0
        var currentValue = (negativeNumber) ? -x : x
        while currentValue > 0 {
            result = result * 10 + currentValue % 10
            currentValue /= 10
        }
        return (negativeNumber) ? -result : result
    }

    static func palindrome(_ x: Int64) -> Bool {
        return x == reverseDigits(x)
    }

    static func stringIsPalindromeDeletingAtMostOneChar(_ string: String) -> Bool {
        let stringIsPalindrome = { (string: String) -> Bool in
            return string == String(string.reversed())
        }

        guard !stringIsPalindrome(string) else {
            return true
        }

        for index in string.indices {
            var mutableString = string
            mutableString.remove(at: index)
            if stringIsPalindrome(mutableString) {
                return true
            }
        }
        return false
    }

    static func validateInput(_ string: String) -> Bool {
        var stack = [Character]()
        for c in string {
            if c == "(" || c == "{" || c == "[" {
                stack.append(c)
            } else if c == ")" || c == "}" || c == "]" {
                guard let x = stack.popLast() else {
                    return false
                }
                if (c == ")" && x == "(") || (c == "]" && x == "[") || (c == "}" && x == "{") {
                    continue
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        return stack.isEmpty
    }

    static func minimumWindow(_ s: String, t: String) -> String {

        if (s.count == 0 || t.count == 0) {
            return ""
        }

        // Dictionary which keeps a count of all the unique characters in t.
        var dictT = [Character : Int]()
        for c in t {
            let count = dictT[c] ?? 0
            dictT[c] = count + 1
        }

        // Number of unique characters in t, which need to be present in the desired window.
        let required = dictT.keys.count

        // Left and Right pointer
        var l = 0
        var r = 0

        // formed is used to keep track of how many unique characters in t
        // are present in the current window in its desired frequency.
        // e.g. if t is "AABC" then the window must have two A's, one B and one C.
        // Thus formed would be = 3 when all these conditions are met.
        var formed = 0

        var windowCounts = [Character : Int]()

        let sArray = Array(s)
        var ans0 = -1
        var ans1 = 0
        var ans2 = 0

        while r < sArray.count {
            let c = sArray[r]

            let count = windowCounts[c] ?? 0
            windowCounts[c] = count + 1

            if
                let y = dictT[c],
                windowCounts[c]! == y
            {
                formed = formed + 1
            }

            while (l <= r && formed == required) {
                let c = sArray[l]
                // Save the smallest window until now.
                if (ans0 == -1 || (r - l + 1) < ans0) {
                    ans0 = r - l + 1
                    ans1 = l
                    ans2 = r
                }

                // The character at the position pointed by the
                // `Left` pointer is no longer a part of the window.
                windowCounts[c] = (windowCounts[c] ?? 0) - 1
                if let x = dictT[c],
                   let y = windowCounts[c],
                   y < x {
                    formed -= 1
                }

                // Move the left pointer ahead, this would help to look for a new window.
                l += 1
            }

            // Keep expanding the window once we are done contracting.
            r += 1
        }

        if ans0 == -1 {
            return ""
        }

        return String(sArray[ans1...ans2])
    }

    static func threeSum(_ nums: [Int]) -> [[Int]] {
        //Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero

        guard nums.count >= 3 else {
            return [[Int]]()
        }

        var results = Set<[Int]>()
        var dups = Set<Int>()
        var seen = [Int : Int]()

        for i in 0..<nums.count - 1 {
            if dups.contains(nums[i]) {
                continue
            }
            dups.insert(nums[i])
            for j in (i + 1)..<nums.count {
                let complement = -nums[i] - nums[j]
                if let sValue = seen[complement], sValue == i {
                    let solution = [nums[i], nums[j], complement].sorted()
                    results.insert(solution)
                }
                seen[nums[j]] = i
            }
        }

        return Array(results)
    }


    static func groupAnagrams(_ strs: [String]) -> [[String]] {
        var anagrams = [String : [String]]()
        for str in strs {
            let sorted = (str.count > 0) ? String(str.sorted()) : str
            if anagrams[sorted] == nil {
                anagrams[sorted] = [String]()
            }
            anagrams[sorted]?.append(str)
        }

        var result = [[String]]()
        anagrams.values.forEach {
            result.append(Array($0))
        }

        return result
    }

    static func nextPermutation(_ nums: inout [Int]) {
        guard nums.count > 1 else {
            return
        }

        var i = nums.count - 2

        while i >= 0 && nums[i + 1] <= nums[i] {
            i -= 1
        }

        if i >= 0 {
            var j = nums.count - 1
            while j >= 0 && nums[j] <= nums[i] {
                j -= 1
            }
            let aux = nums[i]
            nums[i] = nums[j]
            nums[j] = aux
        }
        reverse(&nums, start: i + 1)
    }

    static func reverse(_ nums: inout [Int], start: Int) {
        var i = start
        var j = nums.count - 1
        while i < j {
            let aux = nums[i]
            nums[i] = nums[j]
            nums[j] = aux
            i += 1
            j -= 1
        }
    }
}
