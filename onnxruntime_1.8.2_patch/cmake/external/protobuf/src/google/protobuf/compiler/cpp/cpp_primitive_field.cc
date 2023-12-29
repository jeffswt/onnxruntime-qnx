diff --git a/cmake/external/protobuf/src/google/protobuf/compiler/cpp/cpp_primitive_field.cc b/cmake/external/protobuf/src/google/protobuf/compiler/cpp/cpp_primitive_field.cc
index 9f7f61e16..40e06403a 100644
--- a/cmake/external/protobuf/src/google/protobuf/compiler/cpp/cpp_primitive_field.cc
+++ b/cmake/external/protobuf/src/google/protobuf/compiler/cpp/cpp_primitive_field.cc
@@ -486,7 +486,7 @@ void RepeatedPrimitiveFieldGenerator::GenerateConstinitInitializer(
   format("$name$_()");
   if (descriptor_->is_packed() && FixedSize(descriptor_->type()) == -1 &&
       HasGeneratedMethods(descriptor_->file(), options_)) {
-    format("\n, _$name$_cached_byte_size_()");
+    format("\n, _$name$_cached_byte_size_(0)");
   }
 }
 
