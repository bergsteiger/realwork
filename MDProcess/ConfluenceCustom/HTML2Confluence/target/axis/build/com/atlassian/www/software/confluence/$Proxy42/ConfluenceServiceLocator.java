/**
 * ConfluenceServiceLocator.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.atlassian.www.software.confluence.$Proxy42;

public class ConfluenceServiceLocator extends org.apache.axis.client.Service implements com.atlassian.www.software.confluence.$Proxy42.ConfluenceService {

/**
 * instance of class $Proxy42
 */

    public ConfluenceServiceLocator() {
    }


    public ConfluenceServiceLocator(org.apache.axis.EngineConfiguration config) {
        super(config);
    }

    public ConfluenceServiceLocator(java.lang.String wsdlLoc, javax.xml.namespace.QName sName) throws javax.xml.rpc.ServiceException {
        super(wsdlLoc, sName);
    }

    // Use to get a proxy class for ConfluenceSoapService
    private java.lang.String ConfluenceSoapService_address = "http://172.16.0.35/rpc/soap/confluenceservice-v1";

    public java.lang.String getConfluenceSoapServiceAddress() {
        return ConfluenceSoapService_address;
    }

    // The WSDD service name defaults to the port name.
    private java.lang.String ConfluenceSoapServiceWSDDServiceName = "ConfluenceSoapService";

    public java.lang.String getConfluenceSoapServiceWSDDServiceName() {
        return ConfluenceSoapServiceWSDDServiceName;
    }

    public void setConfluenceSoapServiceWSDDServiceName(java.lang.String name) {
        ConfluenceSoapServiceWSDDServiceName = name;
    }

    public com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapService getConfluenceSoapService() throws javax.xml.rpc.ServiceException {
       java.net.URL endpoint;
        try {
            endpoint = new java.net.URL(ConfluenceSoapService_address);
        }
        catch (java.net.MalformedURLException e) {
            throw new javax.xml.rpc.ServiceException(e);
        }
        return getConfluenceSoapService(endpoint);
    }

    public com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapService getConfluenceSoapService(java.net.URL portAddress) throws javax.xml.rpc.ServiceException {
        try {
            com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub _stub = new com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub(portAddress, this);
            _stub.setPortName(getConfluenceSoapServiceWSDDServiceName());
            return _stub;
        }
        catch (org.apache.axis.AxisFault e) {
            return null;
        }
    }

    public void setConfluenceSoapServiceEndpointAddress(java.lang.String address) {
        ConfluenceSoapService_address = address;
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        try {
            if (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapService.class.isAssignableFrom(serviceEndpointInterface)) {
                com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub _stub = new com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub(new java.net.URL(ConfluenceSoapService_address), this);
                _stub.setPortName(getConfluenceSoapServiceWSDDServiceName());
                return _stub;
            }
        }
        catch (java.lang.Throwable t) {
            throw new javax.xml.rpc.ServiceException(t);
        }
        throw new javax.xml.rpc.ServiceException("There is no stub implementation for the interface:  " + (serviceEndpointInterface == null ? "null" : serviceEndpointInterface.getName()));
    }

    /**
     * For the given interface, get the stub implementation.
     * If this service has no port for the given interface,
     * then ServiceException is thrown.
     */
    public java.rmi.Remote getPort(javax.xml.namespace.QName portName, Class serviceEndpointInterface) throws javax.xml.rpc.ServiceException {
        if (portName == null) {
            return getPort(serviceEndpointInterface);
        }
        java.lang.String inputPortName = portName.getLocalPart();
        if ("ConfluenceSoapService".equals(inputPortName)) {
            return getConfluenceSoapService();
        }
        else  {
            java.rmi.Remote _stub = getPort(serviceEndpointInterface);
            ((org.apache.axis.client.Stub) _stub).setPortName(portName);
            return _stub;
        }
    }

    public javax.xml.namespace.QName getServiceName() {
        return new javax.xml.namespace.QName("http://www.atlassian.com/software/confluence/$Proxy42/", "ConfluenceService");
    }

    private java.util.HashSet ports = null;

    public java.util.Iterator getPorts() {
        if (ports == null) {
            ports = new java.util.HashSet();
            ports.add(new javax.xml.namespace.QName("http://www.atlassian.com/software/confluence/$Proxy42/", "ConfluenceSoapService"));
        }
        return ports.iterator();
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(java.lang.String portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        
if ("ConfluenceSoapService".equals(portName)) {
            setConfluenceSoapServiceEndpointAddress(address);
        }
        else 
{ // Unknown Port Name
            throw new javax.xml.rpc.ServiceException(" Cannot set Endpoint Address for Unknown Port" + portName);
        }
    }

    /**
    * Set the endpoint address for the specified port name.
    */
    public void setEndpointAddress(javax.xml.namespace.QName portName, java.lang.String address) throws javax.xml.rpc.ServiceException {
        setEndpointAddress(portName.getLocalPart(), address);
    }

}
