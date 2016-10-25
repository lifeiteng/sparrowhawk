TESTS = test

check_PROGRAMS = test

test_SOURCES = test.cc
test_LDADD = $(top_builddir)/src/lib/libsparrowhawk.la
test_LDFLAGS = -ldl -lre2 -lprotobuf -lpthread -lthrax -lfst -lfstfar
test_CPPFLAGS = -I$(top_srcdir)/src/include \
	-DDATADIR=\"${top_srcdir}/test/data\"

CLEANFILES = *.tmp* *.log *.json *.list temp test
