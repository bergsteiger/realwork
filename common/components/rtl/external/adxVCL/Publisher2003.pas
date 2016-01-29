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

unit Publisher2003;

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
// File generated on 10/13/2004 12:20:32 PM from Type Library described below.

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
// Type Lib: D:\Program Files\Microsoft Office\OFFICE11\MSPUB.TLB (1)
// IID\LCID: {0002123C-0000-0000-C000-000000000046}\0
// Helpfile: D:\Program Files\Microsoft Office\OFFICE11\vbapb10.chm
// DepndLst:
//   (1) v2.0 stdole, (D:\WINDOWS\system32\stdole2.tlb)
//   (2) v2.3 Office, (D:\Program Files\Common Files\Microsoft Shared\OFFICE11\MSO.DLL)
//   (3) v4.0 StdVCL, (D:\WINDOWS\system32\stdvcl40.dll)
// Errors:
//   Hint: TypeInfo 'Label' changed to 'Label_'
//   Hint: Parameter 'To' of _Document.PrintOut changed to 'To_'
//   Hint: Parameter 'Type' of _Application.FileDialog changed to 'Type_'
//   Hint: Parameter 'Object' of _Application.IsValidObject changed to 'Object_'
//   Hint: Member 'Type' of 'ColorFormat' changed to 'Type_'
//   Hint: Parameter 'Type' of ColorFormat.Type changed to 'Type_'
//   Hint: Member 'Type' of 'Selection' changed to 'Type_'
//   Hint: Parameter 'Type' of Selection.Type changed to 'Type_'
//   Hint: Parameter 'Unit' of ShapeRange.GetLeft changed to 'Unit_'
//   Hint: Parameter 'Unit' of ShapeRange.GetTop changed to 'Unit_'
//   Hint: Parameter 'Unit' of ShapeRange.GetHeight changed to 'Unit_'
//   Hint: Parameter 'Unit' of ShapeRange.GetWidth changed to 'Unit_'
//   Hint: Member 'Type' of 'ShapeRange' changed to 'Type_'
//   Hint: Parameter 'Type' of ShapeRange.Type changed to 'Type_'
//   Hint: Parameter 'Unit' of Shape.GetLeft changed to 'Unit_'
//   Hint: Parameter 'Unit' of Shape.GetTop changed to 'Unit_'
//   Hint: Parameter 'Unit' of Shape.GetHeight changed to 'Unit_'
//   Hint: Parameter 'Unit' of Shape.GetWidth changed to 'Unit_'
//   Hint: Member 'Type' of 'Shape' changed to 'Type_'
//   Hint: Parameter 'Type' of Shape.Type changed to 'Type_'
//   Hint: Member 'Type' of 'CalloutFormat' changed to 'Type_'
//   Hint: Parameter 'Type' of CalloutFormat.Type changed to 'Type_'
//   Hint: Parameter 'Type' of CalloutFormat.Type changed to 'Type_'
//   Hint: Member 'Type' of 'ConnectorFormat' changed to 'Type_'
//   Hint: Parameter 'Type' of ConnectorFormat.Type changed to 'Type_'
//   Hint: Parameter 'Type' of ConnectorFormat.Type changed to 'Type_'
//   Hint: Member 'Type' of 'FillFormat' changed to 'Type_'
//   Hint: Parameter 'Type' of FillFormat.Type changed to 'Type_'
//   Hint: Member 'Type' of 'ShadowFormat' changed to 'Type_'
//   Hint: Parameter 'Type' of ShadowFormat.Type changed to 'Type_'
//   Hint: Parameter 'Type' of ShadowFormat.Type changed to 'Type_'
//   Hint: Parameter 'Unit' of TextRange.Expand changed to 'Unit_'
//   Hint: Parameter 'Unit' of TextRange.Move changed to 'Unit_'
//   Hint: Parameter 'Unit' of TextRange.MoveStart changed to 'Unit_'
//   Hint: Parameter 'Unit' of TextRange.MoveEnd changed to 'Unit_'
//   Hint: Member 'End' of 'TextRange' changed to 'End_'
//   Hint: Parameter 'End' of TextRange.End changed to 'End_'
//   Hint: Parameter 'End' of TextRange.End changed to 'End_'
//   Hint: Parameter 'Type' of TextRange.InsertPageNumber changed to 'Type_'
//   Hint: Parameter 'Raise' of Fields.AddPhoneticGuide changed to 'Raise_'
//   Hint: Member 'Type' of 'Field' changed to 'Type_'
//   Hint: Parameter 'Type' of Field.Type changed to 'Type_'
//   Hint: Member 'Raise' of 'PhoneticGuide' changed to 'Raise_'
//   Hint: Parameter 'Raise' of PhoneticGuide.Raise changed to 'Raise_'
//   Hint: Member 'Type' of 'Story' changed to 'Type_'
//   Hint: Parameter 'Type' of Story.Type changed to 'Type_'
//   Hint: Parameter 'Type' of Hyperlink.TargetType changed to 'Type_'
//   Hint: Member 'Type' of 'Hyperlink' changed to 'Type_'
//   Hint: Parameter 'Type' of Hyperlink.Type changed to 'Type_'
//   Hint: Parameter 'var' of InlineShapes.Item changed to 'var_'
//   Hint: Member 'Object' of 'OLEFormat' changed to 'Object_'
//   Hint: Parameter 'Object' of OLEFormat.Object changed to 'Object_'
//   Hint: Parameter 'Type' of WebCommandButton.ButtonType changed to 'Type_'
//   Hint: Parameter 'Type' of WebCommandButton.ButtonType changed to 'Type_'
//   Hint: Parameter 'Label' of WebListBox.ReturnDataLabel changed to 'Label_'
//   Hint: Parameter 'Label' of WebListBox.ReturnDataLabel changed to 'Label_'
//   Hint: Parameter 'Label' of WebTextBox.ReturnDataLabel changed to 'Label_'
//   Hint: Parameter 'Label' of WebTextBox.ReturnDataLabel changed to 'Label_'
//   Hint: Parameter 'Label' of WebOptionButton.ReturnDataLabel changed to 'Label_'
//   Hint: Parameter 'Label' of WebOptionButton.ReturnDataLabel changed to 'Label_'
//   Hint: Parameter 'Label' of WebCheckBox.ReturnDataLabel changed to 'Label_'
//   Hint: Parameter 'Label' of WebCheckBox.ReturnDataLabel changed to 'Label_'
//   Hint: Member 'Type' of 'WrapFormat' changed to 'Type_'
//   Hint: Member 'Set' of 'BorderArtFormat' changed to 'Set_'
//   Hint: Parameter 'Type' of Page.PageType changed to 'Type_'
//   Hint: Parameter 'Type' of Shapes.AddCallout changed to 'Type_'
//   Hint: Parameter 'Type' of Shapes.AddConnector changed to 'Type_'
//   Hint: Parameter 'Label' of Shapes.AddLabel changed to 'Label_'
//   Hint: Parameter 'Type' of Shapes.AddShape changed to 'Type_'
//   Hint: Parameter 'Type' of Shapes.AddWebControl changed to 'Type_'
//   Hint: Parameter 'Type' of RulerGuides.Add changed to 'Type_'
//   Hint: Member 'Type' of 'RulerGuide' changed to 'Type_'
//   Hint: Member 'Type' of 'MailMergeDataSource' changed to 'Type_'
//   Hint: Member 'Label' of 'PageSetup' changed to 'Label_'
//   Hint: Enum Member 'PbShowDialog' of 'PbShowDialog' changed to 'PbShowDialog_'
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
interface

{$I adxDefs.inc}
                                                    
uses Windows, ActiveX, Classes, Graphics, OleServer, Office2000,
  {$IFNDEF ADX_VCL5}
  Variants,
  {$ENDIF}
  StdVCL;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  PublisherMajorVersion = 2;
  PublisherMinorVersion = 0;

  LIBID_Publisher: TGUID = '{0002123C-0000-0000-C000-000000000046}';

  IID_Documents: TGUID = '{12F564D6-BC5F-410E-ACD1-7D3D47F06FFA}';
  IID__Document: TGUID = '{00021242-0000-0000-C000-000000000046}';
  DIID_DocumentEvents: TGUID = '{00021244-0000-0000-C000-000000000046}';
  IID_Window: TGUID = '{39051BAB-5CA7-11D3-B65F-00C04F8EF32D}';
  IID__Application: TGUID = '{0002123E-0000-0000-C000-000000000046}';
  DIID_ApplicationEvents: TGUID = '{00021240-0000-0000-C000-000000000046}';
  IID_ColorSchemes: TGUID = '{821941D9-F6DD-11D3-907C-00C04F799E3F}';
  IID_ColorScheme: TGUID = '{821941D8-F6DD-11D3-907C-00C04F799E3F}';
  IID_ColorFormat: TGUID = '{00021264-0000-0000-C000-000000000046}';
  IID_ColorCMYK: TGUID = '{3F53F6F6-EBC3-11D3-907C-00C04F799E3F}';
  IID_Options: TGUID = '{718713F2-BEF1-11D3-9077-00C04F799E3F}';
  IID_Selection: TGUID = '{8B9CAA7B-DEFA-11D2-8C78-00C04F8EF340}';
  IID_ShapeRange: TGUID = '{00021260-0000-0000-C000-000000000046}';
  IID_Shape: TGUID = '{00021237-0000-0000-C000-000000000046}';
  IID_Adjustments: TGUID = '{00021262-0000-0000-C000-000000000046}';
  IID_CalloutFormat: TGUID = '{00021263-0000-0000-C000-000000000046}';
  IID_ConnectorFormat: TGUID = '{00021265-0000-0000-C000-000000000046}';
  IID_FillFormat: TGUID = '{00021261-0000-0000-C000-000000000046}';
  IID_GroupShapes: TGUID = '{00021267-0000-0000-C000-000000000046}';
  IID_LineFormat: TGUID = '{00021268-0000-0000-C000-000000000046}';
  IID_ShapeNodes: TGUID = '{00021269-0000-0000-C000-000000000046}';
  IID_ShapeNode: TGUID = '{0002126A-0000-0000-C000-000000000046}';
  IID_PictureFormat: TGUID = '{0002126B-0000-0000-C000-000000000046}';
  IID_ShadowFormat: TGUID = '{0002126C-0000-0000-C000-000000000046}';
  IID_TextEffectFormat: TGUID = '{0002126D-0000-0000-C000-000000000046}';
  IID_TextFrame: TGUID = '{0002126E-0000-0000-C000-000000000046}';
  IID_TextRange: TGUID = '{0002124A-0000-0000-C000-000000000046}';
  IID_Font: TGUID = '{0002124E-0000-0000-C000-000000000046}';
  IID_ParagraphFormat: TGUID = '{BD876261-4399-11D3-B65B-00C04F8EF32D}';
  IID_TabStops: TGUID = '{37B3B0B0-44B5-11D3-B65B-00C04F8EF32D}';
  IID_TabStop: TGUID = '{37B3B0B1-44B5-11D3-B65B-00C04F8EF32D}';
  IID_Fields: TGUID = '{7742D36C-49D5-11D3-B65C-00C04F8EF32D}';
  IID_Field: TGUID = '{7742D36B-49D5-11D3-B65C-00C04F8EF32D}';
  IID_PhoneticGuide: TGUID = '{7742D36D-49D5-11D3-B65C-00C04F8EF32D}';
  IID_Story: TGUID = '{37B3B0B2-44B5-11D3-B65B-00C04F8EF32D}';
  IID_Table: TGUID = '{37FAE3EA-D9B4-11D3-907A-00C04F799E3F}';
  IID_Columns: TGUID = '{37FAE3EF-D9B4-11D3-907A-00C04F799E3F}';
  IID_Column: TGUID = '{37FAE3ED-D9B4-11D3-907A-00C04F799E3F}';
  IID_CellRange: TGUID = '{37FAE3F1-D9B4-11D3-907A-00C04F799E3F}';
  IID_Cell: TGUID = '{37FAE3F0-D9B4-11D3-907A-00C04F799E3F}';
  IID_CellBorder: TGUID = '{702CA50E-E315-11D3-907C-00C04F799E3F}';
  IID_Rows: TGUID = '{37FAE3EC-D9B4-11D3-907A-00C04F799E3F}';
  IID_Row: TGUID = '{37FAE3EB-D9B4-11D3-907A-00C04F799E3F}';
  IID_DropCap: TGUID = '{37B3B0AF-44B5-11D3-B65B-00C04F8EF32D}';
  IID_Hyperlinks: TGUID = '{72E5D393-FC3B-4A38-A9DA-AA30370E66F9}';
  IID_Hyperlink: TGUID = '{2C2B7CD3-F864-11D2-8C7A-00C04F8EF340}';
  IID_FindReplace: TGUID = '{382D6521-2995-4173-B785-9A6BD2F64239}';
  IID_InlineShapes: TGUID = '{98091C49-9841-4D1A-BE2D-8FFD9C7702CC}';
  IID_ThreeDFormat: TGUID = '{0002126F-0000-0000-C000-000000000046}';
  IID_LinkFormat: TGUID = '{2C2B7CD4-F864-11D2-8C7A-00C04F8EF340}';
  IID_OLEFormat: TGUID = '{2C2B7CD5-F864-11D2-8C7A-00C04F8EF340}';
  IID_ObjectVerbs: TGUID = '{BBA7E70F-3FD3-11D3-B65A-00C04F8EF32D}';
  IID_Tags: TGUID = '{2C2B7CD7-F864-11D2-8C7A-00C04F8EF340}';
  IID_Tag: TGUID = '{DA45FDD2-4B16-4E7C-A1E3-F1ADD18DD65A}';
  IID_WebCommandButton: TGUID = '{E792405F-8668-11D3-9058-00C04F799E3F}';
  IID_WebHiddenFields: TGUID = '{E7924060-8668-11D3-9058-00C04F799E3F}';
  IID_WebListBox: TGUID = '{E7924061-8668-11D3-9058-00C04F799E3F}';
  IID_WebListBoxItems: TGUID = '{E7924062-8668-11D3-9058-00C04F799E3F}';
  IID_WebTextBox: TGUID = '{E7924063-8668-11D3-9058-00C04F799E3F}';
  IID_WebOptionButton: TGUID = '{E7924064-8668-11D3-9058-00C04F799E3F}';
  IID_WebCheckBox: TGUID = '{E7924065-8668-11D3-9058-00C04F799E3F}';
  IID_Wizard: TGUID = '{286A9093-BD9E-11D3-B675-00C04F8EF32D}';
  IID_WizardProperties: TGUID = '{286A9094-BD9E-11D3-B675-00C04F8EF32D}';
  IID_WizardProperty: TGUID = '{286A9095-BD9E-11D3-B675-00C04F8EF32D}';
  IID_WizardValues: TGUID = '{286A9096-BD9E-11D3-B675-00C04F8EF32D}';
  IID_WizardValue: TGUID = '{286A9097-BD9E-11D3-B675-00C04F8EF32D}';
  IID_WrapFormat: TGUID = '{CF7E7E58-E0D9-11D3-A8F1-00C04F8EF4EA}';
  IID_BorderArtFormat: TGUID = '{D70F454F-0669-42A8-B8E6-EFF0686490AE}';
  IID_CatalogMergeShapes: TGUID = '{7ADEC766-2AE9-44FF-9EEC-B85F9E1C2D82}';
  IID_WebOptions: TGUID = '{726060F6-2A2C-4E46-AC8A-7CEE29E11FC3}';
  CLASS_Application: TGUID = '{0002123D-0000-0000-C000-000000000046}';
  IID_IApplicationEvents: TGUID = '{0002123F-0000-0000-C000-000000000046}';
  IID_View: TGUID = '{39051BAC-5CA7-11D3-B65F-00C04F8EF32D}';
  IID_Page: TGUID = '{00021246-0000-0000-C000-000000000046}';
  IID_Shapes: TGUID = '{00021235-0000-0000-C000-000000000046}';
  IID_FreeformBuilder: TGUID = '{00021266-0000-0000-C000-000000000046}';
  IID_RulerGuides: TGUID = '{8343FF5B-B266-11D3-906D-00C04F799E3F}';
  IID_RulerGuide: TGUID = '{8343FF5A-B266-11D3-906D-00C04F799E3F}';
  IID_ReaderSpread: TGUID = '{8E884314-7A00-48E8-8E4E-BE709AA88045}';
  IID_HeaderFooter: TGUID = '{36CB1396-5D9C-4407-AF92-90EF8A8D0C48}';
  IID_PageBackground: TGUID = '{AC9B8364-6173-4E98-9F25-E9905E85A3F5}';
  IID_WebPageOptions: TGUID = '{3F546B70-3B09-4692-8B93-E9C7ABCCCE89}';
  IID_LayoutGuides: TGUID = '{34985E9C-CE08-11D3-9079-00C04F799E3F}';
  IID_MailMerge: TGUID = '{4FA84469-DD6A-42D4-979F-ED62ABBDF44D}';
  IID_MailMergeDataSource: TGUID = '{1A0CD25D-4080-4A83-9DD9-02075743E446}';
  IID_MailMergeDataFields: TGUID = '{9DF97ACB-FE7B-47E9-A644-62F8F663C5D4}';
  IID_MailMergeDataField: TGUID = '{0BCCE76B-8012-43CA-A80D-04784985D7F4}';
  IID_MailMergeFilters: TGUID = '{000C1534-0000-0000-C000-000000000046}';
  IID_MailMergeMappedDataFields: TGUID = '{F4B0606E-B5D2-4A11-B29F-22D47375651D}';
  IID_MailMergeMappedDataField: TGUID = '{1D236C54-12E2-44FA-8679-223E3F747D8B}';
  IID_MasterPages: TGUID = '{D3554585-5123-11D3-B65E-00C04F8EF32D}';
  IID_Pages: TGUID = '{00021248-0000-0000-C000-000000000046}';
  IID_PageSetup: TGUID = '{7BE67D19-3411-4609-B5B0-737515B866DA}';
  IID_Label_: TGUID = '{64480E73-E204-44D6-A460-D3315929C81C}';
  IID_Labels: TGUID = '{C5C382C6-C556-44B9-8949-4534045B40EA}';
  IID_Plates: TGUID = '{DE78CEB8-FEBB-11D3-907D-00C04F799E3F}';
  IID_Plate: TGUID = '{DE78CEB9-FEBB-11D3-907D-00C04F799E3F}';
  IID_ScratchArea: TGUID = '{34985E9D-CE08-11D3-9079-00C04F799E3F}';
  IID_Stories: TGUID = '{37B3B0B3-44B5-11D3-B65B-00C04F8EF32D}';
  IID_TextStyles: TGUID = '{37B3B0B5-44B5-11D3-B65B-00C04F8EF32D}';
  IID_TextStyle: TGUID = '{37B3B0B4-44B5-11D3-B65B-00C04F8EF32D}';
  IID_AdvancedPrintOptions: TGUID = '{BEAB0299-1432-45D0-897F-4B8882BC50F4}';
  IID_PrintableRect: TGUID = '{F5F4C30B-5D7F-45B1-A2FF-FB7A95A5C1E0}';
  IID_PrintablePlates: TGUID = '{BE42D3DC-858F-4894-A8A5-D01EBD67D3ED}';
  IID_PrintablePlate: TGUID = '{BA68CB7C-BE43-4EED-9DAF-E9F88E1254CA}';
  IID_BorderArts: TGUID = '{761ED420-B146-411C-AA6D-C5DC063C1B1B}';
  IID_BorderArt: TGUID = '{BDFD66B2-9399-4508-92DF-A9067B912ADF}';
  IID_Sections: TGUID = '{00ABD2DD-7948-48A8-B7C8-589914EED788}';
  IID_Section: TGUID = '{F26BFA6F-048F-4E86-87B3-6587DF725CCF}';
  IID_WebNavigationBarSets: TGUID = '{A05DB779-1FC2-4288-A150-939A955696C4}';
  IID_WebNavigationBarSet: TGUID = '{33D49099-5E91-4A79-9281-7F5DDA3A2179}';
  IID_WebNavigationBarHyperlinks: TGUID = '{87712C53-E1A1-4BA2-A129-93E78764308A}';
  IID_ColorsInUse: TGUID = '{BA716167-A04A-42F3-BEC4-D433F2A7F4EE}';
  CLASS_Document: TGUID = '{09FD2EFF-5669-11D3-B65F-00C04F8EF32D}';
  IID_IDocumentEvents: TGUID = '{00021243-0000-0000-C000-000000000046}';
  IID_MailMergeFilterCriterion: TGUID = '{000C1533-0000-0000-C000-000000000046}';
  IID_ModalBrowser: TGUID = '{FAC601B6-4A1A-4F69-9ABD-4B4DA640B2DB}';
  DIID_ICagNotifySink: TGUID = '{00021293-0000-0000-C000-000000000046}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum PbSchemeColorIndex
type
  PbSchemeColorIndex = TOleEnum;
const
  pbSchemeColorNone = $00000000;
  pbSchemeColorMain = $00000001;
  pbSchemeColorAccent1 = $00000002;
  pbSchemeColorAccent2 = $00000003;
  pbSchemeColorAccent3 = $00000004;
  pbSchemeColorAccent4 = $00000005;
  pbSchemeColorHyperlink = $00000006;
  pbSchemeColorFollowedHyperlink = $00000007;
  pbSchemeColorAccent5 = $00000008;

// Constants for enum PbColorType
type
  PbColorType = TOleEnum;
const
  pbColorTypeMixed = $FFFFFFFE;
  pbColorTypeRGB = $00000001;
  pbColorTypeScheme = $00000002;
  pbColorTypeCMYK = $00000003;
  pbColorTypeCMS = $00000004;
  pbColorTypeInk = $00000005;

// Constants for enum PbPlacementType
type
  PbPlacementType = TOleEnum;
const
  pbPlacementLeft = $00000001;
  pbPlacementRight = $00000002;
  pbPlacementCenter = $00000003;

// Constants for enum PbOrientationType
type
  PbOrientationType = TOleEnum;
const
  pbOrientationPortrait = $00000001;
  pbOrientationLandscape = $00000002;

// Constants for enum PbUnitType
type
  PbUnitType = TOleEnum;
const
  pbUnitInch = $00000000;
  pbUnitCM = $00000001;
  pbUnitPica = $00000002;
  pbUnitPoint = $00000003;
  pbUnitEmu = $00000004;
  pbUnitTwip = $00000005;
  pbUnitFeet = $00000006;
  pbUnitMeter = $00000007;
  pbUnitKyu = $00000008;
  pbUnitHa = $00000009;
  pbUnitPixel = $0000000A;

// Constants for enum PbDirectionType
type
  PbDirectionType = TOleEnum;
const
  pbDirectionLeftToRight = $00000001;
  pbDirectionRightToLeft = $00000002;

// Constants for enum PbSelectionType
type
  PbSelectionType = TOleEnum;
const
  pbSelectionNone = $00000000;
  pbSelectionShape = $00000001;
  pbSelectionText = $00000002;
  pbSelectionTableCells = $00000003;
  pbSelectionShapeSubSelection = $00000004;

// Constants for enum PbVerticalPictureLocking
type
  PbVerticalPictureLocking = TOleEnum;
const
  pbVerticalLockingNone = $00000000;
  pbVerticalLockingTop = $00000001;
  pbVerticalLockingBottom = $00000002;
  pbVerticalLockingStretch = $00000003;

// Constants for enum PbHorizontalPictureLocking
type
  PbHorizontalPictureLocking = TOleEnum;
const
  pbHorizontalLockingNone = $00000000;
  pbHorizontalLockingLeft = $00000001;
  pbHorizontalLockingRight = $00000002;
  pbHorizontalLockingStretch = $00000003;

// Constants for enum PbColorModel
type
  PbColorModel = TOleEnum;
const
  pbColorModelRGB = $00000001;
  pbColorModelCMYK = $00000002;
  pbColorModelGreyScale = $00000003;
  pbColorModelUnknown = $00000004;

// Constants for enum PbImageFormat
type
  PbImageFormat = TOleEnum;
const
  pbImageFormatUNKNOWN = $00000001;
  pbImageFormatEMF = $00000002;
  pbImageFormatWMF = $00000003;
  pbImageFormatPICT = $00000004;
  pbImageFormatJPEG = $00000005;
  pbImageFormatPNG = $00000006;
  pbImageFormatDIB = $00000007;
  pbImageFormatGIF = $00000008;
  pbImageFormatTIFF = $00000009;
  pbImageFormatCMYKJPEG = $0000000A;

// Constants for enum PbPictureInsertAs
type
  PbPictureInsertAs = TOleEnum;
const
  pbPictureInsertAsEmbedded = $00000001;
  pbPictureInsertAsLinked = $00000002;
  pbPictureInsertAsOriginalState = $00000003;

// Constants for enum PbLinkedFileStatus
type
  PbLinkedFileStatus = TOleEnum;
const
  pbLinkedFileOK = $00000001;
  pbLinkedFileMissing = $00000002;
  pbLinkedFileModified = $00000003;

// Constants for enum PbTrackingPresetType
type
  PbTrackingPresetType = TOleEnum;
const
  pbTrackingMixed = $FFFFFFFE;
  pbTrackingCustom = $FFFFFFFF;
  pbTrackingVeryLoose = $00000000;
  pbTrackingLoose = $00000001;
  pbTrackingNormal = $00000002;
  pbTrackingTight = $00000003;
  pbTrackingVeryTight = $00000004;

// Constants for enum PbUnderlineType
type
  PbUnderlineType = TOleEnum;
const
  pbUnderlineMixed = $FFFFFFFF;
  pbUnderlineNone = $00000000;
  pbUnderlineSingle = $00000001;
  pbUnderlineWordsOnly = $00000002;
  pbUnderlineDouble = $00000003;
  pbUnderlineDotted = $00000004;
  pbUnderlineThick = $00000005;
  pbUnderlineDash = $00000006;
  pbUnderlineDotDash = $00000007;
  pbUnderlineDotDotDash = $00000008;
  pbUnderlineWavy = $00000009;
  pbUnderlineWavyHeavy = $0000000A;
  pbUnderlineDotHeavy = $0000000B;
  pbUnderlineDashHeavy = $0000000C;
  pbUnderlineDotDashHeavy = $0000000D;
  pbUnderlineDotDotDashHeavy = $0000000E;
  pbUnderlineDashLong = $0000000F;
  pbUnderlineDashLongHeavy = $00000010;
  pbUnderlineWavyDouble = $00000011;

// Constants for enum PbFontScriptType
type
  PbFontScriptType = TOleEnum;
const
  pbFontScriptMixed = $FFFFFFFE;
  pbFontScriptDefault = $00000000;
  pbFontScriptAsciiLatin = $00000001;
  pbFontScriptLatin = $00000002;
  pbFontScriptGreek = $00000003;
  pbFontScriptCyrillic = $00000004;
  pbFontScriptArmenian = $00000005;
  pbFontScriptHebrew = $00000006;
  pbFontScriptArabic = $00000007;
  pbFontScriptDevanagari = $00000008;
  pbFontScriptBengali = $00000009;
  pbFontScriptGurmukhi = $0000000A;
  pbFontScriptGujarati = $0000000B;
  pbFontScriptOriya = $0000000C;
  pbFontScriptTamil = $0000000D;
  pbFontScriptTelugu = $0000000E;
  pbFontScriptKannada = $0000000F;
  pbFontScriptMalayalam = $00000010;
  pbFontScriptThai = $00000011;
  pbFontScriptLao = $00000012;
  pbFontScriptTibetan = $00000013;
  pbFontScriptGeorgian = $00000014;
  pbFontScriptHangul = $00000015;
  pbFontScriptKana = $00000016;
  pbFontScriptBopomofo = $00000017;
  pbFontScriptHan = $00000018;
  pbFontScriptHalfWidthKana = $00000019;
  pbFontScriptEUDC = $0000001A;
  pbFontScriptYi = $0000001B;
  pbFontScriptHanSurrogate = $0000001C;
  pbFontScriptNonHanSurrogate = $0000001D;
  pbFontScriptSyriac = $0000001E;
  pbFontScriptThaana = $0000001F;
  pbFontScriptMyanmar = $00000020;
  pbFontScriptSinhala = $00000021;
  pbFontScriptEthiopic = $00000022;
  pbFontScriptCherokee = $00000023;
  pbFontScriptCanadianAbor = $00000024;
  pbFontScriptOgham = $00000025;
  pbFontScriptRunic = $00000026;
  pbFontScriptKhmer = $00000027;
  pbFontScriptMongolian = $00000028;
  pbFontScriptBraille = $00000029;
  pbFontScriptCurrency = $0000002A;
  pbFontScriptAsciiSym = $0000002B;

// Constants for enum PbCollapseDirection
type
  PbCollapseDirection = TOleEnum;
const
  pbCollapseStart = $00000001;
  pbCollapseEnd = $00000002;

// Constants for enum PbTextUnit
type
  PbTextUnit = TOleEnum;
const
  pbTextUnitCharacter = $00000001;
  pbTextUnitWord = $00000002;
  pbTextUnitSentence = $00000003;
  pbTextUnitParagraph = $00000004;
  pbTextUnitLine = $00000005;
  pbTextUnitStory = $00000006;
  pbTextUnitScreen = $00000007;
  pbTextUnitSection = $00000008;
  pbTextUnitColumn = $00000009;
  pbTextUnitRow = $0000000A;
  pbTextUnitWindow = $0000000B;
  pbTextUnitCell = $0000000C;
  pbTextUnitCharFormat = $0000000D;
  pbTextUnitParaFormat = $0000000E;
  pbTextUnitTable = $0000000F;
  pbTextUnitObject = $00000010;
  pbTextUnitCodePoint = $00000011;

// Constants for enum PbParagraphAlignmentType
type
  PbParagraphAlignmentType = TOleEnum;
const
  pbParagraphAlignmentMixed = $FF676981;
  pbParagraphAlignmentLeft = $00000000;
  pbParagraphAlignmentCenter = $00000001;
  pbParagraphAlignmentRight = $00000002;
  pbParagraphAlignmentInterWord = $00000003;
  pbParagraphAlignmentDistribute = $00000004;
  pbParagraphAlignmentDistributeEastAsia = $00000005;
  pbParagraphAlignmentJustified = $00000006;
  pbParagraphAlignmentInterIdeograph = $00000007;
  pbParagraphAlignmentInterCluster = $00000008;
  pbParagraphAlignmentDistributeAll = $00000009;
  pbParagraphAlignmentDistributeCenterLast = $0000000A;
  pbParagraphAlignmentKashida = $0000000B;

// Constants for enum PbLineSpacingRule
type
  PbLineSpacingRule = TOleEnum;
const
  pbLineSpacingMixed = $FF676981;
  pbLineSpacingSingle = $00000000;
  pbLineSpacing1pt5 = $00000001;
  pbLineSpacingDouble = $00000002;
  pbLineSpacingExactly = $00000004;
  pbLineSpacingMultiple = $00000005;

// Constants for enum PbTabAlignmentType
type
  PbTabAlignmentType = TOleEnum;
const
  pbTabAlignmentLeading = $00000000;
  pbTabAlignmentCenter = $00000001;
  pbTabAlignmentTrailing = $00000002;
  pbTabAlignmentDecimal = $00000003;

// Constants for enum PbTabLeaderType
type
  PbTabLeaderType = TOleEnum;
const
  pbTabLeaderNone = $00000000;
  pbTabLeaderDot = $00000001;
  pbTabLeaderDashes = $00000002;
  pbTabLeaderLine = $00000003;
  pbTabLeaderBullet = $00000005;

// Constants for enum PbTextDirection
type
  PbTextDirection = TOleEnum;
const
  pbTextDirectionMixed = $FF676981;
  pbTextDirectionLeftToRight = $00000001;
  pbTextDirectionRightToLeft = $00000002;

// Constants for enum PbListType
type
  PbListType = TOleEnum;
const
  pbListTypeArabic = $00000000;
  pbListTypeUpperCaseRoman = $00000001;
  pbListTypeLowerCaseRoman = $00000002;
  pbListTypeUpperCaseLetter = $00000003;
  pbListTypeLowerCaseLetter = $00000004;
  pbListTypeOrdinal = $00000005;
  pbListTypeCardinalText = $00000006;
  pbListTypeOrdinalText = $00000007;
  pbListTypeDbNum1 = $0000000A;
  pbListTypeDbNum2 = $0000000B;
  pbListTypeAiueo = $0000000C;
  pbListTypeIroha = $0000000D;
  pbListTypeDbChar = $0000000E;
  pbListTypeDbNum3 = $00000010;
  pbListTypeDbNum4 = $00000011;
  pbListTypeCirclenum = $00000012;
  pbListTypeDAiueo = $00000014;
  pbListTypeDIroha = $00000015;
  pbListTypeArabicLeadingZero = $00000016;
  pbListTypeBullet = $00000017;
  pbListTypeGanada = $00000018;
  pbListTypeChosung = $00000019;
  pbListTypeZodiac1 = $0000001E;
  pbListTypeZodiac2 = $0000001F;
  pbListTypeTpeDbNum2 = $00000022;
  pbListTypeTpeDbNum3 = $00000023;
  pbListTypeChnDbNum2 = $00000026;
  pbListTypeChnDbNum3 = $00000027;
  pbListTypeKorDbNum1 = $00000029;
  pbListTypeKorDbNum2 = $0000002A;
  pbListTypeKorDbNum3 = $0000002B;
  pbListTypeKorDbNum4 = $0000002C;
  pbListTypeHebrew1 = $0000002D;
  pbListTypeArabic1 = $0000002E;
  pbListTypeHebrew2 = $0000002F;
  pbListTypeArabic2 = $00000030;
  pbListTypeHindi1 = $00000031;
  pbListTypeHindi2 = $00000032;
  pbListTypeHindi3 = $00000033;
  pbListTypeHindi4 = $00000034;
  pbListTypeThai1 = $00000035;
  pbListTypeThai2 = $00000036;
  pbListTypeThai3 = $00000037;
  pbListTypeVietnamese1 = $00000038;
  pbListTypeLowerCaseRussian = $0000003A;
  pbListTypeUpperCaseRussian = $0000003B;
  pbListTypeNone = $000000FF;

// Constants for enum PbListSeparator
type
  PbListSeparator = TOleEnum;
const
  pbListSeparatorParenthesis = $00000000;
  pbListSeparatorDoubleParen = $00010000;
  pbListSeparatorPeriod = $00020000;
  pbListSeparatorPlain = $00030000;
  pbListSeparatorSquare = $00040000;
  pbListSeparatorColon = $00050000;
  pbListSeparatorDoubleSquare = $00060000;
  pbListSeparatorDoubleHyphen = $00070000;
  pbListSeparatorWideComma = $00080000;

// Constants for enum PbDateTimeFormat
type
  PbDateTimeFormat = TOleEnum;
const
  pbDateShort = $00000000;
  pbDateLongDay = $00000001;
  pbDateLong = $00000002;
  pbDateShortAlt = $00000003;
  pbDateISO = $00000004;
  pbDateShortMon = $00000005;
  pbDateShortSlash = $00000006;
  pbDateShortAbb = $00000007;
  pbDateEnglish = $00000008;
  pbDateMonthYr = $00000009;
  pbDateMon_Yr = $0000000A;
  pbTimeDatePM = $0000000B;
  pbTimeDateSecPM = $0000000C;
  pbTimePM = $0000000D;
  pbTimeSecPM = $0000000E;
  pbTime24 = $0000000F;
  pbTimeSec24 = $00000010;
  pbDateTimeEastAsia1 = $00000011;
  pbDateTimeEastAsia2 = $00000012;
  pbDateTimeEastAsia3 = $00000013;
  pbDateTimeEastAsia4 = $00000014;
  pbDateTimeEastAsia5 = $00000015;

// Constants for enum PbCalendarType
type
  PbCalendarType = TOleEnum;
const
  pbCalendarTypeWestern = $00000000;
  pbCalendarTypeArabicHijri = $00000001;
  pbCalendarTypeHebrewLunar = $00000002;
  pbCalendarTypeChineseNational = $00000003;
  pbCalendarTypeJapaneseEmperor = $00000004;
  pbCalendarTypeThaiBuddhist = $00000005;
  pbCalendarTypeKoreanDanki = $00000006;
  pbCalendarTypeSakaEra = $00000007;
  pbCalendarTypeTranslitEnglish = $00000008;
  pbCalendarTypeTranslitFrench = $00000009;

// Constants for enum PbFieldType
type
  PbFieldType = TOleEnum;
const
  pbFieldNone = $00000000;
  pbFieldPageNumber = $00000001;
  pbFieldPageNumberNext = $00000002;
  pbFieldPageNumberPrev = $00000003;
  pbFieldDateTime = $00000004;
  pbFieldMailMerge = $00000005;
  pbFieldIHIV = $00000006;
  pbFieldPhoneticGuide = $00000007;
  pbFieldWizardSampleText = $00000008;
  pbFieldHyperlinkURL = $00000009;
  pbFieldHyperlinkRelativePage = $0000000A;
  pbFieldHyperlinkAbsolutePage = $0000000B;
  pbFieldHyperlinkEmail = $0000000C;
  pbFieldHyperlinkFile = $0000000D;

// Constants for enum PbPhoneticGuideAlignmentType
type
  PbPhoneticGuideAlignmentType = TOleEnum;
const
  pbPhoneticGuideAlignmentDefault = $00000000;
  pbPhoneticGuideAlignmentZeroOneZero = $00000001;
  pbPhoneticGuideAlignmentOneTwoOne = $00000002;
  pbPhoneticGuideAlignmentCenter = $00000003;
  pbPhoneticGuideAlignmentLeft = $00000004;
  pbPhoneticGuideAlignmentRight = $00000005;

// Constants for enum PbCellDiagonalType
type
  PbCellDiagonalType = TOleEnum;
const
  pbTableCellDiagonalMixed = $FFFFFFFE;
  pbTableCellDiagonalNone = $00000000;
  pbTableCellDiagonalUp = $00000001;
  pbTableCellDiagonalDown = $00000002;

// Constants for enum PbVerticalTextAlignmentType
type
  PbVerticalTextAlignmentType = TOleEnum;
const
  pbVerticalTextAlignmentTop = $00000000;
  pbVerticalTextAlignmentCenter = $00000001;
  pbVerticalTextAlignmentBottom = $00000002;

// Constants for enum PbTextOrientation
type
  PbTextOrientation = TOleEnum;
const
  pbTextOrientationMixed = $FFFFFFFE;
  pbTextOrientationHorizontal = $00000001;
  pbTextOrientationVerticalEastAsia = $00000002;
  pbTextOrientationRightToLeft = $00000100;

// Constants for enum PbTableDirectionType
type
  PbTableDirectionType = TOleEnum;
const
  pbTableDirectionLeftToRight = $00000001;
  pbTableDirectionRightToLeft = $00000002;

// Constants for enum PbTableAutoFormatType
type
  PbTableAutoFormatType = TOleEnum;
const
  pbTableAutoFormatDefault = $FFFFFFFD;
  pbTableAutoFormatNone = $FFFFFFFE;
  pbTableAutoFormatMixed = $FFFFFFFF;
  pbTableAutoFormatCheckbookRegister = $00000000;
  pbTableAutoFormatList1 = $00000001;
  pbTableAutoFormatList2 = $00000002;
  pbTableAutoFormatList3 = $00000003;
  pbTableAutoFormatList4 = $00000004;
  pbTableAutoFormatList5 = $00000005;
  pbTableAutoFormatList6 = $00000006;
  pbTableAutoFormatList7 = $00000007;
  pbTableAutoFormatListWithTitle1 = $00000008;
  pbTableAutoFormatListWithTitle2 = $00000009;
  pbTableAutoFormatListWithTitle3 = $0000000A;
  pbTableAutoFormatNumbers1 = $0000000B;
  pbTableAutoFormatNumbers2 = $0000000C;
  pbTableAutoFormatNumbers3 = $0000000D;
  pbTableAutoFormatNumbers4 = $0000000E;
  pbTableAutoFormatNumbers5 = $0000000F;
  pbTableAutoFormatNumbers6 = $00000010;
  pbTableAutoFormatTableOfContents1 = $00000011;
  pbTableAutoFormatTableOfContents2 = $00000012;
  pbTableAutoFormatTableOfContents3 = $00000013;
  pbTableAutoFormatCheckerboard = $00000014;

// Constants for enum PbStoryType
type
  PbStoryType = TOleEnum;
const
  pbStoryTable = $00000000;
  pbStoryTextFrame = $00000001;
  pbStoryContinuedFrom = $00000002;
  pbStoryContinuedOn = $00000003;

// Constants for enum PbHlinkTargetType
type
  PbHlinkTargetType = TOleEnum;
const
  pbHlinkTargetTypeNone = $00000000;
  pbHlinkTargetTypeURL = $00000001;
  pbHlinkTargetTypeEmail = $00000002;
  pbHlinkTargetTypeFirstPage = $00000003;
  pbHlinkTargetTypeLastPage = $00000004;
  pbHlinkTargetTypeNextPage = $00000005;
  pbHlinkTargetTypePreviousPage = $00000006;
  pbHlinkTargetTypePageID = $00000007;

// Constants for enum PbPageNumberType
type
  PbPageNumberType = TOleEnum;
const
  pbPageNumberCurrent = $00000001;
  pbPageNumberNextInStory = $00000002;
  pbPageNumberPreviousInStory = $00000003;

// Constants for enum PbReplaceScope
type
  PbReplaceScope = TOleEnum;
const
  pbReplaceScopeNone = $00000000;
  pbReplaceScopeOne = $00000001;
  pbReplaceScopeAll = $00000002;

// Constants for enum PbTextAutoFitType
type
  PbTextAutoFitType = TOleEnum;
const
  pbTextAutoFitNone = $00000000;
  pbTextAutoFitShrinkOnOverflow = $00000001;
  pbTextAutoFitBestFit = $00000002;

// Constants for enum PbShapeType
type
  PbShapeType = TOleEnum;
const
  pbShapeTypeMixed = $FFFFFFFE;
  pbAutoShape = $00000001;
  pbCallout = $00000002;
  pbChart = $00000003;
  pbComment = $00000004;
  pbFreeform = $00000005;
  pbGroup = $00000006;
  pbEmbeddedOLEObject = $00000007;
  pbFormControl = $00000008;
  pbLine = $00000009;
  pbLinkedOLEObject = $0000000A;
  pbLinkedPicture = $0000000B;
  pbOLEControlObject = $0000000C;
  pbPicture = $0000000D;
  pbPlaceholder = $0000000E;
  pbTextEffect = $0000000F;
  pbMedia = $00000010;
  pbTextFrame = $00000011;
  pbTable = $00000012;
  pbWebCheckBox = $00000064;
  pbWebCommandButton = $00000065;
  pbWebListBox = $00000066;
  pbWebMultiLineTextBox = $00000067;
  pbWebOptionButton = $00000068;
  pbWebSingleLineTextBox = $00000069;
  pbWebWebComponent = $0000006A;
  pbWebHTMLFragment = $0000006B;
  pbGroupWizard = $0000006C;
  pbWebHotSpot = $0000006E;
  pbCatalogMergeArea = $0000006F;
  pbWebNavigationBar = $00000070;

// Constants for enum PbWizardTag
type
  PbWizardTag = TOleEnum;
const
  pbWizardTagLogoGroup = $00000005;
  pbWizardTagOrganizationName = $00000007;
  pbWizardTagPersonalName = $00000008;
  pbWizardTagAddress = $0000000A;
  pbWizardTagTagLine = $00000070;
  pbWizardTagPhoneFaxEmail = $00000071;
  pbWizardTagPhoneNumber = $00000072;
  pbWizardTagJobTitle = $00000073;
  pbWizardTagPersonalNameGroup = $00000074;
  pbWizardTagAddressGroup = $00000075;
  pbWizardTagOrganizationNameGroup = $00000076;
  pbWizardTagTagLineGroup = $00000077;
  pbWizardTagPhoneFaxEmailGroup = $00000078;
  pbWizardTagLocation = $000001E8;
  pbWizardTagMapPicture = $000001E9;
  pbWizardTagCustomerMailingAddress = $00000230;
  pbWizardTagHourTimeDateInformation = $000002AC;
  pbWizardTagBusinessDescription = $000002AD;
  pbWizardTagReturnAddressLines = $00000319;
  pbWizardTagStampBoxOutline = $0000031A;
  pbWizardTagStampBox = $00000377;
  pbWizardTagPhotoPlaceholderFrame = $0000046E;
  pbWizardTagPhotePlaceholderText = $0000046F;
  pbWizardTagPublicationDate = $0000053D;
  pbWizardTagTableOfContentsTitle = $0000053E;
  pbWizardTagTableOfContents = $0000053F;
  pbWizardTagNewsletterTitle = $00000540;
  pbWizardTagPageNumber = $00000542;
  pbWizardTagStoryTitle = $00000544;
  pbWizardTagStory = $00000545;
  pbWizardTagStoryGraphicPrimary = $00000546;
  pbWizardTagStoryCaptionPrimary = $00000547;
  pbWizardTagBriefDescriptionSummary = $00000549;
  pbWizardTagLinkedStoryPrimary = $0000054A;
  pbWizardTagLinkedStorySecondary = $0000054B;
  pbWizardTagLinkedStoryTertiary = $0000054C;
  pbWizardTagMainFloatingGraphic = $0000054D;
  pbWizardTagBriefDescriptionGraphic = $0000054F;
  pbWizardTagStoryGraphicSecondary = $00000550;
  pbWizardTagBriefDescriptionCaption = $00000551;
  pbWizardTagFloatingGraphicCaption = $00000552;
  pbWizardTagBriefDescriptionTitle = $00000554;
  pbWizardTagBriefDescriptionSummaryPrimary = $00000555;
  pbWizardTagStoryCaptionSecondary = $0000055D;
  pbWizardTagMasthead = $00000727;
  pbWizardTagMainTitle = $00000728;
  pbWizardTagMainGraphic = $00000729;
  pbWizardTagDate = $0000072B;
  pbWizardTagTime = $0000072C;
  pbWizardTagList = $0000072D;
  pbWizardTagQuickPubHeading = $0000085C;
  pbWizardTagQuickPubMessage = $0000085D;
  pbWizardTagQuickPubPicture = $0000085E;
  pbWizardTagQuickPubContent = $0000085F;
  pbWizardTagEAPostalCodeGroup = $00000866;
  pbWizardTagEAPostalCodeBox = $00000867;
  pbWizardTagEAPostalCodeLine = $00000868;

// Constants for enum PbSubmitDataRetrievalMethodType
type
  PbSubmitDataRetrievalMethodType = TOleEnum;
const
  pbSubmitDataRetrievalSaveOnServer = $00000001;
  pbSubmitDataRetrievalEmail = $00000002;
  pbSubmitDataRetrievalProgram = $00000003;

// Constants for enum PbSubmitDataFormatType
type
  PbSubmitDataFormatType = TOleEnum;
const
  pbSubmitDataFormatHTML = $00000001;
  pbSubmitDataFormatRichText = $00000002;
  pbSubmitDataFormatCSV = $00000003;
  pbSubmitDataFormatTab = $00000004;

// Constants for enum PbCommandButtonType
type
  PbCommandButtonType = TOleEnum;
const
  pbCommandButtonSubmit = $00000001;
  pbCommandButtonReset = $00000002;

// Constants for enum PbWrapType
type
  PbWrapType = TOleEnum;
const
  pbWrapTypeMixed = $FFFFFFFF;
  pbWrapTypeNone = $00000000;
  pbWrapTypeSquare = $00000001;
  pbWrapTypeTight = $00000002;
  pbWrapTypeThrough = $00000003;
  pbWrapTypeTopAndBottom = $00000004;

// Constants for enum PbWrapSideType
type
  PbWrapSideType = TOleEnum;
const
  pbWrapSideMixed = $FFFFFFFF;
  pbWrapSideBoth = $00000000;
  pbWrapSideLeft = $00000001;
  pbWrapSideRight = $00000002;
  pbWrapSideLarger = $00000003;
  pbWrapSideNeither = $00000004;

// Constants for enum PbInlineAlignment
type
  PbInlineAlignment = TOleEnum;
const
  pbInlineAlignmentMixed = $FFFFFFFE;
  pbInlineAlignmentCharacter = $00000000;
  pbInlineAlignmentLeft = $00000001;
  pbInlineAlignmentRight = $00000002;

// Constants for enum PbHelpType
type
  PbHelpType = TOleEnum;
const
  pbHelp = $00000001;
  pbHelpActiveWindow = $00000002;
  pbHelpPSSHelp = $00000003;

// Constants for enum PbWizard
type
  PbWizard = TOleEnum;
const
  pbWizardNone = $00000000;
  pbWizardBusinessCards = $00000003;
  pbWizardLetterheads = $00000006;
  pbWizardEnvelopes = $00000007;
  pbWizardBrochures = $00000008;
  pbWizardNewsletters = $00000009;
  pbWizardPostcards = $0000000A;
  pbWizardAdvertisements = $0000000C;
  pbWizardCalendars = $0000000D;
  pbWizardFlyers = $00000010;
  pbWizardSigns = $00000011;
  pbWizardResumes = $00000012;
  pbWizardLabels = $00000013;
  pbWizardBusinessForms = $00000014;
  pbWizardBanners = $00000015;
  pbWizardOrigami = $00000016;
  pbWizardAirplanes = $00000017;
  pbWizardMenus = $0000003B;
  pbWizardCertificates = $0000003E;
  pbWizardGiftCertificates = $0000003F;
  pbWizardWithComplimentsCards = $00000049;
  pbWizardPrograms = $0000004C;
  pbWizardCatalogs = $000000A1;
  pbWizardQuickPublications = $000000B3;
  pbWizardWordDocument = $000000BD;
  pbWizardJapanesePostcards = $0000004E;
  pbWizardJapaneseGreetingCards = $00000050;
  pbWizardJapaneseInvitations = $00000051;
  pbWizardJapaneseCalendars = $00000052;
  pbWizardJapaneseBusinessCards = $0000005B;
  pbWizardJapaneseBrochures = $0000005C;
  pbWizardJapaneseEnvelopes = $0000005D;
  pbWizardJapaneseFlyers = $0000005E;
  pbWizardJapaneseLetterheads = $0000005F;
  pbWizardJapanesePrograms = $00000073;
  pbWizardJapaneseMenus = $00000074;
  pbWizardJapaneseNewsletters = $00000075;
  pbWizardJapaneseLabels = $00000076;
  pbWizardJapaneseCertificates = $00000077;
  pbWizardJapaneseWebSites = $00000078;
  pbWizardJapaneseBanners = $00000079;
  pbWizardJapaneseGiftCertificates = $0000007A;
  pbWizardJapaneseBusinessForms = $0000007B;
  pbWizardJapaneseSigns = $00000095;
  pbWizardJapaneseOrigami = $000000A3;
  pbWizardJapaneseAirplanes = $000000A4;
  pbWizardJapaneseAdvertisements = $000000A5;
  pbWizardJapaneseCatalogs = $000000B1;
  pbWizardWebSiteHomePage = $00000005;
  pbWizardWebSiteThreePage = $000000C8;
  pbWizardWebSiteProductSales = $000000C9;
  pbWizardWebSiteServices = $000000CA;
  pbWizardWebSiteBlank = $000000CB;
  pbWizardGreetingCard = $00000028;
  pbWizardInvitation = $00000029;
  pbWizardEmailNewsletter = $00000027;
  pbWizardEmailLetter = $0000012C;
  pbWizardEmailSpeakerEvent = $0000012D;
  pbWizardEmailActivityEvent = $0000012E;
  pbWizardEmailProductList = $0000012F;
  pbWizardEmailFeaturedProduct = $00000130;

// Constants for enum PbSaveOptions
type
  PbSaveOptions = TOleEnum;
const
  pbPromptToSaveChanges = $00000001;
  pbSaveChanges = $00000002;
  pbDoNotSaveChanges = $00000003;

// Constants for enum PbWebControlType
type
  PbWebControlType = TOleEnum;
const
  pbWebControlCheckBox = $00000064;
  pbWebControlCommandButton = $00000065;
  pbWebControlListBox = $00000066;
  pbWebControlMultiLineTextBox = $00000067;
  pbWebControlOptionButton = $00000068;
  pbWebControlSingleLineTextBox = $00000069;
  pbWebControlWebComponent = $0000006A;
  pbWebControlHTMLFragment = $0000006B;
  pbWebControlHotSpot = $0000006E;

// Constants for enum PbWizardGroup
type
  PbWizardGroup = TOleEnum;
const
  pbWizardGroupLogo = $00000004;
  pbWizardGroupDots = $00000031;
  pbWizardGroupBoxes = $00000032;
  pbWizardGroupBarbells = $00000034;
  pbWizardGroupCheckerboards = $00000035;
  pbWizardGroupAttentionGetter = $0000003D;
  pbWizardGroupAdvertisements = $00000044;
  pbWizardGroupWebNavigationBars = $0000004B;
  pbWizardGroupCalendars = $0000004D;
  pbWizardGroupReplyForms = $0000004F;
  pbWizardGroupMarquee = $00000096;
  pbWizardGroupAccentBox = $00000097;
  pbWizardGroupPunctuation = $00000098;
  pbWizardGroupLinearAccent = $00000099;
  pbWizardGroupAccessoryBar = $0000009A;
  pbWizardGroupBorders = $0000009B;
  pbWizardGroupEastAsiaZipCode = $000000B5;
  pbWizardGroupCoupon = $0000003C;
  pbWizardGroupMastheads = $00000069;
  pbWizardGroupTableOfContents = $0000006A;
  pbWizardGroupSidebars = $0000006B;
  pbWizardGroupPullQuotes = $0000006C;
  pbWizardGroupPictureCaptions = $0000006D;
  pbWizardGroupPhoneTearoff = $00000042;
  pbWizardGroupWebMastheads = $00000066;
  pbWizardGroupWellPullQuotes = $00000067;
  pbWizardGroupWebSidebars = $00000068;
  pbWizardGroupWebButtonsEmail = $00000085;
  pbWizardGroupWebButtonsHome = $00000086;
  pbWizardGroupWebButtonsLink = $00000088;
  pbWizardGroupJapaneseCalendar = $00000053;
  pbWizardGroupJapaneseAttentionGetters = $00000061;
  pbWizardGroupJapaneseCoupons = $00000063;
  pbWizardGroupJapaneseReplyForms = $00000089;
  pbWizardGroupJapaneseWebMastheads = $0000008A;
  pbWizardGroupJapaneseWebPullQuotes = $0000008B;
  pbWizardGroupJapaneseWebSidebars = $0000008C;
  pbWizardGroupJapaneseMastheads = $0000008D;
  pbWizardGroupJapaneseTableOfContents = $0000008E;
  pbWizardGroupJapaneseSidebars = $0000008F;
  pbWizardGroupJapanesePullQuotes = $00000090;
  pbWizardGroupJapaneseWebNavigationBars = $00000094;
  pbWizardGroupJapaneseMarquees = $000000A7;
  pbWizardGroupJapaneseAccentBox = $000000A8;
  pbWizardGroupJapaneseLinearAccent = $000000AA;
  pbWizardGroupJapaneseAccessoryBar = $000000AB;
  pbWizardGroupJapaneseBorders = $000000AC;
  pbWizardGroupJapaneseWebButtonEmail = $000000B6;
  pbWizardGroupJapaneseWebButtonHome = $000000B7;
  pbWizardGroupJapaneseWebButtonLink = $000000B8;
  pbWizardGroupWebCalendars = $00000023;

// Constants for enum PbPageType
type
  PbPageType = TOleEnum;
const
  pbPageLeftPage = $00000001;
  pbPageRightPage = $00000002;
  pbPageScratchPage = $00000003;
  pbPageMasterPage = $00000004;

// Constants for enum PbRulerGuideType
type
  PbRulerGuideType = TOleEnum;
const
  pbRulerGuideTypeVertical = $00000001;
  pbRulerGuideTypeHorizontal = $00000002;

// Constants for enum PbPictureResolution
type
  PbPictureResolution = TOleEnum;
const
  pbPictureResolutionDefault = $00000000;
  pbPictureResolutionWeb_96dpi = $00000001;
  pbPictureResolutionDesktopPrint_150dpi = $00000002;
  pbPictureResolutionCommercialPrint_300dpi = $00000003;

// Constants for enum PbZoom
type
  PbZoom = TOleEnum;
const
  pbZoomPageWidth = $FFFFFFFF;
  pbZoomWholePage = $FFFFFFFE;
  pbZoomFitSelection = $FFFFFFFD;

// Constants for enum PbWindowState
type
  PbWindowState = TOleEnum;
const
  pbWindowStateMaximize = $00000000;
  pbWindowStateMinimize = $00000001;
  pbWindowStateNormal = $00000002;

// Constants for enum PbColorMode
type
  PbColorMode = TOleEnum;
const
  pbColorModeDesktop = $00000000;
  pbColorModeProcess = $00000001;
  pbColorModeSpot = $00000002;
  pbColorModeBW = $00000003;
  pbColorModeSpotAndProcess = $00000004;

// Constants for enum PbMailMergeDataFieldType
type
  PbMailMergeDataFieldType = TOleEnum;
const
  pbMailMergeDataFieldString = $00000000;
  pbMailMergeDataFieldPicture = $00000001;

// Constants for enum PbMailMergeDestination
type
  PbMailMergeDestination = TOleEnum;
const
  pbSendToPrinter = $00000001;
  pbMergeToNewPublication = $00000002;
  pbMergeToExistingPublication = $00000003;

// Constants for enum PbWizardPageType
type
  PbWizardPageType = TOleEnum;
const
  pbWizardPageTypeNone = $FFFFFFFF;
  pbWizardPageTypeNewsletter3Stories = $00000001;
  pbWizardPageTypeNewsletterCalendar = $00000002;
  pbWizardPageTypeNewsletterOrderForm = $0000000F;
  pbWizardPageTypeNewsletterResponseForm = $00000010;
  pbWizardPageTypeNewsletterSignupForm = $00000011;
  pbWizardPageTypeCatalogOneColumnText = $00000012;
  pbWizardPageTypeCatalogOneColumnTextPicture = $00000013;
  pbWizardPageTypeCatalogTwoColumnsText = $00000014;
  pbWizardPageTypeCatalogTwoColumnsTextPicture = $00000015;
  pbWizardPageTypeCatalogCalendar = $00000016;
  pbWizardPageTypeCatalogTableOfContents = $00000017;
  pbWizardPageTypeCatalogFeaturedItem = $00000018;
  pbWizardPageTypeCatalogTwoItemsAlignedPictures = $00000019;
  pbWizardPageTypeCatalogTwoItemsOffsetPictures = $0000001A;
  pbWizardPageTypeCatalogThreeItemsAlignedPictures = $0000001B;
  pbWizardPageTypeCatalogThreeItemsOffsetPictures = $0000001C;
  pbWizardPageTypeCatalogThreeItemsStackedPictures = $0000001D;
  pbWizardPageTypeCatalogFourItemsAlignedPictures = $0000001E;
  pbWizardPageTypeCatalogFourItemsOffsetPictures = $0000001F;
  pbWizardPageTypeCatalogFourItemsSquaredPictures = $00000020;
  pbWizardPageTypeCatalogEightItemsOneColumn = $00000021;
  pbWizardPageTypeCatalogEightItemsTwoColumns = $00000022;
  pbWizardPageTypeCatalogBlank = $00000023;
  pbWizardPageTypeCatalogForm = $00000024;
  pbWizardPageTypeWebAboutUs = $000001F5;
  pbWizardPageTypeWebInformational = $000001F6;
  pbWizardPageTypeWebList = $000001F7;
  pbWizardPageTypeWebCalendarPage = $000001F8;
  pbWizardPageTypeWebContactUs = $000001F9;
  pbWizardPageTypeWebEmployeeList = $000001FA;
  pbWizardPageTypeWebEmployee = $000001FB;
  pbWizardPageTypeWebFAQ = $000001FC;
  pbWizardPageTypeWebHome = $000001FD;
  pbWizardPageTypeWebJobs = $000001FE;
  pbWizardPageTypeWebLegal = $000001FF;
  pbWizardPageTypeWebArticle = $00000200;
  pbWizardPageTypeWebPhoto = $00000201;
  pbWizardPageTypeWebPhotoGallery = $00000202;
  pbWizardPageTypeWebProduct = $00000203;
  pbWizardPageTypeWebProductList = $00000204;
  pbWizardPageTypeWebProjectList = $00000205;
  pbWizardPageTypeWebLinks = $00000206;
  pbWizardPageTypeWebSeminar = $00000207;
  pbWizardPageTypeWebServiceList = $00000208;
  pbWizardPageTypeWebService = $00000209;
  pbWizardPageTypeWebSpecial = $0000020A;
  pbWizardPageTypeWebBlank = $0000020C;
  pbWizardPageTypeWebOrderForm = $0000020D;
  pbWizardPageTypeWebResponseForm = $0000020E;
  pbWizardPageTypeWebSignupForm = $0000020F;
  pbWizardPageTypeWebCalendarWithLinks = $00000320;
  pbWizardPageTypeWebProductsWithLinks = $00000321;
  pbWizardPageTypeWebEmployeesWithLinks = $00000322;
  pbWizardPageTypeWebServicesWithLinks = $00000323;
  pbWizardPageTypeWebProjectsWithLinks = $00000324;
  pbWizardPageTypeWebPhotosWithLinks = $00000325;

// Constants for enum PbPublicationLayout
type
  PbPublicationLayout = TOleEnum;
const
  pbLayoutFullPage = $00000001;
  pbLayoutBook = $00000002;
  pbLayoutFoldCard = $00000003;
  pbLayoutGreetingCardL = $00000004;
  pbLayoutGreetingCardT = $00000005;
  pbLayoutKookBaePan = $00000006;
  pbLayoutKookPan = $00000007;
  pbLayoutShinKookPan = $00000008;
  pbLayoutKookBanPan = $00000009;
  pbLayout4x6BaePan = $0000000A;
  pbLayout4x6Pan = $0000000B;
  pbLayout4x6BanPan = $0000000C;
  pbLayoutCrownPan = $0000000D;
  pbLayoutShinSeoPan = $0000000E;
  pbLayoutJang4x6Pan = $0000000F;
  pbLayoutIndexCard = $00000010;
  pbLayoutBusinessCardUS = $00000011;
  pbLayoutBusinessCardEurope = $00000012;
  pbLayoutBusinessCardFE = $00000013;
  pbLayoutBusinessCardLocal = $00000014;
  pbLayoutPosterSmall = $00000015;
  pbLayoutPosterLarge = $00000016;
  pbLayoutCustom = $00000017;
  pbLayoutBannerSmall = $00000018;
  pbLayoutBannerMedium = $00000019;
  pbLayoutBannerLarge = $0000001A;
  pbLayoutBannerCustom = $0000001B;
  pbLayoutPostcardUS = $0000001C;
  pbLayoutPostcardHalfLetter = $0000001D;
  pbLayoutPostcardA4 = $0000001E;
  pbLayoutPostcardJapan = $0000001F;
  pbLayoutLabel = $00000020;
  pbLayoutEnvelope = $00000021;
  pbLayoutWebPageSmall = $00000022;
  pbLayoutWebPageLarge = $00000023;

// Constants for enum PbPersonalInfoSet
type
  PbPersonalInfoSet = TOleEnum;
const
  pbPersonalInfoPrimaryBusiness = $00000001;
  pbPersonalInfoSecondaryBusiness = $00000002;
  pbPersonalInfoOtherOrganization = $00000003;
  pbPersonalInfoHome = $00000004;

// Constants for enum PbReplaceTint
type
  PbReplaceTint = TOleEnum;
const
  pbReplaceTintUseDefault = $00000000;
  pbReplaceTintKeepTints = $00000001;
  pbReplaceTintMaintainLuminosity = $00000002;

// Constants for enum PbInkName
type
  PbInkName = TOleEnum;
const
  pbInkNameCyan = $00000001;
  pbInkNameMagenta = $00000002;
  pbInkNameYellow = $00000003;
  pbInkNameBlack = $00000004;
  pbInkNameSpot1 = $00000101;
  pbInkNameSpot2 = $00000102;
  pbInkNameSpot3 = $00000103;
  pbInkNameSpot4 = $00000104;
  pbInkNameSpot5 = $00000105;
  pbInkNameSpot6 = $00000106;
  pbInkNameSpot7 = $00000107;
  pbInkNameSpot8 = $00000108;
  pbInkNameSpot9 = $00000109;
  pbInkNameSpot10 = $0000010A;
  pbInkNameSpot11 = $0000010B;
  pbInkNameSpot12 = $0000010C;

// Constants for enum PbFileFormat
type
  PbFileFormat = TOleEnum;
const
  pbFilePublication = $00000001;
  pbFilePublisher98 = $00000002;
  pbFilePublisher2000 = $00000003;
  pbFilePublicationHTML = $00000004;
  pbFileWebArchive = $00000005;
  pbFileRTF = $00000006;
  pbFileHTMLFiltered = $00000007;

// Constants for enum PbPrintGraphics
type
  PbPrintGraphics = TOleEnum;
const
  pbPrintHighResolution = $00000001;
  pbPrintLowResolution = $00000002;
  pbPrintNoGraphics = $00000003;

// Constants for enum PbInksToPrint
type
  PbInksToPrint = TOleEnum;
const
  pbInksToPrintAll = $00000001;
  pbInksToPrintUsed = $00000002;
  pbInksToPrintConvertSpotToProcess = $00000003;

// Constants for enum PbPrintMode
type
  PbPrintMode = TOleEnum;
const
  pbPrintModeCompositeRGB = $00000001;
  pbPrintModeSeparations = $00000002;
  pbPrintModeCompositeCMYK = $00000003;
  pbPrintModeCompositeGrayscale = $00000004;

// Constants for enum PbPublicationType
type
  PbPublicationType = TOleEnum;
const
  pbTypePrint = $00000001;
  pbTypeWeb = $00000002;

// Constants for enum PbPageNumberFormat
type
  PbPageNumberFormat = TOleEnum;
const
  pbPageNumberFormatArabic = $00000000;
  pbPageNumberFormatUCRoman = $00000001;
  pbPageNumberFormatLCRoman = $00000002;
  pbPageNumberFormatUCLetter = $00000003;
  pbPageNumberFormatLCLetter = $00000004;
  pbPageNumberFormatOrdinal = $00000005;
  pbPageNumberFormatCardtext = $00000006;
  pbPageNumberFormatOrdtext = $00000007;
  pbPageNumberFormatDbNum1 = $0000000A;
  pbPageNumberFormatDbNum2 = $0000000B;
  pbPageNumberFormatAiueo = $0000000C;
  pbPageNumberFormatIroha = $0000000D;
  pbPageNumberFormatDbChar = $0000000E;
  pbPageNumberFormatDbNum3 = $00000010;
  pbPageNumberFormatCirclenum = $00000012;
  pbPageNumberFormatDAiueo = $00000014;
  pbPageNumberFormatDIroha = $00000015;
  pbPageNumberFormatArabicLZ = $00000016;
  pbPageNumberFormatGanada = $00000018;
  pbPageNumberFormatChosung = $00000019;
  pbPageNumberFormatZodiac1 = $0000001E;
  pbPageNumberFormatZodiac2 = $0000001F;
  pbPageNumberFormatTpeDbNum2 = $00000022;
  pbPageNumberFormatTpeDbNum3 = $00000023;
  pbPageNumberFormatChnDbNum2 = $00000026;
  pbPageNumberFormatChnDbNum3 = $00000027;
  pbPageNumberFormatKorDbNum1 = $00000029;
  pbPageNumberFormatKorDbNum2 = $0000002A;
  pbPageNumberFormatKorDbNum3 = $0000002B;
  pbPageNumberFormatKorDbNum4 = $0000002C;
  pbPageNumberFormatHebrew1 = $0000002D;
  pbPageNumberFormatArabic1 = $0000002E;
  pbPageNumberFormatHebrew2 = $0000002F;
  pbPageNumberFormatArabic2 = $00000030;
  pbPageNumberFormatHindi1 = $00000031;
  pbPageNumberFormatHindi2 = $00000032;
  pbPageNumberFormatHindi3 = $00000033;
  pbPageNumberFormatHindi4 = $00000034;
  pbPageNumberFormatThai1 = $00000035;
  pbPageNumberFormatThai2 = $00000036;
  pbPageNumberFormatThai3 = $00000037;
  pbPageNumberFormatViet1 = $00000038;
  pbPageNumberFormatLCRus = $0000003A;
  pbPageNumberFormatUCRus = $0000003B;

// Constants for enum PbWizardNavBarDesign
type
  PbWizardNavBarDesign = TOleEnum;
const
  pbnbDesignRectangle = $00000001;
  pbnbDesignAmbient = $00000002;
  pbnbDesignCapsule = $00000003;
  pbnbDesignTopDrawer = $00000004;
  pbnbDesignOutline = $00000005;
  pbnbDesignRadius = $00000006;
  pbnbDesignOffset = $00000007;
  pbnbDesignDimension = $00000008;
  pbnbDesignDottedArrow = $00000009;
  pbnbDesignHollowArrow = $0000000A;
  pbnbDesignBracket = $0000000B;
  pbnbDesignEnclosedArrow = $0000000C;
  pbnbDesignCounter = $0000000D;
  pbnbDesignEndCap = $0000000E;
  pbnbDesignCornice = $0000000F;
  pbnbDesignStaff = $00000010;
  pbnbDesignEdge = $00000011;
  pbnbDesignTopLine = $00000012;
  pbnbDesignUnderscore = $00000013;
  pbnbDesignBulletStaff = $00000014;
  pbnbDesignTopBar = $00000015;
  pbnbDesignKeyPunch = $00000016;
  pbnbDesignRoundBullet = $00000017;
  pbnbDesignSquareBullet = $00000018;
  pbnbDesignWatermark = $00000019;
  pbnbDesignBaseline = $0000001A;

// Constants for enum PbWizardNavBarButtonStyle
type
  PbWizardNavBarButtonStyle = TOleEnum;
const
  pbnbButtonStyleSmall = $00000001;
  pbnbButtonStyleLarge = $00000002;
  pbnbButtonStyleText = $00000003;

// Constants for enum PbWizardNavBarAlignment
type
  PbWizardNavBarAlignment = TOleEnum;
const
  pbnbAlignLeft = $00000001;
  pbnbAlignCenter = $00000002;
  pbnbAlignRight = $00000003;

// Constants for enum PbNavBarOrientation
type
  PbNavBarOrientation = TOleEnum;
const
  pbNavBarOrientHorizontal = $00000001;
  pbNavBarOrientVertical = $00000002;

// Constants for enum PbMasterPageType
type
  PbMasterPageType = TOleEnum;
const
  pbMasterPageLeftPage = $00000001;
  pbMasterPageRightPage = $00000002;

// Constants for enum PbSpotColor
type
  PbSpotColor = TOleEnum;
const
  pbInkNone = $00000000;

// Constants for enum PbOriginalFormat
type
  PbOriginalFormat = TOleEnum;
const
  pbOriginalPublicationFormat = $00000001;
  pbPublisherFile = $00000002;

// Constants for enum PbColorScheme
type
  PbColorScheme = TOleEnum;
const
  pbColorSchemeCustom = $00000001;
  pbColorSchemeAlpine = $FFFFFFFF;
  pbColorSchemeAqua = $FFFFFFFE;
  pbColorSchemeBerry = $FFFFFFFD;
  pbColorSchemeBlackGray = $FFFFFFFC;
  pbColorSchemeBrown = $FFFFFFFB;
  pbColorSchemeBurgundy = $FFFFFFFA;
  pbColorSchemeCavern = $FFFFFFF9;
  pbColorSchemeCitrus = $FFFFFFF8;
  pbColorSchemeClay = $FFFFFFF7;
  pbColorSchemeCranberry = $FFFFFFF6;
  pbColorSchemeCrocus = $FFFFFFF5;
  pbColorSchemeDesert = $FFFFFFF4;
  pbColorSchemeField = $FFFFFFF3;
  pbColorSchemeFjord = $FFFFFFF2;
  pbColorSchemeFloral = $FFFFFFF1;
  pbColorSchemeGarnet = $FFFFFFF0;
  pbColorSchemeGlacier = $FFFFFFEF;
  pbColorSchemeHeather = $FFFFFFEE;
  pbColorSchemeIris = $FFFFFFED;
  pbColorSchemeIsland = $FFFFFFEC;
  pbColorSchemeIvy = $FFFFFFEB;
  pbColorSchemeLagoon = $FFFFFFEA;
  pbColorSchemeLilac = $FFFFFFE9;
  pbColorSchemeMahogany = $FFFFFFE8;
  pbColorSchemeMarine = $FFFFFFE7;
  pbColorSchemeMaroon = $FFFFFFE6;
  pbColorSchemeMeadow = $FFFFFFE5;
  pbColorSchemeMist = $FFFFFFE4;
  pbColorSchemeMistletoe = $FFFFFFE3;
  pbColorSchemeMoss = $FFFFFFE2;
  pbColorSchemeMountain = $FFFFFFE1;
  pbColorSchemeMulberry = $FFFFFFE0;
  pbColorSchemeNavy = $FFFFFFDF;
  pbColorSchemeNutmeg = $FFFFFFDE;
  pbColorSchemeOlive = $FFFFFFDD;
  pbColorSchemeOrchid = $FFFFFFDC;
  pbColorSchemeParrot = $FFFFFFDB;
  pbColorSchemePebbles = $FFFFFFDA;
  pbColorSchemePrairie = $FFFFFFD9;
  pbColorSchemeRainForest = $FFFFFFD8;
  pbColorSchemeMonarch = $FFFFFFD7;
  pbColorSchemeRedwood = $FFFFFFD6;
  pbColorSchemeReef = $FFFFFFD5;
  pbColorSchemeSagebrush = $FFFFFFD4;
  pbColorSchemeSapphire = $FFFFFFD3;
  pbColorSchemeShamrock = $FFFFFFD2;
  pbColorSchemeSienna = $FFFFFFD1;
  pbColorSchemeSpice = $FFFFFFD0;
  pbColorSchemeSunrise = $FFFFFFCF;
  pbColorSchemeSunset = $FFFFFFCE;
  pbColorSchemeTeal = $FFFFFFCD;
  pbColorSchemeTidepool = $FFFFFFCC;
  pbColorSchemeTropics = $FFFFFFCB;
  pbColorSchemeTrout = $FFFFFFCA;
  pbColorSchemeVineyard = $FFFFFFC9;
  pbColorSchemeWaterfall = $FFFFFFC8;
  pbColorSchemeWildflower = $FFFFFFC7;
  pbColorSchemeBlackWhite = $FFFFFFC6;
  pbColorSchemeGreen = $FFFFFFC5;
  pbColorSchemeRed = $FFFFFFC4;
  pbColorSchemeDarkBlue = $FFFFFFC3;
  pbColorSchemeOcean = $FFFFFC18;
  pbColorSchemePurple = $FFFFFC17;
  pbColorSchemeCherry = $FFFFFC16;
  pbColorSchemeOrange = $FFFFFC15;
  pbColorSchemeCelebration = $FFFFFC14;
  pbColorSchemePeach = $FFFFFC13;
  pbColorSchemeFirstUserDefined = $000007D0;

// Constants for enum PbFontType
type
  PbFontType = TOleEnum;
const
  pbFontTrueType = $00000001;
  pbFontPrinter = $00000002;
  pbFontRaster = $00000003;
  pbFontUnknown = $00000004;

// Constants for enum PbFontSource
type
  PbFontSource = TOleEnum;
const
  pbFontSystem = $00000001;
  pbFontDocument = $00000002;
  pbFontMissing = $00000003;

// Constants for enum PbFontLicenseLimitations
type
  PbFontLicenseLimitations = TOleEnum;
const
  pbFontEmbeddable = $00000001;
  pbFontPrintPreviewEmbeddable = $00000002;
  pbFontNotEmbeddable = $00000003;

// Constants for enum PbShowDialog
type
  PbShowDialog = TOleEnum;
const
  pbDefaultBehavior = $00000001;
  PbShowDialog_ = $00000002;
  pbSuppressDialog = $00000003;

// Constants for enum PbMailMergeDataSource
type
  PbMailMergeDataSource = TOleEnum;
const
  pbMergeInfoFromODSO = $00000005;

// Constants for enum PbFilterComparison
type
  PbFilterComparison = TOleEnum;
const
  pbComparisonEqual = $00000000;
  pbComparisonNotEqual = $00000001;
  pbComparisonLessThan = $00000002;
  pbComparisonGreaterThan = $00000003;
  pbComparisonLessThanEqual = $00000004;
  pbComparisonGreaterThanEqual = $00000005;
  pbComparisonIsBlank = $00000006;
  pbComparisonIsNotBlank = $00000007;

// Constants for enum PbFilterConjunction
type
  PbFilterConjunction = TOleEnum;
const
  pbConjunctionAnd = $00000000;
  pbConjunctionOr = $00000001;

// Constants for enum PbMappedDataFields
type
  PbMappedDataFields = TOleEnum;
const
  pbUniqueIdentifier = $00000001;
  pbCourtesyTitle = $00000002;
  pbFirstName = $00000003;
  pbMiddleName = $00000004;
  pbLastName = $00000005;
  pbSuffix = $00000006;
  pbNickname = $00000007;
  pbJobTitle = $00000008;
  pbCompany = $00000009;
  pbAddress1 = $0000000A;
  pbAddress2 = $0000000B;
  pbCity = $0000000C;
  pbState = $0000000D;
  pbPostalCode = $0000000E;
  pbCountryRegion = $0000000F;
  pbBusinessPhone = $00000010;
  pbBusinessFax = $00000011;
  pbHomePhone = $00000012;
  pbHomeFax = $00000013;
  pbEmailAddress = $00000014;
  pbWebPageURL = $00000015;
  pbSpouseCourtesyTitle = $00000016;
  pbSpouseFirstName = $00000017;
  pbSpouseMiddleName = $00000018;
  pbSpouseLastName = $00000019;
  pbSpouseNickname = $0000001A;
  pbRubyFirstName = $0000001B;
  pbRubyLastName = $0000001C;
  pbAddress3 = $0000001D;
  pbDepartment = $0000001E;

// Constants for enum PbWizardPageType10
type
  PbWizardPageType10 = TOleEnum;
const
  pbWizardPageTypeWebStory = $00000006;
  pbWizardPageTypeWebCalendar = $00000009;
  pbWizardPageTypeWebEvent = $0000000D;
  pbWizardPageTypeWebSpecialOffer = $0000000C;
  pbWizardPageTypeWebPriceList = $00000008;
  pbWizardPageTypeWebRelatedLinks = $00000007;

// Constants for enum PbWizard10
type
  PbWizard10 = TOleEnum;
const
  pbWizardWebSites = $0000000B;
  pbWizardGreetingCards = $0000000E;
  pbWizardInvitations = $0000000F;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  Documents = interface;
  DocumentsDisp = dispinterface;
  _Document = interface;
  _DocumentDisp = dispinterface;
  DocumentEvents = dispinterface;
  Window = interface;
  WindowDisp = dispinterface;
  _Application = interface;
  _ApplicationDisp = dispinterface;
  ApplicationEvents = dispinterface;
  ColorSchemes = interface;
  ColorSchemesDisp = dispinterface;
  ColorScheme = interface;
  ColorSchemeDisp = dispinterface;
  ColorFormat = interface;
  ColorFormatDisp = dispinterface;
  ColorCMYK = interface;
  ColorCMYKDisp = dispinterface;
  Options = interface;
  OptionsDisp = dispinterface;
  Selection = interface;
  SelectionDisp = dispinterface;
  ShapeRange = interface;
  ShapeRangeDisp = dispinterface;
  Shape = interface;
  ShapeDisp = dispinterface;
  Adjustments = interface;
  AdjustmentsDisp = dispinterface;
  CalloutFormat = interface;
  CalloutFormatDisp = dispinterface;
  ConnectorFormat = interface;
  ConnectorFormatDisp = dispinterface;
  FillFormat = interface;
  FillFormatDisp = dispinterface;
  GroupShapes = interface;
  GroupShapesDisp = dispinterface;
  LineFormat = interface;
  LineFormatDisp = dispinterface;
  ShapeNodes = interface;
  ShapeNodesDisp = dispinterface;
  ShapeNode = interface;
  ShapeNodeDisp = dispinterface;
  PictureFormat = interface;
  PictureFormatDisp = dispinterface;
  ShadowFormat = interface;
  ShadowFormatDisp = dispinterface;
  TextEffectFormat = interface;
  TextEffectFormatDisp = dispinterface;
  TextFrame = interface;
  TextFrameDisp = dispinterface;
  TextRange = interface;
  TextRangeDisp = dispinterface;
  Font = interface;
  FontDisp = dispinterface;
  ParagraphFormat = interface;
  ParagraphFormatDisp = dispinterface;
  TabStops = interface;
  TabStopsDisp = dispinterface;
  TabStop = interface;
  TabStopDisp = dispinterface;
  Fields = interface;
  FieldsDisp = dispinterface;
  Field = interface;
  FieldDisp = dispinterface;
  PhoneticGuide = interface;
  PhoneticGuideDisp = dispinterface;
  Story = interface;
  StoryDisp = dispinterface;
  Table = interface;
  TableDisp = dispinterface;
  Columns = interface;
  ColumnsDisp = dispinterface;
  Column = interface;
  ColumnDisp = dispinterface;
  CellRange = interface;
  CellRangeDisp = dispinterface;
  Cell = interface;
  CellDisp = dispinterface;
  CellBorder = interface;
  CellBorderDisp = dispinterface;
  Rows = interface;
  RowsDisp = dispinterface;
  Row = interface;
  RowDisp = dispinterface;
  DropCap = interface;
  DropCapDisp = dispinterface;
  Hyperlinks = interface;
  HyperlinksDisp = dispinterface;
  Hyperlink = interface;
  HyperlinkDisp = dispinterface;
  FindReplace = interface;
  FindReplaceDisp = dispinterface;
  InlineShapes = interface;
  InlineShapesDisp = dispinterface;
  ThreeDFormat = interface;
  ThreeDFormatDisp = dispinterface;
  LinkFormat = interface;
  LinkFormatDisp = dispinterface;
  OLEFormat = interface;
  OLEFormatDisp = dispinterface;
  ObjectVerbs = interface;
  ObjectVerbsDisp = dispinterface;
  Tags = interface;
  TagsDisp = dispinterface;
  Tag = interface;
  TagDisp = dispinterface;
  WebCommandButton = interface;
  WebCommandButtonDisp = dispinterface;
  WebHiddenFields = interface;
  WebHiddenFieldsDisp = dispinterface;
  WebListBox = interface;
  WebListBoxDisp = dispinterface;
  WebListBoxItems = interface;
  WebListBoxItemsDisp = dispinterface;
  WebTextBox = interface;
  WebTextBoxDisp = dispinterface;
  WebOptionButton = interface;
  WebOptionButtonDisp = dispinterface;
  WebCheckBox = interface;
  WebCheckBoxDisp = dispinterface;
  Wizard = interface;
  WizardDisp = dispinterface;
  WizardProperties = interface;
  WizardPropertiesDisp = dispinterface;
  WizardProperty = interface;
  WizardPropertyDisp = dispinterface;
  WizardValues = interface;
  WizardValuesDisp = dispinterface;
  WizardValue = interface;
  WizardValueDisp = dispinterface;
  WrapFormat = interface;
  WrapFormatDisp = dispinterface;
  BorderArtFormat = interface;
  BorderArtFormatDisp = dispinterface;
  CatalogMergeShapes = interface;
  CatalogMergeShapesDisp = dispinterface;
  WebOptions = interface;
  WebOptionsDisp = dispinterface;
  IApplicationEvents = interface;
  IApplicationEventsDisp = dispinterface;
  View = interface;
  ViewDisp = dispinterface;
  Page = interface;
  PageDisp = dispinterface;
  Shapes = interface;
  ShapesDisp = dispinterface;
  FreeformBuilder = interface;
  FreeformBuilderDisp = dispinterface;
  RulerGuides = interface;
  RulerGuidesDisp = dispinterface;
  RulerGuide = interface;
  RulerGuideDisp = dispinterface;
  ReaderSpread = interface;
  ReaderSpreadDisp = dispinterface;
  HeaderFooter = interface;
  HeaderFooterDisp = dispinterface;
  PageBackground = interface;
  PageBackgroundDisp = dispinterface;
  WebPageOptions = interface;
  WebPageOptionsDisp = dispinterface;
  LayoutGuides = interface;
  LayoutGuidesDisp = dispinterface;
  MailMerge = interface;
  MailMergeDisp = dispinterface;
  MailMergeDataSource = interface;
  MailMergeDataSourceDisp = dispinterface;
  MailMergeDataFields = interface;
  MailMergeDataFieldsDisp = dispinterface;
  MailMergeDataField = interface;
  MailMergeDataFieldDisp = dispinterface;
  MailMergeFilters = interface;
  MailMergeFiltersDisp = dispinterface;
  MailMergeMappedDataFields = interface;
  MailMergeMappedDataFieldsDisp = dispinterface;
  MailMergeMappedDataField = interface;
  MailMergeMappedDataFieldDisp = dispinterface;
  MasterPages = interface;
  MasterPagesDisp = dispinterface;
  Pages = interface;
  PagesDisp = dispinterface;
  PageSetup = interface;
  PageSetupDisp = dispinterface;
  Label_ = interface;
  Label_Disp = dispinterface;
  Labels = interface;
  LabelsDisp = dispinterface;
  Plates = interface;
  PlatesDisp = dispinterface;
  Plate = interface;
  PlateDisp = dispinterface;
  ScratchArea = interface;
  ScratchAreaDisp = dispinterface;
  Stories = interface;
  StoriesDisp = dispinterface;
  TextStyles = interface;
  TextStylesDisp = dispinterface;
  TextStyle = interface;
  TextStyleDisp = dispinterface;
  AdvancedPrintOptions = interface;
  AdvancedPrintOptionsDisp = dispinterface;
  PrintableRect = interface;
  PrintableRectDisp = dispinterface;
  PrintablePlates = interface;
  PrintablePlatesDisp = dispinterface;
  PrintablePlate = interface;
  PrintablePlateDisp = dispinterface;
  BorderArts = interface;
  BorderArtsDisp = dispinterface;
  BorderArt = interface;
  BorderArtDisp = dispinterface;
  Sections = interface;
  SectionsDisp = dispinterface;
  Section = interface;
  SectionDisp = dispinterface;
  WebNavigationBarSets = interface;
  WebNavigationBarSetsDisp = dispinterface;
  WebNavigationBarSet = interface;
  WebNavigationBarSetDisp = dispinterface;
  WebNavigationBarHyperlinks = interface;
  WebNavigationBarHyperlinksDisp = dispinterface;
  ColorsInUse = interface;
  ColorsInUseDisp = dispinterface;
  IDocumentEvents = interface;
  IDocumentEventsDisp = dispinterface;
  MailMergeFilterCriterion = interface;
  MailMergeFilterCriterionDisp = dispinterface;
  ModalBrowser = interface;
  ModalBrowserDisp = dispinterface;
  ICagNotifySink = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  Application = _Application;
  Document = _Document;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PUserType1 = ^TGUID; {*}
  PShortint1 = ^Shortint; {*}
  PPShortint1 = ^PShortint1; {*}
  PUserType2 = ^TGUID; {*}


// *********************************************************************//
// Interface: Documents
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {12F564D6-BC5F-410E-ACD1-7D3D47F06FFA}
// *********************************************************************//
  Documents = interface(IDispatch)
    ['{12F564D6-BC5F-410E-ACD1-7D3D47F06FFA}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(varDocument: OleVariant): Document; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Add(PbWizard: PbWizard; desid: Integer): Document; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[varDocument: OleVariant]: Document read Get_Item; default;
    property Count: SYSINT read Get_Count;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  DocumentsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {12F564D6-BC5F-410E-ACD1-7D3D47F06FFA}
// *********************************************************************//
  DocumentsDisp = dispinterface
    ['{12F564D6-BC5F-410E-ACD1-7D3D47F06FFA}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[varDocument: OleVariant]: Document readonly dispid 0; default;
    property Count: SYSINT readonly dispid 1;
    property Application: Application readonly dispid 2;
    property Parent: IDispatch readonly dispid 3;
    function  Add(PbWizard: PbWizard; desid: Integer): Document; dispid 4;
  end;

// *********************************************************************//
// Interface: _Document
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021242-0000-0000-C000-000000000046}
// *********************************************************************//
  _Document = interface(IDispatch)
    ['{00021242-0000-0000-C000-000000000046}']
    function  Get_ActivePrinter: WideString; safecall;
    procedure Set_ActivePrinter(const RetValue: WideString); safecall;
    function  Get_ActiveWindow: Window; safecall;
    function  Get_Application: Application; safecall;
    function  Get_ColorMode: PbColorMode; safecall;
    function  Get_ColorScheme: ColorScheme; safecall;
    procedure Set_ColorScheme(const RetVal: ColorScheme); safecall;
    function  Get_DefaultTabStop: OleVariant; safecall;
    procedure Set_DefaultTabStop(RetValue: OleVariant); safecall;
    function  Get_EnvelopeVisible: WordBool; safecall;
    procedure Set_EnvelopeVisible(RetValue: WordBool); safecall;
    function  Get_FullName: WideString; safecall;
    function  Get_LayoutGuides: LayoutGuides; safecall;
    function  Get_MailEnvelope: IDispatch; safecall;
    function  Get_MailMerge: MailMerge; safecall;
    function  Get_MasterPages: MasterPages; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Pages: Pages; safecall;
    function  Get_PageSetup: PageSetup; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Path: WideString; safecall;
    function  Get_PersonalInformationSet: PbPersonalInfoSet; safecall;
    procedure Set_PersonalInformationSet(RetValue: PbPersonalInfoSet); safecall;
    function  Get_Plates: Plates; safecall;
    function  Get_ReadOnly: WordBool; safecall;
    function  Get_DocumentDirection: PbDirectionType; safecall;
    procedure Set_DocumentDirection(RetValue: PbDirectionType); safecall;
    function  Get_Saved: WordBool; safecall;
    function  Get_SaveFormat: PbFileFormat; safecall;
    function  Get_ScratchArea: ScratchArea; safecall;
    function  Get_Selection: Selection; safecall;
    function  Get_Stories: Stories; safecall;
    function  Get_Tags: Tags; safecall;
    function  Get_TextStyles: TextStyles; safecall;
    function  Get_ViewBoundariesAndGuides: WordBool; safecall;
    procedure Set_ViewBoundariesAndGuides(RetValue: WordBool); safecall;
    function  Get_ViewTwoPageSpread: WordBool; safecall;
    procedure Set_ViewTwoPageSpread(RetValue: WordBool); safecall;
    function  Get_Wizard: Wizard; safecall;
    procedure Close; safecall;
    function  CreatePlateCollection(Mode: PbColorMode): Plates; safecall;
    procedure EnterColorMode10(Mode: PbColorMode; Plates: OleVariant); safecall;
    function  FindShapesByTag(const TagName: WideString): ShapeRange; safecall;
    function  FindShapeByWizardTag(WizardTag: PbWizardTag; Instance: Integer): ShapeRange; safecall;
    procedure PrintOut(From: Integer; To_: Integer; const PrintToFile: WideString; Copies: Integer; 
                       Collate: WordBool); safecall;
    procedure Save; safecall;
    procedure SaveAs(Filename: OleVariant; Format: PbFileFormat; AddToRecentFiles: WordBool); safecall;
    procedure SelectID(oh: SYSINT); safecall;
    procedure UndoClear; safecall;
    procedure UpdateOLEObjects; safecall;
    function  Get_ActiveView: View; safecall;
    procedure Undo(Count: SYSINT); safecall;
    procedure Redo(Count: SYSINT); safecall;
    procedure BeginCustomUndoAction(const ActionName: WideString); safecall;
    procedure EndCustomUndoAction; safecall;
    function  Get_AdvancedPrintOptions: AdvancedPrintOptions; safecall;
    function  Get_BorderArts: BorderArts; safecall;
    function  Get_IsDataSourceConnected: WordBool; safecall;
    procedure WebPagePreview; safecall;
    function  Get_Find: FindReplace; safecall;
    function  Get_UndoActionsAvailable: SYSINT; safecall;
    function  Get_RedoActionsAvailable: SYSINT; safecall;
    function  Get_ViewHorizontalBaseLineGuides: WordBool; safecall;
    procedure Set_ViewHorizontalBaseLineGuides(RetValue: WordBool); safecall;
    function  Get_ViewVerticalBaseLineGuides: WordBool; safecall;
    procedure Set_ViewVerticalBaseLineGuides(RetValue: WordBool); safecall;
    function  Get_PublicationType: PbPublicationType; safecall;
    procedure ConvertPublicationType(Value: PbPublicationType); safecall;
    function  Get_Sections: Sections; safecall;
    function  Get_WebNavigationBarSets: WebNavigationBarSets; safecall;
    function  Get_RemovePersonalInformation: WordBool; safecall;
    procedure Set_RemovePersonalInformation(RetValue: WordBool); safecall;
    function  Get_PrintPageBackgrounds: WordBool; safecall;
    procedure Set_PrintPageBackgrounds(RetValue: WordBool); safecall;
    function  Get_ColorsInUse: ColorsInUse; safecall;
    function  Get_IsWizard: WordBool; safecall;
    procedure EnterColorMode(Mode: PbColorMode; Plates: OleVariant; DeleteExcessInks: WordBool); safecall;
    property ActivePrinter: WideString read Get_ActivePrinter write Set_ActivePrinter;
    property ActiveWindow: Window read Get_ActiveWindow;
    property Application: Application read Get_Application;
    property ColorMode: PbColorMode read Get_ColorMode;
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property DefaultTabStop: OleVariant read Get_DefaultTabStop write Set_DefaultTabStop;
    property EnvelopeVisible: WordBool read Get_EnvelopeVisible write Set_EnvelopeVisible;
    property FullName: WideString read Get_FullName;
    property LayoutGuides: LayoutGuides read Get_LayoutGuides;
    property MailEnvelope: IDispatch read Get_MailEnvelope;
    property MailMerge: MailMerge read Get_MailMerge;
    property MasterPages: MasterPages read Get_MasterPages;
    property Name: WideString read Get_Name;
    property Pages: Pages read Get_Pages;
    property PageSetup: PageSetup read Get_PageSetup;
    property Parent: IDispatch read Get_Parent;
    property Path: WideString read Get_Path;
    property PersonalInformationSet: PbPersonalInfoSet read Get_PersonalInformationSet write Set_PersonalInformationSet;
    property Plates: Plates read Get_Plates;
    property ReadOnly: WordBool read Get_ReadOnly;
    property DocumentDirection: PbDirectionType read Get_DocumentDirection write Set_DocumentDirection;
    property Saved: WordBool read Get_Saved;
    property SaveFormat: PbFileFormat read Get_SaveFormat;
    property ScratchArea: ScratchArea read Get_ScratchArea;
    property Selection: Selection read Get_Selection;
    property Stories: Stories read Get_Stories;
    property Tags: Tags read Get_Tags;
    property TextStyles: TextStyles read Get_TextStyles;
    property ViewBoundariesAndGuides: WordBool read Get_ViewBoundariesAndGuides write Set_ViewBoundariesAndGuides;
    property ViewTwoPageSpread: WordBool read Get_ViewTwoPageSpread write Set_ViewTwoPageSpread;
    property Wizard: Wizard read Get_Wizard;
    property ActiveView: View read Get_ActiveView;
    property AdvancedPrintOptions: AdvancedPrintOptions read Get_AdvancedPrintOptions;
    property BorderArts: BorderArts read Get_BorderArts;
    property IsDataSourceConnected: WordBool read Get_IsDataSourceConnected;
    property Find: FindReplace read Get_Find;
    property UndoActionsAvailable: SYSINT read Get_UndoActionsAvailable;
    property RedoActionsAvailable: SYSINT read Get_RedoActionsAvailable;
    property ViewHorizontalBaseLineGuides: WordBool read Get_ViewHorizontalBaseLineGuides write Set_ViewHorizontalBaseLineGuides;
    property ViewVerticalBaseLineGuides: WordBool read Get_ViewVerticalBaseLineGuides write Set_ViewVerticalBaseLineGuides;
    property PublicationType: PbPublicationType read Get_PublicationType;
    property Sections: Sections read Get_Sections;
    property WebNavigationBarSets: WebNavigationBarSets read Get_WebNavigationBarSets;
    property RemovePersonalInformation: WordBool read Get_RemovePersonalInformation write Set_RemovePersonalInformation;
    property PrintPageBackgrounds: WordBool read Get_PrintPageBackgrounds write Set_PrintPageBackgrounds;
    property ColorsInUse: ColorsInUse read Get_ColorsInUse;
    property IsWizard: WordBool read Get_IsWizard;
  end;

// *********************************************************************//
// DispIntf:  _DocumentDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021242-0000-0000-C000-000000000046}
// *********************************************************************//
  _DocumentDisp = dispinterface
    ['{00021242-0000-0000-C000-000000000046}']
    property ActivePrinter: WideString dispid 1;
    property ActiveWindow: Window readonly dispid 2;
    property Application: Application readonly dispid 3;
    property ColorMode: PbColorMode readonly dispid 4;
    property ColorScheme: ColorScheme dispid 5;
    property DefaultTabStop: OleVariant dispid 7;
    property EnvelopeVisible: WordBool dispid 9;
    property FullName: WideString readonly dispid 11;
    property LayoutGuides: LayoutGuides readonly dispid 12;
    property MailEnvelope: IDispatch readonly dispid 13;
    property MailMerge: MailMerge readonly dispid 14;
    property MasterPages: MasterPages readonly dispid 15;
    property Name: WideString readonly dispid 16;
    property Pages: Pages readonly dispid 17;
    property PageSetup: PageSetup readonly dispid 18;
    property Parent: IDispatch readonly dispid 23;
    property Path: WideString readonly dispid 24;
    property PersonalInformationSet: PbPersonalInfoSet dispid 25;
    property Plates: Plates readonly dispid 26;
    property ReadOnly: WordBool readonly dispid 27;
    property DocumentDirection: PbDirectionType dispid 28;
    property Saved: WordBool readonly dispid 29;
    property SaveFormat: PbFileFormat readonly dispid 30;
    property ScratchArea: ScratchArea readonly dispid 31;
    property Selection: Selection readonly dispid 32;
    property Stories: Stories readonly dispid 33;
    property Tags: Tags readonly dispid 35;
    property TextStyles: TextStyles readonly dispid 36;
    property ViewBoundariesAndGuides: WordBool dispid 38;
    property ViewTwoPageSpread: WordBool dispid 39;
    property Wizard: Wizard readonly dispid 40;
    procedure Close; dispid 48;
    function  CreatePlateCollection(Mode: PbColorMode): Plates; dispid 49;
    procedure EnterColorMode10(Mode: PbColorMode; Plates: OleVariant); dispid 50;
    function  FindShapesByTag(const TagName: WideString): ShapeRange; dispid 51;
    function  FindShapeByWizardTag(WizardTag: PbWizardTag; Instance: Integer): ShapeRange; dispid 52;
    procedure PrintOut(From: Integer; To_: Integer; const PrintToFile: WideString; Copies: Integer; 
                       Collate: WordBool); dispid 54;
    procedure Save; dispid 57;
    procedure SaveAs(Filename: OleVariant; Format: PbFileFormat; AddToRecentFiles: WordBool); dispid 58;
    procedure SelectID(oh: SYSINT); dispid 59;
    procedure UndoClear; dispid 61;
    procedure UpdateOLEObjects; dispid 62;
    property ActiveView: View readonly dispid 63;
    procedure Undo(Count: SYSINT); dispid 60;
    procedure Redo(Count: SYSINT); dispid 64;
    procedure BeginCustomUndoAction(const ActionName: WideString); dispid 65;
    procedure EndCustomUndoAction; dispid 66;
    property AdvancedPrintOptions: AdvancedPrintOptions readonly dispid 69;
    property BorderArts: BorderArts readonly dispid 71;
    property IsDataSourceConnected: WordBool readonly dispid 72;
    procedure WebPagePreview; dispid 74;
    property Find: FindReplace readonly dispid 75;
    property UndoActionsAvailable: SYSINT readonly dispid 76;
    property RedoActionsAvailable: SYSINT readonly dispid 77;
    property ViewHorizontalBaseLineGuides: WordBool dispid 78;
    property ViewVerticalBaseLineGuides: WordBool dispid 79;
    property PublicationType: PbPublicationType readonly dispid 80;
    procedure ConvertPublicationType(Value: PbPublicationType); dispid 81;
    property Sections: Sections readonly dispid 82;
    property WebNavigationBarSets: WebNavigationBarSets readonly dispid 85;
    property RemovePersonalInformation: WordBool dispid 86;
    property PrintPageBackgrounds: WordBool dispid 87;
    property ColorsInUse: ColorsInUse readonly dispid 88;
    property IsWizard: WordBool readonly dispid 89;
    procedure EnterColorMode(Mode: PbColorMode; Plates: OleVariant; DeleteExcessInks: WordBool); dispid 90;
  end;

// *********************************************************************//
// DispIntf:  DocumentEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {00021244-0000-0000-C000-000000000046}
// *********************************************************************//
  DocumentEvents = dispinterface
    ['{00021244-0000-0000-C000-000000000046}']
    procedure Open; dispid 1;
    procedure BeforeClose(var Cancel: WordBool); dispid 2;
    procedure ShapesAdded; dispid 3;
    procedure WizardAfterChange; dispid 4;
    procedure ShapesRemoved; dispid 5;
    procedure Undo; dispid 6;
    procedure Redo; dispid 7;
  end;

// *********************************************************************//
// Interface: Window
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39051BAB-5CA7-11D3-B65F-00C04F8EF32D}
// *********************************************************************//
  Window = interface(IDispatch)
    ['{39051BAB-5CA7-11D3-B65F-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Caption: WideString; safecall;
    procedure Set_Caption(const RetValue: WideString); safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Top: Integer; safecall;
    procedure Set_Top(RetValue: Integer); safecall;
    function  Get_Left: Integer; safecall;
    procedure Set_Left(RetValue: Integer); safecall;
    function  Get_Width: Integer; safecall;
    procedure Set_Width(RetValue: Integer); safecall;
    function  Get_Height: Integer; safecall;
    procedure Set_Height(RetValue: Integer); safecall;
    function  Get_Visible: WordBool; safecall;
    procedure Set_Visible(RetValue: WordBool); safecall;
    function  Get_WindowState: PbWindowState; safecall;
    procedure Set_WindowState(RetValue: PbWindowState); safecall;
    function  Get_Hwnd: Integer; safecall;
    procedure Activate; safecall;
    procedure Move(Left: Integer; Top: Integer); safecall;
    procedure Resize(Width: Integer; Height: Integer); safecall;
    property Application: Application read Get_Application;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Parent: IDispatch read Get_Parent;
    property Top: Integer read Get_Top write Set_Top;
    property Left: Integer read Get_Left write Set_Left;
    property Width: Integer read Get_Width write Set_Width;
    property Height: Integer read Get_Height write Set_Height;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property WindowState: PbWindowState read Get_WindowState write Set_WindowState;
    property Hwnd: Integer read Get_Hwnd;
  end;

// *********************************************************************//
// DispIntf:  WindowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39051BAB-5CA7-11D3-B65F-00C04F8EF32D}
// *********************************************************************//
  WindowDisp = dispinterface
    ['{39051BAB-5CA7-11D3-B65F-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Caption: WideString dispid 2;
    property Parent: IDispatch readonly dispid 3;
    property Top: Integer dispid 4;
    property Left: Integer dispid 5;
    property Width: Integer dispid 6;
    property Height: Integer dispid 7;
    property Visible: WordBool dispid 9;
    property WindowState: PbWindowState dispid 10;
    property Hwnd: Integer readonly dispid 11;
    procedure Activate; dispid 12;
    procedure Move(Left: Integer; Top: Integer); dispid 13;
    procedure Resize(Width: Integer; Height: Integer); dispid 14;
  end;

// *********************************************************************//
// Interface: _Application
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002123E-0000-0000-C000-000000000046}
// *********************************************************************//
  _Application = interface(IDispatch)
    ['{0002123E-0000-0000-C000-000000000046}']
    function  Get_ActiveDocument: Document; safecall;
    function  Get_ActiveWindow: Window; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Assistant: Assistant; safecall;
    function  Get_Build: Integer; safecall;
    function  Get_ColorSchemes: ColorSchemes; safecall;
    function  Get_COMAddIns: COMAddIns; safecall;
    function  Get_CommandBars: CommandBars; safecall;
    function  Get_FileDialog(Type_: TOleEnum): IDispatch; safecall;
    function  Get_FileSearch: FileSearch; safecall;
    function  Get_Language: Integer; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Options: Options; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Path: WideString; safecall;
    function  Get_PathSeparator: WideString; safecall;
    function  Get_ProductCode: WideString; safecall;
    function  Get_PrintPreview: WordBool; safecall;
    procedure Set_PrintPreview(RetValue: WordBool); safecall;
    function  Get_ScreenUpdating: WordBool; safecall;
    procedure Set_ScreenUpdating(RetValue: WordBool); safecall;
    function  Get_Selection: Selection; safecall;
    function  Get_SnapToGuides: WordBool; safecall;
    procedure Set_SnapToGuides(RetValue: WordBool); safecall;
    function  Get_SnapToObjects: WordBool; safecall;
    procedure Set_SnapToObjects(RetValue: WordBool); safecall;
    function  Get_TemplateFolderPath: WideString; safecall;
    function  Get_Version: WideString; safecall;
    function  Get_OfficeDataSourceObject: IDispatch; safecall;
    procedure ChangeFileOpenDirectory(const Dir: WideString); safecall;
    procedure Help(HelpType: PbHelpType); safecall;
    function  IsValidObject(const Object_: IDispatch): WordBool; safecall;
    function  NewDocument(Wizard: PbWizard; Design: Integer): Document; safecall;
    function  Open(const Filename: WideString; ReadOnly: WordBool; AddToRecentFiles: WordBool; 
                   SaveChanges: PbSaveOptions): Document; safecall;
    procedure Quit; safecall;
    procedure LaunchWebService; safecall;
    function  CentimetersToPoints(Value: Single): Single; safecall;
    function  EmusToPoints(Value: Single): Single; safecall;
    function  InchesToPoints(Value: Single): Single; safecall;
    function  LinesToPoints(Value: Single): Single; safecall;
    function  MillimetersToPoints(Value: Single): Single; safecall;
    function  PicasToPoints(Value: Single): Single; safecall;
    function  PixelsToPoints(Value: Single): Single; safecall;
    function  TwipsToPoints(Value: Single): Single; safecall;
    function  PointsToCentimeters(Value: Single): Single; safecall;
    function  PointsToEmus(Value: Single): Single; safecall;
    function  PointsToInches(Value: Single): Single; safecall;
    function  PointsToLines(Value: Single): Single; safecall;
    function  PointsToMillimeters(Value: Single): Single; safecall;
    function  PointsToPicas(Value: Single): Single; safecall;
    function  PointsToPixels(Value: Single): Single; safecall;
    function  PointsToTwips(Value: Single): Single; safecall;
    function  Get_WizardCatalogVisible: WordBool; safecall;
    procedure Set_WizardCatalogVisible(WizardCatalogVisible: WordBool); safecall;
    function  Get_Documents: Documents; safecall;
    function  Get_WebOptions: WebOptions; safecall;
    property ActiveDocument: Document read Get_ActiveDocument;
    property ActiveWindow: Window read Get_ActiveWindow;
    property Application: Application read Get_Application;
    property Assistant: Assistant read Get_Assistant;
    property Build: Integer read Get_Build;
    property ColorSchemes: ColorSchemes read Get_ColorSchemes;
    property COMAddIns: COMAddIns read Get_COMAddIns;
    property CommandBars: CommandBars read Get_CommandBars;
    property FileDialog[Type_: TOleEnum]: IDispatch read Get_FileDialog;
    property FileSearch: FileSearch read Get_FileSearch;
    property Language: Integer read Get_Language;
    property Name: WideString read Get_Name;
    property Options: Options read Get_Options;
    property Parent: IDispatch read Get_Parent;
    property Path: WideString read Get_Path;
    property PathSeparator: WideString read Get_PathSeparator;
    property ProductCode: WideString read Get_ProductCode;
    property PrintPreview: WordBool read Get_PrintPreview write Set_PrintPreview;
    property ScreenUpdating: WordBool read Get_ScreenUpdating write Set_ScreenUpdating;
    property Selection: Selection read Get_Selection;
    property SnapToGuides: WordBool read Get_SnapToGuides write Set_SnapToGuides;
    property SnapToObjects: WordBool read Get_SnapToObjects write Set_SnapToObjects;
    property TemplateFolderPath: WideString read Get_TemplateFolderPath;
    property Version: WideString read Get_Version;
    property OfficeDataSourceObject: IDispatch read Get_OfficeDataSourceObject;
    property WizardCatalogVisible: WordBool read Get_WizardCatalogVisible write Set_WizardCatalogVisible;
    property Documents: Documents read Get_Documents;
    property WebOptions: WebOptions read Get_WebOptions;
  end;

// *********************************************************************//
// DispIntf:  _ApplicationDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002123E-0000-0000-C000-000000000046}
// *********************************************************************//
  _ApplicationDisp = dispinterface
    ['{0002123E-0000-0000-C000-000000000046}']
    property ActiveDocument: Document readonly dispid 1;
    property ActiveWindow: Window readonly dispid 2;
    property Application: Application readonly dispid 4;
    property Assistant: Assistant readonly dispid 5;
    property Build: Integer readonly dispid 6;
    property ColorSchemes: ColorSchemes readonly dispid 8;
    property COMAddIns: COMAddIns readonly dispid 9;
    property CommandBars: CommandBars readonly dispid 10;
    property FileDialog[Type_: TOleEnum]: IDispatch readonly dispid 11;
    property FileSearch: FileSearch readonly dispid 12;
    property Language: Integer readonly dispid 13;
    property Name: WideString readonly dispid 16;
    property Options: Options readonly dispid 17;
    property Parent: IDispatch readonly dispid 18;
    property Path: WideString readonly dispid 19;
    property PathSeparator: WideString readonly dispid 20;
    property ProductCode: WideString readonly dispid 21;
    property PrintPreview: WordBool dispid 22;
    property ScreenUpdating: WordBool dispid 23;
    property Selection: Selection readonly dispid 25;
    property SnapToGuides: WordBool dispid 26;
    property SnapToObjects: WordBool dispid 27;
    property TemplateFolderPath: WideString readonly dispid 30;
    property Version: WideString readonly dispid 31;
    property OfficeDataSourceObject: IDispatch readonly dispid 33;
    procedure ChangeFileOpenDirectory(const Dir: WideString); dispid 34;
    procedure Help(HelpType: PbHelpType); dispid 35;
    function  IsValidObject(const Object_: IDispatch): WordBool; dispid 36;
    function  NewDocument(Wizard: PbWizard; Design: Integer): Document; dispid 37;
    function  Open(const Filename: WideString; ReadOnly: WordBool; AddToRecentFiles: WordBool; 
                   SaveChanges: PbSaveOptions): Document; dispid 38;
    procedure Quit; dispid 39;
    procedure LaunchWebService; dispid 44;
    function  CentimetersToPoints(Value: Single): Single; dispid 45;
    function  EmusToPoints(Value: Single): Single; dispid 46;
    function  InchesToPoints(Value: Single): Single; dispid 47;
    function  LinesToPoints(Value: Single): Single; dispid 48;
    function  MillimetersToPoints(Value: Single): Single; dispid 49;
    function  PicasToPoints(Value: Single): Single; dispid 50;
    function  PixelsToPoints(Value: Single): Single; dispid 51;
    function  TwipsToPoints(Value: Single): Single; dispid 52;
    function  PointsToCentimeters(Value: Single): Single; dispid 53;
    function  PointsToEmus(Value: Single): Single; dispid 54;
    function  PointsToInches(Value: Single): Single; dispid 55;
    function  PointsToLines(Value: Single): Single; dispid 56;
    function  PointsToMillimeters(Value: Single): Single; dispid 57;
    function  PointsToPicas(Value: Single): Single; dispid 58;
    function  PointsToPixels(Value: Single): Single; dispid 59;
    function  PointsToTwips(Value: Single): Single; dispid 60;
    property WizardCatalogVisible: WordBool dispid 65;
    property Documents: Documents readonly dispid 66;
    property WebOptions: WebOptions readonly dispid 68;
  end;

// *********************************************************************//
// DispIntf:  ApplicationEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {00021240-0000-0000-C000-000000000046}
// *********************************************************************//
  ApplicationEvents = dispinterface
    ['{00021240-0000-0000-C000-000000000046}']
    procedure WindowActivate(const Wn: Window); dispid 1;
    procedure WindowDeactivate(const Wn: Window); dispid 2;
    procedure WindowPageChange(const Vw: View); dispid 4;
    procedure Quit; dispid 5;
    procedure NewDocument(const Doc: _Document); dispid 6;
    procedure DocumentOpen(const Doc: _Document); dispid 7;
    procedure DocumentBeforeClose(const Doc: _Document; var Cancel: WordBool); dispid 8;
    procedure MailMergeAfterMerge(const Doc: _Document); dispid 9;
    procedure MailMergeAfterRecordMerge(const Doc: _Document); dispid 10;
    procedure MailMergeBeforeMerge(const Doc: _Document; StartRecord: Integer; EndRecord: Integer; 
                                   var Cancel: WordBool); dispid 11;
    procedure MailMergeBeforeRecordMerge(const Doc: _Document; var Cancel: WordBool); dispid 12;
    procedure MailMergeDataSourceLoad(const Doc: _Document); dispid 13;
    procedure MailMergeWizardSendToCustom(const Doc: _Document); dispid 16;
    procedure MailMergeWizardStateChange(const Doc: _Document; FromState: SYSINT); dispid 17;
    procedure MailMergeDataSourceValidate(const Doc: _Document; var Handled: WordBool); dispid 18;
  end;

// *********************************************************************//
// Interface: ColorSchemes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {821941D9-F6DD-11D3-907C-00C04F799E3F}
// *********************************************************************//
  ColorSchemes = interface(IDispatch)
    ['{821941D9-F6DD-11D3-907C-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Count: Integer; safecall;
    function  Get_Item(Index: OleVariant): ColorScheme; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Parent: IDispatch; safecall;
    property Application: Application read Get_Application;
    property Count: Integer read Get_Count;
    property Item[Index: OleVariant]: ColorScheme read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  ColorSchemesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {821941D9-F6DD-11D3-907C-00C04F799E3F}
// *********************************************************************//
  ColorSchemesDisp = dispinterface
    ['{821941D9-F6DD-11D3-907C-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Count: Integer readonly dispid 2;
    property Item[Index: OleVariant]: ColorScheme readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
    property Parent: IDispatch readonly dispid 3;
  end;

// *********************************************************************//
// Interface: ColorScheme
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {821941D8-F6DD-11D3-907C-00C04F799E3F}
// *********************************************************************//
  ColorScheme = interface(IDispatch)
    ['{821941D8-F6DD-11D3-907C-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Colors(ColorIndex: PbSchemeColorIndex): ColorFormat; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Parent: IDispatch; safecall;
    property Application: Application read Get_Application;
    property Colors[ColorIndex: PbSchemeColorIndex]: ColorFormat read Get_Colors;
    property Name: WideString read Get_Name;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  ColorSchemeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {821941D8-F6DD-11D3-907C-00C04F799E3F}
// *********************************************************************//
  ColorSchemeDisp = dispinterface
    ['{821941D8-F6DD-11D3-907C-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Colors[ColorIndex: PbSchemeColorIndex]: ColorFormat readonly dispid 2;
    property Name: WideString readonly dispid 3;
    property Parent: IDispatch readonly dispid 4;
  end;

// *********************************************************************//
// Interface: ColorFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021264-0000-0000-C000-000000000046}
// *********************************************************************//
  ColorFormat = interface(IDispatch)
    ['{00021264-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_BaseRGB: MsoRGBType; safecall;
    procedure Set_BaseRGB(RGB: MsoRGBType); safecall;
    function  Get_CMYK: ColorCMYK; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_RGB: MsoRGBType; safecall;
    procedure Set_RGB(RGB: MsoRGBType); safecall;
    function  Get_SchemeColor: PbSchemeColorIndex; safecall;
    procedure Set_SchemeColor(SchemeColor: PbSchemeColorIndex); safecall;
    function  Get_Ink: SYSINT; safecall;
    procedure Set_Ink(Ink: SYSINT); safecall;
    function  Get_TintAndShade: Single; safecall;
    procedure Set_TintAndShade(Value: Single); safecall;
    function  Get_Type_: PbColorType; safecall;
    property Application: Application read Get_Application;
    property BaseRGB: MsoRGBType read Get_BaseRGB write Set_BaseRGB;
    property CMYK: ColorCMYK read Get_CMYK;
    property Parent: IDispatch read Get_Parent;
    property RGB: MsoRGBType read Get_RGB write Set_RGB;
    property SchemeColor: PbSchemeColorIndex read Get_SchemeColor write Set_SchemeColor;
    property Ink: SYSINT read Get_Ink write Set_Ink;
    property TintAndShade: Single read Get_TintAndShade write Set_TintAndShade;
    property Type_: PbColorType read Get_Type_;
  end;

// *********************************************************************//
// DispIntf:  ColorFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021264-0000-0000-C000-000000000046}
// *********************************************************************//
  ColorFormatDisp = dispinterface
    ['{00021264-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property BaseRGB: MsoRGBType dispid 2;
    property CMYK: ColorCMYK readonly dispid 3;
    property Parent: IDispatch readonly dispid 5;
    property RGB: MsoRGBType dispid 0;
    property SchemeColor: PbSchemeColorIndex dispid 6;
    property Ink: SYSINT dispid 7;
    property TintAndShade: Single dispid 8;
    property Type_: PbColorType readonly dispid 9;
  end;

// *********************************************************************//
// Interface: ColorCMYK
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3F53F6F6-EBC3-11D3-907C-00C04F799E3F}
// *********************************************************************//
  ColorCMYK = interface(IDispatch)
    ['{3F53F6F6-EBC3-11D3-907C-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Black: Integer; safecall;
    procedure Set_Black(Value: Integer); safecall;
    function  Get_Cyan: Integer; safecall;
    procedure Set_Cyan(Value: Integer); safecall;
    function  Get_Magenta: Integer; safecall;
    procedure Set_Magenta(Value: Integer); safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Yellow: Integer; safecall;
    procedure Set_Yellow(Value: Integer); safecall;
    procedure SetCMYK(Cyan: Integer; Magenta: Integer; Yellow: Integer; Black: Integer); safecall;
    property Application: Application read Get_Application;
    property Black: Integer read Get_Black write Set_Black;
    property Cyan: Integer read Get_Cyan write Set_Cyan;
    property Magenta: Integer read Get_Magenta write Set_Magenta;
    property Parent: IDispatch read Get_Parent;
    property Yellow: Integer read Get_Yellow write Set_Yellow;
  end;

// *********************************************************************//
// DispIntf:  ColorCMYKDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3F53F6F6-EBC3-11D3-907C-00C04F799E3F}
// *********************************************************************//
  ColorCMYKDisp = dispinterface
    ['{3F53F6F6-EBC3-11D3-907C-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Black: Integer dispid 2;
    property Cyan: Integer dispid 3;
    property Magenta: Integer dispid 4;
    property Parent: IDispatch readonly dispid 5;
    property Yellow: Integer dispid 6;
    procedure SetCMYK(Cyan: Integer; Magenta: Integer; Yellow: Integer; Black: Integer); dispid 7;
  end;

// *********************************************************************//
// Interface: Options
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {718713F2-BEF1-11D3-9077-00C04F799E3F}
// *********************************************************************//
  Options = interface(IDispatch)
    ['{718713F2-BEF1-11D3-9077-00C04F799E3F}']
    function  Get_AllowBackgroundSave: WordBool; safecall;
    procedure Set_AllowBackgroundSave(RetValue: WordBool); safecall;
    function  Get_Application: Application; safecall;
    function  Get_AutoFormatWord: WordBool; safecall;
    procedure Set_AutoFormatWord(RetValue: WordBool); safecall;
    function  Get_AutoHyphenate: WordBool; safecall;
    procedure Set_AutoHyphenate(RetValue: WordBool); safecall;
    function  Get_AutoSelectWord: WordBool; safecall;
    procedure Set_AutoSelectWord(RetValue: WordBool); safecall;
    function  Get_DisplayPrintTroubleshooter: WordBool; safecall;
    procedure Set_DisplayPrintTroubleshooter(RetValue: WordBool); safecall;
    function  Get_DisplayStatusBar: WordBool; safecall;
    procedure Set_DisplayStatusBar(RetValue: WordBool); safecall;
    function  Get_DragAndDropText: WordBool; safecall;
    procedure Set_DragAndDropText(RetValue: WordBool); safecall;
    function  Get_EnvelopePrintPlacement: PbPlacementType; safecall;
    procedure Set_EnvelopePrintPlacement(RetVal: PbPlacementType); safecall;
    function  Get_EnvelopePrintOrientation: PbOrientationType; safecall;
    procedure Set_EnvelopePrintOrientation(RetVal: PbOrientationType); safecall;
    function  Get_HyphenationZone: OleVariant; safecall;
    procedure Set_HyphenationZone(RetVal: OleVariant); safecall;
    function  Get_MeasurementUnit: PbUnitType; safecall;
    procedure Set_MeasurementUnit(RetVal: PbUnitType); safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_PathForPictures: WideString; safecall;
    procedure Set_PathForPictures(const RetValue: WideString); safecall;
    function  Get_PathForPublications: WideString; safecall;
    procedure Set_PathForPublications(const RetValue: WideString); safecall;
    function  Get_PrintLineByLine: WordBool; safecall;
    procedure Set_PrintLineByLine(RetValue: WordBool); safecall;
    function  Get_SaveAutoRecoverInfo: WordBool; safecall;
    procedure Set_SaveAutoRecoverInfo(RetValue: WordBool); safecall;
    function  Get_SaveAutoRecoverInfoInterval: Integer; safecall;
    procedure Set_SaveAutoRecoverInfoInterval(RetValue: Integer); safecall;
    function  Get_ShowBasicColors: WordBool; safecall;
    procedure Set_ShowBasicColors(RetValue: WordBool); safecall;
    function  Get_ShowScreenTipsOnObjects: WordBool; safecall;
    procedure Set_ShowScreenTipsOnObjects(RetValue: WordBool); safecall;
    function  Get_ShowTipPages: WordBool; safecall;
    procedure Set_ShowTipPages(RetValue: WordBool); safecall;
    function  Get_UpdatePersonalInfoOnSave: WordBool; safecall;
    procedure Set_UpdatePersonalInfoOnSave(RetValue: WordBool); safecall;
    function  Get_UseCatalogAtStartup: WordBool; safecall;
    procedure Set_UseCatalogAtStartup(RetValue: WordBool); safecall;
    function  Get_UseEnvelopePaperSizes: WordBool; safecall;
    procedure Set_UseEnvelopePaperSizes(RetValue: WordBool); safecall;
    function  Get_UseEnvelopePrintOptions: WordBool; safecall;
    procedure Set_UseEnvelopePrintOptions(RetValue: WordBool); safecall;
    function  Get_UseHelpfulMousePointers: WordBool; safecall;
    procedure Set_UseHelpfulMousePointers(RetValue: WordBool); safecall;
    procedure ResetTips; safecall;
    procedure ResetWizardSynchronizing; safecall;
    function  Get_DefaultPubDirection: PbDirectionType; safecall;
    procedure Set_DefaultPubDirection(RetValue: PbDirectionType); safecall;
    function  Get_SequenceCheck: WordBool; safecall;
    procedure Set_SequenceCheck(RetValue: WordBool); safecall;
    function  Get_TypeNReplace: WordBool; safecall;
    procedure Set_TypeNReplace(RetValue: WordBool); safecall;
    function  Get_AutoKeyboardSwitching: WordBool; safecall;
    procedure Set_AutoKeyboardSwitching(RetValue: WordBool); safecall;
    function  Get_DefaultTextFlowDirection: PbDirectionType; safecall;
    procedure Set_DefaultTextFlowDirection(RetValue: PbDirectionType); safecall;
    function  Get_AddHebDoubleQuote: WordBool; safecall;
    procedure Set_AddHebDoubleQuote(RetValue: WordBool); safecall;
    property AllowBackgroundSave: WordBool read Get_AllowBackgroundSave write Set_AllowBackgroundSave;
    property Application: Application read Get_Application;
    property AutoFormatWord: WordBool read Get_AutoFormatWord write Set_AutoFormatWord;
    property AutoHyphenate: WordBool read Get_AutoHyphenate write Set_AutoHyphenate;
    property AutoSelectWord: WordBool read Get_AutoSelectWord write Set_AutoSelectWord;
    property DisplayPrintTroubleshooter: WordBool read Get_DisplayPrintTroubleshooter write Set_DisplayPrintTroubleshooter;
    property DisplayStatusBar: WordBool read Get_DisplayStatusBar write Set_DisplayStatusBar;
    property DragAndDropText: WordBool read Get_DragAndDropText write Set_DragAndDropText;
    property EnvelopePrintPlacement: PbPlacementType read Get_EnvelopePrintPlacement write Set_EnvelopePrintPlacement;
    property EnvelopePrintOrientation: PbOrientationType read Get_EnvelopePrintOrientation write Set_EnvelopePrintOrientation;
    property HyphenationZone: OleVariant read Get_HyphenationZone write Set_HyphenationZone;
    property MeasurementUnit: PbUnitType read Get_MeasurementUnit write Set_MeasurementUnit;
    property Parent: IDispatch read Get_Parent;
    property PathForPictures: WideString read Get_PathForPictures write Set_PathForPictures;
    property PathForPublications: WideString read Get_PathForPublications write Set_PathForPublications;
    property PrintLineByLine: WordBool read Get_PrintLineByLine write Set_PrintLineByLine;
    property SaveAutoRecoverInfo: WordBool read Get_SaveAutoRecoverInfo write Set_SaveAutoRecoverInfo;
    property SaveAutoRecoverInfoInterval: Integer read Get_SaveAutoRecoverInfoInterval write Set_SaveAutoRecoverInfoInterval;
    property ShowBasicColors: WordBool read Get_ShowBasicColors write Set_ShowBasicColors;
    property ShowScreenTipsOnObjects: WordBool read Get_ShowScreenTipsOnObjects write Set_ShowScreenTipsOnObjects;
    property ShowTipPages: WordBool read Get_ShowTipPages write Set_ShowTipPages;
    property UpdatePersonalInfoOnSave: WordBool read Get_UpdatePersonalInfoOnSave write Set_UpdatePersonalInfoOnSave;
    property UseCatalogAtStartup: WordBool read Get_UseCatalogAtStartup write Set_UseCatalogAtStartup;
    property UseEnvelopePaperSizes: WordBool read Get_UseEnvelopePaperSizes write Set_UseEnvelopePaperSizes;
    property UseEnvelopePrintOptions: WordBool read Get_UseEnvelopePrintOptions write Set_UseEnvelopePrintOptions;
    property UseHelpfulMousePointers: WordBool read Get_UseHelpfulMousePointers write Set_UseHelpfulMousePointers;
    property DefaultPubDirection: PbDirectionType read Get_DefaultPubDirection write Set_DefaultPubDirection;
    property SequenceCheck: WordBool read Get_SequenceCheck write Set_SequenceCheck;
    property TypeNReplace: WordBool read Get_TypeNReplace write Set_TypeNReplace;
    property AutoKeyboardSwitching: WordBool read Get_AutoKeyboardSwitching write Set_AutoKeyboardSwitching;
    property DefaultTextFlowDirection: PbDirectionType read Get_DefaultTextFlowDirection write Set_DefaultTextFlowDirection;
    property AddHebDoubleQuote: WordBool read Get_AddHebDoubleQuote write Set_AddHebDoubleQuote;
  end;

// *********************************************************************//
// DispIntf:  OptionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {718713F2-BEF1-11D3-9077-00C04F799E3F}
// *********************************************************************//
  OptionsDisp = dispinterface
    ['{718713F2-BEF1-11D3-9077-00C04F799E3F}']
    property AllowBackgroundSave: WordBool dispid 1;
    property Application: Application readonly dispid 2;
    property AutoFormatWord: WordBool dispid 3;
    property AutoHyphenate: WordBool dispid 4;
    property AutoSelectWord: WordBool dispid 5;
    property DisplayPrintTroubleshooter: WordBool dispid 6;
    property DisplayStatusBar: WordBool dispid 7;
    property DragAndDropText: WordBool dispid 8;
    property EnvelopePrintPlacement: PbPlacementType dispid 9;
    property EnvelopePrintOrientation: PbOrientationType dispid 10;
    property HyphenationZone: OleVariant dispid 11;
    property MeasurementUnit: PbUnitType dispid 12;
    property Parent: IDispatch readonly dispid 13;
    property PathForPictures: WideString dispid 14;
    property PathForPublications: WideString dispid 15;
    property PrintLineByLine: WordBool dispid 16;
    property SaveAutoRecoverInfo: WordBool dispid 17;
    property SaveAutoRecoverInfoInterval: Integer dispid 18;
    property ShowBasicColors: WordBool dispid 19;
    property ShowScreenTipsOnObjects: WordBool dispid 20;
    property ShowTipPages: WordBool dispid 21;
    property UpdatePersonalInfoOnSave: WordBool dispid 23;
    property UseCatalogAtStartup: WordBool dispid 24;
    property UseEnvelopePaperSizes: WordBool dispid 25;
    property UseEnvelopePrintOptions: WordBool dispid 26;
    property UseHelpfulMousePointers: WordBool dispid 27;
    procedure ResetTips; dispid 28;
    procedure ResetWizardSynchronizing; dispid 29;
    property DefaultPubDirection: PbDirectionType dispid 30;
    property SequenceCheck: WordBool dispid 31;
    property TypeNReplace: WordBool dispid 32;
    property AutoKeyboardSwitching: WordBool dispid 33;
    property DefaultTextFlowDirection: PbDirectionType dispid 34;
    property AddHebDoubleQuote: WordBool dispid 35;
  end;

// *********************************************************************//
// Interface: Selection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8B9CAA7B-DEFA-11D2-8C78-00C04F8EF340}
// *********************************************************************//
  Selection = interface(IDispatch)
    ['{8B9CAA7B-DEFA-11D2-8C78-00C04F8EF340}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Type_: PbSelectionType; safecall;
    function  Get_ShapeRange: ShapeRange; safecall;
    function  Get_ChildShapeRange: ShapeRange; safecall;
    function  Get_TextRange: TextRange; safecall;
    function  Get_TableCellRange: CellRange; safecall;
    procedure Unselect; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Type_: PbSelectionType read Get_Type_;
    property ShapeRange: ShapeRange read Get_ShapeRange;
    property ChildShapeRange: ShapeRange read Get_ChildShapeRange;
    property TextRange: TextRange read Get_TextRange;
    property TableCellRange: CellRange read Get_TableCellRange;
  end;

// *********************************************************************//
// DispIntf:  SelectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8B9CAA7B-DEFA-11D2-8C78-00C04F8EF340}
// *********************************************************************//
  SelectionDisp = dispinterface
    ['{8B9CAA7B-DEFA-11D2-8C78-00C04F8EF340}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Type_: PbSelectionType readonly dispid 3;
    property ShapeRange: ShapeRange readonly dispid 4;
    property ChildShapeRange: ShapeRange readonly dispid 5;
    property TextRange: TextRange readonly dispid 6;
    property TableCellRange: CellRange readonly dispid 7;
    procedure Unselect; dispid 8;
  end;

// *********************************************************************//
// Interface: ShapeRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021260-0000-0000-C000-000000000046}
// *********************************************************************//
  ShapeRange = interface(IDispatch)
    ['{00021260-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Item(Index: OleVariant): Shape; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    procedure Apply; safecall;
    procedure Cut; safecall;
    procedure Copy; safecall;
    procedure Delete; safecall;
    function  Duplicate: ShapeRange; safecall;
    procedure Flip(FlipCmd: MsoFlipCmd); safecall;
    function  GetLeft(Unit_: PbUnitType): Single; safecall;
    function  GetTop(Unit_: PbUnitType): Single; safecall;
    function  GetHeight(Unit_: PbUnitType): Single; safecall;
    function  GetWidth(Unit_: PbUnitType): Single; safecall;
    procedure IncrementLeft(Increment: OleVariant); safecall;
    procedure IncrementRotation(Increment: Single); safecall;
    procedure IncrementTop(Increment: OleVariant); safecall;
    procedure PickUp; safecall;
    procedure RerouteConnections; safecall;
    procedure ScaleHeight(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); safecall;
    procedure ScaleWidth(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); safecall;
    procedure Select(Replace: OleVariant); safecall;
    procedure SetShapesDefaultProperties; safecall;
    function  Ungroup: ShapeRange; safecall;
    procedure ZOrder(ZOrderCmd: MsoZOrderCmd); safecall;
    function  Get_Adjustments: Adjustments; safecall;
    function  Get_AutoShapeType: MsoAutoShapeType; safecall;
    procedure Set_AutoShapeType(AutoShapeType: MsoAutoShapeType); safecall;
    function  Get_Callout: CalloutFormat; safecall;
    function  Get_ConnectionSiteCount: SYSINT; safecall;
    function  Get_Connector: MsoTriState; safecall;
    function  Get_ConnectorFormat: ConnectorFormat; safecall;
    function  Get_Fill: FillFormat; safecall;
    function  Get_GroupItems: GroupShapes; safecall;
    function  Get_Height: OleVariant; safecall;
    function  Get_HorizontalFlip: MsoTriState; safecall;
    function  Get_Left: OleVariant; safecall;
    function  Get_Line: LineFormat; safecall;
    function  Get_LockAspectRatio: MsoTriState; safecall;
    procedure Set_LockAspectRatio(LockAspectRatio: MsoTriState); safecall;
    function  Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function  Get_Nodes: ShapeNodes; safecall;
    function  Get_Rotation: Single; safecall;
    procedure Set_Rotation(Rotation: Single); safecall;
    function  Get_PictureFormat: PictureFormat; safecall;
    function  Get_Shadow: ShadowFormat; safecall;
    function  Get_TextEffect: TextEffectFormat; safecall;
    function  Get_TextFrame: TextFrame; safecall;
    function  Get_ThreeD: ThreeDFormat; safecall;
    function  Get_Top: OleVariant; safecall;
    function  Get_Type_: PbShapeType; safecall;
    function  Get_VerticalFlip: MsoTriState; safecall;
    function  Get_Vertices: OleVariant; safecall;
    function  Get_Width: OleVariant; safecall;
    function  Get_ZOrderPosition: SYSINT; safecall;
    function  Get_AlternativeText: WideString; safecall;
    procedure Set_AlternativeText(const AlternativeText: WideString); safecall;
    function  Get_HasTable: MsoTriState; safecall;
    function  Get_HasTextFrame: MsoTriState; safecall;
    function  Get_Hyperlink: Hyperlink; safecall;
    function  Get_WizardTag: PbWizardTag; safecall;
    procedure Set_WizardTag(WizardTag: PbWizardTag); safecall;
    function  Get_ID: Integer; safecall;
    function  Get_LinkFormat: LinkFormat; safecall;
    function  Get_OLEFormat: OLEFormat; safecall;
    function  Get_Table: Table; safecall;
    function  Get_Tags: Tags; safecall;
    function  Get_BlackWhiteMode: MsoBlackWhiteMode; safecall;
    procedure Set_BlackWhiteMode(BlackWhiteMode: MsoBlackWhiteMode); safecall;
    function  Get_WizardTagInstance: Integer; safecall;
    procedure Set_WizardTagInstance(WizardTagInstance: Integer); safecall;
    procedure Align(AlignCmd: MsoAlignCmd; RelativeTo: MsoTriState); safecall;
    procedure Distribute(DistributeCmd: MsoDistributeCmd; RelativeTo: MsoTriState); safecall;
    function  Group: Shape; safecall;
    function  Regroup: Shape; safecall;
    function  Get_TextWrap: WrapFormat; safecall;
    function  Get_Wizard: Wizard; safecall;
    function  Get_IsInline: MsoTriState; safecall;
    function  Get_InlineAlignment: PbInlineAlignment; safecall;
    procedure Set_InlineAlignment(Alignment: PbInlineAlignment); safecall;
    procedure MoveIntoTextFlow(const Range: TextRange); safecall;
    procedure MoveOutOfTextFlow; safecall;
    function  Get_InlineTextRange: TextRange; safecall;
    procedure AddToCatalogMergeArea; safecall;
    procedure RemoveFromCatalogMergeArea; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Adjustments: Adjustments read Get_Adjustments;
    property AutoShapeType: MsoAutoShapeType read Get_AutoShapeType write Set_AutoShapeType;
    property Callout: CalloutFormat read Get_Callout;
    property ConnectionSiteCount: SYSINT read Get_ConnectionSiteCount;
    property Connector: MsoTriState read Get_Connector;
    property ConnectorFormat: ConnectorFormat read Get_ConnectorFormat;
    property Fill: FillFormat read Get_Fill;
    property GroupItems: GroupShapes read Get_GroupItems;
    property Height: OleVariant read Get_Height;
    property HorizontalFlip: MsoTriState read Get_HorizontalFlip;
    property Left: OleVariant read Get_Left;
    property Line: LineFormat read Get_Line;
    property LockAspectRatio: MsoTriState read Get_LockAspectRatio write Set_LockAspectRatio;
    property Name: WideString read Get_Name write Set_Name;
    property Nodes: ShapeNodes read Get_Nodes;
    property Rotation: Single read Get_Rotation write Set_Rotation;
    property PictureFormat: PictureFormat read Get_PictureFormat;
    property Shadow: ShadowFormat read Get_Shadow;
    property TextEffect: TextEffectFormat read Get_TextEffect;
    property TextFrame: TextFrame read Get_TextFrame;
    property ThreeD: ThreeDFormat read Get_ThreeD;
    property Top: OleVariant read Get_Top;
    property Type_: PbShapeType read Get_Type_;
    property VerticalFlip: MsoTriState read Get_VerticalFlip;
    property Vertices: OleVariant read Get_Vertices;
    property Width: OleVariant read Get_Width;
    property ZOrderPosition: SYSINT read Get_ZOrderPosition;
    property AlternativeText: WideString read Get_AlternativeText write Set_AlternativeText;
    property HasTable: MsoTriState read Get_HasTable;
    property HasTextFrame: MsoTriState read Get_HasTextFrame;
    property Hyperlink: Hyperlink read Get_Hyperlink;
    property WizardTag: PbWizardTag read Get_WizardTag write Set_WizardTag;
    property ID: Integer read Get_ID;
    property LinkFormat: LinkFormat read Get_LinkFormat;
    property OLEFormat: OLEFormat read Get_OLEFormat;
    property Table: Table read Get_Table;
    property Tags: Tags read Get_Tags;
    property BlackWhiteMode: MsoBlackWhiteMode read Get_BlackWhiteMode write Set_BlackWhiteMode;
    property WizardTagInstance: Integer read Get_WizardTagInstance write Set_WizardTagInstance;
    property TextWrap: WrapFormat read Get_TextWrap;
    property Wizard: Wizard read Get_Wizard;
    property IsInline: MsoTriState read Get_IsInline;
    property InlineAlignment: PbInlineAlignment read Get_InlineAlignment write Set_InlineAlignment;
    property InlineTextRange: TextRange read Get_InlineTextRange;
  end;

// *********************************************************************//
// DispIntf:  ShapeRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021260-0000-0000-C000-000000000046}
// *********************************************************************//
  ShapeRangeDisp = dispinterface
    ['{00021260-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
    function  Item(Index: OleVariant): Shape; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    procedure Apply; dispid 10;
    procedure Cut; dispid 11;
    procedure Copy; dispid 12;
    procedure Delete; dispid 13;
    function  Duplicate: ShapeRange; dispid 14;
    procedure Flip(FlipCmd: MsoFlipCmd); dispid 15;
    function  GetLeft(Unit_: PbUnitType): Single; dispid 16;
    function  GetTop(Unit_: PbUnitType): Single; dispid 17;
    function  GetHeight(Unit_: PbUnitType): Single; dispid 18;
    function  GetWidth(Unit_: PbUnitType): Single; dispid 19;
    procedure IncrementLeft(Increment: OleVariant); dispid 20;
    procedure IncrementRotation(Increment: Single); dispid 21;
    procedure IncrementTop(Increment: OleVariant); dispid 22;
    procedure PickUp; dispid 23;
    procedure RerouteConnections; dispid 24;
    procedure ScaleHeight(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); dispid 25;
    procedure ScaleWidth(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); dispid 26;
    procedure Select(Replace: OleVariant); dispid 27;
    procedure SetShapesDefaultProperties; dispid 28;
    function  Ungroup: ShapeRange; dispid 29;
    procedure ZOrder(ZOrderCmd: MsoZOrderCmd); dispid 30;
    property Adjustments: Adjustments readonly dispid 31;
    property AutoShapeType: MsoAutoShapeType dispid 32;
    property Callout: CalloutFormat readonly dispid 33;
    property ConnectionSiteCount: SYSINT readonly dispid 34;
    property Connector: MsoTriState readonly dispid 35;
    property ConnectorFormat: ConnectorFormat readonly dispid 36;
    property Fill: FillFormat readonly dispid 37;
    property GroupItems: GroupShapes readonly dispid 38;
    property Height: OleVariant readonly dispid 39;
    property HorizontalFlip: MsoTriState readonly dispid 40;
    property Left: OleVariant readonly dispid 41;
    property Line: LineFormat readonly dispid 42;
    property LockAspectRatio: MsoTriState dispid 43;
    property Name: WideString dispid 44;
    property Nodes: ShapeNodes readonly dispid 45;
    property Rotation: Single dispid 46;
    property PictureFormat: PictureFormat readonly dispid 47;
    property Shadow: ShadowFormat readonly dispid 48;
    property TextEffect: TextEffectFormat readonly dispid 49;
    property TextFrame: TextFrame readonly dispid 50;
    property ThreeD: ThreeDFormat readonly dispid 51;
    property Top: OleVariant readonly dispid 52;
    property Type_: PbShapeType readonly dispid 53;
    property VerticalFlip: MsoTriState readonly dispid 54;
    property Vertices: OleVariant readonly dispid 55;
    property Width: OleVariant readonly dispid 57;
    property ZOrderPosition: SYSINT readonly dispid 58;
    property AlternativeText: WideString dispid 60;
    property HasTable: MsoTriState readonly dispid 61;
    property HasTextFrame: MsoTriState readonly dispid 62;
    property Hyperlink: Hyperlink readonly dispid 63;
    property WizardTag: PbWizardTag dispid 64;
    property ID: Integer readonly dispid 65;
    property LinkFormat: LinkFormat readonly dispid 66;
    property OLEFormat: OLEFormat readonly dispid 67;
    property Table: Table readonly dispid 68;
    property Tags: Tags readonly dispid 69;
    property BlackWhiteMode: MsoBlackWhiteMode dispid 70;
    property WizardTagInstance: Integer dispid 71;
    procedure Align(AlignCmd: MsoAlignCmd; RelativeTo: MsoTriState); dispid 100;
    procedure Distribute(DistributeCmd: MsoDistributeCmd; RelativeTo: MsoTriState); dispid 101;
    function  Group: Shape; dispid 102;
    function  Regroup: Shape; dispid 103;
    property TextWrap: WrapFormat readonly dispid 104;
    property Wizard: Wizard readonly dispid 105;
    property IsInline: MsoTriState readonly dispid 106;
    property InlineAlignment: PbInlineAlignment dispid 107;
    procedure MoveIntoTextFlow(const Range: TextRange); dispid 108;
    procedure MoveOutOfTextFlow; dispid 109;
    property InlineTextRange: TextRange readonly dispid 110;
    procedure AddToCatalogMergeArea; dispid 120;
    procedure RemoveFromCatalogMergeArea; dispid 121;
  end;

// *********************************************************************//
// Interface: Shape
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021237-0000-0000-C000-000000000046}
// *********************************************************************//
  Shape = interface(IDispatch)
    ['{00021237-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure Apply; safecall;
    procedure Cut; safecall;
    procedure Copy; safecall;
    procedure Delete; safecall;
    function  Duplicate: Shape; safecall;
    procedure Flip(FlipCmd: MsoFlipCmd); safecall;
    function  GetLeft(Unit_: PbUnitType): Single; safecall;
    function  GetTop(Unit_: PbUnitType): Single; safecall;
    function  GetHeight(Unit_: PbUnitType): Single; safecall;
    function  GetWidth(Unit_: PbUnitType): Single; safecall;
    procedure IncrementLeft(Increment: OleVariant); safecall;
    procedure IncrementRotation(Increment: Single); safecall;
    procedure IncrementTop(Increment: OleVariant); safecall;
    procedure PickUp; safecall;
    procedure RerouteConnections; safecall;
    procedure ScaleHeight(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); safecall;
    procedure ScaleWidth(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); safecall;
    procedure Select(Replace: OleVariant); safecall;
    procedure SetShapesDefaultProperties; safecall;
    function  Ungroup: ShapeRange; safecall;
    procedure ZOrder(ZOrderCmd: MsoZOrderCmd); safecall;
    function  Get_Adjustments: Adjustments; safecall;
    function  Get_AutoShapeType: MsoAutoShapeType; safecall;
    procedure Set_AutoShapeType(AutoShapeType: MsoAutoShapeType); safecall;
    function  Get_Callout: CalloutFormat; safecall;
    function  Get_ConnectionSiteCount: SYSINT; safecall;
    function  Get_Connector: MsoTriState; safecall;
    function  Get_ConnectorFormat: ConnectorFormat; safecall;
    function  Get_Fill: FillFormat; safecall;
    function  Get_GroupItems: GroupShapes; safecall;
    function  Get_Height: OleVariant; safecall;
    procedure Set_Height(Height: OleVariant); safecall;
    function  Get_HorizontalFlip: MsoTriState; safecall;
    function  Get_Left: OleVariant; safecall;
    procedure Set_Left(Left: OleVariant); safecall;
    function  Get_Line: LineFormat; safecall;
    function  Get_LockAspectRatio: MsoTriState; safecall;
    procedure Set_LockAspectRatio(LockAspectRatio: MsoTriState); safecall;
    function  Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function  Get_Nodes: ShapeNodes; safecall;
    function  Get_Rotation: Single; safecall;
    procedure Set_Rotation(Rotation: Single); safecall;
    function  Get_PictureFormat: PictureFormat; safecall;
    function  Get_Shadow: ShadowFormat; safecall;
    function  Get_TextEffect: TextEffectFormat; safecall;
    function  Get_TextFrame: TextFrame; safecall;
    function  Get_ThreeD: ThreeDFormat; safecall;
    function  Get_Top: OleVariant; safecall;
    procedure Set_Top(Top: OleVariant); safecall;
    function  Get_Type_: PbShapeType; safecall;
    function  Get_VerticalFlip: MsoTriState; safecall;
    function  Get_Vertices: OleVariant; safecall;
    function  Get_Width: OleVariant; safecall;
    procedure Set_Width(Width: OleVariant); safecall;
    function  Get_ZOrderPosition: SYSINT; safecall;
    function  Get_AlternativeText: WideString; safecall;
    procedure Set_AlternativeText(const AlternativeText: WideString); safecall;
    function  Get_HasTable: MsoTriState; safecall;
    function  Get_HasTextFrame: MsoTriState; safecall;
    function  Get_Hyperlink: Hyperlink; safecall;
    function  Get_WizardTag: PbWizardTag; safecall;
    procedure Set_WizardTag(WizardTag: PbWizardTag); safecall;
    function  Get_ID: Integer; safecall;
    function  Get_LinkFormat: LinkFormat; safecall;
    function  Get_OLEFormat: OLEFormat; safecall;
    function  Get_Table: Table; safecall;
    function  Get_Tags: Tags; safecall;
    function  Get_BlackWhiteMode: MsoBlackWhiteMode; safecall;
    procedure Set_BlackWhiteMode(BlackWhiteMode: MsoBlackWhiteMode); safecall;
    function  Get_IsGroupMember: WordBool; safecall;
    function  Get_ParentGroupShape: Shape; safecall;
    function  Get_WizardTagInstance: Integer; safecall;
    procedure Set_WizardTagInstance(Instance: Integer); safecall;
    function  Get_WebCommandButton: WebCommandButton; safecall;
    function  Get_WebListBox: WebListBox; safecall;
    function  Get_WebTextBox: WebTextBox; safecall;
    function  Get_WebOptionButton: WebOptionButton; safecall;
    function  Get_WebCheckBox: WebCheckBox; safecall;
    function  Get_Wizard: Wizard; safecall;
    function  Get_TextWrap: WrapFormat; safecall;
    function  Get_WebComponentFormat: IDispatch; safecall;
    function  Get_BorderArt: BorderArtFormat; safecall;
    function  Get_WebNavigationBarSetName: WideString; safecall;
    procedure AddToCatalogMergeArea; safecall;
    procedure RemoveFromCatalogMergeArea; safecall;
    function  Get_CatalogMergeItems: CatalogMergeShapes; safecall;
    procedure RemoveCatalogMergeArea; safecall;
    function  Get_IsInline: MsoTriState; safecall;
    function  Get_InlineTextRange: TextRange; safecall;
    function  Get_InlineAlignment: PbInlineAlignment; safecall;
    procedure Set_InlineAlignment(Alignment: PbInlineAlignment); safecall;
    procedure MoveIntoTextFlow(const Range: TextRange); safecall;
    procedure MoveOutOfTextFlow; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Adjustments: Adjustments read Get_Adjustments;
    property AutoShapeType: MsoAutoShapeType read Get_AutoShapeType write Set_AutoShapeType;
    property Callout: CalloutFormat read Get_Callout;
    property ConnectionSiteCount: SYSINT read Get_ConnectionSiteCount;
    property Connector: MsoTriState read Get_Connector;
    property ConnectorFormat: ConnectorFormat read Get_ConnectorFormat;
    property Fill: FillFormat read Get_Fill;
    property GroupItems: GroupShapes read Get_GroupItems;
    property Height: OleVariant read Get_Height write Set_Height;
    property HorizontalFlip: MsoTriState read Get_HorizontalFlip;
    property Left: OleVariant read Get_Left write Set_Left;
    property Line: LineFormat read Get_Line;
    property LockAspectRatio: MsoTriState read Get_LockAspectRatio write Set_LockAspectRatio;
    property Name: WideString read Get_Name write Set_Name;
    property Nodes: ShapeNodes read Get_Nodes;
    property Rotation: Single read Get_Rotation write Set_Rotation;
    property PictureFormat: PictureFormat read Get_PictureFormat;
    property Shadow: ShadowFormat read Get_Shadow;
    property TextEffect: TextEffectFormat read Get_TextEffect;
    property TextFrame: TextFrame read Get_TextFrame;
    property ThreeD: ThreeDFormat read Get_ThreeD;
    property Top: OleVariant read Get_Top write Set_Top;
    property Type_: PbShapeType read Get_Type_;
    property VerticalFlip: MsoTriState read Get_VerticalFlip;
    property Vertices: OleVariant read Get_Vertices;
    property Width: OleVariant read Get_Width write Set_Width;
    property ZOrderPosition: SYSINT read Get_ZOrderPosition;
    property AlternativeText: WideString read Get_AlternativeText write Set_AlternativeText;
    property HasTable: MsoTriState read Get_HasTable;
    property HasTextFrame: MsoTriState read Get_HasTextFrame;
    property Hyperlink: Hyperlink read Get_Hyperlink;
    property WizardTag: PbWizardTag read Get_WizardTag write Set_WizardTag;
    property ID: Integer read Get_ID;
    property LinkFormat: LinkFormat read Get_LinkFormat;
    property OLEFormat: OLEFormat read Get_OLEFormat;
    property Table: Table read Get_Table;
    property Tags: Tags read Get_Tags;
    property BlackWhiteMode: MsoBlackWhiteMode read Get_BlackWhiteMode write Set_BlackWhiteMode;
    property IsGroupMember: WordBool read Get_IsGroupMember;
    property ParentGroupShape: Shape read Get_ParentGroupShape;
    property WizardTagInstance: Integer read Get_WizardTagInstance write Set_WizardTagInstance;
    property WebCommandButton: WebCommandButton read Get_WebCommandButton;
    property WebListBox: WebListBox read Get_WebListBox;
    property WebTextBox: WebTextBox read Get_WebTextBox;
    property WebOptionButton: WebOptionButton read Get_WebOptionButton;
    property WebCheckBox: WebCheckBox read Get_WebCheckBox;
    property Wizard: Wizard read Get_Wizard;
    property TextWrap: WrapFormat read Get_TextWrap;
    property WebComponentFormat: IDispatch read Get_WebComponentFormat;
    property BorderArt: BorderArtFormat read Get_BorderArt;
    property WebNavigationBarSetName: WideString read Get_WebNavigationBarSetName;
    property CatalogMergeItems: CatalogMergeShapes read Get_CatalogMergeItems;
    property IsInline: MsoTriState read Get_IsInline;
    property InlineTextRange: TextRange read Get_InlineTextRange;
    property InlineAlignment: PbInlineAlignment read Get_InlineAlignment write Set_InlineAlignment;
  end;

// *********************************************************************//
// DispIntf:  ShapeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021237-0000-0000-C000-000000000046}
// *********************************************************************//
  ShapeDisp = dispinterface
    ['{00021237-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure Apply; dispid 10;
    procedure Cut; dispid 11;
    procedure Copy; dispid 12;
    procedure Delete; dispid 13;
    function  Duplicate: Shape; dispid 14;
    procedure Flip(FlipCmd: MsoFlipCmd); dispid 15;
    function  GetLeft(Unit_: PbUnitType): Single; dispid 16;
    function  GetTop(Unit_: PbUnitType): Single; dispid 17;
    function  GetHeight(Unit_: PbUnitType): Single; dispid 18;
    function  GetWidth(Unit_: PbUnitType): Single; dispid 19;
    procedure IncrementLeft(Increment: OleVariant); dispid 20;
    procedure IncrementRotation(Increment: Single); dispid 21;
    procedure IncrementTop(Increment: OleVariant); dispid 22;
    procedure PickUp; dispid 23;
    procedure RerouteConnections; dispid 24;
    procedure ScaleHeight(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); dispid 25;
    procedure ScaleWidth(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); dispid 26;
    procedure Select(Replace: OleVariant); dispid 27;
    procedure SetShapesDefaultProperties; dispid 28;
    function  Ungroup: ShapeRange; dispid 29;
    procedure ZOrder(ZOrderCmd: MsoZOrderCmd); dispid 30;
    property Adjustments: Adjustments readonly dispid 31;
    property AutoShapeType: MsoAutoShapeType dispid 32;
    property Callout: CalloutFormat readonly dispid 33;
    property ConnectionSiteCount: SYSINT readonly dispid 34;
    property Connector: MsoTriState readonly dispid 35;
    property ConnectorFormat: ConnectorFormat readonly dispid 36;
    property Fill: FillFormat readonly dispid 37;
    property GroupItems: GroupShapes readonly dispid 38;
    property Height: OleVariant dispid 39;
    property HorizontalFlip: MsoTriState readonly dispid 40;
    property Left: OleVariant dispid 41;
    property Line: LineFormat readonly dispid 42;
    property LockAspectRatio: MsoTriState dispid 43;
    property Name: WideString dispid 44;
    property Nodes: ShapeNodes readonly dispid 45;
    property Rotation: Single dispid 46;
    property PictureFormat: PictureFormat readonly dispid 47;
    property Shadow: ShadowFormat readonly dispid 48;
    property TextEffect: TextEffectFormat readonly dispid 49;
    property TextFrame: TextFrame readonly dispid 50;
    property ThreeD: ThreeDFormat readonly dispid 51;
    property Top: OleVariant dispid 52;
    property Type_: PbShapeType readonly dispid 53;
    property VerticalFlip: MsoTriState readonly dispid 54;
    property Vertices: OleVariant readonly dispid 55;
    property Width: OleVariant dispid 57;
    property ZOrderPosition: SYSINT readonly dispid 58;
    property AlternativeText: WideString dispid 60;
    property HasTable: MsoTriState readonly dispid 61;
    property HasTextFrame: MsoTriState readonly dispid 62;
    property Hyperlink: Hyperlink readonly dispid 63;
    property WizardTag: PbWizardTag dispid 64;
    property ID: Integer readonly dispid 65;
    property LinkFormat: LinkFormat readonly dispid 66;
    property OLEFormat: OLEFormat readonly dispid 67;
    property Table: Table readonly dispid 68;
    property Tags: Tags readonly dispid 69;
    property BlackWhiteMode: MsoBlackWhiteMode dispid 70;
    property IsGroupMember: WordBool readonly dispid 71;
    property ParentGroupShape: Shape readonly dispid 72;
    property WizardTagInstance: Integer dispid 73;
    property WebCommandButton: WebCommandButton readonly dispid 74;
    property WebListBox: WebListBox readonly dispid 75;
    property WebTextBox: WebTextBox readonly dispid 76;
    property WebOptionButton: WebOptionButton readonly dispid 77;
    property WebCheckBox: WebCheckBox readonly dispid 78;
    property Wizard: Wizard readonly dispid 79;
    property TextWrap: WrapFormat readonly dispid 80;
    property WebComponentFormat: IDispatch readonly dispid 96;
    property BorderArt: BorderArtFormat readonly dispid 103;
    property WebNavigationBarSetName: WideString readonly dispid 105;
    procedure AddToCatalogMergeArea; dispid 110;
    procedure RemoveFromCatalogMergeArea; dispid 111;
    property CatalogMergeItems: CatalogMergeShapes readonly dispid 112;
    procedure RemoveCatalogMergeArea; dispid 113;
    property IsInline: MsoTriState readonly dispid 114;
    property InlineTextRange: TextRange readonly dispid 115;
    property InlineAlignment: PbInlineAlignment dispid 116;
    procedure MoveIntoTextFlow(const Range: TextRange); dispid 117;
    procedure MoveOutOfTextFlow; dispid 118;
  end;

// *********************************************************************//
// Interface: Adjustments
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021262-0000-0000-C000-000000000046}
// *********************************************************************//
  Adjustments = interface(IDispatch)
    ['{00021262-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Get_Item(Index: SYSINT): OleVariant; safecall;
    procedure Set_Item(Index: SYSINT; Val: OleVariant); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property Item[Index: SYSINT]: OleVariant read Get_Item write Set_Item; default;
  end;

// *********************************************************************//
// DispIntf:  AdjustmentsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021262-0000-0000-C000-000000000046}
// *********************************************************************//
  AdjustmentsDisp = dispinterface
    ['{00021262-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
    property Item[Index: SYSINT]: OleVariant dispid 0; default;
  end;

// *********************************************************************//
// Interface: CalloutFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021263-0000-0000-C000-000000000046}
// *********************************************************************//
  CalloutFormat = interface(IDispatch)
    ['{00021263-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure AutomaticLength; safecall;
    procedure CustomDrop(Drop: OleVariant); safecall;
    procedure CustomLength(Length: OleVariant); safecall;
    procedure PresetDrop(DropType: MsoCalloutDropType); safecall;
    function  Get_Accent: MsoTriState; safecall;
    procedure Set_Accent(Accent: MsoTriState); safecall;
    function  Get_Angle: MsoCalloutAngleType; safecall;
    procedure Set_Angle(Angle: MsoCalloutAngleType); safecall;
    function  Get_AutoAttach: MsoTriState; safecall;
    procedure Set_AutoAttach(AutoAttach: MsoTriState); safecall;
    function  Get_AutoLength: MsoTriState; safecall;
    function  Get_Border: MsoTriState; safecall;
    procedure Set_Border(Border: MsoTriState); safecall;
    function  Get_Drop: OleVariant; safecall;
    function  Get_DropType: MsoCalloutDropType; safecall;
    function  Get_Gap: OleVariant; safecall;
    procedure Set_Gap(Gap: OleVariant); safecall;
    function  Get_Length: OleVariant; safecall;
    function  Get_Type_: MsoCalloutType; safecall;
    procedure Set_Type_(Type_: MsoCalloutType); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Accent: MsoTriState read Get_Accent write Set_Accent;
    property Angle: MsoCalloutAngleType read Get_Angle write Set_Angle;
    property AutoAttach: MsoTriState read Get_AutoAttach write Set_AutoAttach;
    property AutoLength: MsoTriState read Get_AutoLength;
    property Border: MsoTriState read Get_Border write Set_Border;
    property Drop: OleVariant read Get_Drop;
    property DropType: MsoCalloutDropType read Get_DropType;
    property Gap: OleVariant read Get_Gap write Set_Gap;
    property Length: OleVariant read Get_Length;
    property Type_: MsoCalloutType read Get_Type_ write Set_Type_;
  end;

// *********************************************************************//
// DispIntf:  CalloutFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021263-0000-0000-C000-000000000046}
// *********************************************************************//
  CalloutFormatDisp = dispinterface
    ['{00021263-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure AutomaticLength; dispid 10;
    procedure CustomDrop(Drop: OleVariant); dispid 11;
    procedure CustomLength(Length: OleVariant); dispid 12;
    procedure PresetDrop(DropType: MsoCalloutDropType); dispid 13;
    property Accent: MsoTriState dispid 100;
    property Angle: MsoCalloutAngleType dispid 101;
    property AutoAttach: MsoTriState dispid 102;
    property AutoLength: MsoTriState readonly dispid 103;
    property Border: MsoTriState dispid 104;
    property Drop: OleVariant readonly dispid 105;
    property DropType: MsoCalloutDropType readonly dispid 106;
    property Gap: OleVariant dispid 107;
    property Length: OleVariant readonly dispid 108;
    property Type_: MsoCalloutType dispid 109;
  end;

// *********************************************************************//
// Interface: ConnectorFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021265-0000-0000-C000-000000000046}
// *********************************************************************//
  ConnectorFormat = interface(IDispatch)
    ['{00021265-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure BeginConnect(const ConnectedShape: Shape; ConnectionSite: SYSINT); safecall;
    procedure BeginDisconnect; safecall;
    procedure EndConnect(const ConnectedShape: Shape; ConnectionSite: SYSINT); safecall;
    procedure EndDisconnect; safecall;
    function  Get_BeginConnected: MsoTriState; safecall;
    function  Get_BeginConnectedShape: Shape; safecall;
    function  Get_BeginConnectionSite: SYSINT; safecall;
    function  Get_EndConnected: MsoTriState; safecall;
    function  Get_EndConnectedShape: Shape; safecall;
    function  Get_EndConnectionSite: SYSINT; safecall;
    function  Get_Type_: MsoConnectorType; safecall;
    procedure Set_Type_(Type_: MsoConnectorType); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property BeginConnected: MsoTriState read Get_BeginConnected;
    property BeginConnectedShape: Shape read Get_BeginConnectedShape;
    property BeginConnectionSite: SYSINT read Get_BeginConnectionSite;
    property EndConnected: MsoTriState read Get_EndConnected;
    property EndConnectedShape: Shape read Get_EndConnectedShape;
    property EndConnectionSite: SYSINT read Get_EndConnectionSite;
    property Type_: MsoConnectorType read Get_Type_ write Set_Type_;
  end;

// *********************************************************************//
// DispIntf:  ConnectorFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021265-0000-0000-C000-000000000046}
// *********************************************************************//
  ConnectorFormatDisp = dispinterface
    ['{00021265-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure BeginConnect(const ConnectedShape: Shape; ConnectionSite: SYSINT); dispid 10;
    procedure BeginDisconnect; dispid 11;
    procedure EndConnect(const ConnectedShape: Shape; ConnectionSite: SYSINT); dispid 12;
    procedure EndDisconnect; dispid 13;
    property BeginConnected: MsoTriState readonly dispid 100;
    property BeginConnectedShape: Shape readonly dispid 101;
    property BeginConnectionSite: SYSINT readonly dispid 102;
    property EndConnected: MsoTriState readonly dispid 103;
    property EndConnectedShape: Shape readonly dispid 104;
    property EndConnectionSite: SYSINT readonly dispid 105;
    property Type_: MsoConnectorType dispid 106;
  end;

// *********************************************************************//
// Interface: FillFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021261-0000-0000-C000-000000000046}
// *********************************************************************//
  FillFormat = interface(IDispatch)
    ['{00021261-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure OneColorGradient(Style: MsoGradientStyle; Variant: SYSINT; Degree: Single); safecall;
    procedure Patterned(Pattern: MsoPatternType); safecall;
    procedure PresetGradient(Style: MsoGradientStyle; Variant: SYSINT; 
                             PresetGradientType: MsoPresetGradientType); safecall;
    procedure PresetTextured(PresetTexture: MsoPresetTexture); safecall;
    procedure Solid; safecall;
    procedure TwoColorGradient(Style: MsoGradientStyle; Variant: SYSINT); safecall;
    procedure UserPicture(const PictureFile: WideString); safecall;
    procedure UserTextured(const TextureFile: WideString); safecall;
    function  Get_BackColor: ColorFormat; safecall;
    procedure Set_BackColor(const BackColor: ColorFormat); safecall;
    function  Get_ForeColor: ColorFormat; safecall;
    procedure Set_ForeColor(const ForeColor: ColorFormat); safecall;
    function  Get_GradientColorType: MsoGradientColorType; safecall;
    function  Get_GradientDegree: Single; safecall;
    function  Get_GradientStyle: MsoGradientStyle; safecall;
    function  Get_GradientVariant: SYSINT; safecall;
    function  Get_Pattern: MsoPatternType; safecall;
    function  Get_PresetGradientType: MsoPresetGradientType; safecall;
    function  Get_PresetTexture: MsoPresetTexture; safecall;
    function  Get_TextureName: WideString; safecall;
    function  Get_TextureType: MsoTextureType; safecall;
    function  Get_Transparency: Single; safecall;
    procedure Set_Transparency(Transparency: Single); safecall;
    function  Get_Type_: MsoFillType; safecall;
    function  Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property BackColor: ColorFormat read Get_BackColor write Set_BackColor;
    property ForeColor: ColorFormat read Get_ForeColor write Set_ForeColor;
    property GradientColorType: MsoGradientColorType read Get_GradientColorType;
    property GradientDegree: Single read Get_GradientDegree;
    property GradientStyle: MsoGradientStyle read Get_GradientStyle;
    property GradientVariant: SYSINT read Get_GradientVariant;
    property Pattern: MsoPatternType read Get_Pattern;
    property PresetGradientType: MsoPresetGradientType read Get_PresetGradientType;
    property PresetTexture: MsoPresetTexture read Get_PresetTexture;
    property TextureName: WideString read Get_TextureName;
    property TextureType: MsoTextureType read Get_TextureType;
    property Transparency: Single read Get_Transparency write Set_Transparency;
    property Type_: MsoFillType read Get_Type_;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  FillFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021261-0000-0000-C000-000000000046}
// *********************************************************************//
  FillFormatDisp = dispinterface
    ['{00021261-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure OneColorGradient(Style: MsoGradientStyle; Variant: SYSINT; Degree: Single); dispid 11;
    procedure Patterned(Pattern: MsoPatternType); dispid 12;
    procedure PresetGradient(Style: MsoGradientStyle; Variant: SYSINT; 
                             PresetGradientType: MsoPresetGradientType); dispid 13;
    procedure PresetTextured(PresetTexture: MsoPresetTexture); dispid 14;
    procedure Solid; dispid 15;
    procedure TwoColorGradient(Style: MsoGradientStyle; Variant: SYSINT); dispid 16;
    procedure UserPicture(const PictureFile: WideString); dispid 17;
    procedure UserTextured(const TextureFile: WideString); dispid 18;
    property BackColor: ColorFormat dispid 100;
    property ForeColor: ColorFormat dispid 101;
    property GradientColorType: MsoGradientColorType readonly dispid 102;
    property GradientDegree: Single readonly dispid 103;
    property GradientStyle: MsoGradientStyle readonly dispid 104;
    property GradientVariant: SYSINT readonly dispid 105;
    property Pattern: MsoPatternType readonly dispid 106;
    property PresetGradientType: MsoPresetGradientType readonly dispid 107;
    property PresetTexture: MsoPresetTexture readonly dispid 108;
    property TextureName: WideString readonly dispid 109;
    property TextureType: MsoTextureType readonly dispid 110;
    property Transparency: Single dispid 111;
    property Type_: MsoFillType readonly dispid 112;
    property Visible: MsoTriState dispid 113;
  end;

// *********************************************************************//
// Interface: GroupShapes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021267-0000-0000-C000-000000000046}
// *********************************************************************//
  GroupShapes = interface(IDispatch)
    ['{00021267-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Item(Index: OleVariant): Shape; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  GroupShapesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021267-0000-0000-C000-000000000046}
// *********************************************************************//
  GroupShapesDisp = dispinterface
    ['{00021267-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
    function  Item(Index: OleVariant): Shape; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: LineFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021268-0000-0000-C000-000000000046}
// *********************************************************************//
  LineFormat = interface(IDispatch)
    ['{00021268-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_BackColor: ColorFormat; safecall;
    procedure Set_BackColor(const BackColor: ColorFormat); safecall;
    function  Get_BeginArrowheadLength: MsoArrowheadLength; safecall;
    procedure Set_BeginArrowheadLength(BeginArrowheadLength: MsoArrowheadLength); safecall;
    function  Get_BeginArrowheadStyle: MsoArrowheadStyle; safecall;
    procedure Set_BeginArrowheadStyle(BeginArrowheadStyle: MsoArrowheadStyle); safecall;
    function  Get_BeginArrowheadWidth: MsoArrowheadWidth; safecall;
    procedure Set_BeginArrowheadWidth(BeginArrowheadWidth: MsoArrowheadWidth); safecall;
    function  Get_DashStyle: MsoLineDashStyle; safecall;
    procedure Set_DashStyle(DashStyle: MsoLineDashStyle); safecall;
    function  Get_EndArrowheadLength: MsoArrowheadLength; safecall;
    procedure Set_EndArrowheadLength(EndArrowheadLength: MsoArrowheadLength); safecall;
    function  Get_EndArrowheadStyle: MsoArrowheadStyle; safecall;
    procedure Set_EndArrowheadStyle(EndArrowheadStyle: MsoArrowheadStyle); safecall;
    function  Get_EndArrowheadWidth: MsoArrowheadWidth; safecall;
    procedure Set_EndArrowheadWidth(EndArrowheadWidth: MsoArrowheadWidth); safecall;
    function  Get_ForeColor: ColorFormat; safecall;
    procedure Set_ForeColor(const ForeColor: ColorFormat); safecall;
    function  Get_Pattern: MsoPatternType; safecall;
    procedure Set_Pattern(Pattern: MsoPatternType); safecall;
    function  Get_Style: MsoLineStyle; safecall;
    procedure Set_Style(Style: MsoLineStyle); safecall;
    function  Get_Transparency: Single; safecall;
    procedure Set_Transparency(Transparency: Single); safecall;
    function  Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    function  Get_Weight: OleVariant; safecall;
    procedure Set_Weight(Weight: OleVariant); safecall;
    function  Get_InsetPen: MsoTriState; safecall;
    procedure Set_InsetPen(Visible: MsoTriState); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property BackColor: ColorFormat read Get_BackColor write Set_BackColor;
    property BeginArrowheadLength: MsoArrowheadLength read Get_BeginArrowheadLength write Set_BeginArrowheadLength;
    property BeginArrowheadStyle: MsoArrowheadStyle read Get_BeginArrowheadStyle write Set_BeginArrowheadStyle;
    property BeginArrowheadWidth: MsoArrowheadWidth read Get_BeginArrowheadWidth write Set_BeginArrowheadWidth;
    property DashStyle: MsoLineDashStyle read Get_DashStyle write Set_DashStyle;
    property EndArrowheadLength: MsoArrowheadLength read Get_EndArrowheadLength write Set_EndArrowheadLength;
    property EndArrowheadStyle: MsoArrowheadStyle read Get_EndArrowheadStyle write Set_EndArrowheadStyle;
    property EndArrowheadWidth: MsoArrowheadWidth read Get_EndArrowheadWidth write Set_EndArrowheadWidth;
    property ForeColor: ColorFormat read Get_ForeColor write Set_ForeColor;
    property Pattern: MsoPatternType read Get_Pattern write Set_Pattern;
    property Style: MsoLineStyle read Get_Style write Set_Style;
    property Transparency: Single read Get_Transparency write Set_Transparency;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property Weight: OleVariant read Get_Weight write Set_Weight;
    property InsetPen: MsoTriState read Get_InsetPen write Set_InsetPen;
  end;

// *********************************************************************//
// DispIntf:  LineFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021268-0000-0000-C000-000000000046}
// *********************************************************************//
  LineFormatDisp = dispinterface
    ['{00021268-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property BackColor: ColorFormat dispid 100;
    property BeginArrowheadLength: MsoArrowheadLength dispid 101;
    property BeginArrowheadStyle: MsoArrowheadStyle dispid 102;
    property BeginArrowheadWidth: MsoArrowheadWidth dispid 103;
    property DashStyle: MsoLineDashStyle dispid 104;
    property EndArrowheadLength: MsoArrowheadLength dispid 105;
    property EndArrowheadStyle: MsoArrowheadStyle dispid 106;
    property EndArrowheadWidth: MsoArrowheadWidth dispid 107;
    property ForeColor: ColorFormat dispid 108;
    property Pattern: MsoPatternType dispid 109;
    property Style: MsoLineStyle dispid 110;
    property Transparency: Single dispid 111;
    property Visible: MsoTriState dispid 112;
    property Weight: OleVariant dispid 113;
    property InsetPen: MsoTriState dispid 114;
  end;

// *********************************************************************//
// Interface: ShapeNodes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021269-0000-0000-C000-000000000046}
// *********************************************************************//
  ShapeNodes = interface(IDispatch)
    ['{00021269-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Item(Index: OleVariant): ShapeNode; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    procedure Delete(Index: SYSINT); safecall;
    procedure Insert(Index: SYSINT; SegmentType: MsoSegmentType; EditingType: MsoEditingType; 
                     X1: OleVariant; Y1: OleVariant; X2: OleVariant; Y2: OleVariant; 
                     X3: OleVariant; Y3: OleVariant); safecall;
    procedure SetEditingType(Index: SYSINT; EditingType: MsoEditingType); safecall;
    procedure SetPosition(Index: SYSINT; X1: OleVariant; Y1: OleVariant); safecall;
    procedure SetSegmentType(Index: SYSINT; SegmentType: MsoSegmentType); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  ShapeNodesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021269-0000-0000-C000-000000000046}
// *********************************************************************//
  ShapeNodesDisp = dispinterface
    ['{00021269-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
    function  Item(Index: OleVariant): ShapeNode; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    procedure Delete(Index: SYSINT); dispid 11;
    procedure Insert(Index: SYSINT; SegmentType: MsoSegmentType; EditingType: MsoEditingType; 
                     X1: OleVariant; Y1: OleVariant; X2: OleVariant; Y2: OleVariant; 
                     X3: OleVariant; Y3: OleVariant); dispid 12;
    procedure SetEditingType(Index: SYSINT; EditingType: MsoEditingType); dispid 13;
    procedure SetPosition(Index: SYSINT; X1: OleVariant; Y1: OleVariant); dispid 14;
    procedure SetSegmentType(Index: SYSINT; SegmentType: MsoSegmentType); dispid 15;
  end;

// *********************************************************************//
// Interface: ShapeNode
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126A-0000-0000-C000-000000000046}
// *********************************************************************//
  ShapeNode = interface(IDispatch)
    ['{0002126A-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_EditingType: MsoEditingType; safecall;
    function  Get_Points: OleVariant; safecall;
    function  Get_SegmentType: MsoSegmentType; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property EditingType: MsoEditingType read Get_EditingType;
    property Points: OleVariant read Get_Points;
    property SegmentType: MsoSegmentType read Get_SegmentType;
  end;

// *********************************************************************//
// DispIntf:  ShapeNodeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126A-0000-0000-C000-000000000046}
// *********************************************************************//
  ShapeNodeDisp = dispinterface
    ['{0002126A-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property EditingType: MsoEditingType readonly dispid 100;
    property Points: OleVariant readonly dispid 101;
    property SegmentType: MsoSegmentType readonly dispid 102;
  end;

// *********************************************************************//
// Interface: PictureFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126B-0000-0000-C000-000000000046}
// *********************************************************************//
  PictureFormat = interface(IDispatch)
    ['{0002126B-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure IncrementBrightness(Increment: Single); safecall;
    procedure IncrementContrast(Increment: Single); safecall;
    function  Get_Brightness: Single; safecall;
    procedure Set_Brightness(Brightness: Single); safecall;
    function  Get_ColorType: MsoPictureColorType; safecall;
    procedure Set_ColorType(ColorType: MsoPictureColorType); safecall;
    function  Get_Contrast: Single; safecall;
    procedure Set_Contrast(Contrast: Single); safecall;
    function  Get_CropBottom: OleVariant; safecall;
    procedure Set_CropBottom(CropBottom: OleVariant); safecall;
    function  Get_CropLeft: OleVariant; safecall;
    procedure Set_CropLeft(CropLeft: OleVariant); safecall;
    function  Get_CropRight: OleVariant; safecall;
    procedure Set_CropRight(CropRight: OleVariant); safecall;
    function  Get_CropTop: OleVariant; safecall;
    procedure Set_CropTop(CropTop: OleVariant); safecall;
    function  Get_TransparencyColor: MsoRGBType; safecall;
    procedure Set_TransparencyColor(TransparencyColor: MsoRGBType); safecall;
    function  Get_TransparentBackground: MsoTriState; safecall;
    procedure Set_TransparentBackground(TransparentBackground: MsoTriState); safecall;
    function  Get_VerticalPictureLocking: PbVerticalPictureLocking; safecall;
    procedure Set_VerticalPictureLocking(VerticalPictureLocking: PbVerticalPictureLocking); safecall;
    function  Get_HorizontalPictureLocking: PbHorizontalPictureLocking; safecall;
    procedure Set_HorizontalPictureLocking(HorizontalPictureLocking: PbHorizontalPictureLocking); safecall;
    function  Get_ColorModel: PbColorModel; safecall;
    function  Get_ColorsInPalette: Integer; safecall;
    function  Get_EffectiveResolution: Integer; safecall;
    function  Get_Filename: WideString; safecall;
    function  Get_FileSize: Integer; safecall;
    function  Get_HasAlphaChannel: MsoTriState; safecall;
    function  Get_Height: OleVariant; safecall;
    function  Get_HorizontalScale: Integer; safecall;
    function  Get_ImageFormat: PbImageFormat; safecall;
    function  Get_IsGreyScale: MsoTriState; safecall;
    function  Get_IsLinked: MsoTriState; safecall;
    function  Get_IsTrueColor: MsoTriState; safecall;
    function  Get_OriginalColorsInPalette: Integer; safecall;
    function  Get_OriginalFileSize: Integer; safecall;
    function  Get_OriginalHasAlphaChannel: MsoTriState; safecall;
    function  Get_OriginalHeight: OleVariant; safecall;
    function  Get_OriginalIsTrueColor: MsoTriState; safecall;
    function  Get_OriginalResolution: Integer; safecall;
    function  Get_OriginalWidth: OleVariant; safecall;
    function  Get_VerticalScale: Integer; safecall;
    function  Get_Width: OleVariant; safecall;
    procedure Replace(const Pathname: WideString; InsertAs: PbPictureInsertAs); safecall;
    function  Get_LinkedFileStatus: PbLinkedFileStatus; safecall;
    function  Get_IsEmpty: MsoTriState; safecall;
    function  Get_HasTransparencyColor: WordBool; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Brightness: Single read Get_Brightness write Set_Brightness;
    property ColorType: MsoPictureColorType read Get_ColorType write Set_ColorType;
    property Contrast: Single read Get_Contrast write Set_Contrast;
    property CropBottom: OleVariant read Get_CropBottom write Set_CropBottom;
    property CropLeft: OleVariant read Get_CropLeft write Set_CropLeft;
    property CropRight: OleVariant read Get_CropRight write Set_CropRight;
    property CropTop: OleVariant read Get_CropTop write Set_CropTop;
    property TransparencyColor: MsoRGBType read Get_TransparencyColor write Set_TransparencyColor;
    property TransparentBackground: MsoTriState read Get_TransparentBackground write Set_TransparentBackground;
    property VerticalPictureLocking: PbVerticalPictureLocking read Get_VerticalPictureLocking write Set_VerticalPictureLocking;
    property HorizontalPictureLocking: PbHorizontalPictureLocking read Get_HorizontalPictureLocking write Set_HorizontalPictureLocking;
    property ColorModel: PbColorModel read Get_ColorModel;
    property ColorsInPalette: Integer read Get_ColorsInPalette;
    property EffectiveResolution: Integer read Get_EffectiveResolution;
    property Filename: WideString read Get_Filename;
    property FileSize: Integer read Get_FileSize;
    property HasAlphaChannel: MsoTriState read Get_HasAlphaChannel;
    property Height: OleVariant read Get_Height;
    property HorizontalScale: Integer read Get_HorizontalScale;
    property ImageFormat: PbImageFormat read Get_ImageFormat;
    property IsGreyScale: MsoTriState read Get_IsGreyScale;
    property IsLinked: MsoTriState read Get_IsLinked;
    property IsTrueColor: MsoTriState read Get_IsTrueColor;
    property OriginalColorsInPalette: Integer read Get_OriginalColorsInPalette;
    property OriginalFileSize: Integer read Get_OriginalFileSize;
    property OriginalHasAlphaChannel: MsoTriState read Get_OriginalHasAlphaChannel;
    property OriginalHeight: OleVariant read Get_OriginalHeight;
    property OriginalIsTrueColor: MsoTriState read Get_OriginalIsTrueColor;
    property OriginalResolution: Integer read Get_OriginalResolution;
    property OriginalWidth: OleVariant read Get_OriginalWidth;
    property VerticalScale: Integer read Get_VerticalScale;
    property Width: OleVariant read Get_Width;
    property LinkedFileStatus: PbLinkedFileStatus read Get_LinkedFileStatus;
    property IsEmpty: MsoTriState read Get_IsEmpty;
    property HasTransparencyColor: WordBool read Get_HasTransparencyColor;
  end;

// *********************************************************************//
// DispIntf:  PictureFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126B-0000-0000-C000-000000000046}
// *********************************************************************//
  PictureFormatDisp = dispinterface
    ['{0002126B-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure IncrementBrightness(Increment: Single); dispid 10;
    procedure IncrementContrast(Increment: Single); dispid 11;
    property Brightness: Single dispid 100;
    property ColorType: MsoPictureColorType dispid 101;
    property Contrast: Single dispid 102;
    property CropBottom: OleVariant dispid 103;
    property CropLeft: OleVariant dispid 104;
    property CropRight: OleVariant dispid 105;
    property CropTop: OleVariant dispid 106;
    property TransparencyColor: MsoRGBType dispid 107;
    property TransparentBackground: MsoTriState dispid 108;
    property VerticalPictureLocking: PbVerticalPictureLocking dispid 109;
    property HorizontalPictureLocking: PbHorizontalPictureLocking dispid 110;
    property ColorModel: PbColorModel readonly dispid 111;
    property ColorsInPalette: Integer readonly dispid 112;
    property EffectiveResolution: Integer readonly dispid 113;
    property Filename: WideString readonly dispid 114;
    property FileSize: Integer readonly dispid 115;
    property HasAlphaChannel: MsoTriState readonly dispid 116;
    property Height: OleVariant readonly dispid 117;
    property HorizontalScale: Integer readonly dispid 118;
    property ImageFormat: PbImageFormat readonly dispid 119;
    property IsGreyScale: MsoTriState readonly dispid 120;
    property IsLinked: MsoTriState readonly dispid 121;
    property IsTrueColor: MsoTriState readonly dispid 122;
    property OriginalColorsInPalette: Integer readonly dispid 123;
    property OriginalFileSize: Integer readonly dispid 124;
    property OriginalHasAlphaChannel: MsoTriState readonly dispid 125;
    property OriginalHeight: OleVariant readonly dispid 126;
    property OriginalIsTrueColor: MsoTriState readonly dispid 127;
    property OriginalResolution: Integer readonly dispid 128;
    property OriginalWidth: OleVariant readonly dispid 129;
    property VerticalScale: Integer readonly dispid 130;
    property Width: OleVariant readonly dispid 131;
    procedure Replace(const Pathname: WideString; InsertAs: PbPictureInsertAs); dispid 132;
    property LinkedFileStatus: PbLinkedFileStatus readonly dispid 133;
    property IsEmpty: MsoTriState readonly dispid 134;
    property HasTransparencyColor: WordBool readonly dispid 135;
  end;

// *********************************************************************//
// Interface: ShadowFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126C-0000-0000-C000-000000000046}
// *********************************************************************//
  ShadowFormat = interface(IDispatch)
    ['{0002126C-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure IncrementOffsetX(Increment: OleVariant); safecall;
    procedure IncrementOffsetY(Increment: OleVariant); safecall;
    function  Get_ForeColor: ColorFormat; safecall;
    procedure Set_ForeColor(const ForeColor: ColorFormat); safecall;
    function  Get_Obscured: MsoTriState; safecall;
    procedure Set_Obscured(Obscured: MsoTriState); safecall;
    function  Get_OffsetX: OleVariant; safecall;
    procedure Set_OffsetX(OffsetX: OleVariant); safecall;
    function  Get_OffsetY: OleVariant; safecall;
    procedure Set_OffsetY(OffsetY: OleVariant); safecall;
    function  Get_Transparency: Single; safecall;
    procedure Set_Transparency(Transparency: Single); safecall;
    function  Get_Type_: MsoShadowType; safecall;
    procedure Set_Type_(Type_: MsoShadowType); safecall;
    function  Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ForeColor: ColorFormat read Get_ForeColor write Set_ForeColor;
    property Obscured: MsoTriState read Get_Obscured write Set_Obscured;
    property OffsetX: OleVariant read Get_OffsetX write Set_OffsetX;
    property OffsetY: OleVariant read Get_OffsetY write Set_OffsetY;
    property Transparency: Single read Get_Transparency write Set_Transparency;
    property Type_: MsoShadowType read Get_Type_ write Set_Type_;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  ShadowFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126C-0000-0000-C000-000000000046}
// *********************************************************************//
  ShadowFormatDisp = dispinterface
    ['{0002126C-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure IncrementOffsetX(Increment: OleVariant); dispid 10;
    procedure IncrementOffsetY(Increment: OleVariant); dispid 11;
    property ForeColor: ColorFormat dispid 100;
    property Obscured: MsoTriState dispid 101;
    property OffsetX: OleVariant dispid 102;
    property OffsetY: OleVariant dispid 103;
    property Transparency: Single dispid 104;
    property Type_: MsoShadowType dispid 105;
    property Visible: MsoTriState dispid 106;
  end;

// *********************************************************************//
// Interface: TextEffectFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126D-0000-0000-C000-000000000046}
// *********************************************************************//
  TextEffectFormat = interface(IDispatch)
    ['{0002126D-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure ToggleVerticalText; safecall;
    function  Get_Alignment: MsoTextEffectAlignment; safecall;
    procedure Set_Alignment(Alignment: MsoTextEffectAlignment); safecall;
    function  Get_FontBold: MsoTriState; safecall;
    procedure Set_FontBold(FontBold: MsoTriState); safecall;
    function  Get_FontItalic: MsoTriState; safecall;
    procedure Set_FontItalic(FontItalic: MsoTriState); safecall;
    function  Get_FontName: WideString; safecall;
    procedure Set_FontName(const FontName: WideString); safecall;
    function  Get_FontSize: OleVariant; safecall;
    procedure Set_FontSize(FontSize: OleVariant); safecall;
    function  Get_KernedPairs: MsoTriState; safecall;
    procedure Set_KernedPairs(KernedPairs: MsoTriState); safecall;
    function  Get_NormalizedHeight: MsoTriState; safecall;
    procedure Set_NormalizedHeight(NormalizedHeight: MsoTriState); safecall;
    function  Get_PresetShape: MsoPresetTextEffectShape; safecall;
    procedure Set_PresetShape(PresetShape: MsoPresetTextEffectShape); safecall;
    function  Get_PresetTextEffect: MsoPresetTextEffect; safecall;
    procedure Set_PresetTextEffect(Preset: MsoPresetTextEffect); safecall;
    function  Get_RotatedChars: MsoTriState; safecall;
    procedure Set_RotatedChars(RotatedChars: MsoTriState); safecall;
    function  Get_Text: WideString; safecall;
    procedure Set_Text(const Text: WideString); safecall;
    function  Get_Tracking: OleVariant; safecall;
    procedure Set_Tracking(Tracking: OleVariant); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Alignment: MsoTextEffectAlignment read Get_Alignment write Set_Alignment;
    property FontBold: MsoTriState read Get_FontBold write Set_FontBold;
    property FontItalic: MsoTriState read Get_FontItalic write Set_FontItalic;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: OleVariant read Get_FontSize write Set_FontSize;
    property KernedPairs: MsoTriState read Get_KernedPairs write Set_KernedPairs;
    property NormalizedHeight: MsoTriState read Get_NormalizedHeight write Set_NormalizedHeight;
    property PresetShape: MsoPresetTextEffectShape read Get_PresetShape write Set_PresetShape;
    property PresetTextEffect: MsoPresetTextEffect read Get_PresetTextEffect write Set_PresetTextEffect;
    property RotatedChars: MsoTriState read Get_RotatedChars write Set_RotatedChars;
    property Text: WideString read Get_Text write Set_Text;
    property Tracking: OleVariant read Get_Tracking write Set_Tracking;
  end;

// *********************************************************************//
// DispIntf:  TextEffectFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126D-0000-0000-C000-000000000046}
// *********************************************************************//
  TextEffectFormatDisp = dispinterface
    ['{0002126D-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure ToggleVerticalText; dispid 10;
    property Alignment: MsoTextEffectAlignment dispid 100;
    property FontBold: MsoTriState dispid 101;
    property FontItalic: MsoTriState dispid 102;
    property FontName: WideString dispid 103;
    property FontSize: OleVariant dispid 104;
    property KernedPairs: MsoTriState dispid 105;
    property NormalizedHeight: MsoTriState dispid 106;
    property PresetShape: MsoPresetTextEffectShape dispid 107;
    property PresetTextEffect: MsoPresetTextEffect dispid 108;
    property RotatedChars: MsoTriState dispid 109;
    property Text: WideString dispid 110;
    property Tracking: OleVariant dispid 111;
  end;

// *********************************************************************//
// Interface: TextFrame
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126E-0000-0000-C000-000000000046}
// *********************************************************************//
  TextFrame = interface(IDispatch)
    ['{0002126E-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_TextRange: TextRange; safecall;
    function  Get_AutoFitText: PbTextAutoFitType; safecall;
    procedure Set_AutoFitText(AutoFit: PbTextAutoFitType); safecall;
    function  Get_Columns: Integer; safecall;
    procedure Set_Columns(Columns: Integer); safecall;
    function  Get_ColumnSpacing: OleVariant; safecall;
    procedure Set_ColumnSpacing(Spacing: OleVariant); safecall;
    function  Get_HasNextLink: MsoTriState; safecall;
    function  Get_HasPreviousLink: MsoTriState; safecall;
    function  Get_HasText: MsoTriState; safecall;
    function  Get_MarginLeft: OleVariant; safecall;
    procedure Set_MarginLeft(Margin: OleVariant); safecall;
    function  Get_MarginTop: OleVariant; safecall;
    procedure Set_MarginTop(Margin: OleVariant); safecall;
    function  Get_MarginRight: OleVariant; safecall;
    procedure Set_MarginRight(Margin: OleVariant); safecall;
    function  Get_MarginBottom: OleVariant; safecall;
    procedure Set_MarginBottom(Margin: OleVariant); safecall;
    function  Get_NextLinkedTextFrame: TextFrame; safecall;
    procedure Set_NextLinkedTextFrame(const Next: TextFrame); safecall;
    function  Get_Overflowing: MsoTriState; safecall;
    function  Get_PreviousLinkedTextFrame: TextFrame; safecall;
    function  Get_Orientation: PbTextOrientation; safecall;
    procedure Set_Orientation(Orientation: PbTextOrientation); safecall;
    function  Get_VerticalTextAlignment: PbVerticalTextAlignmentType; safecall;
    procedure Set_VerticalTextAlignment(Alignment: PbVerticalTextAlignmentType); safecall;
    procedure BreakForwardLink; safecall;
    function  ValidLinkTarget(const LinkTarget: Shape): WordBool; safecall;
    function  Get_Story: Story; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property TextRange: TextRange read Get_TextRange;
    property AutoFitText: PbTextAutoFitType read Get_AutoFitText write Set_AutoFitText;
    property Columns: Integer read Get_Columns write Set_Columns;
    property ColumnSpacing: OleVariant read Get_ColumnSpacing write Set_ColumnSpacing;
    property HasNextLink: MsoTriState read Get_HasNextLink;
    property HasPreviousLink: MsoTriState read Get_HasPreviousLink;
    property HasText: MsoTriState read Get_HasText;
    property MarginLeft: OleVariant read Get_MarginLeft write Set_MarginLeft;
    property MarginTop: OleVariant read Get_MarginTop write Set_MarginTop;
    property MarginRight: OleVariant read Get_MarginRight write Set_MarginRight;
    property MarginBottom: OleVariant read Get_MarginBottom write Set_MarginBottom;
    property NextLinkedTextFrame: TextFrame read Get_NextLinkedTextFrame write Set_NextLinkedTextFrame;
    property Overflowing: MsoTriState read Get_Overflowing;
    property PreviousLinkedTextFrame: TextFrame read Get_PreviousLinkedTextFrame;
    property Orientation: PbTextOrientation read Get_Orientation write Set_Orientation;
    property VerticalTextAlignment: PbVerticalTextAlignmentType read Get_VerticalTextAlignment write Set_VerticalTextAlignment;
    property Story: Story read Get_Story;
  end;

// *********************************************************************//
// DispIntf:  TextFrameDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126E-0000-0000-C000-000000000046}
// *********************************************************************//
  TextFrameDisp = dispinterface
    ['{0002126E-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property TextRange: TextRange readonly dispid 3;
    property AutoFitText: PbTextAutoFitType dispid 6;
    property Columns: Integer dispid 8;
    property ColumnSpacing: OleVariant dispid 9;
    property HasNextLink: MsoTriState readonly dispid 10;
    property HasPreviousLink: MsoTriState readonly dispid 11;
    property HasText: MsoTriState readonly dispid 12;
    property MarginLeft: OleVariant dispid 14;
    property MarginTop: OleVariant dispid 15;
    property MarginRight: OleVariant dispid 16;
    property MarginBottom: OleVariant dispid 17;
    property NextLinkedTextFrame: TextFrame dispid 18;
    property Overflowing: MsoTriState readonly dispid 19;
    property PreviousLinkedTextFrame: TextFrame readonly dispid 20;
    property Orientation: PbTextOrientation dispid 23;
    property VerticalTextAlignment: PbVerticalTextAlignmentType dispid 24;
    procedure BreakForwardLink; dispid 25;
    function  ValidLinkTarget(const LinkTarget: Shape): WordBool; dispid 26;
    property Story: Story readonly dispid 27;
  end;

// *********************************************************************//
// Interface: TextRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002124A-0000-0000-C000-000000000046}
// *********************************************************************//
  TextRange = interface(IDispatch)
    ['{0002124A-0000-0000-C000-000000000046}']
    function  Get_Text: WideString; safecall;
    procedure Set_Text(const RetValue: WideString); safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Font: Font; safecall;
    procedure Set_Font(const RetVal: Font); safecall;
    procedure Collapse(Direction: PbCollapseDirection); safecall;
    function  Expand(Unit_: PbTextUnit): Integer; safecall;
    function  Move(Unit_: PbTextUnit; Size: Integer): Integer; safecall;
    function  MoveStart(Unit_: PbTextUnit; Size: Integer): Integer; safecall;
    function  MoveEnd(Unit_: PbTextUnit; Size: Integer): Integer; safecall;
    function  Characters(Start: Integer; Length: Integer): TextRange; safecall;
    function  Get_Length: Integer; safecall;
    function  Get_Start: Integer; safecall;
    procedure Set_Start(Start: Integer); safecall;
    function  Get_End_: Integer; safecall;
    procedure Set_End_(End_: Integer); safecall;
    function  Get_BoundLeft: Single; safecall;
    function  Get_BoundHeight: Single; safecall;
    function  Get_BoundTop: Single; safecall;
    function  Get_BoundWidth: Single; safecall;
    function  Get_ParagraphFormat: ParagraphFormat; safecall;
    procedure Set_ParagraphFormat(const ppPara: ParagraphFormat); safecall;
    function  InsertAfter(const NewText: WideString): TextRange; safecall;
    function  InsertBefore(const NewText: WideString): TextRange; safecall;
    function  InsertSymbol(const FontName: WideString; CharIndex: Integer): TextRange; safecall;
    function  InsertDateTime(Format: PbDateTimeFormat; InsertAsField: WordBool; 
                             InsertAsFullWidth: WordBool; Language: MsoLanguageID; 
                             Calendar: PbCalendarType): TextRange; safecall;
    function  Paragraphs(Start: Integer; Length: Integer): TextRange; safecall;
    function  Lines(Start: Integer; Length: Integer): TextRange; safecall;
    function  Words(Start: Integer; Length: Integer): TextRange; safecall;
    procedure Select; safecall;
    function  Get_ContainingObject: IDispatch; safecall;
    function  Get_Duplicate: TextRange; safecall;
    function  Get_MajorityFont: Font; safecall;
    function  Get_MajorityParagraphFormat: ParagraphFormat; safecall;
    function  Get_Fields: Fields; safecall;
    function  Get_Story: Story; safecall;
    function  Get_LanguageID: MsoLanguageID; safecall;
    procedure Set_LanguageID(Language: MsoLanguageID); safecall;
    function  Get_DropCap: DropCap; safecall;
    procedure Cut; safecall;
    procedure Copy; safecall;
    procedure Delete; safecall;
    function  Paste: TextRange; safecall;
    function  InsertMailMergeField(varIndex: OleVariant): TextRange; safecall;
    function  Get_Script: PbFontScriptType; safecall;
    function  Get_Hyperlinks: Hyperlinks; safecall;
    function  InsertPageNumber(Type_: PbPageNumberType): TextRange; safecall;
    function  Get_Find: FindReplace; safecall;
    function  Get_InlineShapes: InlineShapes; safecall;
    property Text: WideString read Get_Text write Set_Text;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Font: Font read Get_Font write Set_Font;
    property Length: Integer read Get_Length;
    property Start: Integer read Get_Start write Set_Start;
    property End_: Integer read Get_End_ write Set_End_;
    property BoundLeft: Single read Get_BoundLeft;
    property BoundHeight: Single read Get_BoundHeight;
    property BoundTop: Single read Get_BoundTop;
    property BoundWidth: Single read Get_BoundWidth;
    property ParagraphFormat: ParagraphFormat read Get_ParagraphFormat write Set_ParagraphFormat;
    property ContainingObject: IDispatch read Get_ContainingObject;
    property Duplicate: TextRange read Get_Duplicate;
    property MajorityFont: Font read Get_MajorityFont;
    property MajorityParagraphFormat: ParagraphFormat read Get_MajorityParagraphFormat;
    property Fields: Fields read Get_Fields;
    property Story: Story read Get_Story;
    property LanguageID: MsoLanguageID read Get_LanguageID write Set_LanguageID;
    property DropCap: DropCap read Get_DropCap;
    property Script: PbFontScriptType read Get_Script;
    property Hyperlinks: Hyperlinks read Get_Hyperlinks;
    property Find: FindReplace read Get_Find;
    property InlineShapes: InlineShapes read Get_InlineShapes;
  end;

// *********************************************************************//
// DispIntf:  TextRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002124A-0000-0000-C000-000000000046}
// *********************************************************************//
  TextRangeDisp = dispinterface
    ['{0002124A-0000-0000-C000-000000000046}']
    property Text: WideString dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Font: Font dispid 3;
    procedure Collapse(Direction: PbCollapseDirection); dispid 4;
    function  Expand(Unit_: PbTextUnit): Integer; dispid 5;
    function  Move(Unit_: PbTextUnit; Size: Integer): Integer; dispid 6;
    function  MoveStart(Unit_: PbTextUnit; Size: Integer): Integer; dispid 7;
    function  MoveEnd(Unit_: PbTextUnit; Size: Integer): Integer; dispid 8;
    function  Characters(Start: Integer; Length: Integer): TextRange; dispid 9;
    property Length: Integer readonly dispid 10;
    property Start: Integer dispid 11;
    property End_: Integer dispid 12;
    property BoundLeft: Single readonly dispid 13;
    property BoundHeight: Single readonly dispid 14;
    property BoundTop: Single readonly dispid 15;
    property BoundWidth: Single readonly dispid 16;
    property ParagraphFormat: ParagraphFormat dispid 17;
    function  InsertAfter(const NewText: WideString): TextRange; dispid 20;
    function  InsertBefore(const NewText: WideString): TextRange; dispid 21;
    function  InsertSymbol(const FontName: WideString; CharIndex: Integer): TextRange; dispid 24;
    function  InsertDateTime(Format: PbDateTimeFormat; InsertAsField: WordBool; 
                             InsertAsFullWidth: WordBool; Language: MsoLanguageID; 
                             Calendar: PbCalendarType): TextRange; dispid 25;
    function  Paragraphs(Start: Integer; Length: Integer): TextRange; dispid 26;
    function  Lines(Start: Integer; Length: Integer): TextRange; dispid 27;
    function  Words(Start: Integer; Length: Integer): TextRange; dispid 28;
    procedure Select; dispid 29;
    property ContainingObject: IDispatch readonly dispid 31;
    property Duplicate: TextRange readonly dispid 32;
    property MajorityFont: Font readonly dispid 33;
    property MajorityParagraphFormat: ParagraphFormat readonly dispid 34;
    property Fields: Fields readonly dispid 35;
    property Story: Story readonly dispid 36;
    property LanguageID: MsoLanguageID dispid 37;
    property DropCap: DropCap readonly dispid 38;
    procedure Cut; dispid 39;
    procedure Copy; dispid 40;
    procedure Delete; dispid 41;
    function  Paste: TextRange; dispid 42;
    function  InsertMailMergeField(varIndex: OleVariant): TextRange; dispid 43;
    property Script: PbFontScriptType readonly dispid 44;
    property Hyperlinks: Hyperlinks readonly dispid 45;
    function  InsertPageNumber(Type_: PbPageNumberType): TextRange; dispid 47;
    property Find: FindReplace readonly dispid 51;
    property InlineShapes: InlineShapes readonly dispid 52;
  end;

// *********************************************************************//
// Interface: Font
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002124E-0000-0000-C000-000000000046}
// *********************************************************************//
  Font = interface(IDispatch)
    ['{0002124E-0000-0000-C000-000000000046}']
    function  Get_Name: WideString; safecall;
    procedure Set_Name(const FontName: WideString); safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Bold: MsoTriState; safecall;
    procedure Set_Bold(Bold: MsoTriState); safecall;
    function  Get_BoldBi: MsoTriState; safecall;
    procedure Set_BoldBi(Bold: MsoTriState); safecall;
    function  Get_Size: OleVariant; safecall;
    procedure Set_Size(Size: OleVariant); safecall;
    function  Get_SizeBi: OleVariant; safecall;
    procedure Set_SizeBi(Size: OleVariant); safecall;
    function  Get_AllCaps: MsoTriState; safecall;
    procedure Set_AllCaps(AllCaps: MsoTriState); safecall;
    function  Get_Emboss: MsoTriState; safecall;
    procedure Set_Emboss(Emboss: MsoTriState); safecall;
    function  Get_Engrave: MsoTriState; safecall;
    procedure Set_Engrave(Engrave: MsoTriState); safecall;
    function  Get_Italic: MsoTriState; safecall;
    procedure Set_Italic(Italic: MsoTriState); safecall;
    function  Get_ItalicBi: MsoTriState; safecall;
    procedure Set_ItalicBi(Italic: MsoTriState); safecall;
    function  Get_Outline: MsoTriState; safecall;
    procedure Set_Outline(Outline: MsoTriState); safecall;
    function  Get_SmallCaps: MsoTriState; safecall;
    procedure Set_SmallCaps(SmallCaps: MsoTriState); safecall;
    function  Get_SuperScript: MsoTriState; safecall;
    procedure Set_SuperScript(SuperScript: MsoTriState); safecall;
    function  Get_SubScript: MsoTriState; safecall;
    procedure Set_SubScript(SubScript: MsoTriState); safecall;
    function  Get_Shadow: MsoTriState; safecall;
    procedure Set_Shadow(Shadow: MsoTriState); safecall;
    function  Get_AutomaticPairKerningThreshold: OleVariant; safecall;
    procedure Set_AutomaticPairKerningThreshold(Threshold: OleVariant); safecall;
    function  Get_Kerning: OleVariant; safecall;
    procedure Set_Kerning(Kerning: OleVariant); safecall;
    function  Get_Scaling: OleVariant; safecall;
    procedure Set_Scaling(Scaling: OleVariant); safecall;
    function  Get_Tracking: OleVariant; safecall;
    procedure Set_Tracking(TrackingValue: OleVariant); safecall;
    function  Get_Color: ColorFormat; safecall;
    function  Get_TrackingPreset: PbTrackingPresetType; safecall;
    procedure Set_TrackingPreset(Preset: PbTrackingPresetType); safecall;
    function  Get_Underline: PbUnderlineType; safecall;
    procedure Set_Underline(Underline: PbUnderlineType); safecall;
    function  Get_Position: OleVariant; safecall;
    procedure Set_Position(Position: OleVariant); safecall;
    function  Get_AttachedToText: WordBool; safecall;
    procedure Grow; safecall;
    procedure Shrink; safecall;
    function  Duplicate: Font; safecall;
    procedure Reset; safecall;
    function  GetScriptName(Script: PbFontScriptType): WideString; safecall;
    procedure SetScriptName(Script: PbFontScriptType; const FontName: WideString); safecall;
    function  Get_UseDiacriticColor: MsoTriState; safecall;
    procedure Set_UseDiacriticColor(UseDiacriticColor: MsoTriState); safecall;
    function  Get_DiacriticColor: ColorFormat; safecall;
    function  Get_ExpandUsingKashida: MsoTriState; safecall;
    procedure Set_ExpandUsingKashida(RetValue: MsoTriState); safecall;
    property Name: WideString read Get_Name write Set_Name;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Bold: MsoTriState read Get_Bold write Set_Bold;
    property BoldBi: MsoTriState read Get_BoldBi write Set_BoldBi;
    property Size: OleVariant read Get_Size write Set_Size;
    property SizeBi: OleVariant read Get_SizeBi write Set_SizeBi;
    property AllCaps: MsoTriState read Get_AllCaps write Set_AllCaps;
    property Emboss: MsoTriState read Get_Emboss write Set_Emboss;
    property Engrave: MsoTriState read Get_Engrave write Set_Engrave;
    property Italic: MsoTriState read Get_Italic write Set_Italic;
    property ItalicBi: MsoTriState read Get_ItalicBi write Set_ItalicBi;
    property Outline: MsoTriState read Get_Outline write Set_Outline;
    property SmallCaps: MsoTriState read Get_SmallCaps write Set_SmallCaps;
    property SuperScript: MsoTriState read Get_SuperScript write Set_SuperScript;
    property SubScript: MsoTriState read Get_SubScript write Set_SubScript;
    property Shadow: MsoTriState read Get_Shadow write Set_Shadow;
    property AutomaticPairKerningThreshold: OleVariant read Get_AutomaticPairKerningThreshold write Set_AutomaticPairKerningThreshold;
    property Kerning: OleVariant read Get_Kerning write Set_Kerning;
    property Scaling: OleVariant read Get_Scaling write Set_Scaling;
    property Tracking: OleVariant read Get_Tracking write Set_Tracking;
    property Color: ColorFormat read Get_Color;
    property TrackingPreset: PbTrackingPresetType read Get_TrackingPreset write Set_TrackingPreset;
    property Underline: PbUnderlineType read Get_Underline write Set_Underline;
    property Position: OleVariant read Get_Position write Set_Position;
    property AttachedToText: WordBool read Get_AttachedToText;
    property UseDiacriticColor: MsoTriState read Get_UseDiacriticColor write Set_UseDiacriticColor;
    property DiacriticColor: ColorFormat read Get_DiacriticColor;
    property ExpandUsingKashida: MsoTriState read Get_ExpandUsingKashida write Set_ExpandUsingKashida;
  end;

// *********************************************************************//
// DispIntf:  FontDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002124E-0000-0000-C000-000000000046}
// *********************************************************************//
  FontDisp = dispinterface
    ['{0002124E-0000-0000-C000-000000000046}']
    property Name: WideString dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Bold: MsoTriState dispid 3;
    property BoldBi: MsoTriState dispid 4;
    property Size: OleVariant dispid 5;
    property SizeBi: OleVariant dispid 6;
    property AllCaps: MsoTriState dispid 7;
    property Emboss: MsoTriState dispid 8;
    property Engrave: MsoTriState dispid 9;
    property Italic: MsoTriState dispid 10;
    property ItalicBi: MsoTriState dispid 11;
    property Outline: MsoTriState dispid 12;
    property SmallCaps: MsoTriState dispid 13;
    property SuperScript: MsoTriState dispid 14;
    property SubScript: MsoTriState dispid 15;
    property Shadow: MsoTriState dispid 16;
    property AutomaticPairKerningThreshold: OleVariant dispid 17;
    property Kerning: OleVariant dispid 18;
    property Scaling: OleVariant dispid 19;
    property Tracking: OleVariant dispid 20;
    property Color: ColorFormat readonly dispid 21;
    property TrackingPreset: PbTrackingPresetType dispid 22;
    property Underline: PbUnderlineType dispid 23;
    property Position: OleVariant dispid 24;
    property AttachedToText: WordBool readonly dispid 25;
    procedure Grow; dispid 26;
    procedure Shrink; dispid 27;
    function  Duplicate: Font; dispid 28;
    procedure Reset; dispid 29;
    function  GetScriptName(Script: PbFontScriptType): WideString; dispid 30;
    procedure SetScriptName(Script: PbFontScriptType; const FontName: WideString); dispid 31;
    property UseDiacriticColor: MsoTriState dispid 32;
    property DiacriticColor: ColorFormat readonly dispid 33;
    property ExpandUsingKashida: MsoTriState dispid 34;
  end;

// *********************************************************************//
// Interface: ParagraphFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BD876261-4399-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  ParagraphFormat = interface(IDispatch)
    ['{BD876261-4399-11D3-B65B-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Alignment: PbParagraphAlignmentType; safecall;
    procedure Set_Alignment(Alignment: PbParagraphAlignmentType); safecall;
    function  Get_FirstLineIndent: OleVariant; safecall;
    procedure Set_FirstLineIndent(Indent: OleVariant); safecall;
    function  Get_LeftIndent: OleVariant; safecall;
    procedure Set_LeftIndent(Indent: OleVariant); safecall;
    function  Get_RightIndent: OleVariant; safecall;
    procedure Set_RightIndent(Indent: OleVariant); safecall;
    function  Get_SpaceAfter: OleVariant; safecall;
    procedure Set_SpaceAfter(Spacing: OleVariant); safecall;
    function  Get_SpaceBefore: OleVariant; safecall;
    procedure Set_SpaceBefore(Spacing: OleVariant); safecall;
    function  Get_LineSpacing: OleVariant; safecall;
    procedure Set_LineSpacing(Spacing: OleVariant); safecall;
    function  Get_LineSpacingRule: PbLineSpacingRule; safecall;
    procedure Set_LineSpacingRule(Spacing: PbLineSpacingRule); safecall;
    function  Get_Tabs: TabStops; safecall;
    function  Get_TextDirection: PbTextDirection; safecall;
    procedure Set_TextDirection(Direction: PbTextDirection); safecall;
    function  Get_TextStyle: OleVariant; safecall;
    procedure Set_TextStyle(StyleIndex: OleVariant); safecall;
    procedure Reset; safecall;
    function  Duplicate: ParagraphFormat; safecall;
    procedure SetLineSpacing(Rule: PbLineSpacingRule; Spacing: OleVariant); safecall;
    function  Get_AttachedToText: WordBool; safecall;
    function  Get_KashidaPercentage: Integer; safecall;
    procedure Set_KashidaPercentage(pPercent: Integer); safecall;
    procedure SetListType(Value: PbListType; const BulletText: WideString); safecall;
    function  Get_ListType: PbListType; safecall;
    function  Get_ListIndent: Single; safecall;
    procedure Set_ListIndent(Value: OleVariant); safecall;
    function  Get_ListBulletText: WideString; safecall;
    function  Get_ListBulletFontSize: Single; safecall;
    procedure Set_ListBulletFontSize(ptsSize: OleVariant); safecall;
    function  Get_ListBulletFontName: WideString; safecall;
    procedure Set_ListBulletFontName(const FontName: WideString); safecall;
    function  Get_ListNumberSeparator: PbListSeparator; safecall;
    procedure Set_ListNumberSeparator(Value: PbListSeparator); safecall;
    function  Get_ListNumberStart: Integer; safecall;
    procedure Set_ListNumberStart(Value: Integer); safecall;
    function  Get_CharBasedFirstLineIndent: Integer; safecall;
    procedure Set_CharBasedFirstLineIndent(Chars: Integer); safecall;
    function  Get_UseCharBasedFirstLineIndent: MsoTriState; safecall;
    procedure Set_UseCharBasedFirstLineIndent(UseCharIndent: MsoTriState); safecall;
    function  Get_WidowControl: MsoTriState; safecall;
    procedure Set_WidowControl(WidowControl: MsoTriState); safecall;
    function  Get_KeepLinesTogether: MsoTriState; safecall;
    procedure Set_KeepLinesTogether(KeepLinesTogether: MsoTriState); safecall;
    function  Get_KeepWithNext: MsoTriState; safecall;
    procedure Set_KeepWithNext(KeepWithNext: MsoTriState); safecall;
    function  Get_StartInNextTextBox: MsoTriState; safecall;
    procedure Set_StartInNextTextBox(StartInNextTextBox: MsoTriState); safecall;
    function  Get_LockToBaseLine: MsoTriState; safecall;
    procedure Set_LockToBaseLine(LockToBaseLine: MsoTriState); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Alignment: PbParagraphAlignmentType read Get_Alignment write Set_Alignment;
    property FirstLineIndent: OleVariant read Get_FirstLineIndent write Set_FirstLineIndent;
    property LeftIndent: OleVariant read Get_LeftIndent write Set_LeftIndent;
    property RightIndent: OleVariant read Get_RightIndent write Set_RightIndent;
    property SpaceAfter: OleVariant read Get_SpaceAfter write Set_SpaceAfter;
    property SpaceBefore: OleVariant read Get_SpaceBefore write Set_SpaceBefore;
    property LineSpacing: OleVariant read Get_LineSpacing write Set_LineSpacing;
    property LineSpacingRule: PbLineSpacingRule read Get_LineSpacingRule write Set_LineSpacingRule;
    property Tabs: TabStops read Get_Tabs;
    property TextDirection: PbTextDirection read Get_TextDirection write Set_TextDirection;
    property TextStyle: OleVariant read Get_TextStyle write Set_TextStyle;
    property AttachedToText: WordBool read Get_AttachedToText;
    property KashidaPercentage: Integer read Get_KashidaPercentage write Set_KashidaPercentage;
    property ListType: PbListType read Get_ListType;
    property ListBulletText: WideString read Get_ListBulletText;
    property ListBulletFontName: WideString read Get_ListBulletFontName write Set_ListBulletFontName;
    property ListNumberSeparator: PbListSeparator read Get_ListNumberSeparator write Set_ListNumberSeparator;
    property ListNumberStart: Integer read Get_ListNumberStart write Set_ListNumberStart;
    property CharBasedFirstLineIndent: Integer read Get_CharBasedFirstLineIndent write Set_CharBasedFirstLineIndent;
    property UseCharBasedFirstLineIndent: MsoTriState read Get_UseCharBasedFirstLineIndent write Set_UseCharBasedFirstLineIndent;
    property WidowControl: MsoTriState read Get_WidowControl write Set_WidowControl;
    property KeepLinesTogether: MsoTriState read Get_KeepLinesTogether write Set_KeepLinesTogether;
    property KeepWithNext: MsoTriState read Get_KeepWithNext write Set_KeepWithNext;
    property StartInNextTextBox: MsoTriState read Get_StartInNextTextBox write Set_StartInNextTextBox;
    property LockToBaseLine: MsoTriState read Get_LockToBaseLine write Set_LockToBaseLine;
  end;

// *********************************************************************//
// DispIntf:  ParagraphFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BD876261-4399-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  ParagraphFormatDisp = dispinterface
    ['{BD876261-4399-11D3-B65B-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Alignment: PbParagraphAlignmentType dispid 3;
    property FirstLineIndent: OleVariant dispid 5;
    property LeftIndent: OleVariant dispid 6;
    property RightIndent: OleVariant dispid 7;
    property SpaceAfter: OleVariant dispid 8;
    property SpaceBefore: OleVariant dispid 9;
    property LineSpacing: OleVariant dispid 10;
    property LineSpacingRule: PbLineSpacingRule dispid 11;
    property Tabs: TabStops readonly dispid 12;
    property TextDirection: PbTextDirection dispid 13;
    property TextStyle: OleVariant dispid 14;
    procedure Reset; dispid 15;
    function  Duplicate: ParagraphFormat; dispid 16;
    procedure SetLineSpacing(Rule: PbLineSpacingRule; Spacing: OleVariant); dispid 17;
    property AttachedToText: WordBool readonly dispid 18;
    property KashidaPercentage: Integer dispid 19;
    procedure SetListType(Value: PbListType; const BulletText: WideString); dispid 20;
    property ListType: PbListType readonly dispid 21;
    function  ListIndent: Single; dispid 22;
    property ListBulletText: WideString readonly dispid 23;
    function  ListBulletFontSize: Single; dispid 24;
    property ListBulletFontName: WideString dispid 25;
    property ListNumberSeparator: PbListSeparator dispid 26;
    property ListNumberStart: Integer dispid 27;
    property CharBasedFirstLineIndent: Integer dispid 28;
    property UseCharBasedFirstLineIndent: MsoTriState dispid 29;
    property WidowControl: MsoTriState dispid 30;
    property KeepLinesTogether: MsoTriState dispid 31;
    property KeepWithNext: MsoTriState dispid 32;
    property StartInNextTextBox: MsoTriState dispid 33;
    property LockToBaseLine: MsoTriState dispid 34;
  end;

// *********************************************************************//
// Interface: TabStops
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B0-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  TabStops = interface(IDispatch)
    ['{37B3B0B0-44B5-11D3-B65B-00C04F8EF32D}']
    function  Item(Index: Integer): TabStop; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    procedure ClearAll; safecall;
    procedure Add(Position: OleVariant; Alignment: PbTabAlignmentType; Leader: PbTabLeaderType); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  TabStopsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B0-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  TabStopsDisp = dispinterface
    ['{37B3B0B0-44B5-11D3-B65B-00C04F8EF32D}']
    function  Item(Index: Integer): TabStop; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    procedure ClearAll; dispid 4;
    procedure Add(Position: OleVariant; Alignment: PbTabAlignmentType; Leader: PbTabLeaderType); dispid 5;
  end;

// *********************************************************************//
// Interface: TabStop
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B1-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  TabStop = interface(IDispatch)
    ['{37B3B0B1-44B5-11D3-B65B-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Position: OleVariant; safecall;
    procedure Set_Position(Position: OleVariant); safecall;
    function  Get_Alignment: PbTabAlignmentType; safecall;
    procedure Set_Alignment(Alignment: PbTabAlignmentType); safecall;
    function  Get_Leader: PbTabLeaderType; safecall;
    procedure Set_Leader(Leader: PbTabLeaderType); safecall;
    procedure Clear; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Position: OleVariant read Get_Position write Set_Position;
    property Alignment: PbTabAlignmentType read Get_Alignment write Set_Alignment;
    property Leader: PbTabLeaderType read Get_Leader write Set_Leader;
  end;

// *********************************************************************//
// DispIntf:  TabStopDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B1-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  TabStopDisp = dispinterface
    ['{37B3B0B1-44B5-11D3-B65B-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Position: OleVariant dispid 3;
    property Alignment: PbTabAlignmentType dispid 4;
    property Leader: PbTabLeaderType dispid 5;
    procedure Clear; dispid 6;
  end;

// *********************************************************************//
// Interface: Fields
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7742D36C-49D5-11D3-B65C-00C04F8EF32D}
// *********************************************************************//
  Fields = interface(IDispatch)
    ['{7742D36C-49D5-11D3-B65C-00C04F8EF32D}']
    function  Item(Index: Integer): Field; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    procedure Unlink; safecall;
    function  AddHorizontalInVertical(const Range: TextRange; const Text: WideString): Field; safecall;
    function  AddPhoneticGuide(const Range: TextRange; const Text: WideString; 
                               Alignment: PbPhoneticGuideAlignmentType; Raise_: OleVariant; 
                               const FontName: WideString; FontSize: OleVariant): Field; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  FieldsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7742D36C-49D5-11D3-B65C-00C04F8EF32D}
// *********************************************************************//
  FieldsDisp = dispinterface
    ['{7742D36C-49D5-11D3-B65C-00C04F8EF32D}']
    function  Item(Index: Integer): Field; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    procedure Unlink; dispid 4;
    function  AddHorizontalInVertical(const Range: TextRange; const Text: WideString): Field; dispid 7;
    function  AddPhoneticGuide(const Range: TextRange; const Text: WideString; 
                               Alignment: PbPhoneticGuideAlignmentType; Raise_: OleVariant; 
                               const FontName: WideString; FontSize: OleVariant): Field; dispid 8;
  end;

// *********************************************************************//
// Interface: Field
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7742D36B-49D5-11D3-B65C-00C04F8EF32D}
// *********************************************************************//
  Field = interface(IDispatch)
    ['{7742D36B-49D5-11D3-B65C-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Code: WideString; safecall;
    function  Get_TextRange: TextRange; safecall;
    function  Get_Type_: PbFieldType; safecall;
    function  Get_Next: Field; safecall;
    function  Get_Result: WideString; safecall;
    function  Get_PhoneticGuide: PhoneticGuide; safecall;
    procedure Unlink; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Code: WideString read Get_Code;
    property TextRange: TextRange read Get_TextRange;
    property Type_: PbFieldType read Get_Type_;
    property Next: Field read Get_Next;
    property Result: WideString read Get_Result;
    property PhoneticGuide: PhoneticGuide read Get_PhoneticGuide;
  end;

// *********************************************************************//
// DispIntf:  FieldDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7742D36B-49D5-11D3-B65C-00C04F8EF32D}
// *********************************************************************//
  FieldDisp = dispinterface
    ['{7742D36B-49D5-11D3-B65C-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Code: WideString readonly dispid 3;
    property TextRange: TextRange readonly dispid 4;
    property Type_: PbFieldType readonly dispid 5;
    property Next: Field readonly dispid 6;
    property Result: WideString readonly dispid 7;
    property PhoneticGuide: PhoneticGuide readonly dispid 8;
    procedure Unlink; dispid 9;
  end;

// *********************************************************************//
// Interface: PhoneticGuide
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7742D36D-49D5-11D3-B65C-00C04F8EF32D}
// *********************************************************************//
  PhoneticGuide = interface(IDispatch)
    ['{7742D36D-49D5-11D3-B65C-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_FontName: WideString; safecall;
    function  Get_FontSize: OleVariant; safecall;
    function  Get_Raise_: OleVariant; safecall;
    function  Get_Alignment: PbPhoneticGuideAlignmentType; safecall;
    function  Get_BaseText: WideString; safecall;
    function  Get_Text: WideString; safecall;
    procedure Clear; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property FontName: WideString read Get_FontName;
    property FontSize: OleVariant read Get_FontSize;
    property Raise_: OleVariant read Get_Raise_;
    property Alignment: PbPhoneticGuideAlignmentType read Get_Alignment;
    property BaseText: WideString read Get_BaseText;
    property Text: WideString read Get_Text;
  end;

// *********************************************************************//
// DispIntf:  PhoneticGuideDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7742D36D-49D5-11D3-B65C-00C04F8EF32D}
// *********************************************************************//
  PhoneticGuideDisp = dispinterface
    ['{7742D36D-49D5-11D3-B65C-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property FontName: WideString readonly dispid 3;
    property FontSize: OleVariant readonly dispid 4;
    property Raise_: OleVariant readonly dispid 5;
    property Alignment: PbPhoneticGuideAlignmentType readonly dispid 6;
    property BaseText: WideString readonly dispid 7;
    property Text: WideString readonly dispid 8;
    procedure Clear; dispid 9;
  end;

// *********************************************************************//
// Interface: Story
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B2-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  Story = interface(IDispatch)
    ['{37B3B0B2-44B5-11D3-B65B-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_HasTable: MsoTriState; safecall;
    function  Get_HasTextFrame: MsoTriState; safecall;
    function  Get_TextFrame: TextFrame; safecall;
    function  Get_Table: Table; safecall;
    function  Get_Type_: PbStoryType; safecall;
    function  Get_TextRange: TextRange; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property HasTable: MsoTriState read Get_HasTable;
    property HasTextFrame: MsoTriState read Get_HasTextFrame;
    property TextFrame: TextFrame read Get_TextFrame;
    property Table: Table read Get_Table;
    property Type_: PbStoryType read Get_Type_;
    property TextRange: TextRange read Get_TextRange;
  end;

// *********************************************************************//
// DispIntf:  StoryDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B2-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  StoryDisp = dispinterface
    ['{37B3B0B2-44B5-11D3-B65B-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property HasTable: MsoTriState readonly dispid 3;
    property HasTextFrame: MsoTriState readonly dispid 4;
    property TextFrame: TextFrame readonly dispid 5;
    property Table: Table readonly dispid 6;
    property Type_: PbStoryType readonly dispid 7;
    property TextRange: TextRange readonly dispid 8;
  end;

// *********************************************************************//
// Interface: Table
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3EA-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  Table = interface(IDispatch)
    ['{37FAE3EA-D9B4-11D3-907A-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Columns: Columns; safecall;
    function  Get_GrowToFitText: WordBool; safecall;
    procedure Set_GrowToFitText(RetValue: WordBool); safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Rows: Rows; safecall;
    function  Get_TableDirection: PbTableDirectionType; safecall;
    procedure Set_TableDirection(RetVal: PbTableDirectionType); safecall;
    function  Get_Cells(StartRow: Integer; StartColumn: Integer; EndRow: Integer; EndColumn: Integer): CellRange; safecall;
    procedure ApplyAutoFormat(AutoFormat: PbTableAutoFormatType; TextFormatting: WordBool; 
                              TextAlignment: WordBool; Fill: WordBool; Borders: WordBool); safecall;
    property Application: Application read Get_Application;
    property Columns: Columns read Get_Columns;
    property GrowToFitText: WordBool read Get_GrowToFitText write Set_GrowToFitText;
    property Parent: IDispatch read Get_Parent;
    property Rows: Rows read Get_Rows;
    property TableDirection: PbTableDirectionType read Get_TableDirection write Set_TableDirection;
    property Cells[StartRow: Integer; StartColumn: Integer; EndRow: Integer; EndColumn: Integer]: CellRange read Get_Cells;
  end;

// *********************************************************************//
// DispIntf:  TableDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3EA-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  TableDisp = dispinterface
    ['{37FAE3EA-D9B4-11D3-907A-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Columns: Columns readonly dispid 3;
    property GrowToFitText: WordBool dispid 4;
    property Parent: IDispatch readonly dispid 5;
    property Rows: Rows readonly dispid 6;
    property TableDirection: PbTableDirectionType dispid 7;
    property Cells[StartRow: Integer; StartColumn: Integer; EndRow: Integer; EndColumn: Integer]: CellRange readonly dispid 8;
    procedure ApplyAutoFormat(AutoFormat: PbTableAutoFormatType; TextFormatting: WordBool; 
                              TextAlignment: WordBool; Fill: WordBool; Borders: WordBool); dispid 9;
  end;

// *********************************************************************//
// Interface: Columns
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3EF-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  Columns = interface(IDispatch)
    ['{37FAE3EF-D9B4-11D3-907A-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Count: Integer; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Item(Index: Integer): Column; safecall;
    function  Add(BeforeColumn: Integer): Column; safecall;
    property Application: Application read Get_Application;
    property Count: Integer read Get_Count;
    property Parent: IDispatch read Get_Parent;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  ColumnsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3EF-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  ColumnsDisp = dispinterface
    ['{37FAE3EF-D9B4-11D3-907A-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Count: Integer readonly dispid 2;
    property Parent: IDispatch readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    function  Item(Index: Integer): Column; dispid 0;
    function  Add(BeforeColumn: Integer): Column; dispid 4;
  end;

// *********************************************************************//
// Interface: Column
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3ED-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  Column = interface(IDispatch)
    ['{37FAE3ED-D9B4-11D3-907A-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Cells: CellRange; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Width: OleVariant; safecall;
    procedure Set_Width(RetValue: OleVariant); safecall;
    procedure Delete; safecall;
    property Application: Application read Get_Application;
    property Cells: CellRange read Get_Cells;
    property Parent: IDispatch read Get_Parent;
    property Width: OleVariant read Get_Width write Set_Width;
  end;

// *********************************************************************//
// DispIntf:  ColumnDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3ED-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  ColumnDisp = dispinterface
    ['{37FAE3ED-D9B4-11D3-907A-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Cells: CellRange readonly dispid 2;
    property Parent: IDispatch readonly dispid 4;
    property Width: OleVariant dispid 3;
    procedure Delete; dispid 5;
  end;

// *********************************************************************//
// Interface: CellRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3F1-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  CellRange = interface(IDispatch)
    ['{37FAE3F1-D9B4-11D3-907A-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Column: Integer; safecall;
    function  Get_Count: Integer; safecall;
    function  Get_Height: Integer; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Row: Integer; safecall;
    function  Get_Width: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Item(Index: Integer): Cell; safecall;
    procedure Merge; safecall;
    procedure Select; safecall;
    property Application: Application read Get_Application;
    property Column: Integer read Get_Column;
    property Count: Integer read Get_Count;
    property Height: Integer read Get_Height;
    property Parent: IDispatch read Get_Parent;
    property Row: Integer read Get_Row;
    property Width: Integer read Get_Width;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  CellRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3F1-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  CellRangeDisp = dispinterface
    ['{37FAE3F1-D9B4-11D3-907A-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Column: Integer readonly dispid 2;
    property Count: Integer readonly dispid 3;
    property Height: Integer readonly dispid 4;
    property Parent: IDispatch readonly dispid 5;
    property Row: Integer readonly dispid 6;
    property Width: Integer readonly dispid 7;
    property _NewEnum: IUnknown readonly dispid -4;
    function  Item(Index: Integer): Cell; dispid 0;
    procedure Merge; dispid 8;
    procedure Select; dispid 9;
  end;

// *********************************************************************//
// Interface: Cell
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3F0-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  Cell = interface(IDispatch)
    ['{37FAE3F0-D9B4-11D3-907A-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_BorderDiagonal: CellBorder; safecall;
    function  Get_BorderBottom: CellBorder; safecall;
    function  Get_BorderLeft: CellBorder; safecall;
    function  Get_BorderRight: CellBorder; safecall;
    function  Get_BorderTop: CellBorder; safecall;
    function  Get_Column: Integer; safecall;
    function  Get_Diagonal: PbCellDiagonalType; safecall;
    procedure Set_Diagonal(RetValue: PbCellDiagonalType); safecall;
    function  Get_Fill: FillFormat; safecall;
    function  Get_HasText: WordBool; safecall;
    function  Get_Height: Integer; safecall;
    function  Get_MarginBottom: OleVariant; safecall;
    procedure Set_MarginBottom(RetValue: OleVariant); safecall;
    function  Get_MarginLeft: OleVariant; safecall;
    procedure Set_MarginLeft(RetValue: OleVariant); safecall;
    function  Get_MarginRight: OleVariant; safecall;
    procedure Set_MarginRight(RetValue: OleVariant); safecall;
    function  Get_MarginTop: OleVariant; safecall;
    procedure Set_MarginTop(RetValue: OleVariant); safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Row: Integer; safecall;
    function  Get_Selected: WordBool; safecall;
    function  Get_TextRange: TextRange; safecall;
    function  Get_VerticalTextAlignment: PbVerticalTextAlignmentType; safecall;
    procedure Set_VerticalTextAlignment(RetValue: PbVerticalTextAlignmentType); safecall;
    function  Get_Width: Integer; safecall;
    procedure Merge(const MergeTo: Cell); safecall;
    procedure Select; safecall;
    function  Split: CellRange; safecall;
    function  Get_CellTextOrientation: PbTextOrientation; safecall;
    procedure Set_CellTextOrientation(Orientation: PbTextOrientation); safecall;
    property Application: Application read Get_Application;
    property BorderDiagonal: CellBorder read Get_BorderDiagonal;
    property BorderBottom: CellBorder read Get_BorderBottom;
    property BorderLeft: CellBorder read Get_BorderLeft;
    property BorderRight: CellBorder read Get_BorderRight;
    property BorderTop: CellBorder read Get_BorderTop;
    property Column: Integer read Get_Column;
    property Diagonal: PbCellDiagonalType read Get_Diagonal write Set_Diagonal;
    property Fill: FillFormat read Get_Fill;
    property HasText: WordBool read Get_HasText;
    property Height: Integer read Get_Height;
    property MarginBottom: OleVariant read Get_MarginBottom write Set_MarginBottom;
    property MarginLeft: OleVariant read Get_MarginLeft write Set_MarginLeft;
    property MarginRight: OleVariant read Get_MarginRight write Set_MarginRight;
    property MarginTop: OleVariant read Get_MarginTop write Set_MarginTop;
    property Parent: IDispatch read Get_Parent;
    property Row: Integer read Get_Row;
    property Selected: WordBool read Get_Selected;
    property TextRange: TextRange read Get_TextRange;
    property VerticalTextAlignment: PbVerticalTextAlignmentType read Get_VerticalTextAlignment write Set_VerticalTextAlignment;
    property Width: Integer read Get_Width;
    property CellTextOrientation: PbTextOrientation read Get_CellTextOrientation write Set_CellTextOrientation;
  end;

// *********************************************************************//
// DispIntf:  CellDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3F0-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  CellDisp = dispinterface
    ['{37FAE3F0-D9B4-11D3-907A-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property BorderDiagonal: CellBorder readonly dispid 2;
    property BorderBottom: CellBorder readonly dispid 3;
    property BorderLeft: CellBorder readonly dispid 4;
    property BorderRight: CellBorder readonly dispid 5;
    property BorderTop: CellBorder readonly dispid 6;
    property Column: Integer readonly dispid 7;
    property Diagonal: PbCellDiagonalType dispid 8;
    property Fill: FillFormat readonly dispid 9;
    property HasText: WordBool readonly dispid 10;
    property Height: Integer readonly dispid 11;
    property MarginBottom: OleVariant dispid 12;
    property MarginLeft: OleVariant dispid 13;
    property MarginRight: OleVariant dispid 14;
    property MarginTop: OleVariant dispid 15;
    property Parent: IDispatch readonly dispid 16;
    property Row: Integer readonly dispid 17;
    property Selected: WordBool readonly dispid 18;
    property TextRange: TextRange readonly dispid 19;
    property VerticalTextAlignment: PbVerticalTextAlignmentType dispid 20;
    property Width: Integer readonly dispid 21;
    procedure Merge(const MergeTo: Cell); dispid 22;
    procedure Select; dispid 23;
    function  Split: CellRange; dispid 24;
    property CellTextOrientation: PbTextOrientation dispid 25;
  end;

// *********************************************************************//
// Interface: CellBorder
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {702CA50E-E315-11D3-907C-00C04F799E3F}
// *********************************************************************//
  CellBorder = interface(IDispatch)
    ['{702CA50E-E315-11D3-907C-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Color: ColorFormat; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Weight: OleVariant; safecall;
    procedure Set_Weight(Weight: OleVariant); safecall;
    property Application: Application read Get_Application;
    property Color: ColorFormat read Get_Color;
    property Parent: IDispatch read Get_Parent;
    property Weight: OleVariant read Get_Weight write Set_Weight;
  end;

// *********************************************************************//
// DispIntf:  CellBorderDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {702CA50E-E315-11D3-907C-00C04F799E3F}
// *********************************************************************//
  CellBorderDisp = dispinterface
    ['{702CA50E-E315-11D3-907C-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Color: ColorFormat readonly dispid 2;
    property Parent: IDispatch readonly dispid 3;
    property Weight: OleVariant dispid 4;
  end;

// *********************************************************************//
// Interface: Rows
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3EC-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  Rows = interface(IDispatch)
    ['{37FAE3EC-D9B4-11D3-907A-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Count: Integer; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Item(Index: Integer): Row; safecall;
    function  Add(BeforeRow: Integer): Row; safecall;
    property Application: Application read Get_Application;
    property Count: Integer read Get_Count;
    property Parent: IDispatch read Get_Parent;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  RowsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3EC-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  RowsDisp = dispinterface
    ['{37FAE3EC-D9B4-11D3-907A-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Count: Integer readonly dispid 2;
    property Parent: IDispatch readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    function  Item(Index: Integer): Row; dispid 0;
    function  Add(BeforeRow: Integer): Row; dispid 4;
  end;

// *********************************************************************//
// Interface: Row
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3EB-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  Row = interface(IDispatch)
    ['{37FAE3EB-D9B4-11D3-907A-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Cells: CellRange; safecall;
    function  Get_Height: OleVariant; safecall;
    procedure Set_Height(RetValue: OleVariant); safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure Delete; safecall;
    property Application: Application read Get_Application;
    property Cells: CellRange read Get_Cells;
    property Height: OleVariant read Get_Height write Set_Height;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  RowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37FAE3EB-D9B4-11D3-907A-00C04F799E3F}
// *********************************************************************//
  RowDisp = dispinterface
    ['{37FAE3EB-D9B4-11D3-907A-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Cells: CellRange readonly dispid 2;
    property Height: OleVariant dispid 3;
    property Parent: IDispatch readonly dispid 4;
    procedure Delete; dispid 5;
  end;

// *********************************************************************//
// Interface: DropCap
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0AF-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  DropCap = interface(IDispatch)
    ['{37B3B0AF-44B5-11D3-B65B-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_FontName: WideString; safecall;
    procedure Set_FontName(const FontName: WideString); safecall;
    function  Get_FontColor: ColorFormat; safecall;
    function  Get_FontBold: MsoTriState; safecall;
    procedure Set_FontBold(Bold: MsoTriState); safecall;
    function  Get_FontItalic: MsoTriState; safecall;
    procedure Set_FontItalic(Italic: MsoTriState); safecall;
    function  Get_LinesUp: Integer; safecall;
    procedure Set_LinesUp(Lines: Integer); safecall;
    function  Get_Size: Integer; safecall;
    procedure Set_Size(Lines: Integer); safecall;
    function  Get_Span: Integer; safecall;
    procedure Set_Span(Length: Integer); safecall;
    procedure ApplyCustomDropCap(LinesUp: Integer; Size: Integer; Span: Integer; 
                                 const FontName: WideString; Bold: WordBool; Italic: WordBool); safecall;
    procedure Clear; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontColor: ColorFormat read Get_FontColor;
    property FontBold: MsoTriState read Get_FontBold write Set_FontBold;
    property FontItalic: MsoTriState read Get_FontItalic write Set_FontItalic;
    property LinesUp: Integer read Get_LinesUp write Set_LinesUp;
    property Size: Integer read Get_Size write Set_Size;
    property Span: Integer read Get_Span write Set_Span;
  end;

// *********************************************************************//
// DispIntf:  DropCapDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0AF-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  DropCapDisp = dispinterface
    ['{37B3B0AF-44B5-11D3-B65B-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property FontName: WideString dispid 3;
    property FontColor: ColorFormat readonly dispid 4;
    property FontBold: MsoTriState dispid 5;
    property FontItalic: MsoTriState dispid 6;
    property LinesUp: Integer dispid 7;
    property Size: Integer dispid 8;
    property Span: Integer dispid 9;
    procedure ApplyCustomDropCap(LinesUp: Integer; Size: Integer; Span: Integer; 
                                 const FontName: WideString; Bold: WordBool; Italic: WordBool); dispid 11;
    procedure Clear; dispid 12;
  end;

// *********************************************************************//
// Interface: Hyperlinks
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {72E5D393-FC3B-4A38-A9DA-AA30370E66F9}
// *********************************************************************//
  Hyperlinks = interface(IDispatch)
    ['{72E5D393-FC3B-4A38-A9DA-AA30370E66F9}']
    function  Get_Item(Index: Integer): Hyperlink; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Add(const Text: TextRange; const Address: WideString; 
                  RelativePage: PbHlinkTargetType; PageID: Integer; const TextToDisplay: WideString): Hyperlink; safecall;
    property Item[Index: Integer]: Hyperlink read Get_Item; default;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  HyperlinksDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {72E5D393-FC3B-4A38-A9DA-AA30370E66F9}
// *********************************************************************//
  HyperlinksDisp = dispinterface
    ['{72E5D393-FC3B-4A38-A9DA-AA30370E66F9}']
    property Item[Index: Integer]: Hyperlink readonly dispid 0; default;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    function  Add(const Text: TextRange; const Address: WideString; 
                  RelativePage: PbHlinkTargetType; PageID: Integer; const TextToDisplay: WideString): Hyperlink; dispid 4;
  end;

// *********************************************************************//
// Interface: Hyperlink
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C2B7CD3-F864-11D2-8C7A-00C04F8EF340}
// *********************************************************************//
  Hyperlink = interface(IDispatch)
    ['{2C2B7CD3-F864-11D2-8C7A-00C04F8EF340}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Address: WideString; safecall;
    procedure Set_Address(const Address: WideString); safecall;
    function  Get_EmailSubject: WideString; safecall;
    procedure Set_EmailSubject(const Subject: WideString); safecall;
    function  Get_PageID: Integer; safecall;
    procedure Set_PageID(Page: Integer); safecall;
    function  Get_Range: TextRange; safecall;
    function  Get_Shape: Shape; safecall;
    function  Get_TargetType: PbHlinkTargetType; safecall;
    function  Get_TextToDisplay: WideString; safecall;
    procedure Set_TextToDisplay(const SubAddress: WideString); safecall;
    function  Get_Type_: MsoHyperlinkType; safecall;
    procedure Delete; safecall;
    procedure SetPageRelative(RelativePage: PbHlinkTargetType); safecall;
    procedure Move(NewIndex: Integer); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Address: WideString read Get_Address write Set_Address;
    property EmailSubject: WideString read Get_EmailSubject write Set_EmailSubject;
    property PageID: Integer read Get_PageID write Set_PageID;
    property Range: TextRange read Get_Range;
    property Shape: Shape read Get_Shape;
    property TargetType: PbHlinkTargetType read Get_TargetType;
    property TextToDisplay: WideString read Get_TextToDisplay write Set_TextToDisplay;
    property Type_: MsoHyperlinkType read Get_Type_;
  end;

// *********************************************************************//
// DispIntf:  HyperlinkDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C2B7CD3-F864-11D2-8C7A-00C04F8EF340}
// *********************************************************************//
  HyperlinkDisp = dispinterface
    ['{2C2B7CD3-F864-11D2-8C7A-00C04F8EF340}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Address: WideString dispid 3;
    property EmailSubject: WideString dispid 4;
    property PageID: Integer dispid 5;
    property Range: TextRange readonly dispid 6;
    property Shape: Shape readonly dispid 7;
    property TargetType: PbHlinkTargetType readonly dispid 9;
    property TextToDisplay: WideString dispid 10;
    property Type_: MsoHyperlinkType readonly dispid 11;
    procedure Delete; dispid 15;
    procedure SetPageRelative(RelativePage: PbHlinkTargetType); dispid 16;
    procedure Move(NewIndex: Integer); dispid 17;
  end;

// *********************************************************************//
// Interface: FindReplace
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {382D6521-2995-4173-B785-9A6BD2F64239}
// *********************************************************************//
  FindReplace = interface(IDispatch)
    ['{382D6521-2995-4173-B785-9A6BD2F64239}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_FoundTextRange: TextRange; safecall;
    function  Get_FindText: WideString; safecall;
    procedure Set_FindText(const RetVal: WideString); safecall;
    function  Get_ReplaceWithText: WideString; safecall;
    procedure Set_ReplaceWithText(const RetVal: WideString); safecall;
    function  Get_Forward: WordBool; safecall;
    procedure Set_Forward(RetVal: WordBool); safecall;
    function  Get_MatchAlefHamza: WordBool; safecall;
    procedure Set_MatchAlefHamza(RetVal: WordBool); safecall;
    function  Get_MatchCase: WordBool; safecall;
    procedure Set_MatchCase(RetVal: WordBool); safecall;
    function  Get_MatchDiacritics: WordBool; safecall;
    procedure Set_MatchDiacritics(RetVal: WordBool); safecall;
    function  Get_MatchKashida: WordBool; safecall;
    procedure Set_MatchKashida(RetVal: WordBool); safecall;
    function  Get_MatchWholeWord: WordBool; safecall;
    procedure Set_MatchWholeWord(RetVal: WordBool); safecall;
    function  Get_MatchWidth: WordBool; safecall;
    procedure Set_MatchWidth(RetVal: WordBool); safecall;
    function  Get_ReplaceScope: PbReplaceScope; safecall;
    procedure Set_ReplaceScope(RetVal: PbReplaceScope); safecall;
    function  Execute: WordBool; safecall;
    procedure Clear; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property FoundTextRange: TextRange read Get_FoundTextRange;
    property FindText: WideString read Get_FindText write Set_FindText;
    property ReplaceWithText: WideString read Get_ReplaceWithText write Set_ReplaceWithText;
    property Forward: WordBool read Get_Forward write Set_Forward;
    property MatchAlefHamza: WordBool read Get_MatchAlefHamza write Set_MatchAlefHamza;
    property MatchCase: WordBool read Get_MatchCase write Set_MatchCase;
    property MatchDiacritics: WordBool read Get_MatchDiacritics write Set_MatchDiacritics;
    property MatchKashida: WordBool read Get_MatchKashida write Set_MatchKashida;
    property MatchWholeWord: WordBool read Get_MatchWholeWord write Set_MatchWholeWord;
    property MatchWidth: WordBool read Get_MatchWidth write Set_MatchWidth;
    property ReplaceScope: PbReplaceScope read Get_ReplaceScope write Set_ReplaceScope;
  end;

// *********************************************************************//
// DispIntf:  FindReplaceDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {382D6521-2995-4173-B785-9A6BD2F64239}
// *********************************************************************//
  FindReplaceDisp = dispinterface
    ['{382D6521-2995-4173-B785-9A6BD2F64239}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property FoundTextRange: TextRange readonly dispid 3;
    property FindText: WideString dispid 4;
    property ReplaceWithText: WideString dispid 5;
    property Forward: WordBool dispid 6;
    property MatchAlefHamza: WordBool dispid 7;
    property MatchCase: WordBool dispid 8;
    property MatchDiacritics: WordBool dispid 9;
    property MatchKashida: WordBool dispid 10;
    property MatchWholeWord: WordBool dispid 11;
    property MatchWidth: WordBool dispid 12;
    property ReplaceScope: PbReplaceScope dispid 13;
    function  Execute: WordBool; dispid 14;
    procedure Clear; dispid 15;
  end;

// *********************************************************************//
// Interface: InlineShapes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {98091C49-9841-4D1A-BE2D-8FFD9C7702CC}
// *********************************************************************//
  InlineShapes = interface(IDispatch)
    ['{98091C49-9841-4D1A-BE2D-8FFD9C7702CC}']
    function  Item(var_: OleVariant): Shape; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Range(Index: OleVariant): ShapeRange; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Range[Index: OleVariant]: ShapeRange read Get_Range;
  end;

// *********************************************************************//
// DispIntf:  InlineShapesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {98091C49-9841-4D1A-BE2D-8FFD9C7702CC}
// *********************************************************************//
  InlineShapesDisp = dispinterface
    ['{98091C49-9841-4D1A-BE2D-8FFD9C7702CC}']
    function  Item(var_: OleVariant): Shape; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    property Range[Index: OleVariant]: ShapeRange readonly dispid 5;
  end;

// *********************************************************************//
// Interface: ThreeDFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126F-0000-0000-C000-000000000046}
// *********************************************************************//
  ThreeDFormat = interface(IDispatch)
    ['{0002126F-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure IncrementRotationX(Increment: Single); safecall;
    procedure IncrementRotationY(Increment: Single); safecall;
    procedure ResetRotation; safecall;
    procedure SetThreeDFormat(PresetThreeDFormat: MsoPresetThreeDFormat); safecall;
    procedure SetExtrusionDirection(PresetExtrusionDirection: MsoPresetExtrusionDirection); safecall;
    function  Get_Depth: OleVariant; safecall;
    procedure Set_Depth(Depth: OleVariant); safecall;
    function  Get_ExtrusionColor: ColorFormat; safecall;
    function  Get_ExtrusionColorType: MsoExtrusionColorType; safecall;
    procedure Set_ExtrusionColorType(ExtrusionColorType: MsoExtrusionColorType); safecall;
    function  Get_Perspective: MsoTriState; safecall;
    procedure Set_Perspective(Perspective: MsoTriState); safecall;
    function  Get_PresetExtrusionDirection: MsoPresetExtrusionDirection; safecall;
    function  Get_PresetLightingDirection: MsoPresetLightingDirection; safecall;
    procedure Set_PresetLightingDirection(PresetLightingDirection: MsoPresetLightingDirection); safecall;
    function  Get_PresetLightingSoftness: MsoPresetLightingSoftness; safecall;
    procedure Set_PresetLightingSoftness(PresetLightingSoftness: MsoPresetLightingSoftness); safecall;
    function  Get_PresetMaterial: MsoPresetMaterial; safecall;
    procedure Set_PresetMaterial(PresetMaterial: MsoPresetMaterial); safecall;
    function  Get_PresetThreeDFormat: MsoPresetThreeDFormat; safecall;
    function  Get_RotationX: Single; safecall;
    procedure Set_RotationX(RotationX: Single); safecall;
    function  Get_RotationY: Single; safecall;
    procedure Set_RotationY(RotationY: Single); safecall;
    function  Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Depth: OleVariant read Get_Depth write Set_Depth;
    property ExtrusionColor: ColorFormat read Get_ExtrusionColor;
    property ExtrusionColorType: MsoExtrusionColorType read Get_ExtrusionColorType write Set_ExtrusionColorType;
    property Perspective: MsoTriState read Get_Perspective write Set_Perspective;
    property PresetExtrusionDirection: MsoPresetExtrusionDirection read Get_PresetExtrusionDirection;
    property PresetLightingDirection: MsoPresetLightingDirection read Get_PresetLightingDirection write Set_PresetLightingDirection;
    property PresetLightingSoftness: MsoPresetLightingSoftness read Get_PresetLightingSoftness write Set_PresetLightingSoftness;
    property PresetMaterial: MsoPresetMaterial read Get_PresetMaterial write Set_PresetMaterial;
    property PresetThreeDFormat: MsoPresetThreeDFormat read Get_PresetThreeDFormat;
    property RotationX: Single read Get_RotationX write Set_RotationX;
    property RotationY: Single read Get_RotationY write Set_RotationY;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  ThreeDFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002126F-0000-0000-C000-000000000046}
// *********************************************************************//
  ThreeDFormatDisp = dispinterface
    ['{0002126F-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure IncrementRotationX(Increment: Single); dispid 10;
    procedure IncrementRotationY(Increment: Single); dispid 11;
    procedure ResetRotation; dispid 12;
    procedure SetThreeDFormat(PresetThreeDFormat: MsoPresetThreeDFormat); dispid 13;
    procedure SetExtrusionDirection(PresetExtrusionDirection: MsoPresetExtrusionDirection); dispid 14;
    property Depth: OleVariant dispid 100;
    property ExtrusionColor: ColorFormat readonly dispid 101;
    property ExtrusionColorType: MsoExtrusionColorType dispid 102;
    property Perspective: MsoTriState dispid 103;
    property PresetExtrusionDirection: MsoPresetExtrusionDirection readonly dispid 104;
    property PresetLightingDirection: MsoPresetLightingDirection dispid 105;
    property PresetLightingSoftness: MsoPresetLightingSoftness dispid 106;
    property PresetMaterial: MsoPresetMaterial dispid 107;
    property PresetThreeDFormat: MsoPresetThreeDFormat readonly dispid 108;
    property RotationX: Single dispid 109;
    property RotationY: Single dispid 110;
    property Visible: MsoTriState dispid 111;
  end;

// *********************************************************************//
// Interface: LinkFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C2B7CD4-F864-11D2-8C7A-00C04F8EF340}
// *********************************************************************//
  LinkFormat = interface(IDispatch)
    ['{2C2B7CD4-F864-11D2-8C7A-00C04F8EF340}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_SourceFullName: WideString; safecall;
    procedure Update; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property SourceFullName: WideString read Get_SourceFullName;
  end;

// *********************************************************************//
// DispIntf:  LinkFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C2B7CD4-F864-11D2-8C7A-00C04F8EF340}
// *********************************************************************//
  LinkFormatDisp = dispinterface
    ['{2C2B7CD4-F864-11D2-8C7A-00C04F8EF340}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property SourceFullName: WideString readonly dispid 3;
    procedure Update; dispid 4;
  end;

// *********************************************************************//
// Interface: OLEFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C2B7CD5-F864-11D2-8C7A-00C04F8EF340}
// *********************************************************************//
  OLEFormat = interface(IDispatch)
    ['{2C2B7CD5-F864-11D2-8C7A-00C04F8EF340}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Object_: IDispatch; safecall;
    function  Get_ProgId: WideString; safecall;
    function  Get_ObjectVerbs: ObjectVerbs; safecall;
    procedure Activate; safecall;
    procedure DoVerb(iVerb: Integer); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Object_: IDispatch read Get_Object_;
    property ProgId: WideString read Get_ProgId;
    property ObjectVerbs: ObjectVerbs read Get_ObjectVerbs;
  end;

// *********************************************************************//
// DispIntf:  OLEFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C2B7CD5-F864-11D2-8C7A-00C04F8EF340}
// *********************************************************************//
  OLEFormatDisp = dispinterface
    ['{2C2B7CD5-F864-11D2-8C7A-00C04F8EF340}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Object_: IDispatch readonly dispid 3;
    property ProgId: WideString readonly dispid 4;
    property ObjectVerbs: ObjectVerbs readonly dispid 5;
    procedure Activate; dispid 6;
    procedure DoVerb(iVerb: Integer); dispid 7;
  end;

// *********************************************************************//
// Interface: ObjectVerbs
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BBA7E70F-3FD3-11D3-B65A-00C04F8EF32D}
// *********************************************************************//
  ObjectVerbs = interface(IDispatch)
    ['{BBA7E70F-3FD3-11D3-B65A-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Item(Index: Integer): WideString; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  ObjectVerbsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BBA7E70F-3FD3-11D3-B65A-00C04F8EF32D}
// *********************************************************************//
  ObjectVerbsDisp = dispinterface
    ['{BBA7E70F-3FD3-11D3-B65A-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
    function  Item(Index: Integer): WideString; dispid 0;
  end;

// *********************************************************************//
// Interface: Tags
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C2B7CD7-F864-11D2-8C7A-00C04F8EF340}
// *********************************************************************//
  Tags = interface(IDispatch)
    ['{2C2B7CD7-F864-11D2-8C7A-00C04F8EF340}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Item(Index: OleVariant): Tag; safecall;
    function  Add(const Name: WideString; Value: OleVariant): Tag; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  TagsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2C2B7CD7-F864-11D2-8C7A-00C04F8EF340}
// *********************************************************************//
  TagsDisp = dispinterface
    ['{2C2B7CD7-F864-11D2-8C7A-00C04F8EF340}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
    function  Item(Index: OleVariant): Tag; dispid 0;
    function  Add(const Name: WideString; Value: OleVariant): Tag; dispid 4;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: Tag
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DA45FDD2-4B16-4E7C-A1E3-F1ADD18DD65A}
// *********************************************************************//
  Tag = interface(IDispatch)
    ['{DA45FDD2-4B16-4E7C-A1E3-F1ADD18DD65A}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Value: OleVariant; safecall;
    procedure Set_Value(Value: OleVariant); safecall;
    procedure Delete; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Name: WideString read Get_Name;
    property Value: OleVariant read Get_Value write Set_Value;
  end;

// *********************************************************************//
// DispIntf:  TagDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DA45FDD2-4B16-4E7C-A1E3-F1ADD18DD65A}
// *********************************************************************//
  TagDisp = dispinterface
    ['{DA45FDD2-4B16-4E7C-A1E3-F1ADD18DD65A}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Name: WideString readonly dispid 3;
    property Value: OleVariant dispid 4;
    procedure Delete; dispid 5;
  end;

// *********************************************************************//
// Interface: WebCommandButton
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E792405F-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebCommandButton = interface(IDispatch)
    ['{E792405F-8668-11D3-9058-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ActionURL: WideString; safecall;
    procedure Set_ActionURL(const URL: WideString); safecall;
    function  Get_ButtonText: WideString; safecall;
    procedure Set_ButtonText(const Text: WideString); safecall;
    function  Get_DataFileName: WideString; safecall;
    procedure Set_DataFileName(const Filename: WideString); safecall;
    function  Get_DataRetrievalMethod: PbSubmitDataRetrievalMethodType; safecall;
    procedure Set_DataRetrievalMethod(Method: PbSubmitDataRetrievalMethodType); safecall;
    function  Get_EmailAddress: WideString; safecall;
    procedure Set_EmailAddress(const Address: WideString); safecall;
    function  Get_EmailSubject: WideString; safecall;
    procedure Set_EmailSubject(const Subject: WideString); safecall;
    function  Get_DataFileFormat: PbSubmitDataFormatType; safecall;
    procedure Set_DataFileFormat(Format: PbSubmitDataFormatType); safecall;
    function  Get_PostFormData: MsoTriState; safecall;
    procedure Set_PostFormData(Post: MsoTriState); safecall;
    function  Get_HiddenFields: WebHiddenFields; safecall;
    function  Get_ButtonType: PbCommandButtonType; safecall;
    procedure Set_ButtonType(Type_: PbCommandButtonType); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ActionURL: WideString read Get_ActionURL write Set_ActionURL;
    property ButtonText: WideString read Get_ButtonText write Set_ButtonText;
    property DataFileName: WideString read Get_DataFileName write Set_DataFileName;
    property DataRetrievalMethod: PbSubmitDataRetrievalMethodType read Get_DataRetrievalMethod write Set_DataRetrievalMethod;
    property EmailAddress: WideString read Get_EmailAddress write Set_EmailAddress;
    property EmailSubject: WideString read Get_EmailSubject write Set_EmailSubject;
    property DataFileFormat: PbSubmitDataFormatType read Get_DataFileFormat write Set_DataFileFormat;
    property PostFormData: MsoTriState read Get_PostFormData write Set_PostFormData;
    property HiddenFields: WebHiddenFields read Get_HiddenFields;
    property ButtonType: PbCommandButtonType read Get_ButtonType write Set_ButtonType;
  end;

// *********************************************************************//
// DispIntf:  WebCommandButtonDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E792405F-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebCommandButtonDisp = dispinterface
    ['{E792405F-8668-11D3-9058-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property ActionURL: WideString dispid 3;
    property ButtonText: WideString dispid 4;
    property DataFileName: WideString dispid 5;
    property DataRetrievalMethod: PbSubmitDataRetrievalMethodType dispid 6;
    property EmailAddress: WideString dispid 7;
    property EmailSubject: WideString dispid 8;
    property DataFileFormat: PbSubmitDataFormatType dispid 9;
    property PostFormData: MsoTriState dispid 10;
    property HiddenFields: WebHiddenFields readonly dispid 11;
    property ButtonType: PbCommandButtonType dispid 12;
  end;

// *********************************************************************//
// Interface: WebHiddenFields
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924060-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebHiddenFields = interface(IDispatch)
    ['{E7924060-8668-11D3-9058-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  Add(const Name: WideString; const Value: WideString): Integer; safecall;
    procedure Delete(Index: Integer); safecall;
    function  Item(Index: OleVariant): WideString; safecall;
    function  Name(Index: Integer): WideString; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  WebHiddenFieldsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924060-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebHiddenFieldsDisp = dispinterface
    ['{E7924060-8668-11D3-9058-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    function  Add(const Name: WideString; const Value: WideString): Integer; dispid 4;
    procedure Delete(Index: Integer); dispid 5;
    function  Item(Index: OleVariant): WideString; dispid 6;
    function  Name(Index: Integer): WideString; dispid 7;
  end;

// *********************************************************************//
// Interface: WebListBox
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924061-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebListBox = interface(IDispatch)
    ['{E7924061-8668-11D3-9058-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ListBoxItems: WebListBoxItems; safecall;
    function  Get_MultiSelect: MsoTriState; safecall;
    procedure Set_MultiSelect(Multi: MsoTriState); safecall;
    function  Get_ReturnDataLabel: WideString; safecall;
    procedure Set_ReturnDataLabel(const Label_: WideString); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ListBoxItems: WebListBoxItems read Get_ListBoxItems;
    property MultiSelect: MsoTriState read Get_MultiSelect write Set_MultiSelect;
    property ReturnDataLabel: WideString read Get_ReturnDataLabel write Set_ReturnDataLabel;
  end;

// *********************************************************************//
// DispIntf:  WebListBoxDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924061-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebListBoxDisp = dispinterface
    ['{E7924061-8668-11D3-9058-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property ListBoxItems: WebListBoxItems readonly dispid 3;
    property MultiSelect: MsoTriState dispid 4;
    property ReturnDataLabel: WideString dispid 5;
  end;

// *********************************************************************//
// Interface: WebListBoxItems
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924062-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebListBoxItems = interface(IDispatch)
    ['{E7924062-8668-11D3-9058-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    procedure AddItem(const Item: WideString; Index: Integer; SelectState: WordBool; 
                      const ItemValue: WideString); safecall;
    procedure Delete(Index: Integer); safecall;
    function  Item(Index: OleVariant): WideString; safecall;
    procedure Selected(Index: Integer; SelectState: WordBool); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  WebListBoxItemsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924062-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebListBoxItemsDisp = dispinterface
    ['{E7924062-8668-11D3-9058-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    procedure AddItem(const Item: WideString; Index: Integer; SelectState: WordBool; 
                      const ItemValue: WideString); dispid 4;
    procedure Delete(Index: Integer); dispid 5;
    function  Item(Index: OleVariant): WideString; dispid 6;
    procedure Selected(Index: Integer; SelectState: WordBool); dispid 7;
  end;

// *********************************************************************//
// Interface: WebTextBox
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924063-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebTextBox = interface(IDispatch)
    ['{E7924063-8668-11D3-9058-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_DefaultText: WideString; safecall;
    procedure Set_DefaultText(const Text: WideString); safecall;
    function  Get_EchoAsterisks: MsoTriState; safecall;
    procedure Set_EchoAsterisks(Echo: MsoTriState); safecall;
    function  Get_Limit: Integer; safecall;
    procedure Set_Limit(Echo: Integer); safecall;
    function  Get_RequiredControl: MsoTriState; safecall;
    procedure Set_RequiredControl(Required: MsoTriState); safecall;
    function  Get_ReturnDataLabel: WideString; safecall;
    procedure Set_ReturnDataLabel(const Label_: WideString); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property DefaultText: WideString read Get_DefaultText write Set_DefaultText;
    property EchoAsterisks: MsoTriState read Get_EchoAsterisks write Set_EchoAsterisks;
    property Limit: Integer read Get_Limit write Set_Limit;
    property RequiredControl: MsoTriState read Get_RequiredControl write Set_RequiredControl;
    property ReturnDataLabel: WideString read Get_ReturnDataLabel write Set_ReturnDataLabel;
  end;

// *********************************************************************//
// DispIntf:  WebTextBoxDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924063-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebTextBoxDisp = dispinterface
    ['{E7924063-8668-11D3-9058-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property DefaultText: WideString dispid 3;
    property EchoAsterisks: MsoTriState dispid 4;
    property Limit: Integer dispid 5;
    property RequiredControl: MsoTriState dispid 6;
    property ReturnDataLabel: WideString dispid 7;
  end;

// *********************************************************************//
// Interface: WebOptionButton
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924064-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebOptionButton = interface(IDispatch)
    ['{E7924064-8668-11D3-9058-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ReturnDataLabel: WideString; safecall;
    procedure Set_ReturnDataLabel(const Label_: WideString); safecall;
    function  Get_Selected: MsoTriState; safecall;
    procedure Set_Selected(Selected: MsoTriState); safecall;
    function  Get_Value: WideString; safecall;
    procedure Set_Value(const Value: WideString); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ReturnDataLabel: WideString read Get_ReturnDataLabel write Set_ReturnDataLabel;
    property Selected: MsoTriState read Get_Selected write Set_Selected;
    property Value: WideString read Get_Value write Set_Value;
  end;

// *********************************************************************//
// DispIntf:  WebOptionButtonDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924064-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebOptionButtonDisp = dispinterface
    ['{E7924064-8668-11D3-9058-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property ReturnDataLabel: WideString dispid 3;
    property Selected: MsoTriState dispid 4;
    property Value: WideString dispid 5;
  end;

// *********************************************************************//
// Interface: WebCheckBox
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924065-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebCheckBox = interface(IDispatch)
    ['{E7924065-8668-11D3-9058-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ReturnDataLabel: WideString; safecall;
    procedure Set_ReturnDataLabel(const Label_: WideString); safecall;
    function  Get_Selected: MsoTriState; safecall;
    procedure Set_Selected(Selected: MsoTriState); safecall;
    function  Get_Value: WideString; safecall;
    procedure Set_Value(const Value: WideString); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ReturnDataLabel: WideString read Get_ReturnDataLabel write Set_ReturnDataLabel;
    property Selected: MsoTriState read Get_Selected write Set_Selected;
    property Value: WideString read Get_Value write Set_Value;
  end;

// *********************************************************************//
// DispIntf:  WebCheckBoxDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {E7924065-8668-11D3-9058-00C04F799E3F}
// *********************************************************************//
  WebCheckBoxDisp = dispinterface
    ['{E7924065-8668-11D3-9058-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property ReturnDataLabel: WideString dispid 3;
    property Selected: MsoTriState dispid 4;
    property Value: WideString dispid 5;
  end;

// *********************************************************************//
// Interface: Wizard
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9093-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  Wizard = interface(IDispatch)
    ['{286A9093-BD9E-11D3-B675-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ID: SYSINT; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Properties: WizardProperties; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ID: SYSINT read Get_ID;
    property Name: WideString read Get_Name;
    property Properties: WizardProperties read Get_Properties;
  end;

// *********************************************************************//
// DispIntf:  WizardDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9093-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  WizardDisp = dispinterface
    ['{286A9093-BD9E-11D3-B675-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property ID: SYSINT readonly dispid 3;
    property Name: WideString readonly dispid 4;
    property Properties: WizardProperties readonly dispid 5;
  end;

// *********************************************************************//
// Interface: WizardProperties
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9094-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  WizardProperties = interface(IDispatch)
    ['{286A9094-BD9E-11D3-B675-00C04F8EF32D}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(Item: Integer): WizardProperty; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  FindPropertyById(ID: Integer): WizardProperty; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[Item: Integer]: WizardProperty read Get_Item; default;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  WizardPropertiesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9094-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  WizardPropertiesDisp = dispinterface
    ['{286A9094-BD9E-11D3-B675-00C04F8EF32D}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[Item: Integer]: WizardProperty readonly dispid 0; default;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    function  FindPropertyById(ID: Integer): WizardProperty; dispid 4;
  end;

// *********************************************************************//
// Interface: WizardProperty
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9095-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  WizardProperty = interface(IDispatch)
    ['{286A9095-BD9E-11D3-B675-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ID: Integer; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_CurrentValueId: Integer; safecall;
    procedure Set_CurrentValueId(ID: Integer); safecall;
    function  Get_Enabled: WordBool; safecall;
    function  Get_Values: WizardValues; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ID: Integer read Get_ID;
    property Name: WideString read Get_Name;
    property CurrentValueId: Integer read Get_CurrentValueId write Set_CurrentValueId;
    property Enabled: WordBool read Get_Enabled;
    property Values: WizardValues read Get_Values;
  end;

// *********************************************************************//
// DispIntf:  WizardPropertyDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9095-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  WizardPropertyDisp = dispinterface
    ['{286A9095-BD9E-11D3-B675-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property ID: Integer readonly dispid 3;
    property Name: WideString readonly dispid 0;
    property CurrentValueId: Integer dispid 5;
    property Enabled: WordBool readonly dispid 7;
    property Values: WizardValues readonly dispid 8;
  end;

// *********************************************************************//
// Interface: WizardValues
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9096-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  WizardValues = interface(IDispatch)
    ['{286A9096-BD9E-11D3-B675-00C04F8EF32D}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(Item: Integer): WizardValue; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[Item: Integer]: WizardValue read Get_Item; default;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  WizardValuesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9096-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  WizardValuesDisp = dispinterface
    ['{286A9096-BD9E-11D3-B675-00C04F8EF32D}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[Item: Integer]: WizardValue readonly dispid 0; default;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
  end;

// *********************************************************************//
// Interface: WizardValue
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9097-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  WizardValue = interface(IDispatch)
    ['{286A9097-BD9E-11D3-B675-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ID: Integer; safecall;
    function  Get_Name: WideString; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ID: Integer read Get_ID;
    property Name: WideString read Get_Name;
  end;

// *********************************************************************//
// DispIntf:  WizardValueDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {286A9097-BD9E-11D3-B675-00C04F8EF32D}
// *********************************************************************//
  WizardValueDisp = dispinterface
    ['{286A9097-BD9E-11D3-B675-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property ID: Integer readonly dispid 3;
    property Name: WideString readonly dispid 0;
  end;

// *********************************************************************//
// Interface: WrapFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {CF7E7E58-E0D9-11D3-A8F1-00C04F8EF4EA}
// *********************************************************************//
  WrapFormat = interface(IDispatch)
    ['{CF7E7E58-E0D9-11D3-A8F1-00C04F8EF4EA}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Type_: PbWrapType; safecall;
    procedure Set_Type_(RetVal: PbWrapType); safecall;
    function  Get_Side: PbWrapSideType; safecall;
    procedure Set_Side(RetVal: PbWrapSideType); safecall;
    function  Get_DistanceAuto: MsoTriState; safecall;
    procedure Set_DistanceAuto(RetValue: MsoTriState); safecall;
    function  Get_DistanceTop: OleVariant; safecall;
    procedure Set_DistanceTop(RetVal: OleVariant); safecall;
    function  Get_DistanceLeft: OleVariant; safecall;
    procedure Set_DistanceLeft(RetVal: OleVariant); safecall;
    function  Get_DistanceBottom: OleVariant; safecall;
    procedure Set_DistanceBottom(RetVal: OleVariant); safecall;
    function  Get_DistanceRight: OleVariant; safecall;
    procedure Set_DistanceRight(RetVal: OleVariant); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Type_: PbWrapType read Get_Type_ write Set_Type_;
    property Side: PbWrapSideType read Get_Side write Set_Side;
    property DistanceAuto: MsoTriState read Get_DistanceAuto write Set_DistanceAuto;
    property DistanceTop: OleVariant read Get_DistanceTop write Set_DistanceTop;
    property DistanceLeft: OleVariant read Get_DistanceLeft write Set_DistanceLeft;
    property DistanceBottom: OleVariant read Get_DistanceBottom write Set_DistanceBottom;
    property DistanceRight: OleVariant read Get_DistanceRight write Set_DistanceRight;
  end;

// *********************************************************************//
// DispIntf:  WrapFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {CF7E7E58-E0D9-11D3-A8F1-00C04F8EF4EA}
// *********************************************************************//
  WrapFormatDisp = dispinterface
    ['{CF7E7E58-E0D9-11D3-A8F1-00C04F8EF4EA}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Type_: PbWrapType dispid 3;
    property Side: PbWrapSideType dispid 4;
    property DistanceAuto: MsoTriState dispid 5;
    property DistanceTop: OleVariant dispid 6;
    property DistanceLeft: OleVariant dispid 7;
    property DistanceBottom: OleVariant dispid 8;
    property DistanceRight: OleVariant dispid 9;
  end;

// *********************************************************************//
// Interface: BorderArtFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D70F454F-0669-42A8-B8E6-EFF0686490AE}
// *********************************************************************//
  BorderArtFormat = interface(IDispatch)
    ['{D70F454F-0669-42A8-B8E6-EFF0686490AE}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Name: WideString; safecall;
    procedure Set_Name(Name: OleVariant); safecall;
    procedure RevertToDefaultWeight; safecall;
    function  Get_StretchPictures: WordBool; safecall;
    procedure Set_StretchPictures(StretchPictures: WordBool); safecall;
    function  Get_Weight: OleVariant; safecall;
    procedure Set_Weight(Weight: OleVariant); safecall;
    function  Get_Color: ColorFormat; safecall;
    procedure Set_Color(const Color: ColorFormat); safecall;
    procedure Delete; safecall;
    procedure Set_(BorderArtName: OleVariant); safecall;
    procedure RevertToOriginalColor; safecall;
    function  Get_Exists: WordBool; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property StretchPictures: WordBool read Get_StretchPictures write Set_StretchPictures;
    property Weight: OleVariant read Get_Weight write Set_Weight;
    property Color: ColorFormat read Get_Color write Set_Color;
    property Exists: WordBool read Get_Exists;
  end;

// *********************************************************************//
// DispIntf:  BorderArtFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D70F454F-0669-42A8-B8E6-EFF0686490AE}
// *********************************************************************//
  BorderArtFormatDisp = dispinterface
    ['{D70F454F-0669-42A8-B8E6-EFF0686490AE}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    function  Name: WideString; dispid 0;
    procedure RevertToDefaultWeight; dispid 5;
    property StretchPictures: WordBool dispid 6;
    property Weight: OleVariant dispid 7;
    property Color: ColorFormat dispid 8;
    procedure Delete; dispid 9;
    procedure Set_(BorderArtName: OleVariant); dispid 10;
    procedure RevertToOriginalColor; dispid 11;
    property Exists: WordBool readonly dispid 12;
  end;

// *********************************************************************//
// Interface: CatalogMergeShapes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7ADEC766-2AE9-44FF-9EEC-B85F9E1C2D82}
// *********************************************************************//
  CatalogMergeShapes = interface(IDispatch)
    ['{7ADEC766-2AE9-44FF-9EEC-B85F9E1C2D82}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Item(Index: OleVariant): Shape; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Range(Index: OleVariant): ShapeRange; safecall;
    function  Get_HorizontalRepeat: SYSINT; safecall;
    function  Get_VerticalRepeat: SYSINT; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property HorizontalRepeat: SYSINT read Get_HorizontalRepeat;
    property VerticalRepeat: SYSINT read Get_VerticalRepeat;
  end;

// *********************************************************************//
// DispIntf:  CatalogMergeShapesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7ADEC766-2AE9-44FF-9EEC-B85F9E1C2D82}
// *********************************************************************//
  CatalogMergeShapesDisp = dispinterface
    ['{7ADEC766-2AE9-44FF-9EEC-B85F9E1C2D82}']
    property _NewEnum: IUnknown readonly dispid -4;
    function  Item(Index: OleVariant): Shape; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
    function  Range(Index: OleVariant): ShapeRange; dispid 4;
    property HorizontalRepeat: SYSINT readonly dispid 5;
    property VerticalRepeat: SYSINT readonly dispid 6;
  end;

// *********************************************************************//
// Interface: WebOptions
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {726060F6-2A2C-4E46-AC8A-7CEE29E11FC3}
// *********************************************************************//
  WebOptions = interface(IDispatch)
    ['{726060F6-2A2C-4E46-AC8A-7CEE29E11FC3}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_AlwaysSaveInDefaultEncoding: WordBool; safecall;
    procedure Set_AlwaysSaveInDefaultEncoding(RetValue: WordBool); safecall;
    function  Get_Encoding: MsoEncoding; safecall;
    procedure Set_Encoding(pencoding: MsoEncoding); safecall;
    function  Get_EnableIncrementalUpload: WordBool; safecall;
    procedure Set_EnableIncrementalUpload(RetValue: WordBool); safecall;
    function  Get_OrganizeInFolder: WordBool; safecall;
    procedure Set_OrganizeInFolder(RetValue: WordBool); safecall;
    function  Get_RelyOnVML: WordBool; safecall;
    procedure Set_RelyOnVML(RetValue: WordBool); safecall;
    function  Get_ShowOnlyWebFonts: WordBool; safecall;
    procedure Set_ShowOnlyWebFonts(RetValue: WordBool); safecall;
    function  Get_EmailAsImg: WordBool; safecall;
    procedure Set_EmailAsImg(RetValue: WordBool); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property AlwaysSaveInDefaultEncoding: WordBool read Get_AlwaysSaveInDefaultEncoding write Set_AlwaysSaveInDefaultEncoding;
    property Encoding: MsoEncoding read Get_Encoding write Set_Encoding;
    property EnableIncrementalUpload: WordBool read Get_EnableIncrementalUpload write Set_EnableIncrementalUpload;
    property OrganizeInFolder: WordBool read Get_OrganizeInFolder write Set_OrganizeInFolder;
    property RelyOnVML: WordBool read Get_RelyOnVML write Set_RelyOnVML;
    property ShowOnlyWebFonts: WordBool read Get_ShowOnlyWebFonts write Set_ShowOnlyWebFonts;
    property EmailAsImg: WordBool read Get_EmailAsImg write Set_EmailAsImg;
  end;

// *********************************************************************//
// DispIntf:  WebOptionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {726060F6-2A2C-4E46-AC8A-7CEE29E11FC3}
// *********************************************************************//
  WebOptionsDisp = dispinterface
    ['{726060F6-2A2C-4E46-AC8A-7CEE29E11FC3}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property AlwaysSaveInDefaultEncoding: WordBool dispid 3;
    property Encoding: MsoEncoding dispid 4;
    property EnableIncrementalUpload: WordBool dispid 5;
    property OrganizeInFolder: WordBool dispid 6;
    property RelyOnVML: WordBool dispid 7;
    property ShowOnlyWebFonts: WordBool dispid 8;
    property EmailAsImg: WordBool dispid 9;
  end;

// *********************************************************************//
// Interface: IApplicationEvents
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002123F-0000-0000-C000-000000000046}
// *********************************************************************//
  IApplicationEvents = interface(IDispatch)
    ['{0002123F-0000-0000-C000-000000000046}']
    procedure WindowActivate(const Wn: Window); safecall;
    procedure WindowDeactivate(const Wn: Window); safecall;
    procedure WindowPageChange(const Vw: View); safecall;
    procedure Quit; safecall;
    procedure NewDocument(const Doc: _Document); safecall;
    procedure DocumentOpen(const Doc: _Document); safecall;
    procedure DocumentBeforeClose(const Doc: _Document; var Cancel: WordBool); safecall;
    procedure MailMergeAfterMerge(const Doc: _Document); safecall;
    procedure MailMergeAfterRecordMerge(const Doc: _Document); safecall;
    procedure MailMergeBeforeMerge(const Doc: _Document; StartRecord: Integer; EndRecord: Integer; 
                                   var Cancel: WordBool); safecall;
    procedure MailMergeBeforeRecordMerge(const Doc: _Document; var Cancel: WordBool); safecall;
    procedure MailMergeDataSourceLoad(const Doc: _Document); safecall;
    procedure MailMergeWizardSendToCustom(const Doc: _Document); safecall;
    procedure MailMergeWizardStateChange(const Doc: _Document; FromState: SYSINT); safecall;
    procedure MailMergeDataSourceValidate(const Doc: _Document; var Handled: WordBool); safecall;
  end;

// *********************************************************************//
// DispIntf:  IApplicationEventsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0002123F-0000-0000-C000-000000000046}
// *********************************************************************//
  IApplicationEventsDisp = dispinterface
    ['{0002123F-0000-0000-C000-000000000046}']
    procedure WindowActivate(const Wn: Window); dispid 1;
    procedure WindowDeactivate(const Wn: Window); dispid 2;
    procedure WindowPageChange(const Vw: View); dispid 4;
    procedure Quit; dispid 5;
    procedure NewDocument(const Doc: _Document); dispid 6;
    procedure DocumentOpen(const Doc: _Document); dispid 7;
    procedure DocumentBeforeClose(const Doc: _Document; var Cancel: WordBool); dispid 8;
    procedure MailMergeAfterMerge(const Doc: _Document); dispid 9;
    procedure MailMergeAfterRecordMerge(const Doc: _Document); dispid 10;
    procedure MailMergeBeforeMerge(const Doc: _Document; StartRecord: Integer; EndRecord: Integer; 
                                   var Cancel: WordBool); dispid 11;
    procedure MailMergeBeforeRecordMerge(const Doc: _Document; var Cancel: WordBool); dispid 12;
    procedure MailMergeDataSourceLoad(const Doc: _Document); dispid 13;
    procedure MailMergeWizardSendToCustom(const Doc: _Document); dispid 16;
    procedure MailMergeWizardStateChange(const Doc: _Document; FromState: SYSINT); dispid 17;
    procedure MailMergeDataSourceValidate(const Doc: _Document; var Handled: WordBool); dispid 18;
  end;

// *********************************************************************//
// Interface: View
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39051BAC-5CA7-11D3-B65F-00C04F8EF32D}
// *********************************************************************//
  View = interface(IDispatch)
    ['{39051BAC-5CA7-11D3-B65F-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ActivePage: Page; safecall;
    procedure Set_ActivePage(const RetValue: Page); safecall;
    function  Get_Zoom: PbZoom; safecall;
    procedure Set_Zoom(pZoom: PbZoom); safecall;
    procedure ScrollShapeIntoView(const Shape: Shape); safecall;
    procedure ZoomIn; safecall;
    procedure ZoomOut; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ActivePage: Page read Get_ActivePage write Set_ActivePage;
    property Zoom: PbZoom read Get_Zoom write Set_Zoom;
  end;

// *********************************************************************//
// DispIntf:  ViewDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {39051BAC-5CA7-11D3-B65F-00C04F8EF32D}
// *********************************************************************//
  ViewDisp = dispinterface
    ['{39051BAC-5CA7-11D3-B65F-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property ActivePage: Page dispid 3;
    property Zoom: PbZoom dispid 4;
    procedure ScrollShapeIntoView(const Shape: Shape); dispid 5;
    procedure ZoomIn; dispid 6;
    procedure ZoomOut; dispid 7;
  end;

// *********************************************************************//
// Interface: Page
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021246-0000-0000-C000-000000000046}
// *********************************************************************//
  Page = interface(IDispatch)
    ['{00021246-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Shapes: Shapes; safecall;
    function  Get_PageNumber: WideString; safecall;
    function  Get_PageType: PbPageType; safecall;
    function  Get_Master: Page; safecall;
    function  Get_PageID: Integer; safecall;
    function  Get_PageIndex: Integer; safecall;
    function  Get_RulerGuides: RulerGuides; safecall;
    procedure Delete; safecall;
    function  Get_IgnoreMaster: WordBool; safecall;
    procedure Set_IgnoreMaster(RetValue: WordBool); safecall;
    function  Get_Wizard: Wizard; safecall;
    function  Get_Tags: Tags; safecall;
    function  Get_XOffsetWithinReaderSpread: Single; safecall;
    function  Get_YOffsetWithinReaderSpread: Single; safecall;
    function  Get_ReaderSpread: ReaderSpread; safecall;
    function  Get_Width: Integer; safecall;
    function  Get_Height: Integer; safecall;
    procedure SaveAsPicture10(const Filename: WideString); safecall;
    function  Get_Name: WideString; safecall;
    procedure Set_Name(const RetVal: WideString); safecall;
    function  Get_IsTwoPageMaster: WordBool; safecall;
    procedure Set_IsTwoPageMaster(RetVal: WordBool); safecall;
    function  Get_IsTrailing: WordBool; safecall;
    function  Get_IsLeading: WordBool; safecall;
    function  Get_Header: HeaderFooter; safecall;
    function  Get_Footer: HeaderFooter; safecall;
    function  Get_Background: PageBackground; safecall;
    function  Duplicate(const NewAbbreviation: WideString; const NewName: WideString): Page; safecall;
    procedure Move(Page: Integer; After: WordBool); safecall;
    function  Get_WebPageOptions: WebPageOptions; safecall;
    function  Get_LayoutGuides: LayoutGuides; safecall;
    procedure Set_Master(const MasterPage: Page); safecall;
    procedure Set_PageNumber(const RetVal: WideString); safecall;
    function  Get_IsWizardPage: WordBool; safecall;
    procedure SaveAsPicture(const Filename: WideString; pbResolution: PbPictureResolution); safecall;
    procedure ExportEmailHTML(const Filename: WideString); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Shapes: Shapes read Get_Shapes;
    property PageNumber: WideString read Get_PageNumber write Set_PageNumber;
    property PageType: PbPageType read Get_PageType;
    property Master: Page read Get_Master write Set_Master;
    property PageID: Integer read Get_PageID;
    property PageIndex: Integer read Get_PageIndex;
    property RulerGuides: RulerGuides read Get_RulerGuides;
    property IgnoreMaster: WordBool read Get_IgnoreMaster write Set_IgnoreMaster;
    property Wizard: Wizard read Get_Wizard;
    property Tags: Tags read Get_Tags;
    property XOffsetWithinReaderSpread: Single read Get_XOffsetWithinReaderSpread;
    property YOffsetWithinReaderSpread: Single read Get_YOffsetWithinReaderSpread;
    property ReaderSpread: ReaderSpread read Get_ReaderSpread;
    property Width: Integer read Get_Width;
    property Height: Integer read Get_Height;
    property Name: WideString read Get_Name write Set_Name;
    property IsTwoPageMaster: WordBool read Get_IsTwoPageMaster write Set_IsTwoPageMaster;
    property IsTrailing: WordBool read Get_IsTrailing;
    property IsLeading: WordBool read Get_IsLeading;
    property Header: HeaderFooter read Get_Header;
    property Footer: HeaderFooter read Get_Footer;
    property Background: PageBackground read Get_Background;
    property WebPageOptions: WebPageOptions read Get_WebPageOptions;
    property LayoutGuides: LayoutGuides read Get_LayoutGuides;
    property IsWizardPage: WordBool read Get_IsWizardPage;
  end;

// *********************************************************************//
// DispIntf:  PageDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021246-0000-0000-C000-000000000046}
// *********************************************************************//
  PageDisp = dispinterface
    ['{00021246-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Shapes: Shapes readonly dispid 3;
    property PageNumber: WideString dispid 4;
    property PageType: PbPageType readonly dispid 5;
    property Master: Page dispid 6;
    property PageID: Integer readonly dispid 7;
    property PageIndex: Integer readonly dispid 8;
    property RulerGuides: RulerGuides readonly dispid 9;
    procedure Delete; dispid 10;
    property IgnoreMaster: WordBool dispid 11;
    property Wizard: Wizard readonly dispid 12;
    property Tags: Tags readonly dispid 13;
    property XOffsetWithinReaderSpread: Single readonly dispid 14;
    property YOffsetWithinReaderSpread: Single readonly dispid 15;
    property ReaderSpread: ReaderSpread readonly dispid 16;
    property Width: Integer readonly dispid 17;
    property Height: Integer readonly dispid 18;
    procedure SaveAsPicture10(const Filename: WideString); dispid 19;
    property Name: WideString dispid 20;
    property IsTwoPageMaster: WordBool dispid 22;
    property IsTrailing: WordBool readonly dispid 23;
    property IsLeading: WordBool readonly dispid 24;
    property Header: HeaderFooter readonly dispid 25;
    property Footer: HeaderFooter readonly dispid 26;
    property Background: PageBackground readonly dispid 27;
    function  Duplicate(const NewAbbreviation: WideString; const NewName: WideString): Page; dispid 28;
    procedure Move(Page: Integer; After: WordBool); dispid 29;
    property WebPageOptions: WebPageOptions readonly dispid 30;
    property LayoutGuides: LayoutGuides readonly dispid 36;
    property IsWizardPage: WordBool readonly dispid 37;
    procedure SaveAsPicture(const Filename: WideString; pbResolution: PbPictureResolution); dispid 38;
    procedure ExportEmailHTML(const Filename: WideString); dispid 39;
  end;

// *********************************************************************//
// Interface: Shapes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021235-0000-0000-C000-000000000046}
// *********************************************************************//
  Shapes = interface(IDispatch)
    ['{00021235-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Item(Index: OleVariant): Shape; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  AddCallout(Type_: MsoCalloutType; Left: OleVariant; Top: OleVariant; 
                         Width: OleVariant; Height: OleVariant): Shape; safecall;
    function  AddConnector(Type_: MsoConnectorType; BeginX: OleVariant; BeginY: OleVariant; 
                           EndX: OleVariant; EndY: OleVariant): Shape; safecall;
    function  AddCurve(SafeArrayOfPoints: OleVariant): Shape; safecall;
    function  AddLabel(Orientation: PbTextOrientation; Left: OleVariant; Top: OleVariant; 
                       Width: OleVariant; Height: OleVariant): Shape; safecall;
    function  AddLine(BeginX: OleVariant; BeginY: OleVariant; EndX: OleVariant; EndY: OleVariant): Shape; safecall;
    function  AddOLEObject(Left: OleVariant; Top: OleVariant; Width: OleVariant; 
                           Height: OleVariant; const ClassName: WideString; 
                           const Filename: WideString; Link: MsoTriState): Shape; safecall;
    function  AddPicture(const Filename: WideString; LinkToFile: MsoTriState; 
                         SaveWithDocument: MsoTriState; Left: OleVariant; Top: OleVariant; 
                         Width: OleVariant; Height: OleVariant): Shape; safecall;
    function  AddPolyline(SafeArrayOfPoints: OleVariant): Shape; safecall;
    function  AddShape(Type_: MsoAutoShapeType; Left: OleVariant; Top: OleVariant; 
                       Width: OleVariant; Height: OleVariant): Shape; safecall;
    function  AddTable(NumRows: Integer; NumColumns: Integer; Left: OleVariant; Top: OleVariant; 
                       Width: OleVariant; Height: OleVariant; FixedSize: WordBool; 
                       Direction: PbTableDirectionType): Shape; safecall;
    function  AddTextbox(Orientation: PbTextOrientation; Left: OleVariant; Top: OleVariant; 
                         Width: OleVariant; Height: OleVariant): Shape; safecall;
    function  AddTextEffect(PresetTextEffect: MsoPresetTextEffect; const Text: WideString; 
                            const FontName: WideString; FontSize: OleVariant; 
                            FontBold: MsoTriState; FontItalic: MsoTriState; Left: OleVariant; 
                            Top: OleVariant): Shape; safecall;
    function  AddWebControl(Type_: PbWebControlType; Left: OleVariant; Top: OleVariant; 
                            Width: OleVariant; Height: OleVariant; LaunchPropertiesWindow: WordBool): Shape; safecall;
    function  BuildFreeform(EditingType: MsoEditingType; X1: OleVariant; Y1: OleVariant): FreeformBuilder; safecall;
    function  Paste: ShapeRange; safecall;
    function  Range(Index: OleVariant): ShapeRange; safecall;
    procedure SelectAll; safecall;
    function  AddGroupWizard(Wizard: PbWizardGroup; Left: OleVariant; Top: OleVariant; 
                             Width: OleVariant; Height: OleVariant; Design: Integer): Shape; safecall;
    function  FindShapeByWizardTag(WizardTag: PbWizardTag; Instance: Integer): ShapeRange; safecall;
    function  AddWebNavigationBar(const Name: WideString; Left: OleVariant; Top: OleVariant; 
                                  Width: OleVariant): Shape; safecall;
    function  AddCatalogMergeArea: Shape; safecall;
    function  AddEmptyPictureFrame(Left: OleVariant; Top: OleVariant; Width: OleVariant; 
                                   Height: OleVariant): Shape; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  ShapesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021235-0000-0000-C000-000000000046}
// *********************************************************************//
  ShapesDisp = dispinterface
    ['{00021235-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
    function  Item(Index: OleVariant): Shape; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function  AddCallout(Type_: MsoCalloutType; Left: OleVariant; Top: OleVariant; 
                         Width: OleVariant; Height: OleVariant): Shape; dispid 10;
    function  AddConnector(Type_: MsoConnectorType; BeginX: OleVariant; BeginY: OleVariant; 
                           EndX: OleVariant; EndY: OleVariant): Shape; dispid 11;
    function  AddCurve(SafeArrayOfPoints: OleVariant): Shape; dispid 12;
    function  AddLabel(Orientation: PbTextOrientation; Left: OleVariant; Top: OleVariant; 
                       Width: OleVariant; Height: OleVariant): Shape; dispid 13;
    function  AddLine(BeginX: OleVariant; BeginY: OleVariant; EndX: OleVariant; EndY: OleVariant): Shape; dispid 14;
    function  AddOLEObject(Left: OleVariant; Top: OleVariant; Width: OleVariant; 
                           Height: OleVariant; const ClassName: WideString; 
                           const Filename: WideString; Link: MsoTriState): Shape; dispid 15;
    function  AddPicture(const Filename: WideString; LinkToFile: MsoTriState; 
                         SaveWithDocument: MsoTriState; Left: OleVariant; Top: OleVariant; 
                         Width: OleVariant; Height: OleVariant): Shape; dispid 16;
    function  AddPolyline(SafeArrayOfPoints: OleVariant): Shape; dispid 17;
    function  AddShape(Type_: MsoAutoShapeType; Left: OleVariant; Top: OleVariant; 
                       Width: OleVariant; Height: OleVariant): Shape; dispid 18;
    function  AddTable(NumRows: Integer; NumColumns: Integer; Left: OleVariant; Top: OleVariant; 
                       Width: OleVariant; Height: OleVariant; FixedSize: WordBool; 
                       Direction: PbTableDirectionType): Shape; dispid 19;
    function  AddTextbox(Orientation: PbTextOrientation; Left: OleVariant; Top: OleVariant; 
                         Width: OleVariant; Height: OleVariant): Shape; dispid 20;
    function  AddTextEffect(PresetTextEffect: MsoPresetTextEffect; const Text: WideString; 
                            const FontName: WideString; FontSize: OleVariant; 
                            FontBold: MsoTriState; FontItalic: MsoTriState; Left: OleVariant; 
                            Top: OleVariant): Shape; dispid 21;
    function  AddWebControl(Type_: PbWebControlType; Left: OleVariant; Top: OleVariant; 
                            Width: OleVariant; Height: OleVariant; LaunchPropertiesWindow: WordBool): Shape; dispid 22;
    function  BuildFreeform(EditingType: MsoEditingType; X1: OleVariant; Y1: OleVariant): FreeformBuilder; dispid 23;
    function  Paste: ShapeRange; dispid 24;
    function  Range(Index: OleVariant): ShapeRange; dispid 25;
    procedure SelectAll; dispid 26;
    function  AddGroupWizard(Wizard: PbWizardGroup; Left: OleVariant; Top: OleVariant; 
                             Width: OleVariant; Height: OleVariant; Design: Integer): Shape; dispid 27;
    function  FindShapeByWizardTag(WizardTag: PbWizardTag; Instance: Integer): ShapeRange; dispid 28;
    function  AddWebNavigationBar(const Name: WideString; Left: OleVariant; Top: OleVariant; 
                                  Width: OleVariant): Shape; dispid 30;
    function  AddCatalogMergeArea: Shape; dispid 40;
    function  AddEmptyPictureFrame(Left: OleVariant; Top: OleVariant; Width: OleVariant; 
                                   Height: OleVariant): Shape; dispid 45;
  end;

// *********************************************************************//
// Interface: FreeformBuilder
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021266-0000-0000-C000-000000000046}
// *********************************************************************//
  FreeformBuilder = interface(IDispatch)
    ['{00021266-0000-0000-C000-000000000046}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure AddNodes(SegmentType: MsoSegmentType; EditingType: MsoEditingType; X1: OleVariant; 
                       Y1: OleVariant; X2: OleVariant; Y2: OleVariant; X3: OleVariant; 
                       Y3: OleVariant); safecall;
    function  ConvertToShape: Shape; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  FreeformBuilderDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021266-0000-0000-C000-000000000046}
// *********************************************************************//
  FreeformBuilderDisp = dispinterface
    ['{00021266-0000-0000-C000-000000000046}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure AddNodes(SegmentType: MsoSegmentType; EditingType: MsoEditingType; X1: OleVariant; 
                       Y1: OleVariant; X2: OleVariant; Y2: OleVariant; X3: OleVariant; 
                       Y3: OleVariant); dispid 10;
    function  ConvertToShape: Shape; dispid 11;
  end;

// *********************************************************************//
// Interface: RulerGuides
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8343FF5B-B266-11D3-906D-00C04F799E3F}
// *********************************************************************//
  RulerGuides = interface(IDispatch)
    ['{8343FF5B-B266-11D3-906D-00C04F799E3F}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(Item: Integer): RulerGuide; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    procedure Add(Position: OleVariant; Type_: PbRulerGuideType); safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[Item: Integer]: RulerGuide read Get_Item; default;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  RulerGuidesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8343FF5B-B266-11D3-906D-00C04F799E3F}
// *********************************************************************//
  RulerGuidesDisp = dispinterface
    ['{8343FF5B-B266-11D3-906D-00C04F799E3F}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[Item: Integer]: RulerGuide readonly dispid 0; default;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    procedure Add(Position: OleVariant; Type_: PbRulerGuideType); dispid 4;
  end;

// *********************************************************************//
// Interface: RulerGuide
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8343FF5A-B266-11D3-906D-00C04F799E3F}
// *********************************************************************//
  RulerGuide = interface(IDispatch)
    ['{8343FF5A-B266-11D3-906D-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Type_: PbRulerGuideType; safecall;
    procedure Set_Type_(RetVal: PbRulerGuideType); safecall;
    function  Get_Position: OleVariant; safecall;
    procedure Set_Position(RetVal: OleVariant); safecall;
    procedure Delete; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Type_: PbRulerGuideType read Get_Type_ write Set_Type_;
    property Position: OleVariant read Get_Position write Set_Position;
  end;

// *********************************************************************//
// DispIntf:  RulerGuideDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8343FF5A-B266-11D3-906D-00C04F799E3F}
// *********************************************************************//
  RulerGuideDisp = dispinterface
    ['{8343FF5A-B266-11D3-906D-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Type_: PbRulerGuideType dispid 3;
    property Position: OleVariant dispid 4;
    procedure Delete; dispid 5;
  end;

// *********************************************************************//
// Interface: ReaderSpread
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8E884314-7A00-48E8-8E4E-BE709AA88045}
// *********************************************************************//
  ReaderSpread = interface(IDispatch)
    ['{8E884314-7A00-48E8-8E4E-BE709AA88045}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Left: Single; safecall;
    function  Get_Top: Single; safecall;
    function  Get_Pages(Index: Integer): Page; safecall;
    function  Get_PageCount: Integer; safecall;
    function  Get_Width: Single; safecall;
    function  Get_Height: Single; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Left: Single read Get_Left;
    property Top: Single read Get_Top;
    property Pages[Index: Integer]: Page read Get_Pages;
    property PageCount: Integer read Get_PageCount;
    property Width: Single read Get_Width;
    property Height: Single read Get_Height;
  end;

// *********************************************************************//
// DispIntf:  ReaderSpreadDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {8E884314-7A00-48E8-8E4E-BE709AA88045}
// *********************************************************************//
  ReaderSpreadDisp = dispinterface
    ['{8E884314-7A00-48E8-8E4E-BE709AA88045}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Left: Single readonly dispid 3;
    property Top: Single readonly dispid 4;
    property Pages[Index: Integer]: Page readonly dispid 5;
    property PageCount: Integer readonly dispid 6;
    property Width: Single readonly dispid 7;
    property Height: Single readonly dispid 8;
  end;

// *********************************************************************//
// Interface: HeaderFooter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {36CB1396-5D9C-4407-AF92-90EF8A8D0C48}
// *********************************************************************//
  HeaderFooter = interface(IDispatch)
    ['{36CB1396-5D9C-4407-AF92-90EF8A8D0C48}']
    function  Get_Parent: IDispatch; safecall;
    function  Get_Application: Application; safecall;
    procedure Delete; safecall;
    function  Get_TextRange: TextRange; safecall;
    function  Get_IsHeader: WordBool; safecall;
    property Parent: IDispatch read Get_Parent;
    property Application: Application read Get_Application;
    property TextRange: TextRange read Get_TextRange;
    property IsHeader: WordBool read Get_IsHeader;
  end;

// *********************************************************************//
// DispIntf:  HeaderFooterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {36CB1396-5D9C-4407-AF92-90EF8A8D0C48}
// *********************************************************************//
  HeaderFooterDisp = dispinterface
    ['{36CB1396-5D9C-4407-AF92-90EF8A8D0C48}']
    property Parent: IDispatch readonly dispid 1;
    property Application: Application readonly dispid 2;
    procedure Delete; dispid 3;
    property TextRange: TextRange readonly dispid 4;
    property IsHeader: WordBool readonly dispid 5;
  end;

// *********************************************************************//
// Interface: PageBackground
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {AC9B8364-6173-4E98-9F25-E9905E85A3F5}
// *********************************************************************//
  PageBackground = interface(IDispatch)
    ['{AC9B8364-6173-4E98-9F25-E9905E85A3F5}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Fill: FillFormat; safecall;
    function  Get_Exists: WordBool; safecall;
    procedure Create; safecall;
    procedure Delete; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Fill: FillFormat read Get_Fill;
    property Exists: WordBool read Get_Exists;
  end;

// *********************************************************************//
// DispIntf:  PageBackgroundDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {AC9B8364-6173-4E98-9F25-E9905E85A3F5}
// *********************************************************************//
  PageBackgroundDisp = dispinterface
    ['{AC9B8364-6173-4E98-9F25-E9905E85A3F5}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Fill: FillFormat readonly dispid 3;
    property Exists: WordBool readonly dispid 4;
    procedure Create; dispid 5;
    procedure Delete; dispid 6;
  end;

// *********************************************************************//
// Interface: WebPageOptions
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3F546B70-3B09-4692-8B93-E9C7ABCCCE89}
// *********************************************************************//
  WebPageOptions = interface(IDispatch)
    ['{3F546B70-3B09-4692-8B93-E9C7ABCCCE89}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Description: WideString; safecall;
    procedure Set_Description(const RetVal: WideString); safecall;
    function  Get_Keywords: WideString; safecall;
    procedure Set_Keywords(const RetVal: WideString); safecall;
    function  Get_IncludePageOnNewWebNavigationBars: WordBool; safecall;
    procedure Set_IncludePageOnNewWebNavigationBars(RetVal: WordBool); safecall;
    function  Get_BackgroundSound: WideString; safecall;
    procedure Set_BackgroundSound(const RetVal: WideString); safecall;
    function  Get_BackgroundSoundLoopForever: WordBool; safecall;
    function  Get_BackgroundSoundLoopCount: Integer; safecall;
    procedure SetBackgroundSoundRepeat(RepeatForever: WordBool; RepeatTimes: Integer); safecall;
    function  Get_PublishFileName: WideString; safecall;
    procedure Set_PublishFileName(const RetVal: WideString); safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Description: WideString read Get_Description write Set_Description;
    property Keywords: WideString read Get_Keywords write Set_Keywords;
    property IncludePageOnNewWebNavigationBars: WordBool read Get_IncludePageOnNewWebNavigationBars write Set_IncludePageOnNewWebNavigationBars;
    property BackgroundSound: WideString read Get_BackgroundSound write Set_BackgroundSound;
    property BackgroundSoundLoopForever: WordBool read Get_BackgroundSoundLoopForever;
    property BackgroundSoundLoopCount: Integer read Get_BackgroundSoundLoopCount;
    property PublishFileName: WideString read Get_PublishFileName write Set_PublishFileName;
  end;

// *********************************************************************//
// DispIntf:  WebPageOptionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {3F546B70-3B09-4692-8B93-E9C7ABCCCE89}
// *********************************************************************//
  WebPageOptionsDisp = dispinterface
    ['{3F546B70-3B09-4692-8B93-E9C7ABCCCE89}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Description: WideString dispid 3;
    property Keywords: WideString dispid 4;
    property IncludePageOnNewWebNavigationBars: WordBool dispid 5;
    property BackgroundSound: WideString dispid 6;
    property BackgroundSoundLoopForever: WordBool readonly dispid 7;
    property BackgroundSoundLoopCount: Integer readonly dispid 8;
    procedure SetBackgroundSoundRepeat(RepeatForever: WordBool; RepeatTimes: Integer); dispid 9;
    property PublishFileName: WideString dispid 10;
  end;

// *********************************************************************//
// Interface: LayoutGuides
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {34985E9C-CE08-11D3-9079-00C04F799E3F}
// *********************************************************************//
  LayoutGuides = interface(IDispatch)
    ['{34985E9C-CE08-11D3-9079-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Columns: Integer; safecall;
    procedure Set_Columns(RetValue: Integer); safecall;
    function  Get_MarginBottom: OleVariant; safecall;
    procedure Set_MarginBottom(RetValue: OleVariant); safecall;
    function  Get_MarginLeft: OleVariant; safecall;
    procedure Set_MarginLeft(RetValue: OleVariant); safecall;
    function  Get_MarginRight: OleVariant; safecall;
    procedure Set_MarginRight(RetValue: OleVariant); safecall;
    function  Get_MarginTop: OleVariant; safecall;
    procedure Set_MarginTop(RetValue: OleVariant); safecall;
    function  Get_MirrorGuides: WordBool; safecall;
    procedure Set_MirrorGuides(RetValue: WordBool); safecall;
    function  Get_Rows: Integer; safecall;
    procedure Set_Rows(RetValue: Integer); safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ColumnGutterWidth: Single; safecall;
    procedure Set_ColumnGutterWidth(RetValue: OleVariant); safecall;
    function  Get_RowGutterWidth: Single; safecall;
    procedure Set_RowGutterWidth(RetValue: OleVariant); safecall;
    function  Get_GutterCenterlines: WordBool; safecall;
    procedure Set_GutterCenterlines(RetValue: WordBool); safecall;
    function  Get_HorizontalBaseLineOffset: Single; safecall;
    procedure Set_HorizontalBaseLineOffset(RetValue: OleVariant); safecall;
    function  Get_HorizontalBaseLineSpacing: Single; safecall;
    procedure Set_HorizontalBaseLineSpacing(RetValue: OleVariant); safecall;
    function  Get_VerticalBaseLineOffset: Single; safecall;
    procedure Set_VerticalBaseLineOffset(RetValue: OleVariant); safecall;
    function  Get_VerticalBaseLineSpacing: Single; safecall;
    procedure Set_VerticalBaseLineSpacing(RetValue: OleVariant); safecall;
    property Application: Application read Get_Application;
    property Columns: Integer read Get_Columns write Set_Columns;
    property MarginBottom: OleVariant read Get_MarginBottom write Set_MarginBottom;
    property MarginLeft: OleVariant read Get_MarginLeft write Set_MarginLeft;
    property MarginRight: OleVariant read Get_MarginRight write Set_MarginRight;
    property MarginTop: OleVariant read Get_MarginTop write Set_MarginTop;
    property MirrorGuides: WordBool read Get_MirrorGuides write Set_MirrorGuides;
    property Rows: Integer read Get_Rows write Set_Rows;
    property Parent: IDispatch read Get_Parent;
    property GutterCenterlines: WordBool read Get_GutterCenterlines write Set_GutterCenterlines;
  end;

// *********************************************************************//
// DispIntf:  LayoutGuidesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {34985E9C-CE08-11D3-9079-00C04F799E3F}
// *********************************************************************//
  LayoutGuidesDisp = dispinterface
    ['{34985E9C-CE08-11D3-9079-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Columns: Integer dispid 2;
    property MarginBottom: OleVariant dispid 3;
    property MarginLeft: OleVariant dispid 4;
    property MarginRight: OleVariant dispid 5;
    property MarginTop: OleVariant dispid 6;
    property MirrorGuides: WordBool dispid 7;
    property Rows: Integer dispid 8;
    property Parent: IDispatch readonly dispid 9;
    function  ColumnGutterWidth: Single; dispid 10;
    function  RowGutterWidth: Single; dispid 11;
    property GutterCenterlines: WordBool dispid 12;
    function  HorizontalBaseLineOffset: Single; dispid 13;
    function  HorizontalBaseLineSpacing: Single; dispid 14;
    function  VerticalBaseLineOffset: Single; dispid 15;
    function  VerticalBaseLineSpacing: Single; dispid 16;
  end;

// *********************************************************************//
// Interface: MailMerge
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4FA84469-DD6A-42D4-979F-ED62ABBDF44D}
// *********************************************************************//
  MailMerge = interface(IDispatch)
    ['{4FA84469-DD6A-42D4-979F-ED62ABBDF44D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_DataSource: MailMergeDataSource; safecall;
    function  Get_Destination: Integer; safecall;
    function  Get_DocumentUpdating: WordBool; safecall;
    procedure Set_DocumentUpdating(RetValue: WordBool); safecall;
    function  Get_ShowSendToCustom: WideString; safecall;
    procedure Set_ShowSendToCustom(const RetValue: WideString); safecall;
    function  Get_SuppressBlankLines: WordBool; safecall;
    procedure Set_SuppressBlankLines(RetValue: WordBool); safecall;
    function  Get_ViewMailMergeFieldCodes: WordBool; safecall;
    procedure Set_ViewMailMergeFieldCodes(RetValue: WordBool); safecall;
    function  Get_WizardState: SYSINT; safecall;
    procedure Set_WizardState(RetValue: SYSINT); safecall;
    procedure Execute10(Pause: WordBool); safecall;
    procedure OpenDataSource(const bstrDataSource: WideString; const bstrConnect: WideString; 
                             const bstrTable: WideString; fOpenExclusive: Integer; 
                             fNeverPrompt: Integer); safecall;
    procedure ShowWizard(ShowDocumentStep: WordBool; ShowTemplateStep: WordBool; 
                         ShowDataStep: WordBool; ShowWriteStep: WordBool; 
                         ShowPreviewStep: WordBool; ShowMergeStep: WordBool); safecall;
    function  Execute(Pause: WordBool; Destination: PbMailMergeDestination; 
                      const Filename: WideString): Document; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property DataSource: MailMergeDataSource read Get_DataSource;
    property Destination: Integer read Get_Destination;
    property DocumentUpdating: WordBool read Get_DocumentUpdating write Set_DocumentUpdating;
    property ShowSendToCustom: WideString read Get_ShowSendToCustom write Set_ShowSendToCustom;
    property SuppressBlankLines: WordBool read Get_SuppressBlankLines write Set_SuppressBlankLines;
    property ViewMailMergeFieldCodes: WordBool read Get_ViewMailMergeFieldCodes write Set_ViewMailMergeFieldCodes;
    property WizardState: SYSINT read Get_WizardState write Set_WizardState;
  end;

// *********************************************************************//
// DispIntf:  MailMergeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {4FA84469-DD6A-42D4-979F-ED62ABBDF44D}
// *********************************************************************//
  MailMergeDisp = dispinterface
    ['{4FA84469-DD6A-42D4-979F-ED62ABBDF44D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property DataSource: MailMergeDataSource readonly dispid 3;
    property Destination: Integer readonly dispid 4;
    property DocumentUpdating: WordBool dispid 5;
    property ShowSendToCustom: WideString dispid 6;
    property SuppressBlankLines: WordBool dispid 7;
    property ViewMailMergeFieldCodes: WordBool dispid 8;
    property WizardState: SYSINT dispid 9;
    procedure Execute10(Pause: WordBool); dispid 10;
    procedure OpenDataSource(const bstrDataSource: WideString; const bstrConnect: WideString; 
                             const bstrTable: WideString; fOpenExclusive: Integer; 
                             fNeverPrompt: Integer); dispid 11;
    procedure ShowWizard(ShowDocumentStep: WordBool; ShowTemplateStep: WordBool; 
                         ShowDataStep: WordBool; ShowWriteStep: WordBool; 
                         ShowPreviewStep: WordBool; ShowMergeStep: WordBool); dispid 13;
    function  Execute(Pause: WordBool; Destination: PbMailMergeDestination; 
                      const Filename: WideString): Document; dispid 14;
  end;

// *********************************************************************//
// Interface: MailMergeDataSource
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1A0CD25D-4080-4A83-9DD9-02075743E446}
// *********************************************************************//
  MailMergeDataSource = interface(IDispatch)
    ['{1A0CD25D-4080-4A83-9DD9-02075743E446}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_ActiveRecord: Integer; safecall;
    procedure Set_ActiveRecord(RetValue: Integer); safecall;
    function  Get_ConnectString: WideString; safecall;
    function  Get_DataFields: MailMergeDataFields; safecall;
    function  Get_Filters: MailMergeFilters; safecall;
    function  Get_FirstRecord: Integer; safecall;
    procedure Set_FirstRecord(RetValue: Integer); safecall;
    function  Get_Included: WordBool; safecall;
    procedure Set_Included(RetValue: WordBool); safecall;
    function  Get_InvalidAddress: WordBool; safecall;
    procedure Set_InvalidAddress(RetValue: WordBool); safecall;
    function  Get_InvalidComments: WideString; safecall;
    procedure Set_InvalidComments(const RetValue: WideString); safecall;
    function  Get_LastRecord: Integer; safecall;
    procedure Set_LastRecord(RetValue: Integer); safecall;
    function  Get_MappedDataFields: MailMergeMappedDataFields; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_RecordCount: Integer; safecall;
    function  Get_Type_: Integer; safecall;
    function  FindRecord(const FindText: WideString; const Field: WideString): WordBool; safecall;
    procedure SetAllIncludedFlags(Included: WordBool); safecall;
    procedure SetAllErrorFlags(Invalid: WordBool; const InvalidComment: WideString); safecall;
    procedure SetSortOrder(const SortField1: WideString; SortAscending1: WordBool; 
                           const SortField2: WideString; SortAscending2: WordBool; 
                           const SortField3: WideString; SortAscending3: WordBool); safecall;
    procedure OpenRecipientsDialog; safecall;
    function  Get_TableName: WideString; safecall;
    procedure ApplyFilter; safecall;
    procedure Close; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ActiveRecord: Integer read Get_ActiveRecord write Set_ActiveRecord;
    property ConnectString: WideString read Get_ConnectString;
    property DataFields: MailMergeDataFields read Get_DataFields;
    property Filters: MailMergeFilters read Get_Filters;
    property FirstRecord: Integer read Get_FirstRecord write Set_FirstRecord;
    property Included: WordBool read Get_Included write Set_Included;
    property InvalidAddress: WordBool read Get_InvalidAddress write Set_InvalidAddress;
    property InvalidComments: WideString read Get_InvalidComments write Set_InvalidComments;
    property LastRecord: Integer read Get_LastRecord write Set_LastRecord;
    property MappedDataFields: MailMergeMappedDataFields read Get_MappedDataFields;
    property Name: WideString read Get_Name;
    property RecordCount: Integer read Get_RecordCount;
    property Type_: Integer read Get_Type_;
    property TableName: WideString read Get_TableName;
  end;

// *********************************************************************//
// DispIntf:  MailMergeDataSourceDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1A0CD25D-4080-4A83-9DD9-02075743E446}
// *********************************************************************//
  MailMergeDataSourceDisp = dispinterface
    ['{1A0CD25D-4080-4A83-9DD9-02075743E446}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property ActiveRecord: Integer dispid 3;
    property ConnectString: WideString readonly dispid 4;
    property DataFields: MailMergeDataFields readonly dispid 5;
    property Filters: MailMergeFilters readonly dispid 7;
    property FirstRecord: Integer dispid 8;
    property Included: WordBool dispid 9;
    property InvalidAddress: WordBool dispid 10;
    property InvalidComments: WideString dispid 11;
    property LastRecord: Integer dispid 12;
    property MappedDataFields: MailMergeMappedDataFields readonly dispid 13;
    property Name: WideString readonly dispid 14;
    property RecordCount: Integer readonly dispid 15;
    property Type_: Integer readonly dispid 17;
    function  FindRecord(const FindText: WideString; const Field: WideString): WordBool; dispid 18;
    procedure SetAllIncludedFlags(Included: WordBool); dispid 19;
    procedure SetAllErrorFlags(Invalid: WordBool; const InvalidComment: WideString); dispid 20;
    procedure SetSortOrder(const SortField1: WideString; SortAscending1: WordBool; 
                           const SortField2: WideString; SortAscending2: WordBool; 
                           const SortField3: WideString; SortAscending3: WordBool); dispid 21;
    procedure OpenRecipientsDialog; dispid 22;
    property TableName: WideString readonly dispid 23;
    procedure ApplyFilter; dispid 24;
    procedure Close; dispid 25;
  end;

// *********************************************************************//
// Interface: MailMergeDataFields
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9DF97ACB-FE7B-47E9-A644-62F8F663C5D4}
// *********************************************************************//
  MailMergeDataFields = interface(_IMsoDispObj)
    ['{9DF97ACB-FE7B-47E9-A644-62F8F663C5D4}']
    function  Get_Count: Integer; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Item(varIndex: OleVariant): MailMergeDataField; safecall;
    property Count: Integer read Get_Count;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  MailMergeDataFieldsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9DF97ACB-FE7B-47E9-A644-62F8F663C5D4}
// *********************************************************************//
  MailMergeDataFieldsDisp = dispinterface
    ['{9DF97ACB-FE7B-47E9-A644-62F8F663C5D4}']
    property Count: Integer readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    function  Item(varIndex: OleVariant): MailMergeDataField; dispid 1610809346;
    property Application: IDispatch readonly dispid 1610743808;
    property Creator: Integer readonly dispid 1610743809;
  end;

// *********************************************************************//
// Interface: MailMergeDataField
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0BCCE76B-8012-43CA-A80D-04784985D7F4}
// *********************************************************************//
  MailMergeDataField = interface(_IMsoDispObj)
    ['{0BCCE76B-8012-43CA-A80D-04784985D7F4}']
    function  Get_Index: Integer; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Value: WideString; safecall;
    function  Get_FieldType: PbMailMergeDataFieldType; safecall;
    procedure Set_FieldType(RetVal: PbMailMergeDataFieldType); safecall;
    function  Insert(const Range: TextRange): Shape; safecall;
    property Index: Integer read Get_Index;
    property Name: WideString read Get_Name;
    property Parent: IDispatch read Get_Parent;
    property Value: WideString read Get_Value;
    property FieldType: PbMailMergeDataFieldType read Get_FieldType write Set_FieldType;
  end;

// *********************************************************************//
// DispIntf:  MailMergeDataFieldDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {0BCCE76B-8012-43CA-A80D-04784985D7F4}
// *********************************************************************//
  MailMergeDataFieldDisp = dispinterface
    ['{0BCCE76B-8012-43CA-A80D-04784985D7F4}']
    property Index: Integer readonly dispid 1;
    property Name: WideString readonly dispid 2;
    property Parent: IDispatch readonly dispid 3;
    property Value: WideString readonly dispid 4;
    property FieldType: PbMailMergeDataFieldType dispid 20;
    function  Insert(const Range: TextRange): Shape; dispid 21;
    property Application: IDispatch readonly dispid 1610743808;
    property Creator: Integer readonly dispid 1610743809;
  end;

// *********************************************************************//
// Interface: MailMergeFilters
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {000C1534-0000-0000-C000-000000000046}
// *********************************************************************//
  MailMergeFilters = interface(_IMsoDispObj)
    ['{000C1534-0000-0000-C000-000000000046}']
    function  Get_Count: Integer; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Item(Index: Integer): IDispatch; safecall;
    procedure Add(const Column: WideString; Comparison: TOleEnum;
                  Conjunction: TOleEnum; const bstrCompareTo: WideString;
                  DeferUpdate: WordBool); safecall;
    procedure Delete(Index: Integer; DeferUpdate: WordBool); safecall;
    property Count: Integer read Get_Count;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  MailMergeFiltersDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {000C1534-0000-0000-C000-000000000046}
// *********************************************************************//
  MailMergeFiltersDisp = dispinterface
    ['{000C1534-0000-0000-C000-000000000046}']
    property Count: Integer readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    function  Item(Index: Integer): IDispatch; dispid 1610809346;
    procedure Add(const Column: WideString; Comparison: TOleEnum;
                  Conjunction: TOleEnum; const bstrCompareTo: WideString;
                  DeferUpdate: WordBool); dispid 1610809347;
    procedure Delete(Index: Integer; DeferUpdate: WordBool); dispid 1610809348;
    property Application: IDispatch readonly dispid 1610743808;
    property Creator: Integer readonly dispid 1610743809;
  end;

// *********************************************************************//
// Interface: MailMergeMappedDataFields
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F4B0606E-B5D2-4A11-B29F-22D47375651D}
// *********************************************************************//
  MailMergeMappedDataFields = interface(IDispatch)
    ['{F4B0606E-B5D2-4A11-B29F-22D47375651D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  Item(Index: OleVariant): MailMergeMappedDataField; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  MailMergeMappedDataFieldsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F4B0606E-B5D2-4A11-B29F-22D47375651D}
// *********************************************************************//
  MailMergeMappedDataFieldsDisp = dispinterface
    ['{F4B0606E-B5D2-4A11-B29F-22D47375651D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    function  Item(Index: OleVariant): MailMergeMappedDataField; dispid 0;
  end;

// *********************************************************************//
// Interface: MailMergeMappedDataField
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1D236C54-12E2-44FA-8679-223E3F747D8B}
// *********************************************************************//
  MailMergeMappedDataField = interface(IDispatch)
    ['{1D236C54-12E2-44FA-8679-223E3F747D8B}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_DataFieldName: WideString; safecall;
    function  Get_Index: Integer; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Value: WideString; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property DataFieldName: WideString read Get_DataFieldName;
    property Index: Integer read Get_Index;
    property Name: WideString read Get_Name;
    property Value: WideString read Get_Value;
  end;

// *********************************************************************//
// DispIntf:  MailMergeMappedDataFieldDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {1D236C54-12E2-44FA-8679-223E3F747D8B}
// *********************************************************************//
  MailMergeMappedDataFieldDisp = dispinterface
    ['{1D236C54-12E2-44FA-8679-223E3F747D8B}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property DataFieldName: WideString readonly dispid 3;
    property Index: Integer readonly dispid 4;
    property Name: WideString readonly dispid 5;
    property Value: WideString readonly dispid 6;
  end;

// *********************************************************************//
// Interface: MasterPages
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D3554585-5123-11D3-B65E-00C04F8EF32D}
// *********************************************************************//
  MasterPages = interface(IDispatch)
    ['{D3554585-5123-11D3-B65E-00C04F8EF32D}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(Item: Integer): Page; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  Add(IsTwoPageMaster: WordBool; const Abbreviation: WideString; 
                  const Description: WideString): Page; safecall;
    function  FindByPageID(PageID: Integer): Page; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[Item: Integer]: Page read Get_Item; default;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  MasterPagesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {D3554585-5123-11D3-B65E-00C04F8EF32D}
// *********************************************************************//
  MasterPagesDisp = dispinterface
    ['{D3554585-5123-11D3-B65E-00C04F8EF32D}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[Item: Integer]: Page readonly dispid 0; default;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    function  Add(IsTwoPageMaster: WordBool; const Abbreviation: WideString; 
                  const Description: WideString): Page; dispid 4;
    function  FindByPageID(PageID: Integer): Page; dispid 6;
  end;

// *********************************************************************//
// Interface: Pages
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021248-0000-0000-C000-000000000046}
// *********************************************************************//
  Pages = interface(IDispatch)
    ['{00021248-0000-0000-C000-000000000046}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Item(Item: Integer): Page; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  Add10(Count: Integer; After: Integer; DuplicateObjectsOnPage: Integer): Page; safecall;
    procedure AddWizardPage10(After: Integer; PageType: PbWizardPageType); safecall;
    function  FindByPageID(PageID: Integer): Page; safecall;
    function  Add(Count: Integer; After: Integer; DuplicateObjectsOnPage: Integer; 
                  AddHyperlinkToWebNavBar: WordBool): Page; safecall;
    procedure AddWizardPage(After: Integer; PageType: PbWizardPageType; 
                            AddHyperlinkToWebNavBar: WordBool); safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[Item: Integer]: Page read Get_Item; default;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  PagesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021248-0000-0000-C000-000000000046}
// *********************************************************************//
  PagesDisp = dispinterface
    ['{00021248-0000-0000-C000-000000000046}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[Item: Integer]: Page readonly dispid 0; default;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    function  Add10(Count: Integer; After: Integer; DuplicateObjectsOnPage: Integer): Page; dispid 5;
    procedure AddWizardPage10(After: Integer; PageType: PbWizardPageType); dispid 6;
    function  FindByPageID(PageID: Integer): Page; dispid 7;
    function  Add(Count: Integer; After: Integer; DuplicateObjectsOnPage: Integer; 
                  AddHyperlinkToWebNavBar: WordBool): Page; dispid 8;
    procedure AddWizardPage(After: Integer; PageType: PbWizardPageType; 
                            AddHyperlinkToWebNavBar: WordBool); dispid 9;
  end;

// *********************************************************************//
// Interface: PageSetup
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7BE67D19-3411-4609-B5B0-737515B866DA}
// *********************************************************************//
  PageSetup = interface(IDispatch)
    ['{7BE67D19-3411-4609-B5B0-737515B866DA}']
    function  Get_Application: Application; safecall;
    function  Get_HorizontalGap: OleVariant; safecall;
    procedure Set_HorizontalGap(RetValue: OleVariant); safecall;
    function  Get_LeftMargin: OleVariant; safecall;
    procedure Set_LeftMargin(RetValue: OleVariant); safecall;
    function  Get_MultiplePagesPerSheet: WordBool; safecall;
    procedure Set_MultiplePagesPerSheet(RetValue: WordBool); safecall;
    function  Get_PageHeight: OleVariant; safecall;
    procedure Set_PageHeight(RetValue: OleVariant); safecall;
    function  Get_PageWidth: OleVariant; safecall;
    procedure Set_PageWidth(RetValue: OleVariant); safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_TopMargin: OleVariant; safecall;
    procedure Set_TopMargin(RetValue: OleVariant); safecall;
    function  Get_VerticalGap: OleVariant; safecall;
    procedure Set_VerticalGap(RetValue: OleVariant); safecall;
    function  Get_PublicationLayout: PbPublicationLayout; safecall;
    procedure Set_PublicationLayout(pLayout: PbPublicationLayout); safecall;
    function  Get_Label_: Label_; safecall;
    procedure Set_Label_(const RetValue: Label_); safecall;
    function  Get_AvailableLabels: Labels; safecall;
    function  Get_Orientation: PbOrientationType; safecall;
    procedure Set_Orientation(RetValue: PbOrientationType); safecall;
    property Application: Application read Get_Application;
    property HorizontalGap: OleVariant read Get_HorizontalGap write Set_HorizontalGap;
    property LeftMargin: OleVariant read Get_LeftMargin write Set_LeftMargin;
    property MultiplePagesPerSheet: WordBool read Get_MultiplePagesPerSheet write Set_MultiplePagesPerSheet;
    property PageHeight: OleVariant read Get_PageHeight write Set_PageHeight;
    property PageWidth: OleVariant read Get_PageWidth write Set_PageWidth;
    property Parent: IDispatch read Get_Parent;
    property TopMargin: OleVariant read Get_TopMargin write Set_TopMargin;
    property VerticalGap: OleVariant read Get_VerticalGap write Set_VerticalGap;
    property PublicationLayout: PbPublicationLayout read Get_PublicationLayout write Set_PublicationLayout;
    property Label_: Label_ read Get_Label_ write Set_Label_;
    property AvailableLabels: Labels read Get_AvailableLabels;
    property Orientation: PbOrientationType read Get_Orientation write Set_Orientation;
  end;

// *********************************************************************//
// DispIntf:  PageSetupDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {7BE67D19-3411-4609-B5B0-737515B866DA}
// *********************************************************************//
  PageSetupDisp = dispinterface
    ['{7BE67D19-3411-4609-B5B0-737515B866DA}']
    property Application: Application readonly dispid 1;
    property HorizontalGap: OleVariant dispid 2;
    property LeftMargin: OleVariant dispid 3;
    property MultiplePagesPerSheet: WordBool dispid 4;
    property PageHeight: OleVariant dispid 5;
    property PageWidth: OleVariant dispid 6;
    property Parent: IDispatch readonly dispid 13;
    property TopMargin: OleVariant dispid 15;
    property VerticalGap: OleVariant dispid 16;
    property PublicationLayout: PbPublicationLayout dispid 17;
    property Label_: Label_ dispid 18;
    property AvailableLabels: Labels readonly dispid 19;
    property Orientation: PbOrientationType dispid 20;
  end;

// *********************************************************************//
// Interface: Label_
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {64480E73-E204-44D6-A460-D3315929C81C}
// *********************************************************************//
  Label_ = interface(IDispatch)
    ['{64480E73-E204-44D6-A460-D3315929C81C}']
    function  Get_Name: WideString; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Width: OleVariant; safecall;
    function  Get_Height: OleVariant; safecall;
    function  Get_LeftMargin: OleVariant; safecall;
    procedure Set_LeftMargin(RetValue: OleVariant); safecall;
    function  Get_TopMargin: OleVariant; safecall;
    procedure Set_TopMargin(RetValue: OleVariant); safecall;
    function  Get_HorizontalGap: OleVariant; safecall;
    procedure Set_HorizontalGap(RetValue: OleVariant); safecall;
    function  Get_VerticalGap: OleVariant; safecall;
    procedure Set_VerticalGap(RetValue: OleVariant); safecall;
    property Name: WideString read Get_Name;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Width: OleVariant read Get_Width;
    property Height: OleVariant read Get_Height;
    property LeftMargin: OleVariant read Get_LeftMargin write Set_LeftMargin;
    property TopMargin: OleVariant read Get_TopMargin write Set_TopMargin;
    property HorizontalGap: OleVariant read Get_HorizontalGap write Set_HorizontalGap;
    property VerticalGap: OleVariant read Get_VerticalGap write Set_VerticalGap;
  end;

// *********************************************************************//
// DispIntf:  Label_Disp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {64480E73-E204-44D6-A460-D3315929C81C}
// *********************************************************************//
  Label_Disp = dispinterface
    ['{64480E73-E204-44D6-A460-D3315929C81C}']
    property Name: WideString readonly dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Width: OleVariant readonly dispid 3;
    property Height: OleVariant readonly dispid 4;
    property LeftMargin: OleVariant dispid 5;
    property TopMargin: OleVariant dispid 6;
    property HorizontalGap: OleVariant dispid 7;
    property VerticalGap: OleVariant dispid 8;
  end;

// *********************************************************************//
// Interface: Labels
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C5C382C6-C556-44B9-8949-4534045B40EA}
// *********************************************************************//
  Labels = interface(IDispatch)
    ['{C5C382C6-C556-44B9-8949-4534045B40EA}']
    function  Get_Item(Index: OleVariant): Label_; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    property Item[Index: OleVariant]: Label_ read Get_Item; default;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  LabelsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {C5C382C6-C556-44B9-8949-4534045B40EA}
// *********************************************************************//
  LabelsDisp = dispinterface
    ['{C5C382C6-C556-44B9-8949-4534045B40EA}']
    property Item[Index: OleVariant]: Label_ readonly dispid 0; default;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: Plates
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DE78CEB8-FEBB-11D3-907D-00C04F799E3F}
// *********************************************************************//
  Plates = interface(IDispatch)
    ['{DE78CEB8-FEBB-11D3-907D-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Count: Integer; safecall;
    function  Get_Item(Index: Integer): Plate; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure Add(const PlateColor: ColorFormat); safecall;
    function  FindPlateByInkName(InkName: PbInkName): Plate; safecall;
    property Application: Application read Get_Application;
    property Count: Integer read Get_Count;
    property Item[Index: Integer]: Plate read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  PlatesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DE78CEB8-FEBB-11D3-907D-00C04F799E3F}
// *********************************************************************//
  PlatesDisp = dispinterface
    ['{DE78CEB8-FEBB-11D3-907D-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Count: Integer readonly dispid 2;
    property Item[Index: Integer]: Plate readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
    property Parent: IDispatch readonly dispid 3;
    procedure Add(const PlateColor: ColorFormat); dispid 4;
    function  FindPlateByInkName(InkName: PbInkName): Plate; dispid 5;
  end;

// *********************************************************************//
// Interface: Plate
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DE78CEB9-FEBB-11D3-907D-00C04F799E3F}
// *********************************************************************//
  Plate = interface(IDispatch)
    ['{DE78CEB9-FEBB-11D3-907D-00C04F799E3F}']
    function  Get_Angle: Integer; safecall;
    procedure Set_Angle(Value: Integer); safecall;
    function  Get_Application: Application; safecall;
    function  Get_Color: ColorFormat; safecall;
    function  Get_Frequency: Integer; safecall;
    procedure Set_Frequency(Value: Integer); safecall;
    function  Get_Index: Integer; safecall;
    function  Get_Luminance: Integer; safecall;
    procedure Set_Luminance(Value: Integer); safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure Delete10; safecall;
    procedure Delete(PlateReplaceWith: OleVariant; ReplaceTint: PbReplaceTint); safecall;
    procedure ConvertToProcess; safecall;
    function  Get_InUse: WordBool; safecall;
    function  Get_InkName: PbInkName; safecall;
    property Angle: Integer read Get_Angle write Set_Angle;
    property Application: Application read Get_Application;
    property Color: ColorFormat read Get_Color;
    property Frequency: Integer read Get_Frequency write Set_Frequency;
    property Index: Integer read Get_Index;
    property Luminance: Integer read Get_Luminance write Set_Luminance;
    property Name: WideString read Get_Name;
    property Parent: IDispatch read Get_Parent;
    property InUse: WordBool read Get_InUse;
    property InkName: PbInkName read Get_InkName;
  end;

// *********************************************************************//
// DispIntf:  PlateDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {DE78CEB9-FEBB-11D3-907D-00C04F799E3F}
// *********************************************************************//
  PlateDisp = dispinterface
    ['{DE78CEB9-FEBB-11D3-907D-00C04F799E3F}']
    property Angle: Integer dispid 1;
    property Application: Application readonly dispid 2;
    property Color: ColorFormat readonly dispid 3;
    property Frequency: Integer dispid 4;
    property Index: Integer readonly dispid 5;
    property Luminance: Integer dispid 6;
    property Name: WideString readonly dispid 7;
    property Parent: IDispatch readonly dispid 8;
    procedure Delete10; dispid 9;
    procedure Delete(PlateReplaceWith: OleVariant; ReplaceTint: PbReplaceTint); dispid 10;
    procedure ConvertToProcess; dispid 11;
    property InUse: WordBool readonly dispid 12;
    property InkName: PbInkName readonly dispid 13;
  end;

// *********************************************************************//
// Interface: ScratchArea
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {34985E9D-CE08-11D3-9079-00C04F799E3F}
// *********************************************************************//
  ScratchArea = interface(IDispatch)
    ['{34985E9D-CE08-11D3-9079-00C04F799E3F}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Shapes: Shapes; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Shapes: Shapes read Get_Shapes;
  end;

// *********************************************************************//
// DispIntf:  ScratchAreaDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {34985E9D-CE08-11D3-9079-00C04F799E3F}
// *********************************************************************//
  ScratchAreaDisp = dispinterface
    ['{34985E9D-CE08-11D3-9079-00C04F799E3F}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Shapes: Shapes readonly dispid 3;
  end;

// *********************************************************************//
// Interface: Stories
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B3-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  Stories = interface(IDispatch)
    ['{37B3B0B3-44B5-11D3-B65B-00C04F8EF32D}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Item(Index: Integer): Story; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  StoriesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B3-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  StoriesDisp = dispinterface
    ['{37B3B0B3-44B5-11D3-B65B-00C04F8EF32D}']
    property _NewEnum: IUnknown readonly dispid -4;
    function  Item(Index: Integer): Story; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
  end;

// *********************************************************************//
// Interface: TextStyles
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B5-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  TextStyles = interface(IDispatch)
    ['{37B3B0B5-44B5-11D3-B65B-00C04F8EF32D}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Item(Index: OleVariant): TextStyle; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  Add(const StyleName: WideString; const BasedOn: WideString; const Font: Font; 
                  const ParagraphFormat: ParagraphFormat): TextStyle; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  TextStylesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B5-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  TextStylesDisp = dispinterface
    ['{37B3B0B5-44B5-11D3-B65B-00C04F8EF32D}']
    property _NewEnum: IUnknown readonly dispid -4;
    function  Item(Index: OleVariant): TextStyle; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    function  Add(const StyleName: WideString; const BasedOn: WideString; const Font: Font; 
                  const ParagraphFormat: ParagraphFormat): TextStyle; dispid 4;
  end;

// *********************************************************************//
// Interface: TextStyle
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B4-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  TextStyle = interface(IDispatch)
    ['{37B3B0B4-44B5-11D3-B65B-00C04F8EF32D}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Description: WideString; safecall;
    function  Get_Font: Font; safecall;
    procedure Set_Font(const RetVal: Font); safecall;
    function  Get_ParagraphFormat: ParagraphFormat; safecall;
    procedure Set_ParagraphFormat(const ppPara: ParagraphFormat); safecall;
    function  Get_Name: WideString; safecall;
    function  Get_BaseStyle: WideString; safecall;
    procedure Set_BaseStyle(const Style: WideString); safecall;
    function  Get_NextParagraphStyle: WideString; safecall;
    procedure Set_NextParagraphStyle(const Style: WideString); safecall;
    procedure Delete; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Description: WideString read Get_Description;
    property Font: Font read Get_Font write Set_Font;
    property ParagraphFormat: ParagraphFormat read Get_ParagraphFormat write Set_ParagraphFormat;
    property Name: WideString read Get_Name;
    property BaseStyle: WideString read Get_BaseStyle write Set_BaseStyle;
    property NextParagraphStyle: WideString read Get_NextParagraphStyle write Set_NextParagraphStyle;
  end;

// *********************************************************************//
// DispIntf:  TextStyleDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {37B3B0B4-44B5-11D3-B65B-00C04F8EF32D}
// *********************************************************************//
  TextStyleDisp = dispinterface
    ['{37B3B0B4-44B5-11D3-B65B-00C04F8EF32D}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Description: WideString readonly dispid 3;
    property Font: Font dispid 4;
    property ParagraphFormat: ParagraphFormat dispid 5;
    property Name: WideString readonly dispid 6;
    property BaseStyle: WideString dispid 7;
    property NextParagraphStyle: WideString dispid 8;
    procedure Delete; dispid 10;
  end;

// *********************************************************************//
// Interface: AdvancedPrintOptions
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BEAB0299-1432-45D0-897F-4B8882BC50F4}
// *********************************************************************//
  AdvancedPrintOptions = interface(IDispatch)
    ['{BEAB0299-1432-45D0-897F-4B8882BC50F4}']
    function  Get_Parent: IDispatch; safecall;
    function  Get_Application: Application; safecall;
    function  Get_VerticalFlip: WordBool; safecall;
    procedure Set_VerticalFlip(RetValue: WordBool); safecall;
    function  Get_HorizontalFlip: WordBool; safecall;
    procedure Set_HorizontalFlip(RetValue: WordBool); safecall;
    function  Get_NegativeImage: WordBool; safecall;
    procedure Set_NegativeImage(RetValue: WordBool); safecall;
    function  Get_UseOnlyPublicationFonts: WordBool; safecall;
    procedure Set_UseOnlyPublicationFonts(RetValue: WordBool); safecall;
    function  Get_PrintCropMarks: WordBool; safecall;
    procedure Set_PrintCropMarks(RetValue: WordBool); safecall;
    function  Get_PrintRegistrationMarks: WordBool; safecall;
    procedure Set_PrintRegistrationMarks(RetValue: WordBool); safecall;
    function  Get_PrintJobInformation: WordBool; safecall;
    procedure Set_PrintJobInformation(RetValue: WordBool); safecall;
    function  Get_PrintDensityBars: WordBool; safecall;
    procedure Set_PrintDensityBars(RetValue: WordBool); safecall;
    function  Get_PrintColorBars: WordBool; safecall;
    procedure Set_PrintColorBars(RetValue: WordBool); safecall;
    function  Get_AllowBleeds: WordBool; safecall;
    procedure Set_AllowBleeds(RetValue: WordBool); safecall;
    function  Get_PrintBleedMarks: WordBool; safecall;
    procedure Set_PrintBleedMarks(RetValue: WordBool); safecall;
    function  Get_PrintBlankPlates: WordBool; safecall;
    procedure Set_PrintBlankPlates(RetValue: WordBool); safecall;
    function  Get_GraphicsResolution: PbPrintGraphics; safecall;
    procedure Set_GraphicsResolution(RetValue: PbPrintGraphics); safecall;
    function  Get_Resolution: WideString; safecall;
    procedure Set_Resolution(const RetValue: WideString); safecall;
    function  Get_PrintableRect: PrintableRect; safecall;
    function  Get_InksToPrint: PbInksToPrint; safecall;
    procedure Set_InksToPrint(RetValue: PbInksToPrint); safecall;
    function  Get_PrintMode: PbPrintMode; safecall;
    procedure Set_PrintMode(RetValue: PbPrintMode); safecall;
    function  Get_PrintablePlates: PrintablePlates; safecall;
    function  Get_IsPostscriptPrinter: WordBool; safecall;
    function  Get_UseCustomHalftone: WordBool; safecall;
    procedure Set_UseCustomHalftone(RetValue: WordBool); safecall;
    function  Get_PrintCMYKByDefault: WordBool; safecall;
    procedure Set_PrintCMYKByDefault(RetValue: WordBool); safecall;
    property Parent: IDispatch read Get_Parent;
    property Application: Application read Get_Application;
    property VerticalFlip: WordBool read Get_VerticalFlip write Set_VerticalFlip;
    property HorizontalFlip: WordBool read Get_HorizontalFlip write Set_HorizontalFlip;
    property NegativeImage: WordBool read Get_NegativeImage write Set_NegativeImage;
    property UseOnlyPublicationFonts: WordBool read Get_UseOnlyPublicationFonts write Set_UseOnlyPublicationFonts;
    property PrintCropMarks: WordBool read Get_PrintCropMarks write Set_PrintCropMarks;
    property PrintRegistrationMarks: WordBool read Get_PrintRegistrationMarks write Set_PrintRegistrationMarks;
    property PrintJobInformation: WordBool read Get_PrintJobInformation write Set_PrintJobInformation;
    property PrintDensityBars: WordBool read Get_PrintDensityBars write Set_PrintDensityBars;
    property PrintColorBars: WordBool read Get_PrintColorBars write Set_PrintColorBars;
    property AllowBleeds: WordBool read Get_AllowBleeds write Set_AllowBleeds;
    property PrintBleedMarks: WordBool read Get_PrintBleedMarks write Set_PrintBleedMarks;
    property PrintBlankPlates: WordBool read Get_PrintBlankPlates write Set_PrintBlankPlates;
    property GraphicsResolution: PbPrintGraphics read Get_GraphicsResolution write Set_GraphicsResolution;
    property Resolution: WideString read Get_Resolution write Set_Resolution;
    property PrintableRect: PrintableRect read Get_PrintableRect;
    property InksToPrint: PbInksToPrint read Get_InksToPrint write Set_InksToPrint;
    property PrintMode: PbPrintMode read Get_PrintMode write Set_PrintMode;
    property PrintablePlates: PrintablePlates read Get_PrintablePlates;
    property IsPostscriptPrinter: WordBool read Get_IsPostscriptPrinter;
    property UseCustomHalftone: WordBool read Get_UseCustomHalftone write Set_UseCustomHalftone;
    property PrintCMYKByDefault: WordBool read Get_PrintCMYKByDefault write Set_PrintCMYKByDefault;
  end;

// *********************************************************************//
// DispIntf:  AdvancedPrintOptionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BEAB0299-1432-45D0-897F-4B8882BC50F4}
// *********************************************************************//
  AdvancedPrintOptionsDisp = dispinterface
    ['{BEAB0299-1432-45D0-897F-4B8882BC50F4}']
    property Parent: IDispatch readonly dispid 1;
    property Application: Application readonly dispid 2;
    property VerticalFlip: WordBool dispid 3;
    property HorizontalFlip: WordBool dispid 4;
    property NegativeImage: WordBool dispid 5;
    property UseOnlyPublicationFonts: WordBool dispid 6;
    property PrintCropMarks: WordBool dispid 7;
    property PrintRegistrationMarks: WordBool dispid 8;
    property PrintJobInformation: WordBool dispid 9;
    property PrintDensityBars: WordBool dispid 10;
    property PrintColorBars: WordBool dispid 11;
    property AllowBleeds: WordBool dispid 12;
    property PrintBleedMarks: WordBool dispid 13;
    property PrintBlankPlates: WordBool dispid 14;
    property GraphicsResolution: PbPrintGraphics dispid 15;
    property Resolution: WideString dispid 16;
    property PrintableRect: PrintableRect readonly dispid 17;
    property InksToPrint: PbInksToPrint dispid 18;
    property PrintMode: PbPrintMode dispid 19;
    property PrintablePlates: PrintablePlates readonly dispid 20;
    property IsPostscriptPrinter: WordBool readonly dispid 21;
    property UseCustomHalftone: WordBool dispid 22;
    property PrintCMYKByDefault: WordBool dispid 23;
  end;

// *********************************************************************//
// Interface: PrintableRect
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F5F4C30B-5D7F-45B1-A2FF-FB7A95A5C1E0}
// *********************************************************************//
  PrintableRect = interface(IDispatch)
    ['{F5F4C30B-5D7F-45B1-A2FF-FB7A95A5C1E0}']
    function  Get_Parent: IDispatch; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Left: Single; safecall;
    function  Get_Top: Single; safecall;
    function  Get_Width: Single; safecall;
    function  Get_Height: Single; safecall;
    property Parent: IDispatch read Get_Parent;
    property Application: Application read Get_Application;
    property Left: Single read Get_Left;
    property Top: Single read Get_Top;
    property Width: Single read Get_Width;
    property Height: Single read Get_Height;
  end;

// *********************************************************************//
// DispIntf:  PrintableRectDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F5F4C30B-5D7F-45B1-A2FF-FB7A95A5C1E0}
// *********************************************************************//
  PrintableRectDisp = dispinterface
    ['{F5F4C30B-5D7F-45B1-A2FF-FB7A95A5C1E0}']
    property Parent: IDispatch readonly dispid 1;
    property Application: Application readonly dispid 2;
    property Left: Single readonly dispid 3;
    property Top: Single readonly dispid 4;
    property Width: Single readonly dispid 5;
    property Height: Single readonly dispid 6;
  end;

// *********************************************************************//
// Interface: PrintablePlates
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BE42D3DC-858F-4894-A8A5-D01EBD67D3ED}
// *********************************************************************//
  PrintablePlates = interface(IDispatch)
    ['{BE42D3DC-858F-4894-A8A5-D01EBD67D3ED}']
    function  Get_Application: Application; safecall;
    function  Get_Count: Integer; safecall;
    function  FindPlateByInkName(InkName: PbInkName): PrintablePlate; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Item(Index: Integer): PrintablePlate; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    property Application: Application read Get_Application;
    property Count: Integer read Get_Count;
    property Parent: IDispatch read Get_Parent;
    property Item[Index: Integer]: PrintablePlate read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  PrintablePlatesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BE42D3DC-858F-4894-A8A5-D01EBD67D3ED}
// *********************************************************************//
  PrintablePlatesDisp = dispinterface
    ['{BE42D3DC-858F-4894-A8A5-D01EBD67D3ED}']
    property Application: Application readonly dispid 1;
    property Count: Integer readonly dispid 2;
    function  FindPlateByInkName(InkName: PbInkName): PrintablePlate; dispid 3;
    property Parent: IDispatch readonly dispid 4;
    property Item[Index: Integer]: PrintablePlate readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: PrintablePlate
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BA68CB7C-BE43-4EED-9DAF-E9F88E1254CA}
// *********************************************************************//
  PrintablePlate = interface(IDispatch)
    ['{BA68CB7C-BE43-4EED-9DAF-E9F88E1254CA}']
    function  Get_Angle: Integer; safecall;
    procedure Set_Angle(Value: Integer); safecall;
    function  Get_Application: Application; safecall;
    function  Get_Frequency: Integer; safecall;
    procedure Set_Frequency(RetValue: Integer); safecall;
    function  Get_Index: Integer; safecall;
    function  Get_InkName: PbInkName; safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_PrintPlate: WordBool; safecall;
    procedure Set_PrintPlate(RetValue: WordBool); safecall;
    property Angle: Integer read Get_Angle write Set_Angle;
    property Application: Application read Get_Application;
    property Frequency: Integer read Get_Frequency write Set_Frequency;
    property Index: Integer read Get_Index;
    property InkName: PbInkName read Get_InkName;
    property Name: WideString read Get_Name;
    property Parent: IDispatch read Get_Parent;
    property PrintPlate: WordBool read Get_PrintPlate write Set_PrintPlate;
  end;

// *********************************************************************//
// DispIntf:  PrintablePlateDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BA68CB7C-BE43-4EED-9DAF-E9F88E1254CA}
// *********************************************************************//
  PrintablePlateDisp = dispinterface
    ['{BA68CB7C-BE43-4EED-9DAF-E9F88E1254CA}']
    property Angle: Integer dispid 1;
    property Application: Application readonly dispid 2;
    property Frequency: Integer dispid 3;
    property Index: Integer readonly dispid 4;
    property InkName: PbInkName readonly dispid 5;
    property Name: WideString readonly dispid 6;
    property Parent: IDispatch readonly dispid 7;
    property PrintPlate: WordBool dispid 8;
  end;

// *********************************************************************//
// Interface: BorderArts
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {761ED420-B146-411C-AA6D-C5DC063C1B1B}
// *********************************************************************//
  BorderArts = interface(IDispatch)
    ['{761ED420-B146-411C-AA6D-C5DC063C1B1B}']
    function  Get__NewEnum: IUnknown; safecall;
    function  Item(Index: OleVariant): BorderArt; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: SYSINT; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  BorderArtsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {761ED420-B146-411C-AA6D-C5DC063C1B1B}
// *********************************************************************//
  BorderArtsDisp = dispinterface
    ['{761ED420-B146-411C-AA6D-C5DC063C1B1B}']
    property _NewEnum: IUnknown readonly dispid -4;
    function  Item(Index: OleVariant): BorderArt; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: SYSINT readonly dispid 3;
  end;

// *********************************************************************//
// Interface: BorderArt
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDFD66B2-9399-4508-92DF-A9067B912ADF}
// *********************************************************************//
  BorderArt = interface(IDispatch)
    ['{BDFD66B2-9399-4508-92DF-A9067B912ADF}']
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Name: WideString; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Name: WideString read Get_Name;
  end;

// *********************************************************************//
// DispIntf:  BorderArtDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BDFD66B2-9399-4508-92DF-A9067B912ADF}
// *********************************************************************//
  BorderArtDisp = dispinterface
    ['{BDFD66B2-9399-4508-92DF-A9067B912ADF}']
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Name: WideString readonly dispid 0;
  end;

// *********************************************************************//
// Interface: Sections
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00ABD2DD-7948-48A8-B7C8-589914EED788}
// *********************************************************************//
  Sections = interface(IDispatch)
    ['{00ABD2DD-7948-48A8-B7C8-589914EED788}']
    function  Get_Application: Application; safecall;
    function  Get_Count: Integer; safecall;
    function  Get_Item(Index: Integer): Section; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Add(StartPageIndex: Integer): Section; safecall;
    property Application: Application read Get_Application;
    property Count: Integer read Get_Count;
    property Item[Index: Integer]: Section read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  SectionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00ABD2DD-7948-48A8-B7C8-589914EED788}
// *********************************************************************//
  SectionsDisp = dispinterface
    ['{00ABD2DD-7948-48A8-B7C8-589914EED788}']
    property Application: Application readonly dispid 1;
    property Count: Integer readonly dispid 2;
    property Item[Index: Integer]: Section readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
    property Parent: IDispatch readonly dispid 4;
    function  Add(StartPageIndex: Integer): Section; dispid 5;
  end;

// *********************************************************************//
// Interface: Section
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F26BFA6F-048F-4E86-87B3-6587DF725CCF}
// *********************************************************************//
  Section = interface(IDispatch)
    ['{F26BFA6F-048F-4E86-87B3-6587DF725CCF}']
    function  Get_Parent: IDispatch; safecall;
    function  Get_Application: Application; safecall;
    function  Get_StartPageIndex: Integer; safecall;
    function  Get_PageNumberStart: Integer; safecall;
    procedure Set_PageNumberStart(StartNumber: Integer); safecall;
    function  Get_PageNumberFormat: PbPageNumberFormat; safecall;
    procedure Set_PageNumberFormat(NumberFormat: PbPageNumberFormat); safecall;
    function  Get_ShowHeaderFooterOnFirstPage: WordBool; safecall;
    procedure Set_ShowHeaderFooterOnFirstPage(Show: WordBool); safecall;
    function  Get_ContinueNumbersFromPreviousSection: WordBool; safecall;
    procedure Set_ContinueNumbersFromPreviousSection(Continue: WordBool); safecall;
    procedure Delete; safecall;
    property Parent: IDispatch read Get_Parent;
    property Application: Application read Get_Application;
    property StartPageIndex: Integer read Get_StartPageIndex;
    property PageNumberStart: Integer read Get_PageNumberStart write Set_PageNumberStart;
    property PageNumberFormat: PbPageNumberFormat read Get_PageNumberFormat write Set_PageNumberFormat;
    property ShowHeaderFooterOnFirstPage: WordBool read Get_ShowHeaderFooterOnFirstPage write Set_ShowHeaderFooterOnFirstPage;
    property ContinueNumbersFromPreviousSection: WordBool read Get_ContinueNumbersFromPreviousSection write Set_ContinueNumbersFromPreviousSection;
  end;

// *********************************************************************//
// DispIntf:  SectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {F26BFA6F-048F-4E86-87B3-6587DF725CCF}
// *********************************************************************//
  SectionDisp = dispinterface
    ['{F26BFA6F-048F-4E86-87B3-6587DF725CCF}']
    property Parent: IDispatch readonly dispid 1;
    property Application: Application readonly dispid 2;
    property StartPageIndex: Integer readonly dispid 3;
    property PageNumberStart: Integer dispid 4;
    property PageNumberFormat: PbPageNumberFormat dispid 5;
    property ShowHeaderFooterOnFirstPage: WordBool dispid 6;
    property ContinueNumbersFromPreviousSection: WordBool dispid 7;
    procedure Delete; dispid 8;
  end;

// *********************************************************************//
// Interface: WebNavigationBarSets
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A05DB779-1FC2-4288-A150-939A955696C4}
// *********************************************************************//
  WebNavigationBarSets = interface(IDispatch)
    ['{A05DB779-1FC2-4288-A150-939A955696C4}']
    function  Item(Index: OleVariant): WebNavigationBarSet; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  AddSet(const Name: WideString; Design: PbWizardNavBarDesign; AutoUpdate: WordBool): WebNavigationBarSet; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  WebNavigationBarSetsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {A05DB779-1FC2-4288-A150-939A955696C4}
// *********************************************************************//
  WebNavigationBarSetsDisp = dispinterface
    ['{A05DB779-1FC2-4288-A150-939A955696C4}']
    function  Item(Index: OleVariant): WebNavigationBarSet; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    function  AddSet(const Name: WideString; Design: PbWizardNavBarDesign; AutoUpdate: WordBool): WebNavigationBarSet; dispid 5;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: WebNavigationBarSet
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {33D49099-5E91-4A79-9281-7F5DDA3A2179}
// *********************************************************************//
  WebNavigationBarSet = interface(IDispatch)
    ['{33D49099-5E91-4A79-9281-7F5DDA3A2179}']
    procedure Set_Name(const RetValue: WideString); safecall;
    function  Get_Name: WideString; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    procedure DeleteSetAndInstances; safecall;
    procedure Set_Design(Design: PbWizardNavBarDesign); safecall;
    function  Get_Design: PbWizardNavBarDesign; safecall;
    procedure Set_ButtonStyle(Style: PbWizardNavBarButtonStyle); safecall;
    function  Get_ButtonStyle: PbWizardNavBarButtonStyle; safecall;
    function  Get_IsHorizontal: WordBool; safecall;
    procedure Set_HorizontalButtonCount(Count: Integer); safecall;
    function  Get_HorizontalButtonCount: Integer; safecall;
    procedure Set_HorizontalAlignment(Align: PbWizardNavBarAlignment); safecall;
    function  Get_HorizontalAlignment: PbWizardNavBarAlignment; safecall;
    procedure Set_AutoUpdate(Auto: WordBool); safecall;
    function  Get_AutoUpdate: WordBool; safecall;
    procedure Set_ShowSelected(Selected: WordBool); safecall;
    function  Get_ShowSelected: WordBool; safecall;
    procedure Set_Links(const Links: WebNavigationBarHyperlinks); safecall;
    function  Get_Links: WebNavigationBarHyperlinks; safecall;
    function  AddToEveryPage(Left: OleVariant; Top: OleVariant; Width: OleVariant): ShapeRange; safecall;
    procedure ChangeOrientation(Orientation: PbNavBarOrientation); safecall;
    property Name: WideString read Get_Name write Set_Name;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Design: PbWizardNavBarDesign read Get_Design write Set_Design;
    property ButtonStyle: PbWizardNavBarButtonStyle read Get_ButtonStyle write Set_ButtonStyle;
    property IsHorizontal: WordBool read Get_IsHorizontal;
    property HorizontalButtonCount: Integer read Get_HorizontalButtonCount write Set_HorizontalButtonCount;
    property HorizontalAlignment: PbWizardNavBarAlignment read Get_HorizontalAlignment write Set_HorizontalAlignment;
    property AutoUpdate: WordBool read Get_AutoUpdate write Set_AutoUpdate;
    property ShowSelected: WordBool read Get_ShowSelected write Set_ShowSelected;
    property Links: WebNavigationBarHyperlinks read Get_Links write Set_Links;
  end;

// *********************************************************************//
// DispIntf:  WebNavigationBarSetDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {33D49099-5E91-4A79-9281-7F5DDA3A2179}
// *********************************************************************//
  WebNavigationBarSetDisp = dispinterface
    ['{33D49099-5E91-4A79-9281-7F5DDA3A2179}']
    property Name: WideString dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    procedure DeleteSetAndInstances; dispid 3;
    property Design: PbWizardNavBarDesign dispid 4;
    property ButtonStyle: PbWizardNavBarButtonStyle dispid 5;
    property IsHorizontal: WordBool readonly dispid 6;
    property HorizontalButtonCount: Integer dispid 7;
    property HorizontalAlignment: PbWizardNavBarAlignment dispid 8;
    property AutoUpdate: WordBool dispid 9;
    property ShowSelected: WordBool dispid 10;
    property Links: WebNavigationBarHyperlinks dispid 11;
    function  AddToEveryPage(Left: OleVariant; Top: OleVariant; Width: OleVariant): ShapeRange; dispid 12;
    procedure ChangeOrientation(Orientation: PbNavBarOrientation); dispid 13;
  end;

// *********************************************************************//
// Interface: WebNavigationBarHyperlinks
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {87712C53-E1A1-4BA2-A129-93E78764308A}
// *********************************************************************//
  WebNavigationBarHyperlinks = interface(IDispatch)
    ['{87712C53-E1A1-4BA2-A129-93E78764308A}']
    function  Item(Index: Integer): Hyperlink; safecall;
    function  Get_Application: Application; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Count: Integer; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Add(const Address: WideString; RelativePage: PbHlinkTargetType; PageID: Integer; 
                  const TextToDisplay: WideString; Index: Integer): Hyperlink; safecall;
    property Application: Application read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Count: Integer read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  WebNavigationBarHyperlinksDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {87712C53-E1A1-4BA2-A129-93E78764308A}
// *********************************************************************//
  WebNavigationBarHyperlinksDisp = dispinterface
    ['{87712C53-E1A1-4BA2-A129-93E78764308A}']
    function  Item(Index: Integer): Hyperlink; dispid 0;
    property Application: Application readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Count: Integer readonly dispid 3;
    property _NewEnum: IUnknown readonly dispid -4;
    function  Add(const Address: WideString; RelativePage: PbHlinkTargetType; PageID: Integer; 
                  const TextToDisplay: WideString; Index: Integer): Hyperlink; dispid 4;
  end;

// *********************************************************************//
// Interface: ColorsInUse
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BA716167-A04A-42F3-BEC4-D433F2A7F4EE}
// *********************************************************************//
  ColorsInUse = interface(IDispatch)
    ['{BA716167-A04A-42F3-BEC4-D433F2A7F4EE}']
    function  Get_Application: Application; safecall;
    function  Get_Count: Integer; safecall;
    function  Get_Item(Index: Integer): ColorFormat; safecall;
    function  Get__NewEnum: IUnknown; safecall;
    function  Get_Parent: IDispatch; safecall;
    property Application: Application read Get_Application;
    property Count: Integer read Get_Count;
    property Item[Index: Integer]: ColorFormat read Get_Item; default;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  ColorsInUseDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {BA716167-A04A-42F3-BEC4-D433F2A7F4EE}
// *********************************************************************//
  ColorsInUseDisp = dispinterface
    ['{BA716167-A04A-42F3-BEC4-D433F2A7F4EE}']
    property Application: Application readonly dispid 1;
    property Count: Integer readonly dispid 2;
    property Item[Index: Integer]: ColorFormat readonly dispid 0; default;
    property _NewEnum: IUnknown readonly dispid -4;
    property Parent: IDispatch readonly dispid 3;
  end;

// *********************************************************************//
// Interface: IDocumentEvents
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021243-0000-0000-C000-000000000046}
// *********************************************************************//
  IDocumentEvents = interface(IDispatch)
    ['{00021243-0000-0000-C000-000000000046}']
    procedure Open; safecall;
    procedure BeforeClose(var Cancel: WordBool); safecall;
    procedure ShapesAdded; safecall;
    procedure WizardAfterChange; safecall;
    procedure ShapesRemoved; safecall;
    procedure Undo; safecall;
    procedure Redo; safecall;
  end;

// *********************************************************************//
// DispIntf:  IDocumentEventsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {00021243-0000-0000-C000-000000000046}
// *********************************************************************//
  IDocumentEventsDisp = dispinterface
    ['{00021243-0000-0000-C000-000000000046}']
    procedure Open; dispid 1;
    procedure BeforeClose(var Cancel: WordBool); dispid 2;
    procedure ShapesAdded; dispid 3;
    procedure WizardAfterChange; dispid 4;
    procedure ShapesRemoved; dispid 5;
    procedure Undo; dispid 6;
    procedure Redo; dispid 7;
  end;

// *********************************************************************//
// Interface: MailMergeFilterCriterion
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {000C1533-0000-0000-C000-000000000046}
// *********************************************************************//
  MailMergeFilterCriterion = interface(_IMsoDispObj)
    ['{000C1533-0000-0000-C000-000000000046}']
    function  Get_Index: Integer; safecall;
    function  Get_Parent: IDispatch; safecall;
    function  Get_Column: WideString; safecall;
    procedure Set_Column(const pbstrCol: WideString); safecall;
    function  Get_Comparison: TOleEnum; safecall;
    procedure Set_Comparison(pComparison: TOleEnum); safecall;
    function  Get_CompareTo: WideString; safecall;
    procedure Set_CompareTo(const pbstrCompareTo: WideString); safecall;
    function  Get_Conjunction: TOleEnum; safecall;
    procedure Set_Conjunction(pConjunction: TOleEnum); safecall;
    property Index: Integer read Get_Index;
    property Parent: IDispatch read Get_Parent;
    property Column: WideString read Get_Column write Set_Column;
    property Comparison: TOleEnum read Get_Comparison write Set_Comparison;
    property CompareTo: WideString read Get_CompareTo write Set_CompareTo;
    property Conjunction: TOleEnum read Get_Conjunction write Set_Conjunction;
  end;

// *********************************************************************//
// DispIntf:  MailMergeFilterCriterionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {000C1533-0000-0000-C000-000000000046}
// *********************************************************************//
  MailMergeFilterCriterionDisp = dispinterface
    ['{000C1533-0000-0000-C000-000000000046}']
    property Index: Integer readonly dispid 1;
    property Parent: IDispatch readonly dispid 2;
    property Column: WideString dispid 3;
    property Comparison: TOleEnum dispid 4;
    property CompareTo: WideString dispid 5;
    property Conjunction: TOleEnum dispid 6;
    property Application: IDispatch readonly dispid 1610743808;
    property Creator: Integer readonly dispid 1610743809;
  end;

// *********************************************************************//
// Interface: ModalBrowser
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {FAC601B6-4A1A-4F69-9ABD-4B4DA640B2DB}
// *********************************************************************//
  ModalBrowser = interface(IDispatch)
    ['{FAC601B6-4A1A-4F69-9ABD-4B4DA640B2DB}']
    procedure TaskCompleted; safecall;
    procedure ResizeTo(lWidth: Integer; lHeight: Integer); safecall;
    procedure MoveTo(lx: Integer; ly: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  ModalBrowserDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {FAC601B6-4A1A-4F69-9ABD-4B4DA640B2DB}
// *********************************************************************//
  ModalBrowserDisp = dispinterface
    ['{FAC601B6-4A1A-4F69-9ABD-4B4DA640B2DB}']
    procedure TaskCompleted; dispid 1;
    procedure ResizeTo(lWidth: Integer; lHeight: Integer); dispid 2;
    procedure MoveTo(lx: Integer; ly: Integer); dispid 3;
  end;

// *********************************************************************//
// DispIntf:  ICagNotifySink
// Flags:     (4112) Hidden Dispatchable
// GUID:      {00021293-0000-0000-C000-000000000046}
// *********************************************************************//
  ICagNotifySink = dispinterface
    ['{00021293-0000-0000-C000-000000000046}']
    function  InsertClip(const pClipMoniker: IUnknown; const pItemMoniker: IUnknown): SCODE; dispid 1;
    function  WindowIsClosing: SCODE; dispid 2;
  end;

// *********************************************************************//
// The Class CoApplication provides a Create and CreateRemote method to          
// create instances of the default interface _Application exposed by              
// the CoClass Application. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoApplication = class
    class function Create: _Application;
    class function CreateRemote(const MachineName: string): _Application;
  end;

  TApplicationWindowActivate = procedure(Sender: TObject; var Wn: OleVariant) of object;
  TApplicationWindowDeactivate = procedure(Sender: TObject; var Wn: OleVariant) of object;
  TApplicationWindowPageChange = procedure(Sender: TObject; var Vw: OleVariant) of object;
  TApplicationNewDocument = procedure(Sender: TObject; var Doc: OleVariant) of object;
  TApplicationDocumentOpen = procedure(Sender: TObject; var Doc: OleVariant) of object;
  TApplicationDocumentBeforeClose = procedure(Sender: TObject; var Doc: OleVariant;
                                                               var Cancel: OleVariant) of object;
  TApplicationMailMergeAfterMerge = procedure(Sender: TObject; var Doc: OleVariant) of object;
  TApplicationMailMergeAfterRecordMerge = procedure(Sender: TObject; var Doc: OleVariant) of object;
  TApplicationMailMergeBeforeMerge = procedure(Sender: TObject; var Doc: OleVariant;
                                                                StartRecord: Integer; 
                                                                EndRecord: Integer; 
                                                                var Cancel: OleVariant) of object;
  TApplicationMailMergeBeforeRecordMerge = procedure(Sender: TObject; var Doc: OleVariant;
                                                                      var Cancel: OleVariant) of object;
  TApplicationMailMergeDataSourceLoad = procedure(Sender: TObject; var Doc: OleVariant) of object;
  TApplicationMailMergeWizardSendToCustom = procedure(Sender: TObject; var Doc: OleVariant) of object;
  TApplicationMailMergeWizardStateChange = procedure(Sender: TObject; var Doc: OleVariant;
                                                                      FromState: SYSINT) of object;
  TApplicationMailMergeDataSourceValidate = procedure(Sender: TObject; var Doc: OleVariant;
                                                                       var Handled: OleVariant) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TApplication
// Help String      : 
// Default Interface: _Application
// Def. Intf. DISP? : No
// Event   Interface: ApplicationEvents
// TypeFlags        : (11) AppObject CanCreate Predeclid
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TApplicationProperties= class;
{$ENDIF}
  TApplication = class(TOleServer)
  private
    FOnWindowActivate: TApplicationWindowActivate;
    FOnWindowDeactivate: TApplicationWindowDeactivate;
    FOnWindowPageChange: TApplicationWindowPageChange;
    FOnQuit: TNotifyEvent;
    FOnNewDocument: TApplicationNewDocument;
    FOnDocumentOpen: TApplicationDocumentOpen;
    FOnDocumentBeforeClose: TApplicationDocumentBeforeClose;
    FOnMailMergeAfterMerge: TApplicationMailMergeAfterMerge;
    FOnMailMergeAfterRecordMerge: TApplicationMailMergeAfterRecordMerge;
    FOnMailMergeBeforeMerge: TApplicationMailMergeBeforeMerge;
    FOnMailMergeBeforeRecordMerge: TApplicationMailMergeBeforeRecordMerge;
    FOnMailMergeDataSourceLoad: TApplicationMailMergeDataSourceLoad;
    FOnMailMergeWizardSendToCustom: TApplicationMailMergeWizardSendToCustom;
    FOnMailMergeWizardStateChange: TApplicationMailMergeWizardStateChange;
    FOnMailMergeDataSourceValidate: TApplicationMailMergeDataSourceValidate;
    FAutoQuit:    Boolean;
    FIntf:        _Application;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TApplicationProperties;
    function      GetServerProperties: TApplicationProperties;
{$ENDIF}
    function      GetDefaultInterface: _Application;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function  Get_ActiveDocument: Document;
    function  Get_ActiveWindow: Window;
    function  Get_Application: Application;
    function  Get_Assistant: Assistant;
    function  Get_Build: Integer;
    function  Get_ColorSchemes: ColorSchemes;
    function  Get_COMAddIns: COMAddIns;
    function  Get_CommandBars: CommandBars;
    function  Get_FileDialog(Type_: TOleEnum): IDispatch;
    function  Get_FileSearch: FileSearch;
    function  Get_Language: Integer;
    function  Get_Name: WideString;
    function  Get_Options: Options;
    function  Get_Parent: IDispatch;
    function  Get_Path: WideString;
    function  Get_PathSeparator: WideString;
    function  Get_ProductCode: WideString;
    function  Get_PrintPreview: WordBool;
    procedure Set_PrintPreview(RetValue: WordBool);
    function  Get_ScreenUpdating: WordBool;
    procedure Set_ScreenUpdating(RetValue: WordBool);
    function  Get_Selection: Selection;
    function  Get_SnapToGuides: WordBool;
    procedure Set_SnapToGuides(RetValue: WordBool);
    function  Get_SnapToObjects: WordBool;
    procedure Set_SnapToObjects(RetValue: WordBool);
    function  Get_TemplateFolderPath: WideString;
    function  Get_Version: WideString;
    function  Get_OfficeDataSourceObject: IDispatch;
    function  Get_WizardCatalogVisible: WordBool;
    procedure Set_WizardCatalogVisible(WizardCatalogVisible: WordBool);
    function  Get_Documents: Documents;
    function  Get_WebOptions: WebOptions;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Application);
    procedure Disconnect; override;
    procedure ChangeFileOpenDirectory(const Dir: WideString);
    procedure Help(HelpType: PbHelpType);
    function  IsValidObject(const Object_: IDispatch): WordBool;
    function  NewDocument(Wizard: PbWizard; Design: Integer): Document;
    function  Open(const Filename: WideString; ReadOnly: WordBool; AddToRecentFiles: WordBool; 
                   SaveChanges: PbSaveOptions): Document;
    procedure Quit;
    procedure LaunchWebService;
    function  CentimetersToPoints(Value: Single): Single;
    function  EmusToPoints(Value: Single): Single;
    function  InchesToPoints(Value: Single): Single;
    function  LinesToPoints(Value: Single): Single;
    function  MillimetersToPoints(Value: Single): Single;
    function  PicasToPoints(Value: Single): Single;
    function  PixelsToPoints(Value: Single): Single;
    function  TwipsToPoints(Value: Single): Single;
    function  PointsToCentimeters(Value: Single): Single;
    function  PointsToEmus(Value: Single): Single;
    function  PointsToInches(Value: Single): Single;
    function  PointsToLines(Value: Single): Single;
    function  PointsToMillimeters(Value: Single): Single;
    function  PointsToPicas(Value: Single): Single;
    function  PointsToPixels(Value: Single): Single;
    function  PointsToTwips(Value: Single): Single;
    property  DefaultInterface: _Application read GetDefaultInterface;
    property ActiveDocument: Document read Get_ActiveDocument;
    property ActiveWindow: Window read Get_ActiveWindow;
    property Application: Application read Get_Application;
    property Assistant: Assistant read Get_Assistant;
    property Build: Integer read Get_Build;
    property ColorSchemes: ColorSchemes read Get_ColorSchemes;
    property COMAddIns: COMAddIns read Get_COMAddIns;
    property CommandBars: CommandBars read Get_CommandBars;
    property FileDialog[Type_: TOleEnum]: IDispatch read Get_FileDialog;
    property FileSearch: FileSearch read Get_FileSearch;
    property Language: Integer read Get_Language;
    property Name: WideString read Get_Name;
    property Options: Options read Get_Options;
    property Parent: IDispatch read Get_Parent;
    property Path: WideString read Get_Path;
    property PathSeparator: WideString read Get_PathSeparator;
    property ProductCode: WideString read Get_ProductCode;
    property Selection: Selection read Get_Selection;
    property TemplateFolderPath: WideString read Get_TemplateFolderPath;
    property Version: WideString read Get_Version;
    property OfficeDataSourceObject: IDispatch read Get_OfficeDataSourceObject;
    property Documents: Documents read Get_Documents;
    property WebOptions: WebOptions read Get_WebOptions;
    property PrintPreview: WordBool read Get_PrintPreview write Set_PrintPreview;
    property ScreenUpdating: WordBool read Get_ScreenUpdating write Set_ScreenUpdating;
    property SnapToGuides: WordBool read Get_SnapToGuides write Set_SnapToGuides;
    property SnapToObjects: WordBool read Get_SnapToObjects write Set_SnapToObjects;
    property WizardCatalogVisible: WordBool read Get_WizardCatalogVisible write Set_WizardCatalogVisible;
  published
    property AutoQuit: Boolean read FAutoQuit write FAutoQuit; 
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TApplicationProperties read GetServerProperties;
{$ENDIF}
    property OnWindowActivate: TApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnWindowPageChange: TApplicationWindowPageChange read FOnWindowPageChange write FOnWindowPageChange;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnNewDocument: TApplicationNewDocument read FOnNewDocument write FOnNewDocument;
    property OnDocumentOpen: TApplicationDocumentOpen read FOnDocumentOpen write FOnDocumentOpen;
    property OnDocumentBeforeClose: TApplicationDocumentBeforeClose read FOnDocumentBeforeClose write FOnDocumentBeforeClose;
    property OnMailMergeAfterMerge: TApplicationMailMergeAfterMerge read FOnMailMergeAfterMerge write FOnMailMergeAfterMerge;
    property OnMailMergeAfterRecordMerge: TApplicationMailMergeAfterRecordMerge read FOnMailMergeAfterRecordMerge write FOnMailMergeAfterRecordMerge;
    property OnMailMergeBeforeMerge: TApplicationMailMergeBeforeMerge read FOnMailMergeBeforeMerge write FOnMailMergeBeforeMerge;
    property OnMailMergeBeforeRecordMerge: TApplicationMailMergeBeforeRecordMerge read FOnMailMergeBeforeRecordMerge write FOnMailMergeBeforeRecordMerge;
    property OnMailMergeDataSourceLoad: TApplicationMailMergeDataSourceLoad read FOnMailMergeDataSourceLoad write FOnMailMergeDataSourceLoad;
    property OnMailMergeWizardSendToCustom: TApplicationMailMergeWizardSendToCustom read FOnMailMergeWizardSendToCustom write FOnMailMergeWizardSendToCustom;
    property OnMailMergeWizardStateChange: TApplicationMailMergeWizardStateChange read FOnMailMergeWizardStateChange write FOnMailMergeWizardStateChange;
    property OnMailMergeDataSourceValidate: TApplicationMailMergeDataSourceValidate read FOnMailMergeDataSourceValidate write FOnMailMergeDataSourceValidate;
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
    function    GetDefaultInterface: _Application;
    constructor Create(AServer: TApplication);
  protected
    function  Get_ActiveDocument: Document;
    function  Get_ActiveWindow: Window;
    function  Get_Application: Application;
    function  Get_Assistant: Assistant;
    function  Get_Build: Integer;
    function  Get_ColorSchemes: ColorSchemes;
    function  Get_COMAddIns: COMAddIns;
    function  Get_CommandBars: CommandBars;
    function  Get_FileDialog(Type_: MsoFileDialogType): FileDialog;
    function  Get_FileSearch: FileSearch;
    function  Get_Language: Integer;
    function  Get_Name: WideString;
    function  Get_Options: Options;
    function  Get_Parent: IDispatch;
    function  Get_Path: WideString;
    function  Get_PathSeparator: WideString;
    function  Get_ProductCode: WideString;
    function  Get_PrintPreview: WordBool;
    procedure Set_PrintPreview(RetValue: WordBool);
    function  Get_ScreenUpdating: WordBool;
    procedure Set_ScreenUpdating(RetValue: WordBool);
    function  Get_Selection: Selection;
    function  Get_SnapToGuides: WordBool;
    procedure Set_SnapToGuides(RetValue: WordBool);
    function  Get_SnapToObjects: WordBool;
    procedure Set_SnapToObjects(RetValue: WordBool);
    function  Get_TemplateFolderPath: WideString;
    function  Get_Version: WideString;
    function  Get_OfficeDataSourceObject: OfficeDataSourceObject;
    function  Get_WizardCatalogVisible: WordBool;
    procedure Set_WizardCatalogVisible(WizardCatalogVisible: WordBool);
    function  Get_Documents: Documents;
    function  Get_WebOptions: WebOptions;
  public
    property DefaultInterface: _Application read GetDefaultInterface;
  published
    property PrintPreview: WordBool read Get_PrintPreview write Set_PrintPreview;
    property ScreenUpdating: WordBool read Get_ScreenUpdating write Set_ScreenUpdating;
    property SnapToGuides: WordBool read Get_SnapToGuides write Set_SnapToGuides;
    property SnapToObjects: WordBool read Get_SnapToObjects write Set_SnapToObjects;
    property WizardCatalogVisible: WordBool read Get_WizardCatalogVisible write Set_WizardCatalogVisible;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDocument provides a Create and CreateRemote method to          
// create instances of the default interface _Document exposed by              
// the CoClass Document. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDocument = class
    class function Create: _Document;
    class function CreateRemote(const MachineName: string): _Document;
  end;

  TDocumentBeforeClose = procedure(Sender: TObject; var Cancel: OleVariant) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDocument
// Help String      : 
// Default Interface: _Document
// Def. Intf. DISP? : No
// Event   Interface: DocumentEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDocumentProperties= class;
{$ENDIF}
  TDocument = class(TOleServer)
  private
    FOnOpen: TNotifyEvent;
    FOnBeforeClose: TDocumentBeforeClose;
    FOnShapesAdded: TNotifyEvent;
    FOnWizardAfterChange: TNotifyEvent;
    FOnShapesRemoved: TNotifyEvent;
    FOnUndo: TNotifyEvent;
    FOnRedo: TNotifyEvent;
    FIntf:        _Document;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TDocumentProperties;
    function      GetServerProperties: TDocumentProperties;
{$ENDIF}
    function      GetDefaultInterface: _Document;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function  Get_ActivePrinter: WideString;
    procedure Set_ActivePrinter(const RetValue: WideString);
    function  Get_ActiveWindow: Window;
    function  Get_Application: Application;
    function  Get_ColorMode: PbColorMode;
    function  Get_ColorScheme: ColorScheme;
    procedure Set_ColorScheme(const RetVal: ColorScheme);
    function  Get_DefaultTabStop: OleVariant;
    procedure Set_DefaultTabStop(RetValue: OleVariant);
    function  Get_EnvelopeVisible: WordBool;
    procedure Set_EnvelopeVisible(RetValue: WordBool);
    function  Get_FullName: WideString;
    function  Get_LayoutGuides: LayoutGuides;
    function  Get_MailEnvelope: IDispatch;
    function  Get_MailMerge: MailMerge;
    function  Get_MasterPages: MasterPages;
    function  Get_Name: WideString;
    function  Get_Pages: Pages;
    function  Get_PageSetup: PageSetup;
    function  Get_Parent: IDispatch;
    function  Get_Path: WideString;
    function  Get_PersonalInformationSet: PbPersonalInfoSet;
    procedure Set_PersonalInformationSet(RetValue: PbPersonalInfoSet);
    function  Get_Plates: Plates;
    function  Get_ReadOnly: WordBool;
    function  Get_DocumentDirection: PbDirectionType;
    procedure Set_DocumentDirection(RetValue: PbDirectionType);
    function  Get_Saved: WordBool;
    function  Get_SaveFormat: PbFileFormat;
    function  Get_ScratchArea: ScratchArea;
    function  Get_Selection: Selection;
    function  Get_Stories: Stories;
    function  Get_Tags: Tags;
    function  Get_TextStyles: TextStyles;
    function  Get_ViewBoundariesAndGuides: WordBool;
    procedure Set_ViewBoundariesAndGuides(RetValue: WordBool);
    function  Get_ViewTwoPageSpread: WordBool;
    procedure Set_ViewTwoPageSpread(RetValue: WordBool);
    function  Get_Wizard: Wizard;
    function  Get_ActiveView: View;
    function  Get_AdvancedPrintOptions: AdvancedPrintOptions;
    function  Get_BorderArts: BorderArts;
    function  Get_IsDataSourceConnected: WordBool;
    function  Get_Find: FindReplace;
    function  Get_UndoActionsAvailable: SYSINT;
    function  Get_RedoActionsAvailable: SYSINT;
    function  Get_ViewHorizontalBaseLineGuides: WordBool;
    procedure Set_ViewHorizontalBaseLineGuides(RetValue: WordBool);
    function  Get_ViewVerticalBaseLineGuides: WordBool;
    procedure Set_ViewVerticalBaseLineGuides(RetValue: WordBool);
    function  Get_PublicationType: PbPublicationType;
    function  Get_Sections: Sections;
    function  Get_WebNavigationBarSets: WebNavigationBarSets;
    function  Get_RemovePersonalInformation: WordBool;
    procedure Set_RemovePersonalInformation(RetValue: WordBool);
    function  Get_PrintPageBackgrounds: WordBool;
    procedure Set_PrintPageBackgrounds(RetValue: WordBool);
    function  Get_ColorsInUse: ColorsInUse;
    function  Get_IsWizard: WordBool;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Document);
    procedure Disconnect; override;
    procedure Close;
    function  CreatePlateCollection(Mode: PbColorMode): Plates;
    procedure EnterColorMode10(Mode: PbColorMode); overload;
    procedure EnterColorMode10(Mode: PbColorMode; Plates: OleVariant); overload;
    function  FindShapesByTag(const TagName: WideString): ShapeRange;
    function  FindShapeByWizardTag(WizardTag: PbWizardTag; Instance: Integer): ShapeRange;
    procedure PrintOut(From: Integer; To_: Integer; const PrintToFile: WideString; Copies: Integer; 
                       Collate: WordBool);
    procedure Save;
    procedure SaveAs(Filename: OleVariant; Format: PbFileFormat; AddToRecentFiles: WordBool);
    procedure SelectID(oh: SYSINT);
    procedure UndoClear;
    procedure UpdateOLEObjects;
    procedure Undo(Count: SYSINT);
    procedure Redo(Count: SYSINT);
    procedure BeginCustomUndoAction(const ActionName: WideString);
    procedure EndCustomUndoAction;
    procedure WebPagePreview;
    procedure ConvertPublicationType(Value: PbPublicationType);
    procedure EnterColorMode(Mode: PbColorMode; Plates: OleVariant; DeleteExcessInks: WordBool);
    property  DefaultInterface: _Document read GetDefaultInterface;
    property ActiveWindow: Window read Get_ActiveWindow;
    property Application: Application read Get_Application;
    property ColorMode: PbColorMode read Get_ColorMode;
    property DefaultTabStop: OleVariant read Get_DefaultTabStop write Set_DefaultTabStop;
    property FullName: WideString read Get_FullName;
    property LayoutGuides: LayoutGuides read Get_LayoutGuides;
    property MailEnvelope: IDispatch read Get_MailEnvelope;
    property MailMerge: MailMerge read Get_MailMerge;
    property MasterPages: MasterPages read Get_MasterPages;
    property Name: WideString read Get_Name;
    property Pages: Pages read Get_Pages;
    property PageSetup: PageSetup read Get_PageSetup;
    property Parent: IDispatch read Get_Parent;
    property Path: WideString read Get_Path;
    property Plates: Plates read Get_Plates;
    property ReadOnly: WordBool read Get_ReadOnly;
    property Saved: WordBool read Get_Saved;
    property SaveFormat: PbFileFormat read Get_SaveFormat;
    property ScratchArea: ScratchArea read Get_ScratchArea;
    property Selection: Selection read Get_Selection;
    property Stories: Stories read Get_Stories;
    property Tags: Tags read Get_Tags;
    property TextStyles: TextStyles read Get_TextStyles;
    property Wizard: Wizard read Get_Wizard;
    property ActiveView: View read Get_ActiveView;
    property AdvancedPrintOptions: AdvancedPrintOptions read Get_AdvancedPrintOptions;
    property BorderArts: BorderArts read Get_BorderArts;
    property IsDataSourceConnected: WordBool read Get_IsDataSourceConnected;
    property Find: FindReplace read Get_Find;
    property UndoActionsAvailable: SYSINT read Get_UndoActionsAvailable;
    property RedoActionsAvailable: SYSINT read Get_RedoActionsAvailable;
    property PublicationType: PbPublicationType read Get_PublicationType;
    property Sections: Sections read Get_Sections;
    property WebNavigationBarSets: WebNavigationBarSets read Get_WebNavigationBarSets;
    property ColorsInUse: ColorsInUse read Get_ColorsInUse;
    property IsWizard: WordBool read Get_IsWizard;
    property ActivePrinter: WideString read Get_ActivePrinter write Set_ActivePrinter;
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property EnvelopeVisible: WordBool read Get_EnvelopeVisible write Set_EnvelopeVisible;
    property PersonalInformationSet: PbPersonalInfoSet read Get_PersonalInformationSet write Set_PersonalInformationSet;
    property DocumentDirection: PbDirectionType read Get_DocumentDirection write Set_DocumentDirection;
    property ViewBoundariesAndGuides: WordBool read Get_ViewBoundariesAndGuides write Set_ViewBoundariesAndGuides;
    property ViewTwoPageSpread: WordBool read Get_ViewTwoPageSpread write Set_ViewTwoPageSpread;
    property ViewHorizontalBaseLineGuides: WordBool read Get_ViewHorizontalBaseLineGuides write Set_ViewHorizontalBaseLineGuides;
    property ViewVerticalBaseLineGuides: WordBool read Get_ViewVerticalBaseLineGuides write Set_ViewVerticalBaseLineGuides;
    property RemovePersonalInformation: WordBool read Get_RemovePersonalInformation write Set_RemovePersonalInformation;
    property PrintPageBackgrounds: WordBool read Get_PrintPageBackgrounds write Set_PrintPageBackgrounds;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDocumentProperties read GetServerProperties;
{$ENDIF}
    property OnOpen: TNotifyEvent read FOnOpen write FOnOpen;
    property OnBeforeClose: TDocumentBeforeClose read FOnBeforeClose write FOnBeforeClose;
    property OnShapesAdded: TNotifyEvent read FOnShapesAdded write FOnShapesAdded;
    property OnWizardAfterChange: TNotifyEvent read FOnWizardAfterChange write FOnWizardAfterChange;
    property OnShapesRemoved: TNotifyEvent read FOnShapesRemoved write FOnShapesRemoved;
    property OnUndo: TNotifyEvent read FOnUndo write FOnUndo;
    property OnRedo: TNotifyEvent read FOnRedo write FOnRedo;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDocument
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDocumentProperties = class(TPersistent)
  private
    FServer:    TDocument;
    function    GetDefaultInterface: _Document;
    constructor Create(AServer: TDocument);
  protected
    function  Get_ActivePrinter: WideString;
    procedure Set_ActivePrinter(const RetValue: WideString);
    function  Get_ActiveWindow: Window;
    function  Get_Application: Application;
    function  Get_ColorMode: PbColorMode;
    function  Get_ColorScheme: ColorScheme;
    procedure Set_ColorScheme(const RetVal: ColorScheme);
    function  Get_DefaultTabStop: OleVariant;
    procedure Set_DefaultTabStop(RetValue: OleVariant);
    function  Get_EnvelopeVisible: WordBool;
    procedure Set_EnvelopeVisible(RetValue: WordBool);
    function  Get_FullName: WideString;
    function  Get_LayoutGuides: LayoutGuides;
    function  Get_MailEnvelope: MsoEnvelope;
    function  Get_MailMerge: MailMerge;
    function  Get_MasterPages: MasterPages;
    function  Get_Name: WideString;
    function  Get_Pages: Pages;
    function  Get_PageSetup: PageSetup;
    function  Get_Parent: IDispatch;
    function  Get_Path: WideString;
    function  Get_PersonalInformationSet: PbPersonalInfoSet;
    procedure Set_PersonalInformationSet(RetValue: PbPersonalInfoSet);
    function  Get_Plates: Plates;
    function  Get_ReadOnly: WordBool;
    function  Get_DocumentDirection: PbDirectionType;
    procedure Set_DocumentDirection(RetValue: PbDirectionType);
    function  Get_Saved: WordBool;
    function  Get_SaveFormat: PbFileFormat;
    function  Get_ScratchArea: ScratchArea;
    function  Get_Selection: Selection;
    function  Get_Stories: Stories;
    function  Get_Tags: Tags;
    function  Get_TextStyles: TextStyles;
    function  Get_ViewBoundariesAndGuides: WordBool;
    procedure Set_ViewBoundariesAndGuides(RetValue: WordBool);
    function  Get_ViewTwoPageSpread: WordBool;
    procedure Set_ViewTwoPageSpread(RetValue: WordBool);
    function  Get_Wizard: Wizard;
    function  Get_ActiveView: View;
    function  Get_AdvancedPrintOptions: AdvancedPrintOptions;
    function  Get_BorderArts: BorderArts;
    function  Get_IsDataSourceConnected: WordBool;
    function  Get_Find: FindReplace;
    function  Get_UndoActionsAvailable: SYSINT;
    function  Get_RedoActionsAvailable: SYSINT;
    function  Get_ViewHorizontalBaseLineGuides: WordBool;
    procedure Set_ViewHorizontalBaseLineGuides(RetValue: WordBool);
    function  Get_ViewVerticalBaseLineGuides: WordBool;
    procedure Set_ViewVerticalBaseLineGuides(RetValue: WordBool);
    function  Get_PublicationType: PbPublicationType;
    function  Get_Sections: Sections;
    function  Get_WebNavigationBarSets: WebNavigationBarSets;
    function  Get_RemovePersonalInformation: WordBool;
    procedure Set_RemovePersonalInformation(RetValue: WordBool);
    function  Get_PrintPageBackgrounds: WordBool;
    procedure Set_PrintPageBackgrounds(RetValue: WordBool);
    function  Get_ColorsInUse: ColorsInUse;
    function  Get_IsWizard: WordBool;
  public
    property DefaultInterface: _Document read GetDefaultInterface;
  published
    property ActivePrinter: WideString read Get_ActivePrinter write Set_ActivePrinter;
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property EnvelopeVisible: WordBool read Get_EnvelopeVisible write Set_EnvelopeVisible;
    property PersonalInformationSet: PbPersonalInfoSet read Get_PersonalInformationSet write Set_PersonalInformationSet;
    property DocumentDirection: PbDirectionType read Get_DocumentDirection write Set_DocumentDirection;
    property ViewBoundariesAndGuides: WordBool read Get_ViewBoundariesAndGuides write Set_ViewBoundariesAndGuides;
    property ViewTwoPageSpread: WordBool read Get_ViewTwoPageSpread write Set_ViewTwoPageSpread;
    property ViewHorizontalBaseLineGuides: WordBool read Get_ViewHorizontalBaseLineGuides write Set_ViewHorizontalBaseLineGuides;
    property ViewVerticalBaseLineGuides: WordBool read Get_ViewVerticalBaseLineGuides write Set_ViewVerticalBaseLineGuides;
    property RemovePersonalInformation: WordBool read Get_RemovePersonalInformation write Set_RemovePersonalInformation;
    property PrintPageBackgrounds: WordBool read Get_PrintPageBackgrounds write Set_PrintPageBackgrounds;
  end;
{$ENDIF}


procedure Register;

implementation

uses ComObj;

class function CoApplication.Create: _Application;
begin
  Result := CreateComObject(CLASS_Application) as _Application;
end;

class function CoApplication.CreateRemote(const MachineName: string): _Application;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Application) as _Application;
end;

procedure TApplication.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0002123D-0000-0000-C000-000000000046}';
    IntfIID:   '{0002123E-0000-0000-C000-000000000046}';
    EventIID:  '{00021240-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TApplication.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Application;
  end;
end;

procedure TApplication.ConnectTo(svrIntf: _Application);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TApplication.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    if FAutoQuit then
      Quit();
    FIntf := nil;
  end;
end;

function TApplication.GetDefaultInterface: _Application;
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
            FOnWindowActivate(Self, Params[0] {const Window});
   2: if Assigned(FOnWindowDeactivate) then
            FOnWindowDeactivate(Self, Params[0] {const Window});
   4: if Assigned(FOnWindowPageChange) then
            FOnWindowPageChange(Self, Params[0] {const View});
   5: if Assigned(FOnQuit) then
            FOnQuit(Self);
   6: if Assigned(FOnNewDocument) then
            FOnNewDocument(Self, Params[0] {const _Document});
   7: if Assigned(FOnDocumentOpen) then
            FOnDocumentOpen(Self, Params[0] {const _Document});
   8: if Assigned(FOnDocumentBeforeClose) then
            FOnDocumentBeforeClose(Self, Params[0] {const _Document}, Params[1] {var WordBool});
   9: if Assigned(FOnMailMergeAfterMerge) then
            FOnMailMergeAfterMerge(Self, Params[0] {const _Document});
   10: if Assigned(FOnMailMergeAfterRecordMerge) then
            FOnMailMergeAfterRecordMerge(Self, Params[0] {const _Document});
   11: if Assigned(FOnMailMergeBeforeMerge) then
            FOnMailMergeBeforeMerge(Self, Params[0] {const _Document}, Params[1] {Integer}, Params[2] {Integer}, Params[3] {var WordBool});
   12: if Assigned(FOnMailMergeBeforeRecordMerge) then
            FOnMailMergeBeforeRecordMerge(Self, Params[0] {const _Document}, Params[1] {var WordBool});
   13: if Assigned(FOnMailMergeDataSourceLoad) then
            FOnMailMergeDataSourceLoad(Self, Params[0] {const _Document});
   16: if Assigned(FOnMailMergeWizardSendToCustom) then
            FOnMailMergeWizardSendToCustom(Self, Params[0] {const _Document});
   17: if Assigned(FOnMailMergeWizardStateChange) then
            FOnMailMergeWizardStateChange(Self, Params[0] {const _Document}, Params[1] {SYSINT});
   18: if Assigned(FOnMailMergeDataSourceValidate) then
            FOnMailMergeDataSourceValidate(Self, Params[0] {const _Document}, Params[1] {var WordBool});
  end; {case DispID}
end;

function  TApplication.Get_ActiveDocument: Document;
begin
  Result := DefaultInterface.Get_ActiveDocument;
end;

function  TApplication.Get_ActiveWindow: Window;
begin
  Result := DefaultInterface.Get_ActiveWindow;
end;

function  TApplication.Get_Application: Application;
begin
  Result := DefaultInterface.Get_Application;
end;

function  TApplication.Get_Assistant: Assistant;
begin
  Result := DefaultInterface.Get_Assistant;
end;

function  TApplication.Get_Build: Integer;
begin
  Result := DefaultInterface.Get_Build;
end;

function  TApplication.Get_ColorSchemes: ColorSchemes;
begin
  Result := DefaultInterface.Get_ColorSchemes;
end;

function  TApplication.Get_COMAddIns: COMAddIns;
begin
  Result := DefaultInterface.Get_COMAddIns;
end;

function  TApplication.Get_CommandBars: CommandBars;
begin
  Result := DefaultInterface.Get_CommandBars;
end;

function  TApplication.Get_FileDialog(Type_: TOleEnum): IDispatch;
begin
  Result := DefaultInterface.Get_FileDialog(Type_);
end;

function  TApplication.Get_FileSearch: FileSearch;
begin
  Result := DefaultInterface.Get_FileSearch;
end;

function  TApplication.Get_Language: Integer;
begin
  Result := DefaultInterface.Get_Language;
end;

function  TApplication.Get_Name: WideString;
begin
  Result := DefaultInterface.Get_Name;
end;

function  TApplication.Get_Options: Options;
begin
  Result := DefaultInterface.Get_Options;
end;

function  TApplication.Get_Parent: IDispatch;
begin
  Result := DefaultInterface.Get_Parent;
end;

function  TApplication.Get_Path: WideString;
begin
  Result := DefaultInterface.Get_Path;
end;

function  TApplication.Get_PathSeparator: WideString;
begin
  Result := DefaultInterface.Get_PathSeparator;
end;

function  TApplication.Get_ProductCode: WideString;
begin
  Result := DefaultInterface.Get_ProductCode;
end;

function  TApplication.Get_PrintPreview: WordBool;
begin
  Result := DefaultInterface.Get_PrintPreview;
end;

procedure TApplication.Set_PrintPreview(RetValue: WordBool);
begin
  DefaultInterface.Set_PrintPreview(RetValue);
end;

function  TApplication.Get_ScreenUpdating: WordBool;
begin
  Result := DefaultInterface.Get_ScreenUpdating;
end;

procedure TApplication.Set_ScreenUpdating(RetValue: WordBool);
begin
  DefaultInterface.Set_ScreenUpdating(RetValue);
end;

function  TApplication.Get_Selection: Selection;
begin
  Result := DefaultInterface.Get_Selection;
end;

function  TApplication.Get_SnapToGuides: WordBool;
begin
  Result := DefaultInterface.Get_SnapToGuides;
end;

procedure TApplication.Set_SnapToGuides(RetValue: WordBool);
begin
  DefaultInterface.Set_SnapToGuides(RetValue);
end;

function  TApplication.Get_SnapToObjects: WordBool;
begin
  Result := DefaultInterface.Get_SnapToObjects;
end;

procedure TApplication.Set_SnapToObjects(RetValue: WordBool);
begin
  DefaultInterface.Set_SnapToObjects(RetValue);
end;

function  TApplication.Get_TemplateFolderPath: WideString;
begin
  Result := DefaultInterface.Get_TemplateFolderPath;
end;

function  TApplication.Get_Version: WideString;
begin
  Result := DefaultInterface.Get_Version;
end;

function  TApplication.Get_OfficeDataSourceObject: IDispatch;
begin
  Result := DefaultInterface.Get_OfficeDataSourceObject;
end;

function  TApplication.Get_WizardCatalogVisible: WordBool;
begin
  Result := DefaultInterface.Get_WizardCatalogVisible;
end;

procedure TApplication.Set_WizardCatalogVisible(WizardCatalogVisible: WordBool);
begin
  DefaultInterface.Set_WizardCatalogVisible(WizardCatalogVisible);
end;

function  TApplication.Get_Documents: Documents;
begin
  Result := DefaultInterface.Get_Documents;
end;

function  TApplication.Get_WebOptions: WebOptions;
begin
  Result := DefaultInterface.Get_WebOptions;
end;

procedure TApplication.ChangeFileOpenDirectory(const Dir: WideString);
begin
  DefaultInterface.ChangeFileOpenDirectory(Dir);
end;

procedure TApplication.Help(HelpType: PbHelpType);
begin
  DefaultInterface.Help(HelpType);
end;

function  TApplication.IsValidObject(const Object_: IDispatch): WordBool;
begin
  Result := DefaultInterface.IsValidObject(Object_);
end;

function  TApplication.NewDocument(Wizard: PbWizard; Design: Integer): Document;
begin
  Result := DefaultInterface.NewDocument(Wizard, Design);
end;

function  TApplication.Open(const Filename: WideString; ReadOnly: WordBool; 
                            AddToRecentFiles: WordBool; SaveChanges: PbSaveOptions): Document;
begin
  Result := DefaultInterface.Open(Filename, ReadOnly, AddToRecentFiles, SaveChanges);
end;

procedure TApplication.Quit;
begin
  DefaultInterface.Quit;
end;

procedure TApplication.LaunchWebService;
begin
  DefaultInterface.LaunchWebService;
end;

function  TApplication.CentimetersToPoints(Value: Single): Single;
begin
  Result := DefaultInterface.CentimetersToPoints(Value);
end;

function  TApplication.EmusToPoints(Value: Single): Single;
begin
  Result := DefaultInterface.EmusToPoints(Value);
end;

function  TApplication.InchesToPoints(Value: Single): Single;
begin
  Result := DefaultInterface.InchesToPoints(Value);
end;

function  TApplication.LinesToPoints(Value: Single): Single;
begin
  Result := DefaultInterface.LinesToPoints(Value);
end;

function  TApplication.MillimetersToPoints(Value: Single): Single;
begin
  Result := DefaultInterface.MillimetersToPoints(Value);
end;

function  TApplication.PicasToPoints(Value: Single): Single;
begin
  Result := DefaultInterface.PicasToPoints(Value);
end;

function  TApplication.PixelsToPoints(Value: Single): Single;
begin
  Result := DefaultInterface.PixelsToPoints(Value);
end;

function  TApplication.TwipsToPoints(Value: Single): Single;
begin
  Result := DefaultInterface.TwipsToPoints(Value);
end;

function  TApplication.PointsToCentimeters(Value: Single): Single;
begin
  Result := DefaultInterface.PointsToCentimeters(Value);
end;

function  TApplication.PointsToEmus(Value: Single): Single;
begin
  Result := DefaultInterface.PointsToEmus(Value);
end;

function  TApplication.PointsToInches(Value: Single): Single;
begin
  Result := DefaultInterface.PointsToInches(Value);
end;

function  TApplication.PointsToLines(Value: Single): Single;
begin
  Result := DefaultInterface.PointsToLines(Value);
end;

function  TApplication.PointsToMillimeters(Value: Single): Single;
begin
  Result := DefaultInterface.PointsToMillimeters(Value);
end;

function  TApplication.PointsToPicas(Value: Single): Single;
begin
  Result := DefaultInterface.PointsToPicas(Value);
end;

function  TApplication.PointsToPixels(Value: Single): Single;
begin
  Result := DefaultInterface.PointsToPixels(Value);
end;

function  TApplication.PointsToTwips(Value: Single): Single;
begin
  Result := DefaultInterface.PointsToTwips(Value);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TApplicationProperties.Create(AServer: TApplication);
begin
  inherited Create;
  FServer := AServer;
end;

function TApplicationProperties.GetDefaultInterface: _Application;
begin
  Result := FServer.DefaultInterface;
end;

function  TApplicationProperties.Get_ActiveDocument: Document;
begin
  Result := DefaultInterface.Get_ActiveDocument;
end;

function  TApplicationProperties.Get_ActiveWindow: Window;
begin
  Result := DefaultInterface.Get_ActiveWindow;
end;

function  TApplicationProperties.Get_Application: Application;
begin
  Result := DefaultInterface.Get_Application;
end;

function  TApplicationProperties.Get_Assistant: Assistant;
begin
  Result := DefaultInterface.Get_Assistant;
end;

function  TApplicationProperties.Get_Build: Integer;
begin
  Result := DefaultInterface.Get_Build;
end;

function  TApplicationProperties.Get_ColorSchemes: ColorSchemes;
begin
  Result := DefaultInterface.Get_ColorSchemes;
end;

function  TApplicationProperties.Get_COMAddIns: COMAddIns;
begin
  Result := DefaultInterface.Get_COMAddIns;
end;

function  TApplicationProperties.Get_CommandBars: CommandBars;
begin
  Result := DefaultInterface.Get_CommandBars;
end;

function  TApplicationProperties.Get_FileDialog(Type_: MsoFileDialogType): FileDialog;
begin
  Result := DefaultInterface.Get_FileDialog(Type_);
end;

function  TApplicationProperties.Get_FileSearch: FileSearch;
begin
  Result := DefaultInterface.Get_FileSearch;
end;

function  TApplicationProperties.Get_Language: Integer;
begin
  Result := DefaultInterface.Get_Language;
end;

function  TApplicationProperties.Get_Name: WideString;
begin
  Result := DefaultInterface.Get_Name;
end;

function  TApplicationProperties.Get_Options: Options;
begin
  Result := DefaultInterface.Get_Options;
end;

function  TApplicationProperties.Get_Parent: IDispatch;
begin
  Result := DefaultInterface.Get_Parent;
end;

function  TApplicationProperties.Get_Path: WideString;
begin
  Result := DefaultInterface.Get_Path;
end;

function  TApplicationProperties.Get_PathSeparator: WideString;
begin
  Result := DefaultInterface.Get_PathSeparator;
end;

function  TApplicationProperties.Get_ProductCode: WideString;
begin
  Result := DefaultInterface.Get_ProductCode;
end;

function  TApplicationProperties.Get_PrintPreview: WordBool;
begin
  Result := DefaultInterface.Get_PrintPreview;
end;

procedure TApplicationProperties.Set_PrintPreview(RetValue: WordBool);
begin
  DefaultInterface.Set_PrintPreview(RetValue);
end;

function  TApplicationProperties.Get_ScreenUpdating: WordBool;
begin
  Result := DefaultInterface.Get_ScreenUpdating;
end;

procedure TApplicationProperties.Set_ScreenUpdating(RetValue: WordBool);
begin
  DefaultInterface.Set_ScreenUpdating(RetValue);
end;

function  TApplicationProperties.Get_Selection: Selection;
begin
  Result := DefaultInterface.Get_Selection;
end;

function  TApplicationProperties.Get_SnapToGuides: WordBool;
begin
  Result := DefaultInterface.Get_SnapToGuides;
end;

procedure TApplicationProperties.Set_SnapToGuides(RetValue: WordBool);
begin
  DefaultInterface.Set_SnapToGuides(RetValue);
end;

function  TApplicationProperties.Get_SnapToObjects: WordBool;
begin
  Result := DefaultInterface.Get_SnapToObjects;
end;

procedure TApplicationProperties.Set_SnapToObjects(RetValue: WordBool);
begin
  DefaultInterface.Set_SnapToObjects(RetValue);
end;

function  TApplicationProperties.Get_TemplateFolderPath: WideString;
begin
  Result := DefaultInterface.Get_TemplateFolderPath;
end;

function  TApplicationProperties.Get_Version: WideString;
begin
  Result := DefaultInterface.Get_Version;
end;

function  TApplicationProperties.Get_OfficeDataSourceObject: OfficeDataSourceObject;
begin
  Result := DefaultInterface.Get_OfficeDataSourceObject;
end;

function  TApplicationProperties.Get_WizardCatalogVisible: WordBool;
begin
  Result := DefaultInterface.Get_WizardCatalogVisible;
end;

procedure TApplicationProperties.Set_WizardCatalogVisible(WizardCatalogVisible: WordBool);
begin
  DefaultInterface.Set_WizardCatalogVisible(WizardCatalogVisible);
end;

function  TApplicationProperties.Get_Documents: Documents;
begin
  Result := DefaultInterface.Get_Documents;
end;

function  TApplicationProperties.Get_WebOptions: WebOptions;
begin
  Result := DefaultInterface.Get_WebOptions;
end;

{$ENDIF}

class function CoDocument.Create: _Document;
begin
  Result := CreateComObject(CLASS_Document) as _Document;
end;

class function CoDocument.CreateRemote(const MachineName: string): _Document;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Document) as _Document;
end;

procedure TDocument.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{09FD2EFF-5669-11D3-B65F-00C04F8EF32D}';
    IntfIID:   '{00021242-0000-0000-C000-000000000046}';
    EventIID:  '{00021244-0000-0000-C000-000000000046}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDocument.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Document;
  end;
end;

procedure TDocument.ConnectTo(svrIntf: _Document);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TDocument.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TDocument.GetDefaultInterface: _Document;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TDocument.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDocumentProperties.Create(Self);
{$ENDIF}
end;

destructor TDocument.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDocument.GetServerProperties: TDocumentProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TDocument.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
   1: if Assigned(FOnOpen) then
            FOnOpen(Self);
   2: if Assigned(FOnBeforeClose) then
            FOnBeforeClose(Self, Params[0] {var WordBool});
   3: if Assigned(FOnShapesAdded) then
            FOnShapesAdded(Self);
   4: if Assigned(FOnWizardAfterChange) then
            FOnWizardAfterChange(Self);
   5: if Assigned(FOnShapesRemoved) then
            FOnShapesRemoved(Self);
   6: if Assigned(FOnUndo) then
            FOnUndo(Self);
   7: if Assigned(FOnRedo) then
            FOnRedo(Self);
  end; {case DispID}
end;

function  TDocument.Get_ActivePrinter: WideString;
begin
  Result := DefaultInterface.Get_ActivePrinter;
end;

procedure TDocument.Set_ActivePrinter(const RetValue: WideString);
begin
  DefaultInterface.Set_ActivePrinter(RetValue);
end;

function  TDocument.Get_ActiveWindow: Window;
begin
  Result := DefaultInterface.Get_ActiveWindow;
end;

function  TDocument.Get_Application: Application;
begin
  Result := DefaultInterface.Get_Application;
end;

function  TDocument.Get_ColorMode: PbColorMode;
begin
  Result := DefaultInterface.Get_ColorMode;
end;

function  TDocument.Get_ColorScheme: ColorScheme;
begin
  Result := DefaultInterface.Get_ColorScheme;
end;

procedure TDocument.Set_ColorScheme(const RetVal: ColorScheme);
begin
  DefaultInterface.Set_ColorScheme(RetVal);
end;

function  TDocument.Get_DefaultTabStop: OleVariant;
begin
  Result := DefaultInterface.Get_DefaultTabStop;
end;

procedure TDocument.Set_DefaultTabStop(RetValue: OleVariant);
begin
  DefaultInterface.Set_DefaultTabStop(RetValue);
end;

function  TDocument.Get_EnvelopeVisible: WordBool;
begin
  Result := DefaultInterface.Get_EnvelopeVisible;
end;

procedure TDocument.Set_EnvelopeVisible(RetValue: WordBool);
begin
  DefaultInterface.Set_EnvelopeVisible(RetValue);
end;

function  TDocument.Get_FullName: WideString;
begin
  Result := DefaultInterface.Get_FullName;
end;

function  TDocument.Get_LayoutGuides: LayoutGuides;
begin
  Result := DefaultInterface.Get_LayoutGuides;
end;

function  TDocument.Get_MailEnvelope: IDispatch;
begin
  Result := DefaultInterface.Get_MailEnvelope;
end;

function  TDocument.Get_MailMerge: MailMerge;
begin
  Result := DefaultInterface.Get_MailMerge;
end;

function  TDocument.Get_MasterPages: MasterPages;
begin
  Result := DefaultInterface.Get_MasterPages;
end;

function  TDocument.Get_Name: WideString;
begin
  Result := DefaultInterface.Get_Name;
end;

function  TDocument.Get_Pages: Pages;
begin
  Result := DefaultInterface.Get_Pages;
end;

function  TDocument.Get_PageSetup: PageSetup;
begin
  Result := DefaultInterface.Get_PageSetup;
end;

function  TDocument.Get_Parent: IDispatch;
begin
  Result := DefaultInterface.Get_Parent;
end;

function  TDocument.Get_Path: WideString;
begin
  Result := DefaultInterface.Get_Path;
end;

function  TDocument.Get_PersonalInformationSet: PbPersonalInfoSet;
begin
  Result := DefaultInterface.Get_PersonalInformationSet;
end;

procedure TDocument.Set_PersonalInformationSet(RetValue: PbPersonalInfoSet);
begin
  DefaultInterface.Set_PersonalInformationSet(RetValue);
end;

function  TDocument.Get_Plates: Plates;
begin
  Result := DefaultInterface.Get_Plates;
end;

function  TDocument.Get_ReadOnly: WordBool;
begin
  Result := DefaultInterface.Get_ReadOnly;
end;

function  TDocument.Get_DocumentDirection: PbDirectionType;
begin
  Result := DefaultInterface.Get_DocumentDirection;
end;

procedure TDocument.Set_DocumentDirection(RetValue: PbDirectionType);
begin
  DefaultInterface.Set_DocumentDirection(RetValue);
end;

function  TDocument.Get_Saved: WordBool;
begin
  Result := DefaultInterface.Get_Saved;
end;

function  TDocument.Get_SaveFormat: PbFileFormat;
begin
  Result := DefaultInterface.Get_SaveFormat;
end;

function  TDocument.Get_ScratchArea: ScratchArea;
begin
  Result := DefaultInterface.Get_ScratchArea;
end;

function  TDocument.Get_Selection: Selection;
begin
  Result := DefaultInterface.Get_Selection;
end;

function  TDocument.Get_Stories: Stories;
begin
  Result := DefaultInterface.Get_Stories;
end;

function  TDocument.Get_Tags: Tags;
begin
  Result := DefaultInterface.Get_Tags;
end;

function  TDocument.Get_TextStyles: TextStyles;
begin
  Result := DefaultInterface.Get_TextStyles;
end;

function  TDocument.Get_ViewBoundariesAndGuides: WordBool;
begin
  Result := DefaultInterface.Get_ViewBoundariesAndGuides;
end;

procedure TDocument.Set_ViewBoundariesAndGuides(RetValue: WordBool);
begin
  DefaultInterface.Set_ViewBoundariesAndGuides(RetValue);
end;

function  TDocument.Get_ViewTwoPageSpread: WordBool;
begin
  Result := DefaultInterface.Get_ViewTwoPageSpread;
end;

procedure TDocument.Set_ViewTwoPageSpread(RetValue: WordBool);
begin
  DefaultInterface.Set_ViewTwoPageSpread(RetValue);
end;

function  TDocument.Get_Wizard: Wizard;
begin
  Result := DefaultInterface.Get_Wizard;
end;

function  TDocument.Get_ActiveView: View;
begin
  Result := DefaultInterface.Get_ActiveView;
end;

function  TDocument.Get_AdvancedPrintOptions: AdvancedPrintOptions;
begin
  Result := DefaultInterface.Get_AdvancedPrintOptions;
end;

function  TDocument.Get_BorderArts: BorderArts;
begin
  Result := DefaultInterface.Get_BorderArts;
end;

function  TDocument.Get_IsDataSourceConnected: WordBool;
begin
  Result := DefaultInterface.Get_IsDataSourceConnected;
end;

function  TDocument.Get_Find: FindReplace;
begin
  Result := DefaultInterface.Get_Find;
end;

function  TDocument.Get_UndoActionsAvailable: SYSINT;
begin
  Result := DefaultInterface.Get_UndoActionsAvailable;
end;

function  TDocument.Get_RedoActionsAvailable: SYSINT;
begin
  Result := DefaultInterface.Get_RedoActionsAvailable;
end;

function  TDocument.Get_ViewHorizontalBaseLineGuides: WordBool;
begin
  Result := DefaultInterface.Get_ViewHorizontalBaseLineGuides;
end;

procedure TDocument.Set_ViewHorizontalBaseLineGuides(RetValue: WordBool);
begin
  DefaultInterface.Set_ViewHorizontalBaseLineGuides(RetValue);
end;

function  TDocument.Get_ViewVerticalBaseLineGuides: WordBool;
begin
  Result := DefaultInterface.Get_ViewVerticalBaseLineGuides;
end;

procedure TDocument.Set_ViewVerticalBaseLineGuides(RetValue: WordBool);
begin
  DefaultInterface.Set_ViewVerticalBaseLineGuides(RetValue);
end;

function  TDocument.Get_PublicationType: PbPublicationType;
begin
  Result := DefaultInterface.Get_PublicationType;
end;

function  TDocument.Get_Sections: Sections;
begin
  Result := DefaultInterface.Get_Sections;
end;

function  TDocument.Get_WebNavigationBarSets: WebNavigationBarSets;
begin
  Result := DefaultInterface.Get_WebNavigationBarSets;
end;

function  TDocument.Get_RemovePersonalInformation: WordBool;
begin
  Result := DefaultInterface.Get_RemovePersonalInformation;
end;

procedure TDocument.Set_RemovePersonalInformation(RetValue: WordBool);
begin
  DefaultInterface.Set_RemovePersonalInformation(RetValue);
end;

function  TDocument.Get_PrintPageBackgrounds: WordBool;
begin
  Result := DefaultInterface.Get_PrintPageBackgrounds;
end;

procedure TDocument.Set_PrintPageBackgrounds(RetValue: WordBool);
begin
  DefaultInterface.Set_PrintPageBackgrounds(RetValue);
end;

function  TDocument.Get_ColorsInUse: ColorsInUse;
begin
  Result := DefaultInterface.Get_ColorsInUse;
end;

function  TDocument.Get_IsWizard: WordBool;
begin
  Result := DefaultInterface.Get_IsWizard;
end;

procedure TDocument.Close;
begin
  DefaultInterface.Close;
end;

function  TDocument.CreatePlateCollection(Mode: PbColorMode): Plates;
begin
  Result := DefaultInterface.CreatePlateCollection(Mode);
end;

procedure TDocument.EnterColorMode10(Mode: PbColorMode);
begin
  DefaultInterface.EnterColorMode10(Mode, EmptyParam);
end;

procedure TDocument.EnterColorMode10(Mode: PbColorMode; Plates: OleVariant);
begin
  DefaultInterface.EnterColorMode10(Mode, Plates);
end;

function  TDocument.FindShapesByTag(const TagName: WideString): ShapeRange;
begin
  Result := DefaultInterface.FindShapesByTag(TagName);
end;

function  TDocument.FindShapeByWizardTag(WizardTag: PbWizardTag; Instance: Integer): ShapeRange;
begin
  Result := DefaultInterface.FindShapeByWizardTag(WizardTag, Instance);
end;

procedure TDocument.PrintOut(From: Integer; To_: Integer; const PrintToFile: WideString; 
                             Copies: Integer; Collate: WordBool);
begin
  DefaultInterface.PrintOut(From, To_, PrintToFile, Copies, Collate);
end;

procedure TDocument.Save;
begin
  DefaultInterface.Save;
end;

procedure TDocument.SaveAs(Filename: OleVariant; Format: PbFileFormat; AddToRecentFiles: WordBool);
begin
  DefaultInterface.SaveAs(Filename, Format, AddToRecentFiles);
end;

procedure TDocument.SelectID(oh: SYSINT);
begin
  DefaultInterface.SelectID(oh);
end;

procedure TDocument.UndoClear;
begin
  DefaultInterface.UndoClear;
end;

procedure TDocument.UpdateOLEObjects;
begin
  DefaultInterface.UpdateOLEObjects;
end;

procedure TDocument.Undo(Count: SYSINT);
begin
  DefaultInterface.Undo(Count);
end;

procedure TDocument.Redo(Count: SYSINT);
begin
  DefaultInterface.Redo(Count);
end;

procedure TDocument.BeginCustomUndoAction(const ActionName: WideString);
begin
  DefaultInterface.BeginCustomUndoAction(ActionName);
end;

procedure TDocument.EndCustomUndoAction;
begin
  DefaultInterface.EndCustomUndoAction;
end;

procedure TDocument.WebPagePreview;
begin
  DefaultInterface.WebPagePreview;
end;

procedure TDocument.ConvertPublicationType(Value: PbPublicationType);
begin
  DefaultInterface.ConvertPublicationType(Value);
end;

procedure TDocument.EnterColorMode(Mode: PbColorMode; Plates: OleVariant; DeleteExcessInks: WordBool);
begin
  DefaultInterface.EnterColorMode(Mode, Plates, DeleteExcessInks);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDocumentProperties.Create(AServer: TDocument);
begin
  inherited Create;
  FServer := AServer;
end;

function TDocumentProperties.GetDefaultInterface: _Document;
begin
  Result := FServer.DefaultInterface;
end;

function  TDocumentProperties.Get_ActivePrinter: WideString;
begin
  Result := DefaultInterface.Get_ActivePrinter;
end;

procedure TDocumentProperties.Set_ActivePrinter(const RetValue: WideString);
begin
  DefaultInterface.Set_ActivePrinter(RetValue);
end;

function  TDocumentProperties.Get_ActiveWindow: Window;
begin
  Result := DefaultInterface.Get_ActiveWindow;
end;

function  TDocumentProperties.Get_Application: Application;
begin
  Result := DefaultInterface.Get_Application;
end;

function  TDocumentProperties.Get_ColorMode: PbColorMode;
begin
  Result := DefaultInterface.Get_ColorMode;
end;

function  TDocumentProperties.Get_ColorScheme: ColorScheme;
begin
  Result := DefaultInterface.Get_ColorScheme;
end;

procedure TDocumentProperties.Set_ColorScheme(const RetVal: ColorScheme);
begin
  DefaultInterface.Set_ColorScheme(RetVal);
end;

function  TDocumentProperties.Get_DefaultTabStop: OleVariant;
begin
  Result := DefaultInterface.Get_DefaultTabStop;
end;

procedure TDocumentProperties.Set_DefaultTabStop(RetValue: OleVariant);
begin
  DefaultInterface.Set_DefaultTabStop(RetValue);
end;

function  TDocumentProperties.Get_EnvelopeVisible: WordBool;
begin
  Result := DefaultInterface.Get_EnvelopeVisible;
end;

procedure TDocumentProperties.Set_EnvelopeVisible(RetValue: WordBool);
begin
  DefaultInterface.Set_EnvelopeVisible(RetValue);
end;

function  TDocumentProperties.Get_FullName: WideString;
begin
  Result := DefaultInterface.Get_FullName;
end;

function  TDocumentProperties.Get_LayoutGuides: LayoutGuides;
begin
  Result := DefaultInterface.Get_LayoutGuides;
end;

function  TDocumentProperties.Get_MailEnvelope: MsoEnvelope;
begin
  Result := DefaultInterface.Get_MailEnvelope;
end;

function  TDocumentProperties.Get_MailMerge: MailMerge;
begin
  Result := DefaultInterface.Get_MailMerge;
end;

function  TDocumentProperties.Get_MasterPages: MasterPages;
begin
  Result := DefaultInterface.Get_MasterPages;
end;

function  TDocumentProperties.Get_Name: WideString;
begin
  Result := DefaultInterface.Get_Name;
end;

function  TDocumentProperties.Get_Pages: Pages;
begin
  Result := DefaultInterface.Get_Pages;
end;

function  TDocumentProperties.Get_PageSetup: PageSetup;
begin
  Result := DefaultInterface.Get_PageSetup;
end;

function  TDocumentProperties.Get_Parent: IDispatch;
begin
  Result := DefaultInterface.Get_Parent;
end;

function  TDocumentProperties.Get_Path: WideString;
begin
  Result := DefaultInterface.Get_Path;
end;

function  TDocumentProperties.Get_PersonalInformationSet: PbPersonalInfoSet;
begin
  Result := DefaultInterface.Get_PersonalInformationSet;
end;

procedure TDocumentProperties.Set_PersonalInformationSet(RetValue: PbPersonalInfoSet);
begin
  DefaultInterface.Set_PersonalInformationSet(RetValue);
end;

function  TDocumentProperties.Get_Plates: Plates;
begin
  Result := DefaultInterface.Get_Plates;
end;

function  TDocumentProperties.Get_ReadOnly: WordBool;
begin
  Result := DefaultInterface.Get_ReadOnly;
end;

function  TDocumentProperties.Get_DocumentDirection: PbDirectionType;
begin
  Result := DefaultInterface.Get_DocumentDirection;
end;

procedure TDocumentProperties.Set_DocumentDirection(RetValue: PbDirectionType);
begin
  DefaultInterface.Set_DocumentDirection(RetValue);
end;

function  TDocumentProperties.Get_Saved: WordBool;
begin
  Result := DefaultInterface.Get_Saved;
end;

function  TDocumentProperties.Get_SaveFormat: PbFileFormat;
begin
  Result := DefaultInterface.Get_SaveFormat;
end;

function  TDocumentProperties.Get_ScratchArea: ScratchArea;
begin
  Result := DefaultInterface.Get_ScratchArea;
end;

function  TDocumentProperties.Get_Selection: Selection;
begin
  Result := DefaultInterface.Get_Selection;
end;

function  TDocumentProperties.Get_Stories: Stories;
begin
  Result := DefaultInterface.Get_Stories;
end;

function  TDocumentProperties.Get_Tags: Tags;
begin
  Result := DefaultInterface.Get_Tags;
end;

function  TDocumentProperties.Get_TextStyles: TextStyles;
begin
  Result := DefaultInterface.Get_TextStyles;
end;

function  TDocumentProperties.Get_ViewBoundariesAndGuides: WordBool;
begin
  Result := DefaultInterface.Get_ViewBoundariesAndGuides;
end;

procedure TDocumentProperties.Set_ViewBoundariesAndGuides(RetValue: WordBool);
begin
  DefaultInterface.Set_ViewBoundariesAndGuides(RetValue);
end;

function  TDocumentProperties.Get_ViewTwoPageSpread: WordBool;
begin
  Result := DefaultInterface.Get_ViewTwoPageSpread;
end;

procedure TDocumentProperties.Set_ViewTwoPageSpread(RetValue: WordBool);
begin
  DefaultInterface.Set_ViewTwoPageSpread(RetValue);
end;

function  TDocumentProperties.Get_Wizard: Wizard;
begin
  Result := DefaultInterface.Get_Wizard;
end;

function  TDocumentProperties.Get_ActiveView: View;
begin
  Result := DefaultInterface.Get_ActiveView;
end;

function  TDocumentProperties.Get_AdvancedPrintOptions: AdvancedPrintOptions;
begin
  Result := DefaultInterface.Get_AdvancedPrintOptions;
end;

function  TDocumentProperties.Get_BorderArts: BorderArts;
begin
  Result := DefaultInterface.Get_BorderArts;
end;

function  TDocumentProperties.Get_IsDataSourceConnected: WordBool;
begin
  Result := DefaultInterface.Get_IsDataSourceConnected;
end;

function  TDocumentProperties.Get_Find: FindReplace;
begin
  Result := DefaultInterface.Get_Find;
end;

function  TDocumentProperties.Get_UndoActionsAvailable: SYSINT;
begin
  Result := DefaultInterface.Get_UndoActionsAvailable;
end;

function  TDocumentProperties.Get_RedoActionsAvailable: SYSINT;
begin
  Result := DefaultInterface.Get_RedoActionsAvailable;
end;

function  TDocumentProperties.Get_ViewHorizontalBaseLineGuides: WordBool;
begin
  Result := DefaultInterface.Get_ViewHorizontalBaseLineGuides;
end;

procedure TDocumentProperties.Set_ViewHorizontalBaseLineGuides(RetValue: WordBool);
begin
  DefaultInterface.Set_ViewHorizontalBaseLineGuides(RetValue);
end;

function  TDocumentProperties.Get_ViewVerticalBaseLineGuides: WordBool;
begin
  Result := DefaultInterface.Get_ViewVerticalBaseLineGuides;
end;

procedure TDocumentProperties.Set_ViewVerticalBaseLineGuides(RetValue: WordBool);
begin
  DefaultInterface.Set_ViewVerticalBaseLineGuides(RetValue);
end;

function  TDocumentProperties.Get_PublicationType: PbPublicationType;
begin
  Result := DefaultInterface.Get_PublicationType;
end;

function  TDocumentProperties.Get_Sections: Sections;
begin
  Result := DefaultInterface.Get_Sections;
end;

function  TDocumentProperties.Get_WebNavigationBarSets: WebNavigationBarSets;
begin
  Result := DefaultInterface.Get_WebNavigationBarSets;
end;

function  TDocumentProperties.Get_RemovePersonalInformation: WordBool;
begin
  Result := DefaultInterface.Get_RemovePersonalInformation;
end;

procedure TDocumentProperties.Set_RemovePersonalInformation(RetValue: WordBool);
begin
  DefaultInterface.Set_RemovePersonalInformation(RetValue);
end;

function  TDocumentProperties.Get_PrintPageBackgrounds: WordBool;
begin
  Result := DefaultInterface.Get_PrintPageBackgrounds;
end;

procedure TDocumentProperties.Set_PrintPageBackgrounds(RetValue: WordBool);
begin
  DefaultInterface.Set_PrintPageBackgrounds(RetValue);
end;

function  TDocumentProperties.Get_ColorsInUse: ColorsInUse;
begin
  Result := DefaultInterface.Get_ColorsInUse;
end;

function  TDocumentProperties.Get_IsWizard: WordBool;
begin
  Result := DefaultInterface.Get_IsWizard;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents('ActiveX',[TApplication, TDocument]);
end;

end.
