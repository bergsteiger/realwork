/**
 * RemoteUserInformation.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans;

public class RemoteUserInformation  implements java.io.Serializable {
    private java.lang.String username;

    private java.lang.String content;

    private java.lang.String creatorName;

    private java.lang.String lastModifierName;

    private int version;

    private long id;

    private java.util.Calendar creationDate;

    private java.util.Calendar lastModificationDate;

    public RemoteUserInformation() {
    }

    public RemoteUserInformation(
           java.lang.String username,
           java.lang.String content,
           java.lang.String creatorName,
           java.lang.String lastModifierName,
           int version,
           long id,
           java.util.Calendar creationDate,
           java.util.Calendar lastModificationDate) {
           this.username = username;
           this.content = content;
           this.creatorName = creatorName;
           this.lastModifierName = lastModifierName;
           this.version = version;
           this.id = id;
           this.creationDate = creationDate;
           this.lastModificationDate = lastModificationDate;
    }


    /**
     * Gets the username value for this RemoteUserInformation.
     * 
     * @return username
     */
    public java.lang.String getUsername() {
        return username;
    }


    /**
     * Sets the username value for this RemoteUserInformation.
     * 
     * @param username
     */
    public void setUsername(java.lang.String username) {
        this.username = username;
    }


    /**
     * Gets the content value for this RemoteUserInformation.
     * 
     * @return content
     */
    public java.lang.String getContent() {
        return content;
    }


    /**
     * Sets the content value for this RemoteUserInformation.
     * 
     * @param content
     */
    public void setContent(java.lang.String content) {
        this.content = content;
    }


    /**
     * Gets the creatorName value for this RemoteUserInformation.
     * 
     * @return creatorName
     */
    public java.lang.String getCreatorName() {
        return creatorName;
    }


    /**
     * Sets the creatorName value for this RemoteUserInformation.
     * 
     * @param creatorName
     */
    public void setCreatorName(java.lang.String creatorName) {
        this.creatorName = creatorName;
    }


    /**
     * Gets the lastModifierName value for this RemoteUserInformation.
     * 
     * @return lastModifierName
     */
    public java.lang.String getLastModifierName() {
        return lastModifierName;
    }


    /**
     * Sets the lastModifierName value for this RemoteUserInformation.
     * 
     * @param lastModifierName
     */
    public void setLastModifierName(java.lang.String lastModifierName) {
        this.lastModifierName = lastModifierName;
    }


    /**
     * Gets the version value for this RemoteUserInformation.
     * 
     * @return version
     */
    public int getVersion() {
        return version;
    }


    /**
     * Sets the version value for this RemoteUserInformation.
     * 
     * @param version
     */
    public void setVersion(int version) {
        this.version = version;
    }


    /**
     * Gets the id value for this RemoteUserInformation.
     * 
     * @return id
     */
    public long getId() {
        return id;
    }


    /**
     * Sets the id value for this RemoteUserInformation.
     * 
     * @param id
     */
    public void setId(long id) {
        this.id = id;
    }


    /**
     * Gets the creationDate value for this RemoteUserInformation.
     * 
     * @return creationDate
     */
    public java.util.Calendar getCreationDate() {
        return creationDate;
    }


    /**
     * Sets the creationDate value for this RemoteUserInformation.
     * 
     * @param creationDate
     */
    public void setCreationDate(java.util.Calendar creationDate) {
        this.creationDate = creationDate;
    }


    /**
     * Gets the lastModificationDate value for this RemoteUserInformation.
     * 
     * @return lastModificationDate
     */
    public java.util.Calendar getLastModificationDate() {
        return lastModificationDate;
    }


    /**
     * Sets the lastModificationDate value for this RemoteUserInformation.
     * 
     * @param lastModificationDate
     */
    public void setLastModificationDate(java.util.Calendar lastModificationDate) {
        this.lastModificationDate = lastModificationDate;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof RemoteUserInformation)) return false;
        RemoteUserInformation other = (RemoteUserInformation) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.username==null && other.getUsername()==null) || 
             (this.username!=null &&
              this.username.equals(other.getUsername()))) &&
            ((this.content==null && other.getContent()==null) || 
             (this.content!=null &&
              this.content.equals(other.getContent()))) &&
            ((this.creatorName==null && other.getCreatorName()==null) || 
             (this.creatorName!=null &&
              this.creatorName.equals(other.getCreatorName()))) &&
            ((this.lastModifierName==null && other.getLastModifierName()==null) || 
             (this.lastModifierName!=null &&
              this.lastModifierName.equals(other.getLastModifierName()))) &&
            this.version == other.getVersion() &&
            this.id == other.getId() &&
            ((this.creationDate==null && other.getCreationDate()==null) || 
             (this.creationDate!=null &&
              this.creationDate.equals(other.getCreationDate()))) &&
            ((this.lastModificationDate==null && other.getLastModificationDate()==null) || 
             (this.lastModificationDate!=null &&
              this.lastModificationDate.equals(other.getLastModificationDate())));
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
        if (getUsername() != null) {
            _hashCode += getUsername().hashCode();
        }
        if (getContent() != null) {
            _hashCode += getContent().hashCode();
        }
        if (getCreatorName() != null) {
            _hashCode += getCreatorName().hashCode();
        }
        if (getLastModifierName() != null) {
            _hashCode += getLastModifierName().hashCode();
        }
        _hashCode += getVersion();
        _hashCode += new Long(getId()).hashCode();
        if (getCreationDate() != null) {
            _hashCode += getCreationDate().hashCode();
        }
        if (getLastModificationDate() != null) {
            _hashCode += getLastModificationDate().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(RemoteUserInformation.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteUserInformation"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("username");
        elemField.setXmlName(new javax.xml.namespace.QName("", "username"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("content");
        elemField.setXmlName(new javax.xml.namespace.QName("", "content"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("creatorName");
        elemField.setXmlName(new javax.xml.namespace.QName("", "creatorName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("lastModifierName");
        elemField.setXmlName(new javax.xml.namespace.QName("", "lastModifierName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("version");
        elemField.setXmlName(new javax.xml.namespace.QName("", "version"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("id");
        elemField.setXmlName(new javax.xml.namespace.QName("", "id"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("creationDate");
        elemField.setXmlName(new javax.xml.namespace.QName("", "creationDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("lastModificationDate");
        elemField.setXmlName(new javax.xml.namespace.QName("", "lastModificationDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
        elemField.setNillable(false);
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
