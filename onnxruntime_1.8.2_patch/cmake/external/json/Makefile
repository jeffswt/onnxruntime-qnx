diff --git a/cmake/external/json/Makefile b/cmake/external/json/Makefile
index 9dc8be6..4ffc1cb 100644
--- a/cmake/external/json/Makefile
+++ b/cmake/external/json/Makefile
@@ -118,7 +118,7 @@ doctest:
 # -Wno-weak-vtables: exception class is defined inline, but has virtual method
 pedantic_clang:
 	$(MAKE) json_unit CXX=c++ CXXFLAGS=" \
-		-std=c++11 -Wno-c++98-compat -Wno-c++98-compat-pedantic \
+		-std=gnu++11 -Wno-c++98-compat -Wno-c++98-compat-pedantic \
 		-Werror \
 		-Weverything \
 		-Wno-c++2a-compat \
@@ -135,7 +135,7 @@ pedantic_clang:
 # calling GCC with most warnings
 pedantic_gcc:
 	$(MAKE) json_unit CXX=g++-9 CXXFLAGS=" \
-		-std=c++11 \
+		-std=gnu++11 \
 		-Waddress \
 		-Waddress-of-packed-member \
 		-Waggressive-loop-optimizations \
@@ -435,7 +435,7 @@ fuzzing-stop:
 # call cppcheck <http://cppcheck.sourceforge.net>
 # Note: this target is called by Travis
 cppcheck:
-	cppcheck --enable=warning --inline-suppr --inconclusive --force --std=c++11 $(AMALGAMATED_FILE) --error-exitcode=1
+	cppcheck --enable=warning --inline-suppr --inconclusive --force --std=gnu++11 $(AMALGAMATED_FILE) --error-exitcode=1
 
 # call Clang Static Analyzer <https://clang-analyzer.llvm.org>
 clang_analyze:
@@ -457,7 +457,7 @@ cpplint:
 
 # call Clang-Tidy <https://clang.llvm.org/extra/clang-tidy/>
 clang_tidy:
-	$(COMPILER_DIR)/clang-tidy $(AMALGAMATED_FILE) -- -Iinclude -std=c++11
+	$(COMPILER_DIR)/clang-tidy $(AMALGAMATED_FILE) -- -Iinclude -std=gnu++11
 
 # call PVS-Studio Analyzer <https://www.viva64.com/en/pvs-studio/>
 pvs_studio:
@@ -476,7 +476,7 @@ infer:
 
 # call OCLint <http://oclint.org> static analyzer
 oclint:
-	oclint $(SRCS) -report-type html -enable-global-analysis -o oclint_report.html -max-priority-1=10000 -max-priority-2=10000 -max-priority-3=10000 -- -std=c++11 -Iinclude
+	oclint $(SRCS) -report-type html -enable-global-analysis -o oclint_report.html -max-priority-1=10000 -max-priority-2=10000 -max-priority-3=10000 -- -std=gnu++11 -Iinclude
 	open oclint_report.html
 
 # execute the test suite with Clang sanitizers (address and undefined behavior)
@@ -536,7 +536,7 @@ check-single-includes:
 	@for x in $(SRCS); do \
 	  echo "Checking self-sufficiency of $$x..." ; \
 	  echo "#include <$$x>\nint main() {}\n" | sed 's|include/||' > single_include_test.cpp; \
-	  $(CXX) $(CXXFLAGS) -Iinclude -std=c++11 single_include_test.cpp -o single_include_test; \
+	  $(CXX) $(CXXFLAGS) -Iinclude -std=gnu++11 single_include_test.cpp -o single_include_test; \
 	  rm -f single_include_test.cpp single_include_test; \
 	done
 
