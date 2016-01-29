/**
 * ConfluenceSoapServiceSkeleton.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.atlassian.www.software.confluence.$Proxy42;

public class ConfluenceSoapServiceSkeleton implements com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapService, org.apache.axis.wsdl.Skeleton {
    private com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapService impl;
    private static java.util.Map _myOperations = new java.util.Hashtable();
    private static java.util.Collection _myOperationsList = new java.util.ArrayList();

    /**
    * Returns List of OperationDesc objects with this name
    */
    public static java.util.List getOperationDescByName(java.lang.String methodName) {
        return (java.util.List)_myOperations.get(methodName);
    }

    /**
    * Returns Collection of OperationDescs
    */
    public static java.util.Collection getOperationDescs() {
        return _myOperationsList;
    }

    static {
        org.apache.axis.description.OperationDesc _oper;
        org.apache.axis.description.FaultDesc _fault;
        org.apache.axis.description.ParameterDesc [] _params;
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getPermissions", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getPermissions"));
        _oper.setSoapAction("getPermissions");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getPermissions") == null) {
            _myOperations.put("getPermissions", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getPermissions")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/java.util/", "Map"), com.atlassian.www._package.java_util.Map.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("search", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "search"));
        _oper.setSoapAction("search");
        _myOperationsList.add(_oper);
        if (_myOperations.get("search") == null) {
            _myOperations.put("search", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("search")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("search", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "search"));
        _oper.setSoapAction("search");
        _myOperationsList.add(_oper);
        if (_myOperations.get("search") == null) {
            _myOperations.put("search", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("search")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getComment", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteComment"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getComment"));
        _oper.setSoapAction("getComment");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getComment") == null) {
            _myOperations.put("getComment", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getComment")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getServerInfo", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteServerInfo"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getServerInfo"));
        _oper.setSoapAction("getServerInfo");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getServerInfo") == null) {
            _myOperations.put("getServerInfo", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getServerInfo")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://schemas.xmlsoap.org/soap/encoding/", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeSpace"));
        _oper.setSoapAction("removeSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeSpace") == null) {
            _myOperations.put("removeSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpace"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getSpace"));
        _oper.setSoapAction("getSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getSpace") == null) {
            _myOperations.put("getSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getSpaces", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSpaceSummary"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getSpaces"));
        _oper.setSoapAction("getSpaces");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getSpaces") == null) {
            _myOperations.put("getSpaces", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getSpaces")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getPages", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageSummary"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getPages"));
        _oper.setSoapAction("getPages");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getPages") == null) {
            _myOperations.put("getPages", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getPages")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteComment"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addComment", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteComment"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addComment"));
        _oper.setSoapAction("addComment");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addComment") == null) {
            _myOperations.put("addComment", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addComment")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getUser", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUser"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getUser"));
        _oper.setSoapAction("getUser");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getUser") == null) {
            _myOperations.put("getUser", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getUser")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeGroup", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeGroup"));
        _oper.setSoapAction("removeGroup");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeGroup") == null) {
            _myOperations.put("removeGroup", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeGroup")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getPage", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePage"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getPage"));
        _oper.setSoapAction("getPage");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getPage") == null) {
            _myOperations.put("getPage", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getPage")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getPage", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePage"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getPage"));
        _oper.setSoapAction("getPage");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getPage") == null) {
            _myOperations.put("getPage", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getPage")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getDescendents", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageSummary"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getDescendents"));
        _oper.setSoapAction("getDescendents");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getDescendents") == null) {
            _myOperations.put("getDescendents", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getDescendents")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getAttachments", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteAttachment"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getAttachments"));
        _oper.setSoapAction("getAttachments");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getAttachments") == null) {
            _myOperations.put("getAttachments", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getAttachments")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"), byte[].class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addAttachment", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addAttachment"));
        _oper.setSoapAction("addAttachment");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addAttachment") == null) {
            _myOperations.put("addAttachment", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addAttachment")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"), byte[].class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addAttachment", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addAttachment"));
        _oper.setSoapAction("addAttachment");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addAttachment") == null) {
            _myOperations.put("addAttachment", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addAttachment")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeAttachment", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeAttachment"));
        _oper.setSoapAction("removeAttachment");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeAttachment") == null) {
            _myOperations.put("removeAttachment", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeAttachment")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getChildren", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageSummary"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getChildren"));
        _oper.setSoapAction("getChildren");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getChildren") == null) {
            _myOperations.put("getChildren", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getChildren")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getAncestors", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageSummary"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getAncestors"));
        _oper.setSoapAction("getAncestors");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getAncestors") == null) {
            _myOperations.put("getAncestors", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getAncestors")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getComments", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteComment"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getComments"));
        _oper.setSoapAction("getComments");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getComments") == null) {
            _myOperations.put("getComments", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getComments")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeComment", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeComment"));
        _oper.setSoapAction("removeComment");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeComment") == null) {
            _myOperations.put("removeComment", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeComment")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUser"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addUser", _params, null);
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addUser"));
        _oper.setSoapAction("addUser");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addUser") == null) {
            _myOperations.put("addUser", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addUser")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addGroup", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addGroup"));
        _oper.setSoapAction("addGroup");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addGroup") == null) {
            _myOperations.put("addGroup", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addGroup")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeUser", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeUser"));
        _oper.setSoapAction("removeUser");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeUser") == null) {
            _myOperations.put("removeUser", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeUser")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("deactivateUser", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "deactivateUser"));
        _oper.setSoapAction("deactivateUser");
        _myOperationsList.add(_oper);
        if (_myOperations.get("deactivateUser") == null) {
            _myOperations.put("deactivateUser", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("deactivateUser")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("reactivateUser", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "reactivateUser"));
        _oper.setSoapAction("reactivateUser");
        _myOperationsList.add(_oper);
        if (_myOperations.get("reactivateUser") == null) {
            _myOperations.put("reactivateUser", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("reactivateUser")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getGroups", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getGroups"));
        _oper.setSoapAction("getGroups");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getGroups") == null) {
            _myOperations.put("getGroups", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getGroups")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getRelatedLabels", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getRelatedLabels"));
        _oper.setSoapAction("getRelatedLabels");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getRelatedLabels") == null) {
            _myOperations.put("getRelatedLabels", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getRelatedLabels")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getRelatedLabelsInSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getRelatedLabelsInSpace"));
        _oper.setSoapAction("getRelatedLabelsInSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getRelatedLabelsInSpace") == null) {
            _myOperations.put("getRelatedLabelsInSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getRelatedLabelsInSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getSpacesContainingContentWithLabel", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSpace"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getSpacesContainingContentWithLabel"));
        _oper.setSoapAction("getSpacesContainingContentWithLabel");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getSpacesContainingContentWithLabel") == null) {
            _myOperations.put("getSpacesContainingContentWithLabel", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getSpacesContainingContentWithLabel")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getRecentlyUsedLabelsInSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getRecentlyUsedLabelsInSpace"));
        _oper.setSoapAction("getRecentlyUsedLabelsInSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getRecentlyUsedLabelsInSpace") == null) {
            _myOperations.put("getRecentlyUsedLabelsInSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getRecentlyUsedLabelsInSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getRecentlyUsedLabels", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getRecentlyUsedLabels"));
        _oper.setSoapAction("getRecentlyUsedLabels");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getRecentlyUsedLabels") == null) {
            _myOperations.put("getRecentlyUsedLabels", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getRecentlyUsedLabels")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getSpacesWithLabel", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSpace"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getSpacesWithLabel"));
        _oper.setSoapAction("getSpacesWithLabel");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getSpacesWithLabel") == null) {
            _myOperations.put("getSpacesWithLabel", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getSpacesWithLabel")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg4"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getLabelsByDetail", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getLabelsByDetail"));
        _oper.setSoapAction("getLabelsByDetail");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getLabelsByDetail") == null) {
            _myOperations.put("getLabelsByDetail", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getLabelsByDetail")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getMostPopularLabels", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getMostPopularLabels"));
        _oper.setSoapAction("getMostPopularLabels");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getMostPopularLabels") == null) {
            _myOperations.put("getMostPopularLabels", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getMostPopularLabels")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getMostPopularLabelsInSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getMostPopularLabelsInSpace"));
        _oper.setSoapAction("getMostPopularLabelsInSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getMostPopularLabelsInSpace") == null) {
            _myOperations.put("getMostPopularLabelsInSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getMostPopularLabelsInSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getAttachment", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteAttachment"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getAttachment"));
        _oper.setSoapAction("getAttachment");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getAttachment") == null) {
            _myOperations.put("getAttachment", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getAttachment")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getAttachmentData", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "base64Binary"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getAttachmentData"));
        _oper.setSoapAction("getAttachmentData");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getAttachmentData") == null) {
            _myOperations.put("getAttachmentData", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getAttachmentData")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg4"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("moveAttachment", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "moveAttachment"));
        _oper.setSoapAction("moveAttachment");
        _myOperationsList.add(_oper);
        if (_myOperations.get("moveAttachment") == null) {
            _myOperations.put("moveAttachment", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("moveAttachment")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeAllPermissionsForGroup", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeAllPermissionsForGroup"));
        _oper.setSoapAction("removeAllPermissionsForGroup");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeAllPermissionsForGroup") == null) {
            _myOperations.put("removeAllPermissionsForGroup", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeAllPermissionsForGroup")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("login", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "login"));
        _oper.setSoapAction("login");
        _myOperationsList.add(_oper);
        if (_myOperations.get("login") == null) {
            _myOperations.put("login", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("login")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("AuthenticationFailedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "AuthenticationFailedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.AuthenticationFailedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "AuthenticationFailedException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("logout", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "logout"));
        _oper.setSoapAction("logout");
        _myOperationsList.add(_oper);
        if (_myOperations.get("logout") == null) {
            _myOperations.put("logout", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("logout")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("exportSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "exportSpace"));
        _oper.setSoapAction("exportSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("exportSpace") == null) {
            _myOperations.put("exportSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("exportSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpace"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteSpace"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addSpace"));
        _oper.setSoapAction("addSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addSpace") == null) {
            _myOperations.put("addSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("AlreadyExistsException");
        _fault.setQName(new javax.xml.namespace.QName("x", "AlreadyExistsException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.AlreadyExistsException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "AlreadyExistsException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"), boolean.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getActiveUsers", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getActiveUsers"));
        _oper.setSoapAction("getActiveUsers");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getActiveUsers") == null) {
            _myOperations.put("getActiveUsers", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getActiveUsers")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getPageHistory", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePageHistory"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getPageHistory"));
        _oper.setSoapAction("getPageHistory");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getPageHistory") == null) {
            _myOperations.put("getPageHistory", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getPageHistory")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removePage", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://schemas.xmlsoap.org/soap/encoding/", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removePage"));
        _oper.setSoapAction("removePage");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removePage") == null) {
            _myOperations.put("removePage", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removePage")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("renderContent", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "renderContent"));
        _oper.setSoapAction("renderContent");
        _myOperationsList.add(_oper);
        if (_myOperations.get("renderContent") == null) {
            _myOperations.put("renderContent", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("renderContent")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg4"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/java.util/", "Map"), com.atlassian.www._package.java_util.Map.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("renderContent", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "renderContent"));
        _oper.setSoapAction("renderContent");
        _myOperationsList.add(_oper);
        if (_myOperations.get("renderContent") == null) {
            _myOperations.put("renderContent", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("renderContent")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePage"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("storePage", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePage"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "storePage"));
        _oper.setSoapAction("storePage");
        _myOperationsList.add(_oper);
        if (_myOperations.get("storePage") == null) {
            _myOperations.put("storePage", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("storePage")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("VersionMismatchException");
        _fault.setQName(new javax.xml.namespace.QName("x", "VersionMismatchException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "VersionMismatchException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getSpaceLevelPermissions", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getSpaceLevelPermissions"));
        _oper.setSoapAction("getSpaceLevelPermissions");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getSpaceLevelPermissions") == null) {
            _myOperations.put("getSpaceLevelPermissions", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getSpaceLevelPermissions")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addPermissionToSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addPermissionToSpace"));
        _oper.setSoapAction("addPermissionToSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addPermissionToSpace") == null) {
            _myOperations.put("addPermissionToSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addPermissionToSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"), java.lang.String[].class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addPermissionsToSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addPermissionsToSpace"));
        _oper.setSoapAction("addPermissionsToSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addPermissionsToSpace") == null) {
            _myOperations.put("addPermissionsToSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addPermissionsToSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removePermissionFromSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removePermissionFromSpace"));
        _oper.setSoapAction("removePermissionFromSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removePermissionFromSpace") == null) {
            _myOperations.put("removePermissionFromSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removePermissionFromSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUser"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("editUser", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "editUser"));
        _oper.setSoapAction("editUser");
        _myOperationsList.add(_oper);
        if (_myOperations.get("editUser") == null) {
            _myOperations.put("editUser", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("editUser")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getUserGroups", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getUserGroups"));
        _oper.setSoapAction("getUserGroups");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getUserGroups") == null) {
            _myOperations.put("getUserGroups", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getUserGroups")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addUserToGroup", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addUserToGroup"));
        _oper.setSoapAction("addUserToGroup");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addUserToGroup") == null) {
            _myOperations.put("addUserToGroup", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addUserToGroup")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeUserFromGroup", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeUserFromGroup"));
        _oper.setSoapAction("removeUserFromGroup");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeUserFromGroup") == null) {
            _myOperations.put("removeUserFromGroup", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeUserFromGroup")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("changeMyPassword", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "changeMyPassword"));
        _oper.setSoapAction("changeMyPassword");
        _myOperationsList.add(_oper);
        if (_myOperations.get("changeMyPassword") == null) {
            _myOperations.put("changeMyPassword", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("changeMyPassword")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("changeUserPassword", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "changeUserPassword"));
        _oper.setSoapAction("changeUserPassword");
        _myOperationsList.add(_oper);
        if (_myOperations.get("changeUserPassword") == null) {
            _myOperations.put("changeUserPassword", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("changeUserPassword")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUserInformation"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("setUserInformation", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "setUserInformation"));
        _oper.setSoapAction("setUserInformation");
        _myOperationsList.add(_oper);
        if (_myOperations.get("setUserInformation") == null) {
            _myOperations.put("setUserInformation", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("setUserInformation")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getUserInformation", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUserInformation"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getUserInformation"));
        _oper.setSoapAction("getUserInformation");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getUserInformation") == null) {
            _myOperations.put("getUserInformation", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getUserInformation")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("hasUser", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "hasUser"));
        _oper.setSoapAction("hasUser");
        _myOperationsList.add(_oper);
        if (_myOperations.get("hasUser") == null) {
            _myOperations.put("hasUser", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("hasUser")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("hasGroup", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "hasGroup"));
        _oper.setSoapAction("hasGroup");
        _myOperationsList.add(_oper);
        if (_myOperations.get("hasGroup") == null) {
            _myOperations.put("hasGroup", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("hasGroup")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"), int.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg3"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getBlogEntryByDayAndTitle", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntry"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getBlogEntryByDayAndTitle"));
        _oper.setSoapAction("getBlogEntryByDayAndTitle");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getBlogEntryByDayAndTitle") == null) {
            _myOperations.put("getBlogEntryByDayAndTitle", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getBlogEntryByDayAndTitle")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getBlogEntry", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntry"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getBlogEntry"));
        _oper.setSoapAction("getBlogEntry");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getBlogEntry") == null) {
            _myOperations.put("getBlogEntry", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getBlogEntry")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getBlogEntries", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteBlogEntrySummary"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getBlogEntries"));
        _oper.setSoapAction("getBlogEntries");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getBlogEntries") == null) {
            _myOperations.put("getBlogEntries", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getBlogEntries")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntry"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("storeBlogEntry", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntry"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "storeBlogEntry"));
        _oper.setSoapAction("storeBlogEntry");
        _myOperationsList.add(_oper);
        if (_myOperations.get("storeBlogEntry") == null) {
            _myOperations.put("storeBlogEntry", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("storeBlogEntry")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("VersionMismatchException");
        _fault.setQName(new javax.xml.namespace.QName("x", "VersionMismatchException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "VersionMismatchException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"), boolean.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("exportSite", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "exportSite"));
        _oper.setSoapAction("exportSite");
        _myOperationsList.add(_oper);
        if (_myOperations.get("exportSite") == null) {
            _myOperations.put("exportSite", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("exportSite")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getLabelsById", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteLabel"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getLabelsById"));
        _oper.setSoapAction("getLabelsById");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getLabelsById") == null) {
            _myOperations.put("getLabelsById", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getLabelsById")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getLabelContentById", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getLabelContentById"));
        _oper.setSoapAction("getLabelContentById");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getLabelContentById") == null) {
            _myOperations.put("getLabelContentById", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getLabelContentById")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getLabelContentByName", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getLabelContentByName"));
        _oper.setSoapAction("getLabelContentByName");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getLabelContentByName") == null) {
            _myOperations.put("getLabelContentByName", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getLabelContentByName")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteLabel"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getLabelContentByObject", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemoteSearchResult"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getLabelContentByObject"));
        _oper.setSoapAction("getLabelContentByObject");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getLabelContentByObject") == null) {
            _myOperations.put("getLabelContentByObject", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getLabelContentByObject")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addLabelByName", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addLabelByName"));
        _oper.setSoapAction("addLabelByName");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addLabelByName") == null) {
            _myOperations.put("addLabelByName", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addLabelByName")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addLabelById", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addLabelById"));
        _oper.setSoapAction("addLabelById");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addLabelById") == null) {
            _myOperations.put("addLabelById", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addLabelById")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteLabel"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addLabelByObject", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addLabelByObject"));
        _oper.setSoapAction("addLabelByObject");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addLabelByObject") == null) {
            _myOperations.put("addLabelByObject", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addLabelByObject")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addLabelByNameToSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addLabelByNameToSpace"));
        _oper.setSoapAction("addLabelByNameToSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addLabelByNameToSpace") == null) {
            _myOperations.put("addLabelByNameToSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addLabelByNameToSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeLabelByName", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeLabelByName"));
        _oper.setSoapAction("removeLabelByName");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeLabelByName") == null) {
            _myOperations.put("removeLabelByName", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeLabelByName")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeLabelById", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeLabelById"));
        _oper.setSoapAction("removeLabelById");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeLabelById") == null) {
            _myOperations.put("removeLabelById", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeLabelById")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteLabel"), com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeLabelByObject", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeLabelByObject"));
        _oper.setSoapAction("removeLabelByObject");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeLabelByObject") == null) {
            _myOperations.put("removeLabelByObject", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeLabelByObject")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeLabelByNameFromSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeLabelByNameFromSpace"));
        _oper.setSoapAction("removeLabelByNameFromSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeLabelByNameFromSpace") == null) {
            _myOperations.put("removeLabelByNameFromSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeLabelByNameFromSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getPermissionsForUser", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getPermissionsForUser"));
        _oper.setSoapAction("getPermissionsForUser");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getPermissionsForUser") == null) {
            _myOperations.put("getPermissionsForUser", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getPermissionsForUser")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addAnonymousPermissionToSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addAnonymousPermissionToSpace"));
        _oper.setSoapAction("addAnonymousPermissionToSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addAnonymousPermissionToSpace") == null) {
            _myOperations.put("addAnonymousPermissionToSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addAnonymousPermissionToSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.themindelectric.com/2001/schemaArray/", "ArrayOfstring"), java.lang.String[].class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("addAnonymousPermissionsToSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "addAnonymousPermissionsToSpace"));
        _oper.setSoapAction("addAnonymousPermissionsToSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("addAnonymousPermissionsToSpace") == null) {
            _myOperations.put("addAnonymousPermissionsToSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("addAnonymousPermissionsToSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg2"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("removeAnonymousPermissionFromSpace", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "removeAnonymousPermissionFromSpace"));
        _oper.setSoapAction("removeAnonymousPermissionFromSpace");
        _myOperationsList.add(_oper);
        if (_myOperations.get("removeAnonymousPermissionFromSpace") == null) {
            _myOperations.put("removeAnonymousPermissionFromSpace", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("removeAnonymousPermissionFromSpace")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("NotPermittedException");
        _fault.setQName(new javax.xml.namespace.QName("x", "NotPermittedException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "NotPermittedException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
        _params = new org.apache.axis.description.ParameterDesc [] {
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg0"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"), java.lang.String.class, false, false), 
            new org.apache.axis.description.ParameterDesc(new javax.xml.namespace.QName("", "arg1"), org.apache.axis.description.ParameterDesc.IN, new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"), long.class, false, false), 
        };
        _oper = new org.apache.axis.description.OperationDesc("getPagePermissions", _params, new javax.xml.namespace.QName("", "Result"));
        _oper.setReturnType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "ArrayOfRemotePermission"));
        _oper.setElementQName(new javax.xml.namespace.QName("x", "getPagePermissions"));
        _oper.setSoapAction("getPagePermissions");
        _myOperationsList.add(_oper);
        if (_myOperations.get("getPagePermissions") == null) {
            _myOperations.put("getPagePermissions", new java.util.ArrayList());
        }
        ((java.util.List)_myOperations.get("getPagePermissions")).add(_oper);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("InvalidSessionException");
        _fault.setQName(new javax.xml.namespace.QName("x", "InvalidSessionException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "InvalidSessionException"));
        _oper.addFault(_fault);
        _fault = new org.apache.axis.description.FaultDesc();
        _fault.setName("RemoteException");
        _fault.setQName(new javax.xml.namespace.QName("x", "RemoteException"));
        _fault.setClassName("com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException");
        _fault.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc/", "RemoteException"));
        _oper.addFault(_fault);
    }

    public ConfluenceSoapServiceSkeleton() {
        this.impl = new com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceImpl();
    }

    public ConfluenceSoapServiceSkeleton(com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapService impl) {
        this.impl = impl;
    }
    public java.lang.String[] getPermissions(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String[] ret = impl.getPermissions(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] search(java.lang.String arg0, java.lang.String arg1, com.atlassian.www._package.java_util.Map arg2, int arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] ret = impl.search(arg0, arg1, arg2, arg3);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] search(java.lang.String arg0, java.lang.String arg1, int arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] ret = impl.search(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment getComment(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment ret = impl.getComment(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteServerInfo getServerInfo(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteServerInfo ret = impl.getServerInfo(arg0);
        return ret;
    }

    public java.lang.Boolean removeSpace(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.Boolean ret = impl.removeSpace(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace getSpace(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace ret = impl.getSpace(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary[] getSpaces(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary[] ret = impl.getSpaces(arg0);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] getPages(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] ret = impl.getPages(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment addComment(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment ret = impl.addComment(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser getUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser ret = impl.getUser(arg0, arg1);
        return ret;
    }

    public boolean removeGroup(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeGroup(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage getPage(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage ret = impl.getPage(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage getPage(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage ret = impl.getPage(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] getDescendents(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] ret = impl.getDescendents(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment[] getAttachments(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment[] ret = impl.getAttachments(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment addAttachment(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment arg1, byte[] arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment ret = impl.addAttachment(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment addAttachment(java.lang.String arg0, long arg1, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment arg2, byte[] arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment ret = impl.addAttachment(arg0, arg1, arg2, arg3);
        return ret;
    }

    public boolean removeAttachment(java.lang.String arg0, long arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeAttachment(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] getChildren(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] ret = impl.getChildren(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] getAncestors(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] ret = impl.getAncestors(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment[] getComments(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment[] ret = impl.getComments(arg0, arg1);
        return ret;
    }

    public boolean removeComment(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeComment(arg0, arg1);
        return ret;
    }

    public void addUser(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        impl.addUser(arg0, arg1, arg2);
    }

    public boolean addGroup(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addGroup(arg0, arg1);
        return ret;
    }

    public boolean removeUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeUser(arg0, arg1);
        return ret;
    }

    public boolean deactivateUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.deactivateUser(arg0, arg1);
        return ret;
    }

    public boolean reactivateUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.reactivateUser(arg0, arg1);
        return ret;
    }

    public java.lang.String[] getGroups(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String[] ret = impl.getGroups(arg0);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getRelatedLabels(java.lang.String arg0, java.lang.String arg1, int arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] ret = impl.getRelatedLabels(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getRelatedLabelsInSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, int arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] ret = impl.getRelatedLabelsInSpace(arg0, arg1, arg2, arg3);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[] getSpacesContainingContentWithLabel(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[] ret = impl.getSpacesContainingContentWithLabel(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getRecentlyUsedLabelsInSpace(java.lang.String arg0, java.lang.String arg1, int arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] ret = impl.getRecentlyUsedLabelsInSpace(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getRecentlyUsedLabels(java.lang.String arg0, int arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] ret = impl.getRecentlyUsedLabels(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[] getSpacesWithLabel(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[] ret = impl.getSpacesWithLabel(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getLabelsByDetail(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, java.lang.String arg3, java.lang.String arg4) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] ret = impl.getLabelsByDetail(arg0, arg1, arg2, arg3, arg4);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getMostPopularLabels(java.lang.String arg0, int arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] ret = impl.getMostPopularLabels(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getMostPopularLabelsInSpace(java.lang.String arg0, java.lang.String arg1, int arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] ret = impl.getMostPopularLabelsInSpace(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment getAttachment(java.lang.String arg0, long arg1, java.lang.String arg2, int arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment ret = impl.getAttachment(arg0, arg1, arg2, arg3);
        return ret;
    }

    public byte[] getAttachmentData(java.lang.String arg0, long arg1, java.lang.String arg2, int arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        byte[] ret = impl.getAttachmentData(arg0, arg1, arg2, arg3);
        return ret;
    }

    public boolean moveAttachment(java.lang.String arg0, long arg1, java.lang.String arg2, long arg3, java.lang.String arg4) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.moveAttachment(arg0, arg1, arg2, arg3, arg4);
        return ret;
    }

    public boolean removeAllPermissionsForGroup(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeAllPermissionsForGroup(arg0, arg1);
        return ret;
    }

    public java.lang.String login(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.AuthenticationFailedException
    {
        java.lang.String ret = impl.login(arg0, arg1);
        return ret;
    }

    public boolean logout(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.logout(arg0);
        return ret;
    }

    public java.lang.String exportSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String ret = impl.exportSpace(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace addSpace(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.AlreadyExistsException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace ret = impl.addSpace(arg0, arg1);
        return ret;
    }

    public java.lang.String[] getActiveUsers(java.lang.String arg0, boolean arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String[] ret = impl.getActiveUsers(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory[] getPageHistory(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory[] ret = impl.getPageHistory(arg0, arg1);
        return ret;
    }

    public java.lang.Boolean removePage(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.Boolean ret = impl.removePage(arg0, arg1);
        return ret;
    }

    public java.lang.String renderContent(java.lang.String arg0, java.lang.String arg1, long arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String ret = impl.renderContent(arg0, arg1, arg2, arg3);
        return ret;
    }

    public java.lang.String renderContent(java.lang.String arg0, java.lang.String arg1, long arg2, java.lang.String arg3, com.atlassian.www._package.java_util.Map arg4) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String ret = impl.renderContent(arg0, arg1, arg2, arg3, arg4);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage storePage(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage ret = impl.storePage(arg0, arg1);
        return ret;
    }

    public java.lang.String[] getSpaceLevelPermissions(java.lang.String arg0) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String[] ret = impl.getSpaceLevelPermissions(arg0);
        return ret;
    }

    public boolean addPermissionToSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addPermissionToSpace(arg0, arg1, arg2, arg3);
        return ret;
    }

    public boolean addPermissionsToSpace(java.lang.String arg0, java.lang.String[] arg1, java.lang.String arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addPermissionsToSpace(arg0, arg1, arg2, arg3);
        return ret;
    }

    public boolean removePermissionFromSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removePermissionFromSpace(arg0, arg1, arg2, arg3);
        return ret;
    }

    public boolean editUser(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.editUser(arg0, arg1);
        return ret;
    }

    public java.lang.String[] getUserGroups(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String[] ret = impl.getUserGroups(arg0, arg1);
        return ret;
    }

    public boolean addUserToGroup(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addUserToGroup(arg0, arg1, arg2);
        return ret;
    }

    public boolean removeUserFromGroup(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeUserFromGroup(arg0, arg1, arg2);
        return ret;
    }

    public boolean changeMyPassword(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.changeMyPassword(arg0, arg1, arg2);
        return ret;
    }

    public boolean changeUserPassword(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.changeUserPassword(arg0, arg1, arg2);
        return ret;
    }

    public boolean setUserInformation(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.setUserInformation(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation getUserInformation(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation ret = impl.getUserInformation(arg0, arg1);
        return ret;
    }

    public boolean hasUser(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.hasUser(arg0, arg1);
        return ret;
    }

    public boolean hasGroup(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.hasGroup(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry getBlogEntryByDayAndTitle(java.lang.String arg0, java.lang.String arg1, int arg2, java.lang.String arg3) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry ret = impl.getBlogEntryByDayAndTitle(arg0, arg1, arg2, arg3);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry getBlogEntry(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry ret = impl.getBlogEntry(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary[] getBlogEntries(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary[] ret = impl.getBlogEntries(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry storeBlogEntry(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry ret = impl.storeBlogEntry(arg0, arg1);
        return ret;
    }

    public java.lang.String exportSite(java.lang.String arg0, boolean arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String ret = impl.exportSite(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] getLabelsById(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] ret = impl.getLabelsById(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] getLabelContentById(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] ret = impl.getLabelContentById(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] getLabelContentByName(java.lang.String arg0, java.lang.String arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] ret = impl.getLabelContentByName(arg0, arg1);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] getLabelContentByObject(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] ret = impl.getLabelContentByObject(arg0, arg1);
        return ret;
    }

    public boolean addLabelByName(java.lang.String arg0, java.lang.String arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addLabelByName(arg0, arg1, arg2);
        return ret;
    }

    public boolean addLabelById(java.lang.String arg0, long arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addLabelById(arg0, arg1, arg2);
        return ret;
    }

    public boolean addLabelByObject(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addLabelByObject(arg0, arg1, arg2);
        return ret;
    }

    public boolean addLabelByNameToSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addLabelByNameToSpace(arg0, arg1, arg2);
        return ret;
    }

    public boolean removeLabelByName(java.lang.String arg0, java.lang.String arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeLabelByName(arg0, arg1, arg2);
        return ret;
    }

    public boolean removeLabelById(java.lang.String arg0, long arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeLabelById(arg0, arg1, arg2);
        return ret;
    }

    public boolean removeLabelByObject(java.lang.String arg0, com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel arg1, long arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeLabelByObject(arg0, arg1, arg2);
        return ret;
    }

    public boolean removeLabelByNameFromSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeLabelByNameFromSpace(arg0, arg1, arg2);
        return ret;
    }

    public java.lang.String[] getPermissionsForUser(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        java.lang.String[] ret = impl.getPermissionsForUser(arg0, arg1, arg2);
        return ret;
    }

    public boolean addAnonymousPermissionToSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addAnonymousPermissionToSpace(arg0, arg1, arg2);
        return ret;
    }

    public boolean addAnonymousPermissionsToSpace(java.lang.String arg0, java.lang.String[] arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.addAnonymousPermissionsToSpace(arg0, arg1, arg2);
        return ret;
    }

    public boolean removeAnonymousPermissionFromSpace(java.lang.String arg0, java.lang.String arg1, java.lang.String arg2) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        boolean ret = impl.removeAnonymousPermissionFromSpace(arg0, arg1, arg2);
        return ret;
    }

    public com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission[] getPagePermissions(java.lang.String arg0, long arg1) throws java.rmi.RemoteException, com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException, com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException
    {
        com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission[] ret = impl.getPagePermissions(arg0, arg1);
        return ret;
    }

}
