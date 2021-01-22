#ifndef GTKLibSwiftHelpers
#define GTKLibSwiftHelpers

#include <gtk/gtk.h>

static gulong g_signal_connect_swift(void *instance, char *signal, void(*handler)(void), void *data) {
	return g_signal_connect(instance, signal, handler, data);
}

static gulong g_signal_connect_swift_app(void *instance, char *signal, void(*handler)(GtkApplication*, gpointer), void *data) {
	return g_signal_connect(instance, signal, handler, data);
}

typedef enum {
	STRING = 0,
	POINTER = 1
} SwiftGTKType;

static gulong remap_swift_gtk(SwiftGTKType type) {
	switch (type) {
		case STRING: return G_TYPE_STRING;
		case POINTER: return G_TYPE_POINTER;
		default: return G_TYPE_STRING;
	}
}

static GtkTreeStore* tree_store_one_column(SwiftGTKType colType) {
	return gtk_tree_store_new(1, remap_swift_gtk(colType));
}


static GValue* make_string_value(const char *string) {
	GValue* value = (GValue*)malloc(sizeof(GValue));
	memset(value, 0, sizeof(GValue));
	g_value_init(value, G_TYPE_STRING);
	g_value_set_string(value, string);
	return value;
}

#endif