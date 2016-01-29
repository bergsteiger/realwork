/**
 * ConfluenceServiceTestCase.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.3 Oct 05, 2005 (05:23:37 EDT) WSDL2Java emitter.
 */

package com.atlassian.www.software.confluence.$Proxy42;

public class ConfluenceServiceTestCase extends junit.framework.TestCase {
    public ConfluenceServiceTestCase(java.lang.String name) {
        super(name);
    }

    public void testConfluenceSoapServiceWSDL() throws Exception {
        javax.xml.rpc.ServiceFactory serviceFactory = javax.xml.rpc.ServiceFactory.newInstance();
        java.net.URL url = new java.net.URL(new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapServiceAddress() + "?WSDL");
        javax.xml.rpc.Service service = serviceFactory.createService(url, new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getServiceName());
        assertTrue(service != null);
    }

    public void test1ConfluenceSoapServiceGetPermissions() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String[] value = null;
            value = binding.getPermissions(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test2ConfluenceSoapServiceSearch() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] value = null;
            value = binding.search(new java.lang.String(), new java.lang.String(), new com.atlassian.www._package.java_util.Map(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test3ConfluenceSoapServiceSearch() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] value = null;
            value = binding.search(new java.lang.String(), new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test4ConfluenceSoapServiceGetComment() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment value = null;
            value = binding.getComment(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test5ConfluenceSoapServiceGetServerInfo() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteServerInfo value = null;
            value = binding.getServerInfo(new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test6ConfluenceSoapServiceRemoveSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.Boolean value = null;
            value = binding.removeSpace(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test7ConfluenceSoapServiceGetSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace value = null;
            value = binding.getSpace(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test8ConfluenceSoapServiceGetSpaces() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpaceSummary[] value = null;
            value = binding.getSpaces(new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test9ConfluenceSoapServiceGetPages() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] value = null;
            value = binding.getPages(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test10ConfluenceSoapServiceAddComment() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment value = null;
            value = binding.addComment(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test11ConfluenceSoapServiceGetUser() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser value = null;
            value = binding.getUser(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test12ConfluenceSoapServiceRemoveGroup() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeGroup(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test13ConfluenceSoapServiceGetPage() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage value = null;
            value = binding.getPage(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test14ConfluenceSoapServiceGetPage() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage value = null;
            value = binding.getPage(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test15ConfluenceSoapServiceGetDescendents() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] value = null;
            value = binding.getDescendents(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test16ConfluenceSoapServiceGetAttachments() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment[] value = null;
            value = binding.getAttachments(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test17ConfluenceSoapServiceAddAttachment() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment value = null;
            value = binding.addAttachment(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment(), new byte[0]);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test18ConfluenceSoapServiceAddAttachment() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment value = null;
            value = binding.addAttachment(new java.lang.String(), 0, new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment(), new byte[0]);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test19ConfluenceSoapServiceRemoveAttachment() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeAttachment(new java.lang.String(), 0, new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test20ConfluenceSoapServiceGetChildren() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] value = null;
            value = binding.getChildren(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test21ConfluenceSoapServiceGetAncestors() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageSummary[] value = null;
            value = binding.getAncestors(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test22ConfluenceSoapServiceGetComments() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteComment[] value = null;
            value = binding.getComments(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test23ConfluenceSoapServiceRemoveComment() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeComment(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test24ConfluenceSoapServiceAddUser() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            binding.addUser(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test25ConfluenceSoapServiceAddGroup() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addGroup(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test26ConfluenceSoapServiceRemoveUser() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeUser(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test27ConfluenceSoapServiceDeactivateUser() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.deactivateUser(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test28ConfluenceSoapServiceReactivateUser() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.reactivateUser(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test29ConfluenceSoapServiceGetGroups() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String[] value = null;
            value = binding.getGroups(new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test30ConfluenceSoapServiceGetRelatedLabels() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] value = null;
            value = binding.getRelatedLabels(new java.lang.String(), new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test31ConfluenceSoapServiceGetRelatedLabelsInSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] value = null;
            value = binding.getRelatedLabelsInSpace(new java.lang.String(), new java.lang.String(), new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test32ConfluenceSoapServiceGetSpacesContainingContentWithLabel() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[] value = null;
            value = binding.getSpacesContainingContentWithLabel(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test33ConfluenceSoapServiceGetRecentlyUsedLabelsInSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] value = null;
            value = binding.getRecentlyUsedLabelsInSpace(new java.lang.String(), new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test34ConfluenceSoapServiceGetRecentlyUsedLabels() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] value = null;
            value = binding.getRecentlyUsedLabels(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test35ConfluenceSoapServiceGetSpacesWithLabel() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace[] value = null;
            value = binding.getSpacesWithLabel(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test36ConfluenceSoapServiceGetLabelsByDetail() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] value = null;
            value = binding.getLabelsByDetail(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test37ConfluenceSoapServiceGetMostPopularLabels() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] value = null;
            value = binding.getMostPopularLabels(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test38ConfluenceSoapServiceGetMostPopularLabelsInSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] value = null;
            value = binding.getMostPopularLabelsInSpace(new java.lang.String(), new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test39ConfluenceSoapServiceGetAttachment() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteAttachment value = null;
            value = binding.getAttachment(new java.lang.String(), 0, new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test40ConfluenceSoapServiceGetAttachmentData() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            byte[] value = null;
            value = binding.getAttachmentData(new java.lang.String(), 0, new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test41ConfluenceSoapServiceMoveAttachment() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.moveAttachment(new java.lang.String(), 0, new java.lang.String(), 0, new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test42ConfluenceSoapServiceRemoveAllPermissionsForGroup() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeAllPermissionsForGroup(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test43ConfluenceSoapServiceLogin() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String value = null;
            value = binding.login(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.AuthenticationFailedException e2) {
            throw new junit.framework.AssertionFailedError("AuthenticationFailedException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test44ConfluenceSoapServiceLogout() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.logout(new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test45ConfluenceSoapServiceExportSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String value = null;
            value = binding.exportSpace(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test46ConfluenceSoapServiceAddSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace value = null;
            value = binding.addSpace(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSpace());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.AlreadyExistsException e4) {
            throw new junit.framework.AssertionFailedError("AlreadyExistsException Exception caught: " + e4);
        }
            // TBD - validate results
    }

    public void test47ConfluenceSoapServiceGetActiveUsers() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String[] value = null;
            value = binding.getActiveUsers(new java.lang.String(), true);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test48ConfluenceSoapServiceGetPageHistory() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePageHistory[] value = null;
            value = binding.getPageHistory(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test49ConfluenceSoapServiceRemovePage() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.Boolean value = null;
            value = binding.removePage(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test50ConfluenceSoapServiceRenderContent() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String value = null;
            value = binding.renderContent(new java.lang.String(), new java.lang.String(), 0, new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test51ConfluenceSoapServiceRenderContent() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String value = null;
            value = binding.renderContent(new java.lang.String(), new java.lang.String(), 0, new java.lang.String(), new com.atlassian.www._package.java_util.Map());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test52ConfluenceSoapServiceStorePage() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage value = null;
            value = binding.storePage(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePage());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException e4) {
            throw new junit.framework.AssertionFailedError("VersionMismatchException Exception caught: " + e4);
        }
            // TBD - validate results
    }

    public void test53ConfluenceSoapServiceGetSpaceLevelPermissions() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String[] value = null;
            value = binding.getSpaceLevelPermissions(new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test54ConfluenceSoapServiceAddPermissionToSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addPermissionToSpace(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test55ConfluenceSoapServiceAddPermissionsToSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addPermissionsToSpace(new java.lang.String(), new java.lang.String[0], new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test56ConfluenceSoapServiceRemovePermissionFromSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removePermissionFromSpace(new java.lang.String(), new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test57ConfluenceSoapServiceEditUser() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.editUser(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUser());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test58ConfluenceSoapServiceGetUserGroups() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String[] value = null;
            value = binding.getUserGroups(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test59ConfluenceSoapServiceAddUserToGroup() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addUserToGroup(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test60ConfluenceSoapServiceRemoveUserFromGroup() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeUserFromGroup(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test61ConfluenceSoapServiceChangeMyPassword() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.changeMyPassword(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test62ConfluenceSoapServiceChangeUserPassword() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.changeUserPassword(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test63ConfluenceSoapServiceSetUserInformation() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.setUserInformation(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test64ConfluenceSoapServiceGetUserInformation() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteUserInformation value = null;
            value = binding.getUserInformation(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test65ConfluenceSoapServiceHasUser() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.hasUser(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test66ConfluenceSoapServiceHasGroup() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.hasGroup(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test67ConfluenceSoapServiceGetBlogEntryByDayAndTitle() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry value = null;
            value = binding.getBlogEntryByDayAndTitle(new java.lang.String(), new java.lang.String(), 0, new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test68ConfluenceSoapServiceGetBlogEntry() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry value = null;
            value = binding.getBlogEntry(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test69ConfluenceSoapServiceGetBlogEntries() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntrySummary[] value = null;
            value = binding.getBlogEntries(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test70ConfluenceSoapServiceStoreBlogEntry() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry value = null;
            value = binding.storeBlogEntry(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteBlogEntry());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.VersionMismatchException e4) {
            throw new junit.framework.AssertionFailedError("VersionMismatchException Exception caught: " + e4);
        }
            // TBD - validate results
    }

    public void test71ConfluenceSoapServiceExportSite() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String value = null;
            value = binding.exportSite(new java.lang.String(), true);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test72ConfluenceSoapServiceGetLabelsById() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel[] value = null;
            value = binding.getLabelsById(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test73ConfluenceSoapServiceGetLabelContentById() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] value = null;
            value = binding.getLabelContentById(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test74ConfluenceSoapServiceGetLabelContentByName() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] value = null;
            value = binding.getLabelContentByName(new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test75ConfluenceSoapServiceGetLabelContentByObject() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteSearchResult[] value = null;
            value = binding.getLabelContentByObject(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test76ConfluenceSoapServiceAddLabelByName() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addLabelByName(new java.lang.String(), new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test77ConfluenceSoapServiceAddLabelById() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addLabelById(new java.lang.String(), 0, 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test78ConfluenceSoapServiceAddLabelByObject() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addLabelByObject(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test79ConfluenceSoapServiceAddLabelByNameToSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addLabelByNameToSpace(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test80ConfluenceSoapServiceRemoveLabelByName() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeLabelByName(new java.lang.String(), new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test81ConfluenceSoapServiceRemoveLabelById() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeLabelById(new java.lang.String(), 0, 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test82ConfluenceSoapServiceRemoveLabelByObject() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeLabelByObject(new java.lang.String(), new com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemoteLabel(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test83ConfluenceSoapServiceRemoveLabelByNameFromSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeLabelByNameFromSpace(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test84ConfluenceSoapServiceGetPermissionsForUser() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            java.lang.String[] value = null;
            value = binding.getPermissionsForUser(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e2) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e2);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e3) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e3);
        }
            // TBD - validate results
    }

    public void test85ConfluenceSoapServiceAddAnonymousPermissionToSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addAnonymousPermissionToSpace(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test86ConfluenceSoapServiceAddAnonymousPermissionsToSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.addAnonymousPermissionsToSpace(new java.lang.String(), new java.lang.String[0], new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e1) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e1);
        }
            // TBD - validate results
    }

    public void test87ConfluenceSoapServiceRemoveAnonymousPermissionFromSpace() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            boolean value = false;
            value = binding.removeAnonymousPermissionFromSpace(new java.lang.String(), new java.lang.String(), new java.lang.String());
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.NotPermittedException e1) {
            throw new junit.framework.AssertionFailedError("NotPermittedException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

    public void test88ConfluenceSoapServiceGetPagePermissions() throws Exception {
        com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub binding;
        try {
            binding = (com.atlassian.www.software.confluence.$Proxy42.ConfluenceSoapServiceStub)
                          new com.atlassian.www.software.confluence.$Proxy42.ConfluenceServiceLocator().getConfluenceSoapService();
        }
        catch (javax.xml.rpc.ServiceException jre) {
            if(jre.getLinkedCause()!=null)
                jre.getLinkedCause().printStackTrace();
            throw new junit.framework.AssertionFailedError("JAX-RPC ServiceException caught: " + jre);
        }
        assertNotNull("binding is null", binding);

        // Time out after a minute
        binding.setTimeout(60000);

        // Test operation
        try {
            com.atlassian.www._package.com_atlassian_confluence_rpc_soap_beans.RemotePermission[] value = null;
            value = binding.getPagePermissions(new java.lang.String(), 0);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.InvalidSessionException e1) {
            throw new junit.framework.AssertionFailedError("InvalidSessionException Exception caught: " + e1);
        }
        catch (com.atlassian.www._package.com_atlassian_confluence_rpc.RemoteException e2) {
            throw new junit.framework.AssertionFailedError("RemoteException Exception caught: " + e2);
        }
            // TBD - validate results
    }

}
