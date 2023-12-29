diff --git a/cmake/external/wil/include/wil/wistd_config.h b/cmake/external/wil/include/wil/wistd_config.h
index b408c24..2514c6f 100644
--- a/cmake/external/wil/include/wil/wistd_config.h
+++ b/cmake/external/wil/include/wil/wistd_config.h
@@ -361,6 +361,10 @@
 
 #endif // _WIN32
 
+#undef __WI_LIBCPP_LITTLE_ENDIAN
+#undef __WI_LIBCPP_BIG_ENDIAN
+#define __WI_LIBCPP_LITTLE_ENDIAN
+
 #ifdef __WI_LIBCPP_HAS_NO_CONSTEXPR
 #  define __WI_LIBCPP_CONSTEXPR
 #else
