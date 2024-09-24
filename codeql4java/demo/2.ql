import java

from MethodAccess call, Method method
where call.getMethod() = method and (
    method.toString().regexpMatch(".*exec.*") or 
    method.toString().regexpMatch("^readObject$") or 
    method.toString().regexpMatch("^exec$") or 
    method.toString().regexpMatch("^getRuntime$") or
    method.toString().regexpMatch("^execute$") 
    )
select method, method.getNumberOfParameters(), method.getStringSignature(),
  method.getDeclaringType().getName(), method.getDeclaringType().getPackage().getName()

