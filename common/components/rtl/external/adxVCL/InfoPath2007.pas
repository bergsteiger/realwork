{*********************************************************************}
{                                                                     }
{             Add-In Express Component Library                        }
{                  Add-in Express for VCL                             }
{                                                                     }
{             Copyright (C) Add-in Express Ltd.                       }
{             ALL RIGHTS RESERVED                                     }
{                                                                     }
{    The entire contents of this file is protected by U.S. and        }
{    International Copyright Laws. Unauthorized reproduction,         }
{    reverse-engineering, and distribution of all or any portion of   } 
{    the code contained in this file is strictly prohibited and may   }
{    result in severe civil and criminal penalties and will be        }
{    prosecuted to the maximum extent possible under the law.         }
{                                                                     }
{    RESTRICTIONS                                                     }
{                                                                     }
{    THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES ARE        }
{    CONFIDENTIAL AND PROPRIETARY TRADE SECRETS OF ADD-IN EXPRESS     }
{    LTD.                                                             }
{    THE REGISTERED DEVELOPER IS LICENSED TO DISTRIBUTE THE Add-in    }
{    Express VCL AND ALL ACCOMPANYING VCL COMPONENTS AS PART          }
{    OF AN EXECUTABLE PROGRAM ONLY.                                   }
{                                                                     }
{    THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{    FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{    COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{    AVAILABLE TO OTHER INDIVIDUALS WITHOUT WRITTEN CONSENT           }
{    AND PERMISSION FROM ADD-IN EXPRESS LTD.                          }
{                                                                     }
{    CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{    ADDITIONAL RESTRICTIONS.                                         }
{                                                                     }
{*********************************************************************}

unit InfoPath2007;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 11/13/2006 4:14:57 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\PROGRA~1\MICROS~3\Office12\IPEDITOR.DLL (1)
// LIBID: {FD34A360-115F-43CA-8D6F-BBD45FD6F828}
// LCID: 0
// Helpfile: 
// HelpString: Microsoft Office InfoPath 2.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
//   (2) v5.0 MSXML2, (C:\Program Files\Common Files\Microsoft Shared\OFFICE12\msxml5.dll)
//   (3) v2.5 ADODB, (C:\Program Files\Common Files\System\ado\msado25.tlb)
//   (4) v4.0 MSHTML, (C:\WINDOWS\system32\MSHTML.TLB)
// Errors:
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Member 'To' of 'MailEnvelope' changed to 'To_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Member 'To' of 'EmailAdapter' changed to 'To_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WRITEABLECONST ON}
interface

{$I adxDefs.inc}

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  InfoPathMajorVersion = 2;
  InfoPathMinorVersion = 0;

  LIBID_InfoPath: TGUID = '{FD34A360-115F-43CA-8D6F-BBD45FD6F828}';

  IID__IXDOverride: TGUID = '{096CD5B6-0786-11D1-95FA-0080C78EE3BB}';
  IID_Windows: TGUID = '{096CD58B-0786-11D1-95FA-0080C78EE3BB}';
  IID_Window: TGUID = '{096CD595-0786-11D1-95FA-0080C78EE3BB}';
  IID__XDocument: TGUID = '{096CD5B1-0786-11D1-95FA-0080C78EE3BB}';
  IID_Solution: TGUID = '{096CD557-0786-11D1-95FA-0080C78EE3BB}';
  IID_View: TGUID = '{096CD55D-0786-11D1-95FA-0080C78EE3BB}';
  IID_XMLNodes: TGUID = '{096CD6C1-0786-11D1-95FA-0080C78EE3BB}';
  IID_ViewInfos: TGUID = '{096CD601-0786-11D1-95FA-0080C78EE3BB}';
  IID_ViewInfo: TGUID = '{096CD602-0786-11D1-95FA-0080C78EE3BB}';
  IID_DataObjects: TGUID = '{096CD5A4-0786-11D1-95FA-0080C78EE3BB}';
  IID_DataObject: TGUID = '{096CD5A1-0786-11D1-95FA-0080C78EE3BB}';
  IID_UI: TGUID = '{096CD61F-0786-11D1-95FA-0080C78EE3BB}';
  IID_MailEnvelope: TGUID = '{096CD588-0786-11D1-95FA-0080C78EE3BB}';
  IID_TaskPanes: TGUID = '{096CD58D-0786-11D1-95FA-0080C78EE3BB}';
  IID_TaskPane: TGUID = '{096CD58E-0786-11D1-95FA-0080C78EE3BB}';
  IID_XDocuments: TGUID = '{096CD559-0786-11D1-95FA-0080C78EE3BB}';
  IID_XDocuments2: TGUID = '{096CD647-0786-11D1-95FA-0080C78EE3BB}';
  IID__XDocument2: TGUID = '{096CD6A8-0786-11D1-95FA-0080C78EE3BB}';
  IID_DataAdapters: TGUID = '{096CD692-0786-11D1-95FA-0080C78EE3BB}';
  IID_SignedDataBlocks: TGUID = '{096CD712-0786-11D1-95FA-0080C78EE3BB}';
  IID_SignedDataBlock: TGUID = '{096CD714-0786-11D1-95FA-0080C78EE3BB}';
  IID_Signatures: TGUID = '{096CD716-0786-11D1-95FA-0080C78EE3BB}';
  IID_Signature: TGUID = '{096CD718-0786-11D1-95FA-0080C78EE3BB}';
  IID_Certificate: TGUID = '{096CD71A-0786-11D1-95FA-0080C78EE3BB}';
  IID_Util: TGUID = '{096CD6BE-0786-11D1-95FA-0080C78EE3BB}';
  IID_IPMath: TGUID = '{096CD6A0-0786-11D1-95FA-0080C78EE3BB}';
  IID__XDocument3: TGUID = '{096CD6B6-0786-11D1-95FA-0080C78EE3BB}';
  IID_Permission: TGUID = '{096CD6CC-0786-11D1-95FA-0080C78EE3BB}';
  IID_UserPermission: TGUID = '{096CD6CB-0786-11D1-95FA-0080C78EE3BB}';
  IID_InputParameters: TGUID = '{096CD694-0786-11D1-95FA-0080C78EE3BB}';
  IID_InputParameter: TGUID = '{096CD5B5-0786-11D1-95FA-0080C78EE3BB}';
  IID_DocEvent: TGUID = '{096CD613-0786-11D1-95FA-0080C78EE3BB}';
  IID_DocReturnEvent: TGUID = '{096CD676-0786-11D1-95FA-0080C78EE3BB}';
  IID_MergeEvent: TGUID = '{096CD67B-0786-11D1-95FA-0080C78EE3BB}';
  IID_Errors: TGUID = '{096CD578-0786-11D1-95FA-0080C78EE3BB}';
  IID_Error: TGUID = '{096CD577-0786-11D1-95FA-0080C78EE3BB}';
  IID_ViewInfo2: TGUID = '{096CD5FB-0786-11D1-95FA-0080C78EE3BB}';
  IID_View2: TGUID = '{096CD70C-0786-11D1-95FA-0080C78EE3BB}';
  IID_MailEnvelope2: TGUID = '{096CD6FC-0786-11D1-95FA-0080C78EE3BB}';
  IID_DocActionEvent: TGUID = '{096CD63A-0786-11D1-95FA-0080C78EE3BB}';
  IID_DataDOMEvent: TGUID = '{096CD5E5-0786-11D1-95FA-0080C78EE3BB}';
  IID_Solution2: TGUID = '{096CD76D-0786-11D1-95FA-0080C78EE3BB}';
  IID_Window2: TGUID = '{096CD5F7-0786-11D1-95FA-0080C78EE3BB}';
  IID_HTMLTaskPane: TGUID = '{096CD548-0786-11D1-95FA-0080C78EE3BB}';
  IID_VersionUpgradeEvent: TGUID = '{096CD614-0786-11D1-95FA-0080C78EE3BB}';
  IID_SaveEvent: TGUID = '{096CD5F5-0786-11D1-95FA-0080C78EE3BB}';
  IID_SignEvent: TGUID = '{096CD71D-0786-11D1-95FA-0080C78EE3BB}';
  IID_DocContextChangeEvent: TGUID = '{096CD6D2-0786-11D1-95FA-0080C78EE3BB}';
  IID_UI2: TGUID = '{096CD549-0786-11D1-95FA-0080C78EE3BB}';
  IID__ExternalApplication: TGUID = '{096CD69F-0786-11D1-95FA-0080C78EE3BB}';
  IID_User: TGUID = '{096CD6BC-0786-11D1-95FA-0080C78EE3BB}';
  IID_User2: TGUID = '{096CD736-0786-11D1-95FA-0080C78EE3BB}';
  IID_Date: TGUID = '{096CD6A3-0786-11D1-95FA-0080C78EE3BB}';
  IID_InfoPathControl: TGUID = '{096CD68E-0786-11D1-95FA-0080C78EE3BB}';
  IID_InfoPathControlSite: TGUID = '{096CD68F-0786-11D1-95FA-0080C78EE3BB}';
  IID__Application: TGUID = '{096CD58A-0786-11D1-95FA-0080C78EE3BB}';
  IID__Application2: TGUID = '{096CD6BB-0786-11D1-95FA-0080C78EE3BB}';
  IID__XDocumentEventSink: TGUID = '{096CD551-0786-11D1-95FA-0080C78EE3BB}';
  IID__XDocumentEventSink2: TGUID = '{096CD563-0786-11D1-95FA-0080C78EE3BB}';
  IID__DataDOMEventSink: TGUID = '{096CD567-0786-11D1-95FA-0080C78EE3BB}';
  IID_ADOAdapter: TGUID = '{096CD653-0786-11D1-95FA-0080C78EE3BB}';
  IID_ADOAdapter2: TGUID = '{096CD5D3-0786-11D1-95FA-0080C78EE3BB}';
  IID_WebServiceAdapter: TGUID = '{096CD654-0786-11D1-95FA-0080C78EE3BB}';
  IID_WebServiceAdapter2: TGUID = '{096CD5D4-0786-11D1-95FA-0080C78EE3BB}';
  IID_XMLFileAdapter: TGUID = '{096CD655-0786-11D1-95FA-0080C78EE3BB}';
  IID_XMLFileAdapter2: TGUID = '{096CD5D5-0786-11D1-95FA-0080C78EE3BB}';
  IID_IDataAdapterMOM: TGUID = '{096CD734-0786-11D1-95FA-0080C78EE3BB}';
  IID_SharepointListAdapter: TGUID = '{096CD69A-0786-11D1-95FA-0080C78EE3BB}';
  IID_SharepointListAdapter2: TGUID = '{096CD740-0786-11D1-95FA-0080C78EE3BB}';
  IID_DAVAdapter: TGUID = '{096CD5D6-0786-11D1-95FA-0080C78EE3BB}';
  IID_EmailAdapter: TGUID = '{096CD5D7-0786-11D1-95FA-0080C78EE3BB}';
  IID_HWSAdapter: TGUID = '{096CD6BF-0786-11D1-95FA-0080C78EE3BB}';
  IID_SubmitToHostAdapter: TGUID = '{096CD739-0786-11D1-95FA-0080C78EE3BB}';
  IID_HTMLTaskPaneExternal: TGUID = '{096CD5F4-0786-11D1-95FA-0080C78EE3BB}';
  IID_ICLRExtensions: TGUID = '{096CD6A9-0786-11D1-95FA-0080C78EE3BB}';
  IID__ButtonEventSink: TGUID = '{096CD6AB-0786-11D1-95FA-0080C78EE3BB}';
  IID_ISubmitToHostEventHandler: TGUID = '{096CD738-0786-11D1-95FA-0080C78EE3BB}';
  IID_INotifyHostEventHandler: TGUID = '{096CD764-0786-11D1-95FA-0080C78EE3BB}';
  IID_IInitEventHandler: TGUID = '{096CD73A-0786-11D1-95FA-0080C78EE3BB}';
  IID_InfoPathEditor: TGUID = '{096CD706-0786-11D1-95FA-0080C78EE3BB}';
  IID__Application3: TGUID = '{096CD72E-0786-11D1-95FA-0080C78EE3BB}';
  DIID__ApplicationEvents: TGUID = '{096CD72D-0786-11D1-95FA-0080C78EE3BB}';
  IID_IInfoPathDataImporterFields: TGUID = '{096CD76C-0786-11D1-95FA-0080C78EE3BB}';
  IID_IInfoPathDataImporter: TGUID = '{096CD6D9-0786-11D1-95FA-0080C78EE3BB}';
  IID_IPropertyBag: TGUID = '{55272A00-42CB-11CE-8135-00AA004BB851}';
  IID_IErrorLog: TGUID = '{3127CA40-446E-11CE-8135-00AA004BB851}';
  IID_IInfoPathViewControl: TGUID = '{096CD6DA-0786-11D1-95FA-0080C78EE3BB}';
  IID_IEnumString: TGUID = '{00000101-0000-0000-C000-000000000046}';
  CLASS_Application: TGUID = '{8075635F-5146-11D5-A672-00B0D022E945}';
  CLASS_ApplicationEvents: TGUID = '{80756412-5146-11D5-A672-00B0D022E945}';
  CLASS_ExternalApplication: TGUID = '{80756358-5146-11D5-A672-00B0D022E945}';
  CLASS_XDocument: TGUID = '{807563C8-5146-11D5-A672-00B0D022E945}';
  CLASS_DataDOM: TGUID = '{807563C2-5146-11D5-A672-00B0D022E945}';
  CLASS_Button: TGUID = '{807563EA-5146-11D5-A672-00B0D022E945}';
  CLASS_UIObject: TGUID = '{80756363-5146-11D5-A672-00B0D022E945}';
  CLASS_DataAdaptersCollection: TGUID = '{807563E1-5146-11D5-A672-00B0D022E945}';
  CLASS_EmailAdapterObject: TGUID = '{807563E2-5146-11D5-A672-00B0D022E945}';
  CLASS_DAVAdapterObject: TGUID = '{807563E3-5146-11D5-A672-00B0D022E945}';
  CLASS_HWSAdapterObject: TGUID = '{807563E4-5146-11D5-A672-00B0D022E945}';
  CLASS_SubmitToHostAdapterObject: TGUID = '{807563F0-5146-11D5-A672-00B0D022E945}';
  CLASS_SharepointListAdapterObject: TGUID = '{8075638E-5146-11D5-A672-00B0D022E945}';
  CLASS_XMLFileAdapterObject: TGUID = '{8075638C-5146-11D5-A672-00B0D022E945}';
  CLASS_WebServiceAdapterObject: TGUID = '{8075638B-5146-11D5-A672-00B0D022E945}';
  CLASS_ADOAdapterObject: TGUID = '{8075638A-5146-11D5-A672-00B0D022E945}';
  CLASS_DocEventObject: TGUID = '{8075631B-5146-11D5-A672-00B0D022E945}';
  CLASS_DocReturnEventObject: TGUID = '{8075631D-5146-11D5-A672-00B0D022E945}';
  CLASS_DocActionEventObject: TGUID = '{8075631F-5146-11D5-A672-00B0D022E945}';
  CLASS_VersionUpgradeEventObject: TGUID = '{80756320-5146-11D5-A672-00B0D022E945}';
  CLASS_DataDOMEventObject: TGUID = '{80756322-5146-11D5-A672-00B0D022E945}';
  CLASS_SolutionObject: TGUID = '{807563CE-5146-11D5-A672-00B0D022E945}';
  CLASS_WindowObject: TGUID = '{8075635A-5146-11D5-A672-00B0D022E945}';
  CLASS_WindowsCollection: TGUID = '{80756359-5146-11D5-A672-00B0D022E945}';
  CLASS_TaskPanesCollection: TGUID = '{8075630E-5146-11D5-A672-00B0D022E945}';
  CLASS_TaskPaneObject: TGUID = '{80756301-5146-11D5-A672-00B0D022E945}';
  CLASS_HTMLTaskPaneObject: TGUID = '{80756302-5146-11D5-A672-00B0D022E945}';
  CLASS_ViewObject: TGUID = '{80756392-5146-11D5-A672-00B0D022E945}';
  CLASS_MailEnvelopeObject: TGUID = '{807563C1-5146-11D5-A672-00B0D022E945}';
  CLASS_XDocumentsCollection: TGUID = '{80756336-5146-11D5-A672-00B0D022E945}';
  CLASS_ViewInfoObject: TGUID = '{80756337-5146-11D5-A672-00B0D022E945}';
  CLASS_ViewInfosCollection: TGUID = '{80756338-5146-11D5-A672-00B0D022E945}';
  CLASS_ErrorObject: TGUID = '{8075633A-5146-11D5-A672-00B0D022E945}';
  CLASS_ErrorsCollection: TGUID = '{8075633B-5146-11D5-A672-00B0D022E945}';
  CLASS_UtilObject: TGUID = '{80756306-5146-11D5-A672-00B0D022E945}';
  CLASS_MathObject: TGUID = '{80756308-5146-11D5-A672-00B0D022E945}';
  CLASS_DateObject: TGUID = '{80756309-5146-11D5-A672-00B0D022E945}';
  CLASS_SignedDataBlocksCollection: TGUID = '{8075637B-5146-11D5-A672-00B0D022E945}';
  CLASS_SignedDataBlockObject: TGUID = '{8075637C-5146-11D5-A672-00B0D022E945}';
  CLASS_SignaturesCollection: TGUID = '{8075637D-5146-11D5-A672-00B0D022E945}';
  CLASS_SignatureObject: TGUID = '{8075637E-5146-11D5-A672-00B0D022E945}';
  CLASS_CertificateObject: TGUID = '{8075637F-5146-11D5-A672-00B0D022E945}';
  CLASS_MergeEventObject: TGUID = '{8075633C-5146-11D5-A672-00B0D022E945}';
  CLASS_SaveEventObject: TGUID = '{8075633D-5146-11D5-A672-00B0D022E945}';
  CLASS_SignEventObject: TGUID = '{8075633E-5146-11D5-A672-00B0D022E945}';
  CLASS_XMLNodesCollection: TGUID = '{0E221C61-FD53-4BCB-8FA8-C4A341C90863}';
  CLASS_DataSourceObject: TGUID = '{8075630B-5146-11D5-A672-00B0D022E945}';
  CLASS_DataObjectsCollection: TGUID = '{807563B0-5146-11D5-A672-00B0D022E945}';
  CLASS_DocContextChangeEventObject: TGUID = '{8075630C-5146-11D5-A672-00B0D022E945}';
  CLASS_UserObject: TGUID = '{8075630D-5146-11D5-A672-00B0D022E945}';
  CLASS_UserPermissionObject: TGUID = '{80756314-5146-11D5-A672-00B0D022E945}';
  CLASS_PermissionObject: TGUID = '{80756315-5146-11D5-A672-00B0D022E945}';
  CLASS_InfoPathEditorObject: TGUID = '{80756399-5146-11D5-A672-00B0D022E945}';
  CLASS_InputParameterObject: TGUID = '{80756316-5146-11D5-A672-00B0D022E945}';
  CLASS_InputParameterCollection: TGUID = '{8075632E-5146-11D5-A672-00B0D022E945}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum XdWindowType
type
  XdWindowType = TOleEnum;
const
  xdEditorWindow = $00000000;
  xdDesignerWindow = $00000001;

// Constants for enum XdTaskPaneType
type
  XdTaskPaneType = TOleEnum;
const
  xdTaskPaneHTML = $00000000;
  xdTaskPaneFillOutAForm = $00000001;
  xdTaskPaneDesignerNew = $00000002;
  xdTaskPaneSearchResults = $00000003;
  xdTaskPaneHelp = $00000004;
  xdTaskPaneClipArt = $00000005;
  xdTaskPaneFind = $00000006;
  xdTaskPaneReplace = $00000007;
  xdTaskPaneFormatting = $00000008;
  xdTaskPaneBulletsNumbering = $00000009;
  xdTaskPaneSpelling = $0000000A;
  xdTaskPaneParaFormatting = $0000000B;
  xdTaskPaneHWSWorkflow = $0000000C;

// Constants for enum XdSignatureRelation
type
  XdSignatureRelation = TOleEnum;
const
  xdSignatureRelationSingle = $00000001;
  xdSignatureRelationCoSign = $00000002;
  xdSignatureRelationCounterSign = $00000003;

// Constants for enum XdCertificateStatus
type
  XdCertificateStatus = TOleEnum;
const
  xdCertificateStatusError = $00000000;
  xdCertificateStatusValid = $00000001;
  xdCertificateStatusExpired = $00000002;
  xdCertificateStatusNotTrusted = $00000003;
  xdCertificateStatusRevoked = $00000004;

// Constants for enum XdSignatureStatus
type
  XdSignatureStatus = TOleEnum;
const
  xdSignatureStatusError = $00000000;
  xdSignatureStatusValid = $00000001;
  xdSignatureStatusInvalid = $00000002;
  xdSignatureStatusUnsupported = $00000003;

// Constants for enum XdAttachmentType
type
  XdAttachmentType = TOleEnum;
const
  xdXml = $00000000;
  xdXmlXsn = $00000001;
  xdNone = $00000002;

// Constants for enum XdWindowState
type
  XdWindowState = TOleEnum;
const
  xdWindowStateMaximize = $00000001;
  xdWindowStateNormal = $00000002;
  xdWindowStateMinimize = $00000003;

// Constants for enum XdConfirmButtons
type
  XdConfirmButtons = TOleEnum;
const
  xdOKCancel = $00000001;
  xdYesNoCancel = $00000003;
  xdYesNo = $00000004;

// Constants for enum XdConfirmChoice
type
  XdConfirmChoice = TOleEnum;
const
  xdOK = $00000001;
  xdCancel = $00000002;
  xdYes = $00000006;
  xdNo = $00000007;

// Constants for enum XdDocumentVersionMode
type
  XdDocumentVersionMode = TOleEnum;
const
  xdFailOnVersionMismatch = $00000000;
  xdFailOnVersionOlder = $00000001;
  xdUseExistingVersion = $00000002;
  xdCanOpenInReadOnlyMode = $00000008;
  xdCanTransformSigned = $00000010;
  xdPromptTransformSigned = $00000020;
  xdIgnoreDataAdaptersQueryFailure = $00000040;
  xdDoNotInstallActiveXCabs = $00000080;

// Constants for enum XdMachineOnlineState
type
  XdMachineOnlineState = TOleEnum;
const
  xdOffline = $00000000;
  xdOnline = $00000001;
  xdIEIsInOfflineMode = $00000002;

// Constants for enum XdReadOnlyViewMode
type
  XdReadOnlyViewMode = TOleEnum;
const
  xdDefault = $00000000;
  xdNonEditable = $00000001;
  xdFrozen = $00000002;

// Constants for enum CommandIds
type
  CommandIds = TOleEnum;
const
  ShowMergeFormDialog = $00000000;
  ShowImportFormDataDialog = $00000001;
  ShowExportToWebDialog = $00000002;
  WorkOffline = $00000003;
  Close = $00000004;
  Save = $00000005;
  SaveAs = $00000006;
  ShowExportToExcelDialog = $00000007;
  Submit = $00000008;
  GetSubmitButtonCaption = $00000009;
  GotoNextErrorOnView = $0000000A;
  ShowCurrentErrorMessage = $0000000B;
  ShowSetLanguageDialog = $0000000C;
  InsertPictureFromFile = $0000000D;
  ShowInsertTableDialog = $0000000E;
  ShowSplitCellsDialog = $0000000F;
  ShowTablePropertiesDialog = $00000010;
  ShowFormatPictureDialog = $00000011;
  ShowBordersShadingDialog = $00000012;
  ShowInsertHyperlinkDialog = $00000013;
  ShowEditHyperlinkDialog = $00000014;
  InsertNumberedList = $00000015;
  InsertBulletedList = $00000016;
  FormatPainterApplyFormatting = $00000017;
  FormatPainterCopyFormatting = $00000018;
  FormatPainterApplyFormattingPersistent = $00000019;
  SetFontFormattingBold = $0000001A;
  SetFontFormattingItalic = $0000001B;
  SetFontFormattingUnderline = $0000001C;
  SetFontFormattingSuperscript = $0000001D;
  SetFontFormattingSubscript = $0000001E;
  SetFontFormattingStrikethrough = $0000001F;
  AlignTextLeft = $00000020;
  AlignTextCenter = $00000021;
  AlignTextRight = $00000022;
  AlignTextJustify = $00000023;
  SetTextDirectionDefault = $00000024;
  SetTextDirectionLeftToRight = $00000025;
  SetTextDirectionRightToLeft = $00000026;
  SetSingleLineSpacing = $00000027;
  Set15LineSpacing = $00000028;
  SetDoubleLineSpacing = $00000029;
  InsertNumberedListDecimal = $0000002A;
  InsertNumberedListAlphaLowercase = $0000002B;
  InsertNumberedListAlphaUppercase = $0000002C;
  InsertNumberedListRomanLowercase = $0000002D;
  InsertNumberedListRomanUppercase = $0000002E;
  InsertBulletedListSolidCircle = $0000002F;
  InsertBulletedListEmptyCircle = $00000030;
  InsertBulletedListSolidSquare = $00000031;
  DrawTable = $00000032;
  EraseTable = $00000033;
  Cut = $00000034;
  Copy = $00000035;
  Paste = $00000036;
  SelectAll = $00000037;
  Undo = $00000038;
  Redo = $00000039;
  ClearNumberedList = $0000003A;
  ClearBulletedList = $0000003B;
  DecreaseIndent = $0000003C;
  IncreaseIndent = $0000003D;
  InsertRowAbove = $0000003E;
  InsertRowBelow = $0000003F;
  InsertColumnLeft = $00000040;
  InsertColumnRight = $00000041;
  DeleteSelectedTable = $00000042;
  DeleteSelectedRows = $00000043;
  DeleteSelectedColumns = $00000044;
  SelectTable = $00000045;
  SelectRows = $00000046;
  SelectColumns = $00000047;
  SelectCell = $00000048;
  MergeCells = $00000049;
  SetTableHorizontalAlignment = $0000004A;
  GetTableHorizontalAlignment = $0000004B;
  SetTableDirection = $0000004C;
  GetTableDirection = $0000004D;
  InsertHorizontalLine = $0000004E;
  ShowInsertSymbolDialog = $0000004F;
  InsertImage = $00000050;
  InsertHyperlink = $00000051;
  SelectHyperlink = $00000052;
  SetAutoSpaceBetweenAsianAndLatinText = $00000053;
  SetAutoSpaceBetweenAsianTextAndNumbers = $00000054;
  ClearAutoSpace = $00000055;
  SetFindString = $00000056;
  GetFindString = $00000057;
  SetReplaceWithString = $00000058;
  GetReplaceWithString = $00000059;
  SetFindReplaceOptionWholeWordOnly = $0000005A;
  SetFindReplaceOptionMatchCase = $0000005B;
  SetFindReplaceOptionUseWildcards = $0000005C;
  SetFindReplaceOptionSearchDirection = $0000005D;
  GetFindReplaceOptionSearchDirection = $0000005E;
  Replace = $0000005F;
  ReplaceAll = $00000060;
  GetDefaultHighlightColor = $00000061;
  GetDefaultFontColor = $00000062;
  ShowSetSelectedTextFontColorDialog = $00000063;
  ShowSetSelectedTextHighlightColorDialog = $00000064;
  GetFontsAvailableCount = $00000065;
  GetFontAvailableByIndex = $00000066;
  GetFontSizesAvailableCount = $00000067;
  GetFontSizeAvailableByIndex = $00000068;
  SetSelectedTextFontSize = $00000069;
  SetSelectedTextFont = $0000006A;
  GotoFirstErrorOnView = $0000006B;
  ShowDigitalSignaturesDialog = $0000006C;
  ClearFontFormatting = $0000006D;
  SetFontFormattingHeading1 = $0000006E;
  SetFontFormattingHeading2 = $0000006F;
  SetFontFormattingHeading3 = $00000070;
  SetFontFormattingHeading4 = $00000071;
  SetFontFormattingHeading5 = $00000072;
  SetFontFormattingHeading6 = $00000073;
  SetFontFormattingNormal = $00000074;
  DecreaseFontSizeBy2 = $00000075;
  IncreaseFontSizeBy2 = $00000076;
  FindReplaceFindNext = $00000077;
  SetSelectedTextHighlightColor = $00000078;
  SetSelectedTextFontColor = $00000079;
  SetSelectedTextBackgroundColor = $0000007A;
  GetSelectedTextFontSize = $0000007B;
  GetSelectedTextFont = $0000007C;
  GetSelectedTextFontColor = $0000007D;
  GetSelectedTextHighlightColor = $0000007E;
  GetSelectedTextBackgroundColor = $0000007F;
  InsertTable = $00000080;
  IgnoreMisspelledWord = $00000081;
  IgnoreAllOfMisspelledWord = $00000082;
  AddWordToDictionary = $00000083;
  FindNextMisspelledWord = $00000084;
  CorrectMisspelledWord = $00000085;
  CorrectAllOfMisspelledWord = $00000086;
  DeleteMisspelledWord = $00000087;
  SetSpellingOptionCheckAsYouType = $00000088;
  GetSpellingSuggestionsCount = $00000089;
  GetSpellingSuggestion = $0000008A;
  GetCurrentMisspelledWord = $0000008B;
  GetSelectedRowHeight = $0000008C;
  SetSelectedRowHeight = $0000008D;
  GetSelectedColumnWidth = $0000008E;
  SetSelectedColumnWidth = $0000008F;
  SelectNextRow = $00000090;
  SelectPreviousRow = $00000091;
  SelectNextColumn = $00000092;
  SelectPreviousColumn = $00000093;
  GetSelectedCellVerticalAlignment = $00000094;
  GetSelectedCellTopPadding = $00000095;
  GetSelectedCellLeftPadding = $00000096;
  GetSelectedCellBottomPadding = $00000097;
  GetSelectedCellRightPadding = $00000098;
  SetSelectedCellPadding = $00000099;
  SetSelectedCellAlignmentMiddle = $0000009A;
  SetSelectedCellAlignmentTop = $0000009B;
  SetSelectedCellAlignmentBottom = $0000009C;
  SplitCells = $0000009D;
  GetHyperlinkDisplayText = $0000009E;
  GetHyperlinkAddress = $0000009F;
  RemoveHyperlink = $000000A0;
  SetPictureInlineWithText = $000000A1;
  SetPictureToLeftOfText = $000000A2;
  SetPictureToRightOfText = $000000A3;
  SetPictureHeight = $000000A4;
  SetPictureWidth = $000000A5;
  SetPictureAlternativeText = $000000A6;
  GetPictureHeight = $000000A7;
  GetPictureWidth = $000000A8;
  GetPictureAlternativeText = $000000A9;
  GetPictureTextWrapping = $000000AA;
  GetFindReplaceState = $000000AB;
  FormatPainterCopyFormattingPersistent = $000000AC;
  ShowExportToPDFXPSDialog = $000000AD;
  IsFormDirectionRightToLeft = $000000AE;
  IsFormDirectionLeftToRight = $000000AF;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _IXDOverride = interface;
  Windows = interface;
  WindowsDisp = dispinterface;
  Window = interface;
  WindowDisp = dispinterface;
  _XDocument = interface;
  _XDocumentDisp = dispinterface;
  Solution = interface;
  SolutionDisp = dispinterface;
  View = interface;
  ViewDisp = dispinterface;
  XMLNodes = interface;
  XMLNodesDisp = dispinterface;
  ViewInfos = interface;
  ViewInfosDisp = dispinterface;
  ViewInfo = interface;
  ViewInfoDisp = dispinterface;
  DataObjects = interface;
  DataObjectsDisp = dispinterface;
  DataObject = interface;
  DataObjectDisp = dispinterface;
  UI = interface;
  UIDisp = dispinterface;
  MailEnvelope = interface;
  MailEnvelopeDisp = dispinterface;
  TaskPanes = interface;
  TaskPanesDisp = dispinterface;
  TaskPane = interface;
  TaskPaneDisp = dispinterface;
  XDocuments = interface;
  XDocumentsDisp = dispinterface;
  XDocuments2 = interface;
  XDocuments2Disp = dispinterface;
  _XDocument2 = interface;
  _XDocument2Disp = dispinterface;
  DataAdapters = interface;
  DataAdaptersDisp = dispinterface;
  SignedDataBlocks = interface;
  SignedDataBlocksDisp = dispinterface;
  SignedDataBlock = interface;
  SignedDataBlockDisp = dispinterface;
  Signatures = interface;
  SignaturesDisp = dispinterface;
  Signature = interface;
  SignatureDisp = dispinterface;
  Certificate = interface;
  CertificateDisp = dispinterface;
  Util = interface;
  UtilDisp = dispinterface;
  IPMath = interface;
  IPMathDisp = dispinterface;
  _XDocument3 = interface;
  _XDocument3Disp = dispinterface;
  Permission = interface;
  PermissionDisp = dispinterface;
  UserPermission = interface;
  UserPermissionDisp = dispinterface;
  InputParameters = interface;
  InputParametersDisp = dispinterface;
  InputParameter = interface;
  InputParameterDisp = dispinterface;
  DocEvent = interface;
  DocEventDisp = dispinterface;
  DocReturnEvent = interface;
  DocReturnEventDisp = dispinterface;
  MergeEvent = interface;
  MergeEventDisp = dispinterface;
  Errors = interface;
  ErrorsDisp = dispinterface;
  Error = interface;
  ErrorDisp = dispinterface;
  ViewInfo2 = interface;
  ViewInfo2Disp = dispinterface;
  View2 = interface;
  View2Disp = dispinterface;
  MailEnvelope2 = interface;
  MailEnvelope2Disp = dispinterface;
  DocActionEvent = interface;
  DocActionEventDisp = dispinterface;
  DataDOMEvent = interface;
  DataDOMEventDisp = dispinterface;
  Solution2 = interface;
  Solution2Disp = dispinterface;
  Window2 = interface;
  Window2Disp = dispinterface;
  HTMLTaskPane = interface;
  HTMLTaskPaneDisp = dispinterface;
  VersionUpgradeEvent = interface;
  VersionUpgradeEventDisp = dispinterface;
  SaveEvent = interface;
  SaveEventDisp = dispinterface;
  SignEvent = interface;
  SignEventDisp = dispinterface;
  DocContextChangeEvent = interface;
  DocContextChangeEventDisp = dispinterface;
  UI2 = interface;
  UI2Disp = dispinterface;
  _ExternalApplication = interface;
  _ExternalApplicationDisp = dispinterface;
  User = interface;
  UserDisp = dispinterface;
  User2 = interface;
  User2Disp = dispinterface;
  Date = interface;
  DateDisp = dispinterface;
  InfoPathControl = interface;
  InfoPathControlSite = interface;
  InfoPathControlSiteDisp = dispinterface;
  _Application = interface;
  _ApplicationDisp = dispinterface;
  _Application2 = interface;
  _Application2Disp = dispinterface;
  _XDocumentEventSink = interface;
  _XDocumentEventSinkDisp = dispinterface;
  _XDocumentEventSink2 = interface;
  _XDocumentEventSink2Disp = dispinterface;
  _DataDOMEventSink = interface;
  _DataDOMEventSinkDisp = dispinterface;
  ADOAdapter = interface;
  ADOAdapterDisp = dispinterface;
  ADOAdapter2 = interface;
  ADOAdapter2Disp = dispinterface;
  WebServiceAdapter = interface;
  WebServiceAdapterDisp = dispinterface;
  WebServiceAdapter2 = interface;
  WebServiceAdapter2Disp = dispinterface;
  XMLFileAdapter = interface;
  XMLFileAdapterDisp = dispinterface;
  XMLFileAdapter2 = interface;
  XMLFileAdapter2Disp = dispinterface;
  IDataAdapterMOM = interface;
  SharepointListAdapter = interface;
  SharepointListAdapterDisp = dispinterface;
  SharepointListAdapter2 = interface;
  SharepointListAdapter2Disp = dispinterface;
  DAVAdapter = interface;
  DAVAdapterDisp = dispinterface;
  EmailAdapter = interface;
  EmailAdapterDisp = dispinterface;
  HWSAdapter = interface;
  HWSAdapterDisp = dispinterface;
  SubmitToHostAdapter = interface;
  SubmitToHostAdapterDisp = dispinterface;
  HTMLTaskPaneExternal = interface;
  HTMLTaskPaneExternalDisp = dispinterface;
  ICLRExtensions = interface;
  _ButtonEventSink = interface;
  _ButtonEventSinkDisp = dispinterface;
  ISubmitToHostEventHandler = interface;
  INotifyHostEventHandler = interface;
  IInitEventHandler = interface;
  InfoPathEditor = interface;
  _Application3 = interface;
  _Application3Disp = dispinterface;
  _ApplicationEvents = dispinterface;
  IInfoPathDataImporterFields = interface;
  IInfoPathDataImporter = interface;
  IPropertyBag = interface;
  IErrorLog = interface;
  IInfoPathViewControl = interface;
  IEnumString = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Application = _Application2;
  ExternalApplication = _ExternalApplication;
  XDocument = _XDocument2;
  UIObject = UI2;
  DataAdaptersCollection = DataAdapters;
  EmailAdapterObject = EmailAdapter;
  DAVAdapterObject = DAVAdapter;
  HWSAdapterObject = HWSAdapter;
  SubmitToHostAdapterObject = SubmitToHostAdapter;
  SharepointListAdapterObject = SharepointListAdapter;
  XMLFileAdapterObject = XMLFileAdapter2;
  WebServiceAdapterObject = WebServiceAdapter2;
  ADOAdapterObject = ADOAdapter2;
  DocEventObject = DocEvent;
  DocReturnEventObject = DocReturnEvent;
  DocActionEventObject = DocActionEvent;
  VersionUpgradeEventObject = VersionUpgradeEvent;
  DataDOMEventObject = DataDOMEvent;
  SolutionObject = Solution;
  WindowObject = Window2;
  WindowsCollection = Windows;
  TaskPanesCollection = TaskPanes;
  TaskPaneObject = TaskPane;
  HTMLTaskPaneObject = HTMLTaskPane;
  ViewObject = View;
  MailEnvelopeObject = MailEnvelope;
  XDocumentsCollection = XDocuments2;
  ViewInfoObject = ViewInfo;
  ViewInfosCollection = ViewInfos;
  ErrorObject = Error;
  ErrorsCollection = Errors;
  UtilObject = Util;
  MathObject = IPMath;
  DateObject = Date;
  SignedDataBlocksCollection = SignedDataBlocks;
  SignedDataBlockObject = SignedDataBlock;
  SignaturesCollection = Signatures;
  SignatureObject = Signature;
  CertificateObject = Certificate;
  MergeEventObject = MergeEvent;
  SaveEventObject = SaveEvent;
  SignEventObject = SignEvent;
  XMLNodesCollection = XMLNodes;
  DataSourceObject = DataObject;
  DataObjectsCollection = DataObjects;
  DocContextChangeEventObject = DocContextChangeEvent;
  UserObject = User;
  UserPermissionObject = UserPermission;
  PermissionObject = Permission;
  InfoPathEditorObject = InfoPathEditor;
  InputParameterObject = InputParameter;
  InputParameterCollection = InputParameters;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PTDateTime1 = ^TDateTime; {*}
  POleVariant1 = ^OleVariant; {*}
  PUserType1 = ^EXCEPINFO; {*}
  PSYSINT1 = ^SYSINT; {*}


// *********************************************************************//
// Interface: _IXDOverride
// Flags:     (528) Hidden Restricted
// GUID:      {096CD5B6-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _IXDOverride = interface(IUnknown)
    ['{096CD5B6-0786-11D1-95FA-0080C78EE3BB}']
    function Window: HResult; stdcall;
    function Open: HResult; stdcall;
    function Item: HResult; stdcall;
    function Save: HResult; stdcall;
    function Count: HResult; stdcall;
    function Close: HResult; stdcall;
    function Alert: HResult; stdcall;
    function Refresh: HResult; stdcall;
    function Visible: HResult; stdcall;
    function Navigate: HResult; stdcall;
    function Version: HResult; stdcall;
    function Extension: HResult; stdcall;
    function Source: HResult; stdcall;
    function type_: HResult; stdcall;
    function Node: HResult; stdcall;
    function Execute: HResult; stdcall;
    function URI: HResult; stdcall;
    function Name: HResult; stdcall;
    function Parent: HResult; stdcall;
    function ErrorCode: HResult; stdcall;
    function InsertBefore: HResult; stdcall;
    function Offset: HResult; stdcall;
    function SetAttribute: HResult; stdcall;
    function GetAttribute: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: Windows
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD58B-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Windows = interface(IDispatch)
    ['{096CD58B-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): Window; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: Window read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  WindowsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD58B-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  WindowsDisp = dispinterface
    ['{096CD58B-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: Window readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: Window
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD595-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Window = interface(IDispatch)
    ['{096CD595-0786-11D1-95FA-0080C78EE3BB}']
    function Get_CommandBars: IDispatch; safecall;
    procedure Close(fForce: WordBool); safecall;
    function Get_XDocument: _XDocument; safecall;
    function Get_MailEnvelope: MailEnvelope; safecall;
    function Get_Active: WordBool; safecall;
    procedure Activate; safecall;
    function Get_type_: XdWindowType; safecall;
    function Get_TaskPanes: TaskPanes; safecall;
    property CommandBars: IDispatch read Get_CommandBars;
    property XDocument: _XDocument read Get_XDocument;
    property MailEnvelope: MailEnvelope read Get_MailEnvelope;
    property Active: WordBool read Get_Active;
    property type_: XdWindowType read Get_type_;
    property TaskPanes: TaskPanes read Get_TaskPanes;
  end;

// *********************************************************************//
// DispIntf:  WindowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD595-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  WindowDisp = dispinterface
    ['{096CD595-0786-11D1-95FA-0080C78EE3BB}']
    property CommandBars: IDispatch readonly dispid 1;
    procedure Close(fForce: WordBool); dispid 2;
    property XDocument: _XDocument readonly dispid 3;
    property MailEnvelope: MailEnvelope readonly dispid 4;
    property Active: WordBool readonly dispid 5;
    procedure Activate; dispid 6;
    property type_: XdWindowType readonly dispid 7;
    property TaskPanes: TaskPanes readonly dispid 9;
  end;

// *********************************************************************//
// Interface: _XDocument
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5B1-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocument = interface(IDispatch)
    ['{096CD5B1-0786-11D1-95FA-0080C78EE3BB}']
    procedure Save; safecall;
    procedure SaveAs(const bstrFileUrl: WideString); safecall;
    procedure Submit; safecall;
    function Get_IsDirty: WordBool; safecall;
    function Get_IsReadOnly: WordBool; safecall;
    function Get_IsDOMReadOnly: WordBool; safecall;
    function Get_IsNew: WordBool; safecall;
    function Get_URI: WideString; safecall;
    function Get_DOM: IDispatch; safecall;
    function Get_Solution: Solution; safecall;
    function Get_Errors: Errors; safecall;
    function Get_Extension: IDispatch; safecall;
    function Get_View: View; safecall;
    function Get_ViewInfos: ViewInfos; safecall;
    function Get_DataObjects: DataObjects; safecall;
    function Get_Language: WideString; safecall;
    procedure Set_Language(const pbstrLanguage: WideString); safecall;
    procedure ImportFile(const bstrFileURI: WideString); safecall;
    procedure SetDataVariable(lVariableNumber: Integer; const bstrVariableValue: WideString); safecall;
    function GetDataVariable(lVariableNumber: Integer): WideString; safecall;
    function Get_QueryAdapter: IDispatch; safecall;
    function GetDOM(const bstrName: WideString): IDispatch; safecall;
    procedure Query; safecall;
    function Get_IsSigned: WordBool; safecall;
    procedure PrintOut; safecall;
    function Get_UI: UI; safecall;
    property IsDirty: WordBool read Get_IsDirty;
    property IsReadOnly: WordBool read Get_IsReadOnly;
    property IsDOMReadOnly: WordBool read Get_IsDOMReadOnly;
    property IsNew: WordBool read Get_IsNew;
    property URI: WideString read Get_URI;
    property DOM: IDispatch read Get_DOM;
    property Solution: Solution read Get_Solution;
    property Errors: Errors read Get_Errors;
    property Extension: IDispatch read Get_Extension;
    property View: View read Get_View;
    property ViewInfos: ViewInfos read Get_ViewInfos;
    property DataObjects: DataObjects read Get_DataObjects;
    property Language: WideString read Get_Language write Set_Language;
    property QueryAdapter: IDispatch read Get_QueryAdapter;
    property IsSigned: WordBool read Get_IsSigned;
    property UI: UI read Get_UI;
  end;

// *********************************************************************//
// DispIntf:  _XDocumentDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5B1-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocumentDisp = dispinterface
    ['{096CD5B1-0786-11D1-95FA-0080C78EE3BB}']
    procedure Save; dispid 1;
    procedure SaveAs(const bstrFileUrl: WideString); dispid 2;
    procedure Submit; dispid 3;
    property IsDirty: WordBool readonly dispid 5;
    property IsReadOnly: WordBool readonly dispid 16;
    property IsDOMReadOnly: WordBool readonly dispid 39;
    property IsNew: WordBool readonly dispid 6;
    property URI: WideString readonly dispid 7;
    property DOM: IDispatch readonly dispid 8;
    property Solution: Solution readonly dispid 9;
    property Errors: Errors readonly dispid 10;
    property Extension: IDispatch readonly dispid 11;
    property View: View readonly dispid 12;
    property ViewInfos: ViewInfos readonly dispid 15;
    property DataObjects: DataObjects readonly dispid 18;
    property Language: WideString dispid 19;
    procedure ImportFile(const bstrFileURI: WideString); dispid 20;
    procedure SetDataVariable(lVariableNumber: Integer; const bstrVariableValue: WideString); dispid 21;
    function GetDataVariable(lVariableNumber: Integer): WideString; dispid 22;
    property QueryAdapter: IDispatch readonly dispid 23;
    function GetDOM(const bstrName: WideString): IDispatch; dispid 24;
    procedure Query; dispid 25;
    property IsSigned: WordBool readonly dispid 26;
    procedure PrintOut; dispid 27;
    property UI: UI readonly dispid 28;
  end;

// *********************************************************************//
// Interface: Solution
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD557-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Solution = interface(IDispatch)
    ['{096CD557-0786-11D1-95FA-0080C78EE3BB}']
    function Get_DOM: IDispatch; safecall;
    function Get_PackageURL: WideString; safecall;
    function Get_URI: WideString; safecall;
    function Get_Version: WideString; safecall;
    property DOM: IDispatch read Get_DOM;
    property PackageURL: WideString read Get_PackageURL;
    property URI: WideString read Get_URI;
    property Version: WideString read Get_Version;
  end;

// *********************************************************************//
// DispIntf:  SolutionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD557-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SolutionDisp = dispinterface
    ['{096CD557-0786-11D1-95FA-0080C78EE3BB}']
    property DOM: IDispatch readonly dispid 1;
    property PackageURL: WideString readonly dispid 2;
    property URI: WideString readonly dispid 4;
    property Version: WideString readonly dispid 3;
  end;

// *********************************************************************//
// Interface: View
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD55D-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  View = interface(IDispatch)
    ['{096CD55D-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Name: WideString; safecall;
    procedure SwitchView(const bstrName: WideString); safecall;
    function Get_Window: Window; safecall;
    procedure ForceUpdate; safecall;
    procedure DisableAutoUpdate; safecall;
    procedure EnableAutoUpdate; safecall;
    procedure Export(const bstrURL: WideString; const bstrFormat: WideString); safecall;
    function GetSelectedNodes: XMLNodes; safecall;
    function GetContextNodes(varNode: OleVariant; varViewContext: OleVariant): XMLNodes; safecall;
    procedure SelectNodes(const pxnStartNode: IDispatch; varEndNode: OleVariant;
                          varViewContext: OleVariant); safecall;
    procedure SelectText(const pxnField: IDispatch; varViewContext: OleVariant); safecall;
    procedure ExecuteAction(const bstrAction: WideString; varXmlToEdit: OleVariant); safecall;
    property Name: WideString read Get_Name;
    property Window: Window read Get_Window;
  end;

// *********************************************************************//
// DispIntf:  ViewDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD55D-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ViewDisp = dispinterface
    ['{096CD55D-0786-11D1-95FA-0080C78EE3BB}']
    property Name: WideString readonly dispid 1;
    procedure SwitchView(const bstrName: WideString); dispid 2;
    property Window: Window readonly dispid 4;
    procedure ForceUpdate; dispid 6;
    procedure DisableAutoUpdate; dispid 7;
    procedure EnableAutoUpdate; dispid 8;
    procedure Export(const bstrURL: WideString; const bstrFormat: WideString); dispid 9;
    function GetSelectedNodes: XMLNodes; dispid 10;
    function GetContextNodes(varNode: OleVariant; varViewContext: OleVariant): XMLNodes; dispid 11;
    procedure SelectNodes(const pxnStartNode: IDispatch; varEndNode: OleVariant;
                          varViewContext: OleVariant); dispid 12;
    procedure SelectText(const pxnField: IDispatch; varViewContext: OleVariant); dispid 13;
    procedure ExecuteAction(const bstrAction: WideString; varXmlToEdit: OleVariant); dispid 14;
  end;

// *********************************************************************//
// Interface: XMLNodes
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD6C1-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XMLNodes = interface(IDispatch)
    ['{096CD6C1-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): IDispatch; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: IDispatch read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  XMLNodesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD6C1-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XMLNodesDisp = dispinterface
    ['{096CD6C1-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: IDispatch readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: ViewInfos
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD601-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ViewInfos = interface(IDispatch)
    ['{096CD601-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): ViewInfo; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: ViewInfo read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ViewInfosDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD601-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ViewInfosDisp = dispinterface
    ['{096CD601-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: ViewInfo readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: ViewInfo
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD602-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ViewInfo = interface(IDispatch)
    ['{096CD602-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Name: WideString; safecall;
    function Get_IsDefault: WordBool; safecall;
    procedure Set_IsDefault(pvfValue: WordBool); safecall;
    property Name: WideString read Get_Name;
    property IsDefault: WordBool read Get_IsDefault write Set_IsDefault;
  end;

// *********************************************************************//
// DispIntf:  ViewInfoDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD602-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ViewInfoDisp = dispinterface
    ['{096CD602-0786-11D1-95FA-0080C78EE3BB}']
    property Name: WideString readonly dispid 1;
    property IsDefault: WordBool dispid 2;
  end;

// *********************************************************************//
// Interface: DataObjects
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD5A4-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DataObjects = interface(IDispatch)
    ['{096CD5A4-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): DataObject; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: DataObject read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  DataObjectsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD5A4-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DataObjectsDisp = dispinterface
    ['{096CD5A4-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: DataObject readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: DataObject
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5A1-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DataObject = interface(IDispatch)
    ['{096CD5A1-0786-11D1-95FA-0080C78EE3BB}']
    function Get_DOM: IDispatch; safecall;
    function Get_QueryAdapter: IDispatch; safecall;
    function Get_Name: WideString; safecall;
    procedure Query; safecall;
    property DOM: IDispatch read Get_DOM;
    property QueryAdapter: IDispatch read Get_QueryAdapter;
    property Name: WideString read Get_Name;
  end;

// *********************************************************************//
// DispIntf:  DataObjectDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5A1-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DataObjectDisp = dispinterface
    ['{096CD5A1-0786-11D1-95FA-0080C78EE3BB}']
    property DOM: IDispatch readonly dispid 1;
    property QueryAdapter: IDispatch readonly dispid 2;
    property Name: WideString readonly dispid 3;
    procedure Query; dispid 4;
  end;

// *********************************************************************//
// Interface: UI
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD61F-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  UI = interface(IDispatch)
    ['{096CD61F-0786-11D1-95FA-0080C78EE3BB}']
    procedure Alert(const bstrAlertString: WideString); safecall;
    function ShowModalDialog(const bstrName: WideString; varArguments: OleVariant; 
                             varHeight: OleVariant; varWidth: OleVariant; varTop: OleVariant; 
                             varLeft: OleVariant): OleVariant; safecall;
    procedure ShowSignatureDialog; safecall;
    procedure ShowMailItem(const bstrTo: WideString; const bstrCC: WideString; 
                           const bstrBCC: WideString; const bstrSubject: WideString; 
                           const bstrBody: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  UIDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD61F-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  UIDisp = dispinterface
    ['{096CD61F-0786-11D1-95FA-0080C78EE3BB}']
    procedure Alert(const bstrAlertString: WideString); dispid 1;
    function ShowModalDialog(const bstrName: WideString; varArguments: OleVariant; 
                             varHeight: OleVariant; varWidth: OleVariant; varTop: OleVariant; 
                             varLeft: OleVariant): OleVariant; dispid 2;
    procedure ShowSignatureDialog; dispid 3;
    procedure ShowMailItem(const bstrTo: WideString; const bstrCC: WideString; 
                           const bstrBCC: WideString; const bstrSubject: WideString; 
                           const bstrBody: WideString); dispid 4;
  end;

// *********************************************************************//
// Interface: MailEnvelope
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD588-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  MailEnvelope = interface(IDispatch)
    ['{096CD588-0786-11D1-95FA-0080C78EE3BB}']
    function Get_BCC: WideString; safecall;
    procedure Set_BCC(const pbstrBCC: WideString); safecall;
    function Get_CC: WideString; safecall;
    procedure Set_CC(const pbstrCC: WideString); safecall;
    function Get_Subject: WideString; safecall;
    procedure Set_Subject(const pbstrSubject: WideString); safecall;
    function Get_To_: WideString; safecall;
    procedure Set_To_(const pbstrTo: WideString); safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pvfVisible: WordBool); safecall;
    property BCC: WideString read Get_BCC write Set_BCC;
    property CC: WideString read Get_CC write Set_CC;
    property Subject: WideString read Get_Subject write Set_Subject;
    property To_: WideString read Get_To_ write Set_To_;
    property Visible: WordBool read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  MailEnvelopeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD588-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  MailEnvelopeDisp = dispinterface
    ['{096CD588-0786-11D1-95FA-0080C78EE3BB}']
    property BCC: WideString dispid 1;
    property CC: WideString dispid 2;
    property Subject: WideString dispid 3;
    property To_: WideString dispid 4;
    property Visible: WordBool dispid 5;
  end;

// *********************************************************************//
// Interface: TaskPanes
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD58D-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  TaskPanes = interface(IDispatch)
    ['{096CD58D-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): TaskPane; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: TaskPane read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  TaskPanesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD58D-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  TaskPanesDisp = dispinterface
    ['{096CD58D-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: TaskPane readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: TaskPane
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD58E-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  TaskPane = interface(IDispatch)
    ['{096CD58E-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pfVisible: WordBool); safecall;
    function Get_type_: XdTaskPaneType; safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property type_: XdTaskPaneType read Get_type_;
  end;

// *********************************************************************//
// DispIntf:  TaskPaneDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD58E-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  TaskPaneDisp = dispinterface
    ['{096CD58E-0786-11D1-95FA-0080C78EE3BB}']
    property Visible: WordBool dispid 1;
    property type_: XdTaskPaneType readonly dispid 2;
  end;

// *********************************************************************//
// Interface: XDocuments
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD559-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XDocuments = interface(IDispatch)
    ['{096CD559-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): _XDocument; safecall;
    function Get_Count: Integer; safecall;
    function New(varURI: OleVariant; dwBehavior: Integer): _XDocument; safecall;
    function Open(varURI: OleVariant; dwBehavior: Integer): _XDocument; safecall;
    procedure Close(varIndex: OleVariant); safecall;
    function NewFromSolution(varURI: OleVariant): _XDocument; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: _XDocument read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  XDocumentsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD559-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XDocumentsDisp = dispinterface
    ['{096CD559-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: _XDocument readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    function New(varURI: OleVariant; dwBehavior: Integer): _XDocument; dispid 2;
    function Open(varURI: OleVariant; dwBehavior: Integer): _XDocument; dispid 3;
    procedure Close(varIndex: OleVariant); dispid 4;
    function NewFromSolution(varURI: OleVariant): _XDocument; dispid 5;
  end;

// *********************************************************************//
// Interface: XDocuments2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD647-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XDocuments2 = interface(XDocuments)
    ['{096CD647-0786-11D1-95FA-0080C78EE3BB}']
    function NewFromSolutionWithData(varXMLData: OleVariant; varSolutionURI: OleVariant; 
                                     dwBehavior: Integer): _XDocument2; safecall;
  end;

// *********************************************************************//
// DispIntf:  XDocuments2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD647-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XDocuments2Disp = dispinterface
    ['{096CD647-0786-11D1-95FA-0080C78EE3BB}']
    function NewFromSolutionWithData(varXMLData: OleVariant; varSolutionURI: OleVariant; 
                                     dwBehavior: Integer): _XDocument2; dispid 6;
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: _XDocument readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    function New(varURI: OleVariant; dwBehavior: Integer): _XDocument; dispid 2;
    function Open(varURI: OleVariant; dwBehavior: Integer): _XDocument; dispid 3;
    procedure Close(varIndex: OleVariant); dispid 4;
    function NewFromSolution(varURI: OleVariant): _XDocument; dispid 5;
  end;

// *********************************************************************//
// Interface: _XDocument2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6A8-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocument2 = interface(_XDocument)
    ['{096CD6A8-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Role: WideString; safecall;
    procedure Set_Role(const pbstrRole: WideString); safecall;
    function GetNamedNodeProperty(varMainDOMNode: OleVariant; const bstrPropertyName: WideString; 
                                  const bstrDefaultValue: WideString): WideString; safecall;
    procedure SetNamedNodeProperty(const pxmlMainDOMNode: IDispatch;
                                   const bstrPropertyName: WideString; const bstrValue: WideString); safecall;
    function Get_DataAdapters: DataAdapters; safecall;
    procedure ImportDOM(const pxDoc: IDispatch); safecall;
    function Get_SignedDataBlocks: SignedDataBlocks; safecall;
    function Get_IsRecovered: WordBool; safecall;
    function Get_Util: Util; safecall;
    function CreateDOM: IDispatch; safecall;
    procedure SetDirty(vfIsDirty: WordBool); safecall;
    property Role: WideString read Get_Role write Set_Role;
    property DataAdapters: DataAdapters read Get_DataAdapters;
    property SignedDataBlocks: SignedDataBlocks read Get_SignedDataBlocks;
    property IsRecovered: WordBool read Get_IsRecovered;
    property Util: Util read Get_Util;
  end;

// *********************************************************************//
// DispIntf:  _XDocument2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6A8-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocument2Disp = dispinterface
    ['{096CD6A8-0786-11D1-95FA-0080C78EE3BB}']
    property Role: WideString dispid 41;
    function GetNamedNodeProperty(varMainDOMNode: OleVariant; const bstrPropertyName: WideString; 
                                  const bstrDefaultValue: WideString): WideString; dispid 43;
    procedure SetNamedNodeProperty(const pxmlMainDOMNode: IDispatch;
                                   const bstrPropertyName: WideString; const bstrValue: WideString); dispid 44;
    property DataAdapters: DataAdapters readonly dispid 42;
    procedure ImportDOM(const pxDoc: IDispatch); dispid 45;
    property SignedDataBlocks: SignedDataBlocks readonly dispid 40;
    property IsRecovered: WordBool readonly dispid 46;
    property Util: Util readonly dispid 47;
    function CreateDOM: IDispatch; dispid 48;
    procedure SetDirty(vfIsDirty: WordBool); dispid 49;
    procedure Save; dispid 1;
    procedure SaveAs(const bstrFileUrl: WideString); dispid 2;
    procedure Submit; dispid 3;
    property IsDirty: WordBool readonly dispid 5;
    property IsReadOnly: WordBool readonly dispid 16;
    property IsDOMReadOnly: WordBool readonly dispid 39;
    property IsNew: WordBool readonly dispid 6;
    property URI: WideString readonly dispid 7;
    property DOM: IDispatch readonly dispid 8;
    property Solution: Solution readonly dispid 9;
    property Errors: Errors readonly dispid 10;
    property Extension: IDispatch readonly dispid 11;
    property View: View readonly dispid 12;
    property ViewInfos: ViewInfos readonly dispid 15;
    property DataObjects: DataObjects readonly dispid 18;
    property Language: WideString dispid 19;
    procedure ImportFile(const bstrFileURI: WideString); dispid 20;
    procedure SetDataVariable(lVariableNumber: Integer; const bstrVariableValue: WideString); dispid 21;
    function GetDataVariable(lVariableNumber: Integer): WideString; dispid 22;
    property QueryAdapter: IDispatch readonly dispid 23;
    function GetDOM(const bstrName: WideString): IDispatch; dispid 24;
    procedure Query; dispid 25;
    property IsSigned: WordBool readonly dispid 26;
    procedure PrintOut; dispid 27;
    property UI: UI readonly dispid 28;
  end;

// *********************************************************************//
// Interface: DataAdapters
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD692-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DataAdapters = interface(IDispatch)
    ['{096CD692-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): IDispatch; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: IDispatch read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  DataAdaptersDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD692-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DataAdaptersDisp = dispinterface
    ['{096CD692-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: IDispatch readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: SignedDataBlocks
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD712-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SignedDataBlocks = interface(IDispatch)
    ['{096CD712-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): SignedDataBlock; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: SignedDataBlock read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  SignedDataBlocksDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD712-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SignedDataBlocksDisp = dispinterface
    ['{096CD712-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: SignedDataBlock readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: SignedDataBlock
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD714-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SignedDataBlock = interface(IDispatch)
    ['{096CD714-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Name: WideString; safecall;
    function Get_XPath: WideString; safecall;
    function Get_XPathNamespaceDeclarations: WideString; safecall;
    function Get_Caption: WideString; safecall;
    function Get_SignatureRelation: XdSignatureRelation; safecall;
    function Get_Signatures: Signatures; safecall;
    function Get_SignatureContainer: IDispatch; safecall;
    procedure Sign; safecall;
    property Name: WideString read Get_Name;
    property XPath: WideString read Get_XPath;
    property XPathNamespaceDeclarations: WideString read Get_XPathNamespaceDeclarations;
    property Caption: WideString read Get_Caption;
    property SignatureRelation: XdSignatureRelation read Get_SignatureRelation;
    property Signatures: Signatures read Get_Signatures;
    property SignatureContainer: IDispatch read Get_SignatureContainer;
  end;

// *********************************************************************//
// DispIntf:  SignedDataBlockDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD714-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SignedDataBlockDisp = dispinterface
    ['{096CD714-0786-11D1-95FA-0080C78EE3BB}']
    property Name: WideString readonly dispid 1;
    property XPath: WideString readonly dispid 2;
    property XPathNamespaceDeclarations: WideString readonly dispid 3;
    property Caption: WideString readonly dispid 4;
    property SignatureRelation: XdSignatureRelation readonly dispid 6;
    property Signatures: Signatures readonly dispid 7;
    property SignatureContainer: IDispatch readonly dispid 9;
    procedure Sign; dispid 8;
  end;

// *********************************************************************//
// Interface: Signatures
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD716-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Signatures = interface(IDispatch)
    ['{096CD716-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): Signature; safecall;
    function Get_Count: Integer; safecall;
    function Create: Signature; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: Signature read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  SignaturesDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD716-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SignaturesDisp = dispinterface
    ['{096CD716-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: Signature readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    function Create: Signature; dispid 2;
  end;

// *********************************************************************//
// Interface: Signature
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD718-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Signature = interface(IDispatch)
    ['{096CD718-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Comment: WideString; safecall;
    function Get_Certificate: Certificate; safecall;
    function Get_Status: XdSignatureStatus; safecall;
    function Get_SignatureBlockXmlNode: IDispatch; safecall;
    procedure Sign; safecall;
    property Comment: WideString read Get_Comment;
    property Certificate: Certificate read Get_Certificate;
    property Status: XdSignatureStatus read Get_Status;
    property SignatureBlockXmlNode: IDispatch read Get_SignatureBlockXmlNode;
  end;

// *********************************************************************//
// DispIntf:  SignatureDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD718-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SignatureDisp = dispinterface
    ['{096CD718-0786-11D1-95FA-0080C78EE3BB}']
    property Comment: WideString readonly dispid 1;
    property Certificate: Certificate readonly dispid 2;
    property Status: XdSignatureStatus readonly dispid 3;
    property SignatureBlockXmlNode: IDispatch readonly dispid 4;
    procedure Sign; dispid 5;
  end;

// *********************************************************************//
// Interface: Certificate
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD71A-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Certificate = interface(IDispatch)
    ['{096CD71A-0786-11D1-95FA-0080C78EE3BB}']
    function Get_IssuedTo: WideString; safecall;
    function Get_IssuedBy: WideString; safecall;
    function Get_ExpirationDate: WideString; safecall;
    function Get_Status: XdCertificateStatus; safecall;
    property IssuedTo: WideString read Get_IssuedTo;
    property IssuedBy: WideString read Get_IssuedBy;
    property ExpirationDate: WideString read Get_ExpirationDate;
    property Status: XdCertificateStatus read Get_Status;
  end;

// *********************************************************************//
// DispIntf:  CertificateDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD71A-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  CertificateDisp = dispinterface
    ['{096CD71A-0786-11D1-95FA-0080C78EE3BB}']
    property IssuedTo: WideString readonly dispid 1;
    property IssuedBy: WideString readonly dispid 2;
    property ExpirationDate: WideString readonly dispid 3;
    property Status: XdCertificateStatus readonly dispid 4;
  end;

// *********************************************************************//
// Interface: Util
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6BE-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Util = interface(IDispatch)
    ['{096CD6BE-0786-11D1-95FA-0080C78EE3BB}']
    function Match(const bstrValue: WideString; const bstrPattern: WideString): WordBool; safecall;
    function Get_Math: IPMath; safecall;
    function Get_Date: PTDateTime1; safecall;
    property Math: IPMath read Get_Math;
    property Date: PTDateTime1 read Get_Date;
  end;

// *********************************************************************//
// DispIntf:  UtilDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6BE-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  UtilDisp = dispinterface
    ['{096CD6BE-0786-11D1-95FA-0080C78EE3BB}']
    function Match(const bstrValue: WideString; const bstrPattern: WideString): WordBool; dispid 1;
    property Math: IPMath readonly dispid 2;
    property Date: {??PTDateTime1}OleVariant readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IPMath
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6A0-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  IPMath = interface(IDispatch)
    ['{096CD6A0-0786-11D1-95FA-0080C78EE3BB}']
    function Avg(const pxmllistInput: IDispatch): OleVariant; safecall;
    function Max(const pxmllistInput: IDispatch): OleVariant; safecall;
    function Min(const pxmllistInput: IDispatch): OleVariant; safecall;
    function Nz(const pxmllistInput: IDispatch): OleVariant; safecall;
    function Eval(const pxmllistContext: IDispatch; const bstrExpression: WideString): OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  IPMathDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6A0-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  IPMathDisp = dispinterface
    ['{096CD6A0-0786-11D1-95FA-0080C78EE3BB}']
    function Avg(const pxmllistInput: IDispatch): OleVariant; dispid 1;
    function Max(const pxmllistInput: IDispatch): OleVariant; dispid 2;
    function Min(const pxmllistInput: IDispatch): OleVariant; dispid 3;
    function Nz(const pxmllistInput: IDispatch): OleVariant; dispid 4;
    function Eval(const pxmllistContext: IDispatch; const bstrExpression: WideString): OleVariant; dispid 5;
  end;

// *********************************************************************//
// Interface: _XDocument3
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6B6-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocument3 = interface(_XDocument2)
    ['{096CD6B6-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Permission: Permission; safecall;
    function Get_Host: IDispatch; safecall;
    function GetWorkflowTasks: IDispatch; safecall;
    function GetWorkflowTemplates: IDispatch; safecall;
    function Get_HostName: WideString; safecall;
    function Get_InputParameters: InputParameters; safecall;
    procedure CloseDocument; safecall;
    function Get_IsHosted: WordBool; safecall;
    procedure NotifyHost(const bstrNotification: WideString); safecall;
    property Permission: Permission read Get_Permission;
    property Host: IDispatch read Get_Host;
    property HostName: WideString read Get_HostName;
    property InputParameters: InputParameters read Get_InputParameters;
    property IsHosted: WordBool read Get_IsHosted;
  end;

// *********************************************************************//
// DispIntf:  _XDocument3Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6B6-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocument3Disp = dispinterface
    ['{096CD6B6-0786-11D1-95FA-0080C78EE3BB}']
    property Permission: Permission readonly dispid 50;
    property Host: IDispatch readonly dispid 51;
    function GetWorkflowTasks: IDispatch; dispid 52;
    function GetWorkflowTemplates: IDispatch; dispid 53;
    property HostName: WideString readonly dispid 54;
    property InputParameters: InputParameters readonly dispid 55;
    procedure CloseDocument; dispid 56;
    property IsHosted: WordBool readonly dispid 57;
    procedure NotifyHost(const bstrNotification: WideString); dispid 58;
    property Role: WideString dispid 41;
    function GetNamedNodeProperty(varMainDOMNode: OleVariant; const bstrPropertyName: WideString; 
                                  const bstrDefaultValue: WideString): WideString; dispid 43;
    procedure SetNamedNodeProperty(const pxmlMainDOMNode: IDispatch;
                                   const bstrPropertyName: WideString; const bstrValue: WideString); dispid 44;
    property DataAdapters: DataAdapters readonly dispid 42;
    procedure ImportDOM(const pxDoc: IDispatch); dispid 45;
    property SignedDataBlocks: SignedDataBlocks readonly dispid 40;
    property IsRecovered: WordBool readonly dispid 46;
    property Util: Util readonly dispid 47;
    function CreateDOM: IDispatch; dispid 48;
    procedure SetDirty(vfIsDirty: WordBool); dispid 49;
    procedure Save; dispid 1;
    procedure SaveAs(const bstrFileUrl: WideString); dispid 2;
    procedure Submit; dispid 3;
    property IsDirty: WordBool readonly dispid 5;
    property IsReadOnly: WordBool readonly dispid 16;
    property IsDOMReadOnly: WordBool readonly dispid 39;
    property IsNew: WordBool readonly dispid 6;
    property URI: WideString readonly dispid 7;
    property DOM: IDispatch readonly dispid 8;
    property Solution: Solution readonly dispid 9;
    property Errors: Errors readonly dispid 10;
    property Extension: IDispatch readonly dispid 11;
    property View: View readonly dispid 12;
    property ViewInfos: ViewInfos readonly dispid 15;
    property DataObjects: DataObjects readonly dispid 18;
    property Language: WideString dispid 19;
    procedure ImportFile(const bstrFileURI: WideString); dispid 20;
    procedure SetDataVariable(lVariableNumber: Integer; const bstrVariableValue: WideString); dispid 21;
    function GetDataVariable(lVariableNumber: Integer): WideString; dispid 22;
    property QueryAdapter: IDispatch readonly dispid 23;
    function GetDOM(const bstrName: WideString): IDispatch; dispid 24;
    procedure Query; dispid 25;
    property IsSigned: WordBool readonly dispid 26;
    procedure PrintOut; dispid 27;
    property UI: UI readonly dispid 28;
  end;

// *********************************************************************//
// Interface: Permission
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6CC-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Permission = interface(IDispatch)
    ['{096CD6CC-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Item(varIndex: OleVariant): UserPermission; safecall;
    function Get_Count: Integer; safecall;
    function Add(const bstrUserId: WideString; varPermission: OleVariant; 
                 varExpirationDate: OleVariant): UserPermission; safecall;
    procedure ApplyPolicy(const bstrFileName: WideString); safecall;
    procedure RemoveAll; safecall;
    function Get_Enabled: WordBool; safecall;
    procedure Set_Enabled(pvfEnabled: WordBool); safecall;
    function Get_RequestPermissionURL: WideString; safecall;
    procedure Set_RequestPermissionURL(const pbstrContact: WideString); safecall;
    function Get_PolicyName: WideString; safecall;
    function Get_PolicyDescription: WideString; safecall;
    function Get_StoreLicenses: WordBool; safecall;
    procedure Set_StoreLicenses(pvfEnabled: WordBool); safecall;
    function Get_DocumentAuthor: WideString; safecall;
    procedure Set_DocumentAuthor(const pbstrAuthor: WideString); safecall;
    function Get_PermissionFromPolicy: WordBool; safecall;
    function Get__NewEnum: IUnknown; safecall;
    property Item[varIndex: OleVariant]: UserPermission read Get_Item; default;
    property Count: Integer read Get_Count;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property RequestPermissionURL: WideString read Get_RequestPermissionURL write Set_RequestPermissionURL;
    property PolicyName: WideString read Get_PolicyName;
    property PolicyDescription: WideString read Get_PolicyDescription;
    property StoreLicenses: WordBool read Get_StoreLicenses write Set_StoreLicenses;
    property DocumentAuthor: WideString read Get_DocumentAuthor write Set_DocumentAuthor;
    property PermissionFromPolicy: WordBool read Get_PermissionFromPolicy;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  PermissionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6CC-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  PermissionDisp = dispinterface
    ['{096CD6CC-0786-11D1-95FA-0080C78EE3BB}']
    property Item[varIndex: OleVariant]: UserPermission readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    function Add(const bstrUserId: WideString; varPermission: OleVariant; 
                 varExpirationDate: OleVariant): UserPermission; dispid 2;
    procedure ApplyPolicy(const bstrFileName: WideString); dispid 3;
    procedure RemoveAll; dispid 5;
    property Enabled: WordBool dispid 6;
    property RequestPermissionURL: WideString dispid 7;
    property PolicyName: WideString readonly dispid 8;
    property PolicyDescription: WideString readonly dispid 9;
    property StoreLicenses: WordBool dispid 10;
    property DocumentAuthor: WideString dispid 11;
    property PermissionFromPolicy: WordBool readonly dispid 12;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: UserPermission
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6CB-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  UserPermission = interface(IDispatch)
    ['{096CD6CB-0786-11D1-95FA-0080C78EE3BB}']
    function Get_UserId: WideString; safecall;
    function Get_Permission: Integer; safecall;
    procedure Set_Permission(plPermission: Integer); safecall;
    function Get_ExpirationDate: OleVariant; safecall;
    procedure Set_ExpirationDate(pvarExpirationDate: OleVariant); safecall;
    function Get_Parent: IDispatch; safecall;
    procedure Remove; safecall;
    property UserId: WideString read Get_UserId;
    property Permission: Integer read Get_Permission write Set_Permission;
    property ExpirationDate: OleVariant read Get_ExpirationDate write Set_ExpirationDate;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  UserPermissionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6CB-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  UserPermissionDisp = dispinterface
    ['{096CD6CB-0786-11D1-95FA-0080C78EE3BB}']
    property UserId: WideString readonly dispid 0;
    property Permission: Integer dispid 1;
    property ExpirationDate: OleVariant dispid 2;
    property Parent: IDispatch readonly dispid 3;
    procedure Remove; dispid 4;
  end;

// *********************************************************************//
// Interface: InputParameters
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD694-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  InputParameters = interface(IDispatch)
    ['{096CD694-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(varIndex: OleVariant): InputParameter; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varIndex: OleVariant]: InputParameter read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  InputParametersDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD694-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  InputParametersDisp = dispinterface
    ['{096CD694-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varIndex: OleVariant]: InputParameter readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: InputParameter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5B5-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  InputParameter = interface(IDispatch)
    ['{096CD5B5-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Name: WideString; safecall;
    function Get_Value: WideString; safecall;
    property Name: WideString read Get_Name;
    property Value: WideString read Get_Value;
  end;

// *********************************************************************//
// DispIntf:  InputParameterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5B5-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  InputParameterDisp = dispinterface
    ['{096CD5B5-0786-11D1-95FA-0080C78EE3BB}']
    property Name: WideString readonly dispid 1;
    property Value: WideString readonly dispid 2;
  end;

// *********************************************************************//
// Interface: DocEvent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD613-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DocEvent = interface(IDispatch)
    ['{096CD613-0786-11D1-95FA-0080C78EE3BB}']
    function Get_XDocument: _XDocument; safecall;
    property XDocument: _XDocument read Get_XDocument;
  end;

// *********************************************************************//
// DispIntf:  DocEventDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD613-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DocEventDisp = dispinterface
    ['{096CD613-0786-11D1-95FA-0080C78EE3BB}']
    property XDocument: _XDocument readonly dispid 100;
  end;

// *********************************************************************//
// Interface: DocReturnEvent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD676-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DocReturnEvent = interface(DocEvent)
    ['{096CD676-0786-11D1-95FA-0080C78EE3BB}']
    function Get_ReturnStatus: WordBool; safecall;
    procedure Set_ReturnStatus(pfReturnStatus: WordBool); safecall;
    property ReturnStatus: WordBool read Get_ReturnStatus write Set_ReturnStatus;
  end;

// *********************************************************************//
// DispIntf:  DocReturnEventDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD676-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DocReturnEventDisp = dispinterface
    ['{096CD676-0786-11D1-95FA-0080C78EE3BB}']
    property ReturnStatus: WordBool dispid 101;
    property XDocument: _XDocument readonly dispid 100;
  end;

// *********************************************************************//
// Interface: MergeEvent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD67B-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  MergeEvent = interface(DocReturnEvent)
    ['{096CD67B-0786-11D1-95FA-0080C78EE3BB}']
    function Get_RollBack: WordBool; safecall;
    procedure Set_RollBack(pfRollback: WordBool); safecall;
    function Get_Index: Integer; safecall;
    function Get_Count: Integer; safecall;
    function Get_DOM: IDispatch; safecall;
    property RollBack: WordBool read Get_RollBack write Set_RollBack;
    property Index: Integer read Get_Index;
    property Count: Integer read Get_Count;
    property DOM: IDispatch read Get_DOM;
  end;

// *********************************************************************//
// DispIntf:  MergeEventDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD67B-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  MergeEventDisp = dispinterface
    ['{096CD67B-0786-11D1-95FA-0080C78EE3BB}']
    property RollBack: WordBool dispid 1;
    property Index: Integer readonly dispid 2;
    property Count: Integer readonly dispid 3;
    property DOM: IDispatch readonly dispid 4;
    property ReturnStatus: WordBool dispid 101;
    property XDocument: _XDocument readonly dispid 100;
  end;

// *********************************************************************//
// Interface: Errors
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD578-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Errors = interface(IDispatch)
    ['{096CD578-0786-11D1-95FA-0080C78EE3BB}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(Index: Integer): Error; safecall;
    function Get_Count: Integer; safecall;
    function Add(varNode: OleVariant; const bstrConditionName: WideString; 
                 const bstrShortErrorMessage: WideString; 
                 const bstrDetailedErrorMessage: WideString; lErrorCode: Integer; 
                 const bstrType: WideString): Error; safecall;
    procedure Delete(varNode: OleVariant; const bstrConditionName: WideString); safecall;
    procedure DeleteAll; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[Index: Integer]: Error read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ErrorsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {096CD578-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ErrorsDisp = dispinterface
    ['{096CD578-0786-11D1-95FA-0080C78EE3BB}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[Index: Integer]: Error readonly dispid 0; default;
    property Count: Integer readonly dispid 1;
    function Add(varNode: OleVariant; const bstrConditionName: WideString; 
                 const bstrShortErrorMessage: WideString; 
                 const bstrDetailedErrorMessage: WideString; lErrorCode: Integer; 
                 const bstrType: WideString): Error; dispid 2;
    procedure Delete(varNode: OleVariant; const bstrConditionName: WideString); dispid 3;
    procedure DeleteAll; dispid 4;
  end;

// *********************************************************************//
// Interface: Error
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD577-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Error = interface(IDispatch)
    ['{096CD577-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Node: IDispatch; safecall;
    function Get_ConditionName: OleVariant; safecall;
    function Get_ShortErrorMessage: WideString; safecall;
    procedure Set_ShortErrorMessage(const pbstrData: WideString); safecall;
    function Get_DetailedErrorMessage: WideString; safecall;
    procedure Set_DetailedErrorMessage(const pbstrData: WideString); safecall;
    function Get_ErrorCode: Integer; safecall;
    procedure Set_ErrorCode(pErrorCode: Integer); safecall;
    function Get_type_: WideString; safecall;
    property Node: IDispatch read Get_Node;
    property ConditionName: OleVariant read Get_ConditionName;
    property ShortErrorMessage: WideString read Get_ShortErrorMessage write Set_ShortErrorMessage;
    property DetailedErrorMessage: WideString read Get_DetailedErrorMessage write Set_DetailedErrorMessage;
    property ErrorCode: Integer read Get_ErrorCode write Set_ErrorCode;
    property type_: WideString read Get_type_;
  end;

// *********************************************************************//
// DispIntf:  ErrorDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD577-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ErrorDisp = dispinterface
    ['{096CD577-0786-11D1-95FA-0080C78EE3BB}']
    property Node: IDispatch readonly dispid 1;
    property ConditionName: OleVariant readonly dispid 2;
    property ShortErrorMessage: WideString dispid 3;
    property DetailedErrorMessage: WideString dispid 4;
    property ErrorCode: Integer dispid 5;
    property type_: WideString readonly dispid 6;
  end;

// *********************************************************************//
// Interface: ViewInfo2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5FB-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ViewInfo2 = interface(ViewInfo)
    ['{096CD5FB-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Caption: WideString; safecall;
    function Get_HideName: WordBool; safecall;
    property Caption: WideString read Get_Caption;
    property HideName: WordBool read Get_HideName;
  end;

// *********************************************************************//
// DispIntf:  ViewInfo2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5FB-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ViewInfo2Disp = dispinterface
    ['{096CD5FB-0786-11D1-95FA-0080C78EE3BB}']
    property Caption: WideString readonly dispid 3;
    property HideName: WordBool readonly dispid 4;
    property Name: WideString readonly dispid 1;
    property IsDefault: WordBool dispid 2;
  end;

// *********************************************************************//
// Interface: View2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD70C-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  View2 = interface(View)
    ['{096CD70C-0786-11D1-95FA-0080C78EE3BB}']
    procedure ExportAsFixedFormat(const bstrURL: WideString; const bstrFormat: WideString; 
                                  varExporter: OleVariant); safecall;
  end;

// *********************************************************************//
// DispIntf:  View2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD70C-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  View2Disp = dispinterface
    ['{096CD70C-0786-11D1-95FA-0080C78EE3BB}']
    procedure ExportAsFixedFormat(const bstrURL: WideString; const bstrFormat: WideString; 
                                  varExporter: OleVariant); dispid 15;
    property Name: WideString readonly dispid 1;
    procedure SwitchView(const bstrName: WideString); dispid 2;
    property Window: Window readonly dispid 4;
    procedure ForceUpdate; dispid 6;
    procedure DisableAutoUpdate; dispid 7;
    procedure EnableAutoUpdate; dispid 8;
    procedure Export(const bstrURL: WideString; const bstrFormat: WideString); dispid 9;
    function GetSelectedNodes: XMLNodes; dispid 10;
    function GetContextNodes(varNode: OleVariant; varViewContext: OleVariant): XMLNodes; dispid 11;
    procedure SelectNodes(const pxnStartNode: IDispatch; varEndNode: OleVariant;
                          varViewContext: OleVariant); dispid 12;
    procedure SelectText(const pxnField: IDispatch; varViewContext: OleVariant); dispid 13;
    procedure ExecuteAction(const bstrAction: WideString; varXmlToEdit: OleVariant); dispid 14;
  end;

// *********************************************************************//
// Interface: MailEnvelope2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6FC-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  MailEnvelope2 = interface(MailEnvelope)
    ['{096CD6FC-0786-11D1-95FA-0080C78EE3BB}']
    function Get_AttachmentType: XdAttachmentType; safecall;
    procedure Set_AttachmentType(peAttachmentType: XdAttachmentType); safecall;
    function Get_Intro: WideString; safecall;
    procedure Set_Intro(const pbstrIntro: WideString); safecall;
    function Get_Available: WordBool; safecall;
    property AttachmentType: XdAttachmentType read Get_AttachmentType write Set_AttachmentType;
    property Intro: WideString read Get_Intro write Set_Intro;
    property Available: WordBool read Get_Available;
  end;

// *********************************************************************//
// DispIntf:  MailEnvelope2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6FC-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  MailEnvelope2Disp = dispinterface
    ['{096CD6FC-0786-11D1-95FA-0080C78EE3BB}']
    property AttachmentType: XdAttachmentType dispid 6;
    property Intro: WideString dispid 7;
    property Available: WordBool readonly dispid 8;
    property BCC: WideString dispid 1;
    property CC: WideString dispid 2;
    property Subject: WideString dispid 3;
    property To_: WideString dispid 4;
    property Visible: WordBool dispid 5;
  end;

// *********************************************************************//
// Interface: DocActionEvent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD63A-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DocActionEvent = interface(DocReturnEvent)
    ['{096CD63A-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Source: IDispatch; safecall;
    property Source: IDispatch read Get_Source;
  end;

// *********************************************************************//
// DispIntf:  DocActionEventDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD63A-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DocActionEventDisp = dispinterface
    ['{096CD63A-0786-11D1-95FA-0080C78EE3BB}']
    property Source: IDispatch readonly dispid 200;
    property ReturnStatus: WordBool dispid 101;
    property XDocument: _XDocument readonly dispid 100;
  end;

// *********************************************************************//
// Interface: DataDOMEvent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5E5-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DataDOMEvent = interface(DocActionEvent)
    ['{096CD5E5-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Site: IDispatch; safecall;
    function Get_MatchExpression: WideString; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Operation: WideString; safecall;
    function Get_OldValue: OleVariant; safecall;
    function Get_IsUndoRedo: WordBool; safecall;
    function Get_NewValue: OleVariant; safecall;
    function Get_ReturnMessage: WideString; safecall;
    procedure Set_ReturnMessage(const pbstrErrorMessage: WideString); safecall;
    function ReportError(varNode: OleVariant; const bstrShortErrorMessage: WideString; 
                         fSiteIndependent: WordBool; const bstrDetailedErrorMessage: WideString; 
                         lErrorCode: Integer; const bstrType: WideString): Error; safecall;
    property Site: IDispatch read Get_Site;
    property MatchExpression: WideString read Get_MatchExpression;
    property Parent: IDispatch read Get_Parent;
    property Operation: WideString read Get_Operation;
    property OldValue: OleVariant read Get_OldValue;
    property IsUndoRedo: WordBool read Get_IsUndoRedo;
    property NewValue: OleVariant read Get_NewValue;
    property ReturnMessage: WideString read Get_ReturnMessage write Set_ReturnMessage;
  end;

// *********************************************************************//
// DispIntf:  DataDOMEventDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5E5-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DataDOMEventDisp = dispinterface
    ['{096CD5E5-0786-11D1-95FA-0080C78EE3BB}']
    property Site: IDispatch readonly dispid 1;
    property MatchExpression: WideString readonly dispid 2;
    property Parent: IDispatch readonly dispid 3;
    property Operation: WideString readonly dispid 4;
    property OldValue: OleVariant readonly dispid 6;
    property IsUndoRedo: WordBool readonly dispid 5;
    property NewValue: OleVariant readonly dispid 7;
    property ReturnMessage: WideString dispid 102;
    function ReportError(varNode: OleVariant; const bstrShortErrorMessage: WideString; 
                         fSiteIndependent: WordBool; const bstrDetailedErrorMessage: WideString; 
                         lErrorCode: Integer; const bstrType: WideString): Error; dispid 8;
    property Source: IDispatch readonly dispid 200;
    property ReturnStatus: WordBool dispid 101;
    property XDocument: _XDocument readonly dispid 100;
  end;

// *********************************************************************//
// Interface: Solution2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD76D-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Solution2 = interface(Solution)
    ['{096CD76D-0786-11D1-95FA-0080C78EE3BB}']
    function Get_CacheID: WideString; safecall;
    property CacheID: WideString read Get_CacheID;
  end;

// *********************************************************************//
// DispIntf:  Solution2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD76D-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Solution2Disp = dispinterface
    ['{096CD76D-0786-11D1-95FA-0080C78EE3BB}']
    property CacheID: WideString readonly dispid 5;
    property DOM: IDispatch readonly dispid 1;
    property PackageURL: WideString readonly dispid 2;
    property URI: WideString readonly dispid 4;
    property Version: WideString readonly dispid 3;
  end;

// *********************************************************************//
// Interface: Window2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5F7-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Window2 = interface(Window)
    ['{096CD5F7-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Top: Integer; safecall;
    procedure Set_Top(plTop: Integer); safecall;
    function Get_Left: Integer; safecall;
    procedure Set_Left(plLeft: Integer); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(plWidth: Integer); safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(plHeight: Integer); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const pbstrCaption: WideString); safecall;
    function Get_WindowState: XdWindowState; safecall;
    procedure Set_WindowState(plWindowState: XdWindowState); safecall;
    property Top: Integer read Get_Top write Set_Top;
    property Left: Integer read Get_Left write Set_Left;
    property Width: Integer read Get_Width write Set_Width;
    property Height: Integer read Get_Height write Set_Height;
    property Caption: WideString read Get_Caption write Set_Caption;
    property WindowState: XdWindowState read Get_WindowState write Set_WindowState;
  end;

// *********************************************************************//
// DispIntf:  Window2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5F7-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Window2Disp = dispinterface
    ['{096CD5F7-0786-11D1-95FA-0080C78EE3BB}']
    property Top: Integer dispid 10;
    property Left: Integer dispid 11;
    property Width: Integer dispid 12;
    property Height: Integer dispid 13;
    property Caption: WideString dispid 14;
    property WindowState: XdWindowState dispid 15;
    property CommandBars: IDispatch readonly dispid 1;
    procedure Close(fForce: WordBool); dispid 2;
    property XDocument: _XDocument readonly dispid 3;
    property MailEnvelope: MailEnvelope readonly dispid 4;
    property Active: WordBool readonly dispid 5;
    procedure Activate; dispid 6;
    property type_: XdWindowType readonly dispid 7;
    property TaskPanes: TaskPanes readonly dispid 9;
  end;

// *********************************************************************//
// Interface: HTMLTaskPane
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD548-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  HTMLTaskPane = interface(TaskPane)
    ['{096CD548-0786-11D1-95FA-0080C78EE3BB}']
    procedure Navigate(const bstrURL: WideString); safecall;
    function Get_HTMLDocument: IDispatch; safecall;
    function Get_HTMLWindow: IDispatch; safecall;
    property HTMLDocument: IDispatch read Get_HTMLDocument;
    property HTMLWindow: IDispatch read Get_HTMLWindow;
  end;

// *********************************************************************//
// DispIntf:  HTMLTaskPaneDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD548-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  HTMLTaskPaneDisp = dispinterface
    ['{096CD548-0786-11D1-95FA-0080C78EE3BB}']
    procedure Navigate(const bstrURL: WideString); dispid 3;
    property HTMLDocument: IDispatch readonly dispid 4;
    property HTMLWindow: IDispatch readonly dispid 5;
    property Visible: WordBool dispid 1;
    property type_: XdTaskPaneType readonly dispid 2;
  end;

// *********************************************************************//
// Interface: VersionUpgradeEvent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD614-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  VersionUpgradeEvent = interface(DocReturnEvent)
    ['{096CD614-0786-11D1-95FA-0080C78EE3BB}']
    function Get_DocumentVersion: WideString; safecall;
    function Get_SolutionVersion: WideString; safecall;
    property DocumentVersion: WideString read Get_DocumentVersion;
    property SolutionVersion: WideString read Get_SolutionVersion;
  end;

// *********************************************************************//
// DispIntf:  VersionUpgradeEventDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD614-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  VersionUpgradeEventDisp = dispinterface
    ['{096CD614-0786-11D1-95FA-0080C78EE3BB}']
    property DocumentVersion: WideString readonly dispid 1;
    property SolutionVersion: WideString readonly dispid 2;
    property ReturnStatus: WordBool dispid 101;
    property XDocument: _XDocument readonly dispid 100;
  end;

// *********************************************************************//
// Interface: SaveEvent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5F5-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SaveEvent = interface(DocReturnEvent)
    ['{096CD5F5-0786-11D1-95FA-0080C78EE3BB}']
    function Get_IsSaveAs: WordBool; safecall;
    function Get_IsCancelled: WordBool; safecall;
    procedure Set_IsCancelled(pvfIsCancelled: WordBool); safecall;
    function Get_FileName: WideString; safecall;
    function PerformSaveOperation: WordBool; safecall;
    property IsSaveAs: WordBool read Get_IsSaveAs;
    property IsCancelled: WordBool read Get_IsCancelled write Set_IsCancelled;
    property FileName: WideString read Get_FileName;
  end;

// *********************************************************************//
// DispIntf:  SaveEventDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5F5-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SaveEventDisp = dispinterface
    ['{096CD5F5-0786-11D1-95FA-0080C78EE3BB}']
    property IsSaveAs: WordBool readonly dispid 1;
    property IsCancelled: WordBool dispid 2;
    property FileName: WideString readonly dispid 3;
    function PerformSaveOperation: WordBool; dispid 4;
    property ReturnStatus: WordBool dispid 101;
    property XDocument: _XDocument readonly dispid 100;
  end;

// *********************************************************************//
// Interface: SignEvent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD71D-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SignEvent = interface(DocReturnEvent)
    ['{096CD71D-0786-11D1-95FA-0080C78EE3BB}']
    function Get_SignedDataBlock: SignedDataBlock; safecall;
    property SignedDataBlock: SignedDataBlock read Get_SignedDataBlock;
  end;

// *********************************************************************//
// DispIntf:  SignEventDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD71D-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SignEventDisp = dispinterface
    ['{096CD71D-0786-11D1-95FA-0080C78EE3BB}']
    property SignedDataBlock: SignedDataBlock readonly dispid 1;
    property ReturnStatus: WordBool dispid 101;
    property XDocument: _XDocument readonly dispid 100;
  end;

// *********************************************************************//
// Interface: DocContextChangeEvent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6D2-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DocContextChangeEvent = interface(DocEvent)
    ['{096CD6D2-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Context: IDispatch; safecall;
    function Get_type_: WideString; safecall;
    function Get_IsUndoRedo: WordBool; safecall;
    property Context: IDispatch read Get_Context;
    property type_: WideString read Get_type_;
    property IsUndoRedo: WordBool read Get_IsUndoRedo;
  end;

// *********************************************************************//
// DispIntf:  DocContextChangeEventDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6D2-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DocContextChangeEventDisp = dispinterface
    ['{096CD6D2-0786-11D1-95FA-0080C78EE3BB}']
    property Context: IDispatch readonly dispid 1;
    property type_: WideString readonly dispid 2;
    property IsUndoRedo: WordBool readonly dispid 3;
    property XDocument: _XDocument readonly dispid 100;
  end;

// *********************************************************************//
// Interface: UI2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD549-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  UI2 = interface(UI)
    ['{096CD549-0786-11D1-95FA-0080C78EE3BB}']
    function Confirm(const bstrPrompt: WideString; lButtons: XdConfirmButtons): XdConfirmChoice; safecall;
    procedure SetSaveAsDialogFileName(const bstrFileName: WideString); safecall;
    procedure SetSaveAsDialogLocation(const bstrLocation: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  UI2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD549-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  UI2Disp = dispinterface
    ['{096CD549-0786-11D1-95FA-0080C78EE3BB}']
    function Confirm(const bstrPrompt: WideString; lButtons: XdConfirmButtons): XdConfirmChoice; dispid 7;
    procedure SetSaveAsDialogFileName(const bstrFileName: WideString); dispid 5;
    procedure SetSaveAsDialogLocation(const bstrLocation: WideString); dispid 6;
    procedure Alert(const bstrAlertString: WideString); dispid 1;
    function ShowModalDialog(const bstrName: WideString; varArguments: OleVariant; 
                             varHeight: OleVariant; varWidth: OleVariant; varTop: OleVariant; 
                             varLeft: OleVariant): OleVariant; dispid 2;
    procedure ShowSignatureDialog; dispid 3;
    procedure ShowMailItem(const bstrTo: WideString; const bstrCC: WideString; 
                           const bstrBCC: WideString; const bstrSubject: WideString; 
                           const bstrBody: WideString); dispid 4;
  end;

// *********************************************************************//
// Interface: _ExternalApplication
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD69F-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _ExternalApplication = interface(IDispatch)
    ['{096CD69F-0786-11D1-95FA-0080C78EE3BB}']
    procedure Quit; safecall;
    procedure RegisterSolution(const bstrSolutionURL: WideString; const bstrBehavior: WideString); safecall;
    procedure UnregisterSolution(const bstrSolutionURI: WideString); safecall;
    procedure New(const bstrDocumentURI: WideString; dwBehavior: Integer); safecall;
    procedure Open(const bstrDocumentURI: WideString; dwBehavior: Integer); safecall;
    procedure Close(const bstrDocumentURI: WideString); safecall;
    procedure NewFromSolution(const bstrSolutionURI: WideString); safecall;
    procedure CacheSolution(const bstrSolutionURI: WideString); safecall;
  end;

// *********************************************************************//
// DispIntf:  _ExternalApplicationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD69F-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _ExternalApplicationDisp = dispinterface
    ['{096CD69F-0786-11D1-95FA-0080C78EE3BB}']
    procedure Quit; dispid 1;
    procedure RegisterSolution(const bstrSolutionURL: WideString; const bstrBehavior: WideString); dispid 2;
    procedure UnregisterSolution(const bstrSolutionURI: WideString); dispid 3;
    procedure New(const bstrDocumentURI: WideString; dwBehavior: Integer); dispid 4;
    procedure Open(const bstrDocumentURI: WideString; dwBehavior: Integer); dispid 5;
    procedure Close(const bstrDocumentURI: WideString); dispid 6;
    procedure NewFromSolution(const bstrSolutionURI: WideString); dispid 7;
    procedure CacheSolution(const bstrSolutionURI: WideString); dispid 8;
  end;

// *********************************************************************//
// Interface: User
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6BC-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  User = interface(IDispatch)
    ['{096CD6BC-0786-11D1-95FA-0080C78EE3BB}']
    function IsCurrentUser(const bstrUsername: WideString): WordBool; safecall;
    function IsUserMemberOf(const bstrGroupname: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  UserDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6BC-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  UserDisp = dispinterface
    ['{096CD6BC-0786-11D1-95FA-0080C78EE3BB}']
    function IsCurrentUser(const bstrUsername: WideString): WordBool; dispid 1;
    function IsUserMemberOf(const bstrGroupname: WideString): WordBool; dispid 2;
  end;

// *********************************************************************//
// Interface: User2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD736-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  User2 = interface(User)
    ['{096CD736-0786-11D1-95FA-0080C78EE3BB}']
    function Get_LoginName: WideString; safecall;
    function Get_UserName: WideString; safecall;
    property LoginName: WideString read Get_LoginName;
    property UserName: WideString read Get_UserName;
  end;

// *********************************************************************//
// DispIntf:  User2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD736-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  User2Disp = dispinterface
    ['{096CD736-0786-11D1-95FA-0080C78EE3BB}']
    property LoginName: WideString readonly dispid 3;
    property UserName: WideString readonly dispid 4;
    function IsCurrentUser(const bstrUsername: WideString): WordBool; dispid 1;
    function IsUserMemberOf(const bstrGroupname: WideString): WordBool; dispid 2;
  end;

// *********************************************************************//
// Interface: Date
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6A3-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  Date = interface(IDispatch)
    ['{096CD6A3-0786-11D1-95FA-0080C78EE3BB}']
    function Now: OleVariant; safecall;
    function Today: OleVariant; safecall;
    function AddDays(var pvarDate: OleVariant; var pvarDays: OleVariant): OleVariant; safecall;
    function AddSeconds(var pvarTime: OleVariant; var pvarSeconds: OleVariant): OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  DateDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6A3-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DateDisp = dispinterface
    ['{096CD6A3-0786-11D1-95FA-0080C78EE3BB}']
    function Now: OleVariant; dispid 1;
    function Today: OleVariant; dispid 2;
    function AddDays(var pvarDate: OleVariant; var pvarDays: OleVariant): OleVariant; dispid 3;
    function AddSeconds(var pvarTime: OleVariant; var pvarSeconds: OleVariant): OleVariant; dispid 4;
  end;

// *********************************************************************//
// Interface: InfoPathControl
// Flags:     (0)
// GUID:      {096CD68E-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  InfoPathControl = interface(IUnknown)
    ['{096CD68E-0786-11D1-95FA-0080C78EE3BB}']
    function Init(const pControlSite: InfoPathControlSite): HResult; stdcall;
    function Uninit: HResult; stdcall;
    function SaveState: HResult; stdcall;
    function Enable(vfEnabled: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: InfoPathControlSite
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD68F-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  InfoPathControlSite = interface(IDispatch)
    ['{096CD68F-0786-11D1-95FA-0080C78EE3BB}']
    function Get_XDocument: _XDocument; safecall;
    function Get_Node: IDispatch; safecall;
    property XDocument: _XDocument read Get_XDocument;
    property Node: IDispatch read Get_Node;
  end;

// *********************************************************************//
// DispIntf:  InfoPathControlSiteDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD68F-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  InfoPathControlSiteDisp = dispinterface
    ['{096CD68F-0786-11D1-95FA-0080C78EE3BB}']
    property XDocument: _XDocument readonly dispid 1;
    property Node: IDispatch readonly dispid 2;
  end;

// *********************************************************************//
// Interface: _Application
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD58A-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _Application = interface(IDispatch)
    ['{096CD58A-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Name: WideString; safecall;
    function Get_Windows: Windows; safecall;
    function Get_XDocuments: XDocuments; safecall;
    function Get_ActiveWindow: Window; safecall;
    function Get_Version: WideString; safecall;
    function Get_LanguageSettings: IDispatch; safecall;
    function FormatString(varInput: OleVariant; const bstrCategory: WideString; 
                          const bstrOptions: WideString): WideString; safecall;
    procedure Quit(bForce: WordBool); safecall;
    function NewADODBRecordset: IDispatch; safecall;
    function NewADODBConnection: IDispatch; safecall;
    property Name: WideString read Get_Name;
    property Windows: Windows read Get_Windows;
    property XDocuments: XDocuments read Get_XDocuments;
    property ActiveWindow: Window read Get_ActiveWindow;
    property Version: WideString read Get_Version;
    property LanguageSettings: IDispatch read Get_LanguageSettings;
  end;

// *********************************************************************//
// DispIntf:  _ApplicationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD58A-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _ApplicationDisp = dispinterface
    ['{096CD58A-0786-11D1-95FA-0080C78EE3BB}']
    property Name: WideString readonly dispid 0;
    property Windows: Windows readonly dispid 2;
    property XDocuments: XDocuments readonly dispid 3;
    property ActiveWindow: Window readonly dispid 4;
    property Version: WideString readonly dispid 5;
    property LanguageSettings: IDispatch readonly dispid 6;
    function FormatString(varInput: OleVariant; const bstrCategory: WideString; 
                          const bstrOptions: WideString): WideString; dispid 7;
    procedure Quit(bForce: WordBool); dispid 8;
    function NewADODBRecordset: IDispatch; dispid 9;
    function NewADODBConnection: IDispatch; dispid 10;
  end;

// *********************************************************************//
// Interface: _Application2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6BB-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _Application2 = interface(_Application)
    ['{096CD6BB-0786-11D1-95FA-0080C78EE3BB}']
    function Get_User: User; safecall;
    procedure RegisterSolution(const bstrSolutionURL: WideString; const bstrBehavior: WideString); safecall;
    procedure UnregisterSolution(const bstrSolutionURI: WideString); safecall;
    procedure CacheSolution(const bstrSolutionURI: WideString); safecall;
    function Get_MachineOnlineState: XdMachineOnlineState; safecall;
    function IsDestinationReachable(const bstrDestination: WideString): WordBool; safecall;
    function Get_UsableWidth: Integer; safecall;
    function Get_UsableHeight: Integer; safecall;
    property User: User read Get_User;
    property MachineOnlineState: XdMachineOnlineState read Get_MachineOnlineState;
    property UsableWidth: Integer read Get_UsableWidth;
    property UsableHeight: Integer read Get_UsableHeight;
  end;

// *********************************************************************//
// DispIntf:  _Application2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6BB-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _Application2Disp = dispinterface
    ['{096CD6BB-0786-11D1-95FA-0080C78EE3BB}']
    property User: User readonly dispid 11;
    procedure RegisterSolution(const bstrSolutionURL: WideString; const bstrBehavior: WideString); dispid 12;
    procedure UnregisterSolution(const bstrSolutionURI: WideString); dispid 13;
    procedure CacheSolution(const bstrSolutionURI: WideString); dispid 14;
    property MachineOnlineState: XdMachineOnlineState readonly dispid 15;
    function IsDestinationReachable(const bstrDestination: WideString): WordBool; dispid 16;
    property UsableWidth: Integer readonly dispid 17;
    property UsableHeight: Integer readonly dispid 18;
    property Name: WideString readonly dispid 0;
    property Windows: Windows readonly dispid 2;
    property XDocuments: XDocuments readonly dispid 3;
    property ActiveWindow: Window readonly dispid 4;
    property Version: WideString readonly dispid 5;
    property LanguageSettings: IDispatch readonly dispid 6;
    function FormatString(varInput: OleVariant; const bstrCategory: WideString; 
                          const bstrOptions: WideString): WideString; dispid 7;
    procedure Quit(bForce: WordBool); dispid 8;
    function NewADODBRecordset: IDispatch; dispid 9;
    function NewADODBConnection: IDispatch; dispid 10;
  end;

// *********************************************************************//
// Interface: _XDocumentEventSink
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD551-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocumentEventSink = interface(IDispatch)
    ['{096CD551-0786-11D1-95FA-0080C78EE3BB}']
    procedure OnLoad(const pEvent: DocReturnEvent); safecall;
    procedure OnSwitchView(const pEvent: DocEvent); safecall;
    procedure OnAfterImport(const pEvent: DocEvent); safecall;
    procedure OnVersionUpgrade(const pEvent: VersionUpgradeEvent); safecall;
    procedure OnSubmitRequest(const pEvent: DocReturnEvent); safecall;
  end;

// *********************************************************************//
// DispIntf:  _XDocumentEventSinkDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD551-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocumentEventSinkDisp = dispinterface
    ['{096CD551-0786-11D1-95FA-0080C78EE3BB}']
    procedure OnLoad(const pEvent: DocReturnEvent); dispid 1;
    procedure OnSwitchView(const pEvent: DocEvent); dispid 2;
    procedure OnAfterImport(const pEvent: DocEvent); dispid 3;
    procedure OnVersionUpgrade(const pEvent: VersionUpgradeEvent); dispid 4;
    procedure OnSubmitRequest(const pEvent: DocReturnEvent); dispid 5;
  end;

// *********************************************************************//
// Interface: _XDocumentEventSink2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD563-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocumentEventSink2 = interface(_XDocumentEventSink)
    ['{096CD563-0786-11D1-95FA-0080C78EE3BB}']
    procedure OnMergeRequest(const pEvent: MergeEvent); safecall;
    procedure OnContextChange(const pEvent: DocContextChangeEvent); safecall;
    procedure OnSaveRequest(const pEvent: SaveEvent); safecall;
    procedure OnSign(const pEvent: SignEvent); safecall;
  end;

// *********************************************************************//
// DispIntf:  _XDocumentEventSink2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD563-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _XDocumentEventSink2Disp = dispinterface
    ['{096CD563-0786-11D1-95FA-0080C78EE3BB}']
    procedure OnMergeRequest(const pEvent: MergeEvent); dispid 6;
    procedure OnContextChange(const pEvent: DocContextChangeEvent); dispid 7;
    procedure OnSaveRequest(const pEvent: SaveEvent); dispid 8;
    procedure OnSign(const pEvent: SignEvent); dispid 9;
    procedure OnLoad(const pEvent: DocReturnEvent); dispid 1;
    procedure OnSwitchView(const pEvent: DocEvent); dispid 2;
    procedure OnAfterImport(const pEvent: DocEvent); dispid 3;
    procedure OnVersionUpgrade(const pEvent: VersionUpgradeEvent); dispid 4;
    procedure OnSubmitRequest(const pEvent: DocReturnEvent); dispid 5;
  end;

// *********************************************************************//
// Interface: _DataDOMEventSink
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD567-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _DataDOMEventSink = interface(IDispatch)
    ['{096CD567-0786-11D1-95FA-0080C78EE3BB}']
    procedure OnBeforeChange(const pDataDOMEvent: DataDOMEvent); safecall;
    procedure OnValidate(const pDataDOMEvent: DataDOMEvent); safecall;
    procedure OnAfterChange(const pDataDOMEvent: DataDOMEvent); safecall;
  end;

// *********************************************************************//
// DispIntf:  _DataDOMEventSinkDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD567-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _DataDOMEventSinkDisp = dispinterface
    ['{096CD567-0786-11D1-95FA-0080C78EE3BB}']
    procedure OnBeforeChange(const pDataDOMEvent: DataDOMEvent); dispid 1;
    procedure OnValidate(const pDataDOMEvent: DataDOMEvent); dispid 2;
    procedure OnAfterChange(const pDataDOMEvent: DataDOMEvent); dispid 3;
  end;

// *********************************************************************//
// Interface: ADOAdapter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD653-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ADOAdapter = interface(IDispatch)
    ['{096CD653-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Connection: WideString; safecall;
    procedure Set_Connection(const pbstrConnection: WideString); safecall;
    function Get_Command: WideString; safecall;
    procedure Set_Command(const pbstrCommand: WideString); safecall;
    function Get_Timeout: Integer; safecall;
    procedure Set_Timeout(plTimeout: Integer); safecall;
    function BuildSQLFromXMLNodes(const pXmlNode: IDispatch): WideString; safecall;
    property Connection: WideString read Get_Connection write Set_Connection;
    property Command: WideString read Get_Command write Set_Command;
    property Timeout: Integer read Get_Timeout write Set_Timeout;
  end;

// *********************************************************************//
// DispIntf:  ADOAdapterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD653-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ADOAdapterDisp = dispinterface
    ['{096CD653-0786-11D1-95FA-0080C78EE3BB}']
    property Connection: WideString dispid 5;
    property Command: WideString dispid 6;
    property Timeout: Integer dispid 7;
    function BuildSQLFromXMLNodes(const pXmlNode: IDispatch): WideString; dispid 8;
  end;

// *********************************************************************//
// Interface: ADOAdapter2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D3-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ADOAdapter2 = interface(ADOAdapter)
    ['{096CD5D3-0786-11D1-95FA-0080C78EE3BB}']
    function Get_QueryAllowed: WordBool; safecall;
    function Get_SubmitAllowed: WordBool; safecall;
    function Get_Name: WideString; safecall;
    procedure Query; safecall;
    procedure Submit; safecall;
    property QueryAllowed: WordBool read Get_QueryAllowed;
    property SubmitAllowed: WordBool read Get_SubmitAllowed;
    property Name: WideString read Get_Name;
  end;

// *********************************************************************//
// DispIntf:  ADOAdapter2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D3-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ADOAdapter2Disp = dispinterface
    ['{096CD5D3-0786-11D1-95FA-0080C78EE3BB}']
    property QueryAllowed: WordBool readonly dispid 9;
    property SubmitAllowed: WordBool readonly dispid 10;
    property Name: WideString readonly dispid 11;
    procedure Query; dispid 12;
    procedure Submit; dispid 13;
    property Connection: WideString dispid 5;
    property Command: WideString dispid 6;
    property Timeout: Integer dispid 7;
    function BuildSQLFromXMLNodes(const pXmlNode: IDispatch): WideString; dispid 8;
  end;

// *********************************************************************//
// Interface: WebServiceAdapter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD654-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  WebServiceAdapter = interface(IDispatch)
    ['{096CD654-0786-11D1-95FA-0080C78EE3BB}']
    function Get_WSDLURL: WideString; safecall;
    function Get_Operation: WideString; safecall;
    procedure Set_Operation(const pbstrOperation: WideString); safecall;
    function Get_Input: WideString; safecall;
    procedure Set_Input(const pbstrInput: WideString); safecall;
    property WSDLURL: WideString read Get_WSDLURL;
    property Operation: WideString read Get_Operation write Set_Operation;
    property Input: WideString read Get_Input write Set_Input;
  end;

// *********************************************************************//
// DispIntf:  WebServiceAdapterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD654-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  WebServiceAdapterDisp = dispinterface
    ['{096CD654-0786-11D1-95FA-0080C78EE3BB}']
    property WSDLURL: WideString readonly dispid 5;
    property Operation: WideString dispid 6;
    property Input: WideString dispid 7;
  end;

// *********************************************************************//
// Interface: WebServiceAdapter2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D4-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  WebServiceAdapter2 = interface(WebServiceAdapter)
    ['{096CD5D4-0786-11D1-95FA-0080C78EE3BB}']
    function Get_QueryAllowed: WordBool; safecall;
    function Get_SubmitAllowed: WordBool; safecall;
    function Get_Name: WideString; safecall;
    procedure Query; safecall;
    procedure Submit; safecall;
    function Get_OutputLocation: IDispatch; safecall;
    function Get_ErrorsLocation: IDispatch; safecall;
    function GenerateDataSetDiffGram(const pNode: IDispatch): IDispatch; safecall;
    function Get_Timeout: Integer; safecall;
    procedure Set_Timeout(plTimeout: Integer); safecall;
    property QueryAllowed: WordBool read Get_QueryAllowed;
    property SubmitAllowed: WordBool read Get_SubmitAllowed;
    property Name: WideString read Get_Name;
    property OutputLocation: IDispatch read Get_OutputLocation;
    property ErrorsLocation: IDispatch read Get_ErrorsLocation;
    property Timeout: Integer read Get_Timeout write Set_Timeout;
  end;

// *********************************************************************//
// DispIntf:  WebServiceAdapter2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D4-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  WebServiceAdapter2Disp = dispinterface
    ['{096CD5D4-0786-11D1-95FA-0080C78EE3BB}']
    property QueryAllowed: WordBool readonly dispid 8;
    property SubmitAllowed: WordBool readonly dispid 9;
    property Name: WideString readonly dispid 10;
    procedure Query; dispid 11;
    procedure Submit; dispid 12;
    property OutputLocation: IDispatch readonly dispid 14;
    property ErrorsLocation: IDispatch readonly dispid 15;
    function GenerateDataSetDiffGram(const pNode: IDispatch): IDispatch; dispid 13;
    property Timeout: Integer dispid 16;
    property WSDLURL: WideString readonly dispid 5;
    property Operation: WideString dispid 6;
    property Input: WideString dispid 7;
  end;

// *********************************************************************//
// Interface: XMLFileAdapter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD655-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XMLFileAdapter = interface(IDispatch)
    ['{096CD655-0786-11D1-95FA-0080C78EE3BB}']
    function Get_FileURL: WideString; safecall;
    procedure Set_FileURL(const pbstrFileURL: WideString); safecall;
    property FileURL: WideString read Get_FileURL write Set_FileURL;
  end;

// *********************************************************************//
// DispIntf:  XMLFileAdapterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD655-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XMLFileAdapterDisp = dispinterface
    ['{096CD655-0786-11D1-95FA-0080C78EE3BB}']
    property FileURL: WideString dispid 5;
  end;

// *********************************************************************//
// Interface: XMLFileAdapter2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D5-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XMLFileAdapter2 = interface(XMLFileAdapter)
    ['{096CD5D5-0786-11D1-95FA-0080C78EE3BB}']
    function Get_QueryAllowed: WordBool; safecall;
    function Get_SubmitAllowed: WordBool; safecall;
    function Get_Name: WideString; safecall;
    procedure Query; safecall;
    procedure Submit; safecall;
    property QueryAllowed: WordBool read Get_QueryAllowed;
    property SubmitAllowed: WordBool read Get_SubmitAllowed;
    property Name: WideString read Get_Name;
  end;

// *********************************************************************//
// DispIntf:  XMLFileAdapter2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D5-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  XMLFileAdapter2Disp = dispinterface
    ['{096CD5D5-0786-11D1-95FA-0080C78EE3BB}']
    property QueryAllowed: WordBool readonly dispid 6;
    property SubmitAllowed: WordBool readonly dispid 7;
    property Name: WideString readonly dispid 8;
    procedure Query; dispid 9;
    procedure Submit; dispid 10;
    property FileURL: WideString dispid 5;
  end;

// *********************************************************************//
// Interface: IDataAdapterMOM
// Flags:     (16) Hidden
// GUID:      {096CD734-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  IDataAdapterMOM = interface(IUnknown)
    ['{096CD734-0786-11D1-95FA-0080C78EE3BB}']
    function QueryWithOutput(out pbstrOutputXML: WideString): HResult; stdcall;
    function GetErrorXMLForMOM(out pbstrErrorXml: WideString): HResult; stdcall;
    function SubmitWithInput(const bstrInputXML: WideString): HResult; stdcall;
    function GetAdoSubmitName(out pbstrSubmitName: WideString): HResult; stdcall;
    function GenerateDataSetDiffGramInXml(out pbstrDiffGram: WideString): HResult; stdcall;
    function QueryOrSubmitWithInputOutput(fInputIsNull: WordBool; const bstrInputXML: WideString; 
                                          fOutputIsNull: WordBool; out pbstrOutputXML: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: SharepointListAdapter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD69A-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SharepointListAdapter = interface(IDispatch)
    ['{096CD69A-0786-11D1-95FA-0080C78EE3BB}']
    function Get_SiteUrl: WideString; safecall;
    function Get_QueryAllowed: WordBool; safecall;
    function Get_SubmitAllowed: WordBool; safecall;
    function Get_Name: WideString; safecall;
    procedure Query; safecall;
    procedure Submit; safecall;
    property SiteUrl: WideString read Get_SiteUrl;
    property QueryAllowed: WordBool read Get_QueryAllowed;
    property SubmitAllowed: WordBool read Get_SubmitAllowed;
    property Name: WideString read Get_Name;
  end;

// *********************************************************************//
// DispIntf:  SharepointListAdapterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD69A-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SharepointListAdapterDisp = dispinterface
    ['{096CD69A-0786-11D1-95FA-0080C78EE3BB}']
    property SiteUrl: WideString readonly dispid 5;
    property QueryAllowed: WordBool readonly dispid 6;
    property SubmitAllowed: WordBool readonly dispid 7;
    property Name: WideString readonly dispid 8;
    procedure Query; dispid 9;
    procedure Submit; dispid 10;
  end;

// *********************************************************************//
// Interface: SharepointListAdapter2
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD740-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SharepointListAdapter2 = interface(SharepointListAdapter)
    ['{096CD740-0786-11D1-95FA-0080C78EE3BB}']
    function Get_QueryThisFormOnly: WordBool; safecall;
    property QueryThisFormOnly: WordBool read Get_QueryThisFormOnly;
  end;

// *********************************************************************//
// DispIntf:  SharepointListAdapter2Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD740-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SharepointListAdapter2Disp = dispinterface
    ['{096CD740-0786-11D1-95FA-0080C78EE3BB}']
    property QueryThisFormOnly: WordBool readonly dispid 11;
    property SiteUrl: WideString readonly dispid 5;
    property QueryAllowed: WordBool readonly dispid 6;
    property SubmitAllowed: WordBool readonly dispid 7;
    property Name: WideString readonly dispid 8;
    procedure Query; dispid 9;
    procedure Submit; dispid 10;
  end;

// *********************************************************************//
// Interface: DAVAdapter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D6-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DAVAdapter = interface(IDispatch)
    ['{096CD5D6-0786-11D1-95FA-0080C78EE3BB}']
    function Get_QueryAllowed: WordBool; safecall;
    function Get_SubmitAllowed: WordBool; safecall;
    function Get_Name: WideString; safecall;
    function Get_FolderURL: WideString; safecall;
    procedure Set_FolderURL(const pbstrURL: WideString); safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_FileName(const pbstrFileName: WideString); safecall;
    procedure Query; safecall;
    procedure Submit; safecall;
    procedure SubmitData(const pData: IDispatch); safecall;
    property QueryAllowed: WordBool read Get_QueryAllowed;
    property SubmitAllowed: WordBool read Get_SubmitAllowed;
    property Name: WideString read Get_Name;
    property FolderURL: WideString read Get_FolderURL write Set_FolderURL;
    property FileName: WideString read Get_FileName write Set_FileName;
  end;

// *********************************************************************//
// DispIntf:  DAVAdapterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D6-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  DAVAdapterDisp = dispinterface
    ['{096CD5D6-0786-11D1-95FA-0080C78EE3BB}']
    property QueryAllowed: WordBool readonly dispid 5;
    property SubmitAllowed: WordBool readonly dispid 6;
    property Name: WideString readonly dispid 7;
    property FolderURL: WideString dispid 8;
    property FileName: WideString dispid 9;
    procedure Query; dispid 10;
    procedure Submit; dispid 11;
    procedure SubmitData(const pData: IDispatch); dispid 12;
  end;

// *********************************************************************//
// Interface: EmailAdapter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D7-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  EmailAdapter = interface(IDispatch)
    ['{096CD5D7-0786-11D1-95FA-0080C78EE3BB}']
    function Get_QueryAllowed: WordBool; safecall;
    function Get_SubmitAllowed: WordBool; safecall;
    function Get_Name: WideString; safecall;
    function Get_To_: WideString; safecall;
    procedure Set_To_(const pbstrTo: WideString); safecall;
    function Get_CC: WideString; safecall;
    procedure Set_CC(const pbstrCC: WideString); safecall;
    function Get_BCC: WideString; safecall;
    procedure Set_BCC(const pbstrBCC: WideString); safecall;
    function Get_Subject: WideString; safecall;
    procedure Set_Subject(const pbstrSubject: WideString); safecall;
    function Get_Intro: WideString; safecall;
    procedure Set_Intro(const pbstrIntro: WideString); safecall;
    function Get_AttachmentFileName: WideString; safecall;
    procedure Set_AttachmentFileName(const pbstrAttachmentFilename: WideString); safecall;
    procedure Query; safecall;
    procedure Submit; safecall;
    procedure SubmitData(const pData: IDispatch); safecall;
    function Get_AttachmentType: XdAttachmentType; safecall;
    procedure Set_AttachmentType(peAttachmentType: XdAttachmentType); safecall;
    property QueryAllowed: WordBool read Get_QueryAllowed;
    property SubmitAllowed: WordBool read Get_SubmitAllowed;
    property Name: WideString read Get_Name;
    property To_: WideString read Get_To_ write Set_To_;
    property CC: WideString read Get_CC write Set_CC;
    property BCC: WideString read Get_BCC write Set_BCC;
    property Subject: WideString read Get_Subject write Set_Subject;
    property Intro: WideString read Get_Intro write Set_Intro;
    property AttachmentFileName: WideString read Get_AttachmentFileName write Set_AttachmentFileName;
    property AttachmentType: XdAttachmentType read Get_AttachmentType write Set_AttachmentType;
  end;

// *********************************************************************//
// DispIntf:  EmailAdapterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5D7-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  EmailAdapterDisp = dispinterface
    ['{096CD5D7-0786-11D1-95FA-0080C78EE3BB}']
    property QueryAllowed: WordBool readonly dispid 5;
    property SubmitAllowed: WordBool readonly dispid 6;
    property Name: WideString readonly dispid 7;
    property To_: WideString dispid 8;
    property CC: WideString dispid 9;
    property BCC: WideString dispid 10;
    property Subject: WideString dispid 11;
    property Intro: WideString dispid 12;
    property AttachmentFileName: WideString dispid 13;
    procedure Query; dispid 14;
    procedure Submit; dispid 15;
    procedure SubmitData(const pData: IDispatch); dispid 16;
    property AttachmentType: XdAttachmentType dispid 17;
  end;

// *********************************************************************//
// Interface: HWSAdapter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6BF-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  HWSAdapter = interface(IDispatch)
    ['{096CD6BF-0786-11D1-95FA-0080C78EE3BB}']
    function Get_QueryAllowed: WordBool; safecall;
    function Get_SubmitAllowed: WordBool; safecall;
    function Get_Name: WideString; safecall;
    procedure Query; safecall;
    procedure Submit; safecall;
    property QueryAllowed: WordBool read Get_QueryAllowed;
    property SubmitAllowed: WordBool read Get_SubmitAllowed;
    property Name: WideString read Get_Name;
  end;

// *********************************************************************//
// DispIntf:  HWSAdapterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6BF-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  HWSAdapterDisp = dispinterface
    ['{096CD6BF-0786-11D1-95FA-0080C78EE3BB}']
    property QueryAllowed: WordBool readonly dispid 1;
    property SubmitAllowed: WordBool readonly dispid 2;
    property Name: WideString readonly dispid 3;
    procedure Query; dispid 4;
    procedure Submit; dispid 5;
  end;

// *********************************************************************//
// Interface: SubmitToHostAdapter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD739-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SubmitToHostAdapter = interface(IDispatch)
    ['{096CD739-0786-11D1-95FA-0080C78EE3BB}']
    function Get_QueryAllowed: WordBool; safecall;
    function Get_SubmitAllowed: WordBool; safecall;
    function Get_Name: WideString; safecall;
    procedure Query; safecall;
    procedure Submit; safecall;
    property QueryAllowed: WordBool read Get_QueryAllowed;
    property SubmitAllowed: WordBool read Get_SubmitAllowed;
    property Name: WideString read Get_Name;
  end;

// *********************************************************************//
// DispIntf:  SubmitToHostAdapterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD739-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  SubmitToHostAdapterDisp = dispinterface
    ['{096CD739-0786-11D1-95FA-0080C78EE3BB}']
    property QueryAllowed: WordBool readonly dispid 1;
    property SubmitAllowed: WordBool readonly dispid 2;
    property Name: WideString readonly dispid 3;
    procedure Query; dispid 4;
    procedure Submit; dispid 5;
  end;

// *********************************************************************//
// Interface: HTMLTaskPaneExternal
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5F4-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  HTMLTaskPaneExternal = interface(IDispatch)
    ['{096CD5F4-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Window: Window; safecall;
    function Get_XDocument: _XDocument; safecall;
    property Window: Window read Get_Window;
    property XDocument: _XDocument read Get_XDocument;
  end;

// *********************************************************************//
// DispIntf:  HTMLTaskPaneExternalDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD5F4-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  HTMLTaskPaneExternalDisp = dispinterface
    ['{096CD5F4-0786-11D1-95FA-0080C78EE3BB}']
    property Window: Window readonly dispid 1;
    property XDocument: _XDocument readonly dispid 2;
  end;

// *********************************************************************//
// Interface: ICLRExtensions
// Flags:     (16) Hidden
// GUID:      {096CD6A9-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ICLRExtensions = interface(IUnknown)
    ['{096CD6A9-0786-11D1-95FA-0080C78EE3BB}']
    function GetEventSource(const bstrContext: WideString; const bstrEventID: WideString; 
                            const bstrDataObjectName: WideString; out ppdispSource: IDispatch): HResult; stdcall;
    function GetInvokeHelper(const pdispTarget: IDispatch; out ppdispInvokeHelper: IDispatch): HResult; stdcall;
    function IsCrossDomainSafe(const punkCallee: IUnknown; out pvfSafe: WordBool): HResult; stdcall;
    function GetLocalizedErrorString(idError: SYSINT; out pbstrError: WideString): HResult; stdcall;
    function GetLocalizedMsxmlInteropErrorString(idError: SYSINT; out pbstrError: WideString): HResult; stdcall;
    function GetLocalizedDesignOnceErrorString(const bstrErrorId: WideString; 
                                               out pbstrError: WideString): HResult; stdcall;
    function ShowExceptionDialog(const bstrMessage: WideString; const bstrDetails: WideString): HResult; stdcall;
    function PutCancellationInfo(vfSuppressUI: WordBool; const bstrMessage: WideString; 
                                 const bstrDetails: WideString): HResult; stdcall;
    function GetIntPtr(const pdispNode: IDispatch; out pcNode: SYSINT): HResult; stdcall;
    function IncrementSqmPoint(idDataPt: SYSINT): HResult; stdcall;
    function SetDocumentSqmValue(idDataPt: SYSINT): HResult; stdcall;
    function PrintWithDialog: HResult; stdcall;
    function GetMomXmlEventInfo(out pfOneToOneTextChange: Integer): HResult; stdcall;
    function CloseDocument: HResult; stdcall;
    function GetCacheDirectory(out pbstrCacheDirectory: WideString): HResult; stdcall;
    function GetEventSourceNoPostProcess(const bstrContext: WideString; 
                                         const bstrEventID: WideString; 
                                         const bstrDataObjectName: WideString; 
                                         out ppdispSource: IDispatch): HResult; stdcall;
    function PostProcessEventListeners: HResult; stdcall;
    function ForceAppDomainUnload(const bstrAssemblyName: WideString): HResult; stdcall;
    function SetCanUnloadAppDomain(vfCanUnload: WordBool): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: _ButtonEventSink
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6AB-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _ButtonEventSink = interface(IDispatch)
    ['{096CD6AB-0786-11D1-95FA-0080C78EE3BB}']
    procedure OnClick(const pEvent: DocActionEvent); safecall;
  end;

// *********************************************************************//
// DispIntf:  _ButtonEventSinkDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD6AB-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _ButtonEventSinkDisp = dispinterface
    ['{096CD6AB-0786-11D1-95FA-0080C78EE3BB}']
    procedure OnClick(const pEvent: DocActionEvent); dispid 1;
  end;

// *********************************************************************//
// Interface: ISubmitToHostEventHandler
// Flags:     (0)
// GUID:      {096CD738-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  ISubmitToHostEventHandler = interface(IUnknown)
    ['{096CD738-0786-11D1-95FA-0080C78EE3BB}']
    function SubmitToHostEventHandler(const punkSender: IUnknown; 
                                      const bstrAdapterName: WideString; 
                                      out pbstrErrorMessage: WideString; out pfReturnStatus: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: INotifyHostEventHandler
// Flags:     (0)
// GUID:      {096CD764-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  INotifyHostEventHandler = interface(IUnknown)
    ['{096CD764-0786-11D1-95FA-0080C78EE3BB}']
    function NotifyHostEventHandler(const punkSender: IUnknown; const bstrNotification: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IInitEventHandler
// Flags:     (0)
// GUID:      {096CD73A-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  IInitEventHandler = interface(IUnknown)
    ['{096CD73A-0786-11D1-95FA-0080C78EE3BB}']
    function InitEventHandler(const punkSender: IUnknown; const pDocument: _XDocument; 
                              out pROMode: XdReadOnlyViewMode): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: InfoPathEditor
// Flags:     (0)
// GUID:      {096CD706-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  InfoPathEditor = interface(IUnknown)
    ['{096CD706-0786-11D1-95FA-0080C78EE3BB}']
    function Load(const bstrURL: WideString): HResult; stdcall;
    function LoadFromStream(const punkStream: IUnknown): HResult; stdcall;
    function NewFromSolution(const bstrSolutionURI: WideString): HResult; stdcall;
    function NewFromSolutionWithData(const bstrURLXSN: WideString; const punkStream: IUnknown; 
                                     dwBehavior: Integer): HResult; stdcall;
    function Get_XDocument(out ppXDocument: _XDocument): HResult; stdcall;
    function Get_Host(out ppdispHost: IDispatch): HResult; stdcall;
    function Set_Host(const ppdispHost: IDispatch): HResult; stdcall;
    function Get_HostName(out pbstrHostName: WideString): HResult; stdcall;
    function Set_HostName(const pbstrHostName: WideString): HResult; stdcall;
    function SetSubmitToHostEventHandler(const pHandler: ISubmitToHostEventHandler): HResult; stdcall;
    function SetInitEventHandler(const handler: IInitEventHandler): HResult; stdcall;
    function Get_DataConnectionBaseUrl(out pbstrDataConnectionBaseUrl: WideString): HResult; stdcall;
    function Set_DataConnectionBaseUrl(const pbstrDataConnectionBaseUrl: WideString): HResult; stdcall;
    function FlushDocument: HResult; stdcall;
    function CloseDocument: HResult; stdcall;
    function SetNotifyHostEventHandler(const pHandler: INotifyHostEventHandler): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: _Application3
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD72E-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _Application3 = interface(_Application2)
    ['{096CD72E-0786-11D1-95FA-0080C78EE3BB}']
    function Get_COMAddIns: IDispatch; safecall;
    function Get_Events: IUnknown; safecall;
    function GetSolutionURI(const bstrCacheID: WideString): WideString; safecall;
    property COMAddIns: IDispatch read Get_COMAddIns;
    property Events: IUnknown read Get_Events;
  end;

// *********************************************************************//
// DispIntf:  _Application3Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {096CD72E-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _Application3Disp = dispinterface
    ['{096CD72E-0786-11D1-95FA-0080C78EE3BB}']
    property COMAddIns: IDispatch readonly dispid 19;
    property Events: IUnknown readonly dispid 20;
    function GetSolutionURI(const bstrCacheID: WideString): WideString; dispid 21;
    property User: User readonly dispid 11;
    procedure RegisterSolution(const bstrSolutionURL: WideString; const bstrBehavior: WideString); dispid 12;
    procedure UnregisterSolution(const bstrSolutionURI: WideString); dispid 13;
    procedure CacheSolution(const bstrSolutionURI: WideString); dispid 14;
    property MachineOnlineState: XdMachineOnlineState readonly dispid 15;
    function IsDestinationReachable(const bstrDestination: WideString): WordBool; dispid 16;
    property UsableWidth: Integer readonly dispid 17;
    property UsableHeight: Integer readonly dispid 18;
    property Name: WideString readonly dispid 0;
    property Windows: Windows readonly dispid 2;
    property XDocuments: XDocuments readonly dispid 3;
    property ActiveWindow: Window readonly dispid 4;
    property Version: WideString readonly dispid 5;
    property LanguageSettings: IDispatch readonly dispid 6;
    function FormatString(varInput: OleVariant; const bstrCategory: WideString; 
                          const bstrOptions: WideString): WideString; dispid 7;
    procedure Quit(bForce: WordBool); dispid 8;
    function NewADODBRecordset: IDispatch; dispid 9;
    function NewADODBConnection: IDispatch; dispid 10;
  end;

// *********************************************************************//
// DispIntf:  _ApplicationEvents
// Flags:     (4096) Dispatchable
// GUID:      {096CD72D-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  _ApplicationEvents = dispinterface
    ['{096CD72D-0786-11D1-95FA-0080C78EE3BB}']
    procedure WindowActivate(const pDocument: _XDocument; const pWindow: Window); dispid 1;
    procedure WindowDeactivate(const pDocument: _XDocument; const pWindow: Window); dispid 2;
    procedure WindowSize(const pDocument: _XDocument; const pWindow: Window); dispid 3;
    procedure XDocumentBeforeClose(const pDocument: _XDocument; var pfCancel: WordBool); dispid 4;
    procedure XDocumentBeforePrint(const pDocument: _XDocument; var pfCancel: WordBool); dispid 5;
    procedure XDocumentBeforeSave(const pDocument: _XDocument; var pfCancel: WordBool); dispid 6;
    procedure NewXDocument(const pDocument: _XDocument); dispid 7;
    procedure XDocumentOpen(const pDocument: _XDocument); dispid 8;
    procedure Quit; dispid 9;
    procedure XDocumentChange; dispid 10;
  end;

// *********************************************************************//
// Interface: IInfoPathDataImporterFields
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {096CD76C-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  IInfoPathDataImporterFields = interface(IUnknown)
    ['{096CD76C-0786-11D1-95FA-0080C78EE3BB}']
    function GetControls(out ppEnumUnkControls: IEnumUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IInfoPathDataImporter
// Flags:     (128) NonExtensible
// GUID:      {096CD6D9-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  IInfoPathDataImporter = interface(IUnknown)
    ['{096CD6D9-0786-11D1-95FA-0080C78EE3BB}']
    function Initialize(lcid: SYSUINT): HResult; stdcall;
    function Import(const pPrintSettings: IPropertyBag; const punkViewControls: IEnumUnknown): HResult; stdcall;
    function Uninitialize: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IPropertyBag
// Flags:     (0)
// GUID:      {55272A00-42CB-11CE-8135-00AA004BB851}
// *********************************************************************//
  IPropertyBag = interface(IUnknown)
    ['{55272A00-42CB-11CE-8135-00AA004BB851}']
    function RemoteRead(pszPropName: PWideChar; out pVar: OleVariant; const pErrorLog: IErrorLog; 
                        varType: LongWord; const pUnkObj: IUnknown): HResult; stdcall;
    function Write(pszPropName: PWideChar; var pVar: OleVariant): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IErrorLog
// Flags:     (0)
// GUID:      {3127CA40-446E-11CE-8135-00AA004BB851}
// *********************************************************************//
  IErrorLog = interface(IUnknown)
    ['{3127CA40-446E-11CE-8135-00AA004BB851}']
    function AddError(pszPropName: PWideChar; var pExcepInfo: EXCEPINFO): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IInfoPathViewControl
// Flags:     (384) NonExtensible OleAutomation
// GUID:      {096CD6DA-0786-11D1-95FA-0080C78EE3BB}
// *********************************************************************//
  IInfoPathViewControl = interface(IUnknown)
    ['{096CD6DA-0786-11D1-95FA-0080C78EE3BB}']
    function Get_Left(out plLeft: Integer): HResult; stdcall;
    function Get_Top(out plTop: Integer): HResult; stdcall;
    function Get_Width(out plWidth: Integer): HResult; stdcall;
    function Get_Height(out plHeight: Integer): HResult; stdcall;
    function Get_ControlType(out pbstrControlType: WideString): HResult; stdcall;
    function Get_DataType(out pbstrDataType: WideString): HResult; stdcall;
    function Get_NodeName(out pbstrNodeName: WideString): HResult; stdcall;
    function Get_Value(out pbstrValue: WideString): HResult; stdcall;
    function Set_Value(const pbstrValue: WideString): HResult; stdcall;
    function Get_InputScopes(out ppInputScopes: PSYSINT1; out pcInputScopes: SYSUINT; 
                             out ppenumPhraseList: IEnumString; out pbstrRegExp: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumString
// Flags:     (0)
// GUID:      {00000101-0000-0000-C000-000000000046}
// *********************************************************************//
  IEnumString = interface(IUnknown)
    ['{00000101-0000-0000-C000-000000000046}']
    function RemoteNext(celt: LongWord; out rgelt: PWideChar; out pceltFetched: LongWord): HResult; stdcall;
    function Skip(celt: LongWord): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumString): HResult; stdcall;
  end;

// *********************************************************************//
// The Class CoApplication provides a Create and CreateRemote method to          
// create instances of the default interface _Application2 exposed by              
// the CoClass Application. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoApplication = class
    class function Create: _Application2;
    class function CreateRemote(const MachineName: string): _Application2;
  end;

  TApplicationWindowActivate = procedure(Sender: TObject; const pDocument: _XDocument;
    const pWindow: Window) of object;
  TApplicationWindowDeactivate = procedure(Sender: TObject; const pDocument: _XDocument;
    const pWindow: Window) of object;
  TApplicationWindowSize = procedure(Sender: TObject; const pDocument: _XDocument;
    const pWindow: Window) of object;
  TApplicationXDocumentBeforeClose = procedure(Sender: TObject;
    const pDocument: _XDocument; var pfCancel: WordBool) of object;
  TApplicationXDocumentBeforePrint = procedure(Sender: TObject;
    const pDocument: _XDocument; var pfCancel: WordBool) of object;
  TApplicationXDocumentBeforeSave = procedure(Sender: TObject;
    const pDocument: _XDocument; var pfCancel: WordBool) of object;
  TApplicationNewXDocument = procedure(Sender: TObject; const pDocument: _XDocument) of object;
  TApplicationXDocumentOpen = procedure(Sender: TObject; const pDocument: _XDocument) of object;

// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TApplication
// Help String      : 
// Default Interface: _Application2
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TApplicationProperties= class;
{$ENDIF}
  TApplication = class(TOleServer)
  private
    FOnWindowActivate: TApplicationWindowActivate;
    FOnWindowDeactivate: TApplicationWindowDeactivate;
    FOnWindowSize: TApplicationWindowSize;
    FOnXDocumentBeforeClose: TApplicationXDocumentBeforeClose;
    FOnXDocumentBeforePrint: TApplicationXDocumentBeforePrint;
    FOnXDocumentBeforeSave: TApplicationXDocumentBeforeSave;
    FOnNewXDocument: TApplicationNewXDocument;
    FOnXDocumentOpen: TApplicationXDocumentOpen;
    FOnQuit: TNotifyEvent;
    FOnXDocumentChange: TNotifyEvent;
    FIntf:        _Application3;
    FAutoQuit:    Boolean;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TApplicationProperties;
    function      GetServerProperties: TApplicationProperties;
{$ENDIF}
    function      GetDefaultInterface: _Application3;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_User: User;
    function Get_MachineOnlineState: XdMachineOnlineState;
    function Get_UsableWidth: Integer;
    function Get_UsableHeight: Integer;

    function Get_COMAddIns: IDispatch;
    function Get_Events: IUnknown;
    function Get_Name: WideString;
    function Get_Windows: Windows;
    function Get_XDocuments: XDocuments;
    function Get_ActiveWindow: Window;
    function Get_Version: WideString;
    function Get_LanguageSettings: IDispatch;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Application3);
    procedure Disconnect; override;
    procedure RegisterSolution(const bstrSolutionURL: WideString; const bstrBehavior: WideString);
    procedure UnregisterSolution(const bstrSolutionURI: WideString);
    procedure CacheSolution(const bstrSolutionURI: WideString);
    function IsDestinationReachable(const bstrDestination: WideString): WordBool;
    property DefaultInterface: _Application3 read GetDefaultInterface;
    property User: User read Get_User;
    property MachineOnlineState: XdMachineOnlineState read Get_MachineOnlineState;
    property UsableWidth: Integer read Get_UsableWidth;
    property UsableHeight: Integer read Get_UsableHeight;

    function GetSolutionURI(const bstrCacheID: WideString): WideString;
    function FormatString(varInput: OleVariant; const bstrCategory: WideString;
                          const bstrOptions: WideString): WideString;
    procedure Quit(bForce: WordBool);
    function NewADODBRecordset: IDispatch;
    function NewADODBConnection: IDispatch;
    property COMAddIns: IDispatch read Get_COMAddIns;
    property Events: IUnknown read Get_Events;
    property Name: WideString read Get_Name;
    property Windows: Windows read Get_Windows;
    property XDocuments: XDocuments read Get_XDocuments;
    property ActiveWindow: Window read Get_ActiveWindow;
    property Version: WideString read Get_Version;
    property LanguageSettings: IDispatch read Get_LanguageSettings;
  published
    property AutoQuit: Boolean read FAutoQuit write FAutoQuit; 
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TApplicationProperties read GetServerProperties;
{$ENDIF}
    property OnWindowActivate: TApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnWindowSize: TApplicationWindowSize read FOnWindowSize write FOnWindowSize;
    property OnXDocumentBeforeClose: TApplicationXDocumentBeforeClose read FOnXDocumentBeforeClose write FOnXDocumentBeforeClose;
    property OnXDocumentBeforePrint: TApplicationXDocumentBeforePrint read FOnXDocumentBeforePrint write FOnXDocumentBeforePrint;
    property OnXDocumentBeforeSave: TApplicationXDocumentBeforeSave read FOnXDocumentBeforeSave write FOnXDocumentBeforeSave;
    property OnNewXDocument: TApplicationNewXDocument read FOnNewXDocument write FOnNewXDocument;
    property OnXDocumentOpen: TApplicationXDocumentOpen read FOnXDocumentOpen write FOnXDocumentOpen;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnXDocumentChange: TNotifyEvent read FOnXDocumentChange write FOnXDocumentChange;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TApplication
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TApplicationProperties = class(TPersistent)
  private
    FServer:    TApplication;
    function    GetDefaultInterface: _Application2;
    constructor Create(AServer: TApplication);
  protected
    function Get_User: User;
    function Get_MachineOnlineState: XdMachineOnlineState;
    function Get_UsableWidth: Integer;
    function Get_UsableHeight: Integer;
  public
    property DefaultInterface: _Application2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoExternalApplication provides a Create and CreateRemote method to          
// create instances of the default interface _ExternalApplication exposed by              
// the CoClass ExternalApplication. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoExternalApplication = class
    class function Create: _ExternalApplication;
    class function CreateRemote(const MachineName: string): _ExternalApplication;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TExternalApplication
// Help String      : 
// Default Interface: _ExternalApplication
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TExternalApplicationProperties= class;
{$ENDIF}
  TExternalApplication = class(TOleServer)
  private
    FAutoQuit:    Boolean;
    FIntf:        _ExternalApplication;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TExternalApplicationProperties;
    function      GetServerProperties: TExternalApplicationProperties;
{$ENDIF}
    function      GetDefaultInterface: _ExternalApplication;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _ExternalApplication);
    procedure Disconnect; override;
    procedure Quit;
    procedure RegisterSolution(const bstrSolutionURL: WideString; const bstrBehavior: WideString);
    procedure UnregisterSolution(const bstrSolutionURI: WideString);
    procedure New(const bstrDocumentURI: WideString; dwBehavior: Integer);
    procedure Open(const bstrDocumentURI: WideString; dwBehavior: Integer);
    procedure Close(const bstrDocumentURI: WideString);
    procedure NewFromSolution(const bstrSolutionURI: WideString);
    procedure CacheSolution(const bstrSolutionURI: WideString);
    property DefaultInterface: _ExternalApplication read GetDefaultInterface;
  published
    property AutoQuit: Boolean read FAutoQuit write FAutoQuit; 
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TExternalApplicationProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TExternalApplication
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TExternalApplicationProperties = class(TPersistent)
  private
    FServer:    TExternalApplication;
    function    GetDefaultInterface: _ExternalApplication;
    constructor Create(AServer: TExternalApplication);
  protected
  public
    property DefaultInterface: _ExternalApplication read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoXDocument provides a Create and CreateRemote method to          
// create instances of the default interface _XDocument2 exposed by              
// the CoClass XDocument. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoXDocument = class
    class function Create: _XDocument2;
    class function CreateRemote(const MachineName: string): _XDocument2;
  end;

// *********************************************************************//
// The Class CoUIObject provides a Create and CreateRemote method to          
// create instances of the default interface UI2 exposed by              
// the CoClass UIObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUIObject = class
    class function Create: UI2;
    class function CreateRemote(const MachineName: string): UI2;
  end;

// *********************************************************************//
// The Class CoDataAdaptersCollection provides a Create and CreateRemote method to          
// create instances of the default interface DataAdapters exposed by              
// the CoClass DataAdaptersCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataAdaptersCollection = class
    class function Create: DataAdapters;
    class function CreateRemote(const MachineName: string): DataAdapters;
  end;

// *********************************************************************//
// The Class CoEmailAdapterObject provides a Create and CreateRemote method to          
// create instances of the default interface EmailAdapter exposed by              
// the CoClass EmailAdapterObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoEmailAdapterObject = class
    class function Create: EmailAdapter;
    class function CreateRemote(const MachineName: string): EmailAdapter;
  end;

// *********************************************************************//
// The Class CoDAVAdapterObject provides a Create and CreateRemote method to          
// create instances of the default interface DAVAdapter exposed by              
// the CoClass DAVAdapterObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDAVAdapterObject = class
    class function Create: DAVAdapter;
    class function CreateRemote(const MachineName: string): DAVAdapter;
  end;

// *********************************************************************//
// The Class CoHWSAdapterObject provides a Create and CreateRemote method to          
// create instances of the default interface HWSAdapter exposed by              
// the CoClass HWSAdapterObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoHWSAdapterObject = class
    class function Create: HWSAdapter;
    class function CreateRemote(const MachineName: string): HWSAdapter;
  end;

// *********************************************************************//
// The Class CoSubmitToHostAdapterObject provides a Create and CreateRemote method to          
// create instances of the default interface SubmitToHostAdapter exposed by              
// the CoClass SubmitToHostAdapterObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSubmitToHostAdapterObject = class
    class function Create: SubmitToHostAdapter;
    class function CreateRemote(const MachineName: string): SubmitToHostAdapter;
  end;

// *********************************************************************//
// The Class CoSharepointListAdapterObject provides a Create and CreateRemote method to          
// create instances of the default interface SharepointListAdapter exposed by              
// the CoClass SharepointListAdapterObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSharepointListAdapterObject = class
    class function Create: SharepointListAdapter;
    class function CreateRemote(const MachineName: string): SharepointListAdapter;
  end;

// *********************************************************************//
// The Class CoXMLFileAdapterObject provides a Create and CreateRemote method to          
// create instances of the default interface XMLFileAdapter2 exposed by              
// the CoClass XMLFileAdapterObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoXMLFileAdapterObject = class
    class function Create: XMLFileAdapter2;
    class function CreateRemote(const MachineName: string): XMLFileAdapter2;
  end;

// *********************************************************************//
// The Class CoWebServiceAdapterObject provides a Create and CreateRemote method to          
// create instances of the default interface WebServiceAdapter2 exposed by              
// the CoClass WebServiceAdapterObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWebServiceAdapterObject = class
    class function Create: WebServiceAdapter2;
    class function CreateRemote(const MachineName: string): WebServiceAdapter2;
  end;

// *********************************************************************//
// The Class CoADOAdapterObject provides a Create and CreateRemote method to          
// create instances of the default interface ADOAdapter2 exposed by              
// the CoClass ADOAdapterObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoADOAdapterObject = class
    class function Create: ADOAdapter2;
    class function CreateRemote(const MachineName: string): ADOAdapter2;
  end;

// *********************************************************************//
// The Class CoDocEventObject provides a Create and CreateRemote method to          
// create instances of the default interface DocEvent exposed by              
// the CoClass DocEventObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDocEventObject = class
    class function Create: DocEvent;
    class function CreateRemote(const MachineName: string): DocEvent;
  end;

// *********************************************************************//
// The Class CoDocReturnEventObject provides a Create and CreateRemote method to          
// create instances of the default interface DocReturnEvent exposed by              
// the CoClass DocReturnEventObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDocReturnEventObject = class
    class function Create: DocReturnEvent;
    class function CreateRemote(const MachineName: string): DocReturnEvent;
  end;

// *********************************************************************//
// The Class CoDocActionEventObject provides a Create and CreateRemote method to          
// create instances of the default interface DocActionEvent exposed by              
// the CoClass DocActionEventObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDocActionEventObject = class
    class function Create: DocActionEvent;
    class function CreateRemote(const MachineName: string): DocActionEvent;
  end;

// *********************************************************************//
// The Class CoVersionUpgradeEventObject provides a Create and CreateRemote method to          
// create instances of the default interface VersionUpgradeEvent exposed by              
// the CoClass VersionUpgradeEventObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoVersionUpgradeEventObject = class
    class function Create: VersionUpgradeEvent;
    class function CreateRemote(const MachineName: string): VersionUpgradeEvent;
  end;

// *********************************************************************//
// The Class CoDataDOMEventObject provides a Create and CreateRemote method to          
// create instances of the default interface DataDOMEvent exposed by              
// the CoClass DataDOMEventObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataDOMEventObject = class
    class function Create: DataDOMEvent;
    class function CreateRemote(const MachineName: string): DataDOMEvent;
  end;

// *********************************************************************//
// The Class CoSolutionObject provides a Create and CreateRemote method to          
// create instances of the default interface Solution exposed by              
// the CoClass SolutionObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSolutionObject = class
    class function Create: Solution;
    class function CreateRemote(const MachineName: string): Solution;
  end;

// *********************************************************************//
// The Class CoWindowObject provides a Create and CreateRemote method to          
// create instances of the default interface Window2 exposed by              
// the CoClass WindowObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWindowObject = class
    class function Create: Window2;
    class function CreateRemote(const MachineName: string): Window2;
  end;

// *********************************************************************//
// The Class CoWindowsCollection provides a Create and CreateRemote method to          
// create instances of the default interface Windows exposed by              
// the CoClass WindowsCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoWindowsCollection = class
    class function Create: Windows;
    class function CreateRemote(const MachineName: string): Windows;
  end;

// *********************************************************************//
// The Class CoTaskPanesCollection provides a Create and CreateRemote method to          
// create instances of the default interface TaskPanes exposed by              
// the CoClass TaskPanesCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTaskPanesCollection = class
    class function Create: TaskPanes;
    class function CreateRemote(const MachineName: string): TaskPanes;
  end;

// *********************************************************************//
// The Class CoTaskPaneObject provides a Create and CreateRemote method to          
// create instances of the default interface TaskPane exposed by              
// the CoClass TaskPaneObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTaskPaneObject = class
    class function Create: TaskPane;
    class function CreateRemote(const MachineName: string): TaskPane;
  end;

// *********************************************************************//
// The Class CoHTMLTaskPaneObject provides a Create and CreateRemote method to          
// create instances of the default interface HTMLTaskPane exposed by              
// the CoClass HTMLTaskPaneObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoHTMLTaskPaneObject = class
    class function Create: HTMLTaskPane;
    class function CreateRemote(const MachineName: string): HTMLTaskPane;
  end;

// *********************************************************************//
// The Class CoViewObject provides a Create and CreateRemote method to          
// create instances of the default interface View exposed by              
// the CoClass ViewObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoViewObject = class
    class function Create: View;
    class function CreateRemote(const MachineName: string): View;
  end;

// *********************************************************************//
// The Class CoMailEnvelopeObject provides a Create and CreateRemote method to          
// create instances of the default interface MailEnvelope exposed by              
// the CoClass MailEnvelopeObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMailEnvelopeObject = class
    class function Create: MailEnvelope;
    class function CreateRemote(const MachineName: string): MailEnvelope;
  end;

// *********************************************************************//
// The Class CoXDocumentsCollection provides a Create and CreateRemote method to          
// create instances of the default interface XDocuments2 exposed by              
// the CoClass XDocumentsCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoXDocumentsCollection = class
    class function Create: XDocuments2;
    class function CreateRemote(const MachineName: string): XDocuments2;
  end;

// *********************************************************************//
// The Class CoViewInfoObject provides a Create and CreateRemote method to          
// create instances of the default interface ViewInfo exposed by              
// the CoClass ViewInfoObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoViewInfoObject = class
    class function Create: ViewInfo;
    class function CreateRemote(const MachineName: string): ViewInfo;
  end;

// *********************************************************************//
// The Class CoViewInfosCollection provides a Create and CreateRemote method to          
// create instances of the default interface ViewInfos exposed by              
// the CoClass ViewInfosCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoViewInfosCollection = class
    class function Create: ViewInfos;
    class function CreateRemote(const MachineName: string): ViewInfos;
  end;

// *********************************************************************//
// The Class CoErrorObject provides a Create and CreateRemote method to          
// create instances of the default interface Error exposed by              
// the CoClass ErrorObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoErrorObject = class
    class function Create: Error;
    class function CreateRemote(const MachineName: string): Error;
  end;

// *********************************************************************//
// The Class CoErrorsCollection provides a Create and CreateRemote method to          
// create instances of the default interface Errors exposed by              
// the CoClass ErrorsCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoErrorsCollection = class
    class function Create: Errors;
    class function CreateRemote(const MachineName: string): Errors;
  end;

// *********************************************************************//
// The Class CoUtilObject provides a Create and CreateRemote method to          
// create instances of the default interface Util exposed by              
// the CoClass UtilObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUtilObject = class
    class function Create: Util;
    class function CreateRemote(const MachineName: string): Util;
  end;

// *********************************************************************//
// The Class CoMathObject provides a Create and CreateRemote method to          
// create instances of the default interface IPMath exposed by              
// the CoClass MathObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMathObject = class
    class function Create: IPMath;
    class function CreateRemote(const MachineName: string): IPMath;
  end;

// *********************************************************************//
// The Class CoDateObject provides a Create and CreateRemote method to          
// create instances of the default interface Date exposed by              
// the CoClass DateObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDateObject = class
    class function Create: Date;
    class function CreateRemote(const MachineName: string): Date;
  end;

// *********************************************************************//
// The Class CoSignedDataBlocksCollection provides a Create and CreateRemote method to          
// create instances of the default interface SignedDataBlocks exposed by              
// the CoClass SignedDataBlocksCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSignedDataBlocksCollection = class
    class function Create: SignedDataBlocks;
    class function CreateRemote(const MachineName: string): SignedDataBlocks;
  end;

// *********************************************************************//
// The Class CoSignedDataBlockObject provides a Create and CreateRemote method to          
// create instances of the default interface SignedDataBlock exposed by              
// the CoClass SignedDataBlockObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSignedDataBlockObject = class
    class function Create: SignedDataBlock;
    class function CreateRemote(const MachineName: string): SignedDataBlock;
  end;

// *********************************************************************//
// The Class CoSignaturesCollection provides a Create and CreateRemote method to          
// create instances of the default interface Signatures exposed by              
// the CoClass SignaturesCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSignaturesCollection = class
    class function Create: Signatures;
    class function CreateRemote(const MachineName: string): Signatures;
  end;

// *********************************************************************//
// The Class CoSignatureObject provides a Create and CreateRemote method to          
// create instances of the default interface Signature exposed by              
// the CoClass SignatureObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSignatureObject = class
    class function Create: Signature;
    class function CreateRemote(const MachineName: string): Signature;
  end;

// *********************************************************************//
// The Class CoCertificateObject provides a Create and CreateRemote method to          
// create instances of the default interface Certificate exposed by              
// the CoClass CertificateObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCertificateObject = class
    class function Create: Certificate;
    class function CreateRemote(const MachineName: string): Certificate;
  end;

// *********************************************************************//
// The Class CoMergeEventObject provides a Create and CreateRemote method to          
// create instances of the default interface MergeEvent exposed by              
// the CoClass MergeEventObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMergeEventObject = class
    class function Create: MergeEvent;
    class function CreateRemote(const MachineName: string): MergeEvent;
  end;

// *********************************************************************//
// The Class CoSaveEventObject provides a Create and CreateRemote method to          
// create instances of the default interface SaveEvent exposed by              
// the CoClass SaveEventObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSaveEventObject = class
    class function Create: SaveEvent;
    class function CreateRemote(const MachineName: string): SaveEvent;
  end;

// *********************************************************************//
// The Class CoSignEventObject provides a Create and CreateRemote method to          
// create instances of the default interface SignEvent exposed by              
// the CoClass SignEventObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSignEventObject = class
    class function Create: SignEvent;
    class function CreateRemote(const MachineName: string): SignEvent;
  end;

// *********************************************************************//
// The Class CoXMLNodesCollection provides a Create and CreateRemote method to          
// create instances of the default interface XMLNodes exposed by              
// the CoClass XMLNodesCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoXMLNodesCollection = class
    class function Create: XMLNodes;
    class function CreateRemote(const MachineName: string): XMLNodes;
  end;

// *********************************************************************//
// The Class CoDataSourceObject provides a Create and CreateRemote method to          
// create instances of the default interface DataObject exposed by              
// the CoClass DataSourceObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataSourceObject = class
    class function Create: DataObject;
    class function CreateRemote(const MachineName: string): DataObject;
  end;

// *********************************************************************//
// The Class CoDataObjectsCollection provides a Create and CreateRemote method to          
// create instances of the default interface DataObjects exposed by              
// the CoClass DataObjectsCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDataObjectsCollection = class
    class function Create: DataObjects;
    class function CreateRemote(const MachineName: string): DataObjects;
  end;

// *********************************************************************//
// The Class CoDocContextChangeEventObject provides a Create and CreateRemote method to          
// create instances of the default interface DocContextChangeEvent exposed by              
// the CoClass DocContextChangeEventObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDocContextChangeEventObject = class
    class function Create: DocContextChangeEvent;
    class function CreateRemote(const MachineName: string): DocContextChangeEvent;
  end;

// *********************************************************************//
// The Class CoUserObject provides a Create and CreateRemote method to          
// create instances of the default interface User exposed by              
// the CoClass UserObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUserObject = class
    class function Create: User;
    class function CreateRemote(const MachineName: string): User;
  end;

// *********************************************************************//
// The Class CoUserPermissionObject provides a Create and CreateRemote method to          
// create instances of the default interface UserPermission exposed by              
// the CoClass UserPermissionObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUserPermissionObject = class
    class function Create: UserPermission;
    class function CreateRemote(const MachineName: string): UserPermission;
  end;

// *********************************************************************//
// The Class CoPermissionObject provides a Create and CreateRemote method to          
// create instances of the default interface Permission exposed by              
// the CoClass PermissionObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPermissionObject = class
    class function Create: Permission;
    class function CreateRemote(const MachineName: string): Permission;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TInfoPathEditorObject
// Help String      : 
// Default Interface: InfoPathEditor
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TInfoPathEditorObject = class(TOleControl)
  private
    FIntf: InfoPathEditor;
    function  GetControlInterface: InfoPathEditor;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_XDocument(out ppXDocument: _XDocument): HResult;
    function Get_Host(out ppdispHost: IDispatch): HResult;
    function Get_HostName(out pbstrHostName: WideString): HResult;
    function Get_DataConnectionBaseUrl(out pbstrDataConnectionBaseUrl: WideString): HResult;
  public
    function Load(const bstrURL: WideString): HResult;
    function LoadFromStream(const punkStream: IUnknown): HResult;
    function NewFromSolution(const bstrSolutionURI: WideString): HResult;
    function NewFromSolutionWithData(const bstrURLXSN: WideString; const punkStream: IUnknown; 
                                     dwBehavior: Integer): HResult;
    function SetSubmitToHostEventHandler(const pHandler: ISubmitToHostEventHandler): HResult;
    function SetInitEventHandler(const handler: IInitEventHandler): HResult;
    function FlushDocument: HResult;
    function CloseDocument: HResult;
    function SetNotifyHostEventHandler(const pHandler: INotifyHostEventHandler): HResult;
    property  ControlInterface: InfoPathEditor read GetControlInterface;
    property  DefaultInterface: InfoPathEditor read GetControlInterface;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  Visible;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
  end;

// *********************************************************************//
// The Class CoInputParameterObject provides a Create and CreateRemote method to          
// create instances of the default interface InputParameter exposed by              
// the CoClass InputParameterObject. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoInputParameterObject = class
    class function Create: InputParameter;
    class function CreateRemote(const MachineName: string): InputParameter;
  end;

// *********************************************************************//
// The Class CoInputParameterCollection provides a Create and CreateRemote method to          
// create instances of the default interface InputParameters exposed by              
// the CoClass InputParameterCollection. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoInputParameterCollection = class
    class function Create: InputParameters;
    class function CreateRemote(const MachineName: string): InputParameters;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoApplication.Create: _Application2;
begin
  Result := CreateComObject(CLASS_Application) as _Application2;
end;

class function CoApplication.CreateRemote(const MachineName: string): _Application2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Application) as _Application2;
end;

procedure TApplication.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{8075635F-5146-11D5-A672-00B0D022E945}';
//    IntfIID:   '{096CD6BB-0786-11D1-95FA-0080C78EE3BB}';
    IntfIID:   '{096CD72E-0786-11D1-95FA-0080C78EE3BB}';
    EventIID:  '{096CD72D-0786-11D1-95FA-0080C78EE3BB}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TApplication.Connect;
//var
//  punk: IUnknown;
begin
//  if FIntf = nil then begin
//    punk := GetServer;
//    ConnectEvents(punk);
//    FIntf := punk as _Application3;
//  end;
end;

procedure TApplication.ConnectTo(svrIntf: _Application3);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf.Events);
end;

procedure TApplication.DisConnect;
begin
  if FIntf <> nil then begin
    DisconnectEvents(FIntf.Events);
    if FAutoQuit then Quit(True);
    FIntf := nil;
  end;
end;

function TApplication.GetDefaultInterface: _Application3;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TApplicationProperties.Create(Self);
{$ENDIF}
end;

destructor TApplication.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TApplication.GetServerProperties: TApplicationProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TApplication.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnWindowActivate) then
         FOnWindowActivate(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument {const _XDocument},
           IUnknown(TVarData(Params[1]).VPointer) as Window {const Window});
    2: if Assigned(FOnWindowDeactivate) then
         FOnWindowDeactivate(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument {const _XDocument},
           IUnknown(TVarData(Params[1]).VPointer) as Window {const Window});
    3: if Assigned(FOnWindowSize) then
         FOnWindowSize(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument {const _XDocument},
           IUnknown(TVarData(Params[1]).VPointer) as Window {const Window});
    4: if Assigned(FOnXDocumentBeforeClose) then
         FOnXDocumentBeforeClose(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument {const _XDocument},
           WordBool((TVarData(Params[0]).VPointer)^) {var WordBool});
    5: if Assigned(FOnXDocumentBeforePrint) then
         FOnXDocumentBeforePrint(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument {const _XDocument},
           WordBool((TVarData(Params[0]).VPointer)^) {var WordBool});
    6: if Assigned(FOnXDocumentBeforeSave) then
         FOnXDocumentBeforeSave(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument {const _XDocument},
           WordBool((TVarData(Params[0]).VPointer)^) {var WordBool});
    7: if Assigned(FOnNewXDocument) then
         FOnNewXDocument(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument {const _XDocument});
    8: if Assigned(FOnXDocumentOpen) then
         FOnXDocumentOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as _XDocument {const _XDocument});
    9: if Assigned(FOnQuit) then FOnQuit(Self);
    10: if Assigned(FOnXDocumentChange) then FOnXDocumentChange(Self);
  end; {case DispID}
end;

function TApplication.Get_COMAddIns: IDispatch;
begin
  Result := DefaultInterface.COMAddIns;
end;

function TApplication.Get_Events: IUnknown;
begin
  Result := DefaultInterface.Events;
end;

function TApplication.Get_Name: WideString;
begin
  Result := DefaultInterface.Name;
end;

function TApplication.Get_Windows: Windows;
begin
  Result := DefaultInterface.Windows;
end;

function TApplication.Get_XDocuments: XDocuments;
begin
  Result := DefaultInterface.XDocuments;
end;

function TApplication.Get_ActiveWindow: Window;
begin
  Result := DefaultInterface.ActiveWindow;
end;

function TApplication.Get_Version: WideString;
begin
  Result := DefaultInterface.Version;
end;

function TApplication.Get_LanguageSettings: IDispatch;
begin
  Result := DefaultInterface.LanguageSettings;
end;

function TApplication.GetSolutionURI(const bstrCacheID: WideString): WideString;
begin
  Result := DefaultInterface.GetSolutionURI(bstrCacheID);
end;

function TApplication.FormatString(varInput: OleVariant; const bstrCategory: WideString;
  const bstrOptions: WideString): WideString;
begin
  Result := DefaultInterface.FormatString(varInput, bstrCategory, bstrOptions);
end;

procedure TApplication.Quit(bForce: WordBool);
begin
  DefaultInterface.Quit(bForce);
end;

function TApplication.NewADODBRecordset: IDispatch;
begin
  Result := DefaultInterface.NewADODBRecordset;
end;

function TApplication.NewADODBConnection: IDispatch;
begin
  Result := DefaultInterface.NewADODBConnection;
end;

function TApplication.Get_User: User;
begin
    Result := DefaultInterface.User;
end;

function TApplication.Get_MachineOnlineState: XdMachineOnlineState;
begin
    Result := DefaultInterface.MachineOnlineState;
end;

function TApplication.Get_UsableWidth: Integer;
begin
    Result := DefaultInterface.UsableWidth;
end;

function TApplication.Get_UsableHeight: Integer;
begin
    Result := DefaultInterface.UsableHeight;
end;

procedure TApplication.RegisterSolution(const bstrSolutionURL: WideString; 
                                        const bstrBehavior: WideString);
begin
  DefaultInterface.RegisterSolution(bstrSolutionURL, bstrBehavior);
end;

procedure TApplication.UnregisterSolution(const bstrSolutionURI: WideString);
begin
  DefaultInterface.UnregisterSolution(bstrSolutionURI);
end;

procedure TApplication.CacheSolution(const bstrSolutionURI: WideString);
begin
  DefaultInterface.CacheSolution(bstrSolutionURI);
end;

function TApplication.IsDestinationReachable(const bstrDestination: WideString): WordBool;
begin
  Result := DefaultInterface.IsDestinationReachable(bstrDestination);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TApplicationProperties.Create(AServer: TApplication);
begin
  inherited Create;
  FServer := AServer;
end;

function TApplicationProperties.GetDefaultInterface: _Application2;
begin
  Result := FServer.DefaultInterface;
end;

function TApplicationProperties.Get_User: User;
begin
    Result := DefaultInterface.User;
end;

function TApplicationProperties.Get_MachineOnlineState: XdMachineOnlineState;
begin
    Result := DefaultInterface.MachineOnlineState;
end;

function TApplicationProperties.Get_UsableWidth: Integer;
begin
    Result := DefaultInterface.UsableWidth;
end;

function TApplicationProperties.Get_UsableHeight: Integer;
begin
    Result := DefaultInterface.UsableHeight;
end;

{$ENDIF}

class function CoExternalApplication.Create: _ExternalApplication;
begin
  Result := CreateComObject(CLASS_ExternalApplication) as _ExternalApplication;
end;

class function CoExternalApplication.CreateRemote(const MachineName: string): _ExternalApplication;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ExternalApplication) as _ExternalApplication;
end;

procedure TExternalApplication.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{80756358-5146-11D5-A672-00B0D022E945}';
    IntfIID:   '{096CD69F-0786-11D1-95FA-0080C78EE3BB}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TExternalApplication.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _ExternalApplication;
  end;
end;

procedure TExternalApplication.ConnectTo(svrIntf: _ExternalApplication);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TExternalApplication.DisConnect;
begin
  if Fintf <> nil then
  begin
    if FAutoQuit then
      Quit();
    FIntf := nil;
  end;
end;

function TExternalApplication.GetDefaultInterface: _ExternalApplication;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TExternalApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TExternalApplicationProperties.Create(Self);
{$ENDIF}
end;

destructor TExternalApplication.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TExternalApplication.GetServerProperties: TExternalApplicationProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TExternalApplication.Quit;
begin
  DefaultInterface.Quit;
end;

procedure TExternalApplication.RegisterSolution(const bstrSolutionURL: WideString; 
                                                const bstrBehavior: WideString);
begin
  DefaultInterface.RegisterSolution(bstrSolutionURL, bstrBehavior);
end;

procedure TExternalApplication.UnregisterSolution(const bstrSolutionURI: WideString);
begin
  DefaultInterface.UnregisterSolution(bstrSolutionURI);
end;

procedure TExternalApplication.New(const bstrDocumentURI: WideString; dwBehavior: Integer);
begin
  DefaultInterface.New(bstrDocumentURI, dwBehavior);
end;

procedure TExternalApplication.Open(const bstrDocumentURI: WideString; dwBehavior: Integer);
begin
  DefaultInterface.Open(bstrDocumentURI, dwBehavior);
end;

procedure TExternalApplication.Close(const bstrDocumentURI: WideString);
begin
  DefaultInterface.Close(bstrDocumentURI);
end;

procedure TExternalApplication.NewFromSolution(const bstrSolutionURI: WideString);
begin
  DefaultInterface.NewFromSolution(bstrSolutionURI);
end;

procedure TExternalApplication.CacheSolution(const bstrSolutionURI: WideString);
begin
  DefaultInterface.CacheSolution(bstrSolutionURI);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TExternalApplicationProperties.Create(AServer: TExternalApplication);
begin
  inherited Create;
  FServer := AServer;
end;

function TExternalApplicationProperties.GetDefaultInterface: _ExternalApplication;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoXDocument.Create: _XDocument2;
begin
  Result := CreateComObject(CLASS_XDocument) as _XDocument2;
end;

class function CoXDocument.CreateRemote(const MachineName: string): _XDocument2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_XDocument) as _XDocument2;
end;

class function CoUIObject.Create: UI2;
begin
  Result := CreateComObject(CLASS_UIObject) as UI2;
end;

class function CoUIObject.CreateRemote(const MachineName: string): UI2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UIObject) as UI2;
end;

class function CoDataAdaptersCollection.Create: DataAdapters;
begin
  Result := CreateComObject(CLASS_DataAdaptersCollection) as DataAdapters;
end;

class function CoDataAdaptersCollection.CreateRemote(const MachineName: string): DataAdapters;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataAdaptersCollection) as DataAdapters;
end;

class function CoEmailAdapterObject.Create: EmailAdapter;
begin
  Result := CreateComObject(CLASS_EmailAdapterObject) as EmailAdapter;
end;

class function CoEmailAdapterObject.CreateRemote(const MachineName: string): EmailAdapter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_EmailAdapterObject) as EmailAdapter;
end;

class function CoDAVAdapterObject.Create: DAVAdapter;
begin
  Result := CreateComObject(CLASS_DAVAdapterObject) as DAVAdapter;
end;

class function CoDAVAdapterObject.CreateRemote(const MachineName: string): DAVAdapter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DAVAdapterObject) as DAVAdapter;
end;

class function CoHWSAdapterObject.Create: HWSAdapter;
begin
  Result := CreateComObject(CLASS_HWSAdapterObject) as HWSAdapter;
end;

class function CoHWSAdapterObject.CreateRemote(const MachineName: string): HWSAdapter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HWSAdapterObject) as HWSAdapter;
end;

class function CoSubmitToHostAdapterObject.Create: SubmitToHostAdapter;
begin
  Result := CreateComObject(CLASS_SubmitToHostAdapterObject) as SubmitToHostAdapter;
end;

class function CoSubmitToHostAdapterObject.CreateRemote(const MachineName: string): SubmitToHostAdapter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SubmitToHostAdapterObject) as SubmitToHostAdapter;
end;

class function CoSharepointListAdapterObject.Create: SharepointListAdapter;
begin
  Result := CreateComObject(CLASS_SharepointListAdapterObject) as SharepointListAdapter;
end;

class function CoSharepointListAdapterObject.CreateRemote(const MachineName: string): SharepointListAdapter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SharepointListAdapterObject) as SharepointListAdapter;
end;

class function CoXMLFileAdapterObject.Create: XMLFileAdapter2;
begin
  Result := CreateComObject(CLASS_XMLFileAdapterObject) as XMLFileAdapter2;
end;

class function CoXMLFileAdapterObject.CreateRemote(const MachineName: string): XMLFileAdapter2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_XMLFileAdapterObject) as XMLFileAdapter2;
end;

class function CoWebServiceAdapterObject.Create: WebServiceAdapter2;
begin
  Result := CreateComObject(CLASS_WebServiceAdapterObject) as WebServiceAdapter2;
end;

class function CoWebServiceAdapterObject.CreateRemote(const MachineName: string): WebServiceAdapter2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WebServiceAdapterObject) as WebServiceAdapter2;
end;

class function CoADOAdapterObject.Create: ADOAdapter2;
begin
  Result := CreateComObject(CLASS_ADOAdapterObject) as ADOAdapter2;
end;

class function CoADOAdapterObject.CreateRemote(const MachineName: string): ADOAdapter2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ADOAdapterObject) as ADOAdapter2;
end;

class function CoDocEventObject.Create: DocEvent;
begin
  Result := CreateComObject(CLASS_DocEventObject) as DocEvent;
end;

class function CoDocEventObject.CreateRemote(const MachineName: string): DocEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DocEventObject) as DocEvent;
end;

class function CoDocReturnEventObject.Create: DocReturnEvent;
begin
  Result := CreateComObject(CLASS_DocReturnEventObject) as DocReturnEvent;
end;

class function CoDocReturnEventObject.CreateRemote(const MachineName: string): DocReturnEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DocReturnEventObject) as DocReturnEvent;
end;

class function CoDocActionEventObject.Create: DocActionEvent;
begin
  Result := CreateComObject(CLASS_DocActionEventObject) as DocActionEvent;
end;

class function CoDocActionEventObject.CreateRemote(const MachineName: string): DocActionEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DocActionEventObject) as DocActionEvent;
end;

class function CoVersionUpgradeEventObject.Create: VersionUpgradeEvent;
begin
  Result := CreateComObject(CLASS_VersionUpgradeEventObject) as VersionUpgradeEvent;
end;

class function CoVersionUpgradeEventObject.CreateRemote(const MachineName: string): VersionUpgradeEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_VersionUpgradeEventObject) as VersionUpgradeEvent;
end;

class function CoDataDOMEventObject.Create: DataDOMEvent;
begin
  Result := CreateComObject(CLASS_DataDOMEventObject) as DataDOMEvent;
end;

class function CoDataDOMEventObject.CreateRemote(const MachineName: string): DataDOMEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataDOMEventObject) as DataDOMEvent;
end;

class function CoSolutionObject.Create: Solution;
begin
  Result := CreateComObject(CLASS_SolutionObject) as Solution;
end;

class function CoSolutionObject.CreateRemote(const MachineName: string): Solution;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SolutionObject) as Solution;
end;

class function CoWindowObject.Create: Window2;
begin
  Result := CreateComObject(CLASS_WindowObject) as Window2;
end;

class function CoWindowObject.CreateRemote(const MachineName: string): Window2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WindowObject) as Window2;
end;

class function CoWindowsCollection.Create: Windows;
begin
  Result := CreateComObject(CLASS_WindowsCollection) as Windows;
end;

class function CoWindowsCollection.CreateRemote(const MachineName: string): Windows;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_WindowsCollection) as Windows;
end;

class function CoTaskPanesCollection.Create: TaskPanes;
begin
  Result := CreateComObject(CLASS_TaskPanesCollection) as TaskPanes;
end;

class function CoTaskPanesCollection.CreateRemote(const MachineName: string): TaskPanes;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TaskPanesCollection) as TaskPanes;
end;

class function CoTaskPaneObject.Create: TaskPane;
begin
  Result := CreateComObject(CLASS_TaskPaneObject) as TaskPane;
end;

class function CoTaskPaneObject.CreateRemote(const MachineName: string): TaskPane;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_TaskPaneObject) as TaskPane;
end;

class function CoHTMLTaskPaneObject.Create: HTMLTaskPane;
begin
  Result := CreateComObject(CLASS_HTMLTaskPaneObject) as HTMLTaskPane;
end;

class function CoHTMLTaskPaneObject.CreateRemote(const MachineName: string): HTMLTaskPane;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HTMLTaskPaneObject) as HTMLTaskPane;
end;

class function CoViewObject.Create: View;
begin
  Result := CreateComObject(CLASS_ViewObject) as View;
end;

class function CoViewObject.CreateRemote(const MachineName: string): View;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ViewObject) as View;
end;

class function CoMailEnvelopeObject.Create: MailEnvelope;
begin
  Result := CreateComObject(CLASS_MailEnvelopeObject) as MailEnvelope;
end;

class function CoMailEnvelopeObject.CreateRemote(const MachineName: string): MailEnvelope;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MailEnvelopeObject) as MailEnvelope;
end;

class function CoXDocumentsCollection.Create: XDocuments2;
begin
  Result := CreateComObject(CLASS_XDocumentsCollection) as XDocuments2;
end;

class function CoXDocumentsCollection.CreateRemote(const MachineName: string): XDocuments2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_XDocumentsCollection) as XDocuments2;
end;

class function CoViewInfoObject.Create: ViewInfo;
begin
  Result := CreateComObject(CLASS_ViewInfoObject) as ViewInfo;
end;

class function CoViewInfoObject.CreateRemote(const MachineName: string): ViewInfo;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ViewInfoObject) as ViewInfo;
end;

class function CoViewInfosCollection.Create: ViewInfos;
begin
  Result := CreateComObject(CLASS_ViewInfosCollection) as ViewInfos;
end;

class function CoViewInfosCollection.CreateRemote(const MachineName: string): ViewInfos;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ViewInfosCollection) as ViewInfos;
end;

class function CoErrorObject.Create: Error;
begin
  Result := CreateComObject(CLASS_ErrorObject) as Error;
end;

class function CoErrorObject.CreateRemote(const MachineName: string): Error;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ErrorObject) as Error;
end;

class function CoErrorsCollection.Create: Errors;
begin
  Result := CreateComObject(CLASS_ErrorsCollection) as Errors;
end;

class function CoErrorsCollection.CreateRemote(const MachineName: string): Errors;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ErrorsCollection) as Errors;
end;

class function CoUtilObject.Create: Util;
begin
  Result := CreateComObject(CLASS_UtilObject) as Util;
end;

class function CoUtilObject.CreateRemote(const MachineName: string): Util;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UtilObject) as Util;
end;

class function CoMathObject.Create: IPMath;
begin
  Result := CreateComObject(CLASS_MathObject) as IPMath;
end;

class function CoMathObject.CreateRemote(const MachineName: string): IPMath;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MathObject) as IPMath;
end;

class function CoDateObject.Create: Date;
begin
  Result := CreateComObject(CLASS_DateObject) as Date;
end;

class function CoDateObject.CreateRemote(const MachineName: string): Date;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DateObject) as Date;
end;

class function CoSignedDataBlocksCollection.Create: SignedDataBlocks;
begin
  Result := CreateComObject(CLASS_SignedDataBlocksCollection) as SignedDataBlocks;
end;

class function CoSignedDataBlocksCollection.CreateRemote(const MachineName: string): SignedDataBlocks;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SignedDataBlocksCollection) as SignedDataBlocks;
end;

class function CoSignedDataBlockObject.Create: SignedDataBlock;
begin
  Result := CreateComObject(CLASS_SignedDataBlockObject) as SignedDataBlock;
end;

class function CoSignedDataBlockObject.CreateRemote(const MachineName: string): SignedDataBlock;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SignedDataBlockObject) as SignedDataBlock;
end;

class function CoSignaturesCollection.Create: Signatures;
begin
  Result := CreateComObject(CLASS_SignaturesCollection) as Signatures;
end;

class function CoSignaturesCollection.CreateRemote(const MachineName: string): Signatures;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SignaturesCollection) as Signatures;
end;

class function CoSignatureObject.Create: Signature;
begin
  Result := CreateComObject(CLASS_SignatureObject) as Signature;
end;

class function CoSignatureObject.CreateRemote(const MachineName: string): Signature;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SignatureObject) as Signature;
end;

class function CoCertificateObject.Create: Certificate;
begin
  Result := CreateComObject(CLASS_CertificateObject) as Certificate;
end;

class function CoCertificateObject.CreateRemote(const MachineName: string): Certificate;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CertificateObject) as Certificate;
end;

class function CoMergeEventObject.Create: MergeEvent;
begin
  Result := CreateComObject(CLASS_MergeEventObject) as MergeEvent;
end;

class function CoMergeEventObject.CreateRemote(const MachineName: string): MergeEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MergeEventObject) as MergeEvent;
end;

class function CoSaveEventObject.Create: SaveEvent;
begin
  Result := CreateComObject(CLASS_SaveEventObject) as SaveEvent;
end;

class function CoSaveEventObject.CreateRemote(const MachineName: string): SaveEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SaveEventObject) as SaveEvent;
end;

class function CoSignEventObject.Create: SignEvent;
begin
  Result := CreateComObject(CLASS_SignEventObject) as SignEvent;
end;

class function CoSignEventObject.CreateRemote(const MachineName: string): SignEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SignEventObject) as SignEvent;
end;

class function CoXMLNodesCollection.Create: XMLNodes;
begin
  Result := CreateComObject(CLASS_XMLNodesCollection) as XMLNodes;
end;

class function CoXMLNodesCollection.CreateRemote(const MachineName: string): XMLNodes;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_XMLNodesCollection) as XMLNodes;
end;

class function CoDataSourceObject.Create: DataObject;
begin
  Result := CreateComObject(CLASS_DataSourceObject) as DataObject;
end;

class function CoDataSourceObject.CreateRemote(const MachineName: string): DataObject;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataSourceObject) as DataObject;
end;

class function CoDataObjectsCollection.Create: DataObjects;
begin
  Result := CreateComObject(CLASS_DataObjectsCollection) as DataObjects;
end;

class function CoDataObjectsCollection.CreateRemote(const MachineName: string): DataObjects;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DataObjectsCollection) as DataObjects;
end;

class function CoDocContextChangeEventObject.Create: DocContextChangeEvent;
begin
  Result := CreateComObject(CLASS_DocContextChangeEventObject) as DocContextChangeEvent;
end;

class function CoDocContextChangeEventObject.CreateRemote(const MachineName: string): DocContextChangeEvent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DocContextChangeEventObject) as DocContextChangeEvent;
end;

