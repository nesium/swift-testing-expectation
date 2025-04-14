// MIT License
//
// Copyright (c) 2025 Dan Federman
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
import Foundation

public actor Expectations {
	// MARK: Initialization

	public init(_ expectations: [Expectation]) {
		self.expectations = expectations
	}

	public init(_ expectations: Expectation...) {
		self.init(expectations)
	}

	// MARK: Public

	@available(iOS 16.0, *)
	public func fulfillment(
		within duration: Duration,
		filePath: String = #filePath,
		fileID: String = #fileID,
		line: Int = #line,
		column: Int = #column
	) async {
		await withTaskGroup(of: Void.self) { taskGroup in
			for expectation in expectations {
				taskGroup.addTask {
					await expectation.fulfillment(
						within: duration,
						filePath: filePath,
						fileID: fileID,
						line: line,
						column: column
					)
				}
			}
			await taskGroup.waitForAll()
		}
	}

	@available(
		iOS,
		deprecated: 16.0,
		renamed: "fulfillment(within:filePath:fileID:line:column:)",
		message: "Convert TimeInterval to Duration using '.seconds(timeInterval)'"
	)
	public func fulfillment(
		timeout seconds: TimeInterval,
		filePath: String = #filePath,
		fileID: String = #fileID,
		line: Int = #line,
		column: Int = #column
	) async {
		await withTaskGroup(of: Void.self) { taskGroup in
			for expectation in expectations {
				taskGroup.addTask {
					await expectation.fulfillment(
						timeout: seconds,
						filePath: filePath,
						fileID: fileID,
						line: line,
						column: column
					)
				}
			}
			await taskGroup.waitForAll()
		}
	}

	// MARK: Private

	private let expectations: [Expectation]
}
