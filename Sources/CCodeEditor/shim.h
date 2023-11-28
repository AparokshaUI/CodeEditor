#pragma once
#include <gtksourceview/gtksource.h>

static void buffer_on_change_cb(void *, void *);

static uint64_t codeeditor_init(uint64_t buffer) {
  g_assert_nonnull(buffer);
  g_assert(GTK_SOURCE_IS_BUFFER(GTK_SOURCE_BUFFER((void *)buffer)));

  return (uint64_t)gtk_source_view_new_with_buffer(buffer);
}

static void codeeditor_set_top_margin(uint64_t codeeditor, int padding) {
  g_assert_nonnull(codeeditor);
  g_assert(GTK_SOURCE_IS_VIEW(GTK_SOURCE_VIEW((void *)codeeditor)));

  gtk_text_view_set_top_margin(codeeditor, padding);
}

static void codeeditor_set_bottom_margin(uint64_t codeeditor, int padding) {
  g_assert_nonnull(codeeditor);
  g_assert(GTK_SOURCE_IS_VIEW(GTK_SOURCE_VIEW((void *)codeeditor)));

  gtk_text_view_set_bottom_margin(codeeditor, padding);
}

static void codeeditor_set_leading_margin(uint64_t codeeditor, int padding) {
  g_assert_nonnull(codeeditor);
  g_assert(GTK_SOURCE_IS_VIEW(GTK_SOURCE_VIEW((void *)codeeditor)));

  gtk_text_view_set_left_margin(codeeditor, padding);
}

static void codeeditor_set_trailing_margin(uint64_t codeeditor, int padding) {
  g_assert_nonnull(codeeditor);
  g_assert(GTK_SOURCE_IS_VIEW(GTK_SOURCE_VIEW((void *)codeeditor)));

  gtk_text_view_set_right_margin(codeeditor, padding);
}

static void codeeditor_set_line_numbers(uint64_t codeeditor,
                                        gboolean show_line_numbers) {
  g_assert_nonnull(codeeditor);
  g_assert(GTK_SOURCE_IS_VIEW(GTK_SOURCE_VIEW((void *)codeeditor)));

  gtk_source_view_set_show_line_numbers(codeeditor, show_line_numbers);
}

static uint64_t codeeditor_init_buffer() {
  return (uint64_t)gtk_source_buffer_new(NULL);
}

static void codeeditor_buffer_init_signals(uint64_t buffer, uint64_t data) {
  GtkTextBuffer *text_buffer;

  g_assert_nonnull(buffer);
  g_assert_nonnull(data);
  g_assert(GTK_SOURCE_IS_BUFFER(GTK_SOURCE_BUFFER((void *)buffer)));

  text_buffer = GTK_SOURCE_BUFFER(buffer);
  swift_retain(data);
  g_signal_connect(text_buffer, "changed", G_CALLBACK(buffer_on_change_cb),
                   (void *)data);
}

static const char *codeeditor_buffer_get_text(uint64_t buffer) {
  g_assert_nonnull(buffer);
  g_assert(GTK_SOURCE_IS_BUFFER(GTK_SOURCE_BUFFER((void *)buffer)));

  GtkTextIter start_iter;
  GtkTextIter end_iter;

  gtk_text_buffer_get_start_iter(buffer, &start_iter);
  gtk_text_buffer_get_end_iter(buffer, &end_iter);

  return gtk_text_buffer_get_text(buffer, &start_iter, &end_iter, TRUE);
}

static void codeeditor_buffer_set_text(uint64_t buffer, const char *text) {
  g_assert_nonnull(buffer);
  g_assert_nonnull(text);
  g_assert(GTK_SOURCE_IS_BUFFER(GTK_SOURCE_BUFFER((void *)buffer)));

  gtk_text_buffer_set_text(buffer, text, -1);
}

static void codeeditor_buffer_set_language(uint64_t buffer,
                                           const char *language) {
  g_assert_nonnull(buffer);
  g_assert(GTK_SOURCE_IS_BUFFER(GTK_SOURCE_BUFFER((void *)buffer)));
  g_assert_nonnull(language);

  GtkSourceLanguageManager *lang_manager =
      gtk_source_language_manager_get_default();
  GtkSourceBuffer *source_buffer = GTK_SOURCE_BUFFER(buffer);

  GtkSourceLanguage *lang =
      gtk_source_language_manager_get_language(lang_manager, language);
  gtk_source_buffer_set_language(source_buffer, lang);
}

static void update_theme_on_settings_change(GObject *settings,
                                            GParamSpec *pspec,
                                            gpointer user_data) {
  GtkSourceBuffer *source_buffer = GTK_SOURCE_BUFFER(user_data);
  g_assert_nonnull(source_buffer);

  gboolean is_dark_mode = FALSE;
  g_object_get(G_OBJECT(settings), "gtk-application-prefer-dark-theme",
               &is_dark_mode, NULL);

  const char *theme_name = is_dark_mode ? "Adwaita-dark" : "Adwaita";

  GtkSourceStyleSchemeManager *scheme_manager =
      gtk_source_style_scheme_manager_get_default();
  GtkSourceStyleScheme *style_scheme =
      gtk_source_style_scheme_manager_get_scheme(scheme_manager, theme_name);
  gtk_source_buffer_set_style_scheme(source_buffer, style_scheme);
}

static void codeeditor_buffer_set_theme_adaptive(uint64_t buffer) {
  g_assert_nonnull(buffer);
  g_assert(GTK_SOURCE_IS_BUFFER(GTK_SOURCE_BUFFER((void *)buffer)));

  GtkSourceBuffer *source_buffer = GTK_SOURCE_BUFFER(buffer);

  GtkSettings *settings = gtk_settings_get_default();
  gboolean is_dark_mode = FALSE;
  g_object_get(G_OBJECT(settings), "gtk-application-prefer-dark-theme",
               &is_dark_mode, NULL);

  const char *theme_name = is_dark_mode ? "Adwaita-dark" : "Adwaita";

  GtkSourceStyleSchemeManager *scheme_manager =
      gtk_source_style_scheme_manager_get_default();
  GtkSourceStyleScheme *style_scheme =
      gtk_source_style_scheme_manager_get_scheme(scheme_manager, theme_name);
  gtk_source_buffer_set_style_scheme(source_buffer, style_scheme);

  g_signal_connect(settings, "notify::gtk-application-prefer-dark-theme",
                   G_CALLBACK(update_theme_on_settings_change), source_buffer);
}

static void print_language_id(gpointer data, gpointer user_data) {
  const gchar *language_id = (const gchar *)data;
  g_print("%s\n", language_id);
}
