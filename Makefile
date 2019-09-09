all: dist/signed.apk

.PHONY: all clean install unpack

APK_DIR=apk.out/
MAIN_DLL=${APK_DIR}assets/bin/Data/Managed/Assembly-CSharp.dll

${APK_DIR}: original.apk
	sha256sum -c CHECKSUMS.sha256
	apktool decode --output ${APK_DIR} $<
	mkdir -p dll/original/
	mv ${MAIN_DLL} dll/original/

install: dist/signed.apk
	adb install $<

clean:
	rm -rf dist/ dll/ ${APK_DIR}

dist/base.apk: ${APK_DIR} ${MAIN_DLL}
	mkdir -p dist/
	apktool build --output $@ ${APK_DIR}

dist/aligned.apk: dist/base.apk
	rm -f $@
	zipalign 4 $< $@

dist/signed.apk: dist/aligned.apk debug-key.pk8
	apksigner sign --key debug-key.pk8 --cert debug-cert.pem --out $@ dist/aligned.apk

debug-key.pk8:
	openssl req -x509 -days 9125 -newkey rsa:1024 -nodes -keyout debug-key.pem -out debug-cert.pem -subj "/CN=debug"
	openssl pkcs8 -topk8 -outform DER -in debug-key.pem -inform PEM -out debug-key.pk8 -nocrypt
	rm debug-key.pem

dll/main.il: dll/original/Assembly-CSharp.dll
	ildasm -out=$@ $<

${MAIN_DLL}: dll/main.il
	ilasm -dll -output=$@ $<
