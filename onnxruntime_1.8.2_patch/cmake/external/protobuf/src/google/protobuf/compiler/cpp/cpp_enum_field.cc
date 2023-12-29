diff --git a/cmake/external/protobuf/src/google/protobuf/compiler/cpp/cpp_enum_field.cc b/cmake/external/protobuf/src/google/protobuf/compiler/cpp/cpp_enum_field.cc
index 57e6d7e6c..1c1a413dc 100644
--- a/cmake/external/protobuf/src/google/protobuf/compiler/cpp/cpp_enum_field.cc
+++ b/cmake/external/protobuf/src/google/protobuf/compiler/cpp/cpp_enum_field.cc
@@ -496,7 +496,7 @@ void RepeatedEnumFieldGenerator::GenerateConstinitInitializer(
   format("$name$_()");
   if (descriptor_->is_packed() &&
       HasGeneratedMethods(descriptor_->file(), options_)) {
-    format("\n, _$name$_cached_byte_size_()");
+    format("\n, _$name$_cached_byte_size_(0)");
   }
 }
 
