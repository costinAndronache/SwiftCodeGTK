import GTKLib
import Foundation

class TreeView {
	typealias TreeIterPtr = UnsafeMutablePointer<GtkTreeIter>
	typealias TreeStorePtr = UnsafeMutablePointer<GtkTreeStore>
	typealias TreeViewPtr = UnsafeMutablePointer<GtkTreeView>
	
	typealias PopulateRootFcn = (TreeModel<String>.Node, TreeIterPtr?) -> Void
	
	private(set) var treeView: TreeViewPtr?	
	let treeModel = TreeModel<String>()
	
	init() {
		self.treeView = buildView(columnTitle: "")
		treeModel.onUpdatesFinished = { [weak self] in 
			self?.rebindModel()
		}
	}
	
	private func buildView(columnTitle: String) -> TreeViewPtr? {
		
		let view = gtk_tree_view_new()!.rebound(to: GtkTreeView.self)
		let col = gtk_tree_view_column_new()
		gtk_tree_view_column_set_title(col, columnTitle)
		gtk_tree_view_append_column(view, col)

		let renderer = gtk_cell_renderer_text_new()
		gtk_tree_view_column_pack_start(col, renderer, true.cast())
		gtk_tree_view_column_add_attribute(col, renderer, "text", 0)
		return view

	}
	
	
	private func buildTreeStoreFor(model: TreeModel<String>) -> TreeStorePtr {
	
		let treeStore = tree_store_one_column(.string)
		
		var populateRootFcn: PopulateRootFcn?
		populateRootFcn = { rootNode, myIter in 
			gtk_tree_store_set_value(treeStore, myIter, 0, make_string_value(rootNode.data))
			let childIter = TreeIterPtr.allocate(capacity: 1)
			
			rootNode.children.forEach { childRoot in 
				gtk_tree_store_append(treeStore, childIter, myIter)
				populateRootFcn?(childRoot, childIter)
			}
			childIter.deallocate()
		}
		
		let topLevelIter = TreeIterPtr.allocate(capacity: 1)

		model.roots.forEach { node in 
			
			gtk_tree_store_append(treeStore, topLevelIter, nil)
			populateRootFcn?(node, topLevelIter)
		}
		
		topLevelIter.deallocate()
		return treeStore!
	
	}
	
	private func rebindModel() {
		gtk_tree_view_set_model(treeView, nil)
		let store = buildTreeStoreFor(model: treeModel)
		gtk_tree_view_set_model(treeView, store.opaque)
	}
	
}