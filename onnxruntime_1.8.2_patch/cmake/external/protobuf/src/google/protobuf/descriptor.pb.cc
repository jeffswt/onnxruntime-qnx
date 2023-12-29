diff --git a/cmake/external/protobuf/src/google/protobuf/descriptor.pb.cc b/cmake/external/protobuf/src/google/protobuf/descriptor.pb.cc
index c22ae431c..dbfe39ece 100644
--- a/cmake/external/protobuf/src/google/protobuf/descriptor.pb.cc
+++ b/cmake/external/protobuf/src/google/protobuf/descriptor.pb.cc
@@ -393,9 +393,9 @@ PROTOBUF_ATTRIBUTE_NO_DESTROY PROTOBUF_CONSTINIT UninterpretedOptionDefaultTypeI
 constexpr SourceCodeInfo_Location::SourceCodeInfo_Location(
   ::PROTOBUF_NAMESPACE_ID::internal::ConstantInitialized)
   : path_()
-  , _path_cached_byte_size_()
+  , _path_cached_byte_size_(0)
   , span_()
-  , _span_cached_byte_size_()
+  , _span_cached_byte_size_(0)
   , leading_detached_comments_()
   , leading_comments_(&::PROTOBUF_NAMESPACE_ID::internal::fixed_address_empty_string)
   , trailing_comments_(&::PROTOBUF_NAMESPACE_ID::internal::fixed_address_empty_string){}
@@ -423,7 +423,7 @@ PROTOBUF_ATTRIBUTE_NO_DESTROY PROTOBUF_CONSTINIT SourceCodeInfoDefaultTypeIntern
 constexpr GeneratedCodeInfo_Annotation::GeneratedCodeInfo_Annotation(
   ::PROTOBUF_NAMESPACE_ID::internal::ConstantInitialized)
   : path_()
-  , _path_cached_byte_size_()
+  , _path_cached_byte_size_(0)
   , source_file_(&::PROTOBUF_NAMESPACE_ID::internal::fixed_address_empty_string)
   , begin_(0)
   , end_(0){}
