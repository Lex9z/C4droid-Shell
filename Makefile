iPREFIX   := /data/data/com.n0n3m4.droidc
sPREFIX   :=/mnt/sdcard/C4droid_EXT
INCLUDES := -I$(sPREFIX)/include
LIBS     :=-L$(sPREFIX)/lib -lreadline -lhistory -lncurses
LD_LIBRARY_PATH =/data/data/com.n0n3m4.droidc/usr/lib:/vendor/lib:/system/lib
TAR      :=/system/xbin/tar
INSTALL :=/system/xbin/install
RM :=/system/xbin/rm
TOUCH :=/system/xbin/touch


all: install install-gdbm install-iconv install-perl install-autotools install-flex install-texinfo install-help2man install-bison install-ssl install-ssh2 install-curl install-git install-sqlite3 install-cmake install-gdb install-xml2 install-expat install-pcre install-pcap install-zlib install-libtool  install-ssh install-openssh

	
c4dsh: install-readline c4dsh.o
	$(CC) c4dsh.o -o c4dsh $(LIBS)

c4dsh.o: c4dsh.c
	$(CC) $(INCLUDES) -c c4dsh.c -o c4dsh.o    

#use md5sum(busybox)
#PakVer.1.0
#This target checks:if the Makefile has chenged ->so remove all before installation.
clean_install:
	if ! [ -f ${iPREFIX}/`md5sum $(PWD)/Makefile | cut -d' ' -f1`.install ];then $(RM) -rf ${iPREFIX}/usr $(iPREFIX)/tmp /mnt/sdcard/C4droid_EXT;find ${iPREFIX} -maxdepth 1 -type f -name *.install -exec $(RM) -f {} \; && $(TOUCH) ${iPREFIX}/`md5sum $(PWD)/Makefile | cut -d' ' -f1`.install;fi;

install: clean_install c4dsh
	$(INSTALL) -m 0777 c4dsh $(iPREFIX)/files
	if ! [ -d $(iPREFIX)/home ]; then mkdir -m 0777 $(iPREFIX)/home;fi;
	$(RM) -f $(iPREFIX)/files/.C4dENV;
	if  [ -d $(iPREFIX)/etc_bak ]; then mv $(iPREFIX)/etc_bak $(iPREFIX)/usr/etc;fi;

