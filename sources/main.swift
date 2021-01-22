import Foundation
import GTKLib


func buildTreeView() -> TreeView {

	let view = TreeView()
	
	
	view.treeModel.mutate { mut in 
	
		let r1 = mut.addRoot("Root one")
		let r2 = mut.addRoot("Root two")
		
		let cr1 = mut.addChild(r1, "Child one")
		let cr2 = mut.addChild(r2, "Child two")
		
		let ccr1 = mut.addChild(cr1, "Child child one")
	
	}
	
	return view
}

func insertButtonInto(container: UnsafeMutablePointer<GtkContainer>?) {
	let button_box = gtk_button_box_new(GTK_ORIENTATION_HORIZONTAL)
	gtk_container_add (container, button_box)
	let button = gtk_button_new_with_label("Hello World from swift")
	gtk_container_add (button_box?.rebound(to: GtkContainer.self), button)
}

func insertTreeInto(container: UnsafeMutablePointer<GtkContainer>?) {

  let vbox = gtk_vbox_new(false.cast(), 2)!;
  gtk_container_add(container, vbox);

  let view = buildTreeView()
  let selection = gtk_tree_view_get_selection(view.treeView);

  gtk_box_pack_start(vbox.rebound(), view.treeView?.rebound(), true.cast(), true.cast(), 1);

  let statusbar = gtk_statusbar_new();
  gtk_box_pack_start(vbox.rebound(), statusbar, false.cast(), false.cast(), 1);

 // g_signal_connect(selection, "changed", 
  //G_CALLBACK(on_changed), statusbar); 
}


typealias GTKActivation = @convention(c) (UnsafeMutablePointer<GtkApplication>?, gpointer?) -> Void
let activation: GTKActivation = { appPtr, dataPtr in 
   let windowWidget = gtk_application_window_new(appPtr)
   let window = windowWidget?.rebound(to: GtkWindow.self) 
   gtk_window_set_title(window, makeCString(from: "Swift GTK"))
   gtk_window_set_default_size(window, 200, 200);
   
   insertTreeInto(container: window?.rebound(to: GtkContainer.self))

   gtk_widget_show_all(windowWidget)
}

let flags: GApplicationFlags = G_APPLICATION_FLAGS_NONE
let titlePtr = makeCString(from: "com.myApp.domain")
guard let app = gtk_application_new(titlePtr, flags) else {
   exit(0)
}


let commandLine = CommandLine.arguments
let reboundApp = app.rebound(to: GApplication.self)
g_signal_connect_swift_app(app, makeCString(from: "activate"), activation, nil) 
let status = g_application_run(reboundApp, CommandLine.argc, commandLineToCArgs(commandLine: commandLine))
print("imported \(app)")
