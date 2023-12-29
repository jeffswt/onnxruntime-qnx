diff --git a/onnxruntime/core/common/threadpool.cc b/onnxruntime/core/common/threadpool.cc
index cf4b143..7968a14 100644
--- a/onnxruntime/core/common/threadpool.cc
+++ b/onnxruntime/core/common/threadpool.cc
@@ -134,6 +134,8 @@ void ThreadPoolProfiler::MainThreadStat::LogCore() {
 #endif
 #elif defined(__wasm__)
   core_ = emscripten_num_logical_cores();
+#elif defined(__QNX__)
+  core_ = 0;
 #else
   core_ = sched_getcpu();
 #endif
@@ -216,6 +218,8 @@ void ThreadPoolProfiler::LogRun(int thread_idx) {
 #endif
 #elif defined(__wasm__)
       child_thread_stats_[thread_idx].core_ = emscripten_num_logical_cores();
+#elif defined(__QNX__)
+      child_thread_stats_[thread_idx].core_ = 0;
 #else
       child_thread_stats_[thread_idx].core_ = sched_getcpu();
 #endif