install-iconv:
	if ! [ -f $(iPREFIX)/usr/lib/libiconv.so.2 ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/libiconv-1.14/usr.tar.gz;fi;
	if ! [ -f $(sPREFIX)/lib/libiconv.so ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/libiconv-1.14/C4droid_EXT.tar.gz;fi;

install-libtool:
	if ! [ -f $(iPREFIX)/usr/bin/libtool ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/libtool/usr.tar.gz;fi;
	if ! [ -f $(sPREFIX)/include/ltdl.h ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/libtool/C4droid_EXT.tar.gz;fi;

install-readline:
	if ! [ -f $(sPREFIX)/lib/libreadline.a ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/libreadline6.3/C4droid_EXT.tar.gz;fi;
		if ! [ -f $(iPREFIX)/usr/lib/libreadline.la ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/libreadline6.3/usr.tar.gz;fi;

install-xml2:
	if ! [ -f $(sPREFIX)/lib/libxml2.a ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/Xml2/C4droid_EXT.tar.gz;fi;

install-expat:
	if ! [ -f $(sPREFIX)/lib/libexpat.a ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/libexpat/C4droid_EXT.tar.gz;fi;

install-pcre:
	if ! [ -f $(sPREFIX)/lib/libpcre.a ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/libpcre/C4droid_EXT.tar.gz;fi;

install-zlib:
	if ! [ -f $(sPREFIX)/lib/libzlib.a ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/libzlib/C4droid_EXT.tar.gz;fi;

install-ssh:
	if ! [ -f $(iPREFIX)/usr/lib/libssh.so ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/libssh/usr.tar.gz;cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/libssh/C4droid_EXT.tar.gz;fi;

install-pcap:
	if ! [ -f $(sPREFIX)/lib/libpcap.a ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/libpcap/C4droid_EXT.tar.gz;fi;

install-gdbm:
	if ! [ -f $(iPREFIX)/usr/lib/libgdbm.so.4 ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/GDBM/usr.tar.gz;fi;
	if ! [ -f $(sPREFIX)/lib/libgdbm.so ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/GDBM/C4droid_EXT.tar.gz;fi;

install-perl: install-gdbm
	if ! [ -f $(iPREFIX)/usr/bin/perl ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/Perl5/usr.tar.gz;$(RM) -rf $(iPREFIX)/home/.cpan;fi;
	if ! [ -d $(sPREFIX)/lib/perl5 ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/Perl5/C4droid_EXT.tar.gz;cp $(PWD)/App/Perl5/arm-linux-androideabi-thread-multi/Config_heavy.pl $(sPREFIX)/lib/perl5/5.20.1/arm-linux-androideabi-thread-multi/Config_heavy.pl;cp $(PWD)/App/Perl5/CPAN/Config.pm $(sPREFIX)/lib/perl5/5.20.1/CPAN/Config.pm;fi;

install-autotools:
	if ! [ -f $(iPREFIX)/usr/bin/automake ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/Autotools/usr.tar.gz;$(INSTALL) -m 0755 $(PWD)/App/Autotools/CONFIGFIX $(iPREFIX)/usr/bin;fi;

install-flex:
	if ! [ -f $(iPREFIX)/usr/bin/flex ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/Flex/usr.tar.gz;fi;
	if ! [ -f $(sPREFIX)/lib/libfl.a ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/Flex/C4droid_EXT.tar.gz;fi;

install-texinfo:
	if ! [ -f $(iPREFIX)/usr/bin/makeinfo ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/Texinfo5.2/usr.tar.gz;fi;
	if ! [ -d $(sPREFIX)/share/texinfo ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/Texinfo5.2/C4droid_EXT.tar.gz;fi;


install-bison:
	if ! [ -f $(iPREFIX)/usr/bin/bison ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/bison3.0.2/usr.tar.gz;fi

install-help2man:
	if ! [ -f $(iPREFIX)/usr/bin/help2man ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/help2man1.43.3/usr.tar.gz;fi

install-ssl:
	if ! [ -f $(iPREFIX)/usr/bin/openssl ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/openssl/usr.tar.gz;fi;
	if ! [ -d $(sPREFIX)/include/openssl ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/openssl/C4droid_EXT.tar.gz;fi;


install-ssh2: install-ssl
	if ! [ -f $(iPREFIX)/usr/lib/libssh2.so.1 ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/ssh2/usr.tar.gz;fi;
	if ! [ -f $(sPREFIX)/lib/libssh2.so ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/ssh2/C4droid_EXT.tar.gz;fi;

install-curl: install-ssl install-ssh2
	if ! [ -f $(iPREFIX)/usr/bin/curl ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/Curl/usr.tar.gz;install -m 0755 $(PWD)/App/Curl/curl-config $(iPREFIX)/usr/bin;fi;
	if ! [ -f $(sPREFIX)/lib/libcurl.so ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/Curl/C4droid_EXT.tar.gz;fi;

install-git: install-ssl install-ssh2 install-curl
	if ! [ -f $(iPREFIX)/usr/bin/git ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/Git-2.2.0/usr.tar.gz;fi;
install-sqlite3:
	if ! [ -f $(iPREFIX)/usr/bin/sqlite3 ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/sqlite3/usr.tar.gz;fi;
	if ! [ -f $(sPREFIX)/lib/libsqlite3.so ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/sqlite3/C4droid_EXT.tar.gz;fi;

install-cmake: install-ssl
	if ! [ -f $(iPREFIX)/usr/bin/cmake ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/cmake/usr.tar.gz;fi;
	if ! [ -d $(sPREFIX)/share/cmake-3.0 ]; then cd /mnt/sdcard && $(TAR) -mzxf $(PWD)/App/cmake/C4droid_EXT.tar.gz;cp $(PWD)/App/cmake/Linux.cmake $(sPREFIX)/share/cmake-3.0/Modules/Platform/Linux.cmake;fi;

install-gdb:
	if ! [ -f $(iPREFIX)/usr/bin/gdb ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/gdb/usr.tar.gz;fi;

install-openssh:install-ssl
	if ! [ -f $(iPREFIX)/usr/bin/ssh ]; then cd $(iPREFIX) && $(TAR) -mzxf $(PWD)/App/openssh/usr.tar.gz;fi
	if ! [ -f $(iPREFIX)/usr/etc/ssh_host_key ] ; then $(iPREFIX)/usr/bin/ssh-keygen -t rsa1 -f $(iPREFIX)/usr/etc/ssh_host_key -N "" ; fi ;
	if ! [ -f $(iPREFIX)/usr/etc/ssh_host_rsa_key ] ; then $(iPREFIX)/usr/bin/ssh-keygen -t rsa -f $(iPREFIX)/usr/etc/ssh_host_rsa_key -N "" ; fi ;
	if ! [ -f $(iPREFIX)/usr/etc/ssh_host_dsa_key ] ; then $(iPREFIX)/usr/bin/ssh-keygen -t dsa -f $(iPREFIX)/usr/etc/ssh_host_dsa_key -N "" ; fi ;
	if ! [ -f $(iPREFIX)/usr/etc/ssh_host_ed25519_key ] ; then $(iPREFIX)/usr/bin/ssh-keygen -t ed25519 -f $(iPREFIX)/usr/etc/ssh_host_ed25519_key -N "" ; fi ;
	if ! [ -f $(iPREFIX)/usr/etc/ssh_host_ecdsa_key ] ; then $(iPREFIX)/usr/bin/ssh-keygen -t ecdsa -f $(iPREFIX)/usr/etc/ssh_host_ecdsa_key -N "" ; fi ;