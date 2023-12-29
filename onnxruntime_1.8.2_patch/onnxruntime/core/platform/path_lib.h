diff --git a/onnxruntime/core/platform/path_lib.h b/onnxruntime/core/platform/path_lib.h
index e24e698..231f35d 100644
--- a/onnxruntime/core/platform/path_lib.h
+++ b/onnxruntime/core/platform/path_lib.h
@@ -221,7 +221,12 @@ inline std::basic_string<PATH_CHAR_TYPE> GetLastComponent(const std::basic_strin
 }
 
 #else
-inline OrtFileType DTToFileType(unsigned char t) {
+inline OrtFileType DTToFileType(struct dirent *dp) {
+  #if defined(__QNX__)
+  (void)dp;
+  return OrtFileType::TYPE_REG;
+  #else
+  unsigned char t = dp->d_type;
   switch (t) {
     case DT_BLK:
       return OrtFileType::TYPE_BLK;
@@ -240,6 +245,7 @@ inline OrtFileType DTToFileType(unsigned char t) {
     default:
       return OrtFileType::TYPE_UNKNOWN;
   }
+  #endif
 }
 
 template <typename T>
@@ -265,7 +271,7 @@ void LoopDir(const std::string& dir_name, T func) {
   ORT_TRY {
     struct dirent* dp;
     while ((dp = readdir(dir)) != nullptr) {
-      if (!func(dp->d_name, DTToFileType(dp->d_type))) {
+      if (!func(dp->d_name, DTToFileType(dp))) {
         break;
       }
     }
