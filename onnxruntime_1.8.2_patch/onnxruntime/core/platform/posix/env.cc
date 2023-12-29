diff --git a/onnxruntime/core/platform/posix/env.cc b/onnxruntime/core/platform/posix/env.cc
index 3a05f42..74e90af 100644
--- a/onnxruntime/core/platform/posix/env.cc
+++ b/onnxruntime/core/platform/posix/env.cc
@@ -132,7 +132,7 @@ class PosixThread : public EnvThread {
                        new Param{name_prefix, index, start_address, param, thread_options});
     if (s != 0)
       ORT_THROW("pthread_create failed");
-#if !defined(__APPLE__) && !defined(__ANDROID__) && !defined(__wasm__)
+#if !defined(__APPLE__) && !defined(__ANDROID__) && !defined(__wasm__) && !defined(__QNX__)
     if (!thread_options.affinity.empty()) {
       cpu_set_t cpuset;
       CPU_ZERO(&cpuset);
