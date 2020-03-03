# re-RETRY

> Resurrecting RETRY with a bit of reverse engineering

RETRY is the best mobile game ever, but it was apparently too difficult for the masses and was discontinued in 2017. For a while it just crashed at startup.

This repo contains scripts to unpack, modify and repack RETRY 1.5.0 APK with modifications to make it more playable.

## License

**IMPORTANT:** Use of the patches is only allowed if you have paid at least 3,99€ or $3.99 for in-app purchases in [Fail Plane](https://play.google.com/store/apps/details?id=com.darkmatter.retry) (or if that is not available, in some other Rovio digital product).

That is, the patches are *non-free* and subject to the aforementioned license agreement.

The toolchain (`Makefile`) is in the public domain.

## Patches

- Change package and name to allow installation alongside the original
- Make the app debuggable
- Disable Google Play Games integration (because it crashes)
- Allow opening all levels directly (because you had them unlocked back in the day)
- Don't use up challenge retries and coins (because you can't buy coins anymore and don't wanna grind the early levels for coins)

## Usage

Save the original APK as `original.apk`. Run `make`. Connect phone via USB and run `make install`.

## Dependencies

- apktool
- Android SDK
- ilasm+ildasm from CoreCLR (no, Mono versions don't work)

## Future work

- A minimal binary patch to avoid a complicated toolchain
