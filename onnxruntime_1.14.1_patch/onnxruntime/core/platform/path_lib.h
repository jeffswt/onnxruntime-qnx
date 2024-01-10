diff --git a/onnxruntime/core/platform/path_lib.h b/onnxruntime/core/platform/path_lib.h
index e48c2f3..124b561 100644
--- a/onnxruntime/core/platform/path_lib.h
+++ b/onnxruntime/core/platform/path_lib.h
@@ -248,12 +248,12 @@ inline OrtFileType DTToFileTypeAIX(struct stat st) {
 template <typename T>
 void LoopDir(const std::string& dir_name, T func) {
   DIR* dir = opendir(dir_name.c_str());
-  struct stat stats; 
+  struct stat stats;
   if (dir == nullptr) {
     auto e = errno;
     char buf[1024];
     char* msg;
-#if defined(__GLIBC__) && defined(_GNU_SOURCE) 
+#if defined(__GLIBC__) && defined(_GNU_SOURCE)
     msg = strerror_r(e, buf, sizeof(buf));
 #else
     if (strerror_r(e, buf, sizeof(buf)) != 0) {
@@ -272,7 +272,7 @@ void LoopDir(const std::string& dir_name, T func) {
     std::basic_string<PATH_CHAR_TYPE> filename  = ConcatPathComponent<PATH_CHAR_TYPE>(dir_name, dp->d_name);
 	if (stat(filename.c_str(), &stats) != 0) {
 		continue;
-	}	
+	}
       if (!func(dp->d_name, DTToFileTypeAIX(stats))) {
         break;
       }
@@ -285,7 +285,13 @@ void LoopDir(const std::string& dir_name, T func) {
   closedir(dir);
 }
 #else
-inline OrtFileType DTToFileType(unsigned char t) {
+inline OrtFileType DTToFileType(struct dirent *dp) {
+  #if defined(__QNX__)
+  // regular file always for default on QNX
+  (void)(dp);  // suppress unused parameter warning
+  return OrtFileType::TYPE_REG;
+  #else
+  unsigned char t = dp->d_type;
   switch (t) {
     case DT_BLK:
       return OrtFileType::TYPE_BLK;
@@ -304,6 +310,7 @@ inline OrtFileType DTToFileType(unsigned char t) {
     default:
       return OrtFileType::TYPE_UNKNOWN;
   }
+  #endif
 }
 
 template <typename T>
@@ -329,7 +336,7 @@ void LoopDir(const std::string& dir_name, T func) {
   ORT_TRY {
     struct dirent* dp;
     while ((dp = readdir(dir)) != nullptr) {
-      if (!func(dp->d_name, DTToFileType(dp->d_type))) {
+      if (!func(dp->d_name, DTToFileType(dp))) {
         break;
       }
     }
