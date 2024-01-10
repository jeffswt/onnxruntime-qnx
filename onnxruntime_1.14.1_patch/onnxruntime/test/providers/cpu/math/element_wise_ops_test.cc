diff --git a/onnxruntime/test/providers/cpu/math/element_wise_ops_test.cc b/onnxruntime/test/providers/cpu/math/element_wise_ops_test.cc
index 2eec6a2..2a2484e 100644
--- a/onnxruntime/test/providers/cpu/math/element_wise_ops_test.cc
+++ b/onnxruntime/test/providers/cpu/math/element_wise_ops_test.cc
@@ -2661,7 +2661,11 @@ TEST(MathOpTest, Mean_8) {
 #ifdef _LIBCPP_VERSION
 #define MATH_NO_EXCEPT
 #else
-#define MATH_NO_EXCEPT noexcept
+  #if !defined(__QNX__)
+  #define MATH_NO_EXCEPT noexcept
+  #else
+  #define MATH_NO_EXCEPT
+  #endif
 #endif

 template <float (&op)(float value) MATH_NO_EXCEPT>
@@ -2785,7 +2789,7 @@ TEST(MathOpTest, Acosh) {

 TEST(MathOpTest, Atanh) {
   OpTester test("Atanh", 9);
-  TrigFloatTest<::atanhf>(test, {-1.0f, -0.5f, 0.0f, 0.5f, 1.0f});
+  TrigFloatTest<std::atanhf>(test, {-1.0f, -0.5f, 0.0f, 0.5f, 1.0f});
 }

 TEST(MathOpTest, Expand_8_3x3_string) {
