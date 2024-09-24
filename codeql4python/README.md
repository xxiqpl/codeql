# CodeQL

codeql for python

## Codeql4python

- db

```
codeql database create python_db --language=python --overwrite --source-root= D:\vscode-codeql-starter\python_dir
```

- analyze

```
codeql database analyze --ram=8000 --threads=8 --format=sarif-latest --output=codeql_python_out.sarif D:\vscode-codeql-starter\python_dir\..\python_dir_db D:\vscode-codeql-starter\ql\python\ql\src\codeql-suites\python-security-experimental.qls

```

