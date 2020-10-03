#ifndef GTKLibSwiftHelpers
#define GTKLibSwiftHelpers

#include <gtk/gtk.h>

static gulong g_signal_connect_swift(void *instance, char *signal, void(*handler)(void), void *data) {
	return g_signal_connect(instance, signal, handler, data);
}

static gulong g_signal_connect_swift_app(void *instance, char *signal, void(*handler)(GtkApplication*, gpointer), void *data) {
	return g_signal_connect(instance, signal, handler, data);
}


#endif