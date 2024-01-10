diff --git a/onnxruntime/core/providers/cpu/nn/string_normalizer.cc b/onnxruntime/core/providers/cpu/nn/string_normalizer.cc
index dd2e672..81241da 100644
--- a/onnxruntime/core/providers/cpu/nn/string_normalizer.cc
+++ b/onnxruntime/core/providers/cpu/nn/string_normalizer.cc
@@ -82,7 +82,11 @@ class Locale {
  public:
   explicit Locale(const std::string& name) {
     ORT_TRY {
+      #if !defined(__QNX__)
       loc_ = std::locale(name.c_str());
+      #else
+      loc_ = std::locale("C");
+      #endif
     }
     ORT_CATCH(const std::runtime_error& e) {
       ORT_HANDLE_EXCEPTION([&]() {
