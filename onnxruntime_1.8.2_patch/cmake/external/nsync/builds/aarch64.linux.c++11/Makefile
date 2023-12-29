diff --git a/cmake/external/nsync/builds/aarch64.linux.c++11/Makefile b/cmake/external/nsync/builds/aarch64.linux.c++11/Makefile
index faa6853..d7f5cd6 100644
--- a/cmake/external/nsync/builds/aarch64.linux.c++11/Makefile
+++ b/cmake/external/nsync/builds/aarch64.linux.c++11/Makefile
@@ -2,9 +2,9 @@
 # use futex directly.
 CC=g++
 PLATFORM_CPPFLAGS=-DNSYNC_USE_CPP11_TIMEPOINT -DNSYNC_ATOMIC_CPP11 -I../../platform/c++11.futex -I../../platform/c++11 -I../../platform/gcc -I../../platform/posix -pthread
-PLATFORM_CFLAGS=-std=c++11 -Werror -Wall -Wextra -pedantic
+PLATFORM_CFLAGS=-std=gnu++11 -Werror -Wall -Wextra -pedantic
 PLATFORM_LDFLAGS=-pthread
-MKDEP=${CC} -M -std=c++11
+MKDEP=${CC} -M -std=gnu++11
 # It's dangerous to use C++ class destructors if we can avoid it, because nsync
 # may be linked into the address space multiple times, so we use the posix
 # per_thread_waiter.
