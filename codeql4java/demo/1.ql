import java

from Class cl, Constructor c
where
  cl.getPackage().getName().regexpMatch(".*.*") and
  cl.getAConstructor() = c and
  (
    c.getSignature().toString().regexpMatch(".*java.io.File[),].*") or
    c.getSignature().toString().regexpMatch(".*java.nio.file.Path[),].*") or
    c.getSignature().toString().regexpMatch(".*java.io.InputStream[),].*")
  )
select cl, cl.getPackage(), c, c.getNumberOfParameters(), c.getSignature()