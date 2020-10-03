import Foundation
import GTKLib


typealias GTKActivation = @convention(c) (UnsafeMutablePointer<GtkApplication>?, gpointer?) -> Void
let activation: GTKActivation = { appPtr, dataPtr in 
   let windowWidget = gtk_application_window_new(appPtr)
   let window = windowWidget?.rebound(to: GtkWindow.self) 
   gtk_window_set_title(window, makeCString(from: "Swift GTK"))
   gtk_window_set_default_size(window, 200, 200);
   
   let button_box = gtk_button_box_new(GTK_ORIENTATION_HORIZONTAL)
   gtk_container_add (window?.rebound(to: GtkContainer.self), button_box)
   let button = gtk_button_new_with_label(makeCString(from: "Hello World"))
   gtk_container_add (button_box?.rebound(to: GtkContainer.self), button)
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