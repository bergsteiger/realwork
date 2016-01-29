/**
 * RemoteBlogEntrySummary.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans;

public class RemoteBlogEntrySummary  extends com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.AbstractRemotePageSummary  implements java.io.Serializable {
    private java.util.Calendar publishDate;

    private java.lang.String author;

    public RemoteBlogEntrySummary() {
    }

    public RemoteBlogEntrySummary(
           long id,
           java.lang.String space,
           java.lang.String title,
           java.lang.String url,
           int permissions,
           java.util.Calendar publishDate,
           java.lang.String author) {
        super(
            id,
            space,
            title,
            url,
            permissions);
        this.publishDate = publishDate;
        this.author = author;
    }


    /**
     * Gets the publishDate value for this RemoteBlogEntrySummary.
     * 
     * @return publishDate
     */
    public java.util.Calendar getPublishDate() {
        return publishDate;
    }


    /**
     * Sets the publishDate value for this RemoteBlogEntrySummary.
     * 
     * @param publishDate
     */
    public void setPublishDate(java.util.Calendar publishDate) {
        this.publishDate = publishDate;
    }


    /**
     * Gets the author value for this RemoteBlogEntrySummary.
     * 
     * @return author
     */
    public java.lang.String getAuthor() {
        return author;
    }


    /**
     * Sets the author value for this RemoteBlogEntrySummary.
     * 
     * @param author
     */
    public void setAuthor(java.lang.String author) {
        this.author = author;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof RemoteBlogEntrySummary)) return false;
        RemoteBlogEntrySummary other = (RemoteBlogEntrySummary) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = super.equals(obj) && 
            ((this.publishDate==null && other.getPublishDate()==null) || 
             (this.publishDate!=null &&
              this.publishDate.equals(other.getPublishDate()))) &&
            ((this.author==null && other.getAuthor()==null) || 
             (this.author!=null &&
              this.author.equals(other.getAuthor())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = super.hashCode();
        if (getPublishDate() != null) {
            _hashCode += getPublishDate().hashCode();
        }
        if (getAuthor() != null) {
            _hashCode += getAuthor().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(RemoteBlogEntrySummary.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://www.atlassian.com/package/com.atlassian.confluence.rpc.soap.beans/", "RemoteBlogEntrySummary"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("publishDate");
        elemField.setXmlName(new javax.xml.namespace.QName("", "publishDate"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "dateTime"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("author");
        elemField.setXmlName(new javax.xml.namespace.QName("", "author"));
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
