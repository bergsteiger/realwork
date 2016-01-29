/**
 * RemotePermission.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans;

public class RemotePermission  implements java.io.Serializable {
    private java.lang.String lockType;

    private java.lang.String lockedBy;

    public RemotePermission() {
    }

    public RemotePermission(
           java.lang.String lockType,
           java.lang.String lockedBy) {
           this.lockType = lockType;
           this.lockedBy = lockedBy;
    }


    /**
     * Gets the lockType value for this RemotePermission.
     * 
     * @return lockType
     */
    public java.lang.String getLockType() {
        return lockType;
    }


    /**
     * Sets the lockType value for this RemotePermission.
     * 
     * @param lockType
     */
    public void setLockType(java.lang.String lockType) {
        this.lockType = lockType;
    }


    /**
     * Gets the lockedBy value for this RemotePermission.
     * 
     * @return lockedBy
     */
    public java.lang.String getLockedBy() {
        return lockedBy;
    }


    /**
     * Sets the lockedBy value for this RemotePermission.
     * 
     * @param lockedBy
     */
    public void setLockedBy(java.lang.String lockedBy) {
        this.lockedBy = lockedBy;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof RemotePermission)) return false;
        RemotePermission other = (RemotePermission) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.lockType==null && other.getLockType()==null) || 
             (this.lockType!=null &&
              this.lockType.equals(other.getLockType()))) &&
            ((this.lockedBy==null && other.getLockedBy()==null) || 
             (this.lockedBy!=null &&
              this.lockedBy.equals(other.getLockedBy())));
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
        if (getLockType() != null) {
            _hashCode += getLockType().hashCode();
        }
        if (getLockedBy() != null) {
            _hashCode += getLockedBy().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(RemotePermission.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemotePermission"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("lockType");
        elemField.setXmlName(new javax.xml.namespace.QName("", "lockType"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("lockedBy");
        elemField.setXmlName(new javax.xml.namespace.QName("", "lockedBy"));
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
