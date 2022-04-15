# CodeQL

codeql for java

## Codeql4java

- db

```
rm -rf dbs/java-db && codeql database create dbs/java-db --language=java -c "mvn clean install -f pom.xml -Dmaven.test.skip=true" -v
```

- analyze

```
codeql database analyze --ram=8000 --threads=8 --format=sarif-latest --output=sarif-out.sarif ..\dbs\apache_struts_cve_2017_9805\apache_struts_cve_2017_9805 .\scan4sec\java-security-and-quality.qls
```

## Rules

- https://github.com/ice-doom/CodeQLRule

## Refence

- https://github.com/githubsatelliteworkshops/codeql/releases/download/v1.0/apache_struts_cve_2017_9805.zip
- https://github.com/githubsatelliteworkshops/codeql/blob/master/java.md

- https://github.com/github/vscode-codeql-starter
- https://github.com/github/codeql-cli-binaries/releases
- https://codeql.github.com/docs/codeql-cli/manual/
- https://paper.seebug.org/1078/
- https://securitylab.github.com/research/apache-struts-CVE-2018-11776/
- https://github.com/github/codeql