/**
 * @kind path-problem
 */

import java
import DataFlow::PathGraph
import semmle.code.java.dataflow.TaintTracking

class ActionProxyGetMethod extends Method {
  ActionProxyGetMethod() {
    getDeclaringType().getASupertype*().hasQualifiedName("com.opensymphony.xwork2", "ActionProxy") and
    (
      hasName("getMethod") or
      hasName("getNamespace") or
      hasName("getActionName")
    )
  }
}

predicate isActionProxySource(DataFlow::Node source) {
  source.asExpr().(MethodAccess).getMethod() instanceof ActionProxyGetMethod
}

predicate isOgnlSink(DataFlow::Node sink) {
  exists(MethodAccess ma |
    ma.getMethod().hasName("compileAndExecute") or ma.getMethod().hasName("compileAndExecuteMethod")
  |
    ma.getMethod().getDeclaringType().getName().matches("OgnlUtil") and
    sink.asExpr() = ma.getArgument(0)
  )
}

class OgnlTaintTrackingCfg extends DataFlow::Configuration {
  OgnlTaintTrackingCfg() { this = "mapping" }

  override predicate isSource(DataFlow::Node source) { isActionProxySource(source) }

  override predicate isSink(DataFlow::Node sink) { isOgnlSink(sink) }

  override predicate isAdditionalFlowStep(DataFlow::Node node1, DataFlow::Node node2) {
    TaintTracking::localTaintStep(node1, node2)
    or
    exists(Field f, RefType t |
      node1.asExpr() = f.getAnAssignedValue() and
      node2.asExpr() = f.getAnAccess() and
      node1.asExpr().getEnclosingCallable().getDeclaringType() = t and
      node2.asExpr().getEnclosingCallable().getDeclaringType() = t
    )
  }
}

from OgnlTaintTrackingCfg cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select source, source, sink, "潜在的漏洞"