# stagitbuild - easy builder - manager for your stagit site
# see LICENSE file for details

include config.mk

options:
	@echo stagitbuild options:
	@echo "PREFIX = ${PREFIX}"

clean:
	@echo cleaning
	@rm -f stagitbuild-${VERSION}.tar.gz

dist:
	@echo creating dist tarball
	@mkdir -p stagitbuild-${VERSION}
	@cp -R LICENSE Makefile README config.mk stagitbuild.1 stagitbuild stagitbuild-${VERSION}
	tar -cf stagitbuild-${VERSION}.tar stagitbuild-${VERSION}
	gzip stagitbuild-${VERSION}.tar
	@rm -rf stagitbuild-${VERSION}

install: 
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f stagitbuild ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/stagitbuild
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < stagitbuild.1 > ${DESTDIR}${MANPREFIX}/man1/stagitbuild.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/stagitbuild.1

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/stagitbuild
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@ rm -f ${DESTDIR}${MANPREFIX}/man1/stagitbuild.1

.PHONY: options install uninstall dist
