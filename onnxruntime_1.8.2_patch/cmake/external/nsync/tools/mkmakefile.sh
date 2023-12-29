diff --git a/cmake/external/nsync/tools/mkmakefile.sh b/cmake/external/nsync/tools/mkmakefile.sh
index 365b34b..dd41a4b 100644
--- a/cmake/external/nsync/tools/mkmakefile.sh
+++ b/cmake/external/nsync/tools/mkmakefile.sh
@@ -285,10 +285,10 @@ makefile=`
 			case "$ldflags" in ?*) echo "PLATFORM_LDFLAGS=$ldflags";; esac
 			case "$libs" in ?*) echo "PLATFORM_LIBS=$libs";; esac
 			case "$atomics" in
-			c++11)	echo "PLATFORM_CXXFLAGS=-Werror -Wall -Wextra -std=c++11 -pedantic"
+			c++11)	echo "PLATFORM_CXXFLAGS=-Werror -Wall -Wextra -std=gnu++11 -pedantic"
 				echo "PLATFORM_CXX=../../platform/c_from_c++11/src/nsync_atm_c++.cc"
 				echo "MKDEP_DEPEND=mkdep"
-				echo 'MKDEP=./mkdep ${CC} -E -c++=-std=c++11'
+				echo 'MKDEP=./mkdep ${CC} -E -c++=-std=gnu++11'
 				platform_o="nsync_atm_c++.o $platform_o";;
 			*)	echo 'MKDEP=${CC} -M';;
 			esac
@@ -303,10 +303,10 @@ makefile=`
 			case "$ldflags" in ?*) echo "PLATFORM_LDFLAGS=$ldflags";; esac
 			case "$libs" in ?*) echo "PLATFORM_LIBS=$libs";; esac
 			case "$atomics" in
-			c++11)	echo "PLATFORM_CXXFLAGS=-Werror -Wall -Wextra -std=c++11 -pedantic"
+			c++11)	echo "PLATFORM_CXXFLAGS=-Werror -Wall -Wextra -std=gnu++11 -pedantic"
 				echo "PLATFORM_CXX=../../platform/c_from_c++11/src/nsync_atm_c++.cc"
 				echo "MKDEP_DEPEND=mkdep"
-				echo 'MKDEP=./mkdep ${CC} -E -c++=-std=c++11'
+				echo 'MKDEP=./mkdep ${CC} -E -c++=-std=gnu++11'
 				platform_o="nsync_atm_c++.o $platform_o";;
 			*)	echo 'MKDEP=${CC} -M';;
 			esac
@@ -317,10 +317,10 @@ makefile=`
 			echo "TEST_PLATFORM_OBJS=$test_platform_o"
 			;;
 	gcc.c++)	echo "PLATFORM_CPPFLAGS=-DNSYNC_ATOMIC_CPP11 -I../../platform/c++11 $cppflags"
-			echo "PLATFORM_CFLAGS=-x c++ -std=c++11 -Werror -Wall -Wextra -pedantic"
+			echo "PLATFORM_CFLAGS=-x c++ -std=gnu++11 -Werror -Wall -Wextra -pedantic"
 			case "$ldflags" in ?*) echo "PLATFORM_LDFLAGS=$ldflags";; esac
 			case "$libs" in ?*) echo "PLATFORM_LIBS=$libs";; esac
-			echo 'MKDEP=${CC} -M -x c++ -std=c++11'
+			echo 'MKDEP=${CC} -M -x c++ -std=gnu++11'
 			echo "PLATFORM_C=$platform_c"
 			case "$platform_s" in ?*) echo "PLATFORM_S=$platform_s";; esac
 			echo "PLATFORM_OBJS=$platform_o"
@@ -328,10 +328,10 @@ makefile=`
 			echo "TEST_PLATFORM_OBJS=$test_platform_o"
 			;;
 	clang.c++)	echo "PLATFORM_CPPFLAGS=-DNSYNC_ATOMIC_CPP11 -I../../platform/c++11 $cppflags"
-			echo "PLATFORM_CFLAGS=-x c++ -std=c++11 -Werror -Wall -Wextra -pedantic -Wno-unneeded-internal-declaration"
+			echo "PLATFORM_CFLAGS=-x c++ -std=gnu++11 -Werror -Wall -Wextra -pedantic -Wno-unneeded-internal-declaration"
 			case "$ldflags" in ?*) echo "PLATFORM_LDFLAGS=$ldflags";; esac
 			case "$libs" in ?*) echo "PLATFORM_LIBS=$libs";; esac
-			echo 'MKDEP=${CC} -M -x c++ -std=c++11'
+			echo 'MKDEP=${CC} -M -x c++ -std=gnu++11'
 			echo "PLATFORM_C=$platform_c"
 			case "$platform_s" in ?*) echo "PLATFORM_S=$platform_s";; esac
 			echo "PLATFORM_OBJS=$platform_o"
