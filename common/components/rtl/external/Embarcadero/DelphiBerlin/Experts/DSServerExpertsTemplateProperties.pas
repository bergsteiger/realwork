{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSServerExpertsTemplateProperties;

interface

uses InetExpertsTemplateProperties;
const
  // Template file sections.
  // These are typically set in designer.  View Creator datamodule as text.
  sDataSnapConsoleSource = 'DataSnapConsoleSource';
  sDataSnapServiceSource = 'DataSnapServiceSource';
  sDataSnapVCLSource = 'DataSnapVCLSource';

  sDataSnapModuleSource = 'DataSnapModuleSource';
  sDataSnapModuleIntf = 'DataSnapModuleIntf';
  sDataSnapModuleDFMSource = 'DataSnapModuleDFMSource';

  sDataSnapVCLFormSource = 'DataSnapVCLFormSource';
  sDataSnapVCLFormIntf = 'DataSnapVCLFormIntf';

  sDSServerModuleTemplateIntf = 'DSServerModuleTemplateIntf';
  sDSServerModuleTemplate = 'DSServerModuleTemplate';

  sDataSnapServerMethodsClassTemplateIntf = 'DataSnapServerMethodsClassTemplateIntf';
  sDataSnapServerMethodsClassTemplate = 'DataSnapServerMethodsClassTemplate';

  sDataSnapWebModuleIntf = 'DataSnapWebModuleIntf';
  sDataSnapWebModuleSource = 'DataSnapWebModuleSource';
  sDataSnapWebModuleDFMSource = 'DataSnapWebModuleDFMSource';

  // Template options
  sServerMethodsClass_1 = 'ServerMethodsClass';
  sAuthorization_2 = 'Authorization';
  sAuthentication_3 = 'Authentication';
  sServiceMethods_4 = 'ServiceMethods';
  sRunDSServer_5 = 'RunDSServer';
  sTCPIPProtocol_6 = 'TCPIPProtocol';
  sHTTPProtocol_7 = 'HTTPProtocol';
  sIncludeSampleMethods_8 = 'IncludeSampleMethods';
  sIncludeSampleWebFiles_9 = 'IncludeSampleWebFiles';
  sDataSnapREST_10 = 'DataSnapREST';
  sMethodInfoOn_11 = 'MethodInfoOn';
  sIncludeEncryptionFilters_12 = 'IncludeEncryptionFilters';
  sIncludeFilters_13 = 'IncludeFilters';
  sIncludeCompressionFilter_14 = 'IncludeCompressionFilter';
  sHTTPSProtocol_15 = 'HTTPSProtocol';
  sDataSnapConnectors_16 = 'IncludeDataSnapConnectors';
  sIncludeJavaScriptFiles_17 = 'IncludeJavaScriptFiles';
  sServerModule_18 = 'IncludeServerModule';
  sRESTDispatcher_19 = 'RESTDispatcher';


  // Template properties
  sHTTPPort_1 = 'HTTPPort';
  sTCPIPPort_2 = 'TCPIPPort';
  sServerMethodsUnitName_3 = 'ServerMethodsUnitName';
  sServerMethodsClassName_4 = 'ServerMethodsClassName';
  sKeyFilePassword_5 = InetExpertsTemplateProperties.sKeyFilePassword; // 'KeyFilePassword';
  sRootCertFile_6 = InetExpertsTemplateProperties.sRootCertFile; // 'RootCertFile';
  sCertFile_7 = InetExpertsTemplateProperties.sCertFile; // 'CertFile';
  sKeyFile_8 = InetExpertsTemplateProperties.sKeyFile; // 'KeyFile';
  sHTTPSPort_9 = 'HTTPSPort';
  sServerModuleUnitName_10 = 'ServerModuleUnitName';
  sFrameWorkType = 'FrameWorkType';

  sTrue = 'TRUE';
  sFalse = 'FALSE';

  sDSServerConstUnitName = 'ServerConstUnitName';
  sDSServerConstSource = 'ServerConstSource';

implementation

end.
