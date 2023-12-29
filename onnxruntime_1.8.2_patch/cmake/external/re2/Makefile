diff --git a/cmake/external/re2/Makefile b/cmake/external/re2/Makefile
index f001f06..47fc8b3 100644
--- a/cmake/external/re2/Makefile
+++ b/cmake/external/re2/Makefile
@@ -17,7 +17,7 @@ CXX?=g++
 CXXFLAGS?=-O3 -g
 LDFLAGS?=
 # required
-RE2_CXXFLAGS?=-std=c++11 -pthread -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -I. $(CCICU) $(CCPCRE)
+RE2_CXXFLAGS?=-std=gnu++11 -pthread -Wall -Wextra -Wno-unused-parameter -Wno-missing-field-initializers -I. $(CCICU) $(CCPCRE)
 RE2_LDFLAGS?=-pthread $(LDICU) $(LDPCRE)
 AR?=ar
 ARFLAGS?=rsc
@@ -286,7 +286,7 @@ testinstall: static-testinstall shared-testinstall
 	@echo Install tests passed.
 	@echo
 
-static-testinstall: CXXFLAGS:=-std=c++11 -pthread -I$(DESTDIR)$(includedir) $(CXXFLAGS)
+static-testinstall: CXXFLAGS:=-std=gnu++11 -pthread -I$(DESTDIR)$(includedir) $(CXXFLAGS)
 static-testinstall: LDFLAGS:=-pthread -L$(DESTDIR)$(libdir) -l:libre2.a $(LDICU) $(LDFLAGS)
 static-testinstall:
 	@mkdir -p obj
@@ -300,7 +300,7 @@ else
 	obj/testinstall
 endif
 
-shared-testinstall: CXXFLAGS:=-std=c++11 -pthread -I$(DESTDIR)$(includedir) $(CXXFLAGS)
+shared-testinstall: CXXFLAGS:=-std=gnu++11 -pthread -I$(DESTDIR)$(includedir) $(CXXFLAGS)
 shared-testinstall: LDFLAGS:=-pthread -L$(DESTDIR)$(libdir) -lre2 $(LDICU) $(LDFLAGS)
 shared-testinstall:
 	@mkdir -p obj
