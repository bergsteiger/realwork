/**
 * RemoteServerInfo.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans;

public class RemoteServerInfo  implements java.io.Serializable {
    private int majorVersion;

    private int minorVersion;

    private int patchLevel;

    private boolean developmentBuild;

    private java.lang.String buildId;

    private java.lang.String baseUrl;

    public RemoteServerInfo() {
    }

    public RemoteServerInfo(
           int majorVersion,
           int minorVersion,
           int patchLevel,
           boolean developmentBuild,
           java.lang.String buildId,
           java.lang.String baseUrl) {
           this.majorVersion = majorVersion;
           this.minorVersion = minorVersion;
           this.patchLevel = patchLevel;
           this.developmentBuild = developmentBuild;
           this.buildId = buildId;
           this.baseUrl = baseUrl;
    }


    /**
     * Gets the majorVersion value for this RemoteServerInfo.
     * 
     * @return majorVersion
     */
    public int getMajorVersion() {
        return majorVersion;
    }


    /**
     * Sets the majorVersion value for this RemoteServerInfo.
     * 
     * @param majorVersion
     */
    public void setMajorVersion(int majorVersion) {
        this.majorVersion = majorVersion;
    }


    /**
     * Gets the minorVersion value for this RemoteServerInfo.
     * 
     * @return minorVersion
     */
    public int getMinorVersion() {
        return minorVersion;
    }


    /**
     * Sets the minorVersion value for this RemoteServerInfo.
     * 
     * @param minorVersion
     */
    public void setMinorVersion(int minorVersion) {
        this.minorVersion = minorVersion;
    }


    /**
     * Gets the patchLevel value for this RemoteServerInfo.
     * 
     * @return patchLevel
     */
    public int getPatchLevel() {
        return patchLevel;
    }


    /**
     * Sets the patchLevel value for this RemoteServerInfo.
     * 
     * @param patchLevel
     */
    public void setPatchLevel(int patchLevel) {
        this.patchLevel = patchLevel;
    }


    /**
     * Gets the developmentBuild value for this RemoteServerInfo.
     * 
     * @return developmentBuild
     */
    public boolean isDevelopmentBuild() {
        return developmentBuild;
    }


    /**
     * Sets the developmentBuild value for this RemoteServerInfo.
     * 
     * @param developmentBuild
     */
    public void setDevelopmentBuild(boolean developmentBuild) {
        this.developmentBuild = developmentBuild;
    }


    /**
     * Gets the buildId value for this RemoteServerInfo.
     * 
     * @return buildId
     */
    public java.lang.String getBuildId() {
        return buildId;
    }


    /**
     * Sets the buildId value for this RemoteServerInfo.
     * 
     * @param buildId
     */
    public void setBuildId(java.lang.String buildId) {
        this.buildId = buildId;
    }


    /**
     * Gets the baseUrl value for this RemoteServerInfo.
     * 
     * @return baseUrl
     */
    public java.lang.String getBaseUrl() {
        return baseUrl;
    }


    /**
     * Sets the baseUrl value for this RemoteServerInfo.
     * 
     * @param baseUrl
     */
    public void setBaseUrl(java.lang.String baseUrl) {
        this.baseUrl = baseUrl;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof RemoteServerInfo)) return false;
        RemoteServerInfo other = (RemoteServerInfo) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.majorVersion == other.getMajorVersion() &&
            this.minorVersion == other.getMinorVersion() &&
            this.patchLevel == other.getPatchLevel() &&
            this.developmentBuild == other.isDevelopmentBuild() &&
            ((this.buildId==null && other.getBuildId()==null) || 
             (this.buildId!=null &&
              this.buildId.equals(other.getBuildId()))) &&
            ((this.baseUrl==null && other.getBaseUrl()==null) || 
             (this.baseUrl!=null &&
              this.baseUrl.equals(other.getBaseUrl())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        _hashCode += getMajorVersion();
        _hashCode += getMinorVersion();
        _hashCode += getPatchLevel();
        _hashCode += (isDevelopmentBuild() ? Boolean.TRUE : Boolean.FALSE).hashCode();
        if (getBuildId() != null) {
            _hashCode += getBuildId().hashCode();
        }
        if (getBaseUrl() != null) {
            _hashCode += getBaseUrl().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(RemoteServerInfo.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteServerInfo"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("majorVersion");
        elemField.setXmlName(new javax.xml.namespace.QName("", "majorVersion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("minorVersion");
        elemField.setXmlName(new javax.xml.namespace.QName("", "minorVersion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("patchLevel");
        elemField.setXmlName(new javax.xml.namespace.QName("", "patchLevel"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("developmentBuild");
        elemField.setXmlName(new javax.xml.namespace.QName("", "developmentBuild"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "boolean"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("buildId");
        elemField.setXmlName(new javax.xml.namespace.QName("", "buildId"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("baseUrl");
        elemField.setXmlName(new javax.xml.namespace.QName("", "baseUrl"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
