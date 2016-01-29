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

unit FrontPageEditor2000;

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

// PASTLWTR : $Revision: 1.1 $
// File generated on 13.01.2003 00:03:33 from Type Library described below.

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
// ************************************************************************ //
// Type Lib: F:\PROGRA~1\MICROS~2\Office\FPEDITAX.DLL (1)
// IID\LCID: {7577AE81-4416-11CE-9C34-524153480000}\0
// Helpfile: F:\PROGRA~1\MICROS~2\Office\VBAFPOM4.CHM
// DepndLst:
//   (1) v2.0 stdole, (F:\WINDOWS\system32\stdole2.tlb)
// Parent TypeLibrary:
//   (0) v1.0 FrontPage, (F:\Program Files\Microsoft Office\Office\frontpg.exe)
// Errors:
//   Hint: Parameter 'String' of IHTMLDocument2.toString changed to 'String_'
//   Hint: Parameter 'String' of IHTMLElementCollection.toString changed to 'String_'
//   Hint: Parameter 'String' of IHTMLElement.toString changed to 'String_'
//   Hint: Parameter 'String' of IHTMLStyle.toString changed to 'String_'
//   Hint: Member 'type' of 'IHTMLSelectionObject' changed to 'type_'
//   Hint: Symbol 'assign' renamed to 'Assign_'
//   Hint: Parameter 'String' of IHTMLLocation.toString changed to 'String_'
//   Hint: Parameter 'String' of IHTMLWindow2.toString changed to 'String_'
//   Hint: Parameter 'String' of IOmNavigator.toString changed to 'String_'
//   Hint: Member 'type' of 'IHTMLEventObj' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLStyleSheet' changed to 'type_'
//   Hint: Parameter 'Unit' of IHTMLTxtRange.expand changed to 'Unit_'
//   Hint: Parameter 'Unit' of IHTMLTxtRange.Move changed to 'Unit_'
//   Hint: Parameter 'Unit' of IHTMLTxtRange.moveStart changed to 'Unit_'
//   Hint: Parameter 'Unit' of IHTMLTxtRange.moveEnd changed to 'Unit_'
//   Hint: Parameter 'String' of IHTMLTxtRange.FindText changed to 'String_'
//   Hint: Member 'type' of 'DispIHTMLLinkElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLLinkElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLInputImage' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLInputImage' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLUListElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLUListElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLOListElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLOListElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLLIElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLLIElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLSelectElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLSelectElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLInputTextElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLInputTextElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLTextAreaElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLTextAreaElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLInputButtonElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLInputButtonElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLInputHiddenElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLButtonElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLButtonElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLInputFileElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLInputFileElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLOptionButtonElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLOptionButtonElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLScriptElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLScriptElement' changed to 'type_'
//   Hint: Member 'object' of 'DispIHTMLObjectElement' changed to 'object_'
//   Hint: Member 'type' of 'DispIHTMLObjectElement' changed to 'type_'
//   Hint: Member 'object' of 'IHTMLObjectElement' changed to 'object_'
//   Hint: Member 'type' of 'IHTMLObjectElement' changed to 'type_'
//   Hint: Member 'type' of 'DispIHTMLStyleElement' changed to 'type_'
//   Hint: Member 'type' of 'IHTMLStyleElement' changed to 'type_'
//   Hint: Parameter 'String' of IHTMLDialog.toString changed to 'String_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.

{$I adxDefs.inc}

interface

uses Windows, ActiveX, Classes, Graphics, OleServer, OleCtrls, StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  FrontPageEditorMajorVersion = 2;
  FrontPageEditorMinorVersion = 0;

  LIBID_FrontPageEditor: TGUID = '{7577AE81-4416-11CE-9C34-524153480000}';

  DIID_IWPEDoc: TGUID = '{8BBD4A7A-661D-11CF-A3C4-00A024184692}';
  CLASS_CWPEDoc: TGUID = '{31B4599A-FFA3-11CF-B35E-00A0C90A9044}';
  DIID_IPageEditorInternal: TGUID = '{D603F1EF-2632-11D2-AD10-00C04F795285}';
  CLASS_CAutoJackInteral: TGUID = '{D603F1F0-2632-11D2-AD10-00C04F795285}';
  IID_IURLPicker: TGUID = '{12428687-A9D9-11CF-8904-00AA00BDCB98}';
  CLASS_URLPicker: TGUID = '{531173B2-FC78-11D0-8029-0060977B463D}';
  IID_IHTMLColorPicker: TGUID = '{533AC2A3-1ACE-11D1-A787-0000F80272EA}';
  CLASS_HTMLColorPicker: TGUID = '{4604FDF0-EAD7-11D1-BE1A-006008C3FEBE}';
  CLASS_FPAxTagPage: TGUID = '{A0234992-6CC4-11D1-B3B2-0060977B463D}';
  CLASS_FPAxParamsPage: TGUID = '{A0234993-6CC4-11D1-B3B2-0060977B463D}';
  IID_IDTCExtendedServices: TGUID = '{6FF02AB1-809B-11D1-9D27-006008058731}';
  IID_IIdleWorker: TGUID = '{3A82F170-4C49-11D2-BE5D-006008C3FEBE}';
  IID_IChServ: TGUID = '{E047F690-D314-11D1-BDF8-006008C3FEBE}';
  CLASS_ChServ: TGUID = '{E047F691-D314-11D1-BDF8-006008C3FEBE}';
  IID_ICagNotifySink: TGUID = '{9B9168CF-9DA0-11D1-A89A-00C04FB92C8F}';
  IID_IFPEditorControl: TGUID = '{0E5EDCEF-9F3B-11D1-B3C3-0060977B463D}';
  DIID__DFPEditorControlEvents: TGUID = '{F27C78D0-9F63-11D1-B3C3-0060977B463D}';
  CLASS_FPEditorControl: TGUID = '{0E5EDCF0-9F3B-11D1-B3C3-0060977B463D}';
  IID_IFPMarkupPointer: TGUID = '{3050F49F-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLDocument: TGUID = '{626FC520-A41E-11CF-A731-00A0C9082637}';
  IID_IHTMLDocument2: TGUID = '{332C4425-26CB-11D0-B483-00C04FD90119}';
  IID_IHTMLElementCollection: TGUID = '{3050F21F-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLElement: TGUID = '{3050F1FF-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLStyle: TGUID = '{3050F25E-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLFiltersCollection: TGUID = '{3050F3EE-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLSelectionObject: TGUID = '{3050F25A-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLFramesCollection2: TGUID = '{332C4426-26CB-11D0-B483-00C04FD90119}';
  IID_IHTMLLocation: TGUID = '{163BB1E0-6E00-11CF-837A-48DC04C10000}';
  IID_IHTMLWindow2: TGUID = '{332C4427-26CB-11D0-B483-00C04FD90119}';
  IID_IHTMLImageElementFactory: TGUID = '{3050F38E-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLImgElement: TGUID = '{3050F240-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IOmHistory: TGUID = '{FECEAAA2-8405-11CF-8BA1-00AA00476DA6}';
  IID_IOmNavigator: TGUID = '{FECEAAA5-8405-11CF-8BA1-00AA00476DA6}';
  IID_IHTMLMimeTypesCollection: TGUID = '{3050F3FC-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLPluginsCollection: TGUID = '{3050F3FD-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLOpsProfile: TGUID = '{3050F401-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLEventObj: TGUID = '{3050F32D-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLScreen: TGUID = '{3050F35C-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLOptionElementFactory: TGUID = '{3050F38C-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLOptionElement: TGUID = '{3050F211-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLFormElement: TGUID = '{3050F1F7-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLStyleSheetsCollection: TGUID = '{3050F37E-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLStyleSheet: TGUID = '{3050F2E3-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLStyleSheetRulesCollection: TGUID = '{3050F2E5-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLStyleSheetRule: TGUID = '{3050F357-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLRuleStyle: TGUID = '{3050F3CF-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IFPMarkupContainer: TGUID = '{3050F56E-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IFPMarkupServices: TGUID = '{3050F4A0-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTxtRange: TGUID = '{3050F220-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IFPDocument: TGUID = '{C86A1A00-FAA6-11D1-B3ED-0060977B463D}';
  IID_IFPHTMLUndoTransaction: TGUID = '{C86A1A01-FAA6-11D1-B3ED-0060977B463D}';
  CLASS_FPHTMLUndoTransaction: TGUID = '{C86A1A04-FAA6-11D1-B3ED-0060977B463D}';
  IID_IFrontPageHostedControl: TGUID = '{5497064A-5CF4-11D2-AD3E-00C04F795285}';
  DIID_DispFPHTMLDocument: TGUID = '{CD6F2F18-030B-11D2-B3F0-0060977B463D}';
  DIID_HTMLDocumentEvents: TGUID = '{3050F260-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLDocument: TGUID = '{AE464946-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLStyle: TGUID = '{AE464910-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLFiltersCollection: TGUID = '{AE464911-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLStyleSheet: TGUID = '{AE464912-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLStyleSheetsCollection: TGUID = '{AE464913-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLLinkElement: TGUID = '{3050F524-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLLinkElementEvents: TGUID = '{3050F3CC-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLLinkElement: TGUID = '{3050F205-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLLinkElement: TGUID = '{AE464914-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLFormElement: TGUID = '{3050F510-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLFormElementEvents: TGUID = '{3050F364-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLFormElement: TGUID = '{AE464915-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLTextElement: TGUID = '{3050F537-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLElementEvents: TGUID = '{3050F33C-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTextElement: TGUID = '{3050F218-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLTextElement: TGUID = '{AE464916-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLImgElement: TGUID = '{3050F51C-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLImgEvents: TGUID = '{3050F25B-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLControlElement: TGUID = '{04598FC6-866C-11CF-AB7C-00AA00C08FCF}';
  IID_IHTMLDatabinding: TGUID = '{3050F3F2-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLImg: TGUID = '{AE464917-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLInputImage: TGUID = '{3050F51D-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLInputImageEvents: TGUID = '{3050F2C3-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLInputImage: TGUID = '{3050F2C2-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLInputImage: TGUID = '{AE464918-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLImageElementFactory: TGUID = '{AE46491A-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLBodyElement: TGUID = '{3050F507-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLTextContainerEvents: TGUID = '{1FF6AA72-5842-11CF-A707-00AA00C0098D}';
  IID_IHTMLBodyElement: TGUID = '{3050F1D8-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTextContainer: TGUID = '{3050F230-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLBody: TGUID = '{AE46491B-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLFontElement: TGUID = '{3050F512-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLFontElement: TGUID = '{3050F1D9-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLFontElement: TGUID = '{AE46491C-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLAnchorElement: TGUID = '{3050F502-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLAnchorEvents: TGUID = '{3050F29D-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLAnchorElement: TGUID = '{3050F1DA-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLAnchorElement: TGUID = '{AE46491D-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLLabelElement: TGUID = '{3050F522-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLLabelEvents: TGUID = '{3050F329-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLLabelElement: TGUID = '{3050F32A-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLLabelElement: TGUID = '{AE46491E-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLListElement: TGUID = '{3050F525-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLListElement: TGUID = '{3050F20E-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLListElement: TGUID = '{AE46491F-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLUListElement: TGUID = '{3050F538-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLUListElement: TGUID = '{3050F1DD-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLUListElement: TGUID = '{AE464920-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLOListElement: TGUID = '{3050F52A-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLOListElement: TGUID = '{3050F1DE-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLOListElement: TGUID = '{AE464921-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLLIElement: TGUID = '{3050F523-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLLIElement: TGUID = '{3050F1E0-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLLIElement: TGUID = '{AE464922-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLBlockElement: TGUID = '{3050F506-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLBlockElement: TGUID = '{3050F208-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLBlockElement: TGUID = '{AE464923-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLDivElement: TGUID = '{3050F50C-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLDivElement: TGUID = '{3050F200-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLDivElement: TGUID = '{AE464924-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLDDElement: TGUID = '{3050F50B-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLDDElement: TGUID = '{3050F1F2-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLDDElement: TGUID = '{AE464925-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLDTElement: TGUID = '{3050F50D-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLDTElement: TGUID = '{3050F1F3-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLDTElement: TGUID = '{AE464926-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLBRElement: TGUID = '{3050F53A-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLBRElement: TGUID = '{3050F1F0-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLBRElement: TGUID = '{AE464927-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLDListElement: TGUID = '{3050F53B-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLDListElement: TGUID = '{3050F1F1-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLDListElement: TGUID = '{AE464928-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLHRElement: TGUID = '{3050F53D-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLHRElement: TGUID = '{3050F1F4-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLHRElement: TGUID = '{AE464929-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLParaElement: TGUID = '{3050F52C-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLParaElement: TGUID = '{3050F1F5-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLParaElement: TGUID = '{AE46492A-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLHeaderElement: TGUID = '{3050F515-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLHeaderElement: TGUID = '{3050F1F6-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLHeaderElement: TGUID = '{AE46492B-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLSelectElement: TGUID = '{3050F531-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLSelectElementEvents: TGUID = '{3050F302-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLSelectElement: TGUID = '{3050F244-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLSelectElement: TGUID = '{AE46492C-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLOptionElement: TGUID = '{3050F52B-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLOptionElement: TGUID = '{AE46492D-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLOptionElementFactory: TGUID = '{AE46492E-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLInputTextElement: TGUID = '{3050F520-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLInputTextElementEvents: TGUID = '{3050F2A7-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLInputTextElement: TGUID = '{3050F2A6-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLInputTextElement: TGUID = '{AE46492F-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLTextAreaElement: TGUID = '{3050F521-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTextAreaElement: TGUID = '{3050F2AA-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLTextAreaElement: TGUID = '{AE464930-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLInputButtonElement: TGUID = '{3050F51E-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLButtonElementEvents: TGUID = '{3050F2B3-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLInputButtonElement: TGUID = '{3050F2B2-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLInputButtonElement: TGUID = '{AE464931-8B76-11D1-B3BD-0060977B463D}';
  IID_IHTMLInputHiddenElement: TGUID = '{3050F2A4-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLInputHiddenElement: TGUID = '{05F1AF20-4106-11D2-AD1E-00C04F795285}';
  DIID_DispIHTMLButtonElement: TGUID = '{3050F51F-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLButtonElement: TGUID = '{3050F2BB-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLButtonElement: TGUID = '{AE464932-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLInputFileElement: TGUID = '{3050F542-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLInputFileElementEvents: TGUID = '{3050F2AF-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLInputFileElement: TGUID = '{3050F2AD-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLInputFileElement: TGUID = '{AE464933-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLMarqueeElement: TGUID = '{3050F527-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLMarqueeElementEvents: TGUID = '{3050F2B8-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLMarqueeElement: TGUID = '{3050F2B5-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLMarqueeElement: TGUID = '{AE464934-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLOptionButtonElement: TGUID = '{3050F509-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLOptionButtonElementEvents: TGUID = '{3050F2BD-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLOptionButtonElement: TGUID = '{3050F2BC-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLOptionButtonElement: TGUID = '{AE464935-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLTitleElement: TGUID = '{3050F516-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTitleElement: TGUID = '{3050F322-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLTitleElement: TGUID = '{AE464936-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLMetaElement: TGUID = '{3050F517-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLMetaElement: TGUID = '{3050F203-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLMetaElement: TGUID = '{AE464937-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLBaseElement: TGUID = '{3050F518-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLBaseElement: TGUID = '{3050F204-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLBaseElement: TGUID = '{AE464938-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLIsIndexElement: TGUID = '{3050F519-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLIsIndexElement: TGUID = '{3050F206-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLIsIndexElement: TGUID = '{AE464939-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLNextIdElement: TGUID = '{3050F51A-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLNextIdElement: TGUID = '{3050F207-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLNextIdElement: TGUID = '{AE46493A-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLBaseFontElement: TGUID = '{3050F504-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLBaseFontElement: TGUID = '{3050F202-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLBaseFontElement: TGUID = '{AE46493B-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLUnknownElement: TGUID = '{3050F539-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLUnknownElement: TGUID = '{3050F209-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLUnknownElement: TGUID = '{AE46493C-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLHistory: TGUID = '{AE46493D-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLCMimeTypes: TGUID = '{AE46493E-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLCPlugins: TGUID = '{AE46493F-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLCOpsProfile: TGUID = '{AE464940-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLNavigator: TGUID = '{AE464941-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLLocation: TGUID = '{AE464942-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLScreen: TGUID = '{AE464943-8B76-11D1-B3BD-0060977B463D}';
  DIID_HTMLWindowEvents: TGUID = '{96A0A4E0-D062-11CF-94B6-00AA0060275C}';
  CLASS_FPHTMLWindow2: TGUID = '{AE464944-8B76-11D1-B3BD-0060977B463D}';
  CLASS_FPHTMLWindowProxy: TGUID = '{AE464945-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLEmbedElement: TGUID = '{3050F52E-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLControlElementEvents: TGUID = '{9A4BBF53-4E46-101B-8BBD-00AA003E3B29}';
  IID_IHTMLEmbedElement: TGUID = '{3050F25F-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLEmbed: TGUID = '{AE464947-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLMapElement: TGUID = '{3050F526-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLMapEvents: TGUID = '{3050F3BA-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLAreasCollection: TGUID = '{3050F383-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLMapElement: TGUID = '{3050F266-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLMapElement: TGUID = '{AE464948-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLAreaElement: TGUID = '{3050F503-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLAreaEvents: TGUID = '{3050F366-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLAreaElement: TGUID = '{3050F265-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLAreaElement: TGUID = '{AE464949-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLTableCaption: TGUID = '{3050F508-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTableCaption: TGUID = '{3050F2EB-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLTableCaption: TGUID = '{AE46494A-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLCommentElement: TGUID = '{3050F50A-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLCommentElement: TGUID = '{3050F20C-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLCommentElement: TGUID = '{AE46494B-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLPhraseElement: TGUID = '{3050F52D-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLPhraseElement: TGUID = '{3050F20A-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLPhraseElement: TGUID = '{AE46494C-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLSpanElement: TGUID = '{3050F548-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLSpanElement: TGUID = '{3050F3F3-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLSpanElement: TGUID = '{AE46494D-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLTable: TGUID = '{3050F532-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLTableEvents: TGUID = '{3050F407-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTableSection: TGUID = '{3050F23B-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTable: TGUID = '{3050F21E-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLTable: TGUID = '{AE46494E-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLTableCol: TGUID = '{3050F533-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTableCol: TGUID = '{3050F23A-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLTableCol: TGUID = '{AE46494F-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLTableSection: TGUID = '{3050F534-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLTableSection: TGUID = '{AE464950-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLTableRow: TGUID = '{3050F535-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTableRow: TGUID = '{3050F23C-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTableRowMetrics: TGUID = '{3050F413-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLTableRow: TGUID = '{AE464951-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLTableCell: TGUID = '{3050F536-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLTableCell: TGUID = '{3050F23D-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLTableCell: TGUID = '{AE464952-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLScriptElement: TGUID = '{3050F530-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLScriptEvents: TGUID = '{3050F3E2-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLScriptElement: TGUID = '{3050F28B-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLScriptElement: TGUID = '{AE464953-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLNoShowElement: TGUID = '{3050F528-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLNoShowElement: TGUID = '{3050F38A-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLNoShowElement: TGUID = '{AE464954-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLObjectElement: TGUID = '{3050F529-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLObjectElementEvents: TGUID = '{3050F3C4-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLObjectElement: TGUID = '{3050F24F-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLObjectElement: TGUID = '{AE464955-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLFrameBase: TGUID = '{3050F541-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLFrameBase: TGUID = '{3050F311-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLFrameBase: TGUID = '{AE464956-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLFrameElement: TGUID = '{3050F513-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLFrameElement: TGUID = '{3050F313-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLFrameElement: TGUID = '{AE464957-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLIFrameElement: TGUID = '{3050F51B-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLIFrameElement: TGUID = '{3050F315-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLIFrame: TGUID = '{AE464958-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLDivPosition: TGUID = '{3050F50F-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLDivPosition: TGUID = '{3050F212-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLDivPosition: TGUID = '{AE464959-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLFieldSetElement: TGUID = '{3050F545-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLFieldSetElement: TGUID = '{3050F3E7-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLFieldSetElement: TGUID = '{AE46495A-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLLegendElement: TGUID = '{3050F546-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLLegendElement: TGUID = '{3050F3EA-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLLegendElement: TGUID = '{AE46495B-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLSpanFlow: TGUID = '{3050F544-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLSpanFlow: TGUID = '{3050F3E5-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLSpanFlow: TGUID = '{AE46495C-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLFrameSetElement: TGUID = '{3050F514-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLFrameSetElement: TGUID = '{3050F319-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLFrameSetSite: TGUID = '{AE46495D-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLBGsound: TGUID = '{3050F53C-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLBGsound: TGUID = '{3050F369-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLBGsound: TGUID = '{AE46495E-8B76-11D1-B3BD-0060977B463D}';
  DIID_DispIHTMLStyleElement: TGUID = '{3050F511-98B5-11CF-BB82-00AA00BDCE0B}';
  DIID_HTMLStyleElementEvents: TGUID = '{3050F3CB-98B5-11CF-BB82-00AA00BDCE0B}';
  IID_IHTMLStyleElement: TGUID = '{3050F375-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLStyleElement: TGUID = '{AE46495F-8B76-11D1-B3BD-0060977B463D}';
  IID_IHTMLStyleFontFace: TGUID = '{3050F3D5-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLStyleFontFace: TGUID = '{AE464960-8B76-11D1-B3BD-0060977B463D}';
  IID_IHTMLDialog: TGUID = '{3050F216-98B5-11CF-BB82-00AA00BDCE0B}';
  CLASS_FPHTMLDialog: TGUID = '{AE464961-8B76-11D1-B3BD-0060977B463D}';
  IID_IHTMLFrontPageBotElement: TGUID = '{83DB5580-E05A-11D1-B3E1-0060977B463D}';
  DIID_DispIHTMLFrontPageBotElement: TGUID = '{83DB5581-E05A-11D1-B3E1-0060977B463D}';
  CLASS_FPHTMLFrontPageBotElement: TGUID = '{940CDFB0-E059-11D1-B3E1-0060977B463D}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library
// *********************************************************************//
// Constants for enum tagREADYSTATE
type
  tagREADYSTATE = TOleEnum;
const
  READYSTATE_UNINITIALIZED = $00000000;
  READYSTATE_LOADING = $00000001;
  READYSTATE_LOADED = $00000002;
  READYSTATE_INTERACTIVE = $00000003;
  READYSTATE_COMPLETE = $00000004;

// Constants for enum __MIDL___MIDL_itf_WPE_0409_0001
type
  __MIDL___MIDL_itf_WPE_0409_0001 = TOleEnum;
const
  POINTER_GRAVITY_Left = $00000000;
  POINTER_GRAVITY_Right = $00000001;

// Constants for enum __MIDL___MIDL_itf_WPE_0409_0002
type
  __MIDL___MIDL_itf_WPE_0409_0002 = TOleEnum;
const
  ELEM_ADJ_BeforeBegin = $00000000;
  ELEM_ADJ_AfterBegin = $00000001;
  ELEM_ADJ_BeforeEnd = $00000002;
  ELEM_ADJ_AfterEnd = $00000003;

// Constants for enum __MIDL___MIDL_itf_WPE_0409_0003
type
  __MIDL___MIDL_itf_WPE_0409_0003 = TOleEnum;
const
  CONTEXT_TYPE_None = $00000000;
  CONTEXT_TYPE_Text = $00000001;
  CONTEXT_TYPE_EnterScope = $00000002;
  CONTEXT_TYPE_ExitScope = $00000003;
  CONTEXT_TYPE_NoScope = $00000004;

// Constants for enum __MIDL___MIDL_itf_WPE_0409_0004
type
  __MIDL___MIDL_itf_WPE_0409_0004 = TOleEnum;
const
  FINDTEXT_DOWN = $00000001;
  FINDTEXT_WHOLEWORD = $00000002;
  FINDTEXT_MATCHCASE = $00000004;

// Constants for enum __MIDL___MIDL_itf_WPE_0409_0005
type
  __MIDL___MIDL_itf_WPE_0409_0005 = TOleEnum;
const
  TAGID_NULL = $00000000;
  TAGID_UNKNOWN = $00000001;
  TAGID_A = $00000002;
  TAGID_ACRONYM = $00000003;
  TAGID_ADDRESS = $00000004;
  TAGID_APPLET = $00000005;
  TAGID_AREA = $00000006;
  TAGID_B = $00000007;
  TAGID_BASE = $00000008;
  TAGID_BASEFONT = $00000009;
  TAGID_BDO = $0000000A;
  TAGID_BGSOUND = $0000000B;
  TAGID_BIG = $0000000C;
  TAGID_BLINK = $0000000D;
  TAGID_BLOCKQUOTE = $0000000E;
  TAGID_BODY = $0000000F;
  TAGID_BR = $00000010;
  TAGID_BUTTON = $00000011;
  TAGID_CAPTION = $00000012;
  TAGID_CENTER = $00000013;
  TAGID_CITE = $00000014;
  TAGID_CODE = $00000015;
  TAGID_COL = $00000016;
  TAGID_COLGROUP = $00000017;
  TAGID_COMMENT = $00000018;
  TAGID_DD = $00000019;
  TAGID_DEL = $0000001A;
  TAGID_DFN = $0000001B;
  TAGID_DIR = $0000001C;
  TAGID_DIV = $0000001D;
  TAGID_DL = $0000001E;
  TAGID_DT = $0000001F;
  TAGID_EM = $00000020;
  TAGID_EMBED = $00000021;
  TAGID_EVENT = $00000022;
  TAGID_FIELDSET = $00000023;
  TAGID_FONT = $00000024;
  TAGID_FORM = $00000025;
  TAGID_FRAME = $00000026;
  TAGID_FRAMESET = $00000027;
  TAGID_H1 = $00000028;
  TAGID_H2 = $00000029;
  TAGID_H3 = $0000002A;
  TAGID_H4 = $0000002B;
  TAGID_H5 = $0000002C;
  TAGID_H6 = $0000002D;
  TAGID_HEAD = $0000002E;
  TAGID_HR = $0000002F;
  TAGID_HTML = $00000030;
  TAGID_I = $00000031;
  TAGID_IFRAME = $00000032;
  TAGID_IMG = $00000033;
  TAGID_INPUT = $00000034;
  TAGID_INS = $00000035;
  TAGID_ISINDEX = $00000036;
  TAGID_KBD = $00000037;
  TAGID_LABEL = $00000038;
  TAGID_LEGEND = $00000039;
  TAGID_LI = $0000003A;
  TAGID_LINK = $0000003B;
  TAGID_LISTING = $0000003C;
  TAGID_MAP = $0000003D;
  TAGID_MARQUEE = $0000003E;
  TAGID_MENU = $0000003F;
  TAGID_META = $00000040;
  TAGID_NEXTID = $00000041;
  TAGID_NOBR = $00000042;
  TAGID_NOEMBED = $00000043;
  TAGID_NOFRAMES = $00000044;
  TAGID_NOSCRIPT = $00000045;
  TAGID_OBJECT = $00000046;
  TAGID_OL = $00000047;
  TAGID_OPTION = $00000048;
  TAGID_P = $00000049;
  TAGID_PARAM = $0000004A;
  TAGID_PLAINTEXT = $0000004B;
  TAGID_PRE = $0000004C;
  TAGID_Q = $0000004D;
  TAGID_HTMLAREA = $0000004E;
  TAGID_S = $0000004F;
  TAGID_SAMP = $00000050;
  TAGID_SCRIPT = $00000051;
  TAGID_SELECT = $00000052;
  TAGID_SMALL = $00000053;
  TAGID_SPAN = $00000054;
  TAGID_STRIKE = $00000055;
  TAGID_STRONG = $00000056;
  TAGID_STYLE = $00000057;
  TAGID_SUB = $00000058;
  TAGID_SUP = $00000059;
  TAGID_TABLE = $0000005A;
  TAGID_TBODY = $0000005B;
  TAGID_TD = $0000005C;
  TAGID_TEXTAREA = $0000005D;
  TAGID_TFOOT = $0000005E;
  TAGID_TH = $0000005F;
  TAGID_THEAD = $00000060;
  TAGID_TITLE = $00000061;
  TAGID_TR = $00000062;
  TAGID_TT = $00000063;
  TAGID_U = $00000064;
  TAGID_UL = $00000065;
  TAGID_VAR = $00000066;
  TAGID_WBR = $00000067;
  TAGID_XMP = $00000068;
  TAGID_LAST_PREDEFINED = $00002710;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IWPEDoc = dispinterface;
  IPageEditorInternal = dispinterface;
  IURLPicker = interface;
  IURLPickerDisp = dispinterface;
  IHTMLColorPicker = interface;
  IHTMLColorPickerDisp = dispinterface;
  IDTCExtendedServices = interface;
  IIdleWorker = interface;
  IChServ = interface;
  IChServDisp = dispinterface;
  ICagNotifySink = interface;
  ICagNotifySinkDisp = dispinterface;
  IFPEditorControl = interface;
  IFPEditorControlDisp = dispinterface;
  _DFPEditorControlEvents = dispinterface;
  IFPMarkupPointer = interface;
  IFPMarkupPointerDisp = dispinterface;
  IHTMLDocument = interface;
  IHTMLDocumentDisp = dispinterface;
  IHTMLDocument2 = interface;
  IHTMLDocument2Disp = dispinterface;
  IHTMLElementCollection = interface;
  IHTMLElementCollectionDisp = dispinterface;
  IHTMLElement = interface;
  IHTMLElementDisp = dispinterface;
  IHTMLStyle = interface;
  IHTMLStyleDisp = dispinterface;
  IHTMLFiltersCollection = interface;
  IHTMLFiltersCollectionDisp = dispinterface;
  IHTMLSelectionObject = interface;
  IHTMLSelectionObjectDisp = dispinterface;
  IHTMLFramesCollection2 = interface;
  IHTMLFramesCollection2Disp = dispinterface;
  IHTMLLocation = interface;
  IHTMLLocationDisp = dispinterface;
  IHTMLWindow2 = interface;
  IHTMLWindow2Disp = dispinterface;
  IHTMLImageElementFactory = interface;
  IHTMLImageElementFactoryDisp = dispinterface;
  IHTMLImgElement = interface;
  IHTMLImgElementDisp = dispinterface;
  IOmHistory = interface;
  IOmHistoryDisp = dispinterface;
  IOmNavigator = interface;
  IOmNavigatorDisp = dispinterface;
  IHTMLMimeTypesCollection = interface;
  IHTMLMimeTypesCollectionDisp = dispinterface;
  IHTMLPluginsCollection = interface;
  IHTMLPluginsCollectionDisp = dispinterface;
  IHTMLOpsProfile = interface;
  IHTMLOpsProfileDisp = dispinterface;
  IHTMLEventObj = interface;
  IHTMLEventObjDisp = dispinterface;
  IHTMLScreen = interface;
  IHTMLScreenDisp = dispinterface;
  IHTMLOptionElementFactory = interface;
  IHTMLOptionElementFactoryDisp = dispinterface;
  IHTMLOptionElement = interface;
  IHTMLOptionElementDisp = dispinterface;
  IHTMLFormElement = interface;
  IHTMLFormElementDisp = dispinterface;
  IHTMLStyleSheetsCollection = interface;
  IHTMLStyleSheetsCollectionDisp = dispinterface;
  IHTMLStyleSheet = interface;
  IHTMLStyleSheetDisp = dispinterface;
  IHTMLStyleSheetRulesCollection = interface;
  IHTMLStyleSheetRulesCollectionDisp = dispinterface;
  IHTMLStyleSheetRule = interface;
  IHTMLStyleSheetRuleDisp = dispinterface;
  IHTMLRuleStyle = interface;
  IHTMLRuleStyleDisp = dispinterface;
  IFPMarkupContainer = interface;
  IFPMarkupContainerDisp = dispinterface;
  IFPMarkupServices = interface;
  IFPMarkupServicesDisp = dispinterface;
  IHTMLTxtRange = interface;
  IHTMLTxtRangeDisp = dispinterface;
  IFPDocument = interface;
  IFPDocumentDisp = dispinterface;
  IFPHTMLUndoTransaction = interface;
  IFPHTMLUndoTransactionDisp = dispinterface;
  IFrontPageHostedControl = interface;
  DispFPHTMLDocument = dispinterface;
  HTMLDocumentEvents = dispinterface;
  DispIHTMLLinkElement = dispinterface;
  HTMLLinkElementEvents = dispinterface;
  IHTMLLinkElement = interface;
  IHTMLLinkElementDisp = dispinterface;
  DispIHTMLFormElement = dispinterface;
  HTMLFormElementEvents = dispinterface;
  DispIHTMLTextElement = dispinterface;
  HTMLElementEvents = dispinterface;
  IHTMLTextElement = interface;
  IHTMLTextElementDisp = dispinterface;
  DispIHTMLImgElement = dispinterface;
  HTMLImgEvents = dispinterface;
  IHTMLControlElement = interface;
  IHTMLControlElementDisp = dispinterface;
  IHTMLDatabinding = interface;
  IHTMLDatabindingDisp = dispinterface;
  DispIHTMLInputImage = dispinterface;
  HTMLInputImageEvents = dispinterface;
  IHTMLInputImage = interface;
  IHTMLInputImageDisp = dispinterface;
  DispIHTMLBodyElement = dispinterface;
  HTMLTextContainerEvents = dispinterface;
  IHTMLBodyElement = interface;
  IHTMLBodyElementDisp = dispinterface;
  IHTMLTextContainer = interface;
  IHTMLTextContainerDisp = dispinterface;
  DispIHTMLFontElement = dispinterface;
  IHTMLFontElement = interface;
  IHTMLFontElementDisp = dispinterface;
  DispIHTMLAnchorElement = dispinterface;
  HTMLAnchorEvents = dispinterface;
  IHTMLAnchorElement = interface;
  IHTMLAnchorElementDisp = dispinterface;
  DispIHTMLLabelElement = dispinterface;
  HTMLLabelEvents = dispinterface;
  IHTMLLabelElement = interface;
  IHTMLLabelElementDisp = dispinterface;
  DispIHTMLListElement = dispinterface;
  IHTMLListElement = interface;
  IHTMLListElementDisp = dispinterface;
  DispIHTMLUListElement = dispinterface;
  IHTMLUListElement = interface;
  IHTMLUListElementDisp = dispinterface;
  DispIHTMLOListElement = dispinterface;
  IHTMLOListElement = interface;
  IHTMLOListElementDisp = dispinterface;
  DispIHTMLLIElement = dispinterface;
  IHTMLLIElement = interface;
  IHTMLLIElementDisp = dispinterface;
  DispIHTMLBlockElement = dispinterface;
  IHTMLBlockElement = interface;
  IHTMLBlockElementDisp = dispinterface;
  DispIHTMLDivElement = dispinterface;
  IHTMLDivElement = interface;
  IHTMLDivElementDisp = dispinterface;
  DispIHTMLDDElement = dispinterface;
  IHTMLDDElement = interface;
  IHTMLDDElementDisp = dispinterface;
  DispIHTMLDTElement = dispinterface;
  IHTMLDTElement = interface;
  IHTMLDTElementDisp = dispinterface;
  DispIHTMLBRElement = dispinterface;
  IHTMLBRElement = interface;
  IHTMLBRElementDisp = dispinterface;
  DispIHTMLDListElement = dispinterface;
  IHTMLDListElement = interface;
  IHTMLDListElementDisp = dispinterface;
  DispIHTMLHRElement = dispinterface;
  IHTMLHRElement = interface;
  IHTMLHRElementDisp = dispinterface;
  DispIHTMLParaElement = dispinterface;
  IHTMLParaElement = interface;
  IHTMLParaElementDisp = dispinterface;
  DispIHTMLHeaderElement = dispinterface;
  IHTMLHeaderElement = interface;
  IHTMLHeaderElementDisp = dispinterface;
  DispIHTMLSelectElement = dispinterface;
  HTMLSelectElementEvents = dispinterface;
  IHTMLSelectElement = interface;
  IHTMLSelectElementDisp = dispinterface;
  DispIHTMLOptionElement = dispinterface;
  DispIHTMLInputTextElement = dispinterface;
  HTMLInputTextElementEvents = dispinterface;
  IHTMLInputTextElement = interface;
  IHTMLInputTextElementDisp = dispinterface;
  DispIHTMLTextAreaElement = dispinterface;
  IHTMLTextAreaElement = interface;
  IHTMLTextAreaElementDisp = dispinterface;
  DispIHTMLInputButtonElement = dispinterface;
  HTMLButtonElementEvents = dispinterface;
  IHTMLInputButtonElement = interface;
  IHTMLInputButtonElementDisp = dispinterface;
  IHTMLInputHiddenElement = interface;
  IHTMLInputHiddenElementDisp = dispinterface;
  DispIHTMLButtonElement = dispinterface;
  IHTMLButtonElement = interface;
  IHTMLButtonElementDisp = dispinterface;
  DispIHTMLInputFileElement = dispinterface;
  HTMLInputFileElementEvents = dispinterface;
  IHTMLInputFileElement = interface;
  IHTMLInputFileElementDisp = dispinterface;
  DispIHTMLMarqueeElement = dispinterface;
  HTMLMarqueeElementEvents = dispinterface;
  IHTMLMarqueeElement = interface;
  IHTMLMarqueeElementDisp = dispinterface;
  DispIHTMLOptionButtonElement = dispinterface;
  HTMLOptionButtonElementEvents = dispinterface;
  IHTMLOptionButtonElement = interface;
  IHTMLOptionButtonElementDisp = dispinterface;
  DispIHTMLTitleElement = dispinterface;
  IHTMLTitleElement = interface;
  IHTMLTitleElementDisp = dispinterface;
  DispIHTMLMetaElement = dispinterface;
  IHTMLMetaElement = interface;
  IHTMLMetaElementDisp = dispinterface;
  DispIHTMLBaseElement = dispinterface;
  IHTMLBaseElement = interface;
  IHTMLBaseElementDisp = dispinterface;
  DispIHTMLIsIndexElement = dispinterface;
  IHTMLIsIndexElement = interface;
  IHTMLIsIndexElementDisp = dispinterface;
  DispIHTMLNextIdElement = dispinterface;
  IHTMLNextIdElement = interface;
  IHTMLNextIdElementDisp = dispinterface;
  DispIHTMLBaseFontElement = dispinterface;
  IHTMLBaseFontElement = interface;
  IHTMLBaseFontElementDisp = dispinterface;
  DispIHTMLUnknownElement = dispinterface;
  IHTMLUnknownElement = interface;
  IHTMLUnknownElementDisp = dispinterface;
  HTMLWindowEvents = dispinterface;
  DispIHTMLEmbedElement = dispinterface;
  HTMLControlElementEvents = dispinterface;
  IHTMLEmbedElement = interface;
  IHTMLEmbedElementDisp = dispinterface;
  DispIHTMLMapElement = dispinterface;
  HTMLMapEvents = dispinterface;
  IHTMLAreasCollection = interface;
  IHTMLAreasCollectionDisp = dispinterface;
  IHTMLMapElement = interface;
  IHTMLMapElementDisp = dispinterface;
  DispIHTMLAreaElement = dispinterface;
  HTMLAreaEvents = dispinterface;
  IHTMLAreaElement = interface;
  IHTMLAreaElementDisp = dispinterface;
  DispIHTMLTableCaption = dispinterface;
  IHTMLTableCaption = interface;
  IHTMLTableCaptionDisp = dispinterface;
  DispIHTMLCommentElement = dispinterface;
  IHTMLCommentElement = interface;
  IHTMLCommentElementDisp = dispinterface;
  DispIHTMLPhraseElement = dispinterface;
  IHTMLPhraseElement = interface;
  IHTMLPhraseElementDisp = dispinterface;
  DispIHTMLSpanElement = dispinterface;
  IHTMLSpanElement = interface;
  IHTMLSpanElementDisp = dispinterface;
  DispIHTMLTable = dispinterface;
  HTMLTableEvents = dispinterface;
  IHTMLTableSection = interface;
  IHTMLTableSectionDisp = dispinterface;
  IHTMLTable = interface;
  IHTMLTableDisp = dispinterface;
  DispIHTMLTableCol = dispinterface;
  IHTMLTableCol = interface;
  IHTMLTableColDisp = dispinterface;
  DispIHTMLTableSection = dispinterface;
  DispIHTMLTableRow = dispinterface;
  IHTMLTableRow = interface;
  IHTMLTableRowDisp = dispinterface;
  IHTMLTableRowMetrics = interface;
  IHTMLTableRowMetricsDisp = dispinterface;
  DispIHTMLTableCell = dispinterface;
  IHTMLTableCell = interface;
  IHTMLTableCellDisp = dispinterface;
  DispIHTMLScriptElement = dispinterface;
  HTMLScriptEvents = dispinterface;
  IHTMLScriptElement = interface;
  IHTMLScriptElementDisp = dispinterface;
  DispIHTMLNoShowElement = dispinterface;
  IHTMLNoShowElement = interface;
  IHTMLNoShowElementDisp = dispinterface;
  DispIHTMLObjectElement = dispinterface;
  HTMLObjectElementEvents = dispinterface;
  IHTMLObjectElement = interface;
  IHTMLObjectElementDisp = dispinterface;
  DispIHTMLFrameBase = dispinterface;
  IHTMLFrameBase = interface;
  IHTMLFrameBaseDisp = dispinterface;
  DispIHTMLFrameElement = dispinterface;
  IHTMLFrameElement = interface;
  IHTMLFrameElementDisp = dispinterface;
  DispIHTMLIFrameElement = dispinterface;
  IHTMLIFrameElement = interface;
  IHTMLIFrameElementDisp = dispinterface;
  DispIHTMLDivPosition = dispinterface;
  IHTMLDivPosition = interface;
  IHTMLDivPositionDisp = dispinterface;
  DispIHTMLFieldSetElement = dispinterface;
  IHTMLFieldSetElement = interface;
  IHTMLFieldSetElementDisp = dispinterface;
  DispIHTMLLegendElement = dispinterface;
  IHTMLLegendElement = interface;
  IHTMLLegendElementDisp = dispinterface;
  DispIHTMLSpanFlow = dispinterface;
  IHTMLSpanFlow = interface;
  IHTMLSpanFlowDisp = dispinterface;
  DispIHTMLFrameSetElement = dispinterface;
  IHTMLFrameSetElement = interface;
  IHTMLFrameSetElementDisp = dispinterface;
  DispIHTMLBGsound = dispinterface;
  IHTMLBGsound = interface;
  IHTMLBGsoundDisp = dispinterface;
  DispIHTMLStyleElement = dispinterface;
  HTMLStyleElementEvents = dispinterface;
  IHTMLStyleElement = interface;
  IHTMLStyleElementDisp = dispinterface;
  IHTMLStyleFontFace = interface;
  IHTMLStyleFontFaceDisp = dispinterface;
  IHTMLDialog = interface;
  IHTMLDialogDisp = dispinterface;
  IHTMLFrontPageBotElement = interface;
  IHTMLFrontPageBotElementDisp = dispinterface;
  DispIHTMLFrontPageBotElement = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  CWPEDoc = IWPEDoc;
  CAutoJackInteral = IPageEditorInternal;
  URLPicker = IURLPicker;
  HTMLColorPicker = IHTMLColorPicker;
  FPAxTagPage = IUnknown;
  FPAxParamsPage = IUnknown;
  ChServ = IChServ;
  FPEditorControl = IFPEditorControl;
  FPHTMLUndoTransaction = IFPHTMLUndoTransaction;
  FPHTMLDocument = DispFPHTMLDocument;
  FPHTMLStyle = IHTMLStyle;
  FPHTMLFiltersCollection = IHTMLFiltersCollection;
  FPHTMLStyleSheet = IHTMLStyleSheet;
  FPHTMLStyleSheetsCollection = IHTMLStyleSheetsCollection;
  FPHTMLLinkElement = DispIHTMLLinkElement;
  FPHTMLFormElement = DispIHTMLFormElement;
  FPHTMLTextElement = DispIHTMLTextElement;
  FPHTMLImg = DispIHTMLImgElement;
  FPHTMLInputImage = DispIHTMLInputImage;
  FPHTMLImageElementFactory = IHTMLImageElementFactory;
  FPHTMLBody = DispIHTMLBodyElement;
  FPHTMLFontElement = DispIHTMLFontElement;
  FPHTMLAnchorElement = DispIHTMLAnchorElement;
  FPHTMLLabelElement = DispIHTMLLabelElement;
  FPHTMLListElement = DispIHTMLListElement;
  FPHTMLUListElement = DispIHTMLUListElement;
  FPHTMLOListElement = DispIHTMLOListElement;
  FPHTMLLIElement = DispIHTMLLIElement;
  FPHTMLBlockElement = DispIHTMLBlockElement;
  FPHTMLDivElement = DispIHTMLDivElement;
  FPHTMLDDElement = DispIHTMLDDElement;
  FPHTMLDTElement = DispIHTMLDTElement;
  FPHTMLBRElement = DispIHTMLBRElement;
  FPHTMLDListElement = DispIHTMLDListElement;
  FPHTMLHRElement = DispIHTMLHRElement;
  FPHTMLParaElement = DispIHTMLParaElement;
  FPHTMLHeaderElement = DispIHTMLHeaderElement;
  FPHTMLSelectElement = DispIHTMLSelectElement;
  FPHTMLOptionElement = DispIHTMLOptionElement;
  FPHTMLOptionElementFactory = IHTMLOptionElementFactory;
  FPHTMLInputTextElement = DispIHTMLInputTextElement;
  FPHTMLTextAreaElement = DispIHTMLTextAreaElement;
  FPHTMLInputButtonElement = DispIHTMLInputButtonElement;
  FPHTMLInputHiddenElement = DispIHTMLInputButtonElement;
  FPHTMLButtonElement = DispIHTMLButtonElement;
  FPHTMLInputFileElement = DispIHTMLInputFileElement;
  FPHTMLMarqueeElement = DispIHTMLMarqueeElement;
  FPHTMLOptionButtonElement = DispIHTMLOptionButtonElement;
  FPHTMLTitleElement = DispIHTMLTitleElement;
  FPHTMLMetaElement = DispIHTMLMetaElement;
  FPHTMLBaseElement = DispIHTMLBaseElement;
  FPHTMLIsIndexElement = DispIHTMLIsIndexElement;
  FPHTMLNextIdElement = DispIHTMLNextIdElement;
  FPHTMLBaseFontElement = DispIHTMLBaseFontElement;
  FPHTMLUnknownElement = DispIHTMLUnknownElement;
  FPHTMLHistory = IOmHistory;
  FPHTMLCMimeTypes = IHTMLMimeTypesCollection;
  FPHTMLCPlugins = IHTMLPluginsCollection;
  FPHTMLCOpsProfile = IHTMLOpsProfile;
  FPHTMLNavigator = IOmNavigator;
  FPHTMLLocation = IHTMLLocation;
  FPHTMLScreen = IHTMLScreen;
  FPHTMLWindow2 = IHTMLWindow2;
  FPHTMLWindowProxy = IHTMLWindow2;
  FPHTMLEmbed = DispIHTMLEmbedElement;
  FPHTMLMapElement = DispIHTMLMapElement;
  FPHTMLAreaElement = DispIHTMLAreaElement;
  FPHTMLTableCaption = DispIHTMLTableCaption;
  FPHTMLCommentElement = DispIHTMLCommentElement;
  FPHTMLPhraseElement = DispIHTMLPhraseElement;
  FPHTMLSpanElement = DispIHTMLSpanElement;
  FPHTMLTable = DispIHTMLTable;
  FPHTMLTableCol = DispIHTMLTableCol;
  FPHTMLTableSection = DispIHTMLTableSection;
  FPHTMLTableRow = DispIHTMLTableRow;
  FPHTMLTableCell = DispIHTMLTableCell;
  FPHTMLScriptElement = DispIHTMLScriptElement;
  FPHTMLNoShowElement = DispIHTMLNoShowElement;
  FPHTMLObjectElement = DispIHTMLObjectElement;
  FPHTMLFrameBase = DispIHTMLFrameBase;
  FPHTMLFrameElement = DispIHTMLFrameElement;
  FPHTMLIFrame = DispIHTMLIFrameElement;
  FPHTMLDivPosition = DispIHTMLDivPosition;
  FPHTMLFieldSetElement = DispIHTMLFieldSetElement;
  FPHTMLLegendElement = DispIHTMLLegendElement;
  FPHTMLSpanFlow = DispIHTMLSpanFlow;
  FPHTMLFrameSetSite = DispIHTMLFrameSetElement;
  FPHTMLBGsound = DispIHTMLBGsound;
  FPHTMLStyleElement = DispIHTMLStyleElement;
  FPHTMLStyleFontFace = IHTMLStyleFontFace;
  FPHTMLDialog = IHTMLDialog;
  FPHTMLFrontPageBotElement = DispIHTMLFrontPageBotElement;


// *********************************************************************//
// Declaration of structures, unions and aliases.
// *********************************************************************//
  PInteger1 = ^Integer; {*}
  POleVariant1 = ^OleVariant; {*}
  PWordBool1 = ^WordBool; {*}

  POINTER_GRAVITY = __MIDL___MIDL_itf_WPE_0409_0001;
  ELEMENT_ADJACENCY = __MIDL___MIDL_itf_WPE_0409_0002;
  HTML_CONTEXT_TYPE = __MIDL___MIDL_itf_WPE_0409_0003;
  FINDTEXT_FLAGS = __MIDL___MIDL_itf_WPE_0409_0004;
  ELEMENT_TAG_ID = __MIDL___MIDL_itf_WPE_0409_0005;

// *********************************************************************//
// DispIntf:  IWPEDoc
// Flags:     (4112) Hidden Dispatchable
// GUID:      {8BBD4A7A-661D-11CF-A3C4-00A024184692}
// *********************************************************************//
  IWPEDoc = dispinterface
    ['{8BBD4A7A-661D-11CF-A3C4-00A024184692}']
  end;

// *********************************************************************//
// DispIntf:  IPageEditorInternal
// Flags:     (4112) Hidden Dispatchable
// GUID:      {D603F1EF-2632-11D2-AD10-00C04F795285}
// *********************************************************************//
  IPageEditorInternal = dispinterface
    ['{D603F1EF-2632-11D2-AD10-00C04F795285}']
    function  vtiOpenWebPage(const szFileName: WideString; const szURL: WideString;
                             const szWebURL: WideString; const szWebTitle: WideString): IDispatch; dispid 1;
    function  vtiQueryWebPage(const szURL: WideString; const szWebURL: WideString): Integer; dispid 3;
    procedure vtiBringToTop; dispid 4;
    function  vtiOpenForToDoList(const szFileName: WideString; const szURL: WideString;
                                 const szWebURL: WideString; const szWebTitle: WideString;
                                 const szCookie: WideString; toDoTaskId: Integer;
                                 lDateTimeMod: Integer): IDispatch; dispid 2;
    function  vtiNewWebPage(const szURL: WideString; const szWebURL: WideString;
                            const szWebTitle: WideString): IDispatch; dispid 5;
    function  vtiBringPageToTop(const szURL: WideString; const szWebURL: WideString;
                                const szCookie: WideString; toDoTaskId: Integer): Integer; dispid 6;
    procedure vtiGetDocumentCB(const szFileName: WideString; const szURL: WideString;
                               cookie: Integer; dtm: Integer); dispid 7;
    function  vtiGetActiveView: Integer; dispid 8;
    function  vtiDropPage(const szURL: WideString; const szPageTitle: WideString; x: Integer;
                          y: Integer): Integer; dispid 9;
    function  vtiEditImageCB(const szFileName: WideString; lDtm: Integer): Integer; dispid 10;
    procedure vtiEditLink(const szPageUrl: WideString; const szWebURL: WideString;
                          const szOldLink: WideString; const szNewLink: WideString;
                          lPrevDtm: Integer; lCurrDtm: Integer); dispid 11;
    function  vtiListOpenDocs: WideString; dispid 12;
    procedure vtiMoveDocument(const szOldUrl: WideString; const szNewUrl: WideString;
                              const szWebURL: WideString; lPrevDtm: Integer; lCurrDtm: Integer); dispid 13;
    function  vtiOpenWebPageDTM(const szFileName: WideString; const szURL: WideString;
                                const szWebURL: WideString; const szWebTitle: WideString;
                                lDateTimeMod: Integer): IDispatch; dispid 14;
    function  vtiSetDocumentRW(const szPageUrl: WideString; const szWebURL: WideString;
                               bWriteable: Integer; var pbDirty: Integer): Integer; dispid 15;
    procedure vtiRefreshDocument(const szPageUrl: WideString; const szWebURL: WideString); dispid 16;
    function  vtiGetBookmarkList(const pszPageUrl: WideString; const pszWebUrl: WideString): WideString; dispid 17;
    function  vtiScrollToBookmark(const pszPageUrl: WideString; const pszWebUrl: WideString;
                                  const pszBookmark: WideString): Integer; dispid 18;
    function  vtiInsertFile(const pszPageUrl: WideString; const pszWebUrl: WideString;
                            const pszFile: WideString): Integer; dispid 19;
    function  vtiInsertImage(const pszPageUrl: WideString; const pszWebUrl: WideString;
                             const pszFile: WideString): Integer; dispid 20;
    function  vtiGetTopPageUrl: WideString; dispid 21;
    function  vtiInsertHTML(const pszHTML: WideString): Integer; dispid 22;
    procedure vtiPaste; dispid 23;
    procedure vtiQuit; dispid 24;
    function  vtiNotify(lType: Integer; const pszPageUrl: WideString; const pszWebUrl: WideString;
                        const pszStrParam1: WideString; const pszStrParam2: WideString;
                        lParam1: Integer; lParam2: Integer): Integer; dispid 25;
    function  vtiSetMetaTag(const pszPageUrl: WideString; const pszWebUrl: WideString;
                            const pszKey: WideString; const pszValue: WideString; lIndex: Integer;
                            flags: Integer): Integer; dispid 26;
    function  vtiListMetaTags(const pszPageUrl: WideString; const pszWebUrl: WideString;
                              flags: Integer): WideString; dispid 27;
    function  vtiDeleteMetaTag(const pszPageUrl: WideString; const pszWebUrl: WideString;
                               const pszKey: WideString; lIndex: Integer; flags: Integer): Integer; dispid 28;
    function  vtiGetMetaTag(const pszPageUrl: WideString; const pszWebUrl: WideString;
                            const pszKey: WideString; lIndex: Integer; flags: Integer): WideString; dispid 29;
    function  vtiQueryWebPageEx(const szURL: WideString; const szWebURL: WideString;
                                var bDirty: Integer; var bWritable: Integer): Integer; dispid 30;
    property Document[index: Integer]: IDispatch dispid 32;
    function  DocumentCount: Integer; dispid 31;
    function  EditStyleSheet(const szBaseURL: WideString; const szBuf: WideString): WideString; dispid 33;
    function  PickURL(const szBaseURL: WideString; const szURL: WideString;
                      desiredFileType: Integer; flags: Integer; var bCmd: Integer): WideString; dispid 34;
    procedure EditorOptions; dispid 35;
    function  DocumentByUrl(const szAbsUrl: WideString): IDispatch; dispid 36;
    procedure PreviewInBrowser(const szAbsUrl: WideString; bShowPreviewDlg: Integer); dispid 37;
  end;

// *********************************************************************//
// Interface: IURLPicker
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {12428687-A9D9-11CF-8904-00AA00BDCB98}
// *********************************************************************//
  IURLPicker = interface(IDispatch)
    ['{12428687-A9D9-11CF-8904-00AA00BDCB98}']
    function  Execute(const pIDispatch: IDispatch; hwnd: Integer; var pvarValue: OleVariant;
                      const pszcBaseURL: WideString; const pszcAdditionalFilters: WideString;
                      const pszcDlgTitle: WideString; var pvarTargetFrame: OleVariant;
                      dwFlags: Integer): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IURLPickerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {12428687-A9D9-11CF-8904-00AA00BDCB98}
// *********************************************************************//
  IURLPickerDisp = dispinterface
    ['{12428687-A9D9-11CF-8904-00AA00BDCB98}']
    function  Execute(const pIDispatch: IDispatch; hwnd: Integer; var pvarValue: OleVariant;
                      const pszcBaseURL: WideString; const pszcAdditionalFilters: WideString;
                      const pszcDlgTitle: WideString; var pvarTargetFrame: OleVariant;
                      dwFlags: Integer): WordBool; dispid 1;
  end;

// *********************************************************************//
// Interface: IHTMLColorPicker
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {533AC2A3-1ACE-11D1-A787-0000F80272EA}
// *********************************************************************//
  IHTMLColorPicker = interface(IDispatch)
    ['{533AC2A3-1ACE-11D1-A787-0000F80272EA}']
    procedure Execute(const pdispApp: IDispatch; hwndOwner: Integer; var pvarColor: OleVariant;
                      var pfRetVal: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  IHTMLColorPickerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {533AC2A3-1ACE-11D1-A787-0000F80272EA}
// *********************************************************************//
  IHTMLColorPickerDisp = dispinterface
    ['{533AC2A3-1ACE-11D1-A787-0000F80272EA}']
    procedure Execute(const pdispApp: IDispatch; hwndOwner: Integer; var pvarColor: OleVariant;
                      var pfRetVal: WordBool); dispid 1;
  end;

// *********************************************************************//
// Interface: IDTCExtendedServices
// Flags:     (0)
// GUID:      {6FF02AB1-809B-11D1-9D27-006008058731}
// *********************************************************************//
  IDTCExtendedServices = interface(IUnknown)
    ['{6FF02AB1-809B-11D1-9D27-006008058731}']
    function  UsesDataBaseServices: HResult; stdcall;
    function  IsNameUnique(const bstrName: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IIdleWorker
// Flags:     (0)
// GUID:      {3A82F170-4C49-11D2-BE5D-006008C3FEBE}
// *********************************************************************//
  IIdleWorker = interface(IUnknown)
    ['{3A82F170-4C49-11D2-BE5D-006008C3FEBE}']
    function  OnIdle: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IChServ
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E047F690-D314-11D1-BDF8-006008C3FEBE}
// *********************************************************************//
  IChServ = interface(IDispatch)
    ['{E047F690-D314-11D1-BDF8-006008C3FEBE}']
    function  Get__NewEnum: IUnknown; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IChServDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E047F690-D314-11D1-BDF8-006008C3FEBE}
// *********************************************************************//
  IChServDisp = dispinterface
    ['{E047F690-D314-11D1-BDF8-006008C3FEBE}']
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: ICagNotifySink
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9B9168CF-9DA0-11D1-A89A-00C04FB92C8F}
// *********************************************************************//
  ICagNotifySink = interface(IDispatch)
    ['{9B9168CF-9DA0-11D1-A89A-00C04FB92C8F}']
    procedure InsertClip(const pClipMoniker: IUnknown; const pItemMoniker: IUnknown); safecall;
    procedure WindowIsClosing; safecall;
  end;

// *********************************************************************//
// DispIntf:  ICagNotifySinkDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {9B9168CF-9DA0-11D1-A89A-00C04FB92C8F}
// *********************************************************************//
  ICagNotifySinkDisp = dispinterface
    ['{9B9168CF-9DA0-11D1-A89A-00C04FB92C8F}']
    procedure InsertClip(const pClipMoniker: IUnknown; const pItemMoniker: IUnknown); dispid 1;
    procedure WindowIsClosing; dispid 2;
  end;

// *********************************************************************//
// Interface: IFPEditorControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0E5EDCEF-9F3B-11D1-B3C3-0060977B463D}
// *********************************************************************//
  IFPEditorControl = interface(IDispatch)
    ['{0E5EDCEF-9F3B-11D1-B3C3-0060977B463D}']
    function  Get_URL: WideString; safecall;
    procedure Set_URL(const pVal: WideString); safecall;
    procedure NewFromTemplate(const templateName: WideString; const URL: WideString;
                              const title: WideString; const webUrl: WideString;
                              openInFrame: Integer; normalTemplate: Integer); safecall;
    procedure SaveToURL(const URL: WideString); safecall;
    function  Get_ReadyState: tagREADYSTATE; safecall;
    function  Get_Busy: Integer; safecall;
    function  Get_Document: IDispatch; safecall;
    procedure Refresh(bForceSave: Integer); safecall;
    procedure Stop; safecall;
    function  Get_Dirty: Integer; safecall;
    function  Get_CanClose: Integer; safecall;
    procedure OpenURL(const URL: WideString; const filePath: WideString; const web: WideString;
                      lDtm: Integer; bQuiet: Integer); safecall;
    function  Get_Window: IDispatch; safecall;
    function  Get_ActiveWindow: IDispatch; safecall;
    procedure Set_ActiveWindow(const pVal: IDispatch); safecall;
    function  Get_ViewMode: Integer; safecall;
    procedure Set_ViewMode(mode: Integer); safecall;
    procedure DoTask(lTaskId: Integer; const cookie: WideString); safecall;
    function  Get_DocumentHTML: WideString; safecall;
    procedure Set_DocumentHTML(const text: WideString); safecall;
    procedure SaveAndAddTask(var pResult: Integer); safecall;
    function  Get_CanOpenInFrame: Integer; safecall;
    procedure OpenURLAgain(const URL: WideString; voodoo: LongWord); safecall;
    function  Get_ActiveDocument: IDispatch; safecall;
    function  Get_DownloadSize: Integer; safecall;
    function  Get_ActiveDocumentURL: WideString; safecall;
    procedure OpenURLInFrame(const URL: WideString); safecall;
    function  Get_CanNewInFrame: Integer; safecall;
    property URL: WideString read Get_URL write Set_URL;
    property ReadyState: tagREADYSTATE read Get_ReadyState;
    property Busy: Integer read Get_Busy;
    property Document: IDispatch read Get_Document;
    property Dirty: Integer read Get_Dirty;
    property CanClose: Integer read Get_CanClose;
    property Window: IDispatch read Get_Window;
    property ActiveWindow: IDispatch read Get_ActiveWindow write Set_ActiveWindow;
    property ViewMode: Integer read Get_ViewMode write Set_ViewMode;
    property DocumentHTML: WideString read Get_DocumentHTML write Set_DocumentHTML;
    property CanOpenInFrame: Integer read Get_CanOpenInFrame;
    property ActiveDocument: IDispatch read Get_ActiveDocument;
    property DownloadSize: Integer read Get_DownloadSize;
    property ActiveDocumentURL: WideString read Get_ActiveDocumentURL;
    property CanNewInFrame: Integer read Get_CanNewInFrame;
  end;

// *********************************************************************//
// DispIntf:  IFPEditorControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0E5EDCEF-9F3B-11D1-B3C3-0060977B463D}
// *********************************************************************//
  IFPEditorControlDisp = dispinterface
    ['{0E5EDCEF-9F3B-11D1-B3C3-0060977B463D}']
    property URL: WideString dispid 1;
    procedure NewFromTemplate(const templateName: WideString; const URL: WideString;
                              const title: WideString; const webUrl: WideString;
                              openInFrame: Integer; normalTemplate: Integer); dispid 2;
    procedure SaveToURL(const URL: WideString); dispid 3;
    property ReadyState: tagREADYSTATE readonly dispid 4;
    property Busy: Integer readonly dispid 5;
    property Document: IDispatch readonly dispid 6;
    procedure Refresh(bForceSave: Integer); dispid 7;
    procedure Stop; dispid 8;
    property Dirty: Integer readonly dispid 9;
    property CanClose: Integer readonly dispid 10;
    procedure OpenURL(const URL: WideString; const filePath: WideString; const web: WideString;
                      lDtm: Integer; bQuiet: Integer); dispid 11;
    property Window: IDispatch readonly dispid 12;
    property ActiveWindow: IDispatch dispid 13;
    property ViewMode: Integer dispid 14;
    procedure DoTask(lTaskId: Integer; const cookie: WideString); dispid 15;
    property DocumentHTML: WideString dispid 16;
    procedure SaveAndAddTask(var pResult: Integer); dispid 17;
    property CanOpenInFrame: Integer readonly dispid 18;
    procedure OpenURLAgain(const URL: WideString; voodoo: LongWord); dispid 19;
    property ActiveDocument: IDispatch readonly dispid 20;
    property DownloadSize: Integer readonly dispid 21;
    property ActiveDocumentURL: WideString readonly dispid 22;
    procedure OpenURLInFrame(const URL: WideString); dispid 23;
    property CanNewInFrame: Integer readonly dispid 24;
  end;

// *********************************************************************//
// DispIntf:  _DFPEditorControlEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {F27C78D0-9F63-11D1-B3C3-0060977B463D}
// *********************************************************************//
  _DFPEditorControlEvents = dispinterface
    ['{F27C78D0-9F63-11D1-B3C3-0060977B463D}']
    procedure onreadystatechange; dispid 1;
  end;

// *********************************************************************//
// Interface: IFPMarkupPointer
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3050F49F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IFPMarkupPointer = interface(IDispatch)
    ['{3050F49F-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_OwningDoc: IHTMLDocument2; safecall;
    function  Gravity: POINTER_GRAVITY; safecall;
    procedure SetGravity(Gravity: POINTER_GRAVITY); safecall;
    procedure Unposition; safecall;
    procedure IsPositioned(out pfPositioned: Integer; out ppContainer: IFPMarkupContainer); safecall;
    procedure MoveAdjacentToElement(const pElement: IHTMLElement; eAdj: ELEMENT_ADJACENCY); safecall;
    procedure MoveAdjacentToPointer(const pPointer: IFPMarkupPointer; fBefore: Integer); safecall;
    procedure MoveToContainer(const pContainer: IFPMarkupContainer; fAtStart: Integer); safecall;
    procedure left(fMove: Integer; out pContext: HTML_CONTEXT_TYPE; out ppElement: IHTMLElement;
                   var pcch: Integer; const pchText: WideString); safecall;
    procedure Right(fMove: Integer; out pContext: HTML_CONTEXT_TYPE; out ppElement: IHTMLElement;
                    var pcch: Integer; const pchText: WideString); safecall;
    function  Get_CurrentScope: IHTMLElement; safecall;
    procedure FindText(const bstr: WideString; flags: Integer); safecall;
    function  PointerCompare(const pPointer: IFPMarkupPointer): SYSINT; safecall;
    function  ContextualCompare(const pPointer: IFPMarkupPointer): SYSINT; safecall;
    property OwningDoc: IHTMLDocument2 read Get_OwningDoc;
    property CurrentScope: IHTMLElement read Get_CurrentScope;
  end;

// *********************************************************************//
// DispIntf:  IFPMarkupPointerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3050F49F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IFPMarkupPointerDisp = dispinterface
    ['{3050F49F-98B5-11CF-BB82-00AA00BDCE0B}']
    property OwningDoc: IHTMLDocument2 readonly dispid 1001;
    function  Gravity: POINTER_GRAVITY; dispid 1002;
    procedure SetGravity(Gravity: POINTER_GRAVITY); dispid 1003;
    procedure Unposition; dispid 1004;
    procedure IsPositioned(out pfPositioned: Integer; out ppContainer: IFPMarkupContainer); dispid 1005;
    procedure MoveAdjacentToElement(const pElement: IHTMLElement; eAdj: ELEMENT_ADJACENCY); dispid 1006;
    procedure MoveAdjacentToPointer(const pPointer: IFPMarkupPointer; fBefore: Integer); dispid 1007;
    procedure MoveToContainer(const pContainer: IFPMarkupContainer; fAtStart: Integer); dispid 1008;
    procedure left(fMove: Integer; out pContext: HTML_CONTEXT_TYPE; out ppElement: IHTMLElement;
                   var pcch: Integer; const pchText: WideString); dispid 1009;
    procedure Right(fMove: Integer; out pContext: HTML_CONTEXT_TYPE; out ppElement: IHTMLElement;
                    var pcch: Integer; const pchText: WideString); dispid 1010;
    property CurrentScope: IHTMLElement readonly dispid 1011;
    procedure FindText(const bstr: WideString; flags: Integer); dispid 1012;
    function  PointerCompare(const pPointer: IFPMarkupPointer): SYSINT; dispid 1013;
    function  ContextualCompare(const pPointer: IFPMarkupPointer): SYSINT; dispid 1014;
  end;

// *********************************************************************//
// Interface: IHTMLDocument
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {626FC520-A41E-11CF-A731-00A0C9082637}
// *********************************************************************//
  IHTMLDocument = interface(IDispatch)
    ['{626FC520-A41E-11CF-A731-00A0C9082637}']
    function  Get_Script: IDispatch; safecall;
    property Script: IDispatch read Get_Script;
  end;

// *********************************************************************//
// DispIntf:  IHTMLDocumentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {626FC520-A41E-11CF-A731-00A0C9082637}
// *********************************************************************//
  IHTMLDocumentDisp = dispinterface
    ['{626FC520-A41E-11CF-A731-00A0C9082637}']
    property Script: IDispatch readonly dispid 1001;
  end;

// *********************************************************************//
// Interface: IHTMLDocument2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {332C4425-26CB-11D0-B483-00C04FD90119}
// *********************************************************************//
  IHTMLDocument2 = interface(IHTMLDocument)
    ['{332C4425-26CB-11D0-B483-00C04FD90119}']
    function  Get_all: IHTMLElementCollection; safecall;
    function  Get_body: IHTMLElement; safecall;
    function  Get_activeElement: IHTMLElement; safecall;
    function  Get_images: IHTMLElementCollection; safecall;
    function  Get_applets: IHTMLElementCollection; safecall;
    function  Get_links: IHTMLElementCollection; safecall;
    function  Get_forms: IHTMLElementCollection; safecall;
    function  Get_anchors: IHTMLElementCollection; safecall;
    procedure Set_title(const p: WideString); safecall;
    function  Get_title: WideString; safecall;
    function  Get_scripts: IHTMLElementCollection; safecall;
    procedure Set_designMode(const p: WideString); safecall;
    function  Get_designMode: WideString; safecall;
    function  Get_selection: IHTMLSelectionObject; safecall;
    function  Get_ReadyState: WideString; safecall;
    function  Get_frames: IHTMLFramesCollection2; safecall;
    function  Get_embeds: IHTMLElementCollection; safecall;
    function  Get_plugins: IHTMLElementCollection; safecall;
    procedure Set_alinkColor(p: OleVariant); safecall;
    function  Get_alinkColor: OleVariant; safecall;
    procedure Set_bgColor(p: OleVariant); safecall;
    function  Get_bgColor: OleVariant; safecall;
    procedure Set_fgColor(p: OleVariant); safecall;
    function  Get_fgColor: OleVariant; safecall;
    procedure Set_linkColor(p: OleVariant); safecall;
    function  Get_linkColor: OleVariant; safecall;
    procedure Set_vlinkColor(p: OleVariant); safecall;
    function  Get_vlinkColor: OleVariant; safecall;
    function  Get_referrer: WideString; safecall;
    function  Get_location: IHTMLLocation; safecall;
    function  Get_lastModified: WideString; safecall;
    procedure Set_URL(const p: WideString); safecall;
    function  Get_URL: WideString; safecall;
    procedure Set_domain(const p: WideString); safecall;
    function  Get_domain: WideString; safecall;
    procedure Set_cookie(const p: WideString); safecall;
    function  Get_cookie: WideString; safecall;
    procedure Set_expando(p: WordBool); safecall;
    function  Get_expando: WordBool; safecall;
    procedure Set_charset(const p: WideString); safecall;
    function  Get_charset: WideString; safecall;
    procedure Set_defaultCharset(const p: WideString); safecall;
    function  Get_defaultCharset: WideString; safecall;
    function  Get_mimeType: WideString; safecall;
    function  Get_fileSize: WideString; safecall;
    function  Get_fileCreatedDate: WideString; safecall;
    function  Get_fileModifiedDate: WideString; safecall;
    function  Get_fileUpdatedDate: WideString; safecall;
    function  Get_security: WideString; safecall;
    function  Get_protocol: WideString; safecall;
    function  Get_nameProp: WideString; safecall;
    procedure write(psarray: PSafeArray); safecall;
    procedure writeln(psarray: PSafeArray); safecall;
    function  open(const URL: WideString; name: OleVariant; features: OleVariant;
                   replace: OleVariant): IDispatch; safecall;
    procedure close; safecall;
    procedure clear; safecall;
    function  queryCommandSupported(const cmdID: WideString): WordBool; safecall;
    function  queryCommandEnabled(const cmdID: WideString): WordBool; safecall;
    function  queryCommandState(const cmdID: WideString): WordBool; safecall;
    function  queryCommandIndeterm(const cmdID: WideString): WordBool; safecall;
    function  queryCommandText(const cmdID: WideString): WideString; safecall;
    function  queryCommandValue(const cmdID: WideString): OleVariant; safecall;
    function  execCommand(const cmdID: WideString; showUI: WordBool; value: OleVariant): WordBool; safecall;
    function  execCommandShowHelp(const cmdID: WideString): WordBool; safecall;
    function  createElement(const eTag: WideString): IHTMLElement; safecall;
    procedure Set_onhelp(p: OleVariant); safecall;
    function  Get_onhelp: OleVariant; safecall;
    procedure Set_onclick(p: OleVariant); safecall;
    function  Get_onclick: OleVariant; safecall;
    procedure Set_ondblclick(p: OleVariant); safecall;
    function  Get_ondblclick: OleVariant; safecall;
    procedure Set_onkeyup(p: OleVariant); safecall;
    function  Get_onkeyup: OleVariant; safecall;
    procedure Set_onkeydown(p: OleVariant); safecall;
    function  Get_onkeydown: OleVariant; safecall;
    procedure Set_onkeypress(p: OleVariant); safecall;
    function  Get_onkeypress: OleVariant; safecall;
    procedure Set_onmouseup(p: OleVariant); safecall;
    function  Get_onmouseup: OleVariant; safecall;
    procedure Set_onmousedown(p: OleVariant); safecall;
    function  Get_onmousedown: OleVariant; safecall;
    procedure Set_onmousemove(p: OleVariant); safecall;
    function  Get_onmousemove: OleVariant; safecall;
    procedure Set_onmouseout(p: OleVariant); safecall;
    function  Get_onmouseout: OleVariant; safecall;
    procedure Set_onmouseover(p: OleVariant); safecall;
    function  Get_onmouseover: OleVariant; safecall;
    procedure Set_onreadystatechange(p: OleVariant); safecall;
    function  Get_onreadystatechange: OleVariant; safecall;
    procedure Set_onafterupdate(p: OleVariant); safecall;
    function  Get_onafterupdate: OleVariant; safecall;
    procedure Set_onrowexit(p: OleVariant); safecall;
    function  Get_onrowexit: OleVariant; safecall;
    procedure Set_onrowenter(p: OleVariant); safecall;
    function  Get_onrowenter: OleVariant; safecall;
    procedure Set_ondragstart(p: OleVariant); safecall;
    function  Get_ondragstart: OleVariant; safecall;
    procedure Set_onselectstart(p: OleVariant); safecall;
    function  Get_onselectstart: OleVariant; safecall;
    function  elementFromPoint(x: Integer; y: Integer): IHTMLElement; safecall;
    function  Get_parentWindow: IHTMLWindow2; safecall;
    function  Get_styleSheets: IHTMLStyleSheetsCollection; safecall;
    procedure Set_onbeforeupdate(p: OleVariant); safecall;
    function  Get_onbeforeupdate: OleVariant; safecall;
    procedure Set_onerrorupdate(p: OleVariant); safecall;
    function  Get_onerrorupdate: OleVariant; safecall;
    function  toString: WideString; safecall;
    function  createStyleSheet(const bstrHref: WideString; lIndex: Integer): IHTMLStyleSheet; safecall;
    property all: IHTMLElementCollection read Get_all;
    property body: IHTMLElement read Get_body;
    property activeElement: IHTMLElement read Get_activeElement;
    property images: IHTMLElementCollection read Get_images;
    property applets: IHTMLElementCollection read Get_applets;
    property links: IHTMLElementCollection read Get_links;
    property forms: IHTMLElementCollection read Get_forms;
    property anchors: IHTMLElementCollection read Get_anchors;
    property title: WideString read Get_title write Set_title;
    property scripts: IHTMLElementCollection read Get_scripts;
    property designMode: WideString read Get_designMode write Set_designMode;
    property selection: IHTMLSelectionObject read Get_selection;
    property ReadyState: WideString read Get_ReadyState;
    property frames: IHTMLFramesCollection2 read Get_frames;
    property embeds: IHTMLElementCollection read Get_embeds;
    property plugins: IHTMLElementCollection read Get_plugins;
    property alinkColor: OleVariant read Get_alinkColor write Set_alinkColor;
    property bgColor: OleVariant read Get_bgColor write Set_bgColor;
    property fgColor: OleVariant read Get_fgColor write Set_fgColor;
    property linkColor: OleVariant read Get_linkColor write Set_linkColor;
    property vlinkColor: OleVariant read Get_vlinkColor write Set_vlinkColor;
    property referrer: WideString read Get_referrer;
    property location: IHTMLLocation read Get_location;
    property lastModified: WideString read Get_lastModified;
    property URL: WideString read Get_URL write Set_URL;
    property domain: WideString read Get_domain write Set_domain;
    property cookie: WideString read Get_cookie write Set_cookie;
    property expando: WordBool read Get_expando write Set_expando;
    property charset: WideString read Get_charset write Set_charset;
    property defaultCharset: WideString read Get_defaultCharset write Set_defaultCharset;
    property mimeType: WideString read Get_mimeType;
    property fileSize: WideString read Get_fileSize;
    property fileCreatedDate: WideString read Get_fileCreatedDate;
    property fileModifiedDate: WideString read Get_fileModifiedDate;
    property fileUpdatedDate: WideString read Get_fileUpdatedDate;
    property security: WideString read Get_security;
    property protocol: WideString read Get_protocol;
    property nameProp: WideString read Get_nameProp;
    property onhelp: OleVariant read Get_onhelp write Set_onhelp;
    property onclick: OleVariant read Get_onclick write Set_onclick;
    property ondblclick: OleVariant read Get_ondblclick write Set_ondblclick;
    property onkeyup: OleVariant read Get_onkeyup write Set_onkeyup;
    property onkeydown: OleVariant read Get_onkeydown write Set_onkeydown;
    property onkeypress: OleVariant read Get_onkeypress write Set_onkeypress;
    property onmouseup: OleVariant read Get_onmouseup write Set_onmouseup;
    property onmousedown: OleVariant read Get_onmousedown write Set_onmousedown;
    property onmousemove: OleVariant read Get_onmousemove write Set_onmousemove;
    property onmouseout: OleVariant read Get_onmouseout write Set_onmouseout;
    property onmouseover: OleVariant read Get_onmouseover write Set_onmouseover;
    property onreadystatechange: OleVariant read Get_onreadystatechange write Set_onreadystatechange;
    property onafterupdate: OleVariant read Get_onafterupdate write Set_onafterupdate;
    property onrowexit: OleVariant read Get_onrowexit write Set_onrowexit;
    property onrowenter: OleVariant read Get_onrowenter write Set_onrowenter;
    property ondragstart: OleVariant read Get_ondragstart write Set_ondragstart;
    property onselectstart: OleVariant read Get_onselectstart write Set_onselectstart;
    property parentWindow: IHTMLWindow2 read Get_parentWindow;
    property styleSheets: IHTMLStyleSheetsCollection read Get_styleSheets;
    property onbeforeupdate: OleVariant read Get_onbeforeupdate write Set_onbeforeupdate;
    property onerrorupdate: OleVariant read Get_onerrorupdate write Set_onerrorupdate;
  end;

// *********************************************************************//
// DispIntf:  IHTMLDocument2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {332C4425-26CB-11D0-B483-00C04FD90119}
// *********************************************************************//
  IHTMLDocument2Disp = dispinterface
    ['{332C4425-26CB-11D0-B483-00C04FD90119}']
    property all: IHTMLElementCollection readonly dispid 1003;
    property body: IHTMLElement readonly dispid 1004;
    property activeElement: IHTMLElement readonly dispid 1005;
    property images: IHTMLElementCollection readonly dispid 1011;
    property applets: IHTMLElementCollection readonly dispid 1008;
    property links: IHTMLElementCollection readonly dispid 1009;
    property forms: IHTMLElementCollection readonly dispid 1010;
    property anchors: IHTMLElementCollection readonly dispid 1007;
    property title: WideString dispid 1012;
    property scripts: IHTMLElementCollection readonly dispid 1013;
    property designMode: WideString dispid 1014;
    property selection: IHTMLSelectionObject readonly dispid 1017;
    property ReadyState: WideString readonly dispid 1018;
    property frames: IHTMLFramesCollection2 readonly dispid 1019;
    property embeds: IHTMLElementCollection readonly dispid 1015;
    property plugins: IHTMLElementCollection readonly dispid 1021;
    property alinkColor: OleVariant dispid 1022;
    property bgColor: OleVariant dispid -501;
    property fgColor: OleVariant dispid -2147413110;
    property linkColor: OleVariant dispid 1024;
    property vlinkColor: OleVariant dispid 1023;
    property referrer: WideString readonly dispid 1027;
    property location: IHTMLLocation readonly dispid 1026;
    property lastModified: WideString readonly dispid 1028;
    property URL: WideString dispid 1025;
    property domain: WideString dispid 1029;
    property cookie: WideString dispid 1030;
    property expando: WordBool dispid 1031;
    property charset: WideString dispid 1032;
    property defaultCharset: WideString dispid 1033;
    property mimeType: WideString readonly dispid 1041;
    property fileSize: WideString readonly dispid 1042;
    property fileCreatedDate: WideString readonly dispid 1043;
    property fileModifiedDate: WideString readonly dispid 1044;
    property fileUpdatedDate: WideString readonly dispid 1045;
    property security: WideString readonly dispid 1046;
    property protocol: WideString readonly dispid 1047;
    property nameProp: WideString readonly dispid 1048;
    procedure write(psarray: {??PSafeArray} OleVariant); dispid 1054;
    procedure writeln(psarray: {??PSafeArray} OleVariant); dispid 1055;
    function  open(const URL: WideString; name: OleVariant; features: OleVariant;
                   replace: OleVariant): IDispatch; dispid 1056;
    procedure close; dispid 1057;
    procedure clear; dispid 1058;
    function  queryCommandSupported(const cmdID: WideString): WordBool; dispid 1059;
    function  queryCommandEnabled(const cmdID: WideString): WordBool; dispid 1060;
    function  queryCommandState(const cmdID: WideString): WordBool; dispid 1061;
    function  queryCommandIndeterm(const cmdID: WideString): WordBool; dispid 1062;
    function  queryCommandText(const cmdID: WideString): WideString; dispid 1063;
    function  queryCommandValue(const cmdID: WideString): OleVariant; dispid 1064;
    function  execCommand(const cmdID: WideString; showUI: WordBool; value: OleVariant): WordBool; dispid 1065;
    function  execCommandShowHelp(const cmdID: WideString): WordBool; dispid 1066;
    function  createElement(const eTag: WideString): IHTMLElement; dispid 1067;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseup: OleVariant dispid -2147412109;
    property onmousedown: OleVariant dispid -2147412110;
    property onmousemove: OleVariant dispid -2147412108;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onreadystatechange: OleVariant dispid -2147412087;
    property onafterupdate: OleVariant dispid -2147412090;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondragstart: OleVariant dispid -2147412077;
    property onselectstart: OleVariant dispid -2147412075;
    function  elementFromPoint(x: Integer; y: Integer): IHTMLElement; dispid 1068;
    property parentWindow: IHTMLWindow2 readonly dispid 1034;
    property styleSheets: IHTMLStyleSheetsCollection readonly dispid 1069;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onerrorupdate: OleVariant dispid -2147412074;
    function  toString: WideString; dispid 1070;
    function  createStyleSheet(const bstrHref: WideString; lIndex: Integer): IHTMLStyleSheet; dispid 1071;
    property Script: IDispatch readonly dispid 1001;
  end;

// *********************************************************************//
// Interface: IHTMLElementCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F21F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLElementCollection = interface(IDispatch)
    ['{3050F21F-98B5-11CF-BB82-00AA00BDCE0B}']
    function  toString: WideString; safecall;
    procedure Set_length(p: Integer); safecall;
    function  Get_length: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  item(name: OleVariant; index: OleVariant): IDispatch; safecall;
    function  tags(tagName: OleVariant): IDispatch; safecall;
    property length: Integer read Get_length write Set_length;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IHTMLElementCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F21F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLElementCollectionDisp = dispinterface
    ['{3050F21F-98B5-11CF-BB82-00AA00BDCE0B}']
    function  toString: WideString; dispid 1501;
    property length: Integer dispid 1500;
    property _NewEnum: IUnknown readonly dispid -4;
    function  item(name: OleVariant; index: OleVariant): IDispatch; dispid 0;
    function  tags(tagName: OleVariant): IDispatch; dispid 1502;
  end;

// *********************************************************************//
// Interface: IHTMLElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1FF-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLElement = interface(IDispatch)
    ['{3050F1FF-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); safecall;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; safecall;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; safecall;
    procedure Set_className(const p: WideString); safecall;
    function  Get_className: WideString; safecall;
    procedure Set_id(const p: WideString); safecall;
    function  Get_id: WideString; safecall;
    function  Get_tagName: WideString; safecall;
    function  Get_parentElement: IHTMLElement; safecall;
    function  Get_style: IHTMLStyle; safecall;
    procedure Set_onhelp(p: OleVariant); safecall;
    function  Get_onhelp: OleVariant; safecall;
    procedure Set_onclick(p: OleVariant); safecall;
    function  Get_onclick: OleVariant; safecall;
    procedure Set_ondblclick(p: OleVariant); safecall;
    function  Get_ondblclick: OleVariant; safecall;
    procedure Set_onkeydown(p: OleVariant); safecall;
    function  Get_onkeydown: OleVariant; safecall;
    procedure Set_onkeyup(p: OleVariant); safecall;
    function  Get_onkeyup: OleVariant; safecall;
    procedure Set_onkeypress(p: OleVariant); safecall;
    function  Get_onkeypress: OleVariant; safecall;
    procedure Set_onmouseout(p: OleVariant); safecall;
    function  Get_onmouseout: OleVariant; safecall;
    procedure Set_onmouseover(p: OleVariant); safecall;
    function  Get_onmouseover: OleVariant; safecall;
    procedure Set_onmousemove(p: OleVariant); safecall;
    function  Get_onmousemove: OleVariant; safecall;
    procedure Set_onmousedown(p: OleVariant); safecall;
    function  Get_onmousedown: OleVariant; safecall;
    procedure Set_onmouseup(p: OleVariant); safecall;
    function  Get_onmouseup: OleVariant; safecall;
    function  Get_Document: IDispatch; safecall;
    procedure Set_title(const p: WideString); safecall;
    function  Get_title: WideString; safecall;
    procedure Set_language(const p: WideString); safecall;
    function  Get_language: WideString; safecall;
    procedure Set_onselectstart(p: OleVariant); safecall;
    function  Get_onselectstart: OleVariant; safecall;
    procedure scrollIntoView(varargStart: OleVariant); safecall;
    function  contains(const pChild: IHTMLElement): WordBool; safecall;
    function  Get_sourceIndex: Integer; safecall;
    function  Get_recordNumber: OleVariant; safecall;
    procedure Set_lang(const p: WideString); safecall;
    function  Get_lang: WideString; safecall;
    function  Get_offsetLeft: Integer; safecall;
    function  Get_offsetTop: Integer; safecall;
    function  Get_offsetWidth: Integer; safecall;
    function  Get_offsetHeight: Integer; safecall;
    function  Get_offsetParent: IHTMLElement; safecall;
    procedure Set_innerHTML(const p: WideString); safecall;
    function  Get_innerHTML: WideString; safecall;
    procedure Set_innerText(const p: WideString); safecall;
    function  Get_innerText: WideString; safecall;
    procedure Set_outerHTML(const p: WideString); safecall;
    function  Get_outerHTML: WideString; safecall;
    procedure Set_outerText(const p: WideString); safecall;
    function  Get_outerText: WideString; safecall;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); safecall;
    procedure insertAdjacentText(const where: WideString; const text: WideString); safecall;
    function  Get_parentTextEdit: IHTMLElement; safecall;
    function  Get_isTextEdit: WordBool; safecall;
    procedure click; safecall;
    function  Get_filters: IHTMLFiltersCollection; safecall;
    procedure Set_ondragstart(p: OleVariant); safecall;
    function  Get_ondragstart: OleVariant; safecall;
    function  toString: WideString; safecall;
    procedure Set_onbeforeupdate(p: OleVariant); safecall;
    function  Get_onbeforeupdate: OleVariant; safecall;
    procedure Set_onafterupdate(p: OleVariant); safecall;
    function  Get_onafterupdate: OleVariant; safecall;
    procedure Set_onerrorupdate(p: OleVariant); safecall;
    function  Get_onerrorupdate: OleVariant; safecall;
    procedure Set_onrowexit(p: OleVariant); safecall;
    function  Get_onrowexit: OleVariant; safecall;
    procedure Set_onrowenter(p: OleVariant); safecall;
    function  Get_onrowenter: OleVariant; safecall;
    procedure Set_ondatasetchanged(p: OleVariant); safecall;
    function  Get_ondatasetchanged: OleVariant; safecall;
    procedure Set_ondataavailable(p: OleVariant); safecall;
    function  Get_ondataavailable: OleVariant; safecall;
    procedure Set_ondatasetcomplete(p: OleVariant); safecall;
    function  Get_ondatasetcomplete: OleVariant; safecall;
    procedure Set_onfilterchange(p: OleVariant); safecall;
    function  Get_onfilterchange: OleVariant; safecall;
    function  Get_children: IDispatch; safecall;
    function  Get_all: IDispatch; safecall;
    property className: WideString read Get_className write Set_className;
    property id: WideString read Get_id write Set_id;
    property tagName: WideString read Get_tagName;
    property parentElement: IHTMLElement read Get_parentElement;
    property style: IHTMLStyle read Get_style;
    property onhelp: OleVariant read Get_onhelp write Set_onhelp;
    property onclick: OleVariant read Get_onclick write Set_onclick;
    property ondblclick: OleVariant read Get_ondblclick write Set_ondblclick;
    property onkeydown: OleVariant read Get_onkeydown write Set_onkeydown;
    property onkeyup: OleVariant read Get_onkeyup write Set_onkeyup;
    property onkeypress: OleVariant read Get_onkeypress write Set_onkeypress;
    property onmouseout: OleVariant read Get_onmouseout write Set_onmouseout;
    property onmouseover: OleVariant read Get_onmouseover write Set_onmouseover;
    property onmousemove: OleVariant read Get_onmousemove write Set_onmousemove;
    property onmousedown: OleVariant read Get_onmousedown write Set_onmousedown;
    property onmouseup: OleVariant read Get_onmouseup write Set_onmouseup;
    property Document: IDispatch read Get_Document;
    property title: WideString read Get_title write Set_title;
    property language: WideString read Get_language write Set_language;
    property onselectstart: OleVariant read Get_onselectstart write Set_onselectstart;
    property sourceIndex: Integer read Get_sourceIndex;
    property recordNumber: OleVariant read Get_recordNumber;
    property lang: WideString read Get_lang write Set_lang;
    property offsetLeft: Integer read Get_offsetLeft;
    property offsetTop: Integer read Get_offsetTop;
    property offsetWidth: Integer read Get_offsetWidth;
    property offsetHeight: Integer read Get_offsetHeight;
    property offsetParent: IHTMLElement read Get_offsetParent;
    property innerHTML: WideString read Get_innerHTML write Set_innerHTML;
    property innerText: WideString read Get_innerText write Set_innerText;
    property outerHTML: WideString read Get_outerHTML write Set_outerHTML;
    property outerText: WideString read Get_outerText write Set_outerText;
    property parentTextEdit: IHTMLElement read Get_parentTextEdit;
    property isTextEdit: WordBool read Get_isTextEdit;
    property filters: IHTMLFiltersCollection read Get_filters;
    property ondragstart: OleVariant read Get_ondragstart write Set_ondragstart;
    property onbeforeupdate: OleVariant read Get_onbeforeupdate write Set_onbeforeupdate;
    property onafterupdate: OleVariant read Get_onafterupdate write Set_onafterupdate;
    property onerrorupdate: OleVariant read Get_onerrorupdate write Set_onerrorupdate;
    property onrowexit: OleVariant read Get_onrowexit write Set_onrowexit;
    property onrowenter: OleVariant read Get_onrowenter write Set_onrowenter;
    property ondatasetchanged: OleVariant read Get_ondatasetchanged write Set_ondatasetchanged;
    property ondataavailable: OleVariant read Get_ondataavailable write Set_ondataavailable;
    property ondatasetcomplete: OleVariant read Get_ondatasetcomplete write Set_ondatasetcomplete;
    property onfilterchange: OleVariant read Get_onfilterchange write Set_onfilterchange;
    property children: IDispatch read Get_children;
    property all: IDispatch read Get_all;
  end;

// *********************************************************************//
// DispIntf:  IHTMLElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1FF-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLElementDisp = dispinterface
    ['{3050F1FF-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
  end;

// *********************************************************************//
// Interface: IHTMLStyle
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F25E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyle = interface(IDispatch)
    ['{3050F25E-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_fontFamily(const p: WideString); safecall;
    function  Get_fontFamily: WideString; safecall;
    procedure Set_fontStyle(const p: WideString); safecall;
    function  Get_fontStyle: WideString; safecall;
    procedure Set_fontVariant(const p: WideString); safecall;
    function  Get_fontVariant: WideString; safecall;
    procedure Set_fontWeight(const p: WideString); safecall;
    function  Get_fontWeight: WideString; safecall;
    procedure Set_fontSize(p: OleVariant); safecall;
    function  Get_fontSize: OleVariant; safecall;
    procedure Set_font(const p: WideString); safecall;
    function  Get_font: WideString; safecall;
    procedure Set_color(p: OleVariant); safecall;
    function  Get_color: OleVariant; safecall;
    procedure Set_background(const p: WideString); safecall;
    function  Get_background: WideString; safecall;
    procedure Set_backgroundColor(p: OleVariant); safecall;
    function  Get_backgroundColor: OleVariant; safecall;
    procedure Set_backgroundImage(const p: WideString); safecall;
    function  Get_backgroundImage: WideString; safecall;
    procedure Set_backgroundRepeat(const p: WideString); safecall;
    function  Get_backgroundRepeat: WideString; safecall;
    procedure Set_backgroundAttachment(const p: WideString); safecall;
    function  Get_backgroundAttachment: WideString; safecall;
    procedure Set_backgroundPosition(const p: WideString); safecall;
    function  Get_backgroundPosition: WideString; safecall;
    procedure Set_backgroundPositionX(p: OleVariant); safecall;
    function  Get_backgroundPositionX: OleVariant; safecall;
    procedure Set_backgroundPositionY(p: OleVariant); safecall;
    function  Get_backgroundPositionY: OleVariant; safecall;
    procedure Set_wordSpacing(p: OleVariant); safecall;
    function  Get_wordSpacing: OleVariant; safecall;
    procedure Set_letterSpacing(p: OleVariant); safecall;
    function  Get_letterSpacing: OleVariant; safecall;
    procedure Set_textDecoration(const p: WideString); safecall;
    function  Get_textDecoration: WideString; safecall;
    procedure Set_textDecorationNone(p: WordBool); safecall;
    function  Get_textDecorationNone: WordBool; safecall;
    procedure Set_textDecorationUnderline(p: WordBool); safecall;
    function  Get_textDecorationUnderline: WordBool; safecall;
    procedure Set_textDecorationOverline(p: WordBool); safecall;
    function  Get_textDecorationOverline: WordBool; safecall;
    procedure Set_textDecorationLineThrough(p: WordBool); safecall;
    function  Get_textDecorationLineThrough: WordBool; safecall;
    procedure Set_textDecorationBlink(p: WordBool); safecall;
    function  Get_textDecorationBlink: WordBool; safecall;
    procedure Set_verticalAlign(p: OleVariant); safecall;
    function  Get_verticalAlign: OleVariant; safecall;
    procedure Set_textTransform(const p: WideString); safecall;
    function  Get_textTransform: WideString; safecall;
    procedure Set_textAlign(const p: WideString); safecall;
    function  Get_textAlign: WideString; safecall;
    procedure Set_textIndent(p: OleVariant); safecall;
    function  Get_textIndent: OleVariant; safecall;
    procedure Set_lineHeight(p: OleVariant); safecall;
    function  Get_lineHeight: OleVariant; safecall;
    procedure Set_marginTop(p: OleVariant); safecall;
    function  Get_marginTop: OleVariant; safecall;
    procedure Set_marginRight(p: OleVariant); safecall;
    function  Get_marginRight: OleVariant; safecall;
    procedure Set_marginBottom(p: OleVariant); safecall;
    function  Get_marginBottom: OleVariant; safecall;
    procedure Set_marginLeft(p: OleVariant); safecall;
    function  Get_marginLeft: OleVariant; safecall;
    procedure Set_margin(const p: WideString); safecall;
    function  Get_margin: WideString; safecall;
    procedure Set_paddingTop(p: OleVariant); safecall;
    function  Get_paddingTop: OleVariant; safecall;
    procedure Set_paddingRight(p: OleVariant); safecall;
    function  Get_paddingRight: OleVariant; safecall;
    procedure Set_paddingBottom(p: OleVariant); safecall;
    function  Get_paddingBottom: OleVariant; safecall;
    procedure Set_paddingLeft(p: OleVariant); safecall;
    function  Get_paddingLeft: OleVariant; safecall;
    procedure Set_padding(const p: WideString); safecall;
    function  Get_padding: WideString; safecall;
    procedure Set_border(const p: WideString); safecall;
    function  Get_border: WideString; safecall;
    procedure Set_borderTop(const p: WideString); safecall;
    function  Get_borderTop: WideString; safecall;
    procedure Set_borderRight(const p: WideString); safecall;
    function  Get_borderRight: WideString; safecall;
    procedure Set_borderBottom(const p: WideString); safecall;
    function  Get_borderBottom: WideString; safecall;
    procedure Set_borderLeft(const p: WideString); safecall;
    function  Get_borderLeft: WideString; safecall;
    procedure Set_borderColor(const p: WideString); safecall;
    function  Get_borderColor: WideString; safecall;
    procedure Set_borderTopColor(p: OleVariant); safecall;
    function  Get_borderTopColor: OleVariant; safecall;
    procedure Set_borderRightColor(p: OleVariant); safecall;
    function  Get_borderRightColor: OleVariant; safecall;
    procedure Set_borderBottomColor(p: OleVariant); safecall;
    function  Get_borderBottomColor: OleVariant; safecall;
    procedure Set_borderLeftColor(p: OleVariant); safecall;
    function  Get_borderLeftColor: OleVariant; safecall;
    procedure Set_borderWidth(const p: WideString); safecall;
    function  Get_borderWidth: WideString; safecall;
    procedure Set_borderTopWidth(p: OleVariant); safecall;
    function  Get_borderTopWidth: OleVariant; safecall;
    procedure Set_borderRightWidth(p: OleVariant); safecall;
    function  Get_borderRightWidth: OleVariant; safecall;
    procedure Set_borderBottomWidth(p: OleVariant); safecall;
    function  Get_borderBottomWidth: OleVariant; safecall;
    procedure Set_borderLeftWidth(p: OleVariant); safecall;
    function  Get_borderLeftWidth: OleVariant; safecall;
    procedure Set_borderStyle(const p: WideString); safecall;
    function  Get_borderStyle: WideString; safecall;
    procedure Set_borderTopStyle(const p: WideString); safecall;
    function  Get_borderTopStyle: WideString; safecall;
    procedure Set_borderRightStyle(const p: WideString); safecall;
    function  Get_borderRightStyle: WideString; safecall;
    procedure Set_borderBottomStyle(const p: WideString); safecall;
    function  Get_borderBottomStyle: WideString; safecall;
    procedure Set_borderLeftStyle(const p: WideString); safecall;
    function  Get_borderLeftStyle: WideString; safecall;
    procedure Set_width(p: OleVariant); safecall;
    function  Get_width: OleVariant; safecall;
    procedure Set_height(p: OleVariant); safecall;
    function  Get_height: OleVariant; safecall;
    procedure Set_styleFloat(const p: WideString); safecall;
    function  Get_styleFloat: WideString; safecall;
    procedure Set_clear(const p: WideString); safecall;
    function  Get_clear: WideString; safecall;
    procedure Set_display(const p: WideString); safecall;
    function  Get_display: WideString; safecall;
    procedure Set_visibility(const p: WideString); safecall;
    function  Get_visibility: WideString; safecall;
    procedure Set_listStyleType(const p: WideString); safecall;
    function  Get_listStyleType: WideString; safecall;
    procedure Set_listStylePosition(const p: WideString); safecall;
    function  Get_listStylePosition: WideString; safecall;
    procedure Set_listStyleImage(const p: WideString); safecall;
    function  Get_listStyleImage: WideString; safecall;
    procedure Set_listStyle(const p: WideString); safecall;
    function  Get_listStyle: WideString; safecall;
    procedure Set_whiteSpace(const p: WideString); safecall;
    function  Get_whiteSpace: WideString; safecall;
    procedure Set_top(p: OleVariant); safecall;
    function  Get_top: OleVariant; safecall;
    procedure Set_left(p: OleVariant); safecall;
    function  Get_left: OleVariant; safecall;
    function  Get_position: WideString; safecall;
    procedure Set_zIndex(p: OleVariant); safecall;
    function  Get_zIndex: OleVariant; safecall;
    procedure Set_overflow(const p: WideString); safecall;
    function  Get_overflow: WideString; safecall;
    procedure Set_pageBreakBefore(const p: WideString); safecall;
    function  Get_pageBreakBefore: WideString; safecall;
    procedure Set_pageBreakAfter(const p: WideString); safecall;
    function  Get_pageBreakAfter: WideString; safecall;
    procedure Set_cssText(const p: WideString); safecall;
    function  Get_cssText: WideString; safecall;
    procedure Set_pixelTop(p: Integer); safecall;
    function  Get_pixelTop: Integer; safecall;
    procedure Set_pixelLeft(p: Integer); safecall;
    function  Get_pixelLeft: Integer; safecall;
    procedure Set_pixelWidth(p: Integer); safecall;
    function  Get_pixelWidth: Integer; safecall;
    procedure Set_pixelHeight(p: Integer); safecall;
    function  Get_pixelHeight: Integer; safecall;
    procedure Set_posTop(p: Single); safecall;
    function  Get_posTop: Single; safecall;
    procedure Set_posLeft(p: Single); safecall;
    function  Get_posLeft: Single; safecall;
    procedure Set_posWidth(p: Single); safecall;
    function  Get_posWidth: Single; safecall;
    procedure Set_posHeight(p: Single); safecall;
    function  Get_posHeight: Single; safecall;
    procedure Set_cursor(const p: WideString); safecall;
    function  Get_cursor: WideString; safecall;
    procedure Set_clip(const p: WideString); safecall;
    function  Get_clip: WideString; safecall;
    procedure Set_filter(const p: WideString); safecall;
    function  Get_filter: WideString; safecall;
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); safecall;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; safecall;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; safecall;
    function  toString: WideString; safecall;
    property fontFamily: WideString read Get_fontFamily write Set_fontFamily;
    property fontStyle: WideString read Get_fontStyle write Set_fontStyle;
    property fontVariant: WideString read Get_fontVariant write Set_fontVariant;
    property fontWeight: WideString read Get_fontWeight write Set_fontWeight;
    property fontSize: OleVariant read Get_fontSize write Set_fontSize;
    property font: WideString read Get_font write Set_font;
    property color: OleVariant read Get_color write Set_color;
    property background: WideString read Get_background write Set_background;
    property backgroundColor: OleVariant read Get_backgroundColor write Set_backgroundColor;
    property backgroundImage: WideString read Get_backgroundImage write Set_backgroundImage;
    property backgroundRepeat: WideString read Get_backgroundRepeat write Set_backgroundRepeat;
    property backgroundAttachment: WideString read Get_backgroundAttachment write Set_backgroundAttachment;
    property backgroundPosition: WideString read Get_backgroundPosition write Set_backgroundPosition;
    property backgroundPositionX: OleVariant read Get_backgroundPositionX write Set_backgroundPositionX;
    property backgroundPositionY: OleVariant read Get_backgroundPositionY write Set_backgroundPositionY;
    property wordSpacing: OleVariant read Get_wordSpacing write Set_wordSpacing;
    property letterSpacing: OleVariant read Get_letterSpacing write Set_letterSpacing;
    property textDecoration: WideString read Get_textDecoration write Set_textDecoration;
    property textDecorationNone: WordBool read Get_textDecorationNone write Set_textDecorationNone;
    property textDecorationUnderline: WordBool read Get_textDecorationUnderline write Set_textDecorationUnderline;
    property textDecorationOverline: WordBool read Get_textDecorationOverline write Set_textDecorationOverline;
    property textDecorationLineThrough: WordBool read Get_textDecorationLineThrough write Set_textDecorationLineThrough;
    property textDecorationBlink: WordBool read Get_textDecorationBlink write Set_textDecorationBlink;
    property verticalAlign: OleVariant read Get_verticalAlign write Set_verticalAlign;
    property textTransform: WideString read Get_textTransform write Set_textTransform;
    property textAlign: WideString read Get_textAlign write Set_textAlign;
    property textIndent: OleVariant read Get_textIndent write Set_textIndent;
    property lineHeight: OleVariant read Get_lineHeight write Set_lineHeight;
    property marginTop: OleVariant read Get_marginTop write Set_marginTop;
    property marginRight: OleVariant read Get_marginRight write Set_marginRight;
    property marginBottom: OleVariant read Get_marginBottom write Set_marginBottom;
    property marginLeft: OleVariant read Get_marginLeft write Set_marginLeft;
    property margin: WideString read Get_margin write Set_margin;
    property paddingTop: OleVariant read Get_paddingTop write Set_paddingTop;
    property paddingRight: OleVariant read Get_paddingRight write Set_paddingRight;
    property paddingBottom: OleVariant read Get_paddingBottom write Set_paddingBottom;
    property paddingLeft: OleVariant read Get_paddingLeft write Set_paddingLeft;
    property padding: WideString read Get_padding write Set_padding;
    property border: WideString read Get_border write Set_border;
    property borderTop: WideString read Get_borderTop write Set_borderTop;
    property borderRight: WideString read Get_borderRight write Set_borderRight;
    property borderBottom: WideString read Get_borderBottom write Set_borderBottom;
    property borderLeft: WideString read Get_borderLeft write Set_borderLeft;
    property borderColor: WideString read Get_borderColor write Set_borderColor;
    property borderTopColor: OleVariant read Get_borderTopColor write Set_borderTopColor;
    property borderRightColor: OleVariant read Get_borderRightColor write Set_borderRightColor;
    property borderBottomColor: OleVariant read Get_borderBottomColor write Set_borderBottomColor;
    property borderLeftColor: OleVariant read Get_borderLeftColor write Set_borderLeftColor;
    property borderWidth: WideString read Get_borderWidth write Set_borderWidth;
    property borderTopWidth: OleVariant read Get_borderTopWidth write Set_borderTopWidth;
    property borderRightWidth: OleVariant read Get_borderRightWidth write Set_borderRightWidth;
    property borderBottomWidth: OleVariant read Get_borderBottomWidth write Set_borderBottomWidth;
    property borderLeftWidth: OleVariant read Get_borderLeftWidth write Set_borderLeftWidth;
    property borderStyle: WideString read Get_borderStyle write Set_borderStyle;
    property borderTopStyle: WideString read Get_borderTopStyle write Set_borderTopStyle;
    property borderRightStyle: WideString read Get_borderRightStyle write Set_borderRightStyle;
    property borderBottomStyle: WideString read Get_borderBottomStyle write Set_borderBottomStyle;
    property borderLeftStyle: WideString read Get_borderLeftStyle write Set_borderLeftStyle;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
    property styleFloat: WideString read Get_styleFloat write Set_styleFloat;
    property clear: WideString read Get_clear write Set_clear;
    property display: WideString read Get_display write Set_display;
    property visibility: WideString read Get_visibility write Set_visibility;
    property listStyleType: WideString read Get_listStyleType write Set_listStyleType;
    property listStylePosition: WideString read Get_listStylePosition write Set_listStylePosition;
    property listStyleImage: WideString read Get_listStyleImage write Set_listStyleImage;
    property listStyle: WideString read Get_listStyle write Set_listStyle;
    property whiteSpace: WideString read Get_whiteSpace write Set_whiteSpace;
    property top: OleVariant read Get_top write Set_top;
    property left: OleVariant read Get_left write Set_left;
    property position: WideString read Get_position;
    property zIndex: OleVariant read Get_zIndex write Set_zIndex;
    property overflow: WideString read Get_overflow write Set_overflow;
    property pageBreakBefore: WideString read Get_pageBreakBefore write Set_pageBreakBefore;
    property pageBreakAfter: WideString read Get_pageBreakAfter write Set_pageBreakAfter;
    property cssText: WideString read Get_cssText write Set_cssText;
    property pixelTop: Integer read Get_pixelTop write Set_pixelTop;
    property pixelLeft: Integer read Get_pixelLeft write Set_pixelLeft;
    property pixelWidth: Integer read Get_pixelWidth write Set_pixelWidth;
    property pixelHeight: Integer read Get_pixelHeight write Set_pixelHeight;
    property posTop: Single read Get_posTop write Set_posTop;
    property posLeft: Single read Get_posLeft write Set_posLeft;
    property posWidth: Single read Get_posWidth write Set_posWidth;
    property posHeight: Single read Get_posHeight write Set_posHeight;
    property cursor: WideString read Get_cursor write Set_cursor;
    property clip: WideString read Get_clip write Set_clip;
    property filter: WideString read Get_filter write Set_filter;
  end;

// *********************************************************************//
// DispIntf:  IHTMLStyleDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F25E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleDisp = dispinterface
    ['{3050F25E-98B5-11CF-BB82-00AA00BDCE0B}']
    property fontFamily: WideString dispid -2147413094;
    property fontStyle: WideString dispid -2147413088;
    property fontVariant: WideString dispid -2147413087;
    property fontWeight: WideString dispid -2147413085;
    property fontSize: OleVariant dispid -2147413093;
    property font: WideString dispid -2147413071;
    property color: OleVariant dispid -2147413110;
    property background: WideString dispid -2147413080;
    property backgroundColor: OleVariant dispid -501;
    property backgroundImage: WideString dispid -2147413111;
    property backgroundRepeat: WideString dispid -2147413068;
    property backgroundAttachment: WideString dispid -2147413067;
    property backgroundPosition: WideString dispid -2147413066;
    property backgroundPositionX: OleVariant dispid -2147413079;
    property backgroundPositionY: OleVariant dispid -2147413078;
    property wordSpacing: OleVariant dispid -2147413065;
    property letterSpacing: OleVariant dispid -2147413104;
    property textDecoration: WideString dispid -2147413077;
    property textDecorationNone: WordBool dispid -2147413089;
    property textDecorationUnderline: WordBool dispid -2147413091;
    property textDecorationOverline: WordBool dispid -2147413043;
    property textDecorationLineThrough: WordBool dispid -2147413092;
    property textDecorationBlink: WordBool dispid -2147413090;
    property verticalAlign: OleVariant dispid -2147413064;
    property textTransform: WideString dispid -2147413108;
    property textAlign: WideString dispid -2147418040;
    property textIndent: OleVariant dispid -2147413105;
    property lineHeight: OleVariant dispid -2147413106;
    property marginTop: OleVariant dispid -2147413075;
    property marginRight: OleVariant dispid -2147413074;
    property marginBottom: OleVariant dispid -2147413073;
    property marginLeft: OleVariant dispid -2147413072;
    property margin: WideString dispid -2147413076;
    property paddingTop: OleVariant dispid -2147413100;
    property paddingRight: OleVariant dispid -2147413099;
    property paddingBottom: OleVariant dispid -2147413098;
    property paddingLeft: OleVariant dispid -2147413097;
    property padding: WideString dispid -2147413101;
    property border: WideString dispid -2147413063;
    property borderTop: WideString dispid -2147413062;
    property borderRight: WideString dispid -2147413061;
    property borderBottom: WideString dispid -2147413060;
    property borderLeft: WideString dispid -2147413059;
    property borderColor: WideString dispid -2147413058;
    property borderTopColor: OleVariant dispid -2147413057;
    property borderRightColor: OleVariant dispid -2147413056;
    property borderBottomColor: OleVariant dispid -2147413055;
    property borderLeftColor: OleVariant dispid -2147413054;
    property borderWidth: WideString dispid -2147413053;
    property borderTopWidth: OleVariant dispid -2147413052;
    property borderRightWidth: OleVariant dispid -2147413051;
    property borderBottomWidth: OleVariant dispid -2147413050;
    property borderLeftWidth: OleVariant dispid -2147413049;
    property borderStyle: WideString dispid -2147413048;
    property borderTopStyle: WideString dispid -2147413047;
    property borderRightStyle: WideString dispid -2147413046;
    property borderBottomStyle: WideString dispid -2147413045;
    property borderLeftStyle: WideString dispid -2147413044;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property styleFloat: WideString dispid -2147413042;
    property clear: WideString dispid -2147413096;
    property display: WideString dispid -2147413041;
    property visibility: WideString dispid -2147413032;
    property listStyleType: WideString dispid -2147413040;
    property listStylePosition: WideString dispid -2147413039;
    property listStyleImage: WideString dispid -2147413038;
    property listStyle: WideString dispid -2147413037;
    property whiteSpace: WideString dispid -2147413036;
    property top: OleVariant dispid -2147418108;
    property left: OleVariant dispid -2147418109;
    property position: WideString readonly dispid -2147413022;
    property zIndex: OleVariant dispid -2147413021;
    property overflow: WideString dispid -2147413102;
    property pageBreakBefore: WideString dispid -2147413035;
    property pageBreakAfter: WideString dispid -2147413034;
    property cssText: WideString dispid -2147413013;
    property pixelTop: Integer dispid -2147414112;
    property pixelLeft: Integer dispid -2147414111;
    property pixelWidth: Integer dispid -2147414110;
    property pixelHeight: Integer dispid -2147414109;
    property posTop: Single dispid -2147414108;
    property posLeft: Single dispid -2147414107;
    property posWidth: Single dispid -2147414106;
    property posHeight: Single dispid -2147414105;
    property cursor: WideString dispid -2147413010;
    property clip: WideString dispid -2147413020;
    property filter: WideString dispid -2147413030;
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    function  toString: WideString; dispid -2147414104;
  end;

// *********************************************************************//
// Interface: IHTMLFiltersCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3EE-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFiltersCollection = interface(IDispatch)
    ['{3050F3EE-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_length: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  item(var pvarIndex: OleVariant): OleVariant; safecall;
    property length: Integer read Get_length;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IHTMLFiltersCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3EE-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFiltersCollectionDisp = dispinterface
    ['{3050F3EE-98B5-11CF-BB82-00AA00BDCE0B}']
    property length: Integer readonly dispid 1001;
    property _NewEnum: IUnknown readonly dispid -4;
    function  item(var pvarIndex: OleVariant): OleVariant; dispid 0;
  end;

// *********************************************************************//
// Interface: IHTMLSelectionObject
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F25A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLSelectionObject = interface(IDispatch)
    ['{3050F25A-98B5-11CF-BB82-00AA00BDCE0B}']
    function  createRange: IDispatch; safecall;
    procedure empty; safecall;
    procedure clear; safecall;
    function  Get_type_: WideString; safecall;
    property type_: WideString read Get_type_;
  end;

// *********************************************************************//
// DispIntf:  IHTMLSelectionObjectDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F25A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLSelectionObjectDisp = dispinterface
    ['{3050F25A-98B5-11CF-BB82-00AA00BDCE0B}']
    function  createRange: IDispatch; dispid 1001;
    procedure empty; dispid 1002;
    procedure clear; dispid 1003;
    property type_: WideString readonly dispid 1004;
  end;

// *********************************************************************//
// Interface: IHTMLFramesCollection2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {332C4426-26CB-11D0-B483-00C04FD90119}
// *********************************************************************//
  IHTMLFramesCollection2 = interface(IDispatch)
    ['{332C4426-26CB-11D0-B483-00C04FD90119}']
    function  item(var pvarIndex: OleVariant): OleVariant; safecall;
    function  Get_length: Integer; safecall;
    property length: Integer read Get_length;
  end;

// *********************************************************************//
// DispIntf:  IHTMLFramesCollection2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {332C4426-26CB-11D0-B483-00C04FD90119}
// *********************************************************************//
  IHTMLFramesCollection2Disp = dispinterface
    ['{332C4426-26CB-11D0-B483-00C04FD90119}']
    function  item(var pvarIndex: OleVariant): OleVariant; dispid 0;
    property length: Integer readonly dispid 1001;
  end;

// *********************************************************************//
// Interface: IHTMLLocation
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {163BB1E0-6E00-11CF-837A-48DC04C10000}
// *********************************************************************//
  IHTMLLocation = interface(IDispatch)
    ['{163BB1E0-6E00-11CF-837A-48DC04C10000}']
    procedure Set_href(const p: WideString); safecall;
    function  Get_href: WideString; safecall;
    procedure Set_protocol(const p: WideString); safecall;
    function  Get_protocol: WideString; safecall;
    procedure Set_host(const p: WideString); safecall;
    function  Get_host: WideString; safecall;
    procedure Set_hostname(const p: WideString); safecall;
    function  Get_hostname: WideString; safecall;
    procedure Set_port(const p: WideString); safecall;
    function  Get_port: WideString; safecall;
    procedure Set_pathname(const p: WideString); safecall;
    function  Get_pathname: WideString; safecall;
    procedure Set_search(const p: WideString); safecall;
    function  Get_search: WideString; safecall;
    procedure Set_hash(const p: WideString); safecall;
    function  Get_hash: WideString; safecall;
    procedure reload(flag: WordBool); safecall;
    procedure replace(const bstr: WideString); safecall;
    procedure Assign_(const bstr: WideString); safecall;
    function  toString: WideString; safecall;
    property href: WideString read Get_href write Set_href;
    property protocol: WideString read Get_protocol write Set_protocol;
    property host: WideString read Get_host write Set_host;
    property hostname: WideString read Get_hostname write Set_hostname;
    property port: WideString read Get_port write Set_port;
    property pathname: WideString read Get_pathname write Set_pathname;
    property search: WideString read Get_search write Set_search;
    property hash: WideString read Get_hash write Set_hash;
  end;

// *********************************************************************//
// DispIntf:  IHTMLLocationDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {163BB1E0-6E00-11CF-837A-48DC04C10000}
// *********************************************************************//
  IHTMLLocationDisp = dispinterface
    ['{163BB1E0-6E00-11CF-837A-48DC04C10000}']
    property href: WideString dispid 0;
    property protocol: WideString dispid 1;
    property host: WideString dispid 2;
    property hostname: WideString dispid 3;
    property port: WideString dispid 4;
    property pathname: WideString dispid 5;
    property search: WideString dispid 6;
    property hash: WideString dispid 7;
    procedure reload(flag: WordBool); dispid 8;
    procedure replace(const bstr: WideString); dispid 9;
    procedure Assign_(const bstr: WideString); dispid 10;
    function  toString: WideString; dispid 11;
  end;

// *********************************************************************//
// Interface: IHTMLWindow2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {332C4427-26CB-11D0-B483-00C04FD90119}
// *********************************************************************//
  IHTMLWindow2 = interface(IHTMLFramesCollection2)
    ['{332C4427-26CB-11D0-B483-00C04FD90119}']
    function  Get_frames: IHTMLFramesCollection2; safecall;
    procedure Set_defaultStatus(const p: WideString); safecall;
    function  Get_defaultStatus: WideString; safecall;
    procedure Set_status(const p: WideString); safecall;
    function  Get_status: WideString; safecall;
    function  setTimeout(const expression: WideString; msec: Integer; var language: OleVariant): Integer; safecall;
    procedure clearTimeout(timerID: Integer); safecall;
    procedure alert(const message: WideString); safecall;
    function  confirm(const message: WideString): WordBool; safecall;
    function  prompt(const message: WideString; const defstr: WideString): OleVariant; safecall;
    function  Get_Image: IHTMLImageElementFactory; safecall;
    function  Get_location: IHTMLLocation; safecall;
    function  Get_history: IOmHistory; safecall;
    procedure close; safecall;
    procedure Set_opener(p: OleVariant); safecall;
    function  Get_opener: OleVariant; safecall;
    function  Get_navigator: IOmNavigator; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    function  Get_parent: IHTMLWindow2; safecall;
    function  open(const URL: WideString; const name: WideString; const features: WideString;
                   replace: WordBool): IHTMLWindow2; safecall;
    function  Get_self: IHTMLWindow2; safecall;
    function  Get_top: IHTMLWindow2; safecall;
    function  Get_Window: IHTMLWindow2; safecall;
    procedure navigate(const URL: WideString); safecall;
    procedure Set_onfocus(p: OleVariant); safecall;
    function  Get_onfocus: OleVariant; safecall;
    procedure Set_onblur(p: OleVariant); safecall;
    function  Get_onblur: OleVariant; safecall;
    procedure Set_onload(p: OleVariant); safecall;
    function  Get_onload: OleVariant; safecall;
    procedure Set_onbeforeunload(p: OleVariant); safecall;
    function  Get_onbeforeunload: OleVariant; safecall;
    procedure Set_onunload(p: OleVariant); safecall;
    function  Get_onunload: OleVariant; safecall;
    procedure Set_onhelp(p: OleVariant); safecall;
    function  Get_onhelp: OleVariant; safecall;
    procedure Set_onerror(p: OleVariant); safecall;
    function  Get_onerror: OleVariant; safecall;
    procedure Set_onresize(p: OleVariant); safecall;
    function  Get_onresize: OleVariant; safecall;
    procedure Set_onscroll(p: OleVariant); safecall;
    function  Get_onscroll: OleVariant; safecall;
    function  Get_Document: IHTMLDocument2; safecall;
    function  Get_event: IHTMLEventObj; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  showModalDialog(const dialog: WideString; var varArgIn: OleVariant;
                              var varOptions: OleVariant): OleVariant; safecall;
    procedure showHelp(const helpURL: WideString; helpArg: OleVariant; const features: WideString); safecall;
    function  Get_screen: IHTMLScreen; safecall;
    function  Get_Option: IHTMLOptionElementFactory; safecall;
    procedure focus; safecall;
    function  Get_closed: WordBool; safecall;
    procedure blur; safecall;
    procedure scroll(x: Integer; y: Integer); safecall;
    function  Get_clientInformation: IOmNavigator; safecall;
    function  setInterval(const expression: WideString; msec: Integer; var language: OleVariant): Integer; safecall;
    procedure clearInterval(timerID: Integer); safecall;
    procedure Set_offscreenBuffering(p: OleVariant); safecall;
    function  Get_offscreenBuffering: OleVariant; safecall;
    function  execScript(const code: WideString; const language: WideString): OleVariant; safecall;
    function  toString: WideString; safecall;
    procedure scrollBy(x: Integer; y: Integer); safecall;
    procedure scrollTo(x: Integer; y: Integer); safecall;
    procedure moveTo(x: Integer; y: Integer); safecall;
    procedure moveBy(x: Integer; y: Integer); safecall;
    procedure resizeTo(x: Integer; y: Integer); safecall;
    procedure resizeBy(x: Integer; y: Integer); safecall;
    function  Get_external: IDispatch; safecall;
    property frames: IHTMLFramesCollection2 read Get_frames;
    property defaultStatus: WideString read Get_defaultStatus write Set_defaultStatus;
    property status: WideString read Get_status write Set_status;
    property Image: IHTMLImageElementFactory read Get_Image;
    property location: IHTMLLocation read Get_location;
    property history: IOmHistory read Get_history;
    property opener: OleVariant read Get_opener write Set_opener;
    property navigator: IOmNavigator read Get_navigator;
    property name: WideString read Get_name write Set_name;
    property parent: IHTMLWindow2 read Get_parent;
    property self: IHTMLWindow2 read Get_self;
    property top: IHTMLWindow2 read Get_top;
    property Window: IHTMLWindow2 read Get_Window;
    property onfocus: OleVariant read Get_onfocus write Set_onfocus;
    property onblur: OleVariant read Get_onblur write Set_onblur;
    property onload: OleVariant read Get_onload write Set_onload;
    property onbeforeunload: OleVariant read Get_onbeforeunload write Set_onbeforeunload;
    property onunload: OleVariant read Get_onunload write Set_onunload;
    property onhelp: OleVariant read Get_onhelp write Set_onhelp;
    property onerror: OleVariant read Get_onerror write Set_onerror;
    property onresize: OleVariant read Get_onresize write Set_onresize;
    property onscroll: OleVariant read Get_onscroll write Set_onscroll;
    property Document: IHTMLDocument2 read Get_Document;
    property event: IHTMLEventObj read Get_event;
    property _NewEnum: IUnknown read Get__NewEnum;
    property screen: IHTMLScreen read Get_screen;
    property Option: IHTMLOptionElementFactory read Get_Option;
    property closed: WordBool read Get_closed;
    property clientInformation: IOmNavigator read Get_clientInformation;
    property offscreenBuffering: OleVariant read Get_offscreenBuffering write Set_offscreenBuffering;
    property external: IDispatch read Get_external;
  end;

// *********************************************************************//
// DispIntf:  IHTMLWindow2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {332C4427-26CB-11D0-B483-00C04FD90119}
// *********************************************************************//
  IHTMLWindow2Disp = dispinterface
    ['{332C4427-26CB-11D0-B483-00C04FD90119}']
    property frames: IHTMLFramesCollection2 readonly dispid 1100;
    property defaultStatus: WideString dispid 1101;
    property status: WideString dispid 1102;
    function  setTimeout(const expression: WideString; msec: Integer; var language: OleVariant): Integer; dispid 1103;
    procedure clearTimeout(timerID: Integer); dispid 1104;
    procedure alert(const message: WideString); dispid 1105;
    function  confirm(const message: WideString): WordBool; dispid 1110;
    function  prompt(const message: WideString; const defstr: WideString): OleVariant; dispid 1111;
    property Image: IHTMLImageElementFactory readonly dispid 1125;
    property location: IHTMLLocation readonly dispid 14;
    property history: IOmHistory readonly dispid 2;
    procedure close; dispid 3;
    property opener: OleVariant dispid 4;
    property navigator: IOmNavigator readonly dispid 5;
    property name: WideString dispid 11;
    property parent: IHTMLWindow2 readonly dispid 12;
    function  open(const URL: WideString; const name: WideString; const features: WideString;
                   replace: WordBool): IHTMLWindow2; dispid 13;
    property self: IHTMLWindow2 readonly dispid 20;
    property top: IHTMLWindow2 readonly dispid 21;
    property Window: IHTMLWindow2 readonly dispid 22;
    procedure navigate(const URL: WideString); dispid 25;
    property onfocus: OleVariant dispid -2147412098;
    property onblur: OleVariant dispid -2147412097;
    property onload: OleVariant dispid -2147412080;
    property onbeforeunload: OleVariant dispid -2147412073;
    property onunload: OleVariant dispid -2147412079;
    property onhelp: OleVariant dispid -2147412099;
    property onerror: OleVariant dispid -2147412083;
    property onresize: OleVariant dispid -2147412076;
    property onscroll: OleVariant dispid -2147412081;
    property Document: IHTMLDocument2 readonly dispid 1151;
    property event: IHTMLEventObj readonly dispid 1152;
    property _NewEnum: IUnknown readonly dispid 1153;
    function  showModalDialog(const dialog: WideString; var varArgIn: OleVariant;
                              var varOptions: OleVariant): OleVariant; dispid 1154;
    procedure showHelp(const helpURL: WideString; helpArg: OleVariant; const features: WideString); dispid 1155;
    property screen: IHTMLScreen readonly dispid 1156;
    property Option: IHTMLOptionElementFactory readonly dispid 1157;
    procedure focus; dispid 1158;
    property closed: WordBool readonly dispid 23;
    procedure blur; dispid 1159;
    procedure scroll(x: Integer; y: Integer); dispid 1160;
    property clientInformation: IOmNavigator readonly dispid 1161;
    function  setInterval(const expression: WideString; msec: Integer; var language: OleVariant): Integer; dispid 1162;
    procedure clearInterval(timerID: Integer); dispid 1163;
    property offscreenBuffering: OleVariant dispid 1164;
    function  execScript(const code: WideString; const language: WideString): OleVariant; dispid 1165;
    function  toString: WideString; dispid 1166;
    procedure scrollBy(x: Integer; y: Integer); dispid 1167;
    procedure scrollTo(x: Integer; y: Integer); dispid 1168;
    procedure moveTo(x: Integer; y: Integer); dispid 6;
    procedure moveBy(x: Integer; y: Integer); dispid 7;
    procedure resizeTo(x: Integer; y: Integer); dispid 9;
    procedure resizeBy(x: Integer; y: Integer); dispid 8;
    property external: IDispatch readonly dispid 1169;
    function  item(var pvarIndex: OleVariant): OleVariant; dispid 0;
    property length: Integer readonly dispid 1001;
  end;

// *********************************************************************//
// Interface: IHTMLImageElementFactory
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F38E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLImageElementFactory = interface(IDispatch)
    ['{3050F38E-98B5-11CF-BB82-00AA00BDCE0B}']
    function  create(width: OleVariant; height: OleVariant): IHTMLImgElement; safecall;
  end;

// *********************************************************************//
// DispIntf:  IHTMLImageElementFactoryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F38E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLImageElementFactoryDisp = dispinterface
    ['{3050F38E-98B5-11CF-BB82-00AA00BDCE0B}']
    function  create(width: OleVariant; height: OleVariant): IHTMLImgElement; dispid 0;
  end;

// *********************************************************************//
// Interface: IHTMLImgElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F240-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLImgElement = interface(IDispatch)
    ['{3050F240-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_isMap(p: WordBool); safecall;
    function  Get_isMap: WordBool; safecall;
    procedure Set_useMap(const p: WideString); safecall;
    function  Get_useMap: WideString; safecall;
    function  Get_mimeType: WideString; safecall;
    function  Get_fileSize: WideString; safecall;
    function  Get_fileCreatedDate: WideString; safecall;
    function  Get_fileModifiedDate: WideString; safecall;
    function  Get_fileUpdatedDate: WideString; safecall;
    function  Get_protocol: WideString; safecall;
    function  Get_href: WideString; safecall;
    function  Get_nameProp: WideString; safecall;
    procedure Set_border(p: OleVariant); safecall;
    function  Get_border: OleVariant; safecall;
    procedure Set_vspace(p: Integer); safecall;
    function  Get_vspace: Integer; safecall;
    procedure Set_hspace(p: Integer); safecall;
    function  Get_hspace: Integer; safecall;
    procedure Set_alt(const p: WideString); safecall;
    function  Get_alt: WideString; safecall;
    procedure Set_src(const p: WideString); safecall;
    function  Get_src: WideString; safecall;
    procedure Set_lowsrc(const p: WideString); safecall;
    function  Get_lowsrc: WideString; safecall;
    procedure Set_vrml(const p: WideString); safecall;
    function  Get_vrml: WideString; safecall;
    procedure Set_dynsrc(const p: WideString); safecall;
    function  Get_dynsrc: WideString; safecall;
    function  Get_ReadyState: WideString; safecall;
    function  Get_complete: WordBool; safecall;
    procedure Set_loop(p: OleVariant); safecall;
    function  Get_loop: OleVariant; safecall;
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_onload(p: OleVariant); safecall;
    function  Get_onload: OleVariant; safecall;
    procedure Set_onerror(p: OleVariant); safecall;
    function  Get_onerror: OleVariant; safecall;
    procedure Set_onabort(p: OleVariant); safecall;
    function  Get_onabort: OleVariant; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_width(p: Integer); safecall;
    function  Get_width: Integer; safecall;
    procedure Set_height(p: Integer); safecall;
    function  Get_height: Integer; safecall;
    procedure Set_start(const p: WideString); safecall;
    function  Get_start: WideString; safecall;
    property isMap: WordBool read Get_isMap write Set_isMap;
    property useMap: WideString read Get_useMap write Set_useMap;
    property mimeType: WideString read Get_mimeType;
    property fileSize: WideString read Get_fileSize;
    property fileCreatedDate: WideString read Get_fileCreatedDate;
    property fileModifiedDate: WideString read Get_fileModifiedDate;
    property fileUpdatedDate: WideString read Get_fileUpdatedDate;
    property protocol: WideString read Get_protocol;
    property href: WideString read Get_href;
    property nameProp: WideString read Get_nameProp;
    property border: OleVariant read Get_border write Set_border;
    property vspace: Integer read Get_vspace write Set_vspace;
    property hspace: Integer read Get_hspace write Set_hspace;
    property alt: WideString read Get_alt write Set_alt;
    property src: WideString read Get_src write Set_src;
    property lowsrc: WideString read Get_lowsrc write Set_lowsrc;
    property vrml: WideString read Get_vrml write Set_vrml;
    property dynsrc: WideString read Get_dynsrc write Set_dynsrc;
    property ReadyState: WideString read Get_ReadyState;
    property complete: WordBool read Get_complete;
    property loop: OleVariant read Get_loop write Set_loop;
    property align: WideString read Get_align write Set_align;
    property onload: OleVariant read Get_onload write Set_onload;
    property onerror: OleVariant read Get_onerror write Set_onerror;
    property onabort: OleVariant read Get_onabort write Set_onabort;
    property name: WideString read Get_name write Set_name;
    property width: Integer read Get_width write Set_width;
    property height: Integer read Get_height write Set_height;
    property start: WideString read Get_start write Set_start;
  end;

// *********************************************************************//
// DispIntf:  IHTMLImgElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F240-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLImgElementDisp = dispinterface
    ['{3050F240-98B5-11CF-BB82-00AA00BDCE0B}']
    property isMap: WordBool dispid 2002;
    property useMap: WideString dispid 2008;
    property mimeType: WideString readonly dispid 2010;
    property fileSize: WideString readonly dispid 2011;
    property fileCreatedDate: WideString readonly dispid 2012;
    property fileModifiedDate: WideString readonly dispid 2013;
    property fileUpdatedDate: WideString readonly dispid 2014;
    property protocol: WideString readonly dispid 2015;
    property href: WideString readonly dispid 2016;
    property nameProp: WideString readonly dispid 2017;
    property border: OleVariant dispid 1004;
    property vspace: Integer dispid 1005;
    property hspace: Integer dispid 1006;
    property alt: WideString dispid 1002;
    property src: WideString dispid 1003;
    property lowsrc: WideString dispid 1007;
    property vrml: WideString dispid 1008;
    property dynsrc: WideString dispid 1009;
    property ReadyState: WideString readonly dispid 1012;
    property complete: WordBool readonly dispid 1010;
    property loop: OleVariant dispid 1011;
    property align: WideString dispid -2147418039;
    property onload: OleVariant dispid -2147412080;
    property onerror: OleVariant dispid -2147412083;
    property onabort: OleVariant dispid -2147412084;
    property name: WideString dispid -2147418112;
    property width: Integer dispid -2147418107;
    property height: Integer dispid -2147418106;
    property start: WideString dispid 1013;
  end;

// *********************************************************************//
// Interface: IOmHistory
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FECEAAA2-8405-11CF-8BA1-00AA00476DA6}
// *********************************************************************//
  IOmHistory = interface(IDispatch)
    ['{FECEAAA2-8405-11CF-8BA1-00AA00476DA6}']
    function  Get_length: Smallint; safecall;
    procedure back(var pvargdistance: OleVariant); safecall;
    procedure forward(var pvargdistance: OleVariant); safecall;
    procedure go(var pvargdistance: OleVariant); safecall;
    property length: Smallint read Get_length;
  end;

// *********************************************************************//
// DispIntf:  IOmHistoryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FECEAAA2-8405-11CF-8BA1-00AA00476DA6}
// *********************************************************************//
  IOmHistoryDisp = dispinterface
    ['{FECEAAA2-8405-11CF-8BA1-00AA00476DA6}']
    property length: Smallint readonly dispid 1;
    procedure back(var pvargdistance: OleVariant); dispid 2;
    procedure forward(var pvargdistance: OleVariant); dispid 3;
    procedure go(var pvargdistance: OleVariant); dispid 4;
  end;

// *********************************************************************//
// Interface: IOmNavigator
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FECEAAA5-8405-11CF-8BA1-00AA00476DA6}
// *********************************************************************//
  IOmNavigator = interface(IDispatch)
    ['{FECEAAA5-8405-11CF-8BA1-00AA00476DA6}']
    function  Get_appCodeName: WideString; safecall;
    function  Get_appName: WideString; safecall;
    function  Get_appVersion: WideString; safecall;
    function  Get_userAgent: WideString; safecall;
    function  javaEnabled: WordBool; safecall;
    function  taintEnabled: WordBool; safecall;
    function  Get_mimeTypes: IHTMLMimeTypesCollection; safecall;
    function  Get_plugins: IHTMLPluginsCollection; safecall;
    function  Get_cookieEnabled: WordBool; safecall;
    function  Get_opsProfile: IHTMLOpsProfile; safecall;
    function  toString: WideString; safecall;
    function  Get_cpuClass: WideString; safecall;
    function  Get_systemLanguage: WideString; safecall;
    function  Get_browserLanguage: WideString; safecall;
    function  Get_userLanguage: WideString; safecall;
    function  Get_platform: WideString; safecall;
    function  Get_appMinorVersion: WideString; safecall;
    function  Get_connectionSpeed: Integer; safecall;
    function  Get_onLine: WordBool; safecall;
    function  Get_userProfile: IHTMLOpsProfile; safecall;
    property appCodeName: WideString read Get_appCodeName;
    property appName: WideString read Get_appName;
    property appVersion: WideString read Get_appVersion;
    property userAgent: WideString read Get_userAgent;
    property mimeTypes: IHTMLMimeTypesCollection read Get_mimeTypes;
    property plugins: IHTMLPluginsCollection read Get_plugins;
    property cookieEnabled: WordBool read Get_cookieEnabled;
    property opsProfile: IHTMLOpsProfile read Get_opsProfile;
    property cpuClass: WideString read Get_cpuClass;
    property systemLanguage: WideString read Get_systemLanguage;
    property browserLanguage: WideString read Get_browserLanguage;
    property userLanguage: WideString read Get_userLanguage;
    property platform: WideString read Get_platform;
    property appMinorVersion: WideString read Get_appMinorVersion;
    property connectionSpeed: Integer read Get_connectionSpeed;
    property onLine: WordBool read Get_onLine;
    property userProfile: IHTMLOpsProfile read Get_userProfile;
  end;

// *********************************************************************//
// DispIntf:  IOmNavigatorDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {FECEAAA5-8405-11CF-8BA1-00AA00476DA6}
// *********************************************************************//
  IOmNavigatorDisp = dispinterface
    ['{FECEAAA5-8405-11CF-8BA1-00AA00476DA6}']
    property appCodeName: WideString readonly dispid 1;
    property appName: WideString readonly dispid 2;
    property appVersion: WideString readonly dispid 3;
    property userAgent: WideString readonly dispid 4;
    function  javaEnabled: WordBool; dispid 5;
    function  taintEnabled: WordBool; dispid 6;
    property mimeTypes: IHTMLMimeTypesCollection readonly dispid 7;
    property plugins: IHTMLPluginsCollection readonly dispid 8;
    property cookieEnabled: WordBool readonly dispid 9;
    property opsProfile: IHTMLOpsProfile readonly dispid 10;
    function  toString: WideString; dispid 11;
    property cpuClass: WideString readonly dispid 12;
    property systemLanguage: WideString readonly dispid 13;
    property browserLanguage: WideString readonly dispid 14;
    property userLanguage: WideString readonly dispid 15;
    property platform: WideString readonly dispid 16;
    property appMinorVersion: WideString readonly dispid 17;
    property connectionSpeed: Integer readonly dispid 18;
    property onLine: WordBool readonly dispid 19;
    property userProfile: IHTMLOpsProfile readonly dispid 20;
  end;

// *********************************************************************//
// Interface: IHTMLMimeTypesCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3FC-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLMimeTypesCollection = interface(IDispatch)
    ['{3050F3FC-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_length: Integer; safecall;
    property length: Integer read Get_length;
  end;

// *********************************************************************//
// DispIntf:  IHTMLMimeTypesCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3FC-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLMimeTypesCollectionDisp = dispinterface
    ['{3050F3FC-98B5-11CF-BB82-00AA00BDCE0B}']
    property length: Integer readonly dispid 1;
  end;

// *********************************************************************//
// Interface: IHTMLPluginsCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3FD-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLPluginsCollection = interface(IDispatch)
    ['{3050F3FD-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_length: Integer; safecall;
    procedure Refresh(reload: WordBool); safecall;
    property length: Integer read Get_length;
  end;

// *********************************************************************//
// DispIntf:  IHTMLPluginsCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3FD-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLPluginsCollectionDisp = dispinterface
    ['{3050F3FD-98B5-11CF-BB82-00AA00BDCE0B}']
    property length: Integer readonly dispid 1;
    procedure Refresh(reload: WordBool); dispid 2;
  end;

// *********************************************************************//
// Interface: IHTMLOpsProfile
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F401-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOpsProfile = interface(IDispatch)
    ['{3050F401-98B5-11CF-BB82-00AA00BDCE0B}']
    function  addRequest(const name: WideString; reserved: OleVariant): WordBool; safecall;
    procedure clearRequest; safecall;
    procedure doRequest(usage: OleVariant; fname: OleVariant; domain: OleVariant; path: OleVariant;
                        expire: OleVariant; reserved: OleVariant); safecall;
    function  getAttribute(const name: WideString): WideString; safecall;
    function  setAttribute(const name: WideString; const value: WideString; prefs: OleVariant): WordBool; safecall;
    function  commitChanges: WordBool; safecall;
    function  addReadRequest(const name: WideString; reserved: OleVariant): WordBool; safecall;
    procedure doReadRequest(usage: OleVariant; fname: OleVariant; domain: OleVariant;
                            path: OleVariant; expire: OleVariant; reserved: OleVariant); safecall;
    function  doWriteRequest: WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IHTMLOpsProfileDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F401-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOpsProfileDisp = dispinterface
    ['{3050F401-98B5-11CF-BB82-00AA00BDCE0B}']
    function  addRequest(const name: WideString; reserved: OleVariant): WordBool; dispid 1;
    procedure clearRequest; dispid 2;
    procedure doRequest(usage: OleVariant; fname: OleVariant; domain: OleVariant; path: OleVariant;
                        expire: OleVariant; reserved: OleVariant); dispid 3;
    function  getAttribute(const name: WideString): WideString; dispid 4;
    function  setAttribute(const name: WideString; const value: WideString; prefs: OleVariant): WordBool; dispid 5;
    function  commitChanges: WordBool; dispid 6;
    function  addReadRequest(const name: WideString; reserved: OleVariant): WordBool; dispid 7;
    procedure doReadRequest(usage: OleVariant; fname: OleVariant; domain: OleVariant;
                            path: OleVariant; expire: OleVariant; reserved: OleVariant); dispid 8;
    function  doWriteRequest: WordBool; dispid 9;
  end;

// *********************************************************************//
// Interface: IHTMLEventObj
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F32D-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLEventObj = interface(IDispatch)
    ['{3050F32D-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_srcElement: IHTMLElement; safecall;
    function  Get_altKey: WordBool; safecall;
    function  Get_ctrlKey: WordBool; safecall;
    function  Get_shiftKey: WordBool; safecall;
    procedure Set_returnValue(p: OleVariant); safecall;
    function  Get_returnValue: OleVariant; safecall;
    procedure Set_cancelBubble(p: WordBool); safecall;
    function  Get_cancelBubble: WordBool; safecall;
    function  Get_fromElement: IHTMLElement; safecall;
    function  Get_toElement: IHTMLElement; safecall;
    procedure Set_keyCode(p: Integer); safecall;
    function  Get_keyCode: Integer; safecall;
    function  Get_button: Integer; safecall;
    function  Get_type_: WideString; safecall;
    function  Get_qualifier: WideString; safecall;
    function  Get_reason: Integer; safecall;
    function  Get_x: Integer; safecall;
    function  Get_y: Integer; safecall;
    function  Get_clientX: Integer; safecall;
    function  Get_clientY: Integer; safecall;
    function  Get_offsetX: Integer; safecall;
    function  Get_offsetY: Integer; safecall;
    function  Get_screenX: Integer; safecall;
    function  Get_screenY: Integer; safecall;
    function  Get_srcFilter: IDispatch; safecall;
    property srcElement: IHTMLElement read Get_srcElement;
    property altKey: WordBool read Get_altKey;
    property ctrlKey: WordBool read Get_ctrlKey;
    property shiftKey: WordBool read Get_shiftKey;
    property returnValue: OleVariant read Get_returnValue write Set_returnValue;
    property cancelBubble: WordBool read Get_cancelBubble write Set_cancelBubble;
    property fromElement: IHTMLElement read Get_fromElement;
    property toElement: IHTMLElement read Get_toElement;
    property keyCode: Integer read Get_keyCode write Set_keyCode;
    property button: Integer read Get_button;
    property type_: WideString read Get_type_;
    property qualifier: WideString read Get_qualifier;
    property reason: Integer read Get_reason;
    property x: Integer read Get_x;
    property y: Integer read Get_y;
    property clientX: Integer read Get_clientX;
    property clientY: Integer read Get_clientY;
    property offsetX: Integer read Get_offsetX;
    property offsetY: Integer read Get_offsetY;
    property screenX: Integer read Get_screenX;
    property screenY: Integer read Get_screenY;
    property srcFilter: IDispatch read Get_srcFilter;
  end;

// *********************************************************************//
// DispIntf:  IHTMLEventObjDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F32D-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLEventObjDisp = dispinterface
    ['{3050F32D-98B5-11CF-BB82-00AA00BDCE0B}']
    property srcElement: IHTMLElement readonly dispid 1001;
    property altKey: WordBool readonly dispid 1002;
    property ctrlKey: WordBool readonly dispid 1003;
    property shiftKey: WordBool readonly dispid 1004;
    property returnValue: OleVariant dispid 1007;
    property cancelBubble: WordBool dispid 1008;
    property fromElement: IHTMLElement readonly dispid 1009;
    property toElement: IHTMLElement readonly dispid 1010;
    property keyCode: Integer dispid 1011;
    property button: Integer readonly dispid 1012;
    property type_: WideString readonly dispid 1013;
    property qualifier: WideString readonly dispid 1014;
    property reason: Integer readonly dispid 1015;
    property x: Integer readonly dispid 1005;
    property y: Integer readonly dispid 1006;
    property clientX: Integer readonly dispid 1020;
    property clientY: Integer readonly dispid 1021;
    property offsetX: Integer readonly dispid 1022;
    property offsetY: Integer readonly dispid 1023;
    property screenX: Integer readonly dispid 1024;
    property screenY: Integer readonly dispid 1025;
    property srcFilter: IDispatch readonly dispid 1026;
  end;

// *********************************************************************//
// Interface: IHTMLScreen
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F35C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLScreen = interface(IDispatch)
    ['{3050F35C-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_colorDepth: Integer; safecall;
    procedure Set_bufferDepth(p: Integer); safecall;
    function  Get_bufferDepth: Integer; safecall;
    function  Get_width: Integer; safecall;
    function  Get_height: Integer; safecall;
    procedure Set_updateInterval(p: Integer); safecall;
    function  Get_updateInterval: Integer; safecall;
    function  Get_availHeight: Integer; safecall;
    function  Get_availWidth: Integer; safecall;
    function  Get_fontSmoothingEnabled: WordBool; safecall;
    property colorDepth: Integer read Get_colorDepth;
    property bufferDepth: Integer read Get_bufferDepth write Set_bufferDepth;
    property width: Integer read Get_width;
    property height: Integer read Get_height;
    property updateInterval: Integer read Get_updateInterval write Set_updateInterval;
    property availHeight: Integer read Get_availHeight;
    property availWidth: Integer read Get_availWidth;
    property fontSmoothingEnabled: WordBool read Get_fontSmoothingEnabled;
  end;

// *********************************************************************//
// DispIntf:  IHTMLScreenDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F35C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLScreenDisp = dispinterface
    ['{3050F35C-98B5-11CF-BB82-00AA00BDCE0B}']
    property colorDepth: Integer readonly dispid 1001;
    property bufferDepth: Integer dispid 1002;
    property width: Integer readonly dispid 1003;
    property height: Integer readonly dispid 1004;
    property updateInterval: Integer dispid 1005;
    property availHeight: Integer readonly dispid 1006;
    property availWidth: Integer readonly dispid 1007;
    property fontSmoothingEnabled: WordBool readonly dispid 1008;
  end;

// *********************************************************************//
// Interface: IHTMLOptionElementFactory
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F38C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOptionElementFactory = interface(IDispatch)
    ['{3050F38C-98B5-11CF-BB82-00AA00BDCE0B}']
    function  create(text: OleVariant; value: OleVariant; defaultSelected: OleVariant;
                     selected: OleVariant): IHTMLOptionElement; safecall;
  end;

// *********************************************************************//
// DispIntf:  IHTMLOptionElementFactoryDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F38C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOptionElementFactoryDisp = dispinterface
    ['{3050F38C-98B5-11CF-BB82-00AA00BDCE0B}']
    function  create(text: OleVariant; value: OleVariant; defaultSelected: OleVariant;
                     selected: OleVariant): IHTMLOptionElement; dispid 0;
  end;

// *********************************************************************//
// Interface: IHTMLOptionElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F211-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOptionElement = interface(IDispatch)
    ['{3050F211-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_selected(p: WordBool); safecall;
    function  Get_selected: WordBool; safecall;
    procedure Set_value(const p: WideString); safecall;
    function  Get_value: WideString; safecall;
    procedure Set_defaultSelected(p: WordBool); safecall;
    function  Get_defaultSelected: WordBool; safecall;
    procedure Set_index(p: Integer); safecall;
    function  Get_index: Integer; safecall;
    procedure Set_text(const p: WideString); safecall;
    function  Get_text: WideString; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    property selected: WordBool read Get_selected write Set_selected;
    property value: WideString read Get_value write Set_value;
    property defaultSelected: WordBool read Get_defaultSelected write Set_defaultSelected;
    property index: Integer read Get_index write Set_index;
    property text: WideString read Get_text write Set_text;
    property form: IHTMLFormElement read Get_form;
  end;

// *********************************************************************//
// DispIntf:  IHTMLOptionElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F211-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOptionElementDisp = dispinterface
    ['{3050F211-98B5-11CF-BB82-00AA00BDCE0B}']
    property selected: WordBool dispid 1001;
    property value: WideString dispid 1002;
    property defaultSelected: WordBool dispid 1003;
    property index: Integer dispid 1005;
    property text: WideString dispid 1004;
    property form: IHTMLFormElement readonly dispid 1006;
  end;

// *********************************************************************//
// Interface: IHTMLFormElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F7-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFormElement = interface(IDispatch)
    ['{3050F1F7-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_action(const p: WideString); safecall;
    function  Get_action: WideString; safecall;
    procedure Set_dir(const p: WideString); safecall;
    function  Get_dir: WideString; safecall;
    procedure Set_encoding(const p: WideString); safecall;
    function  Get_encoding: WideString; safecall;
    procedure Set_method(const p: WideString); safecall;
    function  Get_method: WideString; safecall;
    function  Get_elements: IDispatch; safecall;
    procedure Set_target(const p: WideString); safecall;
    function  Get_target: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_onsubmit(p: OleVariant); safecall;
    function  Get_onsubmit: OleVariant; safecall;
    procedure Set_onreset(p: OleVariant); safecall;
    function  Get_onreset: OleVariant; safecall;
    procedure submit; safecall;
    procedure reset; safecall;
    procedure Set_length(p: Integer); safecall;
    function  Get_length: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  item(name: OleVariant; index: OleVariant): IDispatch; safecall;
    function  tags(tagName: OleVariant): IDispatch; safecall;
    property action: WideString read Get_action write Set_action;
    property dir: WideString read Get_dir write Set_dir;
    property encoding: WideString read Get_encoding write Set_encoding;
    property method: WideString read Get_method write Set_method;
    property elements: IDispatch read Get_elements;
    property target: WideString read Get_target write Set_target;
    property name: WideString read Get_name write Set_name;
    property onsubmit: OleVariant read Get_onsubmit write Set_onsubmit;
    property onreset: OleVariant read Get_onreset write Set_onreset;
    property length: Integer read Get_length write Set_length;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IHTMLFormElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F7-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFormElementDisp = dispinterface
    ['{3050F1F7-98B5-11CF-BB82-00AA00BDCE0B}']
    property action: WideString dispid 1001;
    property dir: WideString dispid 1002;
    property encoding: WideString dispid 1003;
    property method: WideString dispid 1004;
    property elements: IDispatch readonly dispid 1005;
    property target: WideString dispid 1006;
    property name: WideString dispid -2147418112;
    property onsubmit: OleVariant dispid -2147412101;
    property onreset: OleVariant dispid -2147412100;
    procedure submit; dispid 1009;
    procedure reset; dispid 1010;
    property length: Integer dispid 1500;
    property _NewEnum: IUnknown readonly dispid -4;
    function  item(name: OleVariant; index: OleVariant): IDispatch; dispid 0;
    function  tags(tagName: OleVariant): IDispatch; dispid 1502;
  end;

// *********************************************************************//
// Interface: IHTMLStyleSheetsCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F37E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleSheetsCollection = interface(IDispatch)
    ['{3050F37E-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_length: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  item(var pvarIndex: OleVariant): OleVariant; safecall;
    property length: Integer read Get_length;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IHTMLStyleSheetsCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F37E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleSheetsCollectionDisp = dispinterface
    ['{3050F37E-98B5-11CF-BB82-00AA00BDCE0B}']
    property length: Integer readonly dispid 1001;
    property _NewEnum: IUnknown readonly dispid -4;
    function  item(var pvarIndex: OleVariant): OleVariant; dispid 0;
  end;

// *********************************************************************//
// Interface: IHTMLStyleSheet
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2E3-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleSheet = interface(IDispatch)
    ['{3050F2E3-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_title(const p: WideString); safecall;
    function  Get_title: WideString; safecall;
    function  Get_parentStyleSheet: IHTMLStyleSheet; safecall;
    function  Get_owningElement: IHTMLElement; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    function  Get_readOnly: WordBool; safecall;
    function  Get_imports: IHTMLStyleSheetsCollection; safecall;
    procedure Set_href(const p: WideString); safecall;
    function  Get_href: WideString; safecall;
    function  Get_type_: WideString; safecall;
    function  Get_id: WideString; safecall;
    function  addImport(const bstrURL: WideString; lIndex: Integer): Integer; safecall;
    function  addRule(const bstrSelector: WideString; const bstrStyle: WideString; lIndex: Integer): Integer; safecall;
    procedure removeImport(lIndex: Integer); safecall;
    procedure removeRule(lIndex: Integer); safecall;
    procedure Set_media(const p: WideString); safecall;
    function  Get_media: WideString; safecall;
    procedure Set_cssText(const p: WideString); safecall;
    function  Get_cssText: WideString; safecall;
    function  Get_rules: IHTMLStyleSheetRulesCollection; safecall;
    property title: WideString read Get_title write Set_title;
    property parentStyleSheet: IHTMLStyleSheet read Get_parentStyleSheet;
    property owningElement: IHTMLElement read Get_owningElement;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property readOnly: WordBool read Get_readOnly;
    property imports: IHTMLStyleSheetsCollection read Get_imports;
    property href: WideString read Get_href write Set_href;
    property type_: WideString read Get_type_;
    property id: WideString read Get_id;
    property media: WideString read Get_media write Set_media;
    property cssText: WideString read Get_cssText write Set_cssText;
    property rules: IHTMLStyleSheetRulesCollection read Get_rules;
  end;

// *********************************************************************//
// DispIntf:  IHTMLStyleSheetDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2E3-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleSheetDisp = dispinterface
    ['{3050F2E3-98B5-11CF-BB82-00AA00BDCE0B}']
    property title: WideString dispid 1001;
    property parentStyleSheet: IHTMLStyleSheet readonly dispid 1002;
    property owningElement: IHTMLElement readonly dispid 1003;
    property disabled: WordBool dispid -2147418036;
    property readOnly: WordBool readonly dispid 1004;
    property imports: IHTMLStyleSheetsCollection readonly dispid 1005;
    property href: WideString dispid 1006;
    property type_: WideString readonly dispid 1007;
    property id: WideString readonly dispid 1008;
    function  addImport(const bstrURL: WideString; lIndex: Integer): Integer; dispid 1009;
    function  addRule(const bstrSelector: WideString; const bstrStyle: WideString; lIndex: Integer): Integer; dispid 1010;
    procedure removeImport(lIndex: Integer); dispid 1011;
    procedure removeRule(lIndex: Integer); dispid 1012;
    property media: WideString dispid 1013;
    property cssText: WideString dispid 1014;
    property rules: IHTMLStyleSheetRulesCollection readonly dispid 1015;
  end;

// *********************************************************************//
// Interface: IHTMLStyleSheetRulesCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2E5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleSheetRulesCollection = interface(IDispatch)
    ['{3050F2E5-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_length: Integer; safecall;
    function  item(index: Integer): IHTMLStyleSheetRule; safecall;
    property length: Integer read Get_length;
  end;

// *********************************************************************//
// DispIntf:  IHTMLStyleSheetRulesCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2E5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleSheetRulesCollectionDisp = dispinterface
    ['{3050F2E5-98B5-11CF-BB82-00AA00BDCE0B}']
    property length: Integer readonly dispid 1001;
    function  item(index: Integer): IHTMLStyleSheetRule; dispid 0;
  end;

// *********************************************************************//
// Interface: IHTMLStyleSheetRule
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F357-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleSheetRule = interface(IDispatch)
    ['{3050F357-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_selectorText(const p: WideString); safecall;
    function  Get_selectorText: WideString; safecall;
    function  Get_style: IHTMLRuleStyle; safecall;
    function  Get_readOnly: WordBool; safecall;
    property selectorText: WideString read Get_selectorText write Set_selectorText;
    property style: IHTMLRuleStyle read Get_style;
    property readOnly: WordBool read Get_readOnly;
  end;

// *********************************************************************//
// DispIntf:  IHTMLStyleSheetRuleDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F357-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleSheetRuleDisp = dispinterface
    ['{3050F357-98B5-11CF-BB82-00AA00BDCE0B}']
    property selectorText: WideString dispid 1001;
    property style: IHTMLRuleStyle readonly dispid -2147418038;
    property readOnly: WordBool readonly dispid 1002;
  end;

// *********************************************************************//
// Interface: IHTMLRuleStyle
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3CF-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLRuleStyle = interface(IDispatch)
    ['{3050F3CF-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_fontFamily(const p: WideString); safecall;
    function  Get_fontFamily: WideString; safecall;
    procedure Set_fontStyle(const p: WideString); safecall;
    function  Get_fontStyle: WideString; safecall;
    procedure Set_fontVariant(const p: WideString); safecall;
    function  Get_fontVariant: WideString; safecall;
    procedure Set_fontWeight(const p: WideString); safecall;
    function  Get_fontWeight: WideString; safecall;
    procedure Set_fontSize(p: OleVariant); safecall;
    function  Get_fontSize: OleVariant; safecall;
    procedure Set_font(const p: WideString); safecall;
    function  Get_font: WideString; safecall;
    procedure Set_color(p: OleVariant); safecall;
    function  Get_color: OleVariant; safecall;
    procedure Set_background(const p: WideString); safecall;
    function  Get_background: WideString; safecall;
    procedure Set_backgroundColor(p: OleVariant); safecall;
    function  Get_backgroundColor: OleVariant; safecall;
    procedure Set_backgroundImage(const p: WideString); safecall;
    function  Get_backgroundImage: WideString; safecall;
    procedure Set_backgroundRepeat(const p: WideString); safecall;
    function  Get_backgroundRepeat: WideString; safecall;
    procedure Set_backgroundAttachment(const p: WideString); safecall;
    function  Get_backgroundAttachment: WideString; safecall;
    procedure Set_backgroundPosition(const p: WideString); safecall;
    function  Get_backgroundPosition: WideString; safecall;
    procedure Set_backgroundPositionX(p: OleVariant); safecall;
    function  Get_backgroundPositionX: OleVariant; safecall;
    procedure Set_backgroundPositionY(p: OleVariant); safecall;
    function  Get_backgroundPositionY: OleVariant; safecall;
    procedure Set_wordSpacing(p: OleVariant); safecall;
    function  Get_wordSpacing: OleVariant; safecall;
    procedure Set_letterSpacing(p: OleVariant); safecall;
    function  Get_letterSpacing: OleVariant; safecall;
    procedure Set_textDecoration(const p: WideString); safecall;
    function  Get_textDecoration: WideString; safecall;
    procedure Set_textDecorationNone(p: WordBool); safecall;
    function  Get_textDecorationNone: WordBool; safecall;
    procedure Set_textDecorationUnderline(p: WordBool); safecall;
    function  Get_textDecorationUnderline: WordBool; safecall;
    procedure Set_textDecorationOverline(p: WordBool); safecall;
    function  Get_textDecorationOverline: WordBool; safecall;
    procedure Set_textDecorationLineThrough(p: WordBool); safecall;
    function  Get_textDecorationLineThrough: WordBool; safecall;
    procedure Set_textDecorationBlink(p: WordBool); safecall;
    function  Get_textDecorationBlink: WordBool; safecall;
    procedure Set_verticalAlign(p: OleVariant); safecall;
    function  Get_verticalAlign: OleVariant; safecall;
    procedure Set_textTransform(const p: WideString); safecall;
    function  Get_textTransform: WideString; safecall;
    procedure Set_textAlign(const p: WideString); safecall;
    function  Get_textAlign: WideString; safecall;
    procedure Set_textIndent(p: OleVariant); safecall;
    function  Get_textIndent: OleVariant; safecall;
    procedure Set_lineHeight(p: OleVariant); safecall;
    function  Get_lineHeight: OleVariant; safecall;
    procedure Set_marginTop(p: OleVariant); safecall;
    function  Get_marginTop: OleVariant; safecall;
    procedure Set_marginRight(p: OleVariant); safecall;
    function  Get_marginRight: OleVariant; safecall;
    procedure Set_marginBottom(p: OleVariant); safecall;
    function  Get_marginBottom: OleVariant; safecall;
    procedure Set_marginLeft(p: OleVariant); safecall;
    function  Get_marginLeft: OleVariant; safecall;
    procedure Set_margin(const p: WideString); safecall;
    function  Get_margin: WideString; safecall;
    procedure Set_paddingTop(p: OleVariant); safecall;
    function  Get_paddingTop: OleVariant; safecall;
    procedure Set_paddingRight(p: OleVariant); safecall;
    function  Get_paddingRight: OleVariant; safecall;
    procedure Set_paddingBottom(p: OleVariant); safecall;
    function  Get_paddingBottom: OleVariant; safecall;
    procedure Set_paddingLeft(p: OleVariant); safecall;
    function  Get_paddingLeft: OleVariant; safecall;
    procedure Set_padding(const p: WideString); safecall;
    function  Get_padding: WideString; safecall;
    procedure Set_border(const p: WideString); safecall;
    function  Get_border: WideString; safecall;
    procedure Set_borderTop(const p: WideString); safecall;
    function  Get_borderTop: WideString; safecall;
    procedure Set_borderRight(const p: WideString); safecall;
    function  Get_borderRight: WideString; safecall;
    procedure Set_borderBottom(const p: WideString); safecall;
    function  Get_borderBottom: WideString; safecall;
    procedure Set_borderLeft(const p: WideString); safecall;
    function  Get_borderLeft: WideString; safecall;
    procedure Set_borderColor(const p: WideString); safecall;
    function  Get_borderColor: WideString; safecall;
    procedure Set_borderTopColor(p: OleVariant); safecall;
    function  Get_borderTopColor: OleVariant; safecall;
    procedure Set_borderRightColor(p: OleVariant); safecall;
    function  Get_borderRightColor: OleVariant; safecall;
    procedure Set_borderBottomColor(p: OleVariant); safecall;
    function  Get_borderBottomColor: OleVariant; safecall;
    procedure Set_borderLeftColor(p: OleVariant); safecall;
    function  Get_borderLeftColor: OleVariant; safecall;
    procedure Set_borderWidth(const p: WideString); safecall;
    function  Get_borderWidth: WideString; safecall;
    procedure Set_borderTopWidth(p: OleVariant); safecall;
    function  Get_borderTopWidth: OleVariant; safecall;
    procedure Set_borderRightWidth(p: OleVariant); safecall;
    function  Get_borderRightWidth: OleVariant; safecall;
    procedure Set_borderBottomWidth(p: OleVariant); safecall;
    function  Get_borderBottomWidth: OleVariant; safecall;
    procedure Set_borderLeftWidth(p: OleVariant); safecall;
    function  Get_borderLeftWidth: OleVariant; safecall;
    procedure Set_borderStyle(const p: WideString); safecall;
    function  Get_borderStyle: WideString; safecall;
    procedure Set_borderTopStyle(const p: WideString); safecall;
    function  Get_borderTopStyle: WideString; safecall;
    procedure Set_borderRightStyle(const p: WideString); safecall;
    function  Get_borderRightStyle: WideString; safecall;
    procedure Set_borderBottomStyle(const p: WideString); safecall;
    function  Get_borderBottomStyle: WideString; safecall;
    procedure Set_borderLeftStyle(const p: WideString); safecall;
    function  Get_borderLeftStyle: WideString; safecall;
    procedure Set_width(p: OleVariant); safecall;
    function  Get_width: OleVariant; safecall;
    procedure Set_height(p: OleVariant); safecall;
    function  Get_height: OleVariant; safecall;
    procedure Set_styleFloat(const p: WideString); safecall;
    function  Get_styleFloat: WideString; safecall;
    procedure Set_clear(const p: WideString); safecall;
    function  Get_clear: WideString; safecall;
    procedure Set_display(const p: WideString); safecall;
    function  Get_display: WideString; safecall;
    procedure Set_visibility(const p: WideString); safecall;
    function  Get_visibility: WideString; safecall;
    procedure Set_listStyleType(const p: WideString); safecall;
    function  Get_listStyleType: WideString; safecall;
    procedure Set_listStylePosition(const p: WideString); safecall;
    function  Get_listStylePosition: WideString; safecall;
    procedure Set_listStyleImage(const p: WideString); safecall;
    function  Get_listStyleImage: WideString; safecall;
    procedure Set_listStyle(const p: WideString); safecall;
    function  Get_listStyle: WideString; safecall;
    procedure Set_whiteSpace(const p: WideString); safecall;
    function  Get_whiteSpace: WideString; safecall;
    procedure Set_top(p: OleVariant); safecall;
    function  Get_top: OleVariant; safecall;
    procedure Set_left(p: OleVariant); safecall;
    function  Get_left: OleVariant; safecall;
    function  Get_position: WideString; safecall;
    procedure Set_zIndex(p: OleVariant); safecall;
    function  Get_zIndex: OleVariant; safecall;
    procedure Set_overflow(const p: WideString); safecall;
    function  Get_overflow: WideString; safecall;
    procedure Set_pageBreakBefore(const p: WideString); safecall;
    function  Get_pageBreakBefore: WideString; safecall;
    procedure Set_pageBreakAfter(const p: WideString); safecall;
    function  Get_pageBreakAfter: WideString; safecall;
    procedure Set_cssText(const p: WideString); safecall;
    function  Get_cssText: WideString; safecall;
    procedure Set_cursor(const p: WideString); safecall;
    function  Get_cursor: WideString; safecall;
    procedure Set_clip(const p: WideString); safecall;
    function  Get_clip: WideString; safecall;
    procedure Set_filter(const p: WideString); safecall;
    function  Get_filter: WideString; safecall;
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); safecall;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; safecall;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; safecall;
    property fontFamily: WideString read Get_fontFamily write Set_fontFamily;
    property fontStyle: WideString read Get_fontStyle write Set_fontStyle;
    property fontVariant: WideString read Get_fontVariant write Set_fontVariant;
    property fontWeight: WideString read Get_fontWeight write Set_fontWeight;
    property fontSize: OleVariant read Get_fontSize write Set_fontSize;
    property font: WideString read Get_font write Set_font;
    property color: OleVariant read Get_color write Set_color;
    property background: WideString read Get_background write Set_background;
    property backgroundColor: OleVariant read Get_backgroundColor write Set_backgroundColor;
    property backgroundImage: WideString read Get_backgroundImage write Set_backgroundImage;
    property backgroundRepeat: WideString read Get_backgroundRepeat write Set_backgroundRepeat;
    property backgroundAttachment: WideString read Get_backgroundAttachment write Set_backgroundAttachment;
    property backgroundPosition: WideString read Get_backgroundPosition write Set_backgroundPosition;
    property backgroundPositionX: OleVariant read Get_backgroundPositionX write Set_backgroundPositionX;
    property backgroundPositionY: OleVariant read Get_backgroundPositionY write Set_backgroundPositionY;
    property wordSpacing: OleVariant read Get_wordSpacing write Set_wordSpacing;
    property letterSpacing: OleVariant read Get_letterSpacing write Set_letterSpacing;
    property textDecoration: WideString read Get_textDecoration write Set_textDecoration;
    property textDecorationNone: WordBool read Get_textDecorationNone write Set_textDecorationNone;
    property textDecorationUnderline: WordBool read Get_textDecorationUnderline write Set_textDecorationUnderline;
    property textDecorationOverline: WordBool read Get_textDecorationOverline write Set_textDecorationOverline;
    property textDecorationLineThrough: WordBool read Get_textDecorationLineThrough write Set_textDecorationLineThrough;
    property textDecorationBlink: WordBool read Get_textDecorationBlink write Set_textDecorationBlink;
    property verticalAlign: OleVariant read Get_verticalAlign write Set_verticalAlign;
    property textTransform: WideString read Get_textTransform write Set_textTransform;
    property textAlign: WideString read Get_textAlign write Set_textAlign;
    property textIndent: OleVariant read Get_textIndent write Set_textIndent;
    property lineHeight: OleVariant read Get_lineHeight write Set_lineHeight;
    property marginTop: OleVariant read Get_marginTop write Set_marginTop;
    property marginRight: OleVariant read Get_marginRight write Set_marginRight;
    property marginBottom: OleVariant read Get_marginBottom write Set_marginBottom;
    property marginLeft: OleVariant read Get_marginLeft write Set_marginLeft;
    property margin: WideString read Get_margin write Set_margin;
    property paddingTop: OleVariant read Get_paddingTop write Set_paddingTop;
    property paddingRight: OleVariant read Get_paddingRight write Set_paddingRight;
    property paddingBottom: OleVariant read Get_paddingBottom write Set_paddingBottom;
    property paddingLeft: OleVariant read Get_paddingLeft write Set_paddingLeft;
    property padding: WideString read Get_padding write Set_padding;
    property border: WideString read Get_border write Set_border;
    property borderTop: WideString read Get_borderTop write Set_borderTop;
    property borderRight: WideString read Get_borderRight write Set_borderRight;
    property borderBottom: WideString read Get_borderBottom write Set_borderBottom;
    property borderLeft: WideString read Get_borderLeft write Set_borderLeft;
    property borderColor: WideString read Get_borderColor write Set_borderColor;
    property borderTopColor: OleVariant read Get_borderTopColor write Set_borderTopColor;
    property borderRightColor: OleVariant read Get_borderRightColor write Set_borderRightColor;
    property borderBottomColor: OleVariant read Get_borderBottomColor write Set_borderBottomColor;
    property borderLeftColor: OleVariant read Get_borderLeftColor write Set_borderLeftColor;
    property borderWidth: WideString read Get_borderWidth write Set_borderWidth;
    property borderTopWidth: OleVariant read Get_borderTopWidth write Set_borderTopWidth;
    property borderRightWidth: OleVariant read Get_borderRightWidth write Set_borderRightWidth;
    property borderBottomWidth: OleVariant read Get_borderBottomWidth write Set_borderBottomWidth;
    property borderLeftWidth: OleVariant read Get_borderLeftWidth write Set_borderLeftWidth;
    property borderStyle: WideString read Get_borderStyle write Set_borderStyle;
    property borderTopStyle: WideString read Get_borderTopStyle write Set_borderTopStyle;
    property borderRightStyle: WideString read Get_borderRightStyle write Set_borderRightStyle;
    property borderBottomStyle: WideString read Get_borderBottomStyle write Set_borderBottomStyle;
    property borderLeftStyle: WideString read Get_borderLeftStyle write Set_borderLeftStyle;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
    property styleFloat: WideString read Get_styleFloat write Set_styleFloat;
    property clear: WideString read Get_clear write Set_clear;
    property display: WideString read Get_display write Set_display;
    property visibility: WideString read Get_visibility write Set_visibility;
    property listStyleType: WideString read Get_listStyleType write Set_listStyleType;
    property listStylePosition: WideString read Get_listStylePosition write Set_listStylePosition;
    property listStyleImage: WideString read Get_listStyleImage write Set_listStyleImage;
    property listStyle: WideString read Get_listStyle write Set_listStyle;
    property whiteSpace: WideString read Get_whiteSpace write Set_whiteSpace;
    property top: OleVariant read Get_top write Set_top;
    property left: OleVariant read Get_left write Set_left;
    property position: WideString read Get_position;
    property zIndex: OleVariant read Get_zIndex write Set_zIndex;
    property overflow: WideString read Get_overflow write Set_overflow;
    property pageBreakBefore: WideString read Get_pageBreakBefore write Set_pageBreakBefore;
    property pageBreakAfter: WideString read Get_pageBreakAfter write Set_pageBreakAfter;
    property cssText: WideString read Get_cssText write Set_cssText;
    property cursor: WideString read Get_cursor write Set_cursor;
    property clip: WideString read Get_clip write Set_clip;
    property filter: WideString read Get_filter write Set_filter;
  end;

// *********************************************************************//
// DispIntf:  IHTMLRuleStyleDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3CF-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLRuleStyleDisp = dispinterface
    ['{3050F3CF-98B5-11CF-BB82-00AA00BDCE0B}']
    property fontFamily: WideString dispid -2147413094;
    property fontStyle: WideString dispid -2147413088;
    property fontVariant: WideString dispid -2147413087;
    property fontWeight: WideString dispid -2147413085;
    property fontSize: OleVariant dispid -2147413093;
    property font: WideString dispid -2147413071;
    property color: OleVariant dispid -2147413110;
    property background: WideString dispid -2147413080;
    property backgroundColor: OleVariant dispid -501;
    property backgroundImage: WideString dispid -2147413111;
    property backgroundRepeat: WideString dispid -2147413068;
    property backgroundAttachment: WideString dispid -2147413067;
    property backgroundPosition: WideString dispid -2147413066;
    property backgroundPositionX: OleVariant dispid -2147413079;
    property backgroundPositionY: OleVariant dispid -2147413078;
    property wordSpacing: OleVariant dispid -2147413065;
    property letterSpacing: OleVariant dispid -2147413104;
    property textDecoration: WideString dispid -2147413077;
    property textDecorationNone: WordBool dispid -2147413089;
    property textDecorationUnderline: WordBool dispid -2147413091;
    property textDecorationOverline: WordBool dispid -2147413043;
    property textDecorationLineThrough: WordBool dispid -2147413092;
    property textDecorationBlink: WordBool dispid -2147413090;
    property verticalAlign: OleVariant dispid -2147413064;
    property textTransform: WideString dispid -2147413108;
    property textAlign: WideString dispid -2147418040;
    property textIndent: OleVariant dispid -2147413105;
    property lineHeight: OleVariant dispid -2147413106;
    property marginTop: OleVariant dispid -2147413075;
    property marginRight: OleVariant dispid -2147413074;
    property marginBottom: OleVariant dispid -2147413073;
    property marginLeft: OleVariant dispid -2147413072;
    property margin: WideString dispid -2147413076;
    property paddingTop: OleVariant dispid -2147413100;
    property paddingRight: OleVariant dispid -2147413099;
    property paddingBottom: OleVariant dispid -2147413098;
    property paddingLeft: OleVariant dispid -2147413097;
    property padding: WideString dispid -2147413101;
    property border: WideString dispid -2147413063;
    property borderTop: WideString dispid -2147413062;
    property borderRight: WideString dispid -2147413061;
    property borderBottom: WideString dispid -2147413060;
    property borderLeft: WideString dispid -2147413059;
    property borderColor: WideString dispid -2147413058;
    property borderTopColor: OleVariant dispid -2147413057;
    property borderRightColor: OleVariant dispid -2147413056;
    property borderBottomColor: OleVariant dispid -2147413055;
    property borderLeftColor: OleVariant dispid -2147413054;
    property borderWidth: WideString dispid -2147413053;
    property borderTopWidth: OleVariant dispid -2147413052;
    property borderRightWidth: OleVariant dispid -2147413051;
    property borderBottomWidth: OleVariant dispid -2147413050;
    property borderLeftWidth: OleVariant dispid -2147413049;
    property borderStyle: WideString dispid -2147413048;
    property borderTopStyle: WideString dispid -2147413047;
    property borderRightStyle: WideString dispid -2147413046;
    property borderBottomStyle: WideString dispid -2147413045;
    property borderLeftStyle: WideString dispid -2147413044;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property styleFloat: WideString dispid -2147413042;
    property clear: WideString dispid -2147413096;
    property display: WideString dispid -2147413041;
    property visibility: WideString dispid -2147413032;
    property listStyleType: WideString dispid -2147413040;
    property listStylePosition: WideString dispid -2147413039;
    property listStyleImage: WideString dispid -2147413038;
    property listStyle: WideString dispid -2147413037;
    property whiteSpace: WideString dispid -2147413036;
    property top: OleVariant dispid -2147418108;
    property left: OleVariant dispid -2147418109;
    property position: WideString readonly dispid -2147413022;
    property zIndex: OleVariant dispid -2147413021;
    property overflow: WideString dispid -2147413102;
    property pageBreakBefore: WideString dispid -2147413035;
    property pageBreakAfter: WideString dispid -2147413034;
    property cssText: WideString dispid -2147413013;
    property cursor: WideString dispid -2147413010;
    property clip: WideString dispid -2147413020;
    property filter: WideString dispid -2147413030;
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
  end;

// *********************************************************************//
// Interface: IFPMarkupContainer
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3050F56E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IFPMarkupContainer = interface(IDispatch)
    ['{3050F56E-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_OwningDoc: IHTMLDocument2; safecall;
    property OwningDoc: IHTMLDocument2 read Get_OwningDoc;
  end;

// *********************************************************************//
// DispIntf:  IFPMarkupContainerDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3050F56E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IFPMarkupContainerDisp = dispinterface
    ['{3050F56E-98B5-11CF-BB82-00AA00BDCE0B}']
    property OwningDoc: IHTMLDocument2 readonly dispid 1001;
  end;

// *********************************************************************//
// Interface: IFPMarkupServices
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3050F4A0-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IFPMarkupServices = interface(IDispatch)
    ['{3050F4A0-98B5-11CF-BB82-00AA00BDCE0B}']
    function  CreateMarkupPointer: IFPMarkupPointer; safecall;
    function  CreateMarkupContainer: IFPMarkupContainer; safecall;
    function  CreateMarkupElement(tagID: ELEMENT_TAG_ID; const bstrAttributes: WideString): IHTMLElement; safecall;
    function  CloneElement(const pElemCloneThis: IHTMLElement): IHTMLElement; safecall;
    procedure InsertElement(const pElementInsert: IHTMLElement;
                            const pPointerStart: IFPMarkupPointer;
                            const pPointerFinish: IFPMarkupPointer); safecall;
    procedure RemoveElement(const pElementRemove: IHTMLElement); safecall;
    procedure Remove(const pPointerStart: IFPMarkupPointer; const pPointerFinish: IFPMarkupPointer); safecall;
    procedure Copy(const pPointerSourceStart: IFPMarkupPointer;
                   const pPointerSourceFinish: IFPMarkupPointer;
                   const pPointerTarget: IFPMarkupPointer); safecall;
    procedure Move(const pPointerSourceStart: IFPMarkupPointer;
                   const pPointerSourceFinish: IFPMarkupPointer;
                   const pPointerTarget: IFPMarkupPointer); safecall;
    procedure InsertText(const bstrText: WideString; const pPointerTarget: IFPMarkupPointer); safecall;
    procedure InsertHTML(const bstrHTML: WideString; const pPointerTarget: IFPMarkupPointer); safecall;
    function  GetElementTagId(const pElement: IHTMLElement): ELEMENT_TAG_ID; safecall;
    function  GetTagIDForName(const bstrName: WideString): ELEMENT_TAG_ID; safecall;
    function  GetNameForTagID(tagID: ELEMENT_TAG_ID): WideString; safecall;
    procedure MovePointersToRange(const pIRange: IHTMLTxtRange;
                                  const pPointerStart: IFPMarkupPointer;
                                  const pPointerFinish: IFPMarkupPointer); safecall;
    procedure MoveRangeToPointers(const pPointerStart: IFPMarkupPointer;
                                  const pPointerFinish: IFPMarkupPointer;
                                  const pIRange: IHTMLTxtRange); safecall;
    procedure BeginUndoUnit(const bstrTitle: WideString); safecall;
    procedure EndUndoUnit; safecall;
  end;

// *********************************************************************//
// DispIntf:  IFPMarkupServicesDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {3050F4A0-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IFPMarkupServicesDisp = dispinterface
    ['{3050F4A0-98B5-11CF-BB82-00AA00BDCE0B}']
    function  CreateMarkupPointer: IFPMarkupPointer; dispid 1111;
    function  CreateMarkupContainer: IFPMarkupContainer; dispid 1112;
    function  CreateMarkupElement(tagID: ELEMENT_TAG_ID; const bstrAttributes: WideString): IHTMLElement; dispid 1113;
    function  CloneElement(const pElemCloneThis: IHTMLElement): IHTMLElement; dispid 1114;
    procedure InsertElement(const pElementInsert: IHTMLElement;
                            const pPointerStart: IFPMarkupPointer;
                            const pPointerFinish: IFPMarkupPointer); dispid 1115;
    procedure RemoveElement(const pElementRemove: IHTMLElement); dispid 1116;
    procedure Remove(const pPointerStart: IFPMarkupPointer; const pPointerFinish: IFPMarkupPointer); dispid 1117;
    procedure Copy(const pPointerSourceStart: IFPMarkupPointer;
                   const pPointerSourceFinish: IFPMarkupPointer;
                   const pPointerTarget: IFPMarkupPointer); dispid 1118;
    procedure Move(const pPointerSourceStart: IFPMarkupPointer;
                   const pPointerSourceFinish: IFPMarkupPointer;
                   const pPointerTarget: IFPMarkupPointer); dispid 1119;
    procedure InsertText(const bstrText: WideString; const pPointerTarget: IFPMarkupPointer); dispid 1120;
    procedure InsertHTML(const bstrHTML: WideString; const pPointerTarget: IFPMarkupPointer); dispid 1121;
    function  GetElementTagId(const pElement: IHTMLElement): ELEMENT_TAG_ID; dispid 1122;
    function  GetTagIDForName(const bstrName: WideString): ELEMENT_TAG_ID; dispid 1123;
    function  GetNameForTagID(tagID: ELEMENT_TAG_ID): WideString; dispid 1124;
    procedure MovePointersToRange(const pIRange: IHTMLTxtRange;
                                  const pPointerStart: IFPMarkupPointer;
                                  const pPointerFinish: IFPMarkupPointer); dispid 1125;
    procedure MoveRangeToPointers(const pPointerStart: IFPMarkupPointer;
                                  const pPointerFinish: IFPMarkupPointer;
                                  const pIRange: IHTMLTxtRange); dispid 1126;
    procedure BeginUndoUnit(const bstrTitle: WideString); dispid 1127;
    procedure EndUndoUnit; dispid 1128;
  end;

// *********************************************************************//
// Interface: IHTMLTxtRange
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F220-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTxtRange = interface(IDispatch)
    ['{3050F220-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_htmlText: WideString; safecall;
    procedure Set_text(const p: WideString); safecall;
    function  Get_text: WideString; safecall;
    function  parentElement: IHTMLElement; safecall;
    function  duplicate: IHTMLTxtRange; safecall;
    function  inRange(const range: IHTMLTxtRange): WordBool; safecall;
    function  isEqual(const range: IHTMLTxtRange): WordBool; safecall;
    procedure scrollIntoView(fStart: WordBool); safecall;
    procedure collapse(start: WordBool); safecall;
    function  expand(const Unit_: WideString): WordBool; safecall;
    function  Move(const Unit_: WideString; Count: Integer): Integer; safecall;
    function  moveStart(const Unit_: WideString; Count: Integer): Integer; safecall;
    function  moveEnd(const Unit_: WideString; Count: Integer): Integer; safecall;
    procedure select; safecall;
    procedure pasteHTML(const html: WideString); safecall;
    procedure moveToElementText(const element: IHTMLElement); safecall;
    procedure setEndPoint(const how: WideString; const SourceRange: IHTMLTxtRange); safecall;
    function  compareEndPoints(const how: WideString; const SourceRange: IHTMLTxtRange): Integer; safecall;
    function  FindText(const String_: WideString; Count: Integer; flags: Integer): WordBool; safecall;
    procedure moveToPoint(x: Integer; y: Integer); safecall;
    function  getBookmark: WideString; safecall;
    function  moveToBookmark(const Bookmark: WideString): WordBool; safecall;
    function  queryCommandSupported(const cmdID: WideString): WordBool; safecall;
    function  queryCommandEnabled(const cmdID: WideString): WordBool; safecall;
    function  queryCommandState(const cmdID: WideString): WordBool; safecall;
    function  queryCommandIndeterm(const cmdID: WideString): WordBool; safecall;
    function  queryCommandText(const cmdID: WideString): WideString; safecall;
    function  queryCommandValue(const cmdID: WideString): OleVariant; safecall;
    function  execCommand(const cmdID: WideString; showUI: WordBool; value: OleVariant): WordBool; safecall;
    function  execCommandShowHelp(const cmdID: WideString): WordBool; safecall;
    property htmlText: WideString read Get_htmlText;
    property text: WideString read Get_text write Set_text;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTxtRangeDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F220-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTxtRangeDisp = dispinterface
    ['{3050F220-98B5-11CF-BB82-00AA00BDCE0B}']
    property htmlText: WideString readonly dispid 1003;
    property text: WideString dispid 1004;
    function  parentElement: IHTMLElement; dispid 1006;
    function  duplicate: IHTMLTxtRange; dispid 1008;
    function  inRange(const range: IHTMLTxtRange): WordBool; dispid 1010;
    function  isEqual(const range: IHTMLTxtRange): WordBool; dispid 1011;
    procedure scrollIntoView(fStart: WordBool); dispid 1012;
    procedure collapse(start: WordBool); dispid 1013;
    function  expand(const Unit_: WideString): WordBool; dispid 1014;
    function  Move(const Unit_: WideString; Count: Integer): Integer; dispid 1015;
    function  moveStart(const Unit_: WideString; Count: Integer): Integer; dispid 1016;
    function  moveEnd(const Unit_: WideString; Count: Integer): Integer; dispid 1017;
    procedure select; dispid 1024;
    procedure pasteHTML(const html: WideString); dispid 1026;
    procedure moveToElementText(const element: IHTMLElement); dispid 1001;
    procedure setEndPoint(const how: WideString; const SourceRange: IHTMLTxtRange); dispid 1025;
    function  compareEndPoints(const how: WideString; const SourceRange: IHTMLTxtRange): Integer; dispid 1018;
    function  FindText(const String_: WideString; Count: Integer; flags: Integer): WordBool; dispid 1019;
    procedure moveToPoint(x: Integer; y: Integer); dispid 1020;
    function  getBookmark: WideString; dispid 1021;
    function  moveToBookmark(const Bookmark: WideString): WordBool; dispid 1009;
    function  queryCommandSupported(const cmdID: WideString): WordBool; dispid 1027;
    function  queryCommandEnabled(const cmdID: WideString): WordBool; dispid 1028;
    function  queryCommandState(const cmdID: WideString): WordBool; dispid 1029;
    function  queryCommandIndeterm(const cmdID: WideString): WordBool; dispid 1030;
    function  queryCommandText(const cmdID: WideString): WideString; dispid 1031;
    function  queryCommandValue(const cmdID: WideString): OleVariant; dispid 1032;
    function  execCommand(const cmdID: WideString; showUI: WordBool; value: OleVariant): WordBool; dispid 1033;
    function  execCommandShowHelp(const cmdID: WideString): WordBool; dispid 1034;
  end;

// *********************************************************************//
// Interface: IFPDocument
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C86A1A00-FAA6-11D1-B3ED-0060977B463D}
// *********************************************************************//
  IFPDocument = interface(IDispatch)
    ['{C86A1A00-FAA6-11D1-B3ED-0060977B463D}']
    function  Get_DocumentHTML: WideString; safecall;
    procedure Set_DocumentHTML(const text: WideString); safecall;
    function  createUndoTransaction(const title: WideString): IDispatch; safecall;
    function  Get_isDirty: WordBool; safecall;
    procedure Set_isDirty(isDirty: WordBool); safecall;
    property DocumentHTML: WideString read Get_DocumentHTML write Set_DocumentHTML;
    property isDirty: WordBool read Get_isDirty write Set_isDirty;
  end;

// *********************************************************************//
// DispIntf:  IFPDocumentDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C86A1A00-FAA6-11D1-B3ED-0060977B463D}
// *********************************************************************//
  IFPDocumentDisp = dispinterface
    ['{C86A1A00-FAA6-11D1-B3ED-0060977B463D}']
    property DocumentHTML: WideString dispid 1101;
    function  createUndoTransaction(const title: WideString): IDispatch; dispid 1102;
    property isDirty: WordBool dispid 1103;
  end;

// *********************************************************************//
// Interface: IFPHTMLUndoTransaction
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C86A1A01-FAA6-11D1-B3ED-0060977B463D}
// *********************************************************************//
  IFPHTMLUndoTransaction = interface(IDispatch)
    ['{C86A1A01-FAA6-11D1-B3ED-0060977B463D}']
    procedure commit; safecall;
    procedure abort; safecall;
  end;

// *********************************************************************//
// DispIntf:  IFPHTMLUndoTransactionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {C86A1A01-FAA6-11D1-B3ED-0060977B463D}
// *********************************************************************//
  IFPHTMLUndoTransactionDisp = dispinterface
    ['{C86A1A01-FAA6-11D1-B3ED-0060977B463D}']
    procedure commit; dispid 1001;
    procedure abort; dispid 1002;
  end;

// *********************************************************************//
// Interface: IFrontPageHostedControl
// Flags:     (0)
// GUID:      {5497064A-5CF4-11D2-AD3E-00C04F795285}
// *********************************************************************//
  IFrontPageHostedControl = interface(IUnknown)
    ['{5497064A-5CF4-11D2-AD3E-00C04F795285}']
    function  OnLayout: HResult; stdcall;
    function  OnRemove: HResult; stdcall;
    function  OnRestore: HResult; stdcall;
  end;

// *********************************************************************//
// DispIntf:  DispFPHTMLDocument
// Flags:     (4112) Hidden Dispatchable
// GUID:      {CD6F2F18-030B-11D2-B3F0-0060977B463D}
// *********************************************************************//
  DispFPHTMLDocument = dispinterface
    ['{CD6F2F18-030B-11D2-B3F0-0060977B463D}']
    property Script: IDispatch readonly dispid 1001;
    property all: IHTMLElementCollection readonly dispid 1003;
    property body: IHTMLElement readonly dispid 1004;
    property activeElement: IHTMLElement readonly dispid 1005;
    property images: IHTMLElementCollection readonly dispid 1011;
    property applets: IHTMLElementCollection readonly dispid 1008;
    property links: IHTMLElementCollection readonly dispid 1009;
    property forms: IHTMLElementCollection readonly dispid 1010;
    property anchors: IHTMLElementCollection readonly dispid 1007;
    property title: WideString dispid 1012;
    property scripts: IHTMLElementCollection readonly dispid 1013;
    property designMode: WideString dispid 1014;
    property selection: IHTMLSelectionObject readonly dispid 1017;
    property ReadyState: WideString readonly dispid 1018;
    property frames: IHTMLFramesCollection2 readonly dispid 1019;
    property embeds: IHTMLElementCollection readonly dispid 1015;
    property plugins: IHTMLElementCollection readonly dispid 1021;
    property alinkColor: OleVariant dispid 1022;
    property bgColor: OleVariant dispid -501;
    property fgColor: OleVariant dispid -2147413110;
    property linkColor: OleVariant dispid 1024;
    property vlinkColor: OleVariant dispid 1023;
    property referrer: WideString readonly dispid 1027;
    property location: IHTMLLocation readonly dispid 1026;
    property lastModified: WideString readonly dispid 1028;
    property URL: WideString dispid 1025;
    property domain: WideString dispid 1029;
    property cookie: WideString dispid 1030;
    property expando: WordBool dispid 1031;
    property charset: WideString dispid 1032;
    property defaultCharset: WideString dispid 1033;
    property mimeType: WideString readonly dispid 1041;
    property fileSize: WideString readonly dispid 1042;
    property fileCreatedDate: WideString readonly dispid 1043;
    property fileModifiedDate: WideString readonly dispid 1044;
    property fileUpdatedDate: WideString readonly dispid 1045;
    property security: WideString readonly dispid 1046;
    property protocol: WideString readonly dispid 1047;
    property nameProp: WideString readonly dispid 1048;
    procedure write(psarray: {??PSafeArray} OleVariant); dispid 1054;
    procedure writeln(psarray: {??PSafeArray} OleVariant); dispid 1055;
    function  open(const URL: WideString; name: OleVariant; features: OleVariant;
                   replace: OleVariant): IDispatch; dispid 1056;
    procedure close; dispid 1057;
    procedure clear; dispid 1058;
    function  queryCommandSupported(const cmdID: WideString): WordBool; dispid 1059;
    function  queryCommandEnabled(const cmdID: WideString): WordBool; dispid 1060;
    function  queryCommandState(const cmdID: WideString): WordBool; dispid 1061;
    function  queryCommandIndeterm(const cmdID: WideString): WordBool; dispid 1062;
    function  queryCommandText(const cmdID: WideString): WideString; dispid 1063;
    function  queryCommandValue(const cmdID: WideString): OleVariant; dispid 1064;
    function  execCommand(const cmdID: WideString; showUI: WordBool; value: OleVariant): WordBool; dispid 1065;
    function  execCommandShowHelp(const cmdID: WideString): WordBool; dispid 1066;
    function  createElement(const eTag: WideString): IHTMLElement; dispid 1067;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseup: OleVariant dispid -2147412109;
    property onmousedown: OleVariant dispid -2147412110;
    property onmousemove: OleVariant dispid -2147412108;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onreadystatechange: OleVariant dispid -2147412087;
    property onafterupdate: OleVariant dispid -2147412090;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondragstart: OleVariant dispid -2147412077;
    property onselectstart: OleVariant dispid -2147412075;
    function  elementFromPoint(x: Integer; y: Integer): IHTMLElement; dispid 1068;
    property parentWindow: IHTMLWindow2 readonly dispid 1034;
    property styleSheets: IHTMLStyleSheetsCollection readonly dispid 1069;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onerrorupdate: OleVariant dispid -2147412074;
    function  toString: WideString; dispid 1070;
    function  createStyleSheet(const bstrHref: WideString; lIndex: Integer): IHTMLStyleSheet; dispid 1071;
    property DocumentHTML: WideString dispid 1101;
    function  createUndoTransaction(const title: WideString): IDispatch; dispid 1102;
  end;

// *********************************************************************//
// DispIntf:  HTMLDocumentEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F260-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLDocumentEvents = dispinterface
    ['{3050F260-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    function  onkeypress: WordBool; dispid -603;
    procedure onmousedown; dispid -605;
    procedure onmousemove; dispid -606;
    procedure onmouseup; dispid -607;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onreadystatechange; dispid -609;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onselectstart: WordBool; dispid -2147418100;
    function  onerrorupdate: WordBool; dispid -2147418099;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLLinkElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F524-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLLinkElement = dispinterface
    ['{3050F524-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property href: WideString dispid 1005;
    property rel: WideString dispid 1006;
    property rev: WideString dispid 1007;
    property type_: WideString dispid 1008;
    property ReadyState: WideString readonly dispid 1009;
    property onreadystatechange: OleVariant dispid -2147412087;
    property onload: OleVariant dispid -2147412080;
    property onerror: OleVariant dispid -2147412083;
    property styleSheet: IHTMLStyleSheet readonly dispid 1014;
    property disabled: WordBool dispid 1015;
    property media: WideString dispid 1016;
  end;

// *********************************************************************//
// DispIntf:  HTMLLinkElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F3CC-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLLinkElementEvents = dispinterface
    ['{3050F3CC-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onreadystatechange; dispid -609;
    procedure onload; dispid 1003;
    procedure onerror; dispid 1002;
  end;

// *********************************************************************//
// Interface: IHTMLLinkElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F205-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLLinkElement = interface(IDispatch)
    ['{3050F205-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_href(const p: WideString); safecall;
    function  Get_href: WideString; safecall;
    procedure Set_rel(const p: WideString); safecall;
    function  Get_rel: WideString; safecall;
    procedure Set_rev(const p: WideString); safecall;
    function  Get_rev: WideString; safecall;
    procedure Set_type_(const p: WideString); safecall;
    function  Get_type_: WideString; safecall;
    function  Get_ReadyState: WideString; safecall;
    procedure Set_onreadystatechange(p: OleVariant); safecall;
    function  Get_onreadystatechange: OleVariant; safecall;
    procedure Set_onload(p: OleVariant); safecall;
    function  Get_onload: OleVariant; safecall;
    procedure Set_onerror(p: OleVariant); safecall;
    function  Get_onerror: OleVariant; safecall;
    function  Get_styleSheet: IHTMLStyleSheet; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    procedure Set_media(const p: WideString); safecall;
    function  Get_media: WideString; safecall;
    property href: WideString read Get_href write Set_href;
    property rel: WideString read Get_rel write Set_rel;
    property rev: WideString read Get_rev write Set_rev;
    property type_: WideString read Get_type_ write Set_type_;
    property ReadyState: WideString read Get_ReadyState;
    property onreadystatechange: OleVariant read Get_onreadystatechange write Set_onreadystatechange;
    property onload: OleVariant read Get_onload write Set_onload;
    property onerror: OleVariant read Get_onerror write Set_onerror;
    property styleSheet: IHTMLStyleSheet read Get_styleSheet;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property media: WideString read Get_media write Set_media;
  end;

// *********************************************************************//
// DispIntf:  IHTMLLinkElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F205-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLLinkElementDisp = dispinterface
    ['{3050F205-98B5-11CF-BB82-00AA00BDCE0B}']
    property href: WideString dispid 1005;
    property rel: WideString dispid 1006;
    property rev: WideString dispid 1007;
    property type_: WideString dispid 1008;
    property ReadyState: WideString readonly dispid 1009;
    property onreadystatechange: OleVariant dispid -2147412087;
    property onload: OleVariant dispid -2147412080;
    property onerror: OleVariant dispid -2147412083;
    property styleSheet: IHTMLStyleSheet readonly dispid 1014;
    property disabled: WordBool dispid 1015;
    property media: WideString dispid 1016;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLFormElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F510-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLFormElement = dispinterface
    ['{3050F510-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property action: WideString dispid 1001;
    property dir: WideString dispid 1002;
    property encoding: WideString dispid 1003;
    property method: WideString dispid 1004;
    property elements: IDispatch readonly dispid 1005;
    property target: WideString dispid 1006;
    property name: WideString dispid -2147418112;
    property onsubmit: OleVariant dispid -2147412101;
    property onreset: OleVariant dispid -2147412100;
    procedure submit; dispid 1009;
    procedure reset; dispid 1010;
    property length: Integer dispid 1500;
    property _NewEnum: IUnknown readonly dispid -4;
    function  item(name: OleVariant; index: OleVariant): IDispatch; dispid 0;
    function  tags(tagName: OleVariant): IDispatch; dispid 1502;
  end;

// *********************************************************************//
// DispIntf:  HTMLFormElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F364-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLFormElementEvents = dispinterface
    ['{3050F364-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    function  onsubmit: WordBool; dispid 1007;
    function  onreset: WordBool; dispid 1015;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLTextElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F537-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLTextElement = dispinterface
    ['{3050F537-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
  end;

// *********************************************************************//
// DispIntf:  HTMLElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F33C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLElementEvents = dispinterface
    ['{3050F33C-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
  end;

// *********************************************************************//
// Interface: IHTMLTextElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F218-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTextElement = interface(IDispatch)
    ['{3050F218-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  IHTMLTextElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F218-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTextElementDisp = dispinterface
    ['{3050F218-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLImgElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F51C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLImgElement = dispinterface
    ['{3050F51C-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property isMap: WordBool dispid 2002;
    property useMap: WideString dispid 2008;
    property mimeType: WideString readonly dispid 2010;
    property fileSize: WideString readonly dispid 2011;
    property fileCreatedDate: WideString readonly dispid 2012;
    property fileModifiedDate: WideString readonly dispid 2013;
    property fileUpdatedDate: WideString readonly dispid 2014;
    property protocol: WideString readonly dispid 2015;
    property href: WideString readonly dispid 2016;
    property nameProp: WideString readonly dispid 2017;
    property border: OleVariant dispid 1004;
    property vspace: Integer dispid 1005;
    property hspace: Integer dispid 1006;
    property alt: WideString dispid 1002;
    property src: WideString dispid 1003;
    property lowsrc: WideString dispid 1007;
    property vrml: WideString dispid 1008;
    property dynsrc: WideString dispid 1009;
    property ReadyState: WideString readonly dispid 1012;
    property complete: WordBool readonly dispid 1010;
    property loop: OleVariant dispid 1011;
    property align: WideString dispid -2147418039;
    property onload: OleVariant dispid -2147412080;
    property onerror: OleVariant dispid -2147412083;
    property onabort: OleVariant dispid -2147412084;
    property name: WideString dispid -2147418112;
    property width: Integer dispid -2147418107;
    property height: Integer dispid -2147418106;
    property start: WideString dispid 1013;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  HTMLImgEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F25B-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLImgEvents = dispinterface
    ['{3050F25B-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
    procedure onreadystatechange; dispid -609;
    procedure onload; dispid 1003;
    procedure onerror; dispid 1002;
    procedure onabort; dispid 1000;
  end;

// *********************************************************************//
// Interface: IHTMLControlElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {04598FC6-866C-11CF-AB7C-00AA00C08FCF}
// *********************************************************************//
  IHTMLControlElement = interface(IDispatch)
    ['{04598FC6-866C-11CF-AB7C-00AA00C08FCF}']
    procedure Set_tabIndex(p: Smallint); safecall;
    function  Get_tabIndex: Smallint; safecall;
    procedure focus; safecall;
    procedure Set_accessKey(const p: WideString); safecall;
    function  Get_accessKey: WideString; safecall;
    procedure Set_onblur(p: OleVariant); safecall;
    function  Get_onblur: OleVariant; safecall;
    procedure Set_onfocus(p: OleVariant); safecall;
    function  Get_onfocus: OleVariant; safecall;
    procedure Set_onresize(p: OleVariant); safecall;
    function  Get_onresize: OleVariant; safecall;
    procedure blur; safecall;
    procedure addFilter(const pUnk: IUnknown); safecall;
    procedure removeFilter(const pUnk: IUnknown); safecall;
    function  Get_clientHeight: Integer; safecall;
    function  Get_clientWidth: Integer; safecall;
    function  Get_clientTop: Integer; safecall;
    function  Get_clientLeft: Integer; safecall;
    property tabIndex: Smallint read Get_tabIndex write Set_tabIndex;
    property accessKey: WideString read Get_accessKey write Set_accessKey;
    property onblur: OleVariant read Get_onblur write Set_onblur;
    property onfocus: OleVariant read Get_onfocus write Set_onfocus;
    property onresize: OleVariant read Get_onresize write Set_onresize;
    property clientHeight: Integer read Get_clientHeight;
    property clientWidth: Integer read Get_clientWidth;
    property clientTop: Integer read Get_clientTop;
    property clientLeft: Integer read Get_clientLeft;
  end;

// *********************************************************************//
// DispIntf:  IHTMLControlElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {04598FC6-866C-11CF-AB7C-00AA00C08FCF}
// *********************************************************************//
  IHTMLControlElementDisp = dispinterface
    ['{04598FC6-866C-11CF-AB7C-00AA00C08FCF}']
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
  end;

// *********************************************************************//
// Interface: IHTMLDatabinding
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3F2-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDatabinding = interface(IDispatch)
    ['{3050F3F2-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_dataFld(const p: WideString); safecall;
    function  Get_dataFld: WideString; safecall;
    procedure Set_dataSrc(const p: WideString); safecall;
    function  Get_dataSrc: WideString; safecall;
    procedure Set_dataFormatAs(const p: WideString); safecall;
    function  Get_dataFormatAs: WideString; safecall;
    property dataFld: WideString read Get_dataFld write Set_dataFld;
    property dataSrc: WideString read Get_dataSrc write Set_dataSrc;
    property dataFormatAs: WideString read Get_dataFormatAs write Set_dataFormatAs;
  end;

// *********************************************************************//
// DispIntf:  IHTMLDatabindingDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3F2-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDatabindingDisp = dispinterface
    ['{3050F3F2-98B5-11CF-BB82-00AA00BDCE0B}']
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLInputImage
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F51D-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLInputImage = dispinterface
    ['{3050F51D-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property type_: WideString readonly dispid 2000;
    property disabled: WordBool dispid -2147418036;
    property border: OleVariant dispid 1004;
    property vspace: Integer dispid 1005;
    property hspace: Integer dispid 1006;
    property alt: WideString dispid 1002;
    property src: WideString dispid 1003;
    property lowsrc: WideString dispid 1007;
    property vrml: WideString dispid 1008;
    property dynsrc: WideString dispid 1009;
    property ReadyState: WideString readonly dispid 1012;
    property complete: WordBool readonly dispid 1010;
    property loop: OleVariant dispid 1011;
    property align: WideString dispid -2147418039;
    property onload: OleVariant dispid -2147412080;
    property onerror: OleVariant dispid -2147412083;
    property onabort: OleVariant dispid -2147412084;
    property name: WideString dispid -2147418112;
    property width: Integer dispid -2147418107;
    property height: Integer dispid -2147418106;
    property start: WideString dispid 1013;
  end;

// *********************************************************************//
// DispIntf:  HTMLInputImageEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F2C3-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLInputImageEvents = dispinterface
    ['{3050F2C3-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
    procedure onreadystatechange; dispid -609;
    procedure onload; dispid 1003;
    procedure onerror; dispid 1002;
    procedure onabort; dispid 1000;
  end;

// *********************************************************************//
// Interface: IHTMLInputImage
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2C2-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputImage = interface(IDispatch)
    ['{3050F2C2-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_type_: WideString; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    procedure Set_border(p: OleVariant); safecall;
    function  Get_border: OleVariant; safecall;
    procedure Set_vspace(p: Integer); safecall;
    function  Get_vspace: Integer; safecall;
    procedure Set_hspace(p: Integer); safecall;
    function  Get_hspace: Integer; safecall;
    procedure Set_alt(const p: WideString); safecall;
    function  Get_alt: WideString; safecall;
    procedure Set_src(const p: WideString); safecall;
    function  Get_src: WideString; safecall;
    procedure Set_lowsrc(const p: WideString); safecall;
    function  Get_lowsrc: WideString; safecall;
    procedure Set_vrml(const p: WideString); safecall;
    function  Get_vrml: WideString; safecall;
    procedure Set_dynsrc(const p: WideString); safecall;
    function  Get_dynsrc: WideString; safecall;
    function  Get_ReadyState: WideString; safecall;
    function  Get_complete: WordBool; safecall;
    procedure Set_loop(p: OleVariant); safecall;
    function  Get_loop: OleVariant; safecall;
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_onload(p: OleVariant); safecall;
    function  Get_onload: OleVariant; safecall;
    procedure Set_onerror(p: OleVariant); safecall;
    function  Get_onerror: OleVariant; safecall;
    procedure Set_onabort(p: OleVariant); safecall;
    function  Get_onabort: OleVariant; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_width(p: Integer); safecall;
    function  Get_width: Integer; safecall;
    procedure Set_height(p: Integer); safecall;
    function  Get_height: Integer; safecall;
    procedure Set_start(const p: WideString); safecall;
    function  Get_start: WideString; safecall;
    property type_: WideString read Get_type_;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property border: OleVariant read Get_border write Set_border;
    property vspace: Integer read Get_vspace write Set_vspace;
    property hspace: Integer read Get_hspace write Set_hspace;
    property alt: WideString read Get_alt write Set_alt;
    property src: WideString read Get_src write Set_src;
    property lowsrc: WideString read Get_lowsrc write Set_lowsrc;
    property vrml: WideString read Get_vrml write Set_vrml;
    property dynsrc: WideString read Get_dynsrc write Set_dynsrc;
    property ReadyState: WideString read Get_ReadyState;
    property complete: WordBool read Get_complete;
    property loop: OleVariant read Get_loop write Set_loop;
    property align: WideString read Get_align write Set_align;
    property onload: OleVariant read Get_onload write Set_onload;
    property onerror: OleVariant read Get_onerror write Set_onerror;
    property onabort: OleVariant read Get_onabort write Set_onabort;
    property name: WideString read Get_name write Set_name;
    property width: Integer read Get_width write Set_width;
    property height: Integer read Get_height write Set_height;
    property start: WideString read Get_start write Set_start;
  end;

// *********************************************************************//
// DispIntf:  IHTMLInputImageDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2C2-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputImageDisp = dispinterface
    ['{3050F2C2-98B5-11CF-BB82-00AA00BDCE0B}']
    property type_: WideString readonly dispid 2000;
    property disabled: WordBool dispid -2147418036;
    property border: OleVariant dispid 1004;
    property vspace: Integer dispid 1005;
    property hspace: Integer dispid 1006;
    property alt: WideString dispid 1002;
    property src: WideString dispid 1003;
    property lowsrc: WideString dispid 1007;
    property vrml: WideString dispid 1008;
    property dynsrc: WideString dispid 1009;
    property ReadyState: WideString readonly dispid 1012;
    property complete: WordBool readonly dispid 1010;
    property loop: OleVariant dispid 1011;
    property align: WideString dispid -2147418039;
    property onload: OleVariant dispid -2147412080;
    property onerror: OleVariant dispid -2147412083;
    property onabort: OleVariant dispid -2147412084;
    property name: WideString dispid -2147418112;
    property width: Integer dispid -2147418107;
    property height: Integer dispid -2147418106;
    property start: WideString dispid 1013;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLBodyElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F507-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLBodyElement = dispinterface
    ['{3050F507-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property background: WideString dispid -2147413111;
    property bgProperties: WideString dispid -2147413067;
    property leftMargin: OleVariant dispid -2147413072;
    property topMargin: OleVariant dispid -2147413075;
    property rightMargin: OleVariant dispid -2147413074;
    property bottomMargin: OleVariant dispid -2147413073;
    property noWrap: WordBool dispid -2147413107;
    property bgColor: OleVariant dispid -501;
    property text: OleVariant dispid -2147413110;
    property link: OleVariant dispid 2010;
    property vLink: OleVariant dispid 2012;
    property aLink: OleVariant dispid 2011;
    property onload: OleVariant dispid -2147412080;
    property onunload: OleVariant dispid -2147412079;
    property scroll: WideString dispid -2147413033;
    property onselect: OleVariant dispid -2147412102;
    property onbeforeunload: OleVariant dispid -2147412073;
    function  createTextRange: IHTMLTxtRange; dispid 2013;
  end;

// *********************************************************************//
// DispIntf:  HTMLTextContainerEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {1FF6AA72-5842-11CF-A707-00AA00C0098D}
// *********************************************************************//
  HTMLTextContainerEvents = dispinterface
    ['{1FF6AA72-5842-11CF-A707-00AA00C0098D}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
    procedure onchange; dispid 1001;
    procedure onscroll; dispid 1014;
    procedure onselect; dispid 1006;
  end;

// *********************************************************************//
// Interface: IHTMLBodyElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1D8-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBodyElement = interface(IDispatch)
    ['{3050F1D8-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_background(const p: WideString); safecall;
    function  Get_background: WideString; safecall;
    procedure Set_bgProperties(const p: WideString); safecall;
    function  Get_bgProperties: WideString; safecall;
    procedure Set_leftMargin(p: OleVariant); safecall;
    function  Get_leftMargin: OleVariant; safecall;
    procedure Set_topMargin(p: OleVariant); safecall;
    function  Get_topMargin: OleVariant; safecall;
    procedure Set_rightMargin(p: OleVariant); safecall;
    function  Get_rightMargin: OleVariant; safecall;
    procedure Set_bottomMargin(p: OleVariant); safecall;
    function  Get_bottomMargin: OleVariant; safecall;
    procedure Set_noWrap(p: WordBool); safecall;
    function  Get_noWrap: WordBool; safecall;
    procedure Set_bgColor(p: OleVariant); safecall;
    function  Get_bgColor: OleVariant; safecall;
    procedure Set_text(p: OleVariant); safecall;
    function  Get_text: OleVariant; safecall;
    procedure Set_link(p: OleVariant); safecall;
    function  Get_link: OleVariant; safecall;
    procedure Set_vLink(p: OleVariant); safecall;
    function  Get_vLink: OleVariant; safecall;
    procedure Set_aLink(p: OleVariant); safecall;
    function  Get_aLink: OleVariant; safecall;
    procedure Set_onload(p: OleVariant); safecall;
    function  Get_onload: OleVariant; safecall;
    procedure Set_onunload(p: OleVariant); safecall;
    function  Get_onunload: OleVariant; safecall;
    procedure Set_scroll(const p: WideString); safecall;
    function  Get_scroll: WideString; safecall;
    procedure Set_onselect(p: OleVariant); safecall;
    function  Get_onselect: OleVariant; safecall;
    procedure Set_onbeforeunload(p: OleVariant); safecall;
    function  Get_onbeforeunload: OleVariant; safecall;
    function  createTextRange: IHTMLTxtRange; safecall;
    property background: WideString read Get_background write Set_background;
    property bgProperties: WideString read Get_bgProperties write Set_bgProperties;
    property leftMargin: OleVariant read Get_leftMargin write Set_leftMargin;
    property topMargin: OleVariant read Get_topMargin write Set_topMargin;
    property rightMargin: OleVariant read Get_rightMargin write Set_rightMargin;
    property bottomMargin: OleVariant read Get_bottomMargin write Set_bottomMargin;
    property noWrap: WordBool read Get_noWrap write Set_noWrap;
    property bgColor: OleVariant read Get_bgColor write Set_bgColor;
    property text: OleVariant read Get_text write Set_text;
    property link: OleVariant read Get_link write Set_link;
    property vLink: OleVariant read Get_vLink write Set_vLink;
    property aLink: OleVariant read Get_aLink write Set_aLink;
    property onload: OleVariant read Get_onload write Set_onload;
    property onunload: OleVariant read Get_onunload write Set_onunload;
    property scroll: WideString read Get_scroll write Set_scroll;
    property onselect: OleVariant read Get_onselect write Set_onselect;
    property onbeforeunload: OleVariant read Get_onbeforeunload write Set_onbeforeunload;
  end;

// *********************************************************************//
// DispIntf:  IHTMLBodyElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1D8-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBodyElementDisp = dispinterface
    ['{3050F1D8-98B5-11CF-BB82-00AA00BDCE0B}']
    property background: WideString dispid -2147413111;
    property bgProperties: WideString dispid -2147413067;
    property leftMargin: OleVariant dispid -2147413072;
    property topMargin: OleVariant dispid -2147413075;
    property rightMargin: OleVariant dispid -2147413074;
    property bottomMargin: OleVariant dispid -2147413073;
    property noWrap: WordBool dispid -2147413107;
    property bgColor: OleVariant dispid -501;
    property text: OleVariant dispid -2147413110;
    property link: OleVariant dispid 2010;
    property vLink: OleVariant dispid 2012;
    property aLink: OleVariant dispid 2011;
    property onload: OleVariant dispid -2147412080;
    property onunload: OleVariant dispid -2147412079;
    property scroll: WideString dispid -2147413033;
    property onselect: OleVariant dispid -2147412102;
    property onbeforeunload: OleVariant dispid -2147412073;
    function  createTextRange: IHTMLTxtRange; dispid 2013;
  end;

// *********************************************************************//
// Interface: IHTMLTextContainer
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F230-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTextContainer = interface(IDispatch)
    ['{3050F230-98B5-11CF-BB82-00AA00BDCE0B}']
    function  createControlRange: IDispatch; safecall;
    function  Get_scrollHeight: Integer; safecall;
    function  Get_scrollWidth: Integer; safecall;
    procedure Set_scrollTop(p: Integer); safecall;
    function  Get_scrollTop: Integer; safecall;
    procedure Set_scrollLeft(p: Integer); safecall;
    function  Get_scrollLeft: Integer; safecall;
    procedure Set_onscroll(p: OleVariant); safecall;
    function  Get_onscroll: OleVariant; safecall;
    property scrollHeight: Integer read Get_scrollHeight;
    property scrollWidth: Integer read Get_scrollWidth;
    property scrollTop: Integer read Get_scrollTop write Set_scrollTop;
    property scrollLeft: Integer read Get_scrollLeft write Set_scrollLeft;
    property onscroll: OleVariant read Get_onscroll write Set_onscroll;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTextContainerDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F230-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTextContainerDisp = dispinterface
    ['{3050F230-98B5-11CF-BB82-00AA00BDCE0B}']
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLFontElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F512-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLFontElement = dispinterface
    ['{3050F512-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property color: OleVariant dispid -2147413110;
    property face: WideString dispid -2147413094;
    property size: OleVariant dispid -2147413093;
  end;

// *********************************************************************//
// Interface: IHTMLFontElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1D9-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFontElement = interface(IDispatch)
    ['{3050F1D9-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_color(p: OleVariant); safecall;
    function  Get_color: OleVariant; safecall;
    procedure Set_face(const p: WideString); safecall;
    function  Get_face: WideString; safecall;
    procedure Set_size(p: OleVariant); safecall;
    function  Get_size: OleVariant; safecall;
    property color: OleVariant read Get_color write Set_color;
    property face: WideString read Get_face write Set_face;
    property size: OleVariant read Get_size write Set_size;
  end;

// *********************************************************************//
// DispIntf:  IHTMLFontElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1D9-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFontElementDisp = dispinterface
    ['{3050F1D9-98B5-11CF-BB82-00AA00BDCE0B}']
    property color: OleVariant dispid -2147413110;
    property face: WideString dispid -2147413094;
    property size: OleVariant dispid -2147413093;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLAnchorElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F502-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLAnchorElement = dispinterface
    ['{3050F502-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property href: WideString dispid 0;
    property target: WideString dispid 1003;
    property rel: WideString dispid 1005;
    property rev: WideString dispid 1006;
    property urn: WideString dispid 1007;
    property Methods: WideString dispid 1008;
    property name: WideString dispid -2147418112;
    property host: WideString dispid 1012;
    property hostname: WideString dispid 1013;
    property pathname: WideString dispid 1014;
    property port: WideString dispid 1015;
    property protocol: WideString dispid 1016;
    property search: WideString dispid 1017;
    property hash: WideString dispid 1018;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property accessKey: WideString dispid 1022;
    property protocolLong: WideString readonly dispid 1031;
    property mimeType: WideString readonly dispid 1030;
    property nameProp: WideString readonly dispid 1032;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid 1033;
    procedure blur; dispid 1034;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  HTMLAnchorEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F29D-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLAnchorEvents = dispinterface
    ['{3050F29D-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
  end;

// *********************************************************************//
// Interface: IHTMLAnchorElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1DA-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLAnchorElement = interface(IDispatch)
    ['{3050F1DA-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_href(const p: WideString); safecall;
    function  Get_href: WideString; safecall;
    procedure Set_target(const p: WideString); safecall;
    function  Get_target: WideString; safecall;
    procedure Set_rel(const p: WideString); safecall;
    function  Get_rel: WideString; safecall;
    procedure Set_rev(const p: WideString); safecall;
    function  Get_rev: WideString; safecall;
    procedure Set_urn(const p: WideString); safecall;
    function  Get_urn: WideString; safecall;
    procedure Set_Methods(const p: WideString); safecall;
    function  Get_Methods: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_host(const p: WideString); safecall;
    function  Get_host: WideString; safecall;
    procedure Set_hostname(const p: WideString); safecall;
    function  Get_hostname: WideString; safecall;
    procedure Set_pathname(const p: WideString); safecall;
    function  Get_pathname: WideString; safecall;
    procedure Set_port(const p: WideString); safecall;
    function  Get_port: WideString; safecall;
    procedure Set_protocol(const p: WideString); safecall;
    function  Get_protocol: WideString; safecall;
    procedure Set_search(const p: WideString); safecall;
    function  Get_search: WideString; safecall;
    procedure Set_hash(const p: WideString); safecall;
    function  Get_hash: WideString; safecall;
    procedure Set_onblur(p: OleVariant); safecall;
    function  Get_onblur: OleVariant; safecall;
    procedure Set_onfocus(p: OleVariant); safecall;
    function  Get_onfocus: OleVariant; safecall;
    procedure Set_accessKey(const p: WideString); safecall;
    function  Get_accessKey: WideString; safecall;
    function  Get_protocolLong: WideString; safecall;
    function  Get_mimeType: WideString; safecall;
    function  Get_nameProp: WideString; safecall;
    procedure Set_tabIndex(p: Smallint); safecall;
    function  Get_tabIndex: Smallint; safecall;
    procedure focus; safecall;
    procedure blur; safecall;
    property href: WideString read Get_href write Set_href;
    property target: WideString read Get_target write Set_target;
    property rel: WideString read Get_rel write Set_rel;
    property rev: WideString read Get_rev write Set_rev;
    property urn: WideString read Get_urn write Set_urn;
    property Methods: WideString read Get_Methods write Set_Methods;
    property name: WideString read Get_name write Set_name;
    property host: WideString read Get_host write Set_host;
    property hostname: WideString read Get_hostname write Set_hostname;
    property pathname: WideString read Get_pathname write Set_pathname;
    property port: WideString read Get_port write Set_port;
    property protocol: WideString read Get_protocol write Set_protocol;
    property search: WideString read Get_search write Set_search;
    property hash: WideString read Get_hash write Set_hash;
    property onblur: OleVariant read Get_onblur write Set_onblur;
    property onfocus: OleVariant read Get_onfocus write Set_onfocus;
    property accessKey: WideString read Get_accessKey write Set_accessKey;
    property protocolLong: WideString read Get_protocolLong;
    property mimeType: WideString read Get_mimeType;
    property nameProp: WideString read Get_nameProp;
    property tabIndex: Smallint read Get_tabIndex write Set_tabIndex;
  end;

// *********************************************************************//
// DispIntf:  IHTMLAnchorElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1DA-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLAnchorElementDisp = dispinterface
    ['{3050F1DA-98B5-11CF-BB82-00AA00BDCE0B}']
    property href: WideString dispid 0;
    property target: WideString dispid 1003;
    property rel: WideString dispid 1005;
    property rev: WideString dispid 1006;
    property urn: WideString dispid 1007;
    property Methods: WideString dispid 1008;
    property name: WideString dispid -2147418112;
    property host: WideString dispid 1012;
    property hostname: WideString dispid 1013;
    property pathname: WideString dispid 1014;
    property port: WideString dispid 1015;
    property protocol: WideString dispid 1016;
    property search: WideString dispid 1017;
    property hash: WideString dispid 1018;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property accessKey: WideString dispid 1022;
    property protocolLong: WideString readonly dispid 1031;
    property mimeType: WideString readonly dispid 1030;
    property nameProp: WideString readonly dispid 1032;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid 1033;
    procedure blur; dispid 1034;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLLabelElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F522-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLLabelElement = dispinterface
    ['{3050F522-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property htmlFor: WideString dispid 1000;
    property accessKey: WideString dispid 1001;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  HTMLLabelEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F329-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLLabelEvents = dispinterface
    ['{3050F329-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
  end;

// *********************************************************************//
// Interface: IHTMLLabelElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F32A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLLabelElement = interface(IDispatch)
    ['{3050F32A-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_htmlFor(const p: WideString); safecall;
    function  Get_htmlFor: WideString; safecall;
    procedure Set_accessKey(const p: WideString); safecall;
    function  Get_accessKey: WideString; safecall;
    property htmlFor: WideString read Get_htmlFor write Set_htmlFor;
    property accessKey: WideString read Get_accessKey write Set_accessKey;
  end;

// *********************************************************************//
// DispIntf:  IHTMLLabelElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F32A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLLabelElementDisp = dispinterface
    ['{3050F32A-98B5-11CF-BB82-00AA00BDCE0B}']
    property htmlFor: WideString dispid 1000;
    property accessKey: WideString dispid 1001;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLListElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F525-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLListElement = dispinterface
    ['{3050F525-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
  end;

// *********************************************************************//
// Interface: IHTMLListElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F20E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLListElement = interface(IDispatch)
    ['{3050F20E-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  IHTMLListElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F20E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLListElementDisp = dispinterface
    ['{3050F20E-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLUListElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F538-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLUListElement = dispinterface
    ['{3050F538-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property compact: WordBool dispid 1002;
    property type_: WideString dispid -2147413095;
  end;

// *********************************************************************//
// Interface: IHTMLUListElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1DD-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLUListElement = interface(IDispatch)
    ['{3050F1DD-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_compact(p: WordBool); safecall;
    function  Get_compact: WordBool; safecall;
    procedure Set_type_(const p: WideString); safecall;
    function  Get_type_: WideString; safecall;
    property compact: WordBool read Get_compact write Set_compact;
    property type_: WideString read Get_type_ write Set_type_;
  end;

// *********************************************************************//
// DispIntf:  IHTMLUListElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1DD-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLUListElementDisp = dispinterface
    ['{3050F1DD-98B5-11CF-BB82-00AA00BDCE0B}']
    property compact: WordBool dispid 1002;
    property type_: WideString dispid -2147413095;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLOListElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F52A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLOListElement = dispinterface
    ['{3050F52A-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property compact: WordBool dispid 1002;
    property start: Integer dispid 1003;
    property type_: WideString dispid -2147413095;
  end;

// *********************************************************************//
// Interface: IHTMLOListElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1DE-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOListElement = interface(IDispatch)
    ['{3050F1DE-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_compact(p: WordBool); safecall;
    function  Get_compact: WordBool; safecall;
    procedure Set_start(p: Integer); safecall;
    function  Get_start: Integer; safecall;
    procedure Set_type_(const p: WideString); safecall;
    function  Get_type_: WideString; safecall;
    property compact: WordBool read Get_compact write Set_compact;
    property start: Integer read Get_start write Set_start;
    property type_: WideString read Get_type_ write Set_type_;
  end;

// *********************************************************************//
// DispIntf:  IHTMLOListElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1DE-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOListElementDisp = dispinterface
    ['{3050F1DE-98B5-11CF-BB82-00AA00BDCE0B}']
    property compact: WordBool dispid 1002;
    property start: Integer dispid 1003;
    property type_: WideString dispid -2147413095;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLLIElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F523-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLLIElement = dispinterface
    ['{3050F523-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property type_: WideString dispid -2147413095;
    property value: Integer dispid 1001;
  end;

// *********************************************************************//
// Interface: IHTMLLIElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1E0-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLLIElement = interface(IDispatch)
    ['{3050F1E0-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_type_(const p: WideString); safecall;
    function  Get_type_: WideString; safecall;
    procedure Set_value(p: Integer); safecall;
    function  Get_value: Integer; safecall;
    property type_: WideString read Get_type_ write Set_type_;
    property value: Integer read Get_value write Set_value;
  end;

// *********************************************************************//
// DispIntf:  IHTMLLIElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1E0-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLLIElementDisp = dispinterface
    ['{3050F1E0-98B5-11CF-BB82-00AA00BDCE0B}']
    property type_: WideString dispid -2147413095;
    property value: Integer dispid 1001;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLBlockElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F506-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLBlockElement = dispinterface
    ['{3050F506-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property clear: WideString dispid -2147413096;
  end;

// *********************************************************************//
// Interface: IHTMLBlockElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F208-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBlockElement = interface(IDispatch)
    ['{3050F208-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_clear(const p: WideString); safecall;
    function  Get_clear: WideString; safecall;
    property clear: WideString read Get_clear write Set_clear;
  end;

// *********************************************************************//
// DispIntf:  IHTMLBlockElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F208-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBlockElementDisp = dispinterface
    ['{3050F208-98B5-11CF-BB82-00AA00BDCE0B}']
    property clear: WideString dispid -2147413096;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLDivElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F50C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLDivElement = dispinterface
    ['{3050F50C-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property align: WideString dispid -2147418040;
    property noWrap: WordBool dispid -2147413107;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// Interface: IHTMLDivElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F200-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDivElement = interface(IDispatch)
    ['{3050F200-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_noWrap(p: WordBool); safecall;
    function  Get_noWrap: WordBool; safecall;
    property align: WideString read Get_align write Set_align;
    property noWrap: WordBool read Get_noWrap write Set_noWrap;
  end;

// *********************************************************************//
// DispIntf:  IHTMLDivElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F200-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDivElementDisp = dispinterface
    ['{3050F200-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418040;
    property noWrap: WordBool dispid -2147413107;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLDDElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F50B-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLDDElement = dispinterface
    ['{3050F50B-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property noWrap: WordBool dispid -2147413107;
  end;

// *********************************************************************//
// Interface: IHTMLDDElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F2-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDDElement = interface(IDispatch)
    ['{3050F1F2-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_noWrap(p: WordBool); safecall;
    function  Get_noWrap: WordBool; safecall;
    property noWrap: WordBool read Get_noWrap write Set_noWrap;
  end;

// *********************************************************************//
// DispIntf:  IHTMLDDElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F2-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDDElementDisp = dispinterface
    ['{3050F1F2-98B5-11CF-BB82-00AA00BDCE0B}']
    property noWrap: WordBool dispid -2147413107;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLDTElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F50D-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLDTElement = dispinterface
    ['{3050F50D-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property noWrap: WordBool dispid -2147413107;
  end;

// *********************************************************************//
// Interface: IHTMLDTElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F3-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDTElement = interface(IDispatch)
    ['{3050F1F3-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_noWrap(p: WordBool); safecall;
    function  Get_noWrap: WordBool; safecall;
    property noWrap: WordBool read Get_noWrap write Set_noWrap;
  end;

// *********************************************************************//
// DispIntf:  IHTMLDTElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F3-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDTElementDisp = dispinterface
    ['{3050F1F3-98B5-11CF-BB82-00AA00BDCE0B}']
    property noWrap: WordBool dispid -2147413107;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLBRElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F53A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLBRElement = dispinterface
    ['{3050F53A-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property clear: WideString dispid -2147413096;
  end;

// *********************************************************************//
// Interface: IHTMLBRElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F0-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBRElement = interface(IDispatch)
    ['{3050F1F0-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_clear(const p: WideString); safecall;
    function  Get_clear: WideString; safecall;
    property clear: WideString read Get_clear write Set_clear;
  end;

// *********************************************************************//
// DispIntf:  IHTMLBRElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F0-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBRElementDisp = dispinterface
    ['{3050F1F0-98B5-11CF-BB82-00AA00BDCE0B}']
    property clear: WideString dispid -2147413096;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLDListElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F53B-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLDListElement = dispinterface
    ['{3050F53B-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property compact: WordBool dispid 1001;
  end;

// *********************************************************************//
// Interface: IHTMLDListElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F1-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDListElement = interface(IDispatch)
    ['{3050F1F1-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_compact(p: WordBool); safecall;
    function  Get_compact: WordBool; safecall;
    property compact: WordBool read Get_compact write Set_compact;
  end;

// *********************************************************************//
// DispIntf:  IHTMLDListElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F1-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDListElementDisp = dispinterface
    ['{3050F1F1-98B5-11CF-BB82-00AA00BDCE0B}']
    property compact: WordBool dispid 1001;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLHRElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F53D-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLHRElement = dispinterface
    ['{3050F53D-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property align: WideString dispid -2147418040;
    property color: OleVariant dispid -2147413110;
    property noShade: WordBool dispid 1001;
    property width: OleVariant dispid -2147418107;
    property size: OleVariant dispid -2147418106;
  end;

// *********************************************************************//
// Interface: IHTMLHRElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F4-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLHRElement = interface(IDispatch)
    ['{3050F1F4-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_color(p: OleVariant); safecall;
    function  Get_color: OleVariant; safecall;
    procedure Set_noShade(p: WordBool); safecall;
    function  Get_noShade: WordBool; safecall;
    procedure Set_width(p: OleVariant); safecall;
    function  Get_width: OleVariant; safecall;
    procedure Set_size(p: OleVariant); safecall;
    function  Get_size: OleVariant; safecall;
    property align: WideString read Get_align write Set_align;
    property color: OleVariant read Get_color write Set_color;
    property noShade: WordBool read Get_noShade write Set_noShade;
    property width: OleVariant read Get_width write Set_width;
    property size: OleVariant read Get_size write Set_size;
  end;

// *********************************************************************//
// DispIntf:  IHTMLHRElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F4-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLHRElementDisp = dispinterface
    ['{3050F1F4-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418040;
    property color: OleVariant dispid -2147413110;
    property noShade: WordBool dispid 1001;
    property width: OleVariant dispid -2147418107;
    property size: OleVariant dispid -2147418106;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLParaElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F52C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLParaElement = dispinterface
    ['{3050F52C-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property clear: WideString dispid -2147413096;
    property align: WideString dispid -2147418040;
  end;

// *********************************************************************//
// Interface: IHTMLParaElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLParaElement = interface(IDispatch)
    ['{3050F1F5-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    property align: WideString read Get_align write Set_align;
  end;

// *********************************************************************//
// DispIntf:  IHTMLParaElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLParaElementDisp = dispinterface
    ['{3050F1F5-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418040;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLHeaderElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F515-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLHeaderElement = dispinterface
    ['{3050F515-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property clear: WideString dispid -2147413096;
    property align: WideString dispid -2147418040;
  end;

// *********************************************************************//
// Interface: IHTMLHeaderElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F6-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLHeaderElement = interface(IDispatch)
    ['{3050F1F6-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    property align: WideString read Get_align write Set_align;
  end;

// *********************************************************************//
// DispIntf:  IHTMLHeaderElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F1F6-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLHeaderElementDisp = dispinterface
    ['{3050F1F6-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418040;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLSelectElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F531-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLSelectElement = dispinterface
    ['{3050F531-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property size: Integer dispid 1002;
    property multiple: WordBool dispid 1003;
    property name: WideString dispid -2147418112;
    property options: IDispatch readonly dispid 1005;
    property onchange: OleVariant dispid -2147412082;
    property selectedIndex: Integer dispid 1010;
    property type_: WideString readonly dispid 1012;
    property value: WideString dispid 1011;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    procedure add(const element: IHTMLElement; before: OleVariant); dispid 1503;
    procedure Remove(index: Integer); dispid 1504;
    property length: Integer dispid 1500;
    property _NewEnum: IUnknown readonly dispid -4;
    function  item(name: OleVariant; index: OleVariant): IDispatch; dispid 0;
    function  tags(tagName: OleVariant): IDispatch; dispid 1502;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  HTMLSelectElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F302-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLSelectElementEvents = dispinterface
    ['{3050F302-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
    procedure onchange; dispid 1001;
  end;

// *********************************************************************//
// Interface: IHTMLSelectElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F244-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLSelectElement = interface(IDispatch)
    ['{3050F244-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_size(p: Integer); safecall;
    function  Get_size: Integer; safecall;
    procedure Set_multiple(p: WordBool); safecall;
    function  Get_multiple: WordBool; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    function  Get_options: IDispatch; safecall;
    procedure Set_onchange(p: OleVariant); safecall;
    function  Get_onchange: OleVariant; safecall;
    procedure Set_selectedIndex(p: Integer); safecall;
    function  Get_selectedIndex: Integer; safecall;
    function  Get_type_: WideString; safecall;
    procedure Set_value(const p: WideString); safecall;
    function  Get_value: WideString; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    procedure add(const element: IHTMLElement; before: OleVariant); safecall;
    procedure Remove(index: Integer); safecall;
    procedure Set_length(p: Integer); safecall;
    function  Get_length: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  item(name: OleVariant; index: OleVariant): IDispatch; safecall;
    function  tags(tagName: OleVariant): IDispatch; safecall;
    property size: Integer read Get_size write Set_size;
    property multiple: WordBool read Get_multiple write Set_multiple;
    property name: WideString read Get_name write Set_name;
    property options: IDispatch read Get_options;
    property onchange: OleVariant read Get_onchange write Set_onchange;
    property selectedIndex: Integer read Get_selectedIndex write Set_selectedIndex;
    property type_: WideString read Get_type_;
    property value: WideString read Get_value write Set_value;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property form: IHTMLFormElement read Get_form;
    property length: Integer read Get_length write Set_length;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IHTMLSelectElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F244-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLSelectElementDisp = dispinterface
    ['{3050F244-98B5-11CF-BB82-00AA00BDCE0B}']
    property size: Integer dispid 1002;
    property multiple: WordBool dispid 1003;
    property name: WideString dispid -2147418112;
    property options: IDispatch readonly dispid 1005;
    property onchange: OleVariant dispid -2147412082;
    property selectedIndex: Integer dispid 1010;
    property type_: WideString readonly dispid 1012;
    property value: WideString dispid 1011;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    procedure add(const element: IHTMLElement; before: OleVariant); dispid 1503;
    procedure Remove(index: Integer); dispid 1504;
    property length: Integer dispid 1500;
    property _NewEnum: IUnknown readonly dispid -4;
    function  item(name: OleVariant; index: OleVariant): IDispatch; dispid 0;
    function  tags(tagName: OleVariant): IDispatch; dispid 1502;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLOptionElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F52B-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLOptionElement = dispinterface
    ['{3050F52B-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property selected: WordBool dispid 1001;
    property value: WideString dispid 1002;
    property defaultSelected: WordBool dispid 1003;
    property index: Integer dispid 1005;
    property text: WideString dispid 1004;
    property form: IHTMLFormElement readonly dispid 1006;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLInputTextElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F520-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLInputTextElement = dispinterface
    ['{3050F520-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property type_: WideString readonly dispid 2000;
    property value: WideString dispid -2147413011;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    property defaultValue: WideString dispid -2147413029;
    property size: Integer dispid 4001;
    property maxLength: Integer dispid 4002;
    procedure select; dispid 3003;
    property onchange: OleVariant dispid -2147412082;
    property onselect: OleVariant dispid -2147412102;
    property readOnly: WordBool dispid 3001;
    function  createTextRange: IHTMLTxtRange; dispid 3005;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  HTMLInputTextElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F2A7-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLInputTextElementEvents = dispinterface
    ['{3050F2A7-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
    function  onchange: WordBool; dispid 1001;
    procedure onselect; dispid 1006;
  end;

// *********************************************************************//
// Interface: IHTMLInputTextElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2A6-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputTextElement = interface(IDispatch)
    ['{3050F2A6-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_type_: WideString; safecall;
    procedure Set_value(const p: WideString); safecall;
    function  Get_value: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_status(p: OleVariant); safecall;
    function  Get_status: OleVariant; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    procedure Set_defaultValue(const p: WideString); safecall;
    function  Get_defaultValue: WideString; safecall;
    procedure Set_size(p: Integer); safecall;
    function  Get_size: Integer; safecall;
    procedure Set_maxLength(p: Integer); safecall;
    function  Get_maxLength: Integer; safecall;
    procedure select; safecall;
    procedure Set_onchange(p: OleVariant); safecall;
    function  Get_onchange: OleVariant; safecall;
    procedure Set_onselect(p: OleVariant); safecall;
    function  Get_onselect: OleVariant; safecall;
    procedure Set_readOnly(p: WordBool); safecall;
    function  Get_readOnly: WordBool; safecall;
    function  createTextRange: IHTMLTxtRange; safecall;
    property type_: WideString read Get_type_;
    property value: WideString read Get_value write Set_value;
    property name: WideString read Get_name write Set_name;
    property status: OleVariant read Get_status write Set_status;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property form: IHTMLFormElement read Get_form;
    property defaultValue: WideString read Get_defaultValue write Set_defaultValue;
    property size: Integer read Get_size write Set_size;
    property maxLength: Integer read Get_maxLength write Set_maxLength;
    property onchange: OleVariant read Get_onchange write Set_onchange;
    property onselect: OleVariant read Get_onselect write Set_onselect;
    property readOnly: WordBool read Get_readOnly write Set_readOnly;
  end;

// *********************************************************************//
// DispIntf:  IHTMLInputTextElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2A6-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputTextElementDisp = dispinterface
    ['{3050F2A6-98B5-11CF-BB82-00AA00BDCE0B}']
    property type_: WideString readonly dispid 2000;
    property value: WideString dispid -2147413011;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    property defaultValue: WideString dispid -2147413029;
    property size: Integer dispid 4001;
    property maxLength: Integer dispid 4002;
    procedure select; dispid 3003;
    property onchange: OleVariant dispid -2147412082;
    property onselect: OleVariant dispid -2147412102;
    property readOnly: WordBool dispid 3001;
    function  createTextRange: IHTMLTxtRange; dispid 3005;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLTextAreaElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F521-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLTextAreaElement = dispinterface
    ['{3050F521-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property type_: WideString readonly dispid 2000;
    property value: WideString dispid -2147413011;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    property defaultValue: WideString dispid -2147413029;
    procedure select; dispid 3003;
    property onchange: OleVariant dispid -2147412082;
    property onselect: OleVariant dispid -2147412102;
    property readOnly: WordBool dispid 3001;
    property rows: Integer dispid 5001;
    property cols: Integer dispid 5002;
    property wrap: WideString dispid 5003;
    function  createTextRange: IHTMLTxtRange; dispid 3005;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// Interface: IHTMLTextAreaElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2AA-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTextAreaElement = interface(IDispatch)
    ['{3050F2AA-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_type_: WideString; safecall;
    procedure Set_value(const p: WideString); safecall;
    function  Get_value: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_status(p: OleVariant); safecall;
    function  Get_status: OleVariant; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    procedure Set_defaultValue(const p: WideString); safecall;
    function  Get_defaultValue: WideString; safecall;
    procedure select; safecall;
    procedure Set_onchange(p: OleVariant); safecall;
    function  Get_onchange: OleVariant; safecall;
    procedure Set_onselect(p: OleVariant); safecall;
    function  Get_onselect: OleVariant; safecall;
    procedure Set_readOnly(p: WordBool); safecall;
    function  Get_readOnly: WordBool; safecall;
    procedure Set_rows(p: Integer); safecall;
    function  Get_rows: Integer; safecall;
    procedure Set_cols(p: Integer); safecall;
    function  Get_cols: Integer; safecall;
    procedure Set_wrap(const p: WideString); safecall;
    function  Get_wrap: WideString; safecall;
    function  createTextRange: IHTMLTxtRange; safecall;
    property type_: WideString read Get_type_;
    property value: WideString read Get_value write Set_value;
    property name: WideString read Get_name write Set_name;
    property status: OleVariant read Get_status write Set_status;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property form: IHTMLFormElement read Get_form;
    property defaultValue: WideString read Get_defaultValue write Set_defaultValue;
    property onchange: OleVariant read Get_onchange write Set_onchange;
    property onselect: OleVariant read Get_onselect write Set_onselect;
    property readOnly: WordBool read Get_readOnly write Set_readOnly;
    property rows: Integer read Get_rows write Set_rows;
    property cols: Integer read Get_cols write Set_cols;
    property wrap: WideString read Get_wrap write Set_wrap;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTextAreaElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2AA-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTextAreaElementDisp = dispinterface
    ['{3050F2AA-98B5-11CF-BB82-00AA00BDCE0B}']
    property type_: WideString readonly dispid 2000;
    property value: WideString dispid -2147413011;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    property defaultValue: WideString dispid -2147413029;
    procedure select; dispid 3003;
    property onchange: OleVariant dispid -2147412082;
    property onselect: OleVariant dispid -2147412102;
    property readOnly: WordBool dispid 3001;
    property rows: Integer dispid 5001;
    property cols: Integer dispid 5002;
    property wrap: WideString dispid 5003;
    function  createTextRange: IHTMLTxtRange; dispid 3005;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLInputButtonElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F51E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLInputButtonElement = dispinterface
    ['{3050F51E-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property type_: WideString readonly dispid 2000;
    property value: WideString dispid -2147413011;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    function  createTextRange: IHTMLTxtRange; dispid 2004;
  end;

// *********************************************************************//
// DispIntf:  HTMLButtonElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F2B3-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLButtonElementEvents = dispinterface
    ['{3050F2B3-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
  end;

// *********************************************************************//
// Interface: IHTMLInputButtonElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2B2-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputButtonElement = interface(IDispatch)
    ['{3050F2B2-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_type_: WideString; safecall;
    procedure Set_value(const p: WideString); safecall;
    function  Get_value: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_status(p: OleVariant); safecall;
    function  Get_status: OleVariant; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    function  createTextRange: IHTMLTxtRange; safecall;
    property type_: WideString read Get_type_;
    property value: WideString read Get_value write Set_value;
    property name: WideString read Get_name write Set_name;
    property status: OleVariant read Get_status write Set_status;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property form: IHTMLFormElement read Get_form;
  end;

// *********************************************************************//
// DispIntf:  IHTMLInputButtonElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2B2-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputButtonElementDisp = dispinterface
    ['{3050F2B2-98B5-11CF-BB82-00AA00BDCE0B}']
    property type_: WideString readonly dispid 2000;
    property value: WideString dispid -2147413011;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    function  createTextRange: IHTMLTxtRange; dispid 2004;
  end;

// *********************************************************************//
// Interface: IHTMLInputHiddenElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2A4-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputHiddenElement = interface(IDispatch)
    ['{3050F2A4-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_type_: WideString; safecall;
    procedure Set_value(const p: WideString); safecall;
    function  Get_value: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_status(p: OleVariant); safecall;
    function  Get_status: OleVariant; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    function  createTextRange: IHTMLTxtRange; safecall;
    property type_: WideString read Get_type_;
    property value: WideString read Get_value write Set_value;
    property name: WideString read Get_name write Set_name;
    property status: OleVariant read Get_status write Set_status;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property form: IHTMLFormElement read Get_form;
  end;

// *********************************************************************//
// DispIntf:  IHTMLInputHiddenElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2A4-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputHiddenElementDisp = dispinterface
    ['{3050F2A4-98B5-11CF-BB82-00AA00BDCE0B}']
    property type_: WideString readonly dispid 2000;
    property value: WideString dispid -2147413011;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    function  createTextRange: IHTMLTxtRange; dispid 3005;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLButtonElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F51F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLButtonElement = dispinterface
    ['{3050F51F-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property type_: WideString readonly dispid 2000;
    property value: WideString dispid -2147413011;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    function  createTextRange: IHTMLTxtRange; dispid 2004;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// Interface: IHTMLButtonElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2BB-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLButtonElement = interface(IDispatch)
    ['{3050F2BB-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_type_: WideString; safecall;
    procedure Set_value(const p: WideString); safecall;
    function  Get_value: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_status(p: OleVariant); safecall;
    function  Get_status: OleVariant; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    function  createTextRange: IHTMLTxtRange; safecall;
    property type_: WideString read Get_type_;
    property value: WideString read Get_value write Set_value;
    property name: WideString read Get_name write Set_name;
    property status: OleVariant read Get_status write Set_status;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property form: IHTMLFormElement read Get_form;
  end;

// *********************************************************************//
// DispIntf:  IHTMLButtonElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2BB-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLButtonElementDisp = dispinterface
    ['{3050F2BB-98B5-11CF-BB82-00AA00BDCE0B}']
    property type_: WideString readonly dispid 2000;
    property value: WideString dispid -2147413011;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    function  createTextRange: IHTMLTxtRange; dispid 2004;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLInputFileElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F542-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLInputFileElement = dispinterface
    ['{3050F542-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property type_: WideString readonly dispid 2000;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    property size: Integer dispid 4001;
    property maxLength: Integer dispid 4002;
    procedure select; dispid 3003;
    property onchange: OleVariant dispid -2147412082;
    property onselect: OleVariant dispid -2147412102;
    property value: WideString dispid -2147413011;
  end;

// *********************************************************************//
// DispIntf:  HTMLInputFileElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F2AF-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLInputFileElementEvents = dispinterface
    ['{3050F2AF-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
    function  onchange: WordBool; dispid 1001;
    procedure onselect; dispid 1006;
  end;

// *********************************************************************//
// Interface: IHTMLInputFileElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2AD-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputFileElement = interface(IDispatch)
    ['{3050F2AD-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_type_: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_status(p: OleVariant); safecall;
    function  Get_status: OleVariant; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    procedure Set_size(p: Integer); safecall;
    function  Get_size: Integer; safecall;
    procedure Set_maxLength(p: Integer); safecall;
    function  Get_maxLength: Integer; safecall;
    procedure select; safecall;
    procedure Set_onchange(p: OleVariant); safecall;
    function  Get_onchange: OleVariant; safecall;
    procedure Set_onselect(p: OleVariant); safecall;
    function  Get_onselect: OleVariant; safecall;
    procedure Set_value(const p: WideString); safecall;
    function  Get_value: WideString; safecall;
    property type_: WideString read Get_type_;
    property name: WideString read Get_name write Set_name;
    property status: OleVariant read Get_status write Set_status;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property form: IHTMLFormElement read Get_form;
    property size: Integer read Get_size write Set_size;
    property maxLength: Integer read Get_maxLength write Set_maxLength;
    property onchange: OleVariant read Get_onchange write Set_onchange;
    property onselect: OleVariant read Get_onselect write Set_onselect;
    property value: WideString read Get_value write Set_value;
  end;

// *********************************************************************//
// DispIntf:  IHTMLInputFileElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2AD-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLInputFileElementDisp = dispinterface
    ['{3050F2AD-98B5-11CF-BB82-00AA00BDCE0B}']
    property type_: WideString readonly dispid 2000;
    property name: WideString dispid -2147418112;
    property status: OleVariant dispid 2001;
    property disabled: WordBool dispid -2147418036;
    property form: IHTMLFormElement readonly dispid -2147416108;
    property size: Integer dispid 4001;
    property maxLength: Integer dispid 4002;
    procedure select; dispid 3003;
    property onchange: OleVariant dispid -2147412082;
    property onselect: OleVariant dispid -2147412102;
    property value: WideString dispid -2147413011;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLMarqueeElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F527-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLMarqueeElement = dispinterface
    ['{3050F527-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property bgColor: OleVariant dispid -501;
    property scrollDelay: Integer dispid 6000;
    property direction: WideString dispid 6001;
    property behavior: WideString dispid 6002;
    property scrollAmount: Integer dispid 6003;
    property loop: Integer dispid 6004;
    property vspace: Integer dispid 6005;
    property hspace: Integer dispid 6006;
    property onfinish: OleVariant dispid -2147412086;
    property onstart: OleVariant dispid -2147412085;
    property onbounce: OleVariant dispid -2147412092;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property trueSpeed: WordBool dispid 6007;
    procedure start; dispid 6010;
    procedure Stop; dispid 6011;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  HTMLMarqueeElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F2B8-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLMarqueeElementEvents = dispinterface
    ['{3050F2B8-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
    procedure onchange; dispid 1001;
    procedure onscroll; dispid 1014;
    procedure onselect; dispid 1006;
    procedure onbounce; dispid 1009;
    procedure onfinish; dispid 1010;
    procedure onstart; dispid 1011;
  end;

// *********************************************************************//
// Interface: IHTMLMarqueeElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2B5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLMarqueeElement = interface(IDispatch)
    ['{3050F2B5-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_bgColor(p: OleVariant); safecall;
    function  Get_bgColor: OleVariant; safecall;
    procedure Set_scrollDelay(p: Integer); safecall;
    function  Get_scrollDelay: Integer; safecall;
    procedure Set_direction(const p: WideString); safecall;
    function  Get_direction: WideString; safecall;
    procedure Set_behavior(const p: WideString); safecall;
    function  Get_behavior: WideString; safecall;
    procedure Set_scrollAmount(p: Integer); safecall;
    function  Get_scrollAmount: Integer; safecall;
    procedure Set_loop(p: Integer); safecall;
    function  Get_loop: Integer; safecall;
    procedure Set_vspace(p: Integer); safecall;
    function  Get_vspace: Integer; safecall;
    procedure Set_hspace(p: Integer); safecall;
    function  Get_hspace: Integer; safecall;
    procedure Set_onfinish(p: OleVariant); safecall;
    function  Get_onfinish: OleVariant; safecall;
    procedure Set_onstart(p: OleVariant); safecall;
    function  Get_onstart: OleVariant; safecall;
    procedure Set_onbounce(p: OleVariant); safecall;
    function  Get_onbounce: OleVariant; safecall;
    procedure Set_width(p: OleVariant); safecall;
    function  Get_width: OleVariant; safecall;
    procedure Set_height(p: OleVariant); safecall;
    function  Get_height: OleVariant; safecall;
    procedure Set_trueSpeed(p: WordBool); safecall;
    function  Get_trueSpeed: WordBool; safecall;
    procedure start; safecall;
    procedure Stop; safecall;
    property bgColor: OleVariant read Get_bgColor write Set_bgColor;
    property scrollDelay: Integer read Get_scrollDelay write Set_scrollDelay;
    property direction: WideString read Get_direction write Set_direction;
    property behavior: WideString read Get_behavior write Set_behavior;
    property scrollAmount: Integer read Get_scrollAmount write Set_scrollAmount;
    property loop: Integer read Get_loop write Set_loop;
    property vspace: Integer read Get_vspace write Set_vspace;
    property hspace: Integer read Get_hspace write Set_hspace;
    property onfinish: OleVariant read Get_onfinish write Set_onfinish;
    property onstart: OleVariant read Get_onstart write Set_onstart;
    property onbounce: OleVariant read Get_onbounce write Set_onbounce;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
    property trueSpeed: WordBool read Get_trueSpeed write Set_trueSpeed;
  end;

// *********************************************************************//
// DispIntf:  IHTMLMarqueeElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2B5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLMarqueeElementDisp = dispinterface
    ['{3050F2B5-98B5-11CF-BB82-00AA00BDCE0B}']
    property bgColor: OleVariant dispid -501;
    property scrollDelay: Integer dispid 6000;
    property direction: WideString dispid 6001;
    property behavior: WideString dispid 6002;
    property scrollAmount: Integer dispid 6003;
    property loop: Integer dispid 6004;
    property vspace: Integer dispid 6005;
    property hspace: Integer dispid 6006;
    property onfinish: OleVariant dispid -2147412086;
    property onstart: OleVariant dispid -2147412085;
    property onbounce: OleVariant dispid -2147412092;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property trueSpeed: WordBool dispid 6007;
    procedure start; dispid 6010;
    procedure Stop; dispid 6011;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLOptionButtonElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F509-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLOptionButtonElement = dispinterface
    ['{3050F509-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property value: WideString dispid -2147413011;
    property type_: WideString readonly dispid 1000;
    property name: WideString dispid -2147418112;
    property checked: WordBool dispid 1001;
    property defaultChecked: WordBool dispid 1002;
    property onchange: OleVariant dispid -2147412082;
    property disabled: WordBool dispid -2147418036;
    property status: WordBool dispid 1003;
    property indeterminate: WordBool dispid 1004;
    property form: IHTMLFormElement readonly dispid -2147416108;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  HTMLOptionButtonElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F2BD-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLOptionButtonElementEvents = dispinterface
    ['{3050F2BD-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
    function  onchange: WordBool; dispid 1001;
  end;

// *********************************************************************//
// Interface: IHTMLOptionButtonElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2BC-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOptionButtonElement = interface(IDispatch)
    ['{3050F2BC-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_value(const p: WideString); safecall;
    function  Get_value: WideString; safecall;
    function  Get_type_: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_checked(p: WordBool); safecall;
    function  Get_checked: WordBool; safecall;
    procedure Set_defaultChecked(p: WordBool); safecall;
    function  Get_defaultChecked: WordBool; safecall;
    procedure Set_onchange(p: OleVariant); safecall;
    function  Get_onchange: OleVariant; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    procedure Set_status(p: WordBool); safecall;
    function  Get_status: WordBool; safecall;
    procedure Set_indeterminate(p: WordBool); safecall;
    function  Get_indeterminate: WordBool; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    property value: WideString read Get_value write Set_value;
    property type_: WideString read Get_type_;
    property name: WideString read Get_name write Set_name;
    property checked: WordBool read Get_checked write Set_checked;
    property defaultChecked: WordBool read Get_defaultChecked write Set_defaultChecked;
    property onchange: OleVariant read Get_onchange write Set_onchange;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property status: WordBool read Get_status write Set_status;
    property indeterminate: WordBool read Get_indeterminate write Set_indeterminate;
    property form: IHTMLFormElement read Get_form;
  end;

// *********************************************************************//
// DispIntf:  IHTMLOptionButtonElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2BC-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLOptionButtonElementDisp = dispinterface
    ['{3050F2BC-98B5-11CF-BB82-00AA00BDCE0B}']
    property value: WideString dispid -2147413011;
    property type_: WideString readonly dispid 1000;
    property name: WideString dispid -2147418112;
    property checked: WordBool dispid 1001;
    property defaultChecked: WordBool dispid 1002;
    property onchange: OleVariant dispid -2147412082;
    property disabled: WordBool dispid -2147418036;
    property status: WordBool dispid 1003;
    property indeterminate: WordBool dispid 1004;
    property form: IHTMLFormElement readonly dispid -2147416108;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLTitleElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F516-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLTitleElement = dispinterface
    ['{3050F516-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property text: WideString dispid -2147413011;
  end;

// *********************************************************************//
// Interface: IHTMLTitleElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F322-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTitleElement = interface(IDispatch)
    ['{3050F322-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_text(const p: WideString); safecall;
    function  Get_text: WideString; safecall;
    property text: WideString read Get_text write Set_text;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTitleElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F322-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTitleElementDisp = dispinterface
    ['{3050F322-98B5-11CF-BB82-00AA00BDCE0B}']
    property text: WideString dispid -2147413011;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLMetaElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F517-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLMetaElement = dispinterface
    ['{3050F517-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property httpEquiv: WideString dispid 1001;
    property content: WideString dispid 1002;
    property name: WideString dispid -2147418112;
    property URL: WideString dispid 1003;
    property charset: WideString dispid 1013;
  end;

// *********************************************************************//
// Interface: IHTMLMetaElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F203-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLMetaElement = interface(IDispatch)
    ['{3050F203-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_httpEquiv(const p: WideString); safecall;
    function  Get_httpEquiv: WideString; safecall;
    procedure Set_content(const p: WideString); safecall;
    function  Get_content: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_URL(const p: WideString); safecall;
    function  Get_URL: WideString; safecall;
    procedure Set_charset(const p: WideString); safecall;
    function  Get_charset: WideString; safecall;
    property httpEquiv: WideString read Get_httpEquiv write Set_httpEquiv;
    property content: WideString read Get_content write Set_content;
    property name: WideString read Get_name write Set_name;
    property URL: WideString read Get_URL write Set_URL;
    property charset: WideString read Get_charset write Set_charset;
  end;

// *********************************************************************//
// DispIntf:  IHTMLMetaElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F203-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLMetaElementDisp = dispinterface
    ['{3050F203-98B5-11CF-BB82-00AA00BDCE0B}']
    property httpEquiv: WideString dispid 1001;
    property content: WideString dispid 1002;
    property name: WideString dispid -2147418112;
    property URL: WideString dispid 1003;
    property charset: WideString dispid 1013;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLBaseElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F518-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLBaseElement = dispinterface
    ['{3050F518-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property href: WideString dispid 1003;
    property target: WideString dispid 1004;
  end;

// *********************************************************************//
// Interface: IHTMLBaseElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F204-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBaseElement = interface(IDispatch)
    ['{3050F204-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_href(const p: WideString); safecall;
    function  Get_href: WideString; safecall;
    procedure Set_target(const p: WideString); safecall;
    function  Get_target: WideString; safecall;
    property href: WideString read Get_href write Set_href;
    property target: WideString read Get_target write Set_target;
  end;

// *********************************************************************//
// DispIntf:  IHTMLBaseElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F204-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBaseElementDisp = dispinterface
    ['{3050F204-98B5-11CF-BB82-00AA00BDCE0B}']
    property href: WideString dispid 1003;
    property target: WideString dispid 1004;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLIsIndexElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F519-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLIsIndexElement = dispinterface
    ['{3050F519-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property prompt: WideString dispid 1010;
    property action: WideString dispid 1011;
  end;

// *********************************************************************//
// Interface: IHTMLIsIndexElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F206-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLIsIndexElement = interface(IDispatch)
    ['{3050F206-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_prompt(const p: WideString); safecall;
    function  Get_prompt: WideString; safecall;
    procedure Set_action(const p: WideString); safecall;
    function  Get_action: WideString; safecall;
    property prompt: WideString read Get_prompt write Set_prompt;
    property action: WideString read Get_action write Set_action;
  end;

// *********************************************************************//
// DispIntf:  IHTMLIsIndexElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F206-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLIsIndexElementDisp = dispinterface
    ['{3050F206-98B5-11CF-BB82-00AA00BDCE0B}']
    property prompt: WideString dispid 1010;
    property action: WideString dispid 1011;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLNextIdElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F51A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLNextIdElement = dispinterface
    ['{3050F51A-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property n: WideString dispid 1012;
  end;

// *********************************************************************//
// Interface: IHTMLNextIdElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F207-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLNextIdElement = interface(IDispatch)
    ['{3050F207-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_n(const p: WideString); safecall;
    function  Get_n: WideString; safecall;
    property n: WideString read Get_n write Set_n;
  end;

// *********************************************************************//
// DispIntf:  IHTMLNextIdElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F207-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLNextIdElementDisp = dispinterface
    ['{3050F207-98B5-11CF-BB82-00AA00BDCE0B}']
    property n: WideString dispid 1012;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLBaseFontElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F504-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLBaseFontElement = dispinterface
    ['{3050F504-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property color: OleVariant dispid -2147413110;
    property face: WideString dispid -2147413094;
    property size: Integer dispid -2147413086;
  end;

// *********************************************************************//
// Interface: IHTMLBaseFontElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F202-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBaseFontElement = interface(IDispatch)
    ['{3050F202-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_color(p: OleVariant); safecall;
    function  Get_color: OleVariant; safecall;
    procedure Set_face(const p: WideString); safecall;
    function  Get_face: WideString; safecall;
    procedure Set_size(p: Integer); safecall;
    function  Get_size: Integer; safecall;
    property color: OleVariant read Get_color write Set_color;
    property face: WideString read Get_face write Set_face;
    property size: Integer read Get_size write Set_size;
  end;

// *********************************************************************//
// DispIntf:  IHTMLBaseFontElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F202-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBaseFontElementDisp = dispinterface
    ['{3050F202-98B5-11CF-BB82-00AA00BDCE0B}']
    property color: OleVariant dispid -2147413110;
    property face: WideString dispid -2147413094;
    property size: Integer dispid -2147413086;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLUnknownElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F539-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLUnknownElement = dispinterface
    ['{3050F539-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
  end;

// *********************************************************************//
// Interface: IHTMLUnknownElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F209-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLUnknownElement = interface(IDispatch)
    ['{3050F209-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  IHTMLUnknownElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F209-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLUnknownElementDisp = dispinterface
    ['{3050F209-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  HTMLWindowEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {96A0A4E0-D062-11CF-94B6-00AA0060275C}
// *********************************************************************//
  HTMLWindowEvents = dispinterface
    ['{96A0A4E0-D062-11CF-94B6-00AA0060275C}']
    procedure onload; dispid 1003;
    procedure onunload; dispid 1008;
    function  onhelp: WordBool; dispid -2147418102;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onerror; dispid 1002;
    procedure onresize; dispid 1016;
    procedure onscroll; dispid 1014;
    procedure onbeforeunload; dispid 1017;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLEmbedElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F52E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLEmbedElement = dispinterface
    ['{3050F52E-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property hidden: WideString dispid -2147413031;
    property palette: WideString readonly dispid -2147415108;
    property pluginspage: WideString readonly dispid -2147415107;
    property src: WideString dispid -2147415106;
    property units: WideString dispid -2147415104;
    property name: WideString dispid -2147418112;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
  end;

// *********************************************************************//
// DispIntf:  HTMLControlElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {9A4BBF53-4E46-101B-8BBD-00AA003E3B29}
// *********************************************************************//
  HTMLControlElementEvents = dispinterface
    ['{9A4BBF53-4E46-101B-8BBD-00AA003E3B29}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
    procedure onresize; dispid 1016;
  end;

// *********************************************************************//
// Interface: IHTMLEmbedElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F25F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLEmbedElement = interface(IDispatch)
    ['{3050F25F-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_hidden(const p: WideString); safecall;
    function  Get_hidden: WideString; safecall;
    function  Get_palette: WideString; safecall;
    function  Get_pluginspage: WideString; safecall;
    procedure Set_src(const p: WideString); safecall;
    function  Get_src: WideString; safecall;
    procedure Set_units(const p: WideString); safecall;
    function  Get_units: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_width(p: OleVariant); safecall;
    function  Get_width: OleVariant; safecall;
    procedure Set_height(p: OleVariant); safecall;
    function  Get_height: OleVariant; safecall;
    property hidden: WideString read Get_hidden write Set_hidden;
    property palette: WideString read Get_palette;
    property pluginspage: WideString read Get_pluginspage;
    property src: WideString read Get_src write Set_src;
    property units: WideString read Get_units write Set_units;
    property name: WideString read Get_name write Set_name;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
  end;

// *********************************************************************//
// DispIntf:  IHTMLEmbedElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F25F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLEmbedElementDisp = dispinterface
    ['{3050F25F-98B5-11CF-BB82-00AA00BDCE0B}']
    property hidden: WideString dispid -2147413031;
    property palette: WideString readonly dispid -2147415108;
    property pluginspage: WideString readonly dispid -2147415107;
    property src: WideString dispid -2147415106;
    property units: WideString dispid -2147415104;
    property name: WideString dispid -2147418112;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLMapElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F526-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLMapElement = dispinterface
    ['{3050F526-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property areas: IHTMLAreasCollection readonly dispid 1002;
    property name: WideString dispid -2147418112;
  end;

// *********************************************************************//
// DispIntf:  HTMLMapEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F3BA-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLMapEvents = dispinterface
    ['{3050F3BA-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
  end;

// *********************************************************************//
// Interface: IHTMLAreasCollection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F383-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLAreasCollection = interface(IDispatch)
    ['{3050F383-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_length(p: Integer); safecall;
    function  Get_length: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  item(name: OleVariant; index: OleVariant): IDispatch; safecall;
    function  tags(tagName: OleVariant): IDispatch; safecall;
    procedure add(const element: IHTMLElement; before: OleVariant); safecall;
    procedure Remove(index: Integer); safecall;
    property length: Integer read Get_length write Set_length;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  IHTMLAreasCollectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F383-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLAreasCollectionDisp = dispinterface
    ['{3050F383-98B5-11CF-BB82-00AA00BDCE0B}']
    property length: Integer dispid 1500;
    property _NewEnum: IUnknown readonly dispid -4;
    function  item(name: OleVariant; index: OleVariant): IDispatch; dispid 0;
    function  tags(tagName: OleVariant): IDispatch; dispid 1502;
    procedure add(const element: IHTMLElement; before: OleVariant); dispid 1503;
    procedure Remove(index: Integer); dispid 1504;
  end;

// *********************************************************************//
// Interface: IHTMLMapElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F266-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLMapElement = interface(IDispatch)
    ['{3050F266-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_areas: IHTMLAreasCollection; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    property areas: IHTMLAreasCollection read Get_areas;
    property name: WideString read Get_name write Set_name;
  end;

// *********************************************************************//
// DispIntf:  IHTMLMapElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F266-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLMapElementDisp = dispinterface
    ['{3050F266-98B5-11CF-BB82-00AA00BDCE0B}']
    property areas: IHTMLAreasCollection readonly dispid 1002;
    property name: WideString dispid -2147418112;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLAreaElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F503-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLAreaElement = dispinterface
    ['{3050F503-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property shape: WideString dispid 1001;
    property coords: WideString dispid 1002;
    property href: WideString dispid 0;
    property target: WideString dispid 1004;
    property alt: WideString dispid 1005;
    property noHref: WordBool dispid 1006;
    property host: WideString dispid 1007;
    property hostname: WideString dispid 1008;
    property pathname: WideString dispid 1009;
    property port: WideString dispid 1010;
    property protocol: WideString dispid 1011;
    property search: WideString dispid 1012;
    property hash: WideString dispid 1013;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid 1014;
    procedure blur; dispid 1015;
  end;

// *********************************************************************//
// DispIntf:  HTMLAreaEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F366-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLAreaEvents = dispinterface
    ['{3050F366-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onfocus; dispid -2147418111;
    procedure onblur; dispid -2147418112;
  end;

// *********************************************************************//
// Interface: IHTMLAreaElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F265-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLAreaElement = interface(IDispatch)
    ['{3050F265-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_shape(const p: WideString); safecall;
    function  Get_shape: WideString; safecall;
    procedure Set_coords(const p: WideString); safecall;
    function  Get_coords: WideString; safecall;
    procedure Set_href(const p: WideString); safecall;
    function  Get_href: WideString; safecall;
    procedure Set_target(const p: WideString); safecall;
    function  Get_target: WideString; safecall;
    procedure Set_alt(const p: WideString); safecall;
    function  Get_alt: WideString; safecall;
    procedure Set_noHref(p: WordBool); safecall;
    function  Get_noHref: WordBool; safecall;
    procedure Set_host(const p: WideString); safecall;
    function  Get_host: WideString; safecall;
    procedure Set_hostname(const p: WideString); safecall;
    function  Get_hostname: WideString; safecall;
    procedure Set_pathname(const p: WideString); safecall;
    function  Get_pathname: WideString; safecall;
    procedure Set_port(const p: WideString); safecall;
    function  Get_port: WideString; safecall;
    procedure Set_protocol(const p: WideString); safecall;
    function  Get_protocol: WideString; safecall;
    procedure Set_search(const p: WideString); safecall;
    function  Get_search: WideString; safecall;
    procedure Set_hash(const p: WideString); safecall;
    function  Get_hash: WideString; safecall;
    procedure Set_onblur(p: OleVariant); safecall;
    function  Get_onblur: OleVariant; safecall;
    procedure Set_onfocus(p: OleVariant); safecall;
    function  Get_onfocus: OleVariant; safecall;
    procedure Set_tabIndex(p: Smallint); safecall;
    function  Get_tabIndex: Smallint; safecall;
    procedure focus; safecall;
    procedure blur; safecall;
    property shape: WideString read Get_shape write Set_shape;
    property coords: WideString read Get_coords write Set_coords;
    property href: WideString read Get_href write Set_href;
    property target: WideString read Get_target write Set_target;
    property alt: WideString read Get_alt write Set_alt;
    property noHref: WordBool read Get_noHref write Set_noHref;
    property host: WideString read Get_host write Set_host;
    property hostname: WideString read Get_hostname write Set_hostname;
    property pathname: WideString read Get_pathname write Set_pathname;
    property port: WideString read Get_port write Set_port;
    property protocol: WideString read Get_protocol write Set_protocol;
    property search: WideString read Get_search write Set_search;
    property hash: WideString read Get_hash write Set_hash;
    property onblur: OleVariant read Get_onblur write Set_onblur;
    property onfocus: OleVariant read Get_onfocus write Set_onfocus;
    property tabIndex: Smallint read Get_tabIndex write Set_tabIndex;
  end;

// *********************************************************************//
// DispIntf:  IHTMLAreaElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F265-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLAreaElementDisp = dispinterface
    ['{3050F265-98B5-11CF-BB82-00AA00BDCE0B}']
    property shape: WideString dispid 1001;
    property coords: WideString dispid 1002;
    property href: WideString dispid 0;
    property target: WideString dispid 1004;
    property alt: WideString dispid 1005;
    property noHref: WordBool dispid 1006;
    property host: WideString dispid 1007;
    property hostname: WideString dispid 1008;
    property pathname: WideString dispid 1009;
    property port: WideString dispid 1010;
    property protocol: WideString dispid 1011;
    property search: WideString dispid 1012;
    property hash: WideString dispid 1013;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid 1014;
    procedure blur; dispid 1015;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLTableCaption
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F508-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLTableCaption = dispinterface
    ['{3050F508-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
  end;

// *********************************************************************//
// Interface: IHTMLTableCaption
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2EB-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableCaption = interface(IDispatch)
    ['{3050F2EB-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_vAlign(const p: WideString); safecall;
    function  Get_vAlign: WideString; safecall;
    property align: WideString read Get_align write Set_align;
    property vAlign: WideString read Get_vAlign write Set_vAlign;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTableCaptionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F2EB-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableCaptionDisp = dispinterface
    ['{3050F2EB-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLCommentElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F50A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLCommentElement = dispinterface
    ['{3050F50A-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property text: WideString dispid 1001;
    property atomic: Integer dispid 1002;
  end;

// *********************************************************************//
// Interface: IHTMLCommentElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F20C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLCommentElement = interface(IDispatch)
    ['{3050F20C-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_text(const p: WideString); safecall;
    function  Get_text: WideString; safecall;
    procedure Set_atomic(p: Integer); safecall;
    function  Get_atomic: Integer; safecall;
    property text: WideString read Get_text write Set_text;
    property atomic: Integer read Get_atomic write Set_atomic;
  end;

// *********************************************************************//
// DispIntf:  IHTMLCommentElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F20C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLCommentElementDisp = dispinterface
    ['{3050F20C-98B5-11CF-BB82-00AA00BDCE0B}']
    property text: WideString dispid 1001;
    property atomic: Integer dispid 1002;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLPhraseElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F52D-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLPhraseElement = dispinterface
    ['{3050F52D-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
  end;

// *********************************************************************//
// Interface: IHTMLPhraseElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F20A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLPhraseElement = interface(IDispatch)
    ['{3050F20A-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  IHTMLPhraseElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F20A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLPhraseElementDisp = dispinterface
    ['{3050F20A-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLSpanElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F548-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLSpanElement = dispinterface
    ['{3050F548-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// Interface: IHTMLSpanElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3F3-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLSpanElement = interface(IDispatch)
    ['{3050F3F3-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  IHTMLSpanElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3F3-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLSpanElementDisp = dispinterface
    ['{3050F3F3-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLTable
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F532-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLTable = dispinterface
    ['{3050F532-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property cols: Integer dispid 1001;
    property border: OleVariant dispid 1002;
    property frame: WideString dispid 1004;
    property rules: WideString dispid 1003;
    property cellSpacing: OleVariant dispid 1005;
    property cellPadding: OleVariant dispid 1006;
    property background: WideString dispid -2147413111;
    property bgColor: OleVariant dispid -501;
    property borderColor: OleVariant dispid -2147413084;
    property borderColorLight: OleVariant dispid -2147413083;
    property borderColorDark: OleVariant dispid -2147413082;
    property align: WideString dispid -2147418039;
    procedure Refresh; dispid 1015;
    property rows: IHTMLElementCollection readonly dispid 1016;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property dataPageSize: Integer dispid 1017;
    procedure nextPage; dispid 1018;
    procedure previousPage; dispid 1019;
    property tHead: IHTMLTableSection readonly dispid 1020;
    property tFoot: IHTMLTableSection readonly dispid 1021;
    property tBodies: IHTMLElementCollection readonly dispid 1024;
    property caption: IHTMLTableCaption readonly dispid 1025;
    function  createTHead: IDispatch; dispid 1026;
    procedure deleteTHead; dispid 1027;
    function  createTFoot: IDispatch; dispid 1028;
    procedure deleteTFoot; dispid 1029;
    function  createCaption: IHTMLTableCaption; dispid 1030;
    procedure deleteCaption; dispid 1031;
    function  insertRow(index: Integer): IDispatch; dispid 1032;
    procedure deleteRow(index: Integer); dispid 1033;
    property ReadyState: WideString readonly dispid 1034;
    property onreadystatechange: OleVariant dispid -2147412087;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  HTMLTableEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F407-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLTableEvents = dispinterface
    ['{3050F407-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onreadystatechange; dispid -609;
  end;

// *********************************************************************//
// Interface: IHTMLTableSection
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F23B-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableSection = interface(IDispatch)
    ['{3050F23B-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_vAlign(const p: WideString); safecall;
    function  Get_vAlign: WideString; safecall;
    procedure Set_bgColor(p: OleVariant); safecall;
    function  Get_bgColor: OleVariant; safecall;
    function  Get_rows: IHTMLElementCollection; safecall;
    function  insertRow(index: Integer): IDispatch; safecall;
    procedure deleteRow(index: Integer); safecall;
    property align: WideString read Get_align write Set_align;
    property vAlign: WideString read Get_vAlign write Set_vAlign;
    property bgColor: OleVariant read Get_bgColor write Set_bgColor;
    property rows: IHTMLElementCollection read Get_rows;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTableSectionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F23B-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableSectionDisp = dispinterface
    ['{3050F23B-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
    property bgColor: OleVariant dispid -501;
    property rows: IHTMLElementCollection readonly dispid 1000;
    function  insertRow(index: Integer): IDispatch; dispid 1001;
    procedure deleteRow(index: Integer); dispid 1002;
  end;

// *********************************************************************//
// Interface: IHTMLTable
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F21E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTable = interface(IDispatch)
    ['{3050F21E-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_cols(p: Integer); safecall;
    function  Get_cols: Integer; safecall;
    procedure Set_border(p: OleVariant); safecall;
    function  Get_border: OleVariant; safecall;
    procedure Set_frame(const p: WideString); safecall;
    function  Get_frame: WideString; safecall;
    procedure Set_rules(const p: WideString); safecall;
    function  Get_rules: WideString; safecall;
    procedure Set_cellSpacing(p: OleVariant); safecall;
    function  Get_cellSpacing: OleVariant; safecall;
    procedure Set_cellPadding(p: OleVariant); safecall;
    function  Get_cellPadding: OleVariant; safecall;
    procedure Set_background(const p: WideString); safecall;
    function  Get_background: WideString; safecall;
    procedure Set_bgColor(p: OleVariant); safecall;
    function  Get_bgColor: OleVariant; safecall;
    procedure Set_borderColor(p: OleVariant); safecall;
    function  Get_borderColor: OleVariant; safecall;
    procedure Set_borderColorLight(p: OleVariant); safecall;
    function  Get_borderColorLight: OleVariant; safecall;
    procedure Set_borderColorDark(p: OleVariant); safecall;
    function  Get_borderColorDark: OleVariant; safecall;
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Refresh; safecall;
    function  Get_rows: IHTMLElementCollection; safecall;
    procedure Set_width(p: OleVariant); safecall;
    function  Get_width: OleVariant; safecall;
    procedure Set_height(p: OleVariant); safecall;
    function  Get_height: OleVariant; safecall;
    procedure Set_dataPageSize(p: Integer); safecall;
    function  Get_dataPageSize: Integer; safecall;
    procedure nextPage; safecall;
    procedure previousPage; safecall;
    function  Get_tHead: IHTMLTableSection; safecall;
    function  Get_tFoot: IHTMLTableSection; safecall;
    function  Get_tBodies: IHTMLElementCollection; safecall;
    function  Get_caption: IHTMLTableCaption; safecall;
    function  createTHead: IDispatch; safecall;
    procedure deleteTHead; safecall;
    function  createTFoot: IDispatch; safecall;
    procedure deleteTFoot; safecall;
    function  createCaption: IHTMLTableCaption; safecall;
    procedure deleteCaption; safecall;
    function  insertRow(index: Integer): IDispatch; safecall;
    procedure deleteRow(index: Integer); safecall;
    function  Get_ReadyState: WideString; safecall;
    procedure Set_onreadystatechange(p: OleVariant); safecall;
    function  Get_onreadystatechange: OleVariant; safecall;
    property cols: Integer read Get_cols write Set_cols;
    property border: OleVariant read Get_border write Set_border;
    property frame: WideString read Get_frame write Set_frame;
    property rules: WideString read Get_rules write Set_rules;
    property cellSpacing: OleVariant read Get_cellSpacing write Set_cellSpacing;
    property cellPadding: OleVariant read Get_cellPadding write Set_cellPadding;
    property background: WideString read Get_background write Set_background;
    property bgColor: OleVariant read Get_bgColor write Set_bgColor;
    property borderColor: OleVariant read Get_borderColor write Set_borderColor;
    property borderColorLight: OleVariant read Get_borderColorLight write Set_borderColorLight;
    property borderColorDark: OleVariant read Get_borderColorDark write Set_borderColorDark;
    property align: WideString read Get_align write Set_align;
    property rows: IHTMLElementCollection read Get_rows;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
    property dataPageSize: Integer read Get_dataPageSize write Set_dataPageSize;
    property tHead: IHTMLTableSection read Get_tHead;
    property tFoot: IHTMLTableSection read Get_tFoot;
    property tBodies: IHTMLElementCollection read Get_tBodies;
    property caption: IHTMLTableCaption read Get_caption;
    property ReadyState: WideString read Get_ReadyState;
    property onreadystatechange: OleVariant read Get_onreadystatechange write Set_onreadystatechange;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTableDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F21E-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableDisp = dispinterface
    ['{3050F21E-98B5-11CF-BB82-00AA00BDCE0B}']
    property cols: Integer dispid 1001;
    property border: OleVariant dispid 1002;
    property frame: WideString dispid 1004;
    property rules: WideString dispid 1003;
    property cellSpacing: OleVariant dispid 1005;
    property cellPadding: OleVariant dispid 1006;
    property background: WideString dispid -2147413111;
    property bgColor: OleVariant dispid -501;
    property borderColor: OleVariant dispid -2147413084;
    property borderColorLight: OleVariant dispid -2147413083;
    property borderColorDark: OleVariant dispid -2147413082;
    property align: WideString dispid -2147418039;
    procedure Refresh; dispid 1015;
    property rows: IHTMLElementCollection readonly dispid 1016;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property dataPageSize: Integer dispid 1017;
    procedure nextPage; dispid 1018;
    procedure previousPage; dispid 1019;
    property tHead: IHTMLTableSection readonly dispid 1020;
    property tFoot: IHTMLTableSection readonly dispid 1021;
    property tBodies: IHTMLElementCollection readonly dispid 1024;
    property caption: IHTMLTableCaption readonly dispid 1025;
    function  createTHead: IDispatch; dispid 1026;
    procedure deleteTHead; dispid 1027;
    function  createTFoot: IDispatch; dispid 1028;
    procedure deleteTFoot; dispid 1029;
    function  createCaption: IHTMLTableCaption; dispid 1030;
    procedure deleteCaption; dispid 1031;
    function  insertRow(index: Integer): IDispatch; dispid 1032;
    procedure deleteRow(index: Integer); dispid 1033;
    property ReadyState: WideString readonly dispid 1034;
    property onreadystatechange: OleVariant dispid -2147412087;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLTableCol
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F533-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLTableCol = dispinterface
    ['{3050F533-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property span: Integer dispid 1001;
    property width: OleVariant dispid -2147418107;
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
  end;

// *********************************************************************//
// Interface: IHTMLTableCol
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F23A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableCol = interface(IDispatch)
    ['{3050F23A-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_span(p: Integer); safecall;
    function  Get_span: Integer; safecall;
    procedure Set_width(p: OleVariant); safecall;
    function  Get_width: OleVariant; safecall;
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_vAlign(const p: WideString); safecall;
    function  Get_vAlign: WideString; safecall;
    property span: Integer read Get_span write Set_span;
    property width: OleVariant read Get_width write Set_width;
    property align: WideString read Get_align write Set_align;
    property vAlign: WideString read Get_vAlign write Set_vAlign;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTableColDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F23A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableColDisp = dispinterface
    ['{3050F23A-98B5-11CF-BB82-00AA00BDCE0B}']
    property span: Integer dispid 1001;
    property width: OleVariant dispid -2147418107;
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLTableSection
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F534-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLTableSection = dispinterface
    ['{3050F534-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
    property bgColor: OleVariant dispid -501;
    property rows: IHTMLElementCollection readonly dispid 1000;
    function  insertRow(index: Integer): IDispatch; dispid 1001;
    procedure deleteRow(index: Integer); dispid 1002;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLTableRow
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F535-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLTableRow = dispinterface
    ['{3050F535-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
    property bgColor: OleVariant dispid -501;
    property borderColor: OleVariant dispid -2147413084;
    property borderColorLight: OleVariant dispid -2147413083;
    property borderColorDark: OleVariant dispid -2147413082;
    property rowIndex: Integer readonly dispid 1000;
    property sectionRowIndex: Integer readonly dispid 1001;
    property cells: IHTMLElementCollection readonly dispid 1002;
    function  insertCell(index: Integer): IDispatch; dispid 1003;
    procedure deleteCell(index: Integer); dispid 1004;
    property clientHeight: Integer readonly dispid 1005;
    property clientWidth: Integer readonly dispid 1006;
    property clientTop: Integer readonly dispid 1007;
    property clientLeft: Integer readonly dispid 1008;
  end;

// *********************************************************************//
// Interface: IHTMLTableRow
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F23C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableRow = interface(IDispatch)
    ['{3050F23C-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_vAlign(const p: WideString); safecall;
    function  Get_vAlign: WideString; safecall;
    procedure Set_bgColor(p: OleVariant); safecall;
    function  Get_bgColor: OleVariant; safecall;
    procedure Set_borderColor(p: OleVariant); safecall;
    function  Get_borderColor: OleVariant; safecall;
    procedure Set_borderColorLight(p: OleVariant); safecall;
    function  Get_borderColorLight: OleVariant; safecall;
    procedure Set_borderColorDark(p: OleVariant); safecall;
    function  Get_borderColorDark: OleVariant; safecall;
    function  Get_rowIndex: Integer; safecall;
    function  Get_sectionRowIndex: Integer; safecall;
    function  Get_cells: IHTMLElementCollection; safecall;
    function  insertCell(index: Integer): IDispatch; safecall;
    procedure deleteCell(index: Integer); safecall;
    property align: WideString read Get_align write Set_align;
    property vAlign: WideString read Get_vAlign write Set_vAlign;
    property bgColor: OleVariant read Get_bgColor write Set_bgColor;
    property borderColor: OleVariant read Get_borderColor write Set_borderColor;
    property borderColorLight: OleVariant read Get_borderColorLight write Set_borderColorLight;
    property borderColorDark: OleVariant read Get_borderColorDark write Set_borderColorDark;
    property rowIndex: Integer read Get_rowIndex;
    property sectionRowIndex: Integer read Get_sectionRowIndex;
    property cells: IHTMLElementCollection read Get_cells;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTableRowDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F23C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableRowDisp = dispinterface
    ['{3050F23C-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
    property bgColor: OleVariant dispid -501;
    property borderColor: OleVariant dispid -2147413084;
    property borderColorLight: OleVariant dispid -2147413083;
    property borderColorDark: OleVariant dispid -2147413082;
    property rowIndex: Integer readonly dispid 1000;
    property sectionRowIndex: Integer readonly dispid 1001;
    property cells: IHTMLElementCollection readonly dispid 1002;
    function  insertCell(index: Integer): IDispatch; dispid 1003;
    procedure deleteCell(index: Integer); dispid 1004;
  end;

// *********************************************************************//
// Interface: IHTMLTableRowMetrics
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F413-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableRowMetrics = interface(IDispatch)
    ['{3050F413-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_clientHeight: Integer; safecall;
    function  Get_clientWidth: Integer; safecall;
    function  Get_clientTop: Integer; safecall;
    function  Get_clientLeft: Integer; safecall;
    property clientHeight: Integer read Get_clientHeight;
    property clientWidth: Integer read Get_clientWidth;
    property clientTop: Integer read Get_clientTop;
    property clientLeft: Integer read Get_clientLeft;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTableRowMetricsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F413-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableRowMetricsDisp = dispinterface
    ['{3050F413-98B5-11CF-BB82-00AA00BDCE0B}']
    property clientHeight: Integer readonly dispid 1005;
    property clientWidth: Integer readonly dispid 1006;
    property clientTop: Integer readonly dispid 1007;
    property clientLeft: Integer readonly dispid 1008;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLTableCell
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F536-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLTableCell = dispinterface
    ['{3050F536-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property rowSpan: Integer dispid 2001;
    property colSpan: Integer dispid 2002;
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
    property bgColor: OleVariant dispid -501;
    property noWrap: WordBool dispid -2147413107;
    property background: WideString dispid -2147413111;
    property borderColor: OleVariant dispid -2147413084;
    property borderColorLight: OleVariant dispid -2147413083;
    property borderColorDark: OleVariant dispid -2147413082;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property cellIndex: Integer readonly dispid 2003;
  end;

// *********************************************************************//
// Interface: IHTMLTableCell
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F23D-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableCell = interface(IDispatch)
    ['{3050F23D-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_rowSpan(p: Integer); safecall;
    function  Get_rowSpan: Integer; safecall;
    procedure Set_colSpan(p: Integer); safecall;
    function  Get_colSpan: Integer; safecall;
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_vAlign(const p: WideString); safecall;
    function  Get_vAlign: WideString; safecall;
    procedure Set_bgColor(p: OleVariant); safecall;
    function  Get_bgColor: OleVariant; safecall;
    procedure Set_noWrap(p: WordBool); safecall;
    function  Get_noWrap: WordBool; safecall;
    procedure Set_background(const p: WideString); safecall;
    function  Get_background: WideString; safecall;
    procedure Set_borderColor(p: OleVariant); safecall;
    function  Get_borderColor: OleVariant; safecall;
    procedure Set_borderColorLight(p: OleVariant); safecall;
    function  Get_borderColorLight: OleVariant; safecall;
    procedure Set_borderColorDark(p: OleVariant); safecall;
    function  Get_borderColorDark: OleVariant; safecall;
    procedure Set_width(p: OleVariant); safecall;
    function  Get_width: OleVariant; safecall;
    procedure Set_height(p: OleVariant); safecall;
    function  Get_height: OleVariant; safecall;
    function  Get_cellIndex: Integer; safecall;
    property rowSpan: Integer read Get_rowSpan write Set_rowSpan;
    property colSpan: Integer read Get_colSpan write Set_colSpan;
    property align: WideString read Get_align write Set_align;
    property vAlign: WideString read Get_vAlign write Set_vAlign;
    property bgColor: OleVariant read Get_bgColor write Set_bgColor;
    property noWrap: WordBool read Get_noWrap write Set_noWrap;
    property background: WideString read Get_background write Set_background;
    property borderColor: OleVariant read Get_borderColor write Set_borderColor;
    property borderColorLight: OleVariant read Get_borderColorLight write Set_borderColorLight;
    property borderColorDark: OleVariant read Get_borderColorDark write Set_borderColorDark;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
    property cellIndex: Integer read Get_cellIndex;
  end;

// *********************************************************************//
// DispIntf:  IHTMLTableCellDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F23D-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLTableCellDisp = dispinterface
    ['{3050F23D-98B5-11CF-BB82-00AA00BDCE0B}']
    property rowSpan: Integer dispid 2001;
    property colSpan: Integer dispid 2002;
    property align: WideString dispid -2147418040;
    property vAlign: WideString dispid -2147413081;
    property bgColor: OleVariant dispid -501;
    property noWrap: WordBool dispid -2147413107;
    property background: WideString dispid -2147413111;
    property borderColor: OleVariant dispid -2147413084;
    property borderColorLight: OleVariant dispid -2147413083;
    property borderColorDark: OleVariant dispid -2147413082;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property cellIndex: Integer readonly dispid 2003;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLScriptElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F530-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLScriptElement = dispinterface
    ['{3050F530-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property src: WideString dispid 1001;
    property htmlFor: WideString dispid 1004;
    property event: WideString dispid 1005;
    property text: WideString dispid 1006;
    property defer: WordBool dispid 1007;
    property ReadyState: WideString readonly dispid 1008;
    property onerror: OleVariant dispid -2147412083;
    property type_: WideString dispid 1009;
  end;

// *********************************************************************//
// DispIntf:  HTMLScriptEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F3E2-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLScriptEvents = dispinterface
    ['{3050F3E2-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onreadystatechange(lReadyState: Integer); dispid -609;
    procedure onerror; dispid 1002;
  end;

// *********************************************************************//
// Interface: IHTMLScriptElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F28B-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLScriptElement = interface(IDispatch)
    ['{3050F28B-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_src(const p: WideString); safecall;
    function  Get_src: WideString; safecall;
    procedure Set_htmlFor(const p: WideString); safecall;
    function  Get_htmlFor: WideString; safecall;
    procedure Set_event(const p: WideString); safecall;
    function  Get_event: WideString; safecall;
    procedure Set_text(const p: WideString); safecall;
    function  Get_text: WideString; safecall;
    procedure Set_defer(p: WordBool); safecall;
    function  Get_defer: WordBool; safecall;
    function  Get_ReadyState: WideString; safecall;
    procedure Set_onerror(p: OleVariant); safecall;
    function  Get_onerror: OleVariant; safecall;
    procedure Set_type_(const p: WideString); safecall;
    function  Get_type_: WideString; safecall;
    property src: WideString read Get_src write Set_src;
    property htmlFor: WideString read Get_htmlFor write Set_htmlFor;
    property event: WideString read Get_event write Set_event;
    property text: WideString read Get_text write Set_text;
    property defer: WordBool read Get_defer write Set_defer;
    property ReadyState: WideString read Get_ReadyState;
    property onerror: OleVariant read Get_onerror write Set_onerror;
    property type_: WideString read Get_type_ write Set_type_;
  end;

// *********************************************************************//
// DispIntf:  IHTMLScriptElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F28B-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLScriptElementDisp = dispinterface
    ['{3050F28B-98B5-11CF-BB82-00AA00BDCE0B}']
    property src: WideString dispid 1001;
    property htmlFor: WideString dispid 1004;
    property event: WideString dispid 1005;
    property text: WideString dispid 1006;
    property defer: WordBool dispid 1007;
    property ReadyState: WideString readonly dispid 1008;
    property onerror: OleVariant dispid -2147412083;
    property type_: WideString dispid 1009;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLNoShowElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F528-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLNoShowElement = dispinterface
    ['{3050F528-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
  end;

// *********************************************************************//
// Interface: IHTMLNoShowElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F38A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLNoShowElement = interface(IDispatch)
    ['{3050F38A-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  IHTMLNoShowElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F38A-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLNoShowElementDisp = dispinterface
    ['{3050F38A-98B5-11CF-BB82-00AA00BDCE0B}']
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLObjectElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F529-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLObjectElement = dispinterface
    ['{3050F529-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property object_: IDispatch readonly dispid -2147415111;
    property classid: WideString readonly dispid -2147415110;
    property data: WideString readonly dispid -2147415109;
    property recordset: IDispatch dispid -2147415107;
    property align: WideString dispid -2147418039;
    property name: WideString dispid -2147418112;
    property codeBase: WideString dispid -2147415106;
    property codeType: WideString dispid -2147415105;
    property code: WideString dispid -2147415104;
    property BaseHref: WideString readonly dispid -2147418110;
    property type_: WideString dispid -2147415103;
    property form: IHTMLFormElement readonly dispid -2147416108;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property ReadyState: Integer readonly dispid -2147415102;
    property onreadystatechange: OleVariant dispid -2147412087;
    property onerror: OleVariant dispid -2147412083;
    property altHtml: WideString dispid -2147415101;
    property vspace: Integer dispid -2147415100;
    property hspace: Integer dispid -2147415099;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// DispIntf:  HTMLObjectElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F3C4-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLObjectElementEvents = dispinterface
    ['{3050F3C4-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onreadystatechange; dispid -2147418094;
    function  onerror: WordBool; dispid -2147418093;
  end;

// *********************************************************************//
// Interface: IHTMLObjectElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F24F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLObjectElement = interface(IDispatch)
    ['{3050F24F-98B5-11CF-BB82-00AA00BDCE0B}']
    function  Get_object_: IDispatch; safecall;
    function  Get_classid: WideString; safecall;
    function  Get_data: WideString; safecall;
    procedure Set_recordset(const p: IDispatch); safecall;
    function  Get_recordset: IDispatch; safecall;
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_codeBase(const p: WideString); safecall;
    function  Get_codeBase: WideString; safecall;
    procedure Set_codeType(const p: WideString); safecall;
    function  Get_codeType: WideString; safecall;
    procedure Set_code(const p: WideString); safecall;
    function  Get_code: WideString; safecall;
    function  Get_BaseHref: WideString; safecall;
    procedure Set_type_(const p: WideString); safecall;
    function  Get_type_: WideString; safecall;
    function  Get_form: IHTMLFormElement; safecall;
    procedure Set_width(p: OleVariant); safecall;
    function  Get_width: OleVariant; safecall;
    procedure Set_height(p: OleVariant); safecall;
    function  Get_height: OleVariant; safecall;
    function  Get_ReadyState: Integer; safecall;
    procedure Set_onreadystatechange(p: OleVariant); safecall;
    function  Get_onreadystatechange: OleVariant; safecall;
    procedure Set_onerror(p: OleVariant); safecall;
    function  Get_onerror: OleVariant; safecall;
    procedure Set_altHtml(const p: WideString); safecall;
    function  Get_altHtml: WideString; safecall;
    procedure Set_vspace(p: Integer); safecall;
    function  Get_vspace: Integer; safecall;
    procedure Set_hspace(p: Integer); safecall;
    function  Get_hspace: Integer; safecall;
    property object_: IDispatch read Get_object_;
    property classid: WideString read Get_classid;
    property data: WideString read Get_data;
    property recordset: IDispatch read Get_recordset write Set_recordset;
    property align: WideString read Get_align write Set_align;
    property name: WideString read Get_name write Set_name;
    property codeBase: WideString read Get_codeBase write Set_codeBase;
    property codeType: WideString read Get_codeType write Set_codeType;
    property code: WideString read Get_code write Set_code;
    property BaseHref: WideString read Get_BaseHref;
    property type_: WideString read Get_type_ write Set_type_;
    property form: IHTMLFormElement read Get_form;
    property width: OleVariant read Get_width write Set_width;
    property height: OleVariant read Get_height write Set_height;
    property ReadyState: Integer read Get_ReadyState;
    property onreadystatechange: OleVariant read Get_onreadystatechange write Set_onreadystatechange;
    property onerror: OleVariant read Get_onerror write Set_onerror;
    property altHtml: WideString read Get_altHtml write Set_altHtml;
    property vspace: Integer read Get_vspace write Set_vspace;
    property hspace: Integer read Get_hspace write Set_hspace;
  end;

// *********************************************************************//
// DispIntf:  IHTMLObjectElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F24F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLObjectElementDisp = dispinterface
    ['{3050F24F-98B5-11CF-BB82-00AA00BDCE0B}']
    property object_: IDispatch readonly dispid -2147415111;
    property classid: WideString readonly dispid -2147415110;
    property data: WideString readonly dispid -2147415109;
    property recordset: IDispatch dispid -2147415107;
    property align: WideString dispid -2147418039;
    property name: WideString dispid -2147418112;
    property codeBase: WideString dispid -2147415106;
    property codeType: WideString dispid -2147415105;
    property code: WideString dispid -2147415104;
    property BaseHref: WideString readonly dispid -2147418110;
    property type_: WideString dispid -2147415103;
    property form: IHTMLFormElement readonly dispid -2147416108;
    property width: OleVariant dispid -2147418107;
    property height: OleVariant dispid -2147418106;
    property ReadyState: Integer readonly dispid -2147415102;
    property onreadystatechange: OleVariant dispid -2147412087;
    property onerror: OleVariant dispid -2147412083;
    property altHtml: WideString dispid -2147415101;
    property vspace: Integer dispid -2147415100;
    property hspace: Integer dispid -2147415099;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLFrameBase
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F541-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLFrameBase = dispinterface
    ['{3050F541-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property src: WideString dispid -2147415112;
    property name: WideString dispid -2147418112;
    property border: OleVariant dispid -2147415110;
    property frameBorder: WideString dispid -2147415109;
    property frameSpacing: OleVariant dispid -2147415108;
    property marginWidth: OleVariant dispid -2147415107;
    property marginHeight: OleVariant dispid -2147415106;
    property noResize: WordBool dispid -2147415105;
    property scrolling: WideString dispid -2147415104;
  end;

// *********************************************************************//
// Interface: IHTMLFrameBase
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F311-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFrameBase = interface(IDispatch)
    ['{3050F311-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_src(const p: WideString); safecall;
    function  Get_src: WideString; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_border(p: OleVariant); safecall;
    function  Get_border: OleVariant; safecall;
    procedure Set_frameBorder(const p: WideString); safecall;
    function  Get_frameBorder: WideString; safecall;
    procedure Set_frameSpacing(p: OleVariant); safecall;
    function  Get_frameSpacing: OleVariant; safecall;
    procedure Set_marginWidth(p: OleVariant); safecall;
    function  Get_marginWidth: OleVariant; safecall;
    procedure Set_marginHeight(p: OleVariant); safecall;
    function  Get_marginHeight: OleVariant; safecall;
    procedure Set_noResize(p: WordBool); safecall;
    function  Get_noResize: WordBool; safecall;
    procedure Set_scrolling(const p: WideString); safecall;
    function  Get_scrolling: WideString; safecall;
    property src: WideString read Get_src write Set_src;
    property name: WideString read Get_name write Set_name;
    property border: OleVariant read Get_border write Set_border;
    property frameBorder: WideString read Get_frameBorder write Set_frameBorder;
    property frameSpacing: OleVariant read Get_frameSpacing write Set_frameSpacing;
    property marginWidth: OleVariant read Get_marginWidth write Set_marginWidth;
    property marginHeight: OleVariant read Get_marginHeight write Set_marginHeight;
    property noResize: WordBool read Get_noResize write Set_noResize;
    property scrolling: WideString read Get_scrolling write Set_scrolling;
  end;

// *********************************************************************//
// DispIntf:  IHTMLFrameBaseDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F311-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFrameBaseDisp = dispinterface
    ['{3050F311-98B5-11CF-BB82-00AA00BDCE0B}']
    property src: WideString dispid -2147415112;
    property name: WideString dispid -2147418112;
    property border: OleVariant dispid -2147415110;
    property frameBorder: WideString dispid -2147415109;
    property frameSpacing: OleVariant dispid -2147415108;
    property marginWidth: OleVariant dispid -2147415107;
    property marginHeight: OleVariant dispid -2147415106;
    property noResize: WordBool dispid -2147415105;
    property scrolling: WideString dispid -2147415104;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLFrameElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F513-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLFrameElement = dispinterface
    ['{3050F513-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property src: WideString dispid -2147415112;
    property name: WideString dispid -2147418112;
    property border: OleVariant dispid -2147415110;
    property frameBorder: WideString dispid -2147415109;
    property frameSpacing: OleVariant dispid -2147415108;
    property marginWidth: OleVariant dispid -2147415107;
    property marginHeight: OleVariant dispid -2147415106;
    property noResize: WordBool dispid -2147415105;
    property scrolling: WideString dispid -2147415104;
    property borderColor: OleVariant dispid -2147414111;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// Interface: IHTMLFrameElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F313-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFrameElement = interface(IDispatch)
    ['{3050F313-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_borderColor(p: OleVariant); safecall;
    function  Get_borderColor: OleVariant; safecall;
    property borderColor: OleVariant read Get_borderColor write Set_borderColor;
  end;

// *********************************************************************//
// DispIntf:  IHTMLFrameElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F313-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFrameElementDisp = dispinterface
    ['{3050F313-98B5-11CF-BB82-00AA00BDCE0B}']
    property borderColor: OleVariant dispid -2147414111;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLIFrameElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F51B-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLIFrameElement = dispinterface
    ['{3050F51B-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property src: WideString dispid -2147415112;
    property name: WideString dispid -2147418112;
    property border: OleVariant dispid -2147415110;
    property frameBorder: WideString dispid -2147415109;
    property frameSpacing: OleVariant dispid -2147415108;
    property marginWidth: OleVariant dispid -2147415107;
    property marginHeight: OleVariant dispid -2147415106;
    property noResize: WordBool dispid -2147415105;
    property scrolling: WideString dispid -2147415104;
    property vspace: Integer dispid -2147414111;
    property hspace: Integer dispid -2147414110;
    property align: WideString dispid -2147418039;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// Interface: IHTMLIFrameElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F315-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLIFrameElement = interface(IDispatch)
    ['{3050F315-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_vspace(p: Integer); safecall;
    function  Get_vspace: Integer; safecall;
    procedure Set_hspace(p: Integer); safecall;
    function  Get_hspace: Integer; safecall;
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    property vspace: Integer read Get_vspace write Set_vspace;
    property hspace: Integer read Get_hspace write Set_hspace;
    property align: WideString read Get_align write Set_align;
  end;

// *********************************************************************//
// DispIntf:  IHTMLIFrameElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F315-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLIFrameElementDisp = dispinterface
    ['{3050F315-98B5-11CF-BB82-00AA00BDCE0B}']
    property vspace: Integer dispid -2147414111;
    property hspace: Integer dispid -2147414110;
    property align: WideString dispid -2147418039;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLDivPosition
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F50F-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLDivPosition = dispinterface
    ['{3050F50F-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property align: WideString dispid -2147418039;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// Interface: IHTMLDivPosition
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F212-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDivPosition = interface(IDispatch)
    ['{3050F212-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    property align: WideString read Get_align write Set_align;
  end;

// *********************************************************************//
// DispIntf:  IHTMLDivPositionDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F212-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDivPositionDisp = dispinterface
    ['{3050F212-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418039;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLFieldSetElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F545-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLFieldSetElement = dispinterface
    ['{3050F545-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property align: WideString dispid -2147418039;
  end;

// *********************************************************************//
// Interface: IHTMLFieldSetElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3E7-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFieldSetElement = interface(IDispatch)
    ['{3050F3E7-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    property align: WideString read Get_align write Set_align;
  end;

// *********************************************************************//
// DispIntf:  IHTMLFieldSetElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3E7-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFieldSetElementDisp = dispinterface
    ['{3050F3E7-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418039;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLLegendElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F546-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLLegendElement = dispinterface
    ['{3050F546-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property align: WideString dispid -2147418039;
  end;

// *********************************************************************//
// Interface: IHTMLLegendElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3EA-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLLegendElement = interface(IDispatch)
    ['{3050F3EA-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    property align: WideString read Get_align write Set_align;
  end;

// *********************************************************************//
// DispIntf:  IHTMLLegendElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3EA-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLLegendElementDisp = dispinterface
    ['{3050F3EA-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418039;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLSpanFlow
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F544-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLSpanFlow = dispinterface
    ['{3050F544-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    function  createControlRange: IDispatch; dispid 1001;
    property scrollHeight: Integer readonly dispid 1002;
    property scrollWidth: Integer readonly dispid 1003;
    property scrollTop: Integer dispid 1004;
    property scrollLeft: Integer dispid 1005;
    property onscroll: OleVariant dispid -2147412081;
    property align: WideString dispid -2147418039;
    property dataFld: WideString dispid -2147417091;
    property dataSrc: WideString dispid -2147417090;
    property dataFormatAs: WideString dispid -2147417089;
  end;

// *********************************************************************//
// Interface: IHTMLSpanFlow
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3E5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLSpanFlow = interface(IDispatch)
    ['{3050F3E5-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_align(const p: WideString); safecall;
    function  Get_align: WideString; safecall;
    property align: WideString read Get_align write Set_align;
  end;

// *********************************************************************//
// DispIntf:  IHTMLSpanFlowDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3E5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLSpanFlowDisp = dispinterface
    ['{3050F3E5-98B5-11CF-BB82-00AA00BDCE0B}']
    property align: WideString dispid -2147418039;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLFrameSetElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F514-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLFrameSetElement = dispinterface
    ['{3050F514-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property tabIndex: Smallint dispid -2147418097;
    procedure focus; dispid -2147416112;
    property accessKey: WideString dispid -2147416107;
    property onblur: OleVariant dispid -2147412097;
    property onfocus: OleVariant dispid -2147412098;
    property onresize: OleVariant dispid -2147412076;
    procedure blur; dispid -2147416110;
    procedure addFilter(const pUnk: IUnknown); dispid -2147416095;
    procedure removeFilter(const pUnk: IUnknown); dispid -2147416094;
    property clientHeight: Integer readonly dispid -2147416093;
    property clientWidth: Integer readonly dispid -2147416092;
    property clientTop: Integer readonly dispid -2147416091;
    property clientLeft: Integer readonly dispid -2147416090;
    property rows: WideString dispid 1000;
    property cols: WideString dispid 1001;
    property border: OleVariant dispid 1002;
    property borderColor: OleVariant dispid 1003;
    property frameBorder: WideString dispid 1004;
    property frameSpacing: OleVariant dispid 1005;
    property name: WideString dispid -2147418112;
    property onload: OleVariant dispid -2147412080;
    property onunload: OleVariant dispid -2147412079;
    property onbeforeunload: OleVariant dispid -2147412073;
  end;

// *********************************************************************//
// Interface: IHTMLFrameSetElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F319-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFrameSetElement = interface(IDispatch)
    ['{3050F319-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_rows(const p: WideString); safecall;
    function  Get_rows: WideString; safecall;
    procedure Set_cols(const p: WideString); safecall;
    function  Get_cols: WideString; safecall;
    procedure Set_border(p: OleVariant); safecall;
    function  Get_border: OleVariant; safecall;
    procedure Set_borderColor(p: OleVariant); safecall;
    function  Get_borderColor: OleVariant; safecall;
    procedure Set_frameBorder(const p: WideString); safecall;
    function  Get_frameBorder: WideString; safecall;
    procedure Set_frameSpacing(p: OleVariant); safecall;
    function  Get_frameSpacing: OleVariant; safecall;
    procedure Set_name(const p: WideString); safecall;
    function  Get_name: WideString; safecall;
    procedure Set_onload(p: OleVariant); safecall;
    function  Get_onload: OleVariant; safecall;
    procedure Set_onunload(p: OleVariant); safecall;
    function  Get_onunload: OleVariant; safecall;
    procedure Set_onbeforeunload(p: OleVariant); safecall;
    function  Get_onbeforeunload: OleVariant; safecall;
    property rows: WideString read Get_rows write Set_rows;
    property cols: WideString read Get_cols write Set_cols;
    property border: OleVariant read Get_border write Set_border;
    property borderColor: OleVariant read Get_borderColor write Set_borderColor;
    property frameBorder: WideString read Get_frameBorder write Set_frameBorder;
    property frameSpacing: OleVariant read Get_frameSpacing write Set_frameSpacing;
    property name: WideString read Get_name write Set_name;
    property onload: OleVariant read Get_onload write Set_onload;
    property onunload: OleVariant read Get_onunload write Set_onunload;
    property onbeforeunload: OleVariant read Get_onbeforeunload write Set_onbeforeunload;
  end;

// *********************************************************************//
// DispIntf:  IHTMLFrameSetElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F319-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLFrameSetElementDisp = dispinterface
    ['{3050F319-98B5-11CF-BB82-00AA00BDCE0B}']
    property rows: WideString dispid 1000;
    property cols: WideString dispid 1001;
    property border: OleVariant dispid 1002;
    property borderColor: OleVariant dispid 1003;
    property frameBorder: WideString dispid 1004;
    property frameSpacing: OleVariant dispid 1005;
    property name: WideString dispid -2147418112;
    property onload: OleVariant dispid -2147412080;
    property onunload: OleVariant dispid -2147412079;
    property onbeforeunload: OleVariant dispid -2147412073;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLBGsound
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F53C-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLBGsound = dispinterface
    ['{3050F53C-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property src: WideString dispid 1001;
    property loop: OleVariant dispid 1002;
    property volume: OleVariant dispid 1003;
    property balance: OleVariant dispid 1004;
  end;

// *********************************************************************//
// Interface: IHTMLBGsound
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F369-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBGsound = interface(IDispatch)
    ['{3050F369-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_src(const p: WideString); safecall;
    function  Get_src: WideString; safecall;
    procedure Set_loop(p: OleVariant); safecall;
    function  Get_loop: OleVariant; safecall;
    procedure Set_volume(p: OleVariant); safecall;
    function  Get_volume: OleVariant; safecall;
    procedure Set_balance(p: OleVariant); safecall;
    function  Get_balance: OleVariant; safecall;
    property src: WideString read Get_src write Set_src;
    property loop: OleVariant read Get_loop write Set_loop;
    property volume: OleVariant read Get_volume write Set_volume;
    property balance: OleVariant read Get_balance write Set_balance;
  end;

// *********************************************************************//
// DispIntf:  IHTMLBGsoundDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F369-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLBGsoundDisp = dispinterface
    ['{3050F369-98B5-11CF-BB82-00AA00BDCE0B}']
    property src: WideString dispid 1001;
    property loop: OleVariant dispid 1002;
    property volume: OleVariant dispid 1003;
    property balance: OleVariant dispid 1004;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLStyleElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F511-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  DispIHTMLStyleElement = dispinterface
    ['{3050F511-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    property type_: WideString dispid 1002;
    property ReadyState: WideString readonly dispid 1003;
    property onreadystatechange: OleVariant dispid -2147412087;
    property onload: OleVariant dispid -2147412080;
    property onerror: OleVariant dispid -2147412083;
    property styleSheet: IHTMLStyleSheet readonly dispid 1004;
    property disabled: WordBool dispid 1005;
    property media: WideString dispid 1006;
  end;

// *********************************************************************//
// DispIntf:  HTMLStyleElementEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {3050F3CB-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  HTMLStyleElementEvents = dispinterface
    ['{3050F3CB-98B5-11CF-BB82-00AA00BDCE0B}']
    function  onhelp: WordBool; dispid -2147418102;
    function  onclick: WordBool; dispid -600;
    function  ondblclick: WordBool; dispid -601;
    function  onkeypress: WordBool; dispid -603;
    procedure onkeydown; dispid -602;
    procedure onkeyup; dispid -604;
    procedure onmouseout; dispid -2147418103;
    procedure onmouseover; dispid -2147418104;
    procedure onmousemove; dispid -606;
    procedure onmousedown; dispid -605;
    procedure onmouseup; dispid -607;
    function  onselectstart: WordBool; dispid -2147418100;
    procedure onfilterchange; dispid -2147418095;
    function  ondragstart: WordBool; dispid -2147418101;
    function  onbeforeupdate: WordBool; dispid -2147418108;
    procedure onafterupdate; dispid -2147418107;
    function  onerrorupdate: WordBool; dispid -2147418099;
    function  onrowexit: WordBool; dispid -2147418106;
    procedure onrowenter; dispid -2147418105;
    procedure ondatasetchanged; dispid -2147418098;
    procedure ondataavailable; dispid -2147418097;
    procedure ondatasetcomplete; dispid -2147418096;
    procedure onreadystatechange; dispid -609;
    procedure onload; dispid 1003;
    procedure onerror; dispid 1002;
  end;

// *********************************************************************//
// Interface: IHTMLStyleElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F375-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleElement = interface(IDispatch)
    ['{3050F375-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_type_(const p: WideString); safecall;
    function  Get_type_: WideString; safecall;
    function  Get_ReadyState: WideString; safecall;
    procedure Set_onreadystatechange(p: OleVariant); safecall;
    function  Get_onreadystatechange: OleVariant; safecall;
    procedure Set_onload(p: OleVariant); safecall;
    function  Get_onload: OleVariant; safecall;
    procedure Set_onerror(p: OleVariant); safecall;
    function  Get_onerror: OleVariant; safecall;
    function  Get_styleSheet: IHTMLStyleSheet; safecall;
    procedure Set_disabled(p: WordBool); safecall;
    function  Get_disabled: WordBool; safecall;
    procedure Set_media(const p: WideString); safecall;
    function  Get_media: WideString; safecall;
    property type_: WideString read Get_type_ write Set_type_;
    property ReadyState: WideString read Get_ReadyState;
    property onreadystatechange: OleVariant read Get_onreadystatechange write Set_onreadystatechange;
    property onload: OleVariant read Get_onload write Set_onload;
    property onerror: OleVariant read Get_onerror write Set_onerror;
    property styleSheet: IHTMLStyleSheet read Get_styleSheet;
    property disabled: WordBool read Get_disabled write Set_disabled;
    property media: WideString read Get_media write Set_media;
  end;

// *********************************************************************//
// DispIntf:  IHTMLStyleElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F375-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleElementDisp = dispinterface
    ['{3050F375-98B5-11CF-BB82-00AA00BDCE0B}']
    property type_: WideString dispid 1002;
    property ReadyState: WideString readonly dispid 1003;
    property onreadystatechange: OleVariant dispid -2147412087;
    property onload: OleVariant dispid -2147412080;
    property onerror: OleVariant dispid -2147412083;
    property styleSheet: IHTMLStyleSheet readonly dispid 1004;
    property disabled: WordBool dispid 1005;
    property media: WideString dispid 1006;
  end;

// *********************************************************************//
// Interface: IHTMLStyleFontFace
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3D5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleFontFace = interface(IDispatch)
    ['{3050F3D5-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_fontsrc(const p: WideString); safecall;
    function  Get_fontsrc: WideString; safecall;
    property fontsrc: WideString read Get_fontsrc write Set_fontsrc;
  end;

// *********************************************************************//
// DispIntf:  IHTMLStyleFontFaceDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F3D5-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLStyleFontFaceDisp = dispinterface
    ['{3050F3D5-98B5-11CF-BB82-00AA00BDCE0B}']
    property fontsrc: WideString dispid -2147413015;
  end;

// *********************************************************************//
// Interface: IHTMLDialog
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F216-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDialog = interface(IDispatch)
    ['{3050F216-98B5-11CF-BB82-00AA00BDCE0B}']
    procedure Set_dialogTop(p: OleVariant); safecall;
    function  Get_dialogTop: OleVariant; safecall;
    procedure Set_dialogLeft(p: OleVariant); safecall;
    function  Get_dialogLeft: OleVariant; safecall;
    procedure Set_dialogWidth(p: OleVariant); safecall;
    function  Get_dialogWidth: OleVariant; safecall;
    procedure Set_dialogHeight(p: OleVariant); safecall;
    function  Get_dialogHeight: OleVariant; safecall;
    function  Get_dialogArguments: OleVariant; safecall;
    function  Get_menuArguments: OleVariant; safecall;
    procedure Set_returnValue(p: OleVariant); safecall;
    function  Get_returnValue: OleVariant; safecall;
    procedure close; safecall;
    function  toString: WideString; safecall;
    property dialogTop: OleVariant read Get_dialogTop write Set_dialogTop;
    property dialogLeft: OleVariant read Get_dialogLeft write Set_dialogLeft;
    property dialogWidth: OleVariant read Get_dialogWidth write Set_dialogWidth;
    property dialogHeight: OleVariant read Get_dialogHeight write Set_dialogHeight;
    property dialogArguments: OleVariant read Get_dialogArguments;
    property menuArguments: OleVariant read Get_menuArguments;
    property returnValue: OleVariant read Get_returnValue write Set_returnValue;
  end;

// *********************************************************************//
// DispIntf:  IHTMLDialogDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3050F216-98B5-11CF-BB82-00AA00BDCE0B}
// *********************************************************************//
  IHTMLDialogDisp = dispinterface
    ['{3050F216-98B5-11CF-BB82-00AA00BDCE0B}']
    property dialogTop: OleVariant dispid -2147418108;
    property dialogLeft: OleVariant dispid -2147418109;
    property dialogWidth: OleVariant dispid -2147418107;
    property dialogHeight: OleVariant dispid -2147418106;
    property dialogArguments: OleVariant readonly dispid 25000;
    property menuArguments: OleVariant readonly dispid 25013;
    property returnValue: OleVariant dispid 25001;
    procedure close; dispid 25011;
    function  toString: WideString; dispid 25012;
  end;

// *********************************************************************//
// Interface: IHTMLFrontPageBotElement
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {83DB5580-E05A-11D1-B3E1-0060977B463D}
// *********************************************************************//
  IHTMLFrontPageBotElement = interface(IDispatch)
    ['{83DB5580-E05A-11D1-B3E1-0060977B463D}']
    procedure setBotAttribute(const strAttributeName: WideString; AttributeValue: OleVariant); safecall;
    function  getBotAttribute(const strAttributeName: WideString): OleVariant; safecall;
    function  removeBotAttribute(const strAttributeName: WideString): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IHTMLFrontPageBotElementDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {83DB5580-E05A-11D1-B3E1-0060977B463D}
// *********************************************************************//
  IHTMLFrontPageBotElementDisp = dispinterface
    ['{83DB5580-E05A-11D1-B3E1-0060977B463D}']
    procedure setBotAttribute(const strAttributeName: WideString; AttributeValue: OleVariant); dispid 1001;
    function  getBotAttribute(const strAttributeName: WideString): OleVariant; dispid 1002;
    function  removeBotAttribute(const strAttributeName: WideString): WordBool; dispid 1003;
  end;

// *********************************************************************//
// DispIntf:  DispIHTMLFrontPageBotElement
// Flags:     (4112) Hidden Dispatchable
// GUID:      {83DB5581-E05A-11D1-B3E1-0060977B463D}
// *********************************************************************//
  DispIHTMLFrontPageBotElement = dispinterface
    ['{83DB5581-E05A-11D1-B3E1-0060977B463D}']
    procedure setAttribute(const strAttributeName: WideString; AttributeValue: OleVariant;
                           lFlags: Integer); dispid -2147417611;
    function  getAttribute(const strAttributeName: WideString; lFlags: Integer): OleVariant; dispid -2147417610;
    function  removeAttribute(const strAttributeName: WideString; lFlags: Integer): WordBool; dispid -2147417609;
    property className: WideString dispid -2147417111;
    property id: WideString dispid -2147417110;
    property tagName: WideString readonly dispid -2147417108;
    property parentElement: IHTMLElement readonly dispid -2147418104;
    property style: IHTMLStyle readonly dispid -2147418038;
    property onhelp: OleVariant dispid -2147412099;
    property onclick: OleVariant dispid -2147412104;
    property ondblclick: OleVariant dispid -2147412103;
    property onkeydown: OleVariant dispid -2147412107;
    property onkeyup: OleVariant dispid -2147412106;
    property onkeypress: OleVariant dispid -2147412105;
    property onmouseout: OleVariant dispid -2147412111;
    property onmouseover: OleVariant dispid -2147412112;
    property onmousemove: OleVariant dispid -2147412108;
    property onmousedown: OleVariant dispid -2147412110;
    property onmouseup: OleVariant dispid -2147412109;
    property Document: IDispatch readonly dispid -2147417094;
    property title: WideString dispid -2147418043;
    property language: WideString dispid -2147413012;
    property onselectstart: OleVariant dispid -2147412075;
    procedure scrollIntoView(varargStart: OleVariant); dispid -2147417093;
    function  contains(const pChild: IHTMLElement): WordBool; dispid -2147417092;
    property sourceIndex: Integer readonly dispid -2147417088;
    property recordNumber: OleVariant readonly dispid -2147417087;
    property lang: WideString dispid -2147413103;
    property offsetLeft: Integer readonly dispid -2147417104;
    property offsetTop: Integer readonly dispid -2147417103;
    property offsetWidth: Integer readonly dispid -2147417102;
    property offsetHeight: Integer readonly dispid -2147417101;
    property offsetParent: IHTMLElement readonly dispid -2147417100;
    property innerHTML: WideString dispid -2147417086;
    property innerText: WideString dispid -2147417085;
    property outerHTML: WideString dispid -2147417084;
    property outerText: WideString dispid -2147417083;
    procedure insertAdjacentHTML(const where: WideString; const html: WideString); dispid -2147417082;
    procedure insertAdjacentText(const where: WideString; const text: WideString); dispid -2147417081;
    property parentTextEdit: IHTMLElement readonly dispid -2147417080;
    property isTextEdit: WordBool readonly dispid -2147417078;
    procedure click; dispid -2147417079;
    property filters: IHTMLFiltersCollection readonly dispid -2147417077;
    property ondragstart: OleVariant dispid -2147412077;
    function  toString: WideString; dispid -2147417076;
    property onbeforeupdate: OleVariant dispid -2147412091;
    property onafterupdate: OleVariant dispid -2147412090;
    property onerrorupdate: OleVariant dispid -2147412074;
    property onrowexit: OleVariant dispid -2147412094;
    property onrowenter: OleVariant dispid -2147412093;
    property ondatasetchanged: OleVariant dispid -2147412072;
    property ondataavailable: OleVariant dispid -2147412071;
    property ondatasetcomplete: OleVariant dispid -2147412070;
    property onfilterchange: OleVariant dispid -2147412069;
    property children: IDispatch readonly dispid -2147417075;
    property all: IDispatch readonly dispid -2147417074;
    procedure setBotAttribute(const strAttributeName: WideString; AttributeValue: OleVariant); dispid 1001;
    function  getBotAttribute(const strAttributeName: WideString): OleVariant; dispid 1002;
    function  removeBotAttribute(const strAttributeName: WideString): WordBool; dispid 1003;
  end;

// *********************************************************************//
// The Class CoCWPEDoc provides a Create and CreateRemote method to
// create instances of the default interface IWPEDoc exposed by
// the CoClass CWPEDoc. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCWPEDoc = class
    class function Create: IWPEDoc;
    class function CreateRemote(const MachineName: string): IWPEDoc;
  end;

// *********************************************************************//
// The Class CoCAutoJackInteral provides a Create and CreateRemote method to
// create instances of the default interface IPageEditorInternal exposed by
// the CoClass CAutoJackInteral. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoCAutoJackInteral = class
    class function Create: IPageEditorInternal;
    class function CreateRemote(const MachineName: string): IPageEditorInternal;
  end;

// *********************************************************************//
// The Class CoURLPicker provides a Create and CreateRemote method to
// create instances of the default interface IURLPicker exposed by
// the CoClass URLPicker. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoURLPicker = class
    class function Create: IURLPicker;
    class function CreateRemote(const MachineName: string): IURLPicker;
  end;

// *********************************************************************//
// The Class CoHTMLColorPicker provides a Create and CreateRemote method to
// create instances of the default interface IHTMLColorPicker exposed by
// the CoClass HTMLColorPicker. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoHTMLColorPicker = class
    class function Create: IHTMLColorPicker;
    class function CreateRemote(const MachineName: string): IHTMLColorPicker;
  end;

// *********************************************************************//
// The Class CoFPAxTagPage provides a Create and CreateRemote method to
// create instances of the default interface IUnknown exposed by
// the CoClass FPAxTagPage. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPAxTagPage = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

// *********************************************************************//
// The Class CoFPAxParamsPage provides a Create and CreateRemote method to
// create instances of the default interface IUnknown exposed by
// the CoClass FPAxParamsPage. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPAxParamsPage = class
    class function Create: IUnknown;
    class function CreateRemote(const MachineName: string): IUnknown;
  end;

// *********************************************************************//
// The Class CoChServ provides a Create and CreateRemote method to
// create instances of the default interface IChServ exposed by
// the CoClass ChServ. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoChServ = class
    class function Create: IChServ;
    class function CreateRemote(const MachineName: string): IChServ;
  end;

// *********************************************************************//
// The Class CoFPHTMLUndoTransaction provides a Create and CreateRemote method to
// create instances of the default interface IFPHTMLUndoTransaction exposed by
// the CoClass FPHTMLUndoTransaction. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLUndoTransaction = class
    class function Create: IFPHTMLUndoTransaction;
    class function CreateRemote(const MachineName: string): IFPHTMLUndoTransaction;
  end;

// *********************************************************************//
// The Class CoFPHTMLDocument provides a Create and CreateRemote method to
// create instances of the default interface DispFPHTMLDocument exposed by
// the CoClass FPHTMLDocument. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLDocument = class
    class function Create: DispFPHTMLDocument;
    class function CreateRemote(const MachineName: string): DispFPHTMLDocument;
  end;

// *********************************************************************//
// The Class CoFPHTMLStyle provides a Create and CreateRemote method to
// create instances of the default interface IHTMLStyle exposed by
// the CoClass FPHTMLStyle. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLStyle = class
    class function Create: IHTMLStyle;
    class function CreateRemote(const MachineName: string): IHTMLStyle;
  end;

// *********************************************************************//
// The Class CoFPHTMLFiltersCollection provides a Create and CreateRemote method to
// create instances of the default interface IHTMLFiltersCollection exposed by
// the CoClass FPHTMLFiltersCollection. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLFiltersCollection = class
    class function Create: IHTMLFiltersCollection;
    class function CreateRemote(const MachineName: string): IHTMLFiltersCollection;
  end;

// *********************************************************************//
// The Class CoFPHTMLStyleSheet provides a Create and CreateRemote method to
// create instances of the default interface IHTMLStyleSheet exposed by
// the CoClass FPHTMLStyleSheet. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLStyleSheet = class
    class function Create: IHTMLStyleSheet;
    class function CreateRemote(const MachineName: string): IHTMLStyleSheet;
  end;

// *********************************************************************//
// The Class CoFPHTMLStyleSheetsCollection provides a Create and CreateRemote method to
// create instances of the default interface IHTMLStyleSheetsCollection exposed by
// the CoClass FPHTMLStyleSheetsCollection. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLStyleSheetsCollection = class
    class function Create: IHTMLStyleSheetsCollection;
    class function CreateRemote(const MachineName: string): IHTMLStyleSheetsCollection;
  end;

// *********************************************************************//
// The Class CoFPHTMLLinkElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLLinkElement exposed by
// the CoClass FPHTMLLinkElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLLinkElement = class
    class function Create: DispIHTMLLinkElement;
    class function CreateRemote(const MachineName: string): DispIHTMLLinkElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLFormElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLFormElement exposed by
// the CoClass FPHTMLFormElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLFormElement = class
    class function Create: DispIHTMLFormElement;
    class function CreateRemote(const MachineName: string): DispIHTMLFormElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLTextElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLTextElement exposed by
// the CoClass FPHTMLTextElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLTextElement = class
    class function Create: DispIHTMLTextElement;
    class function CreateRemote(const MachineName: string): DispIHTMLTextElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLImg provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLImgElement exposed by
// the CoClass FPHTMLImg. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLImg = class
    class function Create: DispIHTMLImgElement;
    class function CreateRemote(const MachineName: string): DispIHTMLImgElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLInputImage provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLInputImage exposed by
// the CoClass FPHTMLInputImage. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLInputImage = class
    class function Create: DispIHTMLInputImage;
    class function CreateRemote(const MachineName: string): DispIHTMLInputImage;
  end;

// *********************************************************************//
// The Class CoFPHTMLImageElementFactory provides a Create and CreateRemote method to
// create instances of the default interface IHTMLImageElementFactory exposed by
// the CoClass FPHTMLImageElementFactory. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLImageElementFactory = class
    class function Create: IHTMLImageElementFactory;
    class function CreateRemote(const MachineName: string): IHTMLImageElementFactory;
  end;

// *********************************************************************//
// The Class CoFPHTMLBody provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLBodyElement exposed by
// the CoClass FPHTMLBody. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLBody = class
    class function Create: DispIHTMLBodyElement;
    class function CreateRemote(const MachineName: string): DispIHTMLBodyElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLFontElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLFontElement exposed by
// the CoClass FPHTMLFontElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLFontElement = class
    class function Create: DispIHTMLFontElement;
    class function CreateRemote(const MachineName: string): DispIHTMLFontElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLAnchorElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLAnchorElement exposed by
// the CoClass FPHTMLAnchorElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLAnchorElement = class
    class function Create: DispIHTMLAnchorElement;
    class function CreateRemote(const MachineName: string): DispIHTMLAnchorElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLLabelElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLLabelElement exposed by
// the CoClass FPHTMLLabelElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLLabelElement = class
    class function Create: DispIHTMLLabelElement;
    class function CreateRemote(const MachineName: string): DispIHTMLLabelElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLListElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLListElement exposed by
// the CoClass FPHTMLListElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLListElement = class
    class function Create: DispIHTMLListElement;
    class function CreateRemote(const MachineName: string): DispIHTMLListElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLUListElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLUListElement exposed by
// the CoClass FPHTMLUListElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLUListElement = class
    class function Create: DispIHTMLUListElement;
    class function CreateRemote(const MachineName: string): DispIHTMLUListElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLOListElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLOListElement exposed by
// the CoClass FPHTMLOListElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLOListElement = class
    class function Create: DispIHTMLOListElement;
    class function CreateRemote(const MachineName: string): DispIHTMLOListElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLLIElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLLIElement exposed by
// the CoClass FPHTMLLIElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLLIElement = class
    class function Create: DispIHTMLLIElement;
    class function CreateRemote(const MachineName: string): DispIHTMLLIElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLBlockElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLBlockElement exposed by
// the CoClass FPHTMLBlockElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLBlockElement = class
    class function Create: DispIHTMLBlockElement;
    class function CreateRemote(const MachineName: string): DispIHTMLBlockElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLDivElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLDivElement exposed by
// the CoClass FPHTMLDivElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLDivElement = class
    class function Create: DispIHTMLDivElement;
    class function CreateRemote(const MachineName: string): DispIHTMLDivElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLDDElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLDDElement exposed by
// the CoClass FPHTMLDDElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLDDElement = class
    class function Create: DispIHTMLDDElement;
    class function CreateRemote(const MachineName: string): DispIHTMLDDElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLDTElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLDTElement exposed by
// the CoClass FPHTMLDTElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLDTElement = class
    class function Create: DispIHTMLDTElement;
    class function CreateRemote(const MachineName: string): DispIHTMLDTElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLBRElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLBRElement exposed by
// the CoClass FPHTMLBRElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLBRElement = class
    class function Create: DispIHTMLBRElement;
    class function CreateRemote(const MachineName: string): DispIHTMLBRElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLDListElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLDListElement exposed by
// the CoClass FPHTMLDListElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLDListElement = class
    class function Create: DispIHTMLDListElement;
    class function CreateRemote(const MachineName: string): DispIHTMLDListElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLHRElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLHRElement exposed by
// the CoClass FPHTMLHRElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLHRElement = class
    class function Create: DispIHTMLHRElement;
    class function CreateRemote(const MachineName: string): DispIHTMLHRElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLParaElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLParaElement exposed by
// the CoClass FPHTMLParaElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLParaElement = class
    class function Create: DispIHTMLParaElement;
    class function CreateRemote(const MachineName: string): DispIHTMLParaElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLHeaderElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLHeaderElement exposed by
// the CoClass FPHTMLHeaderElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLHeaderElement = class
    class function Create: DispIHTMLHeaderElement;
    class function CreateRemote(const MachineName: string): DispIHTMLHeaderElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLSelectElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLSelectElement exposed by
// the CoClass FPHTMLSelectElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLSelectElement = class
    class function Create: DispIHTMLSelectElement;
    class function CreateRemote(const MachineName: string): DispIHTMLSelectElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLOptionElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLOptionElement exposed by
// the CoClass FPHTMLOptionElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLOptionElement = class
    class function Create: DispIHTMLOptionElement;
    class function CreateRemote(const MachineName: string): DispIHTMLOptionElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLOptionElementFactory provides a Create and CreateRemote method to
// create instances of the default interface IHTMLOptionElementFactory exposed by
// the CoClass FPHTMLOptionElementFactory. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLOptionElementFactory = class
    class function Create: IHTMLOptionElementFactory;
    class function CreateRemote(const MachineName: string): IHTMLOptionElementFactory;
  end;

// *********************************************************************//
// The Class CoFPHTMLInputTextElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLInputTextElement exposed by
// the CoClass FPHTMLInputTextElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLInputTextElement = class
    class function Create: DispIHTMLInputTextElement;
    class function CreateRemote(const MachineName: string): DispIHTMLInputTextElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLTextAreaElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLTextAreaElement exposed by
// the CoClass FPHTMLTextAreaElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLTextAreaElement = class
    class function Create: DispIHTMLTextAreaElement;
    class function CreateRemote(const MachineName: string): DispIHTMLTextAreaElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLInputButtonElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLInputButtonElement exposed by
// the CoClass FPHTMLInputButtonElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLInputButtonElement = class
    class function Create: DispIHTMLInputButtonElement;
    class function CreateRemote(const MachineName: string): DispIHTMLInputButtonElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLInputHiddenElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLInputButtonElement exposed by
// the CoClass FPHTMLInputHiddenElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLInputHiddenElement = class
    class function Create: DispIHTMLInputButtonElement;
    class function CreateRemote(const MachineName: string): DispIHTMLInputButtonElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLButtonElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLButtonElement exposed by
// the CoClass FPHTMLButtonElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLButtonElement = class
    class function Create: DispIHTMLButtonElement;
    class function CreateRemote(const MachineName: string): DispIHTMLButtonElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLInputFileElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLInputFileElement exposed by
// the CoClass FPHTMLInputFileElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLInputFileElement = class
    class function Create: DispIHTMLInputFileElement;
    class function CreateRemote(const MachineName: string): DispIHTMLInputFileElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLMarqueeElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLMarqueeElement exposed by
// the CoClass FPHTMLMarqueeElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLMarqueeElement = class
    class function Create: DispIHTMLMarqueeElement;
    class function CreateRemote(const MachineName: string): DispIHTMLMarqueeElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLOptionButtonElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLOptionButtonElement exposed by
// the CoClass FPHTMLOptionButtonElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLOptionButtonElement = class
    class function Create: DispIHTMLOptionButtonElement;
    class function CreateRemote(const MachineName: string): DispIHTMLOptionButtonElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLTitleElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLTitleElement exposed by
// the CoClass FPHTMLTitleElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLTitleElement = class
    class function Create: DispIHTMLTitleElement;
    class function CreateRemote(const MachineName: string): DispIHTMLTitleElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLMetaElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLMetaElement exposed by
// the CoClass FPHTMLMetaElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLMetaElement = class
    class function Create: DispIHTMLMetaElement;
    class function CreateRemote(const MachineName: string): DispIHTMLMetaElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLBaseElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLBaseElement exposed by
// the CoClass FPHTMLBaseElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLBaseElement = class
    class function Create: DispIHTMLBaseElement;
    class function CreateRemote(const MachineName: string): DispIHTMLBaseElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLIsIndexElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLIsIndexElement exposed by
// the CoClass FPHTMLIsIndexElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLIsIndexElement = class
    class function Create: DispIHTMLIsIndexElement;
    class function CreateRemote(const MachineName: string): DispIHTMLIsIndexElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLNextIdElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLNextIdElement exposed by
// the CoClass FPHTMLNextIdElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLNextIdElement = class
    class function Create: DispIHTMLNextIdElement;
    class function CreateRemote(const MachineName: string): DispIHTMLNextIdElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLBaseFontElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLBaseFontElement exposed by
// the CoClass FPHTMLBaseFontElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLBaseFontElement = class
    class function Create: DispIHTMLBaseFontElement;
    class function CreateRemote(const MachineName: string): DispIHTMLBaseFontElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLUnknownElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLUnknownElement exposed by
// the CoClass FPHTMLUnknownElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLUnknownElement = class
    class function Create: DispIHTMLUnknownElement;
    class function CreateRemote(const MachineName: string): DispIHTMLUnknownElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLHistory provides a Create and CreateRemote method to
// create instances of the default interface IOmHistory exposed by
// the CoClass FPHTMLHistory. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLHistory = class
    class function Create: IOmHistory;
    class function CreateRemote(const MachineName: string): IOmHistory;
  end;

// *********************************************************************//
// The Class CoFPHTMLCMimeTypes provides a Create and CreateRemote method to
// create instances of the default interface IHTMLMimeTypesCollection exposed by
// the CoClass FPHTMLCMimeTypes. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLCMimeTypes = class
    class function Create: IHTMLMimeTypesCollection;
    class function CreateRemote(const MachineName: string): IHTMLMimeTypesCollection;
  end;

// *********************************************************************//
// The Class CoFPHTMLCPlugins provides a Create and CreateRemote method to
// create instances of the default interface IHTMLPluginsCollection exposed by
// the CoClass FPHTMLCPlugins. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLCPlugins = class
    class function Create: IHTMLPluginsCollection;
    class function CreateRemote(const MachineName: string): IHTMLPluginsCollection;
  end;

// *********************************************************************//
// The Class CoFPHTMLCOpsProfile provides a Create and CreateRemote method to
// create instances of the default interface IHTMLOpsProfile exposed by
// the CoClass FPHTMLCOpsProfile. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLCOpsProfile = class
    class function Create: IHTMLOpsProfile;
    class function CreateRemote(const MachineName: string): IHTMLOpsProfile;
  end;

// *********************************************************************//
// The Class CoFPHTMLNavigator provides a Create and CreateRemote method to
// create instances of the default interface IOmNavigator exposed by
// the CoClass FPHTMLNavigator. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLNavigator = class
    class function Create: IOmNavigator;
    class function CreateRemote(const MachineName: string): IOmNavigator;
  end;

// *********************************************************************//
// The Class CoFPHTMLLocation provides a Create and CreateRemote method to
// create instances of the default interface IHTMLLocation exposed by
// the CoClass FPHTMLLocation. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLLocation = class
    class function Create: IHTMLLocation;
    class function CreateRemote(const MachineName: string): IHTMLLocation;
  end;

// *********************************************************************//
// The Class CoFPHTMLScreen provides a Create and CreateRemote method to
// create instances of the default interface IHTMLScreen exposed by
// the CoClass FPHTMLScreen. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLScreen = class
    class function Create: IHTMLScreen;
    class function CreateRemote(const MachineName: string): IHTMLScreen;
  end;

// *********************************************************************//
// The Class CoFPHTMLWindow2 provides a Create and CreateRemote method to
// create instances of the default interface IHTMLWindow2 exposed by
// the CoClass FPHTMLWindow2. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLWindow2 = class
    class function Create: IHTMLWindow2;
    class function CreateRemote(const MachineName: string): IHTMLWindow2;
  end;

// *********************************************************************//
// The Class CoFPHTMLWindowProxy provides a Create and CreateRemote method to
// create instances of the default interface IHTMLWindow2 exposed by
// the CoClass FPHTMLWindowProxy. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLWindowProxy = class
    class function Create: IHTMLWindow2;
    class function CreateRemote(const MachineName: string): IHTMLWindow2;
  end;

// *********************************************************************//
// The Class CoFPHTMLEmbed provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLEmbedElement exposed by
// the CoClass FPHTMLEmbed. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLEmbed = class
    class function Create: DispIHTMLEmbedElement;
    class function CreateRemote(const MachineName: string): DispIHTMLEmbedElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLMapElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLMapElement exposed by
// the CoClass FPHTMLMapElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLMapElement = class
    class function Create: DispIHTMLMapElement;
    class function CreateRemote(const MachineName: string): DispIHTMLMapElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLAreaElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLAreaElement exposed by
// the CoClass FPHTMLAreaElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLAreaElement = class
    class function Create: DispIHTMLAreaElement;
    class function CreateRemote(const MachineName: string): DispIHTMLAreaElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLTableCaption provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLTableCaption exposed by
// the CoClass FPHTMLTableCaption. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLTableCaption = class
    class function Create: DispIHTMLTableCaption;
    class function CreateRemote(const MachineName: string): DispIHTMLTableCaption;
  end;

// *********************************************************************//
// The Class CoFPHTMLCommentElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLCommentElement exposed by
// the CoClass FPHTMLCommentElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLCommentElement = class
    class function Create: DispIHTMLCommentElement;
    class function CreateRemote(const MachineName: string): DispIHTMLCommentElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLPhraseElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLPhraseElement exposed by
// the CoClass FPHTMLPhraseElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLPhraseElement = class
    class function Create: DispIHTMLPhraseElement;
    class function CreateRemote(const MachineName: string): DispIHTMLPhraseElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLSpanElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLSpanElement exposed by
// the CoClass FPHTMLSpanElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLSpanElement = class
    class function Create: DispIHTMLSpanElement;
    class function CreateRemote(const MachineName: string): DispIHTMLSpanElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLTable provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLTable exposed by
// the CoClass FPHTMLTable. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLTable = class
    class function Create: DispIHTMLTable;
    class function CreateRemote(const MachineName: string): DispIHTMLTable;
  end;

// *********************************************************************//
// The Class CoFPHTMLTableCol provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLTableCol exposed by
// the CoClass FPHTMLTableCol. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLTableCol = class
    class function Create: DispIHTMLTableCol;
    class function CreateRemote(const MachineName: string): DispIHTMLTableCol;
  end;

// *********************************************************************//
// The Class CoFPHTMLTableSection provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLTableSection exposed by
// the CoClass FPHTMLTableSection. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLTableSection = class
    class function Create: DispIHTMLTableSection;
    class function CreateRemote(const MachineName: string): DispIHTMLTableSection;
  end;

// *********************************************************************//
// The Class CoFPHTMLTableRow provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLTableRow exposed by
// the CoClass FPHTMLTableRow. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLTableRow = class
    class function Create: DispIHTMLTableRow;
    class function CreateRemote(const MachineName: string): DispIHTMLTableRow;
  end;

// *********************************************************************//
// The Class CoFPHTMLTableCell provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLTableCell exposed by
// the CoClass FPHTMLTableCell. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLTableCell = class
    class function Create: DispIHTMLTableCell;
    class function CreateRemote(const MachineName: string): DispIHTMLTableCell;
  end;

// *********************************************************************//
// The Class CoFPHTMLScriptElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLScriptElement exposed by
// the CoClass FPHTMLScriptElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLScriptElement = class
    class function Create: DispIHTMLScriptElement;
    class function CreateRemote(const MachineName: string): DispIHTMLScriptElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLNoShowElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLNoShowElement exposed by
// the CoClass FPHTMLNoShowElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLNoShowElement = class
    class function Create: DispIHTMLNoShowElement;
    class function CreateRemote(const MachineName: string): DispIHTMLNoShowElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLObjectElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLObjectElement exposed by
// the CoClass FPHTMLObjectElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLObjectElement = class
    class function Create: DispIHTMLObjectElement;
    class function CreateRemote(const MachineName: string): DispIHTMLObjectElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLFrameBase provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLFrameBase exposed by
// the CoClass FPHTMLFrameBase. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLFrameBase = class
    class function Create: DispIHTMLFrameBase;
    class function CreateRemote(const MachineName: string): DispIHTMLFrameBase;
  end;

// *********************************************************************//
// The Class CoFPHTMLFrameElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLFrameElement exposed by
// the CoClass FPHTMLFrameElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLFrameElement = class
    class function Create: DispIHTMLFrameElement;
    class function CreateRemote(const MachineName: string): DispIHTMLFrameElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLIFrame provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLIFrameElement exposed by
// the CoClass FPHTMLIFrame. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLIFrame = class
    class function Create: DispIHTMLIFrameElement;
    class function CreateRemote(const MachineName: string): DispIHTMLIFrameElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLDivPosition provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLDivPosition exposed by
// the CoClass FPHTMLDivPosition. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLDivPosition = class
    class function Create: DispIHTMLDivPosition;
    class function CreateRemote(const MachineName: string): DispIHTMLDivPosition;
  end;

// *********************************************************************//
// The Class CoFPHTMLFieldSetElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLFieldSetElement exposed by
// the CoClass FPHTMLFieldSetElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLFieldSetElement = class
    class function Create: DispIHTMLFieldSetElement;
    class function CreateRemote(const MachineName: string): DispIHTMLFieldSetElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLLegendElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLLegendElement exposed by
// the CoClass FPHTMLLegendElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLLegendElement = class
    class function Create: DispIHTMLLegendElement;
    class function CreateRemote(const MachineName: string): DispIHTMLLegendElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLSpanFlow provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLSpanFlow exposed by
// the CoClass FPHTMLSpanFlow. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLSpanFlow = class
    class function Create: DispIHTMLSpanFlow;
    class function CreateRemote(const MachineName: string): DispIHTMLSpanFlow;
  end;

// *********************************************************************//
// The Class CoFPHTMLFrameSetSite provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLFrameSetElement exposed by
// the CoClass FPHTMLFrameSetSite. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLFrameSetSite = class
    class function Create: DispIHTMLFrameSetElement;
    class function CreateRemote(const MachineName: string): DispIHTMLFrameSetElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLBGsound provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLBGsound exposed by
// the CoClass FPHTMLBGsound. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLBGsound = class
    class function Create: DispIHTMLBGsound;
    class function CreateRemote(const MachineName: string): DispIHTMLBGsound;
  end;

// *********************************************************************//
// The Class CoFPHTMLStyleElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLStyleElement exposed by
// the CoClass FPHTMLStyleElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLStyleElement = class
    class function Create: DispIHTMLStyleElement;
    class function CreateRemote(const MachineName: string): DispIHTMLStyleElement;
  end;

// *********************************************************************//
// The Class CoFPHTMLStyleFontFace provides a Create and CreateRemote method to
// create instances of the default interface IHTMLStyleFontFace exposed by
// the CoClass FPHTMLStyleFontFace. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLStyleFontFace = class
    class function Create: IHTMLStyleFontFace;
    class function CreateRemote(const MachineName: string): IHTMLStyleFontFace;
  end;

// *********************************************************************//
// The Class CoFPHTMLDialog provides a Create and CreateRemote method to
// create instances of the default interface IHTMLDialog exposed by
// the CoClass FPHTMLDialog. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLDialog = class
    class function Create: IHTMLDialog;
    class function CreateRemote(const MachineName: string): IHTMLDialog;
  end;

// *********************************************************************//
// The Class CoFPHTMLFrontPageBotElement provides a Create and CreateRemote method to
// create instances of the default interface DispIHTMLFrontPageBotElement exposed by
// the CoClass FPHTMLFrontPageBotElement. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoFPHTMLFrontPageBotElement = class
    class function Create: DispIHTMLFrontPageBotElement;
    class function CreateRemote(const MachineName: string): DispIHTMLFrontPageBotElement;
  end;

implementation

uses ComObj;

class function CoCWPEDoc.Create: IWPEDoc;
begin
  Result := CreateComObject(CLASS_CWPEDoc) as IWPEDoc;
end;

class function CoCWPEDoc.CreateRemote(const MachineName: string): IWPEDoc;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CWPEDoc) as IWPEDoc;
end;

class function CoCAutoJackInteral.Create: IPageEditorInternal;
begin
  Result := CreateComObject(CLASS_CAutoJackInteral) as IPageEditorInternal;
end;

class function CoCAutoJackInteral.CreateRemote(const MachineName: string): IPageEditorInternal;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CAutoJackInteral) as IPageEditorInternal;
end;

class function CoURLPicker.Create: IURLPicker;
begin
  Result := CreateComObject(CLASS_URLPicker) as IURLPicker;
end;

class function CoURLPicker.CreateRemote(const MachineName: string): IURLPicker;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_URLPicker) as IURLPicker;
end;

class function CoHTMLColorPicker.Create: IHTMLColorPicker;
begin
  Result := CreateComObject(CLASS_HTMLColorPicker) as IHTMLColorPicker;
end;

class function CoHTMLColorPicker.CreateRemote(const MachineName: string): IHTMLColorPicker;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_HTMLColorPicker) as IHTMLColorPicker;
end;

class function CoFPAxTagPage.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_FPAxTagPage) as IUnknown;
end;

class function CoFPAxTagPage.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPAxTagPage) as IUnknown;
end;

class function CoFPAxParamsPage.Create: IUnknown;
begin
  Result := CreateComObject(CLASS_FPAxParamsPage) as IUnknown;
end;

class function CoFPAxParamsPage.CreateRemote(const MachineName: string): IUnknown;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPAxParamsPage) as IUnknown;
end;

class function CoChServ.Create: IChServ;
begin
  Result := CreateComObject(CLASS_ChServ) as IChServ;
end;

class function CoChServ.CreateRemote(const MachineName: string): IChServ;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ChServ) as IChServ;
end;

class function CoFPHTMLUndoTransaction.Create: IFPHTMLUndoTransaction;
begin
  Result := CreateComObject(CLASS_FPHTMLUndoTransaction) as IFPHTMLUndoTransaction;
end;

class function CoFPHTMLUndoTransaction.CreateRemote(const MachineName: string): IFPHTMLUndoTransaction;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLUndoTransaction) as IFPHTMLUndoTransaction;
end;

class function CoFPHTMLDocument.Create: DispFPHTMLDocument;
begin
  Result := CreateComObject(CLASS_FPHTMLDocument) as DispFPHTMLDocument;
end;

class function CoFPHTMLDocument.CreateRemote(const MachineName: string): DispFPHTMLDocument;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLDocument) as DispFPHTMLDocument;
end;

class function CoFPHTMLStyle.Create: IHTMLStyle;
begin
  Result := CreateComObject(CLASS_FPHTMLStyle) as IHTMLStyle;
end;

class function CoFPHTMLStyle.CreateRemote(const MachineName: string): IHTMLStyle;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLStyle) as IHTMLStyle;
end;

class function CoFPHTMLFiltersCollection.Create: IHTMLFiltersCollection;
begin
  Result := CreateComObject(CLASS_FPHTMLFiltersCollection) as IHTMLFiltersCollection;
end;

class function CoFPHTMLFiltersCollection.CreateRemote(const MachineName: string): IHTMLFiltersCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLFiltersCollection) as IHTMLFiltersCollection;
end;

class function CoFPHTMLStyleSheet.Create: IHTMLStyleSheet;
begin
  Result := CreateComObject(CLASS_FPHTMLStyleSheet) as IHTMLStyleSheet;
end;

class function CoFPHTMLStyleSheet.CreateRemote(const MachineName: string): IHTMLStyleSheet;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLStyleSheet) as IHTMLStyleSheet;
end;

class function CoFPHTMLStyleSheetsCollection.Create: IHTMLStyleSheetsCollection;
begin
  Result := CreateComObject(CLASS_FPHTMLStyleSheetsCollection) as IHTMLStyleSheetsCollection;
end;

class function CoFPHTMLStyleSheetsCollection.CreateRemote(const MachineName: string): IHTMLStyleSheetsCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLStyleSheetsCollection) as IHTMLStyleSheetsCollection;
end;

class function CoFPHTMLLinkElement.Create: DispIHTMLLinkElement;
begin
  Result := CreateComObject(CLASS_FPHTMLLinkElement) as DispIHTMLLinkElement;
end;

class function CoFPHTMLLinkElement.CreateRemote(const MachineName: string): DispIHTMLLinkElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLLinkElement) as DispIHTMLLinkElement;
end;

class function CoFPHTMLFormElement.Create: DispIHTMLFormElement;
begin
  Result := CreateComObject(CLASS_FPHTMLFormElement) as DispIHTMLFormElement;
end;

class function CoFPHTMLFormElement.CreateRemote(const MachineName: string): DispIHTMLFormElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLFormElement) as DispIHTMLFormElement;
end;

class function CoFPHTMLTextElement.Create: DispIHTMLTextElement;
begin
  Result := CreateComObject(CLASS_FPHTMLTextElement) as DispIHTMLTextElement;
end;

class function CoFPHTMLTextElement.CreateRemote(const MachineName: string): DispIHTMLTextElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLTextElement) as DispIHTMLTextElement;
end;

class function CoFPHTMLImg.Create: DispIHTMLImgElement;
begin
  Result := CreateComObject(CLASS_FPHTMLImg) as DispIHTMLImgElement;
end;

class function CoFPHTMLImg.CreateRemote(const MachineName: string): DispIHTMLImgElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLImg) as DispIHTMLImgElement;
end;

class function CoFPHTMLInputImage.Create: DispIHTMLInputImage;
begin
  Result := CreateComObject(CLASS_FPHTMLInputImage) as DispIHTMLInputImage;
end;

class function CoFPHTMLInputImage.CreateRemote(const MachineName: string): DispIHTMLInputImage;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLInputImage) as DispIHTMLInputImage;
end;

class function CoFPHTMLImageElementFactory.Create: IHTMLImageElementFactory;
begin
  Result := CreateComObject(CLASS_FPHTMLImageElementFactory) as IHTMLImageElementFactory;
end;

class function CoFPHTMLImageElementFactory.CreateRemote(const MachineName: string): IHTMLImageElementFactory;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLImageElementFactory) as IHTMLImageElementFactory;
end;

class function CoFPHTMLBody.Create: DispIHTMLBodyElement;
begin
  Result := CreateComObject(CLASS_FPHTMLBody) as DispIHTMLBodyElement;
end;

class function CoFPHTMLBody.CreateRemote(const MachineName: string): DispIHTMLBodyElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLBody) as DispIHTMLBodyElement;
end;

class function CoFPHTMLFontElement.Create: DispIHTMLFontElement;
begin
  Result := CreateComObject(CLASS_FPHTMLFontElement) as DispIHTMLFontElement;
end;

class function CoFPHTMLFontElement.CreateRemote(const MachineName: string): DispIHTMLFontElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLFontElement) as DispIHTMLFontElement;
end;

class function CoFPHTMLAnchorElement.Create: DispIHTMLAnchorElement;
begin
  Result := CreateComObject(CLASS_FPHTMLAnchorElement) as DispIHTMLAnchorElement;
end;

class function CoFPHTMLAnchorElement.CreateRemote(const MachineName: string): DispIHTMLAnchorElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLAnchorElement) as DispIHTMLAnchorElement;
end;

class function CoFPHTMLLabelElement.Create: DispIHTMLLabelElement;
begin
  Result := CreateComObject(CLASS_FPHTMLLabelElement) as DispIHTMLLabelElement;
end;

class function CoFPHTMLLabelElement.CreateRemote(const MachineName: string): DispIHTMLLabelElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLLabelElement) as DispIHTMLLabelElement;
end;

class function CoFPHTMLListElement.Create: DispIHTMLListElement;
begin
  Result := CreateComObject(CLASS_FPHTMLListElement) as DispIHTMLListElement;
end;

class function CoFPHTMLListElement.CreateRemote(const MachineName: string): DispIHTMLListElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLListElement) as DispIHTMLListElement;
end;

class function CoFPHTMLUListElement.Create: DispIHTMLUListElement;
begin
  Result := CreateComObject(CLASS_FPHTMLUListElement) as DispIHTMLUListElement;
end;

class function CoFPHTMLUListElement.CreateRemote(const MachineName: string): DispIHTMLUListElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLUListElement) as DispIHTMLUListElement;
end;

class function CoFPHTMLOListElement.Create: DispIHTMLOListElement;
begin
  Result := CreateComObject(CLASS_FPHTMLOListElement) as DispIHTMLOListElement;
end;

class function CoFPHTMLOListElement.CreateRemote(const MachineName: string): DispIHTMLOListElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLOListElement) as DispIHTMLOListElement;
end;

class function CoFPHTMLLIElement.Create: DispIHTMLLIElement;
begin
  Result := CreateComObject(CLASS_FPHTMLLIElement) as DispIHTMLLIElement;
end;

class function CoFPHTMLLIElement.CreateRemote(const MachineName: string): DispIHTMLLIElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLLIElement) as DispIHTMLLIElement;
end;

class function CoFPHTMLBlockElement.Create: DispIHTMLBlockElement;
begin
  Result := CreateComObject(CLASS_FPHTMLBlockElement) as DispIHTMLBlockElement;
end;

class function CoFPHTMLBlockElement.CreateRemote(const MachineName: string): DispIHTMLBlockElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLBlockElement) as DispIHTMLBlockElement;
end;

class function CoFPHTMLDivElement.Create: DispIHTMLDivElement;
begin
  Result := CreateComObject(CLASS_FPHTMLDivElement) as DispIHTMLDivElement;
end;

class function CoFPHTMLDivElement.CreateRemote(const MachineName: string): DispIHTMLDivElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLDivElement) as DispIHTMLDivElement;
end;

class function CoFPHTMLDDElement.Create: DispIHTMLDDElement;
begin
  Result := CreateComObject(CLASS_FPHTMLDDElement) as DispIHTMLDDElement;
end;

class function CoFPHTMLDDElement.CreateRemote(const MachineName: string): DispIHTMLDDElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLDDElement) as DispIHTMLDDElement;
end;

class function CoFPHTMLDTElement.Create: DispIHTMLDTElement;
begin
  Result := CreateComObject(CLASS_FPHTMLDTElement) as DispIHTMLDTElement;
end;

class function CoFPHTMLDTElement.CreateRemote(const MachineName: string): DispIHTMLDTElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLDTElement) as DispIHTMLDTElement;
end;

class function CoFPHTMLBRElement.Create: DispIHTMLBRElement;
begin
  Result := CreateComObject(CLASS_FPHTMLBRElement) as DispIHTMLBRElement;
end;

class function CoFPHTMLBRElement.CreateRemote(const MachineName: string): DispIHTMLBRElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLBRElement) as DispIHTMLBRElement;
end;

class function CoFPHTMLDListElement.Create: DispIHTMLDListElement;
begin
  Result := CreateComObject(CLASS_FPHTMLDListElement) as DispIHTMLDListElement;
end;

class function CoFPHTMLDListElement.CreateRemote(const MachineName: string): DispIHTMLDListElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLDListElement) as DispIHTMLDListElement;
end;

class function CoFPHTMLHRElement.Create: DispIHTMLHRElement;
begin
  Result := CreateComObject(CLASS_FPHTMLHRElement) as DispIHTMLHRElement;
end;

class function CoFPHTMLHRElement.CreateRemote(const MachineName: string): DispIHTMLHRElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLHRElement) as DispIHTMLHRElement;
end;

class function CoFPHTMLParaElement.Create: DispIHTMLParaElement;
begin
  Result := CreateComObject(CLASS_FPHTMLParaElement) as DispIHTMLParaElement;
end;

class function CoFPHTMLParaElement.CreateRemote(const MachineName: string): DispIHTMLParaElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLParaElement) as DispIHTMLParaElement;
end;

class function CoFPHTMLHeaderElement.Create: DispIHTMLHeaderElement;
begin
  Result := CreateComObject(CLASS_FPHTMLHeaderElement) as DispIHTMLHeaderElement;
end;

class function CoFPHTMLHeaderElement.CreateRemote(const MachineName: string): DispIHTMLHeaderElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLHeaderElement) as DispIHTMLHeaderElement;
end;

class function CoFPHTMLSelectElement.Create: DispIHTMLSelectElement;
begin
  Result := CreateComObject(CLASS_FPHTMLSelectElement) as DispIHTMLSelectElement;
end;

class function CoFPHTMLSelectElement.CreateRemote(const MachineName: string): DispIHTMLSelectElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLSelectElement) as DispIHTMLSelectElement;
end;

class function CoFPHTMLOptionElement.Create: DispIHTMLOptionElement;
begin
  Result := CreateComObject(CLASS_FPHTMLOptionElement) as DispIHTMLOptionElement;
end;

class function CoFPHTMLOptionElement.CreateRemote(const MachineName: string): DispIHTMLOptionElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLOptionElement) as DispIHTMLOptionElement;
end;

class function CoFPHTMLOptionElementFactory.Create: IHTMLOptionElementFactory;
begin
  Result := CreateComObject(CLASS_FPHTMLOptionElementFactory) as IHTMLOptionElementFactory;
end;

class function CoFPHTMLOptionElementFactory.CreateRemote(const MachineName: string): IHTMLOptionElementFactory;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLOptionElementFactory) as IHTMLOptionElementFactory;
end;

class function CoFPHTMLInputTextElement.Create: DispIHTMLInputTextElement;
begin
  Result := CreateComObject(CLASS_FPHTMLInputTextElement) as DispIHTMLInputTextElement;
end;

class function CoFPHTMLInputTextElement.CreateRemote(const MachineName: string): DispIHTMLInputTextElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLInputTextElement) as DispIHTMLInputTextElement;
end;

class function CoFPHTMLTextAreaElement.Create: DispIHTMLTextAreaElement;
begin
  Result := CreateComObject(CLASS_FPHTMLTextAreaElement) as DispIHTMLTextAreaElement;
end;

class function CoFPHTMLTextAreaElement.CreateRemote(const MachineName: string): DispIHTMLTextAreaElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLTextAreaElement) as DispIHTMLTextAreaElement;
end;

class function CoFPHTMLInputButtonElement.Create: DispIHTMLInputButtonElement;
begin
  Result := CreateComObject(CLASS_FPHTMLInputButtonElement) as DispIHTMLInputButtonElement;
end;

class function CoFPHTMLInputButtonElement.CreateRemote(const MachineName: string): DispIHTMLInputButtonElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLInputButtonElement) as DispIHTMLInputButtonElement;
end;

class function CoFPHTMLInputHiddenElement.Create: DispIHTMLInputButtonElement;
begin
  Result := CreateComObject(CLASS_FPHTMLInputHiddenElement) as DispIHTMLInputButtonElement;
end;

class function CoFPHTMLInputHiddenElement.CreateRemote(const MachineName: string): DispIHTMLInputButtonElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLInputHiddenElement) as DispIHTMLInputButtonElement;
end;

class function CoFPHTMLButtonElement.Create: DispIHTMLButtonElement;
begin
  Result := CreateComObject(CLASS_FPHTMLButtonElement) as DispIHTMLButtonElement;
end;

class function CoFPHTMLButtonElement.CreateRemote(const MachineName: string): DispIHTMLButtonElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLButtonElement) as DispIHTMLButtonElement;
end;

class function CoFPHTMLInputFileElement.Create: DispIHTMLInputFileElement;
begin
  Result := CreateComObject(CLASS_FPHTMLInputFileElement) as DispIHTMLInputFileElement;
end;

class function CoFPHTMLInputFileElement.CreateRemote(const MachineName: string): DispIHTMLInputFileElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLInputFileElement) as DispIHTMLInputFileElement;
end;

class function CoFPHTMLMarqueeElement.Create: DispIHTMLMarqueeElement;
begin
  Result := CreateComObject(CLASS_FPHTMLMarqueeElement) as DispIHTMLMarqueeElement;
end;

class function CoFPHTMLMarqueeElement.CreateRemote(const MachineName: string): DispIHTMLMarqueeElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLMarqueeElement) as DispIHTMLMarqueeElement;
end;

class function CoFPHTMLOptionButtonElement.Create: DispIHTMLOptionButtonElement;
begin
  Result := CreateComObject(CLASS_FPHTMLOptionButtonElement) as DispIHTMLOptionButtonElement;
end;

class function CoFPHTMLOptionButtonElement.CreateRemote(const MachineName: string): DispIHTMLOptionButtonElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLOptionButtonElement) as DispIHTMLOptionButtonElement;
end;

class function CoFPHTMLTitleElement.Create: DispIHTMLTitleElement;
begin
  Result := CreateComObject(CLASS_FPHTMLTitleElement) as DispIHTMLTitleElement;
end;

class function CoFPHTMLTitleElement.CreateRemote(const MachineName: string): DispIHTMLTitleElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLTitleElement) as DispIHTMLTitleElement;
end;

class function CoFPHTMLMetaElement.Create: DispIHTMLMetaElement;
begin
  Result := CreateComObject(CLASS_FPHTMLMetaElement) as DispIHTMLMetaElement;
end;

class function CoFPHTMLMetaElement.CreateRemote(const MachineName: string): DispIHTMLMetaElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLMetaElement) as DispIHTMLMetaElement;
end;

class function CoFPHTMLBaseElement.Create: DispIHTMLBaseElement;
begin
  Result := CreateComObject(CLASS_FPHTMLBaseElement) as DispIHTMLBaseElement;
end;

class function CoFPHTMLBaseElement.CreateRemote(const MachineName: string): DispIHTMLBaseElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLBaseElement) as DispIHTMLBaseElement;
end;

class function CoFPHTMLIsIndexElement.Create: DispIHTMLIsIndexElement;
begin
  Result := CreateComObject(CLASS_FPHTMLIsIndexElement) as DispIHTMLIsIndexElement;
end;

class function CoFPHTMLIsIndexElement.CreateRemote(const MachineName: string): DispIHTMLIsIndexElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLIsIndexElement) as DispIHTMLIsIndexElement;
end;

class function CoFPHTMLNextIdElement.Create: DispIHTMLNextIdElement;
begin
  Result := CreateComObject(CLASS_FPHTMLNextIdElement) as DispIHTMLNextIdElement;
end;

class function CoFPHTMLNextIdElement.CreateRemote(const MachineName: string): DispIHTMLNextIdElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLNextIdElement) as DispIHTMLNextIdElement;
end;

class function CoFPHTMLBaseFontElement.Create: DispIHTMLBaseFontElement;
begin
  Result := CreateComObject(CLASS_FPHTMLBaseFontElement) as DispIHTMLBaseFontElement;
end;

class function CoFPHTMLBaseFontElement.CreateRemote(const MachineName: string): DispIHTMLBaseFontElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLBaseFontElement) as DispIHTMLBaseFontElement;
end;

class function CoFPHTMLUnknownElement.Create: DispIHTMLUnknownElement;
begin
  Result := CreateComObject(CLASS_FPHTMLUnknownElement) as DispIHTMLUnknownElement;
end;

class function CoFPHTMLUnknownElement.CreateRemote(const MachineName: string): DispIHTMLUnknownElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLUnknownElement) as DispIHTMLUnknownElement;
end;

class function CoFPHTMLHistory.Create: IOmHistory;
begin
  Result := CreateComObject(CLASS_FPHTMLHistory) as IOmHistory;
end;

class function CoFPHTMLHistory.CreateRemote(const MachineName: string): IOmHistory;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLHistory) as IOmHistory;
end;

class function CoFPHTMLCMimeTypes.Create: IHTMLMimeTypesCollection;
begin
  Result := CreateComObject(CLASS_FPHTMLCMimeTypes) as IHTMLMimeTypesCollection;
end;

class function CoFPHTMLCMimeTypes.CreateRemote(const MachineName: string): IHTMLMimeTypesCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLCMimeTypes) as IHTMLMimeTypesCollection;
end;

class function CoFPHTMLCPlugins.Create: IHTMLPluginsCollection;
begin
  Result := CreateComObject(CLASS_FPHTMLCPlugins) as IHTMLPluginsCollection;
end;

class function CoFPHTMLCPlugins.CreateRemote(const MachineName: string): IHTMLPluginsCollection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLCPlugins) as IHTMLPluginsCollection;
end;

class function CoFPHTMLCOpsProfile.Create: IHTMLOpsProfile;
begin
  Result := CreateComObject(CLASS_FPHTMLCOpsProfile) as IHTMLOpsProfile;
end;

class function CoFPHTMLCOpsProfile.CreateRemote(const MachineName: string): IHTMLOpsProfile;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLCOpsProfile) as IHTMLOpsProfile;
end;

class function CoFPHTMLNavigator.Create: IOmNavigator;
begin
  Result := CreateComObject(CLASS_FPHTMLNavigator) as IOmNavigator;
end;

class function CoFPHTMLNavigator.CreateRemote(const MachineName: string): IOmNavigator;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLNavigator) as IOmNavigator;
end;

class function CoFPHTMLLocation.Create: IHTMLLocation;
begin
  Result := CreateComObject(CLASS_FPHTMLLocation) as IHTMLLocation;
end;

class function CoFPHTMLLocation.CreateRemote(const MachineName: string): IHTMLLocation;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLLocation) as IHTMLLocation;
end;

class function CoFPHTMLScreen.Create: IHTMLScreen;
begin
  Result := CreateComObject(CLASS_FPHTMLScreen) as IHTMLScreen;
end;

class function CoFPHTMLScreen.CreateRemote(const MachineName: string): IHTMLScreen;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLScreen) as IHTMLScreen;
end;

class function CoFPHTMLWindow2.Create: IHTMLWindow2;
begin
  Result := CreateComObject(CLASS_FPHTMLWindow2) as IHTMLWindow2;
end;

class function CoFPHTMLWindow2.CreateRemote(const MachineName: string): IHTMLWindow2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLWindow2) as IHTMLWindow2;
end;

class function CoFPHTMLWindowProxy.Create: IHTMLWindow2;
begin
  Result := CreateComObject(CLASS_FPHTMLWindowProxy) as IHTMLWindow2;
end;

class function CoFPHTMLWindowProxy.CreateRemote(const MachineName: string): IHTMLWindow2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLWindowProxy) as IHTMLWindow2;
end;

class function CoFPHTMLEmbed.Create: DispIHTMLEmbedElement;
begin
  Result := CreateComObject(CLASS_FPHTMLEmbed) as DispIHTMLEmbedElement;
end;

class function CoFPHTMLEmbed.CreateRemote(const MachineName: string): DispIHTMLEmbedElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLEmbed) as DispIHTMLEmbedElement;
end;

class function CoFPHTMLMapElement.Create: DispIHTMLMapElement;
begin
  Result := CreateComObject(CLASS_FPHTMLMapElement) as DispIHTMLMapElement;
end;

class function CoFPHTMLMapElement.CreateRemote(const MachineName: string): DispIHTMLMapElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLMapElement) as DispIHTMLMapElement;
end;

class function CoFPHTMLAreaElement.Create: DispIHTMLAreaElement;
begin
  Result := CreateComObject(CLASS_FPHTMLAreaElement) as DispIHTMLAreaElement;
end;

class function CoFPHTMLAreaElement.CreateRemote(const MachineName: string): DispIHTMLAreaElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLAreaElement) as DispIHTMLAreaElement;
end;

class function CoFPHTMLTableCaption.Create: DispIHTMLTableCaption;
begin
  Result := CreateComObject(CLASS_FPHTMLTableCaption) as DispIHTMLTableCaption;
end;

class function CoFPHTMLTableCaption.CreateRemote(const MachineName: string): DispIHTMLTableCaption;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLTableCaption) as DispIHTMLTableCaption;
end;

class function CoFPHTMLCommentElement.Create: DispIHTMLCommentElement;
begin
  Result := CreateComObject(CLASS_FPHTMLCommentElement) as DispIHTMLCommentElement;
end;

class function CoFPHTMLCommentElement.CreateRemote(const MachineName: string): DispIHTMLCommentElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLCommentElement) as DispIHTMLCommentElement;
end;

class function CoFPHTMLPhraseElement.Create: DispIHTMLPhraseElement;
begin
  Result := CreateComObject(CLASS_FPHTMLPhraseElement) as DispIHTMLPhraseElement;
end;

class function CoFPHTMLPhraseElement.CreateRemote(const MachineName: string): DispIHTMLPhraseElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLPhraseElement) as DispIHTMLPhraseElement;
end;

class function CoFPHTMLSpanElement.Create: DispIHTMLSpanElement;
begin
  Result := CreateComObject(CLASS_FPHTMLSpanElement) as DispIHTMLSpanElement;
end;

class function CoFPHTMLSpanElement.CreateRemote(const MachineName: string): DispIHTMLSpanElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLSpanElement) as DispIHTMLSpanElement;
end;

class function CoFPHTMLTable.Create: DispIHTMLTable;
begin
  Result := CreateComObject(CLASS_FPHTMLTable) as DispIHTMLTable;
end;

class function CoFPHTMLTable.CreateRemote(const MachineName: string): DispIHTMLTable;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLTable) as DispIHTMLTable;
end;

class function CoFPHTMLTableCol.Create: DispIHTMLTableCol;
begin
  Result := CreateComObject(CLASS_FPHTMLTableCol) as DispIHTMLTableCol;
end;

class function CoFPHTMLTableCol.CreateRemote(const MachineName: string): DispIHTMLTableCol;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLTableCol) as DispIHTMLTableCol;
end;

class function CoFPHTMLTableSection.Create: DispIHTMLTableSection;
begin
  Result := CreateComObject(CLASS_FPHTMLTableSection) as DispIHTMLTableSection;
end;

class function CoFPHTMLTableSection.CreateRemote(const MachineName: string): DispIHTMLTableSection;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLTableSection) as DispIHTMLTableSection;
end;

class function CoFPHTMLTableRow.Create: DispIHTMLTableRow;
begin
  Result := CreateComObject(CLASS_FPHTMLTableRow) as DispIHTMLTableRow;
end;

class function CoFPHTMLTableRow.CreateRemote(const MachineName: string): DispIHTMLTableRow;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLTableRow) as DispIHTMLTableRow;
end;

class function CoFPHTMLTableCell.Create: DispIHTMLTableCell;
begin
  Result := CreateComObject(CLASS_FPHTMLTableCell) as DispIHTMLTableCell;
end;

class function CoFPHTMLTableCell.CreateRemote(const MachineName: string): DispIHTMLTableCell;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLTableCell) as DispIHTMLTableCell;
end;

class function CoFPHTMLScriptElement.Create: DispIHTMLScriptElement;
begin
  Result := CreateComObject(CLASS_FPHTMLScriptElement) as DispIHTMLScriptElement;
end;

class function CoFPHTMLScriptElement.CreateRemote(const MachineName: string): DispIHTMLScriptElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLScriptElement) as DispIHTMLScriptElement;
end;

class function CoFPHTMLNoShowElement.Create: DispIHTMLNoShowElement;
begin
  Result := CreateComObject(CLASS_FPHTMLNoShowElement) as DispIHTMLNoShowElement;
end;

class function CoFPHTMLNoShowElement.CreateRemote(const MachineName: string): DispIHTMLNoShowElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLNoShowElement) as DispIHTMLNoShowElement;
end;

class function CoFPHTMLObjectElement.Create: DispIHTMLObjectElement;
begin
  Result := CreateComObject(CLASS_FPHTMLObjectElement) as DispIHTMLObjectElement;
end;

class function CoFPHTMLObjectElement.CreateRemote(const MachineName: string): DispIHTMLObjectElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLObjectElement) as DispIHTMLObjectElement;
end;

class function CoFPHTMLFrameBase.Create: DispIHTMLFrameBase;
begin
  Result := CreateComObject(CLASS_FPHTMLFrameBase) as DispIHTMLFrameBase;
end;

class function CoFPHTMLFrameBase.CreateRemote(const MachineName: string): DispIHTMLFrameBase;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLFrameBase) as DispIHTMLFrameBase;
end;

class function CoFPHTMLFrameElement.Create: DispIHTMLFrameElement;
begin
  Result := CreateComObject(CLASS_FPHTMLFrameElement) as DispIHTMLFrameElement;
end;

class function CoFPHTMLFrameElement.CreateRemote(const MachineName: string): DispIHTMLFrameElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLFrameElement) as DispIHTMLFrameElement;
end;

class function CoFPHTMLIFrame.Create: DispIHTMLIFrameElement;
begin
  Result := CreateComObject(CLASS_FPHTMLIFrame) as DispIHTMLIFrameElement;
end;

class function CoFPHTMLIFrame.CreateRemote(const MachineName: string): DispIHTMLIFrameElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLIFrame) as DispIHTMLIFrameElement;
end;

class function CoFPHTMLDivPosition.Create: DispIHTMLDivPosition;
begin
  Result := CreateComObject(CLASS_FPHTMLDivPosition) as DispIHTMLDivPosition;
end;

class function CoFPHTMLDivPosition.CreateRemote(const MachineName: string): DispIHTMLDivPosition;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLDivPosition) as DispIHTMLDivPosition;
end;

class function CoFPHTMLFieldSetElement.Create: DispIHTMLFieldSetElement;
begin
  Result := CreateComObject(CLASS_FPHTMLFieldSetElement) as DispIHTMLFieldSetElement;
end;

class function CoFPHTMLFieldSetElement.CreateRemote(const MachineName: string): DispIHTMLFieldSetElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLFieldSetElement) as DispIHTMLFieldSetElement;
end;

class function CoFPHTMLLegendElement.Create: DispIHTMLLegendElement;
begin
  Result := CreateComObject(CLASS_FPHTMLLegendElement) as DispIHTMLLegendElement;
end;

class function CoFPHTMLLegendElement.CreateRemote(const MachineName: string): DispIHTMLLegendElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLLegendElement) as DispIHTMLLegendElement;
end;

class function CoFPHTMLSpanFlow.Create: DispIHTMLSpanFlow;
begin
  Result := CreateComObject(CLASS_FPHTMLSpanFlow) as DispIHTMLSpanFlow;
end;

class function CoFPHTMLSpanFlow.CreateRemote(const MachineName: string): DispIHTMLSpanFlow;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLSpanFlow) as DispIHTMLSpanFlow;
end;

class function CoFPHTMLFrameSetSite.Create: DispIHTMLFrameSetElement;
begin
  Result := CreateComObject(CLASS_FPHTMLFrameSetSite) as DispIHTMLFrameSetElement;
end;

class function CoFPHTMLFrameSetSite.CreateRemote(const MachineName: string): DispIHTMLFrameSetElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLFrameSetSite) as DispIHTMLFrameSetElement;
end;

class function CoFPHTMLBGsound.Create: DispIHTMLBGsound;
begin
  Result := CreateComObject(CLASS_FPHTMLBGsound) as DispIHTMLBGsound;
end;

class function CoFPHTMLBGsound.CreateRemote(const MachineName: string): DispIHTMLBGsound;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLBGsound) as DispIHTMLBGsound;
end;

class function CoFPHTMLStyleElement.Create: DispIHTMLStyleElement;
begin
  Result := CreateComObject(CLASS_FPHTMLStyleElement) as DispIHTMLStyleElement;
end;

class function CoFPHTMLStyleElement.CreateRemote(const MachineName: string): DispIHTMLStyleElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLStyleElement) as DispIHTMLStyleElement;
end;

class function CoFPHTMLStyleFontFace.Create: IHTMLStyleFontFace;
begin
  Result := CreateComObject(CLASS_FPHTMLStyleFontFace) as IHTMLStyleFontFace;
end;

class function CoFPHTMLStyleFontFace.CreateRemote(const MachineName: string): IHTMLStyleFontFace;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLStyleFontFace) as IHTMLStyleFontFace;
end;

class function CoFPHTMLDialog.Create: IHTMLDialog;
begin
  Result := CreateComObject(CLASS_FPHTMLDialog) as IHTMLDialog;
end;

class function CoFPHTMLDialog.CreateRemote(const MachineName: string): IHTMLDialog;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLDialog) as IHTMLDialog;
end;

class function CoFPHTMLFrontPageBotElement.Create: DispIHTMLFrontPageBotElement;
begin
  Result := CreateComObject(CLASS_FPHTMLFrontPageBotElement) as DispIHTMLFrontPageBotElement;
end;

class function CoFPHTMLFrontPageBotElement.CreateRemote(const MachineName: string): DispIHTMLFrontPageBotElement;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_FPHTMLFrontPageBotElement) as DispIHTMLFrontPageBotElement;
end;

end.