class function CoUserObject.Create: User;
begin
  Result := CreateComObject(CLASS_UserObject) as User;
end;

class function CoUserObject.CreateRemote(const MachineName: string): User;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UserObject) as User;
end;

class function CoUserPermissionObject.Create: UserPermission;
begin
  Result := CreateComObject(CLASS_UserPermissionObject) as UserPermission;
end;

class function CoUserPermissionObject.CreateRemote(const MachineName: string): UserPermission;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UserPermissionObject) as UserPermission;
end;

class function CoPermissionObject.Create: Permission;
begin
  Result := CreateComObject(CLASS_PermissionObject) as Permission;
end;

class function CoPermissionObject.CreateRemote(const MachineName: string): Permission;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PermissionObject) as Permission;
end;

procedure TInfoPathEditorObject.InitControlData;
const
  CLicenseKey: array[0..15] of Word = ( $0049, $006E, $0066, $006F, $0050, $0061, $0074, $0068, $002E, $0045, $0064
    , $0069, $0074, $006F, $0072, $0000);
  CControlData: TControlData2 = (
    ClassID: '{80756399-5146-11D5-A672-00B0D022E945}';
    EventIID: '';
    EventCount: 0;
    EventDispIDs: nil;
    LicenseKey: @CLicenseKey;
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
end;

procedure TInfoPathEditorObject.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as InfoPathEditor;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TInfoPathEditorObject.GetControlInterface: InfoPathEditor;
begin
  CreateControl;
  Result := FIntf;
end;

function TInfoPathEditorObject.Get_XDocument(out ppXDocument: _XDocument): HResult;
begin
    Result := DefaultInterface.Get_XDocument(ppXDocument);
end;

function TInfoPathEditorObject.Get_Host(out ppdispHost: IDispatch): HResult;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Host;
end;

function TInfoPathEditorObject.Get_HostName(out pbstrHostName: WideString): HResult;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.HostName;
end;

function TInfoPathEditorObject.Get_DataConnectionBaseUrl(out pbstrDataConnectionBaseUrl: WideString): HResult;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.DataConnectionBaseUrl;
end;

function TInfoPathEditorObject.Load(const bstrURL: WideString): HResult;
begin
  Result := DefaultInterface.Load(bstrURL);
end;

function TInfoPathEditorObject.LoadFromStream(const punkStream: IUnknown): HResult;
begin
  Result := DefaultInterface.LoadFromStream(punkStream);
end;

function TInfoPathEditorObject.NewFromSolution(const bstrSolutionURI: WideString): HResult;
begin
  Result := DefaultInterface.NewFromSolution(bstrSolutionURI);
end;

function TInfoPathEditorObject.NewFromSolutionWithData(const bstrURLXSN: WideString; 
                                                       const punkStream: IUnknown; 
                                                       dwBehavior: Integer): HResult;
begin
  Result := DefaultInterface.NewFromSolutionWithData(bstrURLXSN, punkStream, dwBehavior);
end;

function TInfoPathEditorObject.SetSubmitToHostEventHandler(const pHandler: ISubmitToHostEventHandler): HResult;
begin
  Result := DefaultInterface.SetSubmitToHostEventHandler(pHandler);
end;

function TInfoPathEditorObject.SetInitEventHandler(const handler: IInitEventHandler): HResult;
begin
  Result := DefaultInterface.SetInitEventHandler(handler);
end;

function TInfoPathEditorObject.FlushDocument: HResult;
begin
  Result := DefaultInterface.FlushDocument;
end;

function TInfoPathEditorObject.CloseDocument: HResult;
begin
  Result := DefaultInterface.CloseDocument;
end;

function TInfoPathEditorObject.SetNotifyHostEventHandler(const pHandler: INotifyHostEventHandler): HResult;
begin
  Result := DefaultInterface.SetNotifyHostEventHandler(pHandler);
end;

class function CoInputParameterObject.Create: InputParameter;
begin
  Result := CreateComObject(CLASS_InputParameterObject) as InputParameter;
end;

class function CoInputParameterObject.CreateRemote(const MachineName: string): InputParameter;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_InputParameterObject) as InputParameter;
end;

class function CoInputParameterCollection.Create: InputParameters;
begin
  Result := CreateComObject(CLASS_InputParameterCollection) as InputParameters;
end;

class function CoInputParameterCollection.CreateRemote(const MachineName: string): InputParameters;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_InputParameterCollection) as InputParameters;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TInfoPathEditorObject]);
  RegisterComponents(dtlServerPage, [TApplication, TExternalApplication]);
end;

end.
