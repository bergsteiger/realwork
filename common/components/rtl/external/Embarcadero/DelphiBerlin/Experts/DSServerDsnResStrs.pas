{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSServerDsnResStrs;

interface

resourcestring

  // DSServerReg
  rsServerModule = 'Server Module';
  rsServerModuleComment = 'Creates a module which implements DataSnap server methods. Use this module to add custom server methods or use the built in IAppServer support. The IAppServer interface provides a provider/resolver model for passing DataSets between server and clients.';

  // DSWebBrokerReg
  SNewDSWebAppExpertCaption = 'New DataSnap WebBroker Application';
  SNewDSWebAppExpertComment =
    'The DataSnap WebBroker Application Wizard provides an easy way to implement a server application using both the WebBroker and DataSnap technologies.';
  SNewDSWebAppExpertName = 'DataSnap WebBroker Application';

  SNewDSRESTAppExpertCaption = 'New DataSnap REST Application';
  SNewDSRESTAppExpertComment = 'Creates a DataSnap server with support for REST communication and with web pages that invoke server methods using Java Script and JSON.';
  SNewDSRESTAppExpertName = 'DataSnap REST Application';
  sDirectoryContainsAProject = 'Directory (%s) already contains DataSnap REST project files, either remove/delete the files or select a different location';
  sSpecifyDirectory = 'Please enter a project location';

  // DSStandAloneReg
  SNewDSStandAloneAppExpertComment  = 'The DataSnap Server Wizard provides an easy way to implement a server application using the DataSnap technology.';
  SNewDSStandAloneAppExpertName     = 'DataSnap Server';

  // DSStandAloneForm
  sSelectProtocol = 'Select one or more protocols';

  // DSCreators
  rsDataSnapServerPage  = 'DataSnap Server';
  rsDatasnapServer      = 'DataSnap Server';
  rsDataSnapServerMethodsModuleFormName = 'ServerMethods';  // If blank will default to DSDataModule

  // DSServerMrWizard

  sFeaturesPageTitle = 'Server Features';
  sFeaturesPageDescription = 'Check the features to add to the DataSnap server';
  sNoFeatureSelected = 'Select a feature for more information';

  sProtocolFeatureName = 'Protocols';
  sProtocolFeatureDescription = 'Choose the protocols that can be used to connect to the DataSnap server.';

  sTCPProtocolFeatureName = 'TCP/IP';
  sTCPProtocolFeatureDescription = 'Check TCP/IP to add support for TCP/IP connections.  DataSnap DBExpress clients can connect using TCP/IP.';
  sHTTPProtocolFeatureName = 'HTTP';
  sHTTPSProtocolFeatureDescription = 'Check HTTPS to add support for HTTP(Secure) connections. ' +
    'REST clients (including Delphi, C++, JavaScript and PHP) as well as DBExpress clients can connect using HTTPS';
  sHTTPProtocolFeatureDescription = 'Check HTTP to add support for HTTP connections. ' +
    'REST clients (including Delphi, C++, JavaScript and PHP) as well as DBExpress clients can connect using HTTP.';
  sHTTPSProtocolFeatureName = 'HTTPS';
  sAuthenticationFeatureName = 'Authentication';
  sAuthenticationFeatureDescription = 'Authentication controls access to the DataSnap server based on a user name and password provided by the client.';
  sAuthorizationFeatureName = 'Authorization';
  sAuthorizationFeatureDescription = 'Authorization controls access to server methods based on user roles.';

  sServerMethodClassFeatureName = 'Server Methods Class';
  sServerMethodClassFeatureDescription = 'Add a server methods class to the DataSnap server.';
  sSampleMethodsFeatureName = 'Sample Methods';
  sSampleMethodsFeatureDescription = 'Include sample methods EchoString and ReverseString.';
  sSampleWebFilesFeatureName = 'Sample Web Files';
  sSampleWebFilesFeatureDescription = 'Include sample web pages and related files.';

  sWebFilesFeatureName = 'JavaScript Files';
  sWebFilesFeatureDescription = 'Include the JavaScript files for REST client development, along with proxy generator components configured for JavaScript proxy generation.';

  sConnectorsFeatureName = 'Mobile Connectors';
  sConnectorsFeatureDescription = 'Include support for proxy dispatching for mobile connector development.';

  sServerModuleFeatureName = 'Server Module';
  sServerModuleFeatureDescription = 'Create a separate module for DS server components. ';

  sRESTDispatcherFeatureName = 'Simplified Dispatcher';
  sRESTDispatcherFeatureDescription = 'Use TDSRESTWebDispatcher rather than TDSHTTPWebDispatcher.  The REST dispatcher supports REST only.  The HTTP dispatcher also supports DBX/Native HTTP connections.';

  sFiltersFeatureName = 'Filters';
  sFiltersFeatureDescription = 'Encryption and Compression filters for the selected protocol(s). The filters '+
    'will be used with DataSnap SQL connections to the server.';
  sEncryptionFeatureName = 'Encryption';
  sEncryptionFeatureDescription = 'Add a PC1 and RSA filter for the selected protocol(s). The RSA filter requires '+
    'the OpenSSL libraries to be present on the server and any clients.';
  sCompressionFeatureName = 'Compression';
  sCompressionFeatureDescription = 'Add a Zlib compression filter for the selected protocol(s).';

  sHTTPPortLabel = '&HTTP Port:';
  sHTTPSPortLabel = 'HTTP&S Port:';
  sTCPIPPortLabel = '&TCP/IP Port:';

  // DSProjectLocationWizardPage
  sLocationPageInfo = 'This directory is the root location of the web application.  ' +
    'This is the output directory of the project executable and the location of web application files such as .js, .html, and .css files, and other static files.';
  sLocationPageTitle = 'Project location';
  sLocationPageDescription = 'Provide the directory where the project will be created.';

  // DSPortFrame
  rsTestPortOK = 'Test port succeeded';

  // DSStandAlonAppWizardPage
   sConsoleInfo = 'A console application has a text-only interface';
   sServiceInfo = 'A service application is installed as a Windows service';
   sFormsInfo = 'A Forms application displays a form';
   sDSStandAloneApWizardPageTitle = 'Project type';
   sDSStandAloneApWizardPageDescription = 'Specify the type of this application';

   // DSPortsWizardPage
  sPortsPageInfo = 'Click a field for more information';
  sPortsPageTitle = 'Port Numbers';
  sPortsPageDescription = 'Specify the ports that will be used by the DataSnap server to listen for client requests.  ' +
  'Use the "Test" button to make sure the port number is not already in use on this computer.';
  sHTTPPortInfo = 'HTTP port.  Port 80 is the well know HTTP port number used by web servers such as IIS.';
  sHTTPSPortInfo = 'HTTPS port.  Port 443 is the well known HTTPS port number used by web servers such as IIS.';
  sTCPIPPortInfo = 'TCP/IP port.  The default DataSnap TCP/IP port number is 211.';

  // DSServerClassWizardPage
  sComponentInfo = 'The TComponent ancestor type provides a simple code-only implementation.';
  sDataModuleInfo = 'The TDataModule ancestor type provides a design surface for dropping non-visual components';
  sDSServerModuleInfo = 'The TDSServerModule ancestor type provides a design surface and also implements the IAppServer interface.';
  sClassWizardPageTitle = 'Server methods ancestor class';
  sClassWizardPageDescription = 'Select an ancestor type for the server methods class.';

implementation

end.
