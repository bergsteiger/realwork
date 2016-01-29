/**
 * ConfluenceSoapServiceStub.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.atlassian.www.software.confluence.$Proxy42;

public class ConfluenceSoapServiceStub extends org.apache.axis.client.Stub implements com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapService {
    private java.util.Vector cachedSerClasses = new java.util.Vector();
    private java.util.Vector cachedSerQNames = new java.util.Vector();
    private java.util.Vector cachedSerFactories = new java.util.Vector();
    private java.util.Vector cachedDeserFactories = new java.util.Vector();

    static org.apache.axis.description.OperationDesc [] _operations;

    static {
        _operations = new org.apache.axis.description.OperationDesc[88];
        _initOperationDesc1();
        _initOperationDesc2();
        _initOperationDesc3();
        _initOperationDesc4();
        _initOperationDesc5();
        _initOperationDesc6();
        _initOperationDesc7();
        _initOperationDesc8();
        _initOperationDesc9();
    }

    private static void _initOperationDesc1(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getPermissions");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        oper.setReturnClass(java.lang.String[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[0] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("search");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/java.util/", "Map"), com.atlassian.www._package.java_util.Map.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[1] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("search");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[2] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getComment");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteComment"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[3] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getServerInfo");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteServerInfo"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteServerInfo.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[4] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://schemas.xmlsoap.org/soap/encoding/", "boolean"));
        oper.setReturnClass(java.lang.Boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[5] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpace"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[6] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getSpaces");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSpaceSummary"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[7] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getPages");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageSummary"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[8] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addComment");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteComment"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteComment"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[9] = oper;

    }

    private static void _initOperationDesc2(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getUser");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUser"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[10] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeGroup");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[11] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getPage");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePage"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[12] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getPage");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePage"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[13] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getDescendents");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageSummary"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[14] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getAttachments");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteAttachment"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[15] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addAttachment");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"), byte[].class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[16] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addAttachment");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"), byte[].class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[17] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeAttachment");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[18] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getChildren");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageSummary"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[19] = oper;

    }

    private static void _initOperationDesc3(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getAncestors");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageSummary"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[20] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getComments");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteComment"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[21] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeComment");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[22] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addUser");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUser"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(org.apache.axis.encoding.XMLType.AXIS_VOID);
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[23] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addGroup");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[24] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeUser");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[25] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("deactivateUser");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[26] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("reactivateUser");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[27] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getGroups");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        oper.setReturnClass(java.lang.String[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[28] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getRelatedLabels");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[29] = oper;

    }

    private static void _initOperationDesc4(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getRelatedLabelsInSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[30] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getSpacesContainingContentWithLabel");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSpace"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[31] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getRecentlyUsedLabelsInSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[32] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getRecentlyUsedLabels");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[33] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getSpacesWithLabel");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSpace"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[34] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getLabelsByDetail");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg4"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[35] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getMostPopularLabels");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[36] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getMostPopularLabelsInSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[37] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getAttachment");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[38] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getAttachmentData");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"));
        oper.setReturnClass(byte[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[39] = oper;

    }

    private static void _initOperationDesc5(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("moveAttachment");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg4"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[40] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeAllPermissionsForGroup");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[41] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("login");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        oper.setReturnClass(java.lang.String.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "AuthenticationFailedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.AuthenticationFailedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "AuthenticationFailedException"), 
                      true
                     ));
        _operations[42] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("logout");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[43] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("exportSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        oper.setReturnClass(java.lang.String.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[44] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpace"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpace"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "AlreadyExistsException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.AlreadyExistsException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "AlreadyExistsException"), 
                      true
                     ));
        _operations[45] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getActiveUsers");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"), boolean.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        oper.setReturnClass(java.lang.String[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[46] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getPageHistory");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageHistory"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[47] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removePage");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://schemas.xmlsoap.org/soap/encoding/", "boolean"));
        oper.setReturnClass(java.lang.Boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[48] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("renderContent");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        oper.setReturnClass(java.lang.String.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[49] = oper;

    }

    private static void _initOperationDesc6(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("renderContent");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg4"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/java.util/", "Map"), com.atlassian.www._package.java_util.Map.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        oper.setReturnClass(java.lang.String.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[50] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("storePage");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePage"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePage"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "VersionMismatchException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "VersionMismatchException"), 
                      true
                     ));
        _operations[51] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getSpaceLevelPermissions");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        oper.setReturnClass(java.lang.String[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[52] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addPermissionToSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[53] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addPermissionsToSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"), java.lang.String[].class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[54] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removePermissionFromSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[55] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("editUser");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUser"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[56] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getUserGroups");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        oper.setReturnClass(java.lang.String[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[57] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addUserToGroup");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[58] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeUserFromGroup");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[59] = oper;

    }

    private static void _initOperationDesc7(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("changeMyPassword");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[60] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("changeUserPassword");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[61] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("setUserInformation");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUserInformation"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[62] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getUserInformation");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUserInformation"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[63] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("hasUser");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[64] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("hasGroup");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[65] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getBlogEntryByDayAndTitle");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntry"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[66] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getBlogEntry");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntry"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[67] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getBlogEntries");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteBlogEntrySummary"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[68] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("storeBlogEntry");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntry"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntry"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "VersionMismatchException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "VersionMismatchException"), 
                      true
                     ));
        _operations[69] = oper;

    }

    private static void _initOperationDesc8(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("exportSite");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"), boolean.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        oper.setReturnClass(java.lang.String.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[70] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getLabelsById");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[71] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getLabelContentById");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[72] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getLabelContentByName");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[73] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getLabelContentByObject");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteLabel"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[74] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addLabelByName");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[75] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addLabelById");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[76] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addLabelByObject");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteLabel"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[77] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addLabelByNameToSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[78] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeLabelByName");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[79] = oper;

    }

    private static void _initOperationDesc9(){
        org.apache.axis.description.OperationDesc oper;
        org.apache.axis.description.ParameterDesc param;
        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeLabelById");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[80] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeLabelByObject");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteLabel"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[81] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeLabelByNameFromSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[82] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getPermissionsForUser");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        oper.setReturnClass(java.lang.String[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[83] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addAnonymousPermissionToSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[84] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("addAnonymousPermissionsToSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"), java.lang.String[].class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[85] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("removeAnonymousPermissionFromSpace");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        oper.setReturnClass(boolean.class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "NotPermittedException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[86] = oper;

        oper = new org.apache.axis.description.OperationDesc();
        oper.setName("getPagePermissions");
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false);
        oper.addParameter(param);
        param = new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false);
        oper.addParameter(param);
        oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePermission"));
        oper.setReturnClass(com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission[].class);
        oper.setReturnQName(new javax.xml.namespace.QName("", "Result"));
        oper.setStyle(org.apache.axis.constants.Style.RPC);
        oper.setUse(org.apache.axis.constants.Use.ENCODED);
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "InvalidSessionException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"), 
                      true
                     ));
        oper.addFault(new org.apache.axis.description.FaultDesc(
                      new javax.xml.namespace.QName("x", "RemoteException"),
                      "com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException",
                      new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"), 
                      true
                     ));
        _operations[87] = oper;

    }

    public ConfluenceSoapServiceStub() throws org.apache.axis.AxisFault {
         this(null);
    }

    public ConfluenceSoapServiceStub(java.net.URL endpointURL, javax.xml.rpc.Service service) throws org.apache.axis.AxisFault {
         this(service);
         super.cachedEndpoint = endpointURL;
    }

    public ConfluenceSoapServiceStub(javax.xml.rpc.Service service) throws org.apache.axis.AxisFault {
        if (service == null) {
            super.service = new org.apache.axis.client.Service();
        } else {
            super.service = service;
        }
        ((org.apache.axis.client.Service)super.service).setTypeMappingVersion("1.1");
            java.lang.Class cls;
            javax.xml.namespace.QName qName;
            javax.xml.namespace.QName qName2;
            java.lang.Class beansf = org.apache.axis.encoding.ser.BeanSerializerFactory.class;
            java.lang.Class beandf = org.apache.axis.encoding.ser.BeanDeserializerFactory.class;
            java.lang.Class enumsf = org.apache.axis.encoding.ser.EnumSerializerFactory.class;
            java.lang.Class enumdf = org.apache.axis.encoding.ser.EnumDeserializerFactory.class;
            java.lang.Class arraysf = org.apache.axis.encoding.ser.ArraySerializerFactory.class;
            java.lang.Class arraydf = org.apache.axis.encoding.ser.ArrayDeserializerFactory.class;
            java.lang.Class simplesf = org.apache.axis.encoding.ser.SimpleSerializerFactory.class;
            java.lang.Class simpledf = org.apache.axis.encoding.ser.SimpleDeserializerFactory.class;
            java.lang.Class simplelistsf = org.apache.axis.encoding.ser.SimpleListSerializerFactory.class;
            java.lang.Class simplelistdf = org.apache.axis.encoding.ser.SimpleListDeserializerFactory.class;
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "AbstractRemotePageSummary");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.AbstractRemotePageSummary.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteAttachment");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteBlogEntrySummary");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntrySummary");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteComment");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteComment");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteLabel");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageHistory");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePageHistory");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageSummary");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePageSummary");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePermission");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePermission");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSearchResult");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSpace");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpace");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSpaceSummary");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpaceSummary");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntry");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntrySummary");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteComment");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteLabel");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePage");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePageHistory");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePageSummary");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePermission");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSearchResult");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteServerInfo");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteServerInfo.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpace");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpaceSummary");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUser");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUserInformation");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "AlreadyExistsException");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc.AlreadyExistsException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "AuthenticationFailedException");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc.AuthenticationFailedException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "VersionMismatchException");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.atlassian.com/package/java.util/", "Map");
            cachedSerQNames.add(qName);
            cls = com.atlassian.www._package.java_util.Map.class;
            cachedSerClasses.add(cls);
            cachedSerFactories.add(beansf);
            cachedDeserFactories.add(beandf);

            qName = new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring");
            cachedSerQNames.add(qName);
            cls = java.lang.String[].class;
            cachedSerClasses.add(cls);
            qName = new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string");
            qName2 = null;
            cachedSerFactories.add(new org.apache.axis.encoding.ser.ArraySerializerFactory(qName, qName2));
            cachedDeserFactories.add(new org.apache.axis.encoding.ser.ArrayDeserializerFactory());

    }

    protected org.apache.axis.client.Call createCall() throws java.rmi.RemoteException {
        try {
            org.apache.axis.client.Call _call = super._createCall();
            if (super.maintainSessionSet) {
                _call.setMaintainSession(super.maintainSession);
            }
            if (super.cachedUsername != null) {
                _call.setUsername(super.cachedUsername);
            }
            if (super.cachedPassword != null) {
                _call.setPassword(super.cachedPassword);
            }
            if (super.cachedEndpoint != null) {
                _call.setTargetEndpointAddress(super.cachedEndpoint);
            }
            if (super.cachedTimeout != null) {
                _call.setTimeout(super.cachedTimeout);
            }
            if (super.cachedPortName != null) {
                _call.setPortName(super.cachedPortName);
            }
            java.util.Enumeration keys = super.cachedProperties.keys();
            while (keys.hasMoreElements()) {
                java.lang.String key = (java.lang.String) keys.nextElement();
                _call.setProperty(key, super.cachedProperties.get(key));
            }
            // All the type mapping information is registered
            // when the first call is made.
            // The type mapping information is actually registered in
            // the TypeMappingRegistry of the service, which
            // is the reason why registration is only needed for the first call.
            synchronized (this) {
                if (firstCall()) {
                    // must set encoding style before registering serializers
                    _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
                    _call.setEncodingStyle(org.apache.axis.Constants.URI_SOAP11_ENC);
                    for (int i = 0; i < cachedSerFactories.size(); ++i) {
                        java.lang.Class cls = (java.lang.Class) cachedSerClasses.get(i);
                        javax.xml.namespace.QName qName =
                                (javax.xml.namespace.QName) cachedSerQNames.get(i);
                        java.lang.Object x = cachedSerFactories.get(i);
                        if (x instanceof Class) {
                            java.lang.Class sf = (java.lang.Class)
                                 cachedSerFactories.get(i);
                            java.lang.Class df = (java.lang.Class)
                                 cachedDeserFactories.get(i);
                            _call.registerTypeMapping(cls, qName, sf, df, false);
                        }
                        else if (x instanceof javax.xml.rpc.encoding.SerializerFactory) {
                            org.apache.axis.encoding.SerializerFactory sf = (org.apache.axis.encoding.SerializerFactory)
                                 cachedSerFactories.get(i);
                            org.apache.axis.encoding.DeserializerFactory df = (org.apache.axis.encoding.DeserializerFactory)
                                 cachedDeserFactories.get(i);
                            _call.registerTypeMapping(cls, qName, sf, df, false);
                        }
                    }
                }
            }
            return _call;
        }
        catch (java.lang.Throwable _t) {
            throw new org.apache.axis.AxisFault("Failure trying to get the Call object", _t);
        }
    }

    public java.lang.String[] getPermissions(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[0]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getPermissions");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getPermissions"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String[]) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] search(java.lang.String arg0, java.lang.String arg1, com.atlassian.www._package.java_util.Map arg2, int arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[1]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("search");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "search"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2, new java.lang.Integer(arg3)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] search(java.lang.String arg0, java.lang.String arg1, int arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[2]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("search");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "search"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Integer(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment getComment(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[3]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getComment");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getComment"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteServerInfo getServerInfo(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[4]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getServerInfo");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getServerInfo"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteServerInfo) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteServerInfo) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteServerInfo.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.Boolean removeSpace(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[5]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.Boolean) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.Boolean.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace getSpace(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[6]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary[] getSpaces(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[7]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getSpaces");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getSpaces"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] getPages(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[8]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getPages");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getPages"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment addComment(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[9]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addComment");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addComment"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser getUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[10]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getUser");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getUser"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeGroup(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[11]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeGroup");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeGroup"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage getPage(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[12]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getPage");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getPage"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage getPage(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[13]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getPage");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getPage"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] getDescendents(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[14]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getDescendents");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getDescendents"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment[] getAttachments(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[15]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getAttachments");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getAttachments"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment addAttachment(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment arg1, byte[] arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[16]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addAttachment");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addAttachment"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment addAttachment(java.lang.String arg0, long arg1, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment arg2, byte[] arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[17]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addAttachment");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addAttachment"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1), arg2, arg3});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeAttachment(java.lang.String arg0, long arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[18]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeAttachment");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeAttachment"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1), arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] getChildren(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[19]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getChildren");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getChildren"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] getAncestors(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[20]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getAncestors");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getAncestors"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment[] getComments(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[21]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getComments");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getComments"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeComment(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[22]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeComment");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeComment"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public void addUser(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[23]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addUser");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addUser"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        extractAttachments(_call);
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addGroup(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[24]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addGroup");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addGroup"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[25]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeUser");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeUser"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean deactivateUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[26]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("deactivateUser");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "deactivateUser"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean reactivateUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[27]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("reactivateUser");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "reactivateUser"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String[] getGroups(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[28]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getGroups");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getGroups"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String[]) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getRelatedLabels(java.lang.String arg0, java.lang.String arg1, int arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[29]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getRelatedLabels");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getRelatedLabels"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Integer(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getRelatedLabelsInSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, int arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[30]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getRelatedLabelsInSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getRelatedLabelsInSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2, new java.lang.Integer(arg3)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[] getSpacesContainingContentWithLabel(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[31]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getSpacesContainingContentWithLabel");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getSpacesContainingContentWithLabel"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getRecentlyUsedLabelsInSpace(java.lang.String arg0, java.lang.String arg1, int arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[32]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getRecentlyUsedLabelsInSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getRecentlyUsedLabelsInSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Integer(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getRecentlyUsedLabels(java.lang.String arg0, int arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[33]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getRecentlyUsedLabels");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getRecentlyUsedLabels"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Integer(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[] getSpacesWithLabel(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[34]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getSpacesWithLabel");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getSpacesWithLabel"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getLabelsByDetail(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, java.lang.String arg3, java.lang.String arg4) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[35]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getLabelsByDetail");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getLabelsByDetail"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2, arg3, arg4});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getMostPopularLabels(java.lang.String arg0, int arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[36]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getMostPopularLabels");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getMostPopularLabels"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Integer(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getMostPopularLabelsInSpace(java.lang.String arg0, java.lang.String arg1, int arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[37]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getMostPopularLabelsInSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getMostPopularLabelsInSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Integer(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment getAttachment(java.lang.String arg0, long arg1, java.lang.String arg2, int arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[38]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getAttachment");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getAttachment"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1), arg2, new java.lang.Integer(arg3)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public byte[] getAttachmentData(java.lang.String arg0, long arg1, java.lang.String arg2, int arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[39]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getAttachmentData");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getAttachmentData"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1), arg2, new java.lang.Integer(arg3)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (byte[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (byte[]) org.apache.axis.utils.JavaUtils.convert(_resp, byte[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean moveAttachment(java.lang.String arg0, long arg1, java.lang.String arg2, long arg3, java.lang.String arg4) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[40]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("moveAttachment");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "moveAttachment"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1), arg2, new java.lang.Long(arg3), arg4});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeAllPermissionsForGroup(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[41]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeAllPermissionsForGroup");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeAllPermissionsForGroup"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String login(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.AuthenticationFailedException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[42]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("login");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "login"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.AuthenticationFailedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.AuthenticationFailedException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean logout(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[43]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("logout");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "logout"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String exportSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[44]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("exportSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "exportSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace addSpace(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.AlreadyExistsException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[45]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.AlreadyExistsException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.AlreadyExistsException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String[] getActiveUsers(java.lang.String arg0, boolean arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[46]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getActiveUsers");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getActiveUsers"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Boolean(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String[]) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory[] getPageHistory(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[47]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getPageHistory");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getPageHistory"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.Boolean removePage(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[48]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removePage");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removePage"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.Boolean) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.Boolean.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String renderContent(java.lang.String arg0, java.lang.String arg1, long arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[49]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("renderContent");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "renderContent"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Long(arg2), arg3});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String renderContent(java.lang.String arg0, java.lang.String arg1, long arg2, java.lang.String arg3, com.atlassian.www._package.java_util.Map arg4) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[50]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("renderContent");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "renderContent"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Long(arg2), arg3, arg4});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage storePage(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[51]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("storePage");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "storePage"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String[] getSpaceLevelPermissions(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[52]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getSpaceLevelPermissions");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getSpaceLevelPermissions"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String[]) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addPermissionToSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[53]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addPermissionToSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addPermissionToSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2, arg3});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addPermissionsToSpace(java.lang.String arg0, java.lang.String[] arg1, java.lang.String arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[54]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addPermissionsToSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addPermissionsToSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2, arg3});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removePermissionFromSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[55]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removePermissionFromSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removePermissionFromSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2, arg3});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean editUser(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[56]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("editUser");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "editUser"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String[] getUserGroups(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[57]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getUserGroups");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getUserGroups"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String[]) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addUserToGroup(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[58]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addUserToGroup");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addUserToGroup"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeUserFromGroup(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[59]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeUserFromGroup");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeUserFromGroup"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean changeMyPassword(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[60]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("changeMyPassword");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "changeMyPassword"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean changeUserPassword(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[61]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("changeUserPassword");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "changeUserPassword"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean setUserInformation(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[62]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("setUserInformation");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "setUserInformation"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation getUserInformation(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[63]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getUserInformation");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getUserInformation"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean hasUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[64]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("hasUser");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "hasUser"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean hasGroup(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[65]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("hasGroup");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "hasGroup"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry getBlogEntryByDayAndTitle(java.lang.String arg0, java.lang.String arg1, int arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[66]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getBlogEntryByDayAndTitle");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getBlogEntryByDayAndTitle"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Integer(arg2), arg3});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry getBlogEntry(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[67]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getBlogEntry");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getBlogEntry"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary[] getBlogEntries(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[68]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getBlogEntries");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getBlogEntries"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry storeBlogEntry(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[69]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("storeBlogEntry");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "storeBlogEntry"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String exportSite(java.lang.String arg0, boolean arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[70]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("exportSite");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "exportSite"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Boolean(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String.class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getLabelsById(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[71]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getLabelsById");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getLabelsById"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] getLabelContentById(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[72]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getLabelContentById");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getLabelContentById"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] getLabelContentByName(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[73]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getLabelContentByName");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getLabelContentByName"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] getLabelContentByObject(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[74]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getLabelContentByObject");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getLabelContentByObject"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addLabelByName(java.lang.String arg0, java.lang.String arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[75]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addLabelByName");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addLabelByName"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Long(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addLabelById(java.lang.String arg0, long arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[76]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addLabelById");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addLabelById"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1), new java.lang.Long(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addLabelByObject(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[77]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addLabelByObject");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addLabelByObject"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Long(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addLabelByNameToSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[78]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addLabelByNameToSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addLabelByNameToSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeLabelByName(java.lang.String arg0, java.lang.String arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[79]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeLabelByName");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeLabelByName"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Long(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeLabelById(java.lang.String arg0, long arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[80]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeLabelById");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeLabelById"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1), new java.lang.Long(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeLabelByObject(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[81]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeLabelByObject");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeLabelByObject"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, new java.lang.Long(arg2)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeLabelByNameFromSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[82]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeLabelByNameFromSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeLabelByNameFromSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public java.lang.String[] getPermissionsForUser(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[83]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getPermissionsForUser");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getPermissionsForUser"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (java.lang.String[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (java.lang.String[]) org.apache.axis.utils.JavaUtils.convert(_resp, java.lang.String[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addAnonymousPermissionToSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[84]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addAnonymousPermissionToSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addAnonymousPermissionToSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean addAnonymousPermissionsToSpace(java.lang.String arg0, java.lang.String[] arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[85]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("addAnonymousPermissionsToSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "addAnonymousPermissionsToSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public boolean removeAnonymousPermissionFromSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[86]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("removeAnonymousPermissionFromSpace");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "removeAnonymousPermissionFromSpace"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, arg1, arg2});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return ((java.lang.Boolean) _resp).booleanValue();
            } catch (java.lang.Exception _exception) {
                return ((java.lang.Boolean) org.apache.axis.utils.JavaUtils.convert(_resp, boolean.class)).booleanValue();
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission[] getPagePermissions(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException {
        if (super.cachedEndpoint == null) {
            throw new org.apache.axis.NoEndPointException();
        }
        org.apache.axis.client.Call _call = createCall();
        _call.setOperation(_operations[87]);
        _call.setUseSOAPAction(true);
        _call.setSOAPActionURI("getPagePermissions");
        _call.setSOAPVersion(org.apache.axis.soap.SOAPConstants.SOAP11_CONSTANTS);
        _call.setOperationName(new javax.xml.namespace.QName("x", "getPagePermissions"));

        setRequestHeaders(_call);
        setAttachments(_call);
 try {        java.lang.Object _resp = _call.invoke(new java.lang.Object[] {arg0, new java.lang.Long(arg1)});

        if (_resp instanceof java.rmi.RemoteException) {
            throw (java.rmi.RemoteException)_resp;
        }
        else {
            extractAttachments(_call);
            try {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission[]) _resp;
            } catch (java.lang.Exception _exception) {
                return (com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission[]) org.apache.axis.utils.JavaUtils.convert(_resp, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission[].class);
            }
        }
  } catch (org.apache.axis.AxisFault axisFaultException) {
    if (axisFaultException.detail != null) {
        if (axisFaultException.detail instanceof java.rmi.RemoteException) {
              throw (java.rmi.RemoteException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException) axisFaultException.detail;
         }
        if (axisFaultException.detail instanceof com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) {
              throw (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException) axisFaultException.detail;
         }
   }
  throw axisFaultException;
}
    }

}
