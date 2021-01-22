import Foundation 

class TreeModel<T> {
	var roots: [Node] = []
	var onUpdatesFinished: () -> Void = { }
	
	func mutate(using block: (Mutations) -> Void) {
		let mutations = Mutations(
		addRoot: self.addRoot,
		addChild: self.addChild,
		addChildren: self.addChildren,
		removeNode: self.removeNode
		)
		
		block(mutations)
		onUpdatesFinished()
	}
	
	private func addRoot(data: T) -> Node {
		let newNode = Node(data: data)
		roots.append(newNode)
		return newNode
	}
	
	private func addChild(forNode: Node, data: T) -> Node {
		let newNode = Node(data: data)
		forNode.children.append(newNode)
		newNode.parent = forNode
		return newNode
	}
	
	private func addChildren(forNode: Node, values: [T]) -> [Node] {
		let newNodes = values.map { self.addChild(forNode: forNode, data: $0) }
		return newNodes
	}
	
	private func removeNode(_ node: Node) {
		node.parent?.children.removeAll { $0 === node }
		roots.removeAll { $0 === node }
	}
}


extension TreeModel {

	class Node {
		let data: T
		var children: [Node] = []
		fileprivate weak var parent: Node? 
		
		fileprivate init(data: T) {
			self.data = data
		}
		
		fileprivate init(data: T, children: [Node]) {
			self.data = data
			self.children = children
			children.forEach { $0.parent = self }
		}
	}
}


extension TreeModel {

	struct Mutations {
		let addRoot: (T) -> Node
		let addChild: (Node, T) -> Node
		let addChildren: (Node, [T]) -> [Node]
		let removeNode : (Node) -> Void
	}
}











