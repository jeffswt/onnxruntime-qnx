diff --git a/samples/c_cxx/imagenet/local_filesystem.h b/samples/c_cxx/imagenet/local_filesystem.h
index dbb2055..d92c93f 100644
--- a/samples/c_cxx/imagenet/local_filesystem.h
+++ b/samples/c_cxx/imagenet/local_filesystem.h
@@ -85,7 +85,11 @@ inline void ReportSystemError(const char* operation_name, const TCharString& pat
   throw std::runtime_error(oss.str());
 }
 
-inline OrtFileType DTToFileType(unsigned char t) {
+inline OrtFileType DTToFileType(struct dirent *dp) {
+  #if defined(__QNX__)
+  return OrtFileType::TYPE_REG;
+  #else
+  unsigned char t = dp->d_type;
   switch (t) {
     case DT_BLK:
       return OrtFileType::TYPE_BLK;
@@ -104,6 +108,7 @@ inline OrtFileType DTToFileType(unsigned char t) {
     default:
       return OrtFileType::TYPE_UNKNOWN;
   }
+  #endif
 }
 
 template <typename T>
@@ -129,7 +134,7 @@ void LoopDir(const TCharString& dir_name, T func) {
   try {
     struct dirent* dp;
     while ((dp = readdir(dir)) != nullptr) {
-      if (!func(dp->d_name, DTToFileType(dp->d_type))) {
+      if (!func(dp->d_name, DTToFileType(dp))) {
         break;
       }
     }
