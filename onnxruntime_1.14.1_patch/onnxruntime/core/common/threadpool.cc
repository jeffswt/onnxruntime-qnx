diff --git a/onnxruntime/core/common/threadpool.cc b/onnxruntime/core/common/threadpool.cc
index a032c5d..369d5f3 100644
--- a/onnxruntime/core/common/threadpool.cc
+++ b/onnxruntime/core/common/threadpool.cc
@@ -33,6 +33,9 @@ limitations under the License.
 #endif
 #elif defined(__wasm__)
 #include <emscripten/threading.h>
+#elif defined(__QNX__)
+#include <sys/neutrino.h>
+#include <sched.h>
 #else
 #include <sched.h>
 #endif
@@ -138,6 +141,8 @@ void ThreadPoolProfiler::MainThreadStat::LogCore() {
   core_ = emscripten_num_logical_cores();
 #elif defined(_AIX)
   core_ = mycpu();
+#elif defined(__QNX__)
+  core_ = SchedGetCpuNum();
 #else
   core_ = sched_getcpu();
 #endif
@@ -222,6 +227,8 @@ void ThreadPoolProfiler::LogRun(int thread_idx) {
       child_thread_stats_[thread_idx].core_ = emscripten_num_logical_cores();
 #elif defined(_AIX)
       child_thread_stats_[thread_idx].core_ = mycpu();
+#elif defined(__QNX__)
+      child_thread_stats_[thread_idx].core_ = SchedGetCpuNum();
 #else
       child_thread_stats_[thread_idx].core_ = sched_getcpu();
 #endif
@@ -266,7 +273,7 @@ struct alignas(CACHE_LINE_BYTES) LoopCounterShard {
 };
 
 static_assert(sizeof(LoopCounterShard) == CACHE_LINE_BYTES, "Expected loop counter shards to match cache-line size");
- 
+
 class alignas(CACHE_LINE_BYTES) LoopCounter {
  public:
   LoopCounter(uint64_t num_iterations,
@@ -457,7 +464,7 @@ void ThreadPool::ParallelForFixedBlockSizeScheduling(const std::ptrdiff_t total,
         }
       }
     };
-    // Distribute task among all threads in the pool, reduce number of work items if 
+    // Distribute task among all threads in the pool, reduce number of work items if
     // num_of_blocks is smaller than number of threads.
     RunInParallel(run_work, std::min(NumThreads() + 1, num_of_blocks), base_block_size);
   }
