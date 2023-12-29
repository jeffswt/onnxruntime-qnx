diff --git a/cmake/external/protobuf/src/google/protobuf/stubs/mutex.h b/cmake/external/protobuf/src/google/protobuf/stubs/mutex.h
index 82b62a66b..2eab67d41 100644
--- a/cmake/external/protobuf/src/google/protobuf/stubs/mutex.h
+++ b/cmake/external/protobuf/src/google/protobuf/stubs/mutex.h
@@ -116,7 +116,11 @@ class CallOnceInitializedMutex {
 // mutexes.
 class GOOGLE_PROTOBUF_CAPABILITY("mutex") PROTOBUF_EXPORT WrappedMutex {
  public:
+ #if defined(__QNX__)
   constexpr WrappedMutex() = default;
+ #else
+  constexpr WrappedMutex() {}
+ #endif
   void Lock() GOOGLE_PROTOBUF_ACQUIRE() { mu_.lock(); }
   void Unlock() GOOGLE_PROTOBUF_RELEASE() { mu_.unlock(); }
   // Crash if this Mutex is not held exclusively by this thread.
