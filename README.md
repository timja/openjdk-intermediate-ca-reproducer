# Reproduce Java Chain issue

Requirements:
* On a Mac
* Docker
* Docker compose
* OpenSSL

## Create certificates
```shell
./bin/setup.sh
docker compose up
```

## Configure certificate trust

Install the root and intermediate certs to your Keychain.
Your user keychain is fine (login).

If you double click the cert it may try use your system one which is ok but may not work if you don't have admin access.
Instead you can just drag and drop the certificates into the keychain.

Double click the root in the keychain and expand the trust section and set to "Always Trust".

Then open the URL in your browser and validate its trusted: https://localhost:8443

You should see a page with "Hello, World!".

## Run with Java

```shell
java Main.java https://localhost:8443 KeychainStore
```

### Expected with Java 23

```text
Exception in thread "main" java.lang.RuntimeException: Test failed:
	at Main.main(Main.java:36)
Caused by: javax.net.ssl.SSLHandshakeException: PKIX path building failed: sun.security.provider.certpath.SunCertPathBuilderException: unable to find valid certification path to requested target
```

### Expected with https://github.com/openjdk/jdk/pull/22911

Command:

```shell
/Users/timja/projects/jdk/build/macosx-aarch64-server-release/jdk/bin/java Main.java https://localhost:8443 KeychainStore
```

Output:
```
timja-intermediate
timja-root
size:<some number>
Success
```
