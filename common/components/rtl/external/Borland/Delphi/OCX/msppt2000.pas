unit MSPpt2000;

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
// File generated on 6/19/2002 9:57:32 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: d:\source\delphi.latest\typelib\typelib\typelibraries\msppt9.olb (1)
// LIBID: {91493440-5A91-11CF-8700-00AA0060263B}
// LCID: 0
// Helpfile: d:\source\delphi.latest\typelib\typelib\typelibraries\VBAPPT9.CHM
// HelpString: Microsoft PowerPoint 9.0 Object Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v2.1 Office, (C:\Program Files\Microsoft Office\Office\MSO9.DLL)
//   (3) v5.3 VBIDE, (C:\Program Files\Common Files\Microsoft Shared\VBA\VBA6\VBE6EXT.OLB)
// Errors:
//   Hint: Symbol 'Application' renamed to 'PowerPointApplication'
//   Hint: Symbol 'Global' renamed to 'PowerPointGlobal'
//   Hint: Symbol 'Presentation' renamed to 'PowerPointPresentation'
//   Hint: Symbol 'Slide' renamed to 'PowerPointSlide'
//   Hint: Symbol 'OLEControl' renamed to 'OLECtrl'
//   Hint: Parameter 'Type' of _Application.FileDialog changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of ColorFormat.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of Selection.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of View.Type changed to 'Type_'
//   Hint: Parameter 'End' of PrintRanges.Add changed to 'End_'
//   Hint: Member 'End' of 'PrintRange' changed to 'End_'
//   Hint: Parameter 'End' of PrintRange.End changed to 'End_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of Hyperlink.Type changed to 'Type_'
//   Hint: Parameter 'Type' of ExtraColors.Add changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of SoundEffect.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of SoundEffect.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of SoundFormat.Type changed to 'Type_'
//   Hint: Parameter 'Type' of Shapes.AddCallout changed to 'Type_'
//   Hint: Parameter 'Type' of Shapes.AddConnector changed to 'Type_'
//   Hint: Parameter 'Label' of Shapes.AddLabel changed to 'Label_'
//   Hint: Parameter 'Type' of Shapes.AddShape changed to 'Type_'
//   Hint: Parameter 'Type' of Shapes.AddPlaceholder changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of PlaceholderFormat.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of Shape.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of ShapeRange.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of FillFormat.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of ShadowFormat.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of ShadowFormat.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of ConnectorFormat.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of ConnectorFormat.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of CalloutFormat.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of CalloutFormat.Type changed to 'Type_'
//   Hint: Member 'Object' of 'OLEFormat' changed to 'Object_'
//   Hint: Parameter 'Object' of OLEFormat.Object changed to 'Object_'
//   Hint: Parameter 'Type' of TextRange.ChangeCase changed to 'Type_'
//   Hint: Parameter 'Type' of TabStops.Add changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of TabStop.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of TabStop.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of BulletFormat.Type changed to 'Type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of BulletFormat.Type changed to 'Type_'
//   Hint: Parameter 'Type' of TextStyles.Item changed to 'Type_'
//   Hint: Parameter 'To' of _Presentation.PrintOut changed to 'To_'
//   Hint: Parameter 'Type' of PPDialogs.RunCharacterAlert changed to 'Type_'
//   Hint: Parameter 'Type' of PPAlert.Run changed to 'Type_'
//   Hint: Member 'Label' of 'PPControl' changed to 'Label_'
//   Hint: Parameter 'Label' of PPControl.Label changed to 'Label_'
//   Hint: Parameter 'Label' of PPControl.Label changed to 'Label_'
//   Hint: Parameter 'String' of PPStrings.Add changed to 'String_'
//   Hint: Parameter 'String' of PPStrings.Insert changed to 'String_'
//   Hint: Symbol 'Application' renamed to 'PowerPointApplication'
//   Hint: Symbol 'Global' renamed to 'PowerPointGlobal'
//   Hint: Symbol 'Presentation' renamed to 'PowerPointPresentation'
//   Hint: Symbol 'Slide' renamed to 'PowerPointSlide'
//   Hint: Symbol 'OLEControl' renamed to 'OLECtrl'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Member 'End' of 'PrintRange' changed to 'End_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Member 'Object' of 'OLEFormat' changed to 'Object_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Member 'Label' of 'PPControl' changed to 'Label_'
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
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, Office2000, OleServer, StdVCL, Variants, 
VBIDE2000;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  PowerPointMajorVersion = 2;
  PowerPointMinorVersion = 6;

  LIBID_PowerPoint: TGUID = '{91493440-5A91-11CF-8700-00AA0060263B}';

  IID_Collection: TGUID = '{91493450-5A91-11CF-8700-00AA0060263B}';
  IID__Application: TGUID = '{91493442-5A91-11CF-8700-00AA0060263B}';
  IID__Global: TGUID = '{91493451-5A91-11CF-8700-00AA0060263B}';
  IID_EApplication: TGUID = '{914934C2-5A91-11CF-8700-00AA0060263B}';
  CLASS_PowerPointGlobal: TGUID = '{91493443-5A91-11CF-8700-00AA0060263B}';
  IID_ColorFormat: TGUID = '{91493452-5A91-11CF-8700-00AA0060263B}';
  IID_SlideShowWindow: TGUID = '{91493453-5A91-11CF-8700-00AA0060263B}';
  IID_Selection: TGUID = '{91493454-5A91-11CF-8700-00AA0060263B}';
  IID_DocumentWindows: TGUID = '{91493455-5A91-11CF-8700-00AA0060263B}';
  IID_SlideShowWindows: TGUID = '{91493456-5A91-11CF-8700-00AA0060263B}';
  IID_DocumentWindow: TGUID = '{91493457-5A91-11CF-8700-00AA0060263B}';
  IID_View: TGUID = '{91493458-5A91-11CF-8700-00AA0060263B}';
  IID_SlideShowView: TGUID = '{91493459-5A91-11CF-8700-00AA0060263B}';
  IID_SlideShowSettings: TGUID = '{9149345A-5A91-11CF-8700-00AA0060263B}';
  IID_NamedSlideShows: TGUID = '{9149345B-5A91-11CF-8700-00AA0060263B}';
  IID_NamedSlideShow: TGUID = '{9149345C-5A91-11CF-8700-00AA0060263B}';
  IID_PrintOptions: TGUID = '{9149345D-5A91-11CF-8700-00AA0060263B}';
  IID_PrintRanges: TGUID = '{9149345E-5A91-11CF-8700-00AA0060263B}';
  IID_PrintRange: TGUID = '{9149345F-5A91-11CF-8700-00AA0060263B}';
  IID_AddIns: TGUID = '{91493460-5A91-11CF-8700-00AA0060263B}';
  IID_AddIn: TGUID = '{91493461-5A91-11CF-8700-00AA0060263B}';
  IID_Presentations: TGUID = '{91493462-5A91-11CF-8700-00AA0060263B}';
  IID_PresEvents: TGUID = '{91493463-5A91-11CF-8700-00AA0060263B}';
  IID__Presentation: TGUID = '{9149349D-5A91-11CF-8700-00AA0060263B}';
  IID_Hyperlinks: TGUID = '{91493464-5A91-11CF-8700-00AA0060263B}';
  IID_Hyperlink: TGUID = '{91493465-5A91-11CF-8700-00AA0060263B}';
  IID_PageSetup: TGUID = '{91493466-5A91-11CF-8700-00AA0060263B}';
  IID_Fonts: TGUID = '{91493467-5A91-11CF-8700-00AA0060263B}';
  IID_ExtraColors: TGUID = '{91493468-5A91-11CF-8700-00AA0060263B}';
  IID_Slides: TGUID = '{91493469-5A91-11CF-8700-00AA0060263B}';
  IID__Slide: TGUID = '{9149346A-5A91-11CF-8700-00AA0060263B}';
  IID_SlideRange: TGUID = '{9149346B-5A91-11CF-8700-00AA0060263B}';
  IID__Master: TGUID = '{9149346C-5A91-11CF-8700-00AA0060263B}';
  IID_SldEvents: TGUID = '{9149346D-5A91-11CF-8700-00AA0060263B}';
  CLASS_PowerPointSlide: TGUID = '{91493445-5A91-11CF-8700-00AA0060263B}';
  IID_ColorSchemes: TGUID = '{9149346E-5A91-11CF-8700-00AA0060263B}';
  IID_ColorScheme: TGUID = '{9149346F-5A91-11CF-8700-00AA0060263B}';
  IID_RGBColor: TGUID = '{91493470-5A91-11CF-8700-00AA0060263B}';
  IID_SlideShowTransition: TGUID = '{91493471-5A91-11CF-8700-00AA0060263B}';
  IID_SoundEffect: TGUID = '{91493472-5A91-11CF-8700-00AA0060263B}';
  IID_SoundFormat: TGUID = '{91493473-5A91-11CF-8700-00AA0060263B}';
  IID_HeadersFooters: TGUID = '{91493474-5A91-11CF-8700-00AA0060263B}';
  IID_Shapes: TGUID = '{91493475-5A91-11CF-8700-00AA0060263B}';
  IID_Placeholders: TGUID = '{91493476-5A91-11CF-8700-00AA0060263B}';
  IID_PlaceholderFormat: TGUID = '{91493477-5A91-11CF-8700-00AA0060263B}';
  IID_FreeformBuilder: TGUID = '{91493478-5A91-11CF-8700-00AA0060263B}';
  IID_Shape: TGUID = '{91493479-5A91-11CF-8700-00AA0060263B}';
  IID_ShapeRange: TGUID = '{9149347A-5A91-11CF-8700-00AA0060263B}';
  IID_GroupShapes: TGUID = '{9149347B-5A91-11CF-8700-00AA0060263B}';
  IID_Adjustments: TGUID = '{9149347C-5A91-11CF-8700-00AA0060263B}';
  IID_PictureFormat: TGUID = '{9149347D-5A91-11CF-8700-00AA0060263B}';
  IID_FillFormat: TGUID = '{9149347E-5A91-11CF-8700-00AA0060263B}';
  IID_LineFormat: TGUID = '{9149347F-5A91-11CF-8700-00AA0060263B}';
  IID_ShadowFormat: TGUID = '{91493480-5A91-11CF-8700-00AA0060263B}';
  IID_ConnectorFormat: TGUID = '{91493481-5A91-11CF-8700-00AA0060263B}';
  IID_TextEffectFormat: TGUID = '{91493482-5A91-11CF-8700-00AA0060263B}';
  IID_ThreeDFormat: TGUID = '{91493483-5A91-11CF-8700-00AA0060263B}';
  IID_TextFrame: TGUID = '{91493484-5A91-11CF-8700-00AA0060263B}';
  IID_CalloutFormat: TGUID = '{91493485-5A91-11CF-8700-00AA0060263B}';
  IID_ShapeNodes: TGUID = '{91493486-5A91-11CF-8700-00AA0060263B}';
  IID_ShapeNode: TGUID = '{91493487-5A91-11CF-8700-00AA0060263B}';
  IID_OLEFormat: TGUID = '{91493488-5A91-11CF-8700-00AA0060263B}';
  IID_LinkFormat: TGUID = '{91493489-5A91-11CF-8700-00AA0060263B}';
  IID_ObjectVerbs: TGUID = '{9149348A-5A91-11CF-8700-00AA0060263B}';
  IID_AnimationSettings: TGUID = '{9149348B-5A91-11CF-8700-00AA0060263B}';
  IID_ActionSettings: TGUID = '{9149348C-5A91-11CF-8700-00AA0060263B}';
  IID_ActionSetting: TGUID = '{9149348D-5A91-11CF-8700-00AA0060263B}';
  IID_PlaySettings: TGUID = '{9149348E-5A91-11CF-8700-00AA0060263B}';
  IID_TextRange: TGUID = '{9149348F-5A91-11CF-8700-00AA0060263B}';
  IID_Ruler: TGUID = '{91493490-5A91-11CF-8700-00AA0060263B}';
  IID_RulerLevels: TGUID = '{91493491-5A91-11CF-8700-00AA0060263B}';
  IID_RulerLevel: TGUID = '{91493492-5A91-11CF-8700-00AA0060263B}';
  IID_TabStops: TGUID = '{91493493-5A91-11CF-8700-00AA0060263B}';
  IID_TabStop: TGUID = '{91493494-5A91-11CF-8700-00AA0060263B}';
  IID_Font: TGUID = '{91493495-5A91-11CF-8700-00AA0060263B}';
  IID_ParagraphFormat: TGUID = '{91493496-5A91-11CF-8700-00AA0060263B}';
  IID_BulletFormat: TGUID = '{91493497-5A91-11CF-8700-00AA0060263B}';
  IID_TextStyles: TGUID = '{91493498-5A91-11CF-8700-00AA0060263B}';
  IID_TextStyle: TGUID = '{91493499-5A91-11CF-8700-00AA0060263B}';
  IID_TextStyleLevels: TGUID = '{9149349A-5A91-11CF-8700-00AA0060263B}';
  IID_TextStyleLevel: TGUID = '{9149349B-5A91-11CF-8700-00AA0060263B}';
  IID_HeaderFooter: TGUID = '{9149349C-5A91-11CF-8700-00AA0060263B}';
  CLASS_PowerPointPresentation: TGUID = '{91493444-5A91-11CF-8700-00AA0060263B}';
  IID_PPDialogs: TGUID = '{9149349E-5A91-11CF-8700-00AA0060263B}';
  IID_PPAlert: TGUID = '{9149349F-5A91-11CF-8700-00AA0060263B}';
  IID_PPDialog: TGUID = '{914934A0-5A91-11CF-8700-00AA0060263B}';
  IID_PPTabSheet: TGUID = '{914934A1-5A91-11CF-8700-00AA0060263B}';
  IID_PPControls: TGUID = '{914934A2-5A91-11CF-8700-00AA0060263B}';
  IID_PPTabSheets: TGUID = '{914934A3-5A91-11CF-8700-00AA0060263B}';
  IID_PPControl: TGUID = '{914934A4-5A91-11CF-8700-00AA0060263B}';
  IID_PPPushButton: TGUID = '{914934A5-5A91-11CF-8700-00AA0060263B}';
  IID_PPToggleButton: TGUID = '{914934A6-5A91-11CF-8700-00AA0060263B}';
  IID_PPBitmapButton: TGUID = '{914934A7-5A91-11CF-8700-00AA0060263B}';
  IID_PPListBox: TGUID = '{914934A8-5A91-11CF-8700-00AA0060263B}';
  IID_PPStrings: TGUID = '{914934A9-5A91-11CF-8700-00AA0060263B}';
  IID_PPCheckBox: TGUID = '{914934AA-5A91-11CF-8700-00AA0060263B}';
  IID_PPRadioCluster: TGUID = '{914934AB-5A91-11CF-8700-00AA0060263B}';
  IID_PPStaticText: TGUID = '{914934AC-5A91-11CF-8700-00AA0060263B}';
  IID_PPEditText: TGUID = '{914934AD-5A91-11CF-8700-00AA0060263B}';
  IID_PPIcon: TGUID = '{914934AE-5A91-11CF-8700-00AA0060263B}';
  IID_PPBitmap: TGUID = '{914934AF-5A91-11CF-8700-00AA0060263B}';
  IID_PPSpinner: TGUID = '{914934B0-5A91-11CF-8700-00AA0060263B}';
  IID_PPScrollBar: TGUID = '{914934B1-5A91-11CF-8700-00AA0060263B}';
  IID_PPGroupBox: TGUID = '{914934B2-5A91-11CF-8700-00AA0060263B}';
  IID_PPFrame: TGUID = '{914934B3-5A91-11CF-8700-00AA0060263B}';
  IID_PPTabControl: TGUID = '{914934B4-5A91-11CF-8700-00AA0060263B}';
  IID_PPDropDown: TGUID = '{914934B5-5A91-11CF-8700-00AA0060263B}';
  IID_PPDropDownEdit: TGUID = '{914934B6-5A91-11CF-8700-00AA0060263B}';
  IID_PPSlideMiniature: TGUID = '{914934B7-5A91-11CF-8700-00AA0060263B}';
  IID_PPRadioButton: TGUID = '{914934B8-5A91-11CF-8700-00AA0060263B}';
  IID_Tags: TGUID = '{914934B9-5A91-11CF-8700-00AA0060263B}';
  IID_FileDialogFileList: TGUID = '{914934BA-5A91-11CF-8700-00AA0060263B}';
  IID_FileDialogExtension: TGUID = '{914934BB-5A91-11CF-8700-00AA0060263B}';
  IID_FileDialogExtensionList: TGUID = '{914934BC-5A91-11CF-8700-00AA0060263B}';
  IID_FileDialog: TGUID = '{914934BD-5A91-11CF-8700-00AA0060263B}';
  IID_MouseTracker: TGUID = '{914934BE-5A91-11CF-8700-00AA0060263B}';
  IID_MouseDownHandler: TGUID = '{914934BF-5A91-11CF-8700-00AA0060263B}';
  IID_OCXExtender: TGUID = '{914934C0-5A91-11CF-8700-00AA0060263B}';
  IID_OCXExtenderEvents: TGUID = '{914934C1-5A91-11CF-8700-00AA0060263B}';
  CLASS_OLECtrl: TGUID = '{91493446-5A91-11CF-8700-00AA0060263B}';
  CLASS_PowerPointApplication: TGUID = '{91493441-5A91-11CF-8700-00AA0060263B}';
  IID_Table: TGUID = '{914934C3-5A91-11CF-8700-00AA0060263B}';
  IID_Columns: TGUID = '{914934C4-5A91-11CF-8700-00AA0060263B}';
  IID_Column: TGUID = '{914934C5-5A91-11CF-8700-00AA0060263B}';
  IID_Rows: TGUID = '{914934C6-5A91-11CF-8700-00AA0060263B}';
  IID_Row: TGUID = '{914934C7-5A91-11CF-8700-00AA0060263B}';
  IID_CellRange: TGUID = '{914934C8-5A91-11CF-8700-00AA0060263B}';
  IID_Cell: TGUID = '{914934C9-5A91-11CF-8700-00AA0060263B}';
  IID_Borders: TGUID = '{914934CA-5A91-11CF-8700-00AA0060263B}';
  IID_Panes: TGUID = '{914934CB-5A91-11CF-8700-00AA0060263B}';
  IID_Pane: TGUID = '{914934CC-5A91-11CF-8700-00AA0060263B}';
  IID_DefaultWebOptions: TGUID = '{914934CD-5A91-11CF-8700-00AA0060263B}';
  IID_WebOptions: TGUID = '{914934CE-5A91-11CF-8700-00AA0060263B}';
  IID_PublishObjects: TGUID = '{914934CF-5A91-11CF-8700-00AA0060263B}';
  IID_PublishObject: TGUID = '{914934D0-5A91-11CF-8700-00AA0060263B}';
  IID_Marker: TGUID = '{914934D1-5A91-11CF-8700-00AA0060263B}';
  IID_MasterEvents: TGUID = '{914934D2-5A91-11CF-8700-00AA0060263B}';
  CLASS_Master: TGUID = '{91493447-5A91-11CF-8700-00AA0060263B}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum PpWindowState
type
  PpWindowState = TOleEnum;
const
  ppWindowNormal = $00000001;
  ppWindowMinimized = $00000002;
  ppWindowMaximized = $00000003;

// Constants for enum PpArrangeStyle
type
  PpArrangeStyle = TOleEnum;
const
  ppArrangeTiled = $00000001;
  ppArrangeCascade = $00000002;

// Constants for enum PpViewType
type
  PpViewType = TOleEnum;
const
  ppViewSlide = $00000001;
  ppViewSlideMaster = $00000002;
  ppViewNotesPage = $00000003;
  ppViewHandoutMaster = $00000004;
  ppViewNotesMaster = $00000005;
  ppViewOutline = $00000006;
  ppViewSlideSorter = $00000007;
  ppViewTitleMaster = $00000008;
  ppViewNormal = $00000009;

// Constants for enum PpColorSchemeIndex
type
  PpColorSchemeIndex = TOleEnum;
const
  ppSchemeColorMixed = $FFFFFFFE;
  ppNotSchemeColor = $00000000;
  ppBackground = $00000001;
  ppForeground = $00000002;
  ppShadow = $00000003;
  ppTitle = $00000004;
  ppFill = $00000005;
  ppAccent1 = $00000006;
  ppAccent2 = $00000007;
  ppAccent3 = $00000008;

// Constants for enum PpSlideSizeType
type
  PpSlideSizeType = TOleEnum;
const
  ppSlideSizeOnScreen = $00000001;
  ppSlideSizeLetterPaper = $00000002;
  ppSlideSizeA4Paper = $00000003;
  ppSlideSize35MM = $00000004;
  ppSlideSizeOverhead = $00000005;
  ppSlideSizeBanner = $00000006;
  ppSlideSizeCustom = $00000007;

// Constants for enum PpSaveAsFileType
type
  PpSaveAsFileType = TOleEnum;
const
  ppSaveAsPresentation = $00000001;
  ppSaveAsPowerPoint7 = $00000002;
  ppSaveAsPowerPoint4 = $00000003;
  ppSaveAsPowerPoint3 = $00000004;
  ppSaveAsTemplate = $00000005;
  ppSaveAsRTF = $00000006;
  ppSaveAsShow = $00000007;
  ppSaveAsAddIn = $00000008;
  ppSaveAsPowerPoint4FarEast = $0000000A;
  ppSaveAsDefault = $0000000B;
  ppSaveAsHTML = $0000000C;
  ppSaveAsHTMLv3 = $0000000D;
  ppSaveAsHTMLDual = $0000000E;
  ppSaveAsMetaFile = $0000000F;
  ppSaveAsGIF = $00000010;
  ppSaveAsJPG = $00000011;
  ppSaveAsPNG = $00000012;
  ppSaveAsBMP = $00000013;

// Constants for enum PpTextStyleType
type
  PpTextStyleType = TOleEnum;
const
  ppDefaultStyle = $00000001;
  ppTitleStyle = $00000002;
  ppBodyStyle = $00000003;

// Constants for enum PpSlideLayout
type
  PpSlideLayout = TOleEnum;
const
  ppLayoutMixed = $FFFFFFFE;
  ppLayoutTitle = $00000001;
  ppLayoutText = $00000002;
  ppLayoutTwoColumnText = $00000003;
  ppLayoutTable = $00000004;
  ppLayoutTextAndChart = $00000005;
  ppLayoutChartAndText = $00000006;
  ppLayoutOrgchart = $00000007;
  ppLayoutChart = $00000008;
  ppLayoutTextAndClipart = $00000009;
  ppLayoutClipartAndText = $0000000A;
  ppLayoutTitleOnly = $0000000B;
  ppLayoutBlank = $0000000C;
  ppLayoutTextAndObject = $0000000D;
  ppLayoutObjectAndText = $0000000E;
  ppLayoutLargeObject = $0000000F;
  ppLayoutObject = $00000010;
  ppLayoutTextAndMediaClip = $00000011;
  ppLayoutMediaClipAndText = $00000012;
  ppLayoutObjectOverText = $00000013;
  ppLayoutTextOverObject = $00000014;
  ppLayoutTextAndTwoObjects = $00000015;
  ppLayoutTwoObjectsAndText = $00000016;
  ppLayoutTwoObjectsOverText = $00000017;
  ppLayoutFourObjects = $00000018;
  ppLayoutVerticalText = $00000019;
  ppLayoutClipArtAndVerticalText = $0000001A;
  ppLayoutVerticalTitleAndText = $0000001B;
  ppLayoutVerticalTitleAndTextOverChart = $0000001C;

// Constants for enum PpEntryEffect
type
  PpEntryEffect = TOleEnum;
const
  ppEffectMixed = $FFFFFFFE;
  ppEffectNone = $00000000;
  ppEffectCut = $00000101;
  ppEffectCutThroughBlack = $00000102;
  ppEffectRandom = $00000201;
  ppEffectBlindsHorizontal = $00000301;
  ppEffectBlindsVertical = $00000302;
  ppEffectCheckerboardAcross = $00000401;
  ppEffectCheckerboardDown = $00000402;
  ppEffectCoverLeft = $00000501;
  ppEffectCoverUp = $00000502;
  ppEffectCoverRight = $00000503;
  ppEffectCoverDown = $00000504;
  ppEffectCoverLeftUp = $00000505;
  ppEffectCoverRightUp = $00000506;
  ppEffectCoverLeftDown = $00000507;
  ppEffectCoverRightDown = $00000508;
  ppEffectDissolve = $00000601;
  ppEffectFade = $00000701;
  ppEffectUncoverLeft = $00000801;
  ppEffectUncoverUp = $00000802;
  ppEffectUncoverRight = $00000803;
  ppEffectUncoverDown = $00000804;
  ppEffectUncoverLeftUp = $00000805;
  ppEffectUncoverRightUp = $00000806;
  ppEffectUncoverLeftDown = $00000807;
  ppEffectUncoverRightDown = $00000808;
  ppEffectRandomBarsHorizontal = $00000901;
  ppEffectRandomBarsVertical = $00000902;
  ppEffectStripsUpLeft = $00000A01;
  ppEffectStripsUpRight = $00000A02;
  ppEffectStripsDownLeft = $00000A03;
  ppEffectStripsDownRight = $00000A04;
  ppEffectStripsLeftUp = $00000A05;
  ppEffectStripsRightUp = $00000A06;
  ppEffectStripsLeftDown = $00000A07;
  ppEffectStripsRightDown = $00000A08;
  ppEffectWipeLeft = $00000B01;
  ppEffectWipeUp = $00000B02;
  ppEffectWipeRight = $00000B03;
  ppEffectWipeDown = $00000B04;
  ppEffectBoxOut = $00000C01;
  ppEffectBoxIn = $00000C02;
  ppEffectFlyFromLeft = $00000D01;
  ppEffectFlyFromTop = $00000D02;
  ppEffectFlyFromRight = $00000D03;
  ppEffectFlyFromBottom = $00000D04;
  ppEffectFlyFromTopLeft = $00000D05;
  ppEffectFlyFromTopRight = $00000D06;
  ppEffectFlyFromBottomLeft = $00000D07;
  ppEffectFlyFromBottomRight = $00000D08;
  ppEffectPeekFromLeft = $00000D09;
  ppEffectPeekFromDown = $00000D0A;
  ppEffectPeekFromRight = $00000D0B;
  ppEffectPeekFromUp = $00000D0C;
  ppEffectCrawlFromLeft = $00000D0D;
  ppEffectCrawlFromUp = $00000D0E;
  ppEffectCrawlFromRight = $00000D0F;
  ppEffectCrawlFromDown = $00000D10;
  ppEffectZoomIn = $00000D11;
  ppEffectZoomInSlightly = $00000D12;
  ppEffectZoomOut = $00000D13;
  ppEffectZoomOutSlightly = $00000D14;
  ppEffectZoomCenter = $00000D15;
  ppEffectZoomBottom = $00000D16;
  ppEffectStretchAcross = $00000D17;
  ppEffectStretchLeft = $00000D18;
  ppEffectStretchUp = $00000D19;
  ppEffectStretchRight = $00000D1A;
  ppEffectStretchDown = $00000D1B;
  ppEffectSwivel = $00000D1C;
  ppEffectSpiral = $00000D1D;
  ppEffectSplitHorizontalOut = $00000E01;
  ppEffectSplitHorizontalIn = $00000E02;
  ppEffectSplitVerticalOut = $00000E03;
  ppEffectSplitVerticalIn = $00000E04;
  ppEffectFlashOnceFast = $00000F01;
  ppEffectFlashOnceMedium = $00000F02;
  ppEffectFlashOnceSlow = $00000F03;
  ppEffectAppear = $00000F04;

// Constants for enum PpTextLevelEffect
type
  PpTextLevelEffect = TOleEnum;
const
  ppAnimateLevelMixed = $FFFFFFFE;
  ppAnimateLevelNone = $00000000;
  ppAnimateByFirstLevel = $00000001;
  ppAnimateBySecondLevel = $00000002;
  ppAnimateByThirdLevel = $00000003;
  ppAnimateByFourthLevel = $00000004;
  ppAnimateByFifthLevel = $00000005;
  ppAnimateByAllLevels = $00000010;

// Constants for enum PpTextUnitEffect
type
  PpTextUnitEffect = TOleEnum;
const
  ppAnimateUnitMixed = $FFFFFFFE;
  ppAnimateByParagraph = $00000000;
  ppAnimateByWord = $00000001;
  ppAnimateByCharacter = $00000002;

// Constants for enum PpChartUnitEffect
type
  PpChartUnitEffect = TOleEnum;
const
  ppAnimateChartMixed = $FFFFFFFE;
  ppAnimateBySeries = $00000001;
  ppAnimateByCategory = $00000002;
  ppAnimateBySeriesElements = $00000003;
  ppAnimateByCategoryElements = $00000004;

// Constants for enum PpAfterEffect
type
  PpAfterEffect = TOleEnum;
const
  ppAfterEffectMixed = $FFFFFFFE;
  ppAfterEffectNothing = $00000000;
  ppAfterEffectHide = $00000001;
  ppAfterEffectDim = $00000002;
  ppAfterEffectHideOnClick = $00000003;

// Constants for enum PpAdvanceMode
type
  PpAdvanceMode = TOleEnum;
const
  ppAdvanceModeMixed = $FFFFFFFE;
  ppAdvanceOnClick = $00000001;
  ppAdvanceOnTime = $00000002;

// Constants for enum PpSoundEffectType
type
  PpSoundEffectType = TOleEnum;
const
  ppSoundEffectsMixed = $FFFFFFFE;
  ppSoundNone = $00000000;
  ppSoundStopPrevious = $00000001;
  ppSoundFile = $00000002;

// Constants for enum PpFollowColors
type
  PpFollowColors = TOleEnum;
const
  ppFollowColorsMixed = $FFFFFFFE;
  ppFollowColorsNone = $00000000;
  ppFollowColorsScheme = $00000001;
  ppFollowColorsTextAndBackground = $00000002;

// Constants for enum PpUpdateOption
type
  PpUpdateOption = TOleEnum;
const
  ppUpdateOptionMixed = $FFFFFFFE;
  ppUpdateOptionManual = $00000001;
  ppUpdateOptionAutomatic = $00000002;

// Constants for enum PpParagraphAlignment
type
  PpParagraphAlignment = TOleEnum;
const
  ppAlignmentMixed = $FFFFFFFE;
  ppAlignLeft = $00000001;
  ppAlignCenter = $00000002;
  ppAlignRight = $00000003;
  ppAlignJustify = $00000004;
  ppAlignDistribute = $00000005;

// Constants for enum PpBaselineAlignment
type
  PpBaselineAlignment = TOleEnum;
const
  ppBaselineAlignMixed = $FFFFFFFE;
  ppBaselineAlignBaseline = $00000001;
  ppBaselineAlignTop = $00000002;
  ppBaselineAlignCenter = $00000003;
  ppBaselineAlignFarEast50 = $00000004;

// Constants for enum PpTabStopType
type
  PpTabStopType = TOleEnum;
const
  ppTabStopMixed = $FFFFFFFE;
  ppTabStopLeft = $00000001;
  ppTabStopCenter = $00000002;
  ppTabStopRight = $00000003;
  ppTabStopDecimal = $00000004;

// Constants for enum PpIndentControl
type
  PpIndentControl = TOleEnum;
const
  ppIndentControlMixed = $FFFFFFFE;
  ppIndentReplaceAttr = $00000001;
  ppIndentKeepAttr = $00000002;

// Constants for enum PpChangeCase
type
  PpChangeCase = TOleEnum;
const
  ppCaseSentence = $00000001;
  ppCaseLower = $00000002;
  ppCaseUpper = $00000003;
  ppCaseTitle = $00000004;
  ppCaseToggle = $00000005;

// Constants for enum PpDialogMode
type
  PpDialogMode = TOleEnum;
const
  ppDialogModeMixed = $FFFFFFFE;
  ppDialogModeless = $00000000;
  ppDialogModal = $00000001;

// Constants for enum PpDialogStyle
type
  PpDialogStyle = TOleEnum;
const
  ppDialogStyleMixed = $FFFFFFFE;
  ppDialogStandard = $00000001;
  ppDialogTabbed = $00000002;

// Constants for enum PpDialogPositioning
type
  PpDialogPositioning = TOleEnum;
const
  ppDialogPositionNormal = $00000001;
  ppDialogPositionCenterParent = $00000002;
  ppDialogPositionCenterScreen = $00000003;
  ppDialogPositionRememberLast = $00000004;

// Constants for enum PpDialogFontStyle
type
  PpDialogFontStyle = TOleEnum;
const
  ppDialogFontStyleMixed = $FFFFFFFE;
  ppDialogSmall = $FFFFFFFF;
  ppDialogItalic = $00000000;

// Constants for enum PpScrollBarStyle
type
  PpScrollBarStyle = TOleEnum;
const
  ppScrollBarVertical = $00000000;
  ppScrollBarHorizontal = $00000001;

// Constants for enum PpListBoxSelectionStyle
type
  PpListBoxSelectionStyle = TOleEnum;
const
  ppListBoxSingle = $00000000;
  ppListBoxMulti = $00000001;

// Constants for enum PpListBoxAbbreviationStyle
type
  PpListBoxAbbreviationStyle = TOleEnum;
const
  ppListBoxAbbreviationNone = $00000000;
  ppListBoxAbbreviationTruncation = $00000001;
  ppListBoxAbbreviationTruncationWithEllipsis = $00000002;
  ppListBoxAbbreviationFileNames = $00000003;

// Constants for enum PpAlertType
type
  PpAlertType = TOleEnum;
const
  ppAlertTypeOK = $00000000;
  ppAlertTypeOKCANCEL = $00000001;
  ppAlertTypeYESNO = $00000002;
  ppAlertTypeYESNOCANCEL = $00000003;
  ppAlertTypeBACKNEXTCLOSE = $00000004;
  ppAlertTypeRETRYCANCEL = $00000005;
  ppAlertTypeABORTRETRYIGNORE = $00000006;

// Constants for enum PpAlertButton
type
  PpAlertButton = TOleEnum;
const
  ppAlertButtonCLOSE = $00000000;
  ppAlertButtonSNOOZE = $00000001;
  ppAlertButtonSEARCH = $00000002;
  ppAlertButtonIGNORE = $00000003;
  ppAlertButtonABORT = $00000004;
  ppAlertButtonRETRY = $00000005;
  ppAlertButtonNEXT = $00000006;
  ppAlertButtonBACK = $00000007;
  ppAlertButtonNO = $00000008;
  ppAlertButtonYES = $00000009;
  ppAlertButtonCANCEL = $0000000A;
  ppAlertButtonOK = $0000000B;
  ppAlertButtonNULL = $0000000C;

// Constants for enum PpAlertIcon
type
  PpAlertIcon = TOleEnum;
const
  ppAlertIconQuestionMark = $00000000;
  ppAlertIconNote = $00000001;
  ppAlertIconCaution = $00000002;
  ppAlertIconStop = $00000003;

// Constants for enum PpSlideShowPointerType
type
  PpSlideShowPointerType = TOleEnum;
const
  ppSlideShowPointerNone = $00000000;
  ppSlideShowPointerArrow = $00000001;
  ppSlideShowPointerPen = $00000002;
  ppSlideShowPointerAlwaysHidden = $00000003;
  ppSlideShowPointerAutoArrow = $00000004;

// Constants for enum PpSlideShowState
type
  PpSlideShowState = TOleEnum;
const
  ppSlideShowRunning = $00000001;
  ppSlideShowPaused = $00000002;
  ppSlideShowBlackScreen = $00000003;
  ppSlideShowWhiteScreen = $00000004;
  ppSlideShowDone = $00000005;

// Constants for enum PpSlideShowAdvanceMode
type
  PpSlideShowAdvanceMode = TOleEnum;
const
  ppSlideShowManualAdvance = $00000001;
  ppSlideShowUseSlideTimings = $00000002;
  ppSlideShowRehearseNewTimings = $00000003;

// Constants for enum PpFileDialogType
type
  PpFileDialogType = TOleEnum;
const
  ppFileDialogOpen = $00000001;
  ppFileDialogSave = $00000002;

// Constants for enum PpFileDialogView
type
  PpFileDialogView = TOleEnum;
const
  ppFileDialogViewDetails = $00000001;
  ppFileDialogViewPreview = $00000002;
  ppFileDialogViewProperties = $00000003;
  ppFileDialogViewList = $00000004;

// Constants for enum PpPrintOutputType
type
  PpPrintOutputType = TOleEnum;
const
  ppPrintOutputSlides = $00000001;
  ppPrintOutputTwoSlideHandouts = $00000002;
  ppPrintOutputThreeSlideHandouts = $00000003;
  ppPrintOutputSixSlideHandouts = $00000004;
  ppPrintOutputNotesPages = $00000005;
  ppPrintOutputOutline = $00000006;
  ppPrintOutputBuildSlides = $00000007;
  ppPrintOutputFourSlideHandouts = $00000008;
  ppPrintOutputNineSlideHandouts = $00000009;

// Constants for enum PpPrintHandoutOrder
type
  PpPrintHandoutOrder = TOleEnum;
const
  ppPrintHandoutVerticalFirst = $00000001;
  ppPrintHandoutHorizontalFirst = $00000002;

// Constants for enum PpPrintColorType
type
  PpPrintColorType = TOleEnum;
const
  ppPrintColor = $00000001;
  ppPrintBlackAndWhite = $00000002;
  ppPrintPureBlackAndWhite = $00000003;

// Constants for enum PpSelectionType
type
  PpSelectionType = TOleEnum;
const
  ppSelectionNone = $00000000;
  ppSelectionSlides = $00000001;
  ppSelectionShapes = $00000002;
  ppSelectionText = $00000003;

// Constants for enum PpDirection
type
  PpDirection = TOleEnum;
const
  ppDirectionMixed = $FFFFFFFE;
  ppDirectionLeftToRight = $00000001;
  ppDirectionRightToLeft = $00000002;

// Constants for enum PpDateTimeFormat
type
  PpDateTimeFormat = TOleEnum;
const
  ppDateTimeFormatMixed = $FFFFFFFE;
  ppDateTimeMdyy = $00000001;
  ppDateTimeddddMMMMddyyyy = $00000002;
  ppDateTimedMMMMyyyy = $00000003;
  ppDateTimeMMMMdyyyy = $00000004;
  ppDateTimedMMMyy = $00000005;
  ppDateTimeMMMMyy = $00000006;
  ppDateTimeMMyy = $00000007;
  ppDateTimeMMddyyHmm = $00000008;
  ppDateTimeMMddyyhmmAMPM = $00000009;
  ppDateTimeHmm = $0000000A;
  ppDateTimeHmmss = $0000000B;
  ppDateTimehmmAMPM = $0000000C;
  ppDateTimehmmssAMPM = $0000000D;

// Constants for enum PpTransitionSpeed
type
  PpTransitionSpeed = TOleEnum;
const
  ppTransitionSpeedMixed = $FFFFFFFE;
  ppTransitionSpeedSlow = $00000001;
  ppTransitionSpeedMedium = $00000002;
  ppTransitionSpeedFast = $00000003;

// Constants for enum PpMouseActivation
type
  PpMouseActivation = TOleEnum;
const
  ppMouseClick = $00000001;
  ppMouseOver = $00000002;

// Constants for enum PpActionType
type
  PpActionType = TOleEnum;
const
  ppActionMixed = $FFFFFFFE;
  ppActionNone = $00000000;
  ppActionNextSlide = $00000001;
  ppActionPreviousSlide = $00000002;
  ppActionFirstSlide = $00000003;
  ppActionLastSlide = $00000004;
  ppActionLastSlideViewed = $00000005;
  ppActionEndShow = $00000006;
  ppActionHyperlink = $00000007;
  ppActionRunMacro = $00000008;
  ppActionRunProgram = $00000009;
  ppActionNamedSlideShow = $0000000A;
  ppActionOLEVerb = $0000000B;
  ppActionPlay = $0000000C;

// Constants for enum PpPlaceholderType
type
  PpPlaceholderType = TOleEnum;
const
  ppPlaceholderMixed = $FFFFFFFE;
  ppPlaceholderTitle = $00000001;
  ppPlaceholderBody = $00000002;
  ppPlaceholderCenterTitle = $00000003;
  ppPlaceholderSubtitle = $00000004;
  ppPlaceholderVerticalTitle = $00000005;
  ppPlaceholderVerticalBody = $00000006;
  ppPlaceholderObject = $00000007;
  ppPlaceholderChart = $00000008;
  ppPlaceholderBitmap = $00000009;
  ppPlaceholderMediaClip = $0000000A;
  ppPlaceholderOrgChart = $0000000B;
  ppPlaceholderTable = $0000000C;
  ppPlaceholderSlideNumber = $0000000D;
  ppPlaceholderHeader = $0000000E;
  ppPlaceholderFooter = $0000000F;
  ppPlaceholderDate = $00000010;

// Constants for enum PpSlideShowType
type
  PpSlideShowType = TOleEnum;
const
  ppShowTypeSpeaker = $00000001;
  ppShowTypeWindow = $00000002;
  ppShowTypeKiosk = $00000003;

// Constants for enum PpPrintRangeType
type
  PpPrintRangeType = TOleEnum;
const
  ppPrintAll = $00000001;
  ppPrintSelection = $00000002;
  ppPrintCurrent = $00000003;
  ppPrintSlideRange = $00000004;
  ppPrintNamedSlideShow = $00000005;

// Constants for enum PpAutoSize
type
  PpAutoSize = TOleEnum;
const
  ppAutoSizeMixed = $FFFFFFFE;
  ppAutoSizeNone = $00000000;
  ppAutoSizeShapeToFitText = $00000001;

// Constants for enum PpMediaType
type
  PpMediaType = TOleEnum;
const
  ppMediaTypeMixed = $FFFFFFFE;
  ppMediaTypeOther = $00000001;
  ppMediaTypeSound = $00000002;
  ppMediaTypeMovie = $00000003;

// Constants for enum PpSoundFormatType
type
  PpSoundFormatType = TOleEnum;
const
  ppSoundFormatMixed = $FFFFFFFE;
  ppSoundFormatNone = $00000000;
  ppSoundFormatWAV = $00000001;
  ppSoundFormatMIDI = $00000002;
  ppSoundFormatCDAudio = $00000003;

// Constants for enum PpFarEastLineBreakLevel
type
  PpFarEastLineBreakLevel = TOleEnum;
const
  ppFarEastLineBreakLevelNormal = $00000001;
  ppFarEastLineBreakLevelStrict = $00000002;
  ppFarEastLineBreakLevelCustom = $00000003;

// Constants for enum PpSlideShowRangeType
type
  PpSlideShowRangeType = TOleEnum;
const
  ppShowAll = $00000001;
  ppShowSlideRange = $00000002;
  ppShowNamedSlideShow = $00000003;

// Constants for enum PpFrameColors
type
  PpFrameColors = TOleEnum;
const
  ppFrameColorsBrowserColors = $00000001;
  ppFrameColorsPresentationSchemeTextColor = $00000002;
  ppFrameColorsPresentationSchemeAccentColor = $00000003;
  ppFrameColorsWhiteTextOnBlack = $00000004;
  ppFrameColorsBlackTextOnWhite = $00000005;

// Constants for enum PpBorderType
type
  PpBorderType = TOleEnum;
const
  ppBorderTop = $00000001;
  ppBorderLeft = $00000002;
  ppBorderBottom = $00000003;
  ppBorderRight = $00000004;
  ppBorderDiagonalDown = $00000005;
  ppBorderDiagonalUp = $00000006;

// Constants for enum PpHTMLVersion
type
  PpHTMLVersion = TOleEnum;
const
  ppHTMLv3 = $00000001;
  ppHTMLv4 = $00000002;
  ppHTMLDual = $00000003;

// Constants for enum PpPublishSourceType
type
  PpPublishSourceType = TOleEnum;
const
  ppPublishAll = $00000001;
  ppPublishSlideRange = $00000002;
  ppPublishNamedSlideShow = $00000003;

// Constants for enum PpBulletType
type
  PpBulletType = TOleEnum;
const
  ppBulletMixed = $FFFFFFFE;
  ppBulletNone = $00000000;
  ppBulletUnnumbered = $00000001;
  ppBulletNumbered = $00000002;
  ppBulletPicture = $00000003;

// Constants for enum PpNumberedBulletStyle
type
  PpNumberedBulletStyle = TOleEnum;
const
  ppBulletStyleMixed = $FFFFFFFE;
  ppBulletAlphaLCPeriod = $00000000;
  ppBulletAlphaUCPeriod = $00000001;
  ppBulletArabicParenRight = $00000002;
  ppBulletArabicPeriod = $00000003;
  ppBulletRomanLCParenBoth = $00000004;
  ppBulletRomanLCParenRight = $00000005;
  ppBulletRomanLCPeriod = $00000006;
  ppBulletRomanUCPeriod = $00000007;
  ppBulletAlphaLCParenBoth = $00000008;
  ppBulletAlphaLCParenRight = $00000009;
  ppBulletAlphaUCParenBoth = $0000000A;
  ppBulletAlphaUCParenRight = $0000000B;
  ppBulletArabicParenBoth = $0000000C;
  ppBulletArabicPlain = $0000000D;
  ppBulletRomanUCParenBoth = $0000000E;
  ppBulletRomanUCParenRight = $0000000F;
  ppBulletSimpChinPlain = $00000010;
  ppBulletSimpChinPeriod = $00000011;
  ppBulletCircleNumDBPlain = $00000012;
  ppBulletCircleNumWDWhitePlain = $00000013;
  ppBulletCircleNumWDBlackPlain = $00000014;
  ppBulletTradChinPlain = $00000015;
  ppBulletTradChinPeriod = $00000016;
  ppBulletArabicAlphaDash = $00000017;
  ppBulletArabicAbjadDash = $00000018;
  ppBulletHebrewAlphaDash = $00000019;
  ppBulletKanjiKoreanPlain = $0000001A;
  ppBulletKanjiKoreanPeriod = $0000001B;
  ppBulletArabicDBPlain = $0000001C;
  ppBulletArabicDBPeriod = $0000001D;

// Constants for enum PpMarkerType
type
  PpMarkerType = TOleEnum;
const
  ppBoot = $00000000;
  ppFileNew = $00000001;
  ppFileOpen = $00000002;
  ppFileSave = $00000003;
  ppPrintForeground = $00000004;
  ppPrintBackground = $00000005;
  ppOLEInsert = $00000006;
  ppSlideShowStart = $00000007;
  ppSlideShowDraw = $00000008;
  ppSlideViewScroll = $00000009;
  ppDialogStart = $0000000A;

// Constants for enum PpShapeFormat
type
  PpShapeFormat = TOleEnum;
const
  ppShapeFormatGIF = $00000000;
  ppShapeFormatJPG = $00000001;
  ppShapeFormatPNG = $00000002;
  ppShapeFormatBMP = $00000003;
  ppShapeFormatWMF = $00000004;

// Constants for enum PpExportMode
type
  PpExportMode = TOleEnum;
const
  ppRelativeToSlide = $00000001;
  ppClipRelativeToSlide = $00000002;
  ppScaleToFit = $00000003;
  ppScaleXY = $00000004;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  Collection = interface;
  CollectionDisp = dispinterface;
  _Application = interface;
  _ApplicationDisp = dispinterface;
  _Global = interface;
  _GlobalDisp = dispinterface;
  EApplication = interface;
  ColorFormat = interface;
  ColorFormatDisp = dispinterface;
  SlideShowWindow = interface;
  SlideShowWindowDisp = dispinterface;
  Selection = interface;
  SelectionDisp = dispinterface;
  DocumentWindows = interface;
  DocumentWindowsDisp = dispinterface;
  SlideShowWindows = interface;
  SlideShowWindowsDisp = dispinterface;
  DocumentWindow = interface;
  DocumentWindowDisp = dispinterface;
  View = interface;
  ViewDisp = dispinterface;
  SlideShowView = interface;
  SlideShowViewDisp = dispinterface;
  SlideShowSettings = interface;
  SlideShowSettingsDisp = dispinterface;
  NamedSlideShows = interface;
  NamedSlideShowsDisp = dispinterface;
  NamedSlideShow = interface;
  NamedSlideShowDisp = dispinterface;
  PrintOptions = interface;
  PrintOptionsDisp = dispinterface;
  PrintRanges = interface;
  PrintRangesDisp = dispinterface;
  PrintRange = interface;
  PrintRangeDisp = dispinterface;
  AddIns = interface;
  AddInsDisp = dispinterface;
  AddIn = interface;
  AddInDisp = dispinterface;
  Presentations = interface;
  PresentationsDisp = dispinterface;
  PresEvents = interface;
  _Presentation = interface;
  _PresentationDisp = dispinterface;
  Hyperlinks = interface;
  HyperlinksDisp = dispinterface;
  Hyperlink = interface;
  HyperlinkDisp = dispinterface;
  PageSetup = interface;
  PageSetupDisp = dispinterface;
  Fonts = interface;
  FontsDisp = dispinterface;
  ExtraColors = interface;
  ExtraColorsDisp = dispinterface;
  Slides = interface;
  SlidesDisp = dispinterface;
  _Slide = interface;
  _SlideDisp = dispinterface;
  SlideRange = interface;
  SlideRangeDisp = dispinterface;
  _Master = interface;
  _MasterDisp = dispinterface;
  SldEvents = interface;
  ColorSchemes = interface;
  ColorSchemesDisp = dispinterface;
  ColorScheme = interface;
  ColorSchemeDisp = dispinterface;
  RGBColor = interface;
  RGBColorDisp = dispinterface;
  SlideShowTransition = interface;
  SlideShowTransitionDisp = dispinterface;
  SoundEffect = interface;
  SoundEffectDisp = dispinterface;
  SoundFormat = interface;
  SoundFormatDisp = dispinterface;
  HeadersFooters = interface;
  HeadersFootersDisp = dispinterface;
  Shapes = interface;
  ShapesDisp = dispinterface;
  Placeholders = interface;
  PlaceholdersDisp = dispinterface;
  PlaceholderFormat = interface;
  PlaceholderFormatDisp = dispinterface;
  FreeformBuilder = interface;
  FreeformBuilderDisp = dispinterface;
  Shape = interface;
  ShapeDisp = dispinterface;
  ShapeRange = interface;
  ShapeRangeDisp = dispinterface;
  GroupShapes = interface;
  GroupShapesDisp = dispinterface;
  Adjustments = interface;
  AdjustmentsDisp = dispinterface;
  PictureFormat = interface;
  PictureFormatDisp = dispinterface;
  FillFormat = interface;
  FillFormatDisp = dispinterface;
  LineFormat = interface;
  LineFormatDisp = dispinterface;
  ShadowFormat = interface;
  ShadowFormatDisp = dispinterface;
  ConnectorFormat = interface;
  ConnectorFormatDisp = dispinterface;
  TextEffectFormat = interface;
  TextEffectFormatDisp = dispinterface;
  ThreeDFormat = interface;
  ThreeDFormatDisp = dispinterface;
  TextFrame = interface;
  TextFrameDisp = dispinterface;
  CalloutFormat = interface;
  CalloutFormatDisp = dispinterface;
  ShapeNodes = interface;
  ShapeNodesDisp = dispinterface;
  ShapeNode = interface;
  ShapeNodeDisp = dispinterface;
  OLEFormat = interface;
  OLEFormatDisp = dispinterface;
  LinkFormat = interface;
  LinkFormatDisp = dispinterface;
  ObjectVerbs = interface;
  ObjectVerbsDisp = dispinterface;
  AnimationSettings = interface;
  AnimationSettingsDisp = dispinterface;
  ActionSettings = interface;
  ActionSettingsDisp = dispinterface;
  ActionSetting = interface;
  ActionSettingDisp = dispinterface;
  PlaySettings = interface;
  PlaySettingsDisp = dispinterface;
  TextRange = interface;
  TextRangeDisp = dispinterface;
  Ruler = interface;
  RulerDisp = dispinterface;
  RulerLevels = interface;
  RulerLevelsDisp = dispinterface;
  RulerLevel = interface;
  RulerLevelDisp = dispinterface;
  TabStops = interface;
  TabStopsDisp = dispinterface;
  TabStop = interface;
  TabStopDisp = dispinterface;
  Font = interface;
  FontDisp = dispinterface;
  ParagraphFormat = interface;
  ParagraphFormatDisp = dispinterface;
  BulletFormat = interface;
  BulletFormatDisp = dispinterface;
  TextStyles = interface;
  TextStylesDisp = dispinterface;
  TextStyle = interface;
  TextStyleDisp = dispinterface;
  TextStyleLevels = interface;
  TextStyleLevelsDisp = dispinterface;
  TextStyleLevel = interface;
  TextStyleLevelDisp = dispinterface;
  HeaderFooter = interface;
  HeaderFooterDisp = dispinterface;
  PPDialogs = interface;
  PPDialogsDisp = dispinterface;
  PPAlert = interface;
  PPAlertDisp = dispinterface;
  PPDialog = interface;
  PPDialogDisp = dispinterface;
  PPTabSheet = interface;
  PPTabSheetDisp = dispinterface;
  PPControls = interface;
  PPControlsDisp = dispinterface;
  PPTabSheets = interface;
  PPTabSheetsDisp = dispinterface;
  PPControl = interface;
  PPControlDisp = dispinterface;
  PPPushButton = interface;
  PPPushButtonDisp = dispinterface;
  PPToggleButton = interface;
  PPToggleButtonDisp = dispinterface;
  PPBitmapButton = interface;
  PPBitmapButtonDisp = dispinterface;
  PPListBox = interface;
  PPListBoxDisp = dispinterface;
  PPStrings = interface;
  PPStringsDisp = dispinterface;
  PPCheckBox = interface;
  PPCheckBoxDisp = dispinterface;
  PPRadioCluster = interface;
  PPRadioClusterDisp = dispinterface;
  PPStaticText = interface;
  PPStaticTextDisp = dispinterface;
  PPEditText = interface;
  PPEditTextDisp = dispinterface;
  PPIcon = interface;
  PPIconDisp = dispinterface;
  PPBitmap = interface;
  PPBitmapDisp = dispinterface;
  PPSpinner = interface;
  PPSpinnerDisp = dispinterface;
  PPScrollBar = interface;
  PPScrollBarDisp = dispinterface;
  PPGroupBox = interface;
  PPGroupBoxDisp = dispinterface;
  PPFrame = interface;
  PPFrameDisp = dispinterface;
  PPTabControl = interface;
  PPTabControlDisp = dispinterface;
  PPDropDown = interface;
  PPDropDownDisp = dispinterface;
  PPDropDownEdit = interface;
  PPDropDownEditDisp = dispinterface;
  PPSlideMiniature = interface;
  PPSlideMiniatureDisp = dispinterface;
  PPRadioButton = interface;
  PPRadioButtonDisp = dispinterface;
  Tags = interface;
  TagsDisp = dispinterface;
  FileDialogFileList = interface;
  FileDialogFileListDisp = dispinterface;
  FileDialogExtension = interface;
  FileDialogExtensionDisp = dispinterface;
  FileDialogExtensionList = interface;
  FileDialogExtensionListDisp = dispinterface;
  FileDialog = interface;
  FileDialogDisp = dispinterface;
  MouseTracker = interface;
  MouseDownHandler = interface;
  OCXExtender = interface;
  OCXExtenderDisp = dispinterface;
  OCXExtenderEvents = interface;
  Table = interface;
  TableDisp = dispinterface;
  Columns = interface;
  ColumnsDisp = dispinterface;
  Column = interface;
  ColumnDisp = dispinterface;
  Rows = interface;
  RowsDisp = dispinterface;
  Row = interface;
  RowDisp = dispinterface;
  CellRange = interface;
  CellRangeDisp = dispinterface;
  Cell = interface;
  CellDisp = dispinterface;
  Borders = interface;
  BordersDisp = dispinterface;
  Panes = interface;
  PanesDisp = dispinterface;
  Pane = interface;
  PaneDisp = dispinterface;
  DefaultWebOptions = interface;
  DefaultWebOptionsDisp = dispinterface;
  WebOptions = interface;
  WebOptionsDisp = dispinterface;
  PublishObjects = interface;
  PublishObjectsDisp = dispinterface;
  PublishObject = interface;
  PublishObjectDisp = dispinterface;
  Marker = interface;
  MarkerDisp = dispinterface;
  MasterEvents = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  PowerPointGlobal = _Global;
  PowerPointSlide = _Slide;
  PowerPointPresentation = _Presentation;
  OLECtrl = OCXExtender;
  PowerPointApplication = _Application;
  Master = _Master;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PPSafeArray1 = ^PSafeArray; {*}
  POleVariant1 = ^OleVariant; {*}
  PSingle1 = ^Single; {*}


// *********************************************************************//
// Interface: Collection
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {91493450-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Collection = interface(IDispatch)
    ['{91493450-5A91-11CF-8700-00AA0060263B}']
    function Get__NewEnum: IUnknown; safecall;
    function _Index(index: SYSINT): OleVariant; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  CollectionDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {91493450-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  CollectionDisp = dispinterface
    ['{91493450-5A91-11CF-8700-00AA0060263B}']
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: _Application
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493442-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _Application = interface(IDispatch)
    ['{91493442-5A91-11CF-8700-00AA0060263B}']
    function Get_Presentations: Presentations; safecall;
    function Get_Windows: DocumentWindows; safecall;
    function Get_Dialogs: PPDialogs; safecall;
    function Get_ActiveWindow: DocumentWindow; safecall;
    function Get_ActivePresentation: PowerPointPresentation; safecall;
    function Get_SlideShowWindows: SlideShowWindows; safecall;
    function Get_CommandBars: CommandBars; safecall;
    function Get_Path: WideString; safecall;
    function Get_Name: WideString; safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Caption: WideString); safecall;
    function Get_Assistant: Assistant; safecall;
    function Get_FileSearch: FileSearch; safecall;
    function Get_FileFind: IFind; safecall;
    function Get_Build: WideString; safecall;
    function Get_Version: WideString; safecall;
    function Get_OperatingSystem: WideString; safecall;
    function Get_ActivePrinter: WideString; safecall;
    function Get_Creator: Integer; safecall;
    function Get_AddIns: AddIns; safecall;
    function Get_VBE: VBE; safecall;
    procedure Help(const HelpFile: WideString; ContextID: SYSINT); safecall;
    procedure Quit; safecall;
    function Run(const MacroName: WideString; var safeArrayOfParams: PSafeArray): OleVariant; safecall;
    function FileDialog(Type_: PpFileDialogType): FileDialog; safecall;
    procedure LaunchSpelling(const pWindow: DocumentWindow); safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(Left: Single); safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(Top: Single); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(Width: Single); safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(Height: Single); safecall;
    function Get_WindowState: PpWindowState; safecall;
    procedure Set_WindowState(WindowState: PpWindowState); safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    function Get_HWND: Integer; safecall;
    function Get_Active: MsoTriState; safecall;
    procedure Activate; safecall;
    function Get_AnswerWizard: AnswerWizard; safecall;
    function Get_COMAddIns: COMAddIns; safecall;
    function Get_ProductCode: WideString; safecall;
    function Get_DefaultWebOptions: DefaultWebOptions; safecall;
    function Get_LanguageSettings: LanguageSettings; safecall;
    function Get_MsoDebugOptions: MsoDebugOptions; safecall;
    function Get_ShowWindowsInTaskbar: MsoTriState; safecall;
    procedure Set_ShowWindowsInTaskbar(ShowWindowsInTaskbar: MsoTriState); safecall;
    function Get_Marker: Marker; safecall;
    function Get_FeatureInstall: MsoFeatureInstall; safecall;
    procedure Set_FeatureInstall(FeatureInstall: MsoFeatureInstall); safecall;
    function GetOptionFlag(Option: Integer; Persist: WordBool): WordBool; safecall;
    procedure SetOptionFlag(Option: Integer; State: WordBool; Persist: WordBool); safecall;
    property Presentations: Presentations read Get_Presentations;
    property Windows: DocumentWindows read Get_Windows;
    property Dialogs: PPDialogs read Get_Dialogs;
    property ActiveWindow: DocumentWindow read Get_ActiveWindow;
    property ActivePresentation: PowerPointPresentation read Get_ActivePresentation;
    property SlideShowWindows: SlideShowWindows read Get_SlideShowWindows;
    property CommandBars: CommandBars read Get_CommandBars;
    property Path: WideString read Get_Path;
    property Name: WideString read Get_Name;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Assistant: Assistant read Get_Assistant;
    property FileSearch: FileSearch read Get_FileSearch;
    property FileFind: IFind read Get_FileFind;
    property Build: WideString read Get_Build;
    property Version: WideString read Get_Version;
    property OperatingSystem: WideString read Get_OperatingSystem;
    property ActivePrinter: WideString read Get_ActivePrinter;
    property Creator: Integer read Get_Creator;
    property AddIns: AddIns read Get_AddIns;
    property VBE: VBE read Get_VBE;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Width: Single read Get_Width write Set_Width;
    property Height: Single read Get_Height write Set_Height;
    property WindowState: PpWindowState read Get_WindowState write Set_WindowState;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property HWND: Integer read Get_HWND;
    property Active: MsoTriState read Get_Active;
    property AnswerWizard: AnswerWizard read Get_AnswerWizard;
    property COMAddIns: COMAddIns read Get_COMAddIns;
    property ProductCode: WideString read Get_ProductCode;
    property DefaultWebOptions: DefaultWebOptions read Get_DefaultWebOptions;
    property LanguageSettings: LanguageSettings read Get_LanguageSettings;
    property MsoDebugOptions: MsoDebugOptions read Get_MsoDebugOptions;
    property ShowWindowsInTaskbar: MsoTriState read Get_ShowWindowsInTaskbar write Set_ShowWindowsInTaskbar;
    property Marker: Marker read Get_Marker;
    property FeatureInstall: MsoFeatureInstall read Get_FeatureInstall write Set_FeatureInstall;
  end;

// *********************************************************************//
// DispIntf:  _ApplicationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493442-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _ApplicationDisp = dispinterface
    ['{91493442-5A91-11CF-8700-00AA0060263B}']
    property Presentations: Presentations readonly dispid 2001;
    property Windows: DocumentWindows readonly dispid 2002;
    property Dialogs: PPDialogs readonly dispid 2003;
    property ActiveWindow: DocumentWindow readonly dispid 2004;
    property ActivePresentation: PowerPointPresentation readonly dispid 2005;
    property SlideShowWindows: SlideShowWindows readonly dispid 2006;
    property CommandBars: CommandBars readonly dispid 2007;
    property Path: WideString readonly dispid 2008;
    property Name: WideString readonly dispid 0;
    property Caption: WideString dispid 2009;
    property Assistant: Assistant readonly dispid 2010;
    property FileSearch: FileSearch readonly dispid 2011;
    property FileFind: IFind readonly dispid 2012;
    property Build: WideString readonly dispid 2013;
    property Version: WideString readonly dispid 2014;
    property OperatingSystem: WideString readonly dispid 2015;
    property ActivePrinter: WideString readonly dispid 2016;
    property Creator: Integer readonly dispid 2017;
    property AddIns: AddIns readonly dispid 2018;
    property VBE: VBE readonly dispid 2019;
    procedure Help(const HelpFile: WideString; ContextID: SYSINT); dispid 2020;
    procedure Quit; dispid 2021;
    function Run(const MacroName: WideString; var safeArrayOfParams: {??PSafeArray}OleVariant): OleVariant; dispid 2022;
    function FileDialog(Type_: PpFileDialogType): FileDialog; dispid 2023;
    procedure LaunchSpelling(const pWindow: DocumentWindow); dispid 2024;
    property Left: Single dispid 2025;
    property Top: Single dispid 2026;
    property Width: Single dispid 2027;
    property Height: Single dispid 2028;
    property WindowState: PpWindowState dispid 2029;
    property Visible: MsoTriState dispid 2030;
    property HWND: Integer readonly dispid 2031;
    property Active: MsoTriState readonly dispid 2032;
    procedure Activate; dispid 2033;
    property AnswerWizard: AnswerWizard readonly dispid 2034;
    property COMAddIns: COMAddIns readonly dispid 2035;
    property ProductCode: WideString readonly dispid 2036;
    property DefaultWebOptions: DefaultWebOptions readonly dispid 2037;
    property LanguageSettings: LanguageSettings readonly dispid 2038;
    property MsoDebugOptions: MsoDebugOptions readonly dispid 2039;
    property ShowWindowsInTaskbar: MsoTriState dispid 2040;
    property Marker: Marker readonly dispid 2041;
    property FeatureInstall: MsoFeatureInstall dispid 2042;
    function GetOptionFlag(Option: Integer; Persist: WordBool): WordBool; dispid 2043;
    procedure SetOptionFlag(Option: Integer; State: WordBool; Persist: WordBool); dispid 2044;
  end;

// *********************************************************************//
// Interface: _Global
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493451-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _Global = interface(IDispatch)
    ['{91493451-5A91-11CF-8700-00AA0060263B}']
    function Get_ActivePresentation: PowerPointPresentation; safecall;
    function Get_ActiveWindow: DocumentWindow; safecall;
    function Get_AddIns: AddIns; safecall;
    function Get_Application: PowerPointApplication; safecall;
    function Get_Assistant: Assistant; safecall;
    function Get_Dialogs: PPDialogs; safecall;
    function Get_Presentations: Presentations; safecall;
    function Get_SlideShowWindows: SlideShowWindows; safecall;
    function Get_Windows: DocumentWindows; safecall;
    function Get_CommandBars: CommandBars; safecall;
    function Get_AnswerWizard: AnswerWizard; safecall;
    property ActivePresentation: PowerPointPresentation read Get_ActivePresentation;
    property ActiveWindow: DocumentWindow read Get_ActiveWindow;
    property AddIns: AddIns read Get_AddIns;
    property Application: PowerPointApplication read Get_Application;
    property Assistant: Assistant read Get_Assistant;
    property Dialogs: PPDialogs read Get_Dialogs;
    property Presentations: Presentations read Get_Presentations;
    property SlideShowWindows: SlideShowWindows read Get_SlideShowWindows;
    property Windows: DocumentWindows read Get_Windows;
    property CommandBars: CommandBars read Get_CommandBars;
    property AnswerWizard: AnswerWizard read Get_AnswerWizard;
  end;

// *********************************************************************//
// DispIntf:  _GlobalDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493451-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _GlobalDisp = dispinterface
    ['{91493451-5A91-11CF-8700-00AA0060263B}']
    property ActivePresentation: PowerPointPresentation readonly dispid 2001;
    property ActiveWindow: DocumentWindow readonly dispid 2002;
    property AddIns: AddIns readonly dispid 2003;
    property Application: PowerPointApplication readonly dispid 2004;
    property Assistant: Assistant readonly dispid 2005;
    property Dialogs: PPDialogs readonly dispid 2006;
    property Presentations: Presentations readonly dispid 2007;
    property SlideShowWindows: SlideShowWindows readonly dispid 2008;
    property Windows: DocumentWindows readonly dispid 2009;
    property CommandBars: CommandBars readonly dispid 2010;
    property AnswerWizard: AnswerWizard readonly dispid 2011;
  end;

// *********************************************************************//
// Interface: EApplication
// Flags:     (4096) Dispatchable
// GUID:      {914934C2-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  EApplication = interface(IDispatch)
    ['{914934C2-5A91-11CF-8700-00AA0060263B}']
    function WindowSelectionChange(const Sel: Selection): HResult; stdcall;
    function WindowBeforeRightClick(const Sel: Selection; var Cancel: WordBool): HResult; stdcall;
    function WindowBeforeDoubleClick(const Sel: Selection; var Cancel: WordBool): HResult; stdcall;
    function PresentationClose(const Pres: PowerPointPresentation): HResult; stdcall;
    function PresentationSave(const Pres: PowerPointPresentation): HResult; stdcall;
    function PresentationOpen(const Pres: PowerPointPresentation): HResult; stdcall;
    function NewPresentation(const Pres: PowerPointPresentation): HResult; stdcall;
    function PresentationNewSlide(const Sld: PowerPointSlide): HResult; stdcall;
    function WindowActivate(const Pres: PowerPointPresentation; const Wn: DocumentWindow): HResult; stdcall;
    function WindowDeactivate(const Pres: PowerPointPresentation; const Wn: DocumentWindow): HResult; stdcall;
    function SlideShowBegin(const Wn: SlideShowWindow): HResult; stdcall;
    function SlideShowNextBuild(const Wn: SlideShowWindow): HResult; stdcall;
    function SlideShowNextSlide(const Wn: SlideShowWindow): HResult; stdcall;
    function SlideShowEnd(const Pres: PowerPointPresentation): HResult; stdcall;
    function PresentationPrint(const Pres: PowerPointPresentation): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ColorFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493452-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ColorFormat = interface(IDispatch)
    ['{91493452-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_RGB: MsoRGBType; safecall;
    procedure Set_RGB(RGB: MsoRGBType); safecall;
    function Get_type_: MsoColorType; safecall;
    function Get_SchemeColor: PpColorSchemeIndex; safecall;
    procedure Set_SchemeColor(SchemeColor: PpColorSchemeIndex); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property RGB: MsoRGBType read Get_RGB write Set_RGB;
    property type_: MsoColorType read Get_type_;
    property SchemeColor: PpColorSchemeIndex read Get_SchemeColor write Set_SchemeColor;
  end;

// *********************************************************************//
// DispIntf:  ColorFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493452-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ColorFormatDisp = dispinterface
    ['{91493452-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    property RGB: MsoRGBType dispid 0;
    property type_: MsoColorType readonly dispid 101;
    property SchemeColor: PpColorSchemeIndex dispid 2003;
  end;

// *********************************************************************//
// Interface: SlideShowWindow
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493453-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowWindow = interface(IDispatch)
    ['{91493453-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_View: SlideShowView; safecall;
    function Get_Presentation: PowerPointPresentation; safecall;
    function Get_IsFullScreen: MsoTriState; safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(Left: Single); safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(Top: Single); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(Width: Single); safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(Height: Single); safecall;
    function Get_HWND: Integer; safecall;
    function Get_Active: MsoTriState; safecall;
    procedure Activate; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property View: SlideShowView read Get_View;
    property Presentation: PowerPointPresentation read Get_Presentation;
    property IsFullScreen: MsoTriState read Get_IsFullScreen;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Width: Single read Get_Width write Set_Width;
    property Height: Single read Get_Height write Set_Height;
    property HWND: Integer read Get_HWND;
    property Active: MsoTriState read Get_Active;
  end;

// *********************************************************************//
// DispIntf:  SlideShowWindowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493453-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowWindowDisp = dispinterface
    ['{91493453-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property View: SlideShowView readonly dispid 2003;
    property Presentation: PowerPointPresentation readonly dispid 2004;
    property IsFullScreen: MsoTriState readonly dispid 2005;
    property Left: Single dispid 2006;
    property Top: Single dispid 2007;
    property Width: Single dispid 2008;
    property Height: Single dispid 2009;
    property HWND: Integer readonly dispid 2010;
    property Active: MsoTriState readonly dispid 2011;
    procedure Activate; dispid 2012;
  end;

// *********************************************************************//
// Interface: Selection
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493454-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Selection = interface(IDispatch)
    ['{91493454-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure Cut; safecall;
    procedure Copy; safecall;
    procedure Delete; safecall;
    procedure Unselect; safecall;
    function Get_type_: PpSelectionType; safecall;
    function Get_SlideRange: SlideRange; safecall;
    function Get_ShapeRange: ShapeRange; safecall;
    function Get_TextRange: TextRange; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property type_: PpSelectionType read Get_type_;
    property SlideRange: SlideRange read Get_SlideRange;
    property ShapeRange: ShapeRange read Get_ShapeRange;
    property TextRange: TextRange read Get_TextRange;
  end;

// *********************************************************************//
// DispIntf:  SelectionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493454-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SelectionDisp = dispinterface
    ['{91493454-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    procedure Cut; dispid 2003;
    procedure Copy; dispid 2004;
    procedure Delete; dispid 2005;
    procedure Unselect; dispid 2006;
    property type_: PpSelectionType readonly dispid 2007;
    property SlideRange: SlideRange readonly dispid 2008;
    property ShapeRange: ShapeRange readonly dispid 2009;
    property TextRange: TextRange readonly dispid 2010;
  end;

// *********************************************************************//
// Interface: DocumentWindows
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493455-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  DocumentWindows = interface(Collection)
    ['{91493455-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): DocumentWindow; safecall;
    procedure Arrange(arrangeStyle: PpArrangeStyle); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  DocumentWindowsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493455-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  DocumentWindowsDisp = dispinterface
    ['{91493455-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): DocumentWindow; dispid 0;
    procedure Arrange(arrangeStyle: PpArrangeStyle); dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: SlideShowWindows
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493456-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowWindows = interface(Collection)
    ['{91493456-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): SlideShowWindow; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  SlideShowWindowsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493456-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowWindowsDisp = dispinterface
    ['{91493456-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): SlideShowWindow; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: DocumentWindow
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493457-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  DocumentWindow = interface(IDispatch)
    ['{91493457-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Selection: Selection; safecall;
    function Get_View: View; safecall;
    function Get_Presentation: PowerPointPresentation; safecall;
    function Get_ViewType: PpViewType; safecall;
    procedure Set_ViewType(ViewType: PpViewType); safecall;
    function Get_BlackAndWhite: MsoTriState; safecall;
    procedure Set_BlackAndWhite(BlackAndWhite: MsoTriState); safecall;
    function Get_Active: MsoTriState; safecall;
    function Get_WindowState: PpWindowState; safecall;
    procedure Set_WindowState(WindowState: PpWindowState); safecall;
    function Get_Caption: WideString; safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(Left: Single); safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(Top: Single); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(Width: Single); safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(Height: Single); safecall;
    procedure FitToPage; safecall;
    procedure Activate; safecall;
    procedure LargeScroll(Down: SYSINT; Up: SYSINT; ToRight: SYSINT; ToLeft: SYSINT); safecall;
    procedure SmallScroll(Down: SYSINT; Up: SYSINT; ToRight: SYSINT; ToLeft: SYSINT); safecall;
    function NewWindow: DocumentWindow; safecall;
    procedure Close; safecall;
    function Get_HWND: Integer; safecall;
    function Get_ActivePane: Pane; safecall;
    function Get_Panes: Panes; safecall;
    function Get_SplitVertical: Integer; safecall;
    procedure Set_SplitVertical(SplitVertical: Integer); safecall;
    function Get_SplitHorizontal: Integer; safecall;
    procedure Set_SplitHorizontal(SplitHorizontal: Integer); safecall;
    function RangeFromPoint(X: SYSINT; Y: SYSINT): IDispatch; safecall;
    function PointsToScreenPixelsX(Points: Single): SYSINT; safecall;
    function PointsToScreenPixelsY(Points: Single): SYSINT; safecall;
    procedure ScrollIntoView(Left: Single; Top: Single; Width: Single; Height: Single; 
                             Start: MsoTriState); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Selection: Selection read Get_Selection;
    property View: View read Get_View;
    property Presentation: PowerPointPresentation read Get_Presentation;
    property ViewType: PpViewType read Get_ViewType write Set_ViewType;
    property BlackAndWhite: MsoTriState read Get_BlackAndWhite write Set_BlackAndWhite;
    property Active: MsoTriState read Get_Active;
    property WindowState: PpWindowState read Get_WindowState write Set_WindowState;
    property Caption: WideString read Get_Caption;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Width: Single read Get_Width write Set_Width;
    property Height: Single read Get_Height write Set_Height;
    property HWND: Integer read Get_HWND;
    property ActivePane: Pane read Get_ActivePane;
    property Panes: Panes read Get_Panes;
    property SplitVertical: Integer read Get_SplitVertical write Set_SplitVertical;
    property SplitHorizontal: Integer read Get_SplitHorizontal write Set_SplitHorizontal;
  end;

// *********************************************************************//
// DispIntf:  DocumentWindowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493457-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  DocumentWindowDisp = dispinterface
    ['{91493457-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Selection: Selection readonly dispid 2003;
    property View: View readonly dispid 2004;
    property Presentation: PowerPointPresentation readonly dispid 2005;
    property ViewType: PpViewType dispid 2006;
    property BlackAndWhite: MsoTriState dispid 2007;
    property Active: MsoTriState readonly dispid 2008;
    property WindowState: PpWindowState dispid 2009;
    property Caption: WideString readonly dispid 0;
    property Left: Single dispid 2010;
    property Top: Single dispid 2011;
    property Width: Single dispid 2012;
    property Height: Single dispid 2013;
    procedure FitToPage; dispid 2014;
    procedure Activate; dispid 2015;
    procedure LargeScroll(Down: SYSINT; Up: SYSINT; ToRight: SYSINT; ToLeft: SYSINT); dispid 2016;
    procedure SmallScroll(Down: SYSINT; Up: SYSINT; ToRight: SYSINT; ToLeft: SYSINT); dispid 2017;
    function NewWindow: DocumentWindow; dispid 2018;
    procedure Close; dispid 2019;
    property HWND: Integer readonly dispid 2020;
    property ActivePane: Pane readonly dispid 2021;
    property Panes: Panes readonly dispid 2022;
    property SplitVertical: Integer dispid 2023;
    property SplitHorizontal: Integer dispid 2024;
    function RangeFromPoint(X: SYSINT; Y: SYSINT): IDispatch; dispid 2025;
    function PointsToScreenPixelsX(Points: Single): SYSINT; dispid 2026;
    function PointsToScreenPixelsY(Points: Single): SYSINT; dispid 2027;
    procedure ScrollIntoView(Left: Single; Top: Single; Width: Single; Height: Single; 
                             Start: MsoTriState); dispid 2028;
  end;

// *********************************************************************//
// Interface: View
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493458-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  View = interface(IDispatch)
    ['{91493458-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_type_: PpViewType; safecall;
    function Get_Zoom: SYSINT; safecall;
    procedure Set_Zoom(Zoom: SYSINT); safecall;
    procedure Paste; safecall;
    function Get_Slide: IDispatch; safecall;
    procedure Set_Slide(const Slide: IDispatch); safecall;
    procedure GotoSlide(index: SYSINT); safecall;
    function Get_DisplaySlideMiniature: MsoTriState; safecall;
    procedure Set_DisplaySlideMiniature(DisplaySlideMiniature: MsoTriState); safecall;
    function Get_ZoomToFit: MsoTriState; safecall;
    procedure Set_ZoomToFit(ZoomToFit: MsoTriState); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property type_: PpViewType read Get_type_;
    property Zoom: SYSINT read Get_Zoom write Set_Zoom;
    property Slide: IDispatch read Get_Slide write Set_Slide;
    property DisplaySlideMiniature: MsoTriState read Get_DisplaySlideMiniature write Set_DisplaySlideMiniature;
    property ZoomToFit: MsoTriState read Get_ZoomToFit write Set_ZoomToFit;
  end;

// *********************************************************************//
// DispIntf:  ViewDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493458-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ViewDisp = dispinterface
    ['{91493458-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property type_: PpViewType readonly dispid 2003;
    property Zoom: SYSINT dispid 2004;
    procedure Paste; dispid 2005;
    property Slide: IDispatch dispid 2006;
    procedure GotoSlide(index: SYSINT); dispid 2007;
    property DisplaySlideMiniature: MsoTriState dispid 2008;
    property ZoomToFit: MsoTriState dispid 2009;
  end;

// *********************************************************************//
// Interface: SlideShowView
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493459-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowView = interface(IDispatch)
    ['{91493459-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Zoom: SYSINT; safecall;
    function Get_Slide: PowerPointSlide; safecall;
    function Get_PointerType: PpSlideShowPointerType; safecall;
    procedure Set_PointerType(PointerType: PpSlideShowPointerType); safecall;
    function Get_State: PpSlideShowState; safecall;
    procedure Set_State(State: PpSlideShowState); safecall;
    function Get_AcceleratorsEnabled: MsoTriState; safecall;
    procedure Set_AcceleratorsEnabled(AcceleratorsEnabled: MsoTriState); safecall;
    function Get_PresentationElapsedTime: Single; safecall;
    function Get_SlideElapsedTime: Single; safecall;
    procedure Set_SlideElapsedTime(SlideElapsedTime: Single); safecall;
    function Get_LastSlideViewed: PowerPointSlide; safecall;
    function Get_AdvanceMode: PpSlideShowAdvanceMode; safecall;
    function Get_PointerColor: ColorFormat; safecall;
    function Get_IsNamedShow: MsoTriState; safecall;
    function Get_SlideShowName: WideString; safecall;
    procedure DrawLine(BeginX: Single; BeginY: Single; EndX: Single; EndY: Single); safecall;
    procedure EraseDrawing; safecall;
    procedure First; safecall;
    procedure Last; safecall;
    procedure Next; safecall;
    procedure Previous; safecall;
    procedure GotoSlide(index: SYSINT; ResetSlide: MsoTriState); safecall;
    procedure GotoNamedShow(const SlideShowName: WideString); safecall;
    procedure EndNamedShow; safecall;
    procedure ResetSlideTime; safecall;
    procedure Exit; safecall;
    procedure InstallTracker(const pTracker: MouseTracker; Presenter: MsoTriState); safecall;
    function Get_CurrentShowPosition: SYSINT; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Zoom: SYSINT read Get_Zoom;
    property Slide: PowerPointSlide read Get_Slide;
    property PointerType: PpSlideShowPointerType read Get_PointerType write Set_PointerType;
    property State: PpSlideShowState read Get_State write Set_State;
    property AcceleratorsEnabled: MsoTriState read Get_AcceleratorsEnabled write Set_AcceleratorsEnabled;
    property PresentationElapsedTime: Single read Get_PresentationElapsedTime;
    property SlideElapsedTime: Single read Get_SlideElapsedTime write Set_SlideElapsedTime;
    property LastSlideViewed: PowerPointSlide read Get_LastSlideViewed;
    property AdvanceMode: PpSlideShowAdvanceMode read Get_AdvanceMode;
    property PointerColor: ColorFormat read Get_PointerColor;
    property IsNamedShow: MsoTriState read Get_IsNamedShow;
    property SlideShowName: WideString read Get_SlideShowName;
    property CurrentShowPosition: SYSINT read Get_CurrentShowPosition;
  end;

// *********************************************************************//
// DispIntf:  SlideShowViewDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493459-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowViewDisp = dispinterface
    ['{91493459-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Zoom: SYSINT readonly dispid 2003;
    property Slide: PowerPointSlide readonly dispid 2004;
    property PointerType: PpSlideShowPointerType dispid 2005;
    property State: PpSlideShowState dispid 2006;
    property AcceleratorsEnabled: MsoTriState dispid 2007;
    property PresentationElapsedTime: Single readonly dispid 2008;
    property SlideElapsedTime: Single dispid 2009;
    property LastSlideViewed: PowerPointSlide readonly dispid 2010;
    property AdvanceMode: PpSlideShowAdvanceMode readonly dispid 2011;
    property PointerColor: ColorFormat readonly dispid 2012;
    property IsNamedShow: MsoTriState readonly dispid 2013;
    property SlideShowName: WideString readonly dispid 2014;
    procedure DrawLine(BeginX: Single; BeginY: Single; EndX: Single; EndY: Single); dispid 2015;
    procedure EraseDrawing; dispid 2016;
    procedure First; dispid 2017;
    procedure Last; dispid 2018;
    procedure Next; dispid 2019;
    procedure Previous; dispid 2020;
    procedure GotoSlide(index: SYSINT; ResetSlide: MsoTriState); dispid 2021;
    procedure GotoNamedShow(const SlideShowName: WideString); dispid 2022;
    procedure EndNamedShow; dispid 2023;
    procedure ResetSlideTime; dispid 2024;
    procedure Exit; dispid 2025;
    procedure InstallTracker(const pTracker: MouseTracker; Presenter: MsoTriState); dispid 2026;
    property CurrentShowPosition: SYSINT readonly dispid 2027;
  end;

// *********************************************************************//
// Interface: SlideShowSettings
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowSettings = interface(IDispatch)
    ['{9149345A-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_PointerColor: ColorFormat; safecall;
    function Get_NamedSlideShows: NamedSlideShows; safecall;
    function Get_StartingSlide: SYSINT; safecall;
    procedure Set_StartingSlide(StartingSlide: SYSINT); safecall;
    function Get_EndingSlide: SYSINT; safecall;
    procedure Set_EndingSlide(EndingSlide: SYSINT); safecall;
    function Get_AdvanceMode: PpSlideShowAdvanceMode; safecall;
    procedure Set_AdvanceMode(AdvanceMode: PpSlideShowAdvanceMode); safecall;
    function Run: SlideShowWindow; safecall;
    function Get_LoopUntilStopped: MsoTriState; safecall;
    procedure Set_LoopUntilStopped(LoopUntilStopped: MsoTriState); safecall;
    function Get_ShowType: PpSlideShowType; safecall;
    procedure Set_ShowType(ShowType: PpSlideShowType); safecall;
    function Get_ShowWithNarration: MsoTriState; safecall;
    procedure Set_ShowWithNarration(ShowWithNarration: MsoTriState); safecall;
    function Get_ShowWithAnimation: MsoTriState; safecall;
    procedure Set_ShowWithAnimation(ShowWithAnimation: MsoTriState); safecall;
    function Get_SlideShowName: WideString; safecall;
    procedure Set_SlideShowName(const SlideShowName: WideString); safecall;
    function Get_RangeType: PpSlideShowRangeType; safecall;
    procedure Set_RangeType(RangeType: PpSlideShowRangeType); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property PointerColor: ColorFormat read Get_PointerColor;
    property NamedSlideShows: NamedSlideShows read Get_NamedSlideShows;
    property StartingSlide: SYSINT read Get_StartingSlide write Set_StartingSlide;
    property EndingSlide: SYSINT read Get_EndingSlide write Set_EndingSlide;
    property AdvanceMode: PpSlideShowAdvanceMode read Get_AdvanceMode write Set_AdvanceMode;
    property LoopUntilStopped: MsoTriState read Get_LoopUntilStopped write Set_LoopUntilStopped;
    property ShowType: PpSlideShowType read Get_ShowType write Set_ShowType;
    property ShowWithNarration: MsoTriState read Get_ShowWithNarration write Set_ShowWithNarration;
    property ShowWithAnimation: MsoTriState read Get_ShowWithAnimation write Set_ShowWithAnimation;
    property SlideShowName: WideString read Get_SlideShowName write Set_SlideShowName;
    property RangeType: PpSlideShowRangeType read Get_RangeType write Set_RangeType;
  end;

// *********************************************************************//
// DispIntf:  SlideShowSettingsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowSettingsDisp = dispinterface
    ['{9149345A-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property PointerColor: ColorFormat readonly dispid 2003;
    property NamedSlideShows: NamedSlideShows readonly dispid 2004;
    property StartingSlide: SYSINT dispid 2005;
    property EndingSlide: SYSINT dispid 2006;
    property AdvanceMode: PpSlideShowAdvanceMode dispid 2007;
    function Run: SlideShowWindow; dispid 2008;
    property LoopUntilStopped: MsoTriState dispid 2009;
    property ShowType: PpSlideShowType dispid 2010;
    property ShowWithNarration: MsoTriState dispid 2011;
    property ShowWithAnimation: MsoTriState dispid 2012;
    property SlideShowName: WideString dispid 2013;
    property RangeType: PpSlideShowRangeType dispid 2014;
  end;

// *********************************************************************//
// Interface: NamedSlideShows
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  NamedSlideShows = interface(Collection)
    ['{9149345B-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: OleVariant): NamedSlideShow; safecall;
    function Add(const Name: WideString; safeArrayOfSlideIDs: OleVariant): NamedSlideShow; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  NamedSlideShowsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  NamedSlideShowsDisp = dispinterface
    ['{9149345B-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: OleVariant): NamedSlideShow; dispid 0;
    function Add(const Name: WideString; safeArrayOfSlideIDs: OleVariant): NamedSlideShow; dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: NamedSlideShow
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  NamedSlideShow = interface(IDispatch)
    ['{9149345C-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Name: WideString; safecall;
    procedure Delete; safecall;
    function Get_SlideIDs: OleVariant; safecall;
    function Get_Count: Integer; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Name: WideString read Get_Name;
    property SlideIDs: OleVariant read Get_SlideIDs;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  NamedSlideShowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  NamedSlideShowDisp = dispinterface
    ['{9149345C-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Name: WideString readonly dispid 2003;
    procedure Delete; dispid 2004;
    property SlideIDs: OleVariant readonly dispid 2005;
    property Count: Integer readonly dispid 2006;
  end;

// *********************************************************************//
// Interface: PrintOptions
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345D-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PrintOptions = interface(IDispatch)
    ['{9149345D-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_PrintColorType: PpPrintColorType; safecall;
    procedure Set_PrintColorType(PrintColorType: PpPrintColorType); safecall;
    function Get_Collate: MsoTriState; safecall;
    procedure Set_Collate(Collate: MsoTriState); safecall;
    function Get_FitToPage: MsoTriState; safecall;
    procedure Set_FitToPage(FitToPage: MsoTriState); safecall;
    function Get_FrameSlides: MsoTriState; safecall;
    procedure Set_FrameSlides(FrameSlides: MsoTriState); safecall;
    function Get_NumberOfCopies: SYSINT; safecall;
    procedure Set_NumberOfCopies(NumberOfCopies: SYSINT); safecall;
    function Get_OutputType: PpPrintOutputType; safecall;
    procedure Set_OutputType(OutputType: PpPrintOutputType); safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_PrintHiddenSlides: MsoTriState; safecall;
    procedure Set_PrintHiddenSlides(PrintHiddenSlides: MsoTriState); safecall;
    function Get_PrintInBackground: MsoTriState; safecall;
    procedure Set_PrintInBackground(PrintInBackground: MsoTriState); safecall;
    function Get_RangeType: PpPrintRangeType; safecall;
    procedure Set_RangeType(RangeType: PpPrintRangeType); safecall;
    function Get_Ranges: PrintRanges; safecall;
    function Get_PrintFontsAsGraphics: MsoTriState; safecall;
    procedure Set_PrintFontsAsGraphics(PrintFontsAsGraphics: MsoTriState); safecall;
    function Get_SlideShowName: WideString; safecall;
    procedure Set_SlideShowName(const SlideShowName: WideString); safecall;
    function Get_ActivePrinter: WideString; safecall;
    procedure Set_ActivePrinter(const ActivePrinter: WideString); safecall;
    function Get_HandoutOrder: PpPrintHandoutOrder; safecall;
    procedure Set_HandoutOrder(HandoutOrder: PpPrintHandoutOrder); safecall;
    property Application: PowerPointApplication read Get_Application;
    property PrintColorType: PpPrintColorType read Get_PrintColorType write Set_PrintColorType;
    property Collate: MsoTriState read Get_Collate write Set_Collate;
    property FitToPage: MsoTriState read Get_FitToPage write Set_FitToPage;
    property FrameSlides: MsoTriState read Get_FrameSlides write Set_FrameSlides;
    property NumberOfCopies: SYSINT read Get_NumberOfCopies write Set_NumberOfCopies;
    property OutputType: PpPrintOutputType read Get_OutputType write Set_OutputType;
    property Parent: IDispatch read Get_Parent;
    property PrintHiddenSlides: MsoTriState read Get_PrintHiddenSlides write Set_PrintHiddenSlides;
    property PrintInBackground: MsoTriState read Get_PrintInBackground write Set_PrintInBackground;
    property RangeType: PpPrintRangeType read Get_RangeType write Set_RangeType;
    property Ranges: PrintRanges read Get_Ranges;
    property PrintFontsAsGraphics: MsoTriState read Get_PrintFontsAsGraphics write Set_PrintFontsAsGraphics;
    property SlideShowName: WideString read Get_SlideShowName write Set_SlideShowName;
    property ActivePrinter: WideString read Get_ActivePrinter write Set_ActivePrinter;
    property HandoutOrder: PpPrintHandoutOrder read Get_HandoutOrder write Set_HandoutOrder;
  end;

// *********************************************************************//
// DispIntf:  PrintOptionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345D-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PrintOptionsDisp = dispinterface
    ['{9149345D-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property PrintColorType: PpPrintColorType dispid 2002;
    property Collate: MsoTriState dispid 2003;
    property FitToPage: MsoTriState dispid 2004;
    property FrameSlides: MsoTriState dispid 2005;
    property NumberOfCopies: SYSINT dispid 2006;
    property OutputType: PpPrintOutputType dispid 2007;
    property Parent: IDispatch readonly dispid 2008;
    property PrintHiddenSlides: MsoTriState dispid 2009;
    property PrintInBackground: MsoTriState dispid 2010;
    property RangeType: PpPrintRangeType dispid 2011;
    property Ranges: PrintRanges readonly dispid 2012;
    property PrintFontsAsGraphics: MsoTriState dispid 2013;
    property SlideShowName: WideString dispid 2014;
    property ActivePrinter: WideString dispid 2015;
    property HandoutOrder: PpPrintHandoutOrder dispid 2016;
  end;

// *********************************************************************//
// Interface: PrintRanges
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PrintRanges = interface(Collection)
    ['{9149345E-5A91-11CF-8700-00AA0060263B}']
    function Add(Start: SYSINT; End_: SYSINT): PrintRange; safecall;
    function Get_Application: PowerPointApplication; safecall;
    procedure ClearAll; safecall;
    function Item(index: SYSINT): PrintRange; safecall;
    function Get_Parent: IDispatch; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  PrintRangesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PrintRangesDisp = dispinterface
    ['{9149345E-5A91-11CF-8700-00AA0060263B}']
    function Add(Start: SYSINT; End_: SYSINT): PrintRange; dispid 2001;
    property Application: PowerPointApplication readonly dispid 2002;
    procedure ClearAll; dispid 2003;
    function Item(index: SYSINT): PrintRange; dispid 0;
    property Parent: IDispatch readonly dispid 2004;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: PrintRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PrintRange = interface(IDispatch)
    ['{9149345F-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Start: SYSINT; safecall;
    function Get_End_: SYSINT; safecall;
    procedure Delete; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Start: SYSINT read Get_Start;
    property End_: SYSINT read Get_End_;
  end;

// *********************************************************************//
// DispIntf:  PrintRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149345F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PrintRangeDisp = dispinterface
    ['{9149345F-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Start: SYSINT readonly dispid 2003;
    property End_: SYSINT readonly dispid 2004;
    procedure Delete; dispid 2005;
  end;

// *********************************************************************//
// Interface: AddIns
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493460-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  AddIns = interface(Collection)
    ['{91493460-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(var index: OleVariant): AddIn; safecall;
    function Add(const FileName: WideString): AddIn; safecall;
    procedure Remove(var index: OleVariant); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  AddInsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493460-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  AddInsDisp = dispinterface
    ['{91493460-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(var index: OleVariant): AddIn; dispid 0;
    function Add(const FileName: WideString): AddIn; dispid 2003;
    procedure Remove(var index: OleVariant); dispid 2004;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: AddIn
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493461-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  AddIn = interface(IDispatch)
    ['{91493461-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_FullName: WideString; safecall;
    function Get_Name: WideString; safecall;
    function Get_Path: WideString; safecall;
    function Get_Registered: MsoTriState; safecall;
    procedure Set_Registered(Registered: MsoTriState); safecall;
    function Get_AutoLoad: MsoTriState; safecall;
    procedure Set_AutoLoad(AutoLoad: MsoTriState); safecall;
    function Get_Loaded: MsoTriState; safecall;
    procedure Set_Loaded(Loaded: MsoTriState); safecall;
    function Get_DisplayAlerts: MsoTriState; safecall;
    procedure Set_DisplayAlerts(DisplayAlerts: MsoTriState); safecall;
    function Get_RegisteredInHKLM: MsoTriState; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property FullName: WideString read Get_FullName;
    property Name: WideString read Get_Name;
    property Path: WideString read Get_Path;
    property Registered: MsoTriState read Get_Registered write Set_Registered;
    property AutoLoad: MsoTriState read Get_AutoLoad write Set_AutoLoad;
    property Loaded: MsoTriState read Get_Loaded write Set_Loaded;
    property DisplayAlerts: MsoTriState read Get_DisplayAlerts write Set_DisplayAlerts;
    property RegisteredInHKLM: MsoTriState read Get_RegisteredInHKLM;
  end;

// *********************************************************************//
// DispIntf:  AddInDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493461-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  AddInDisp = dispinterface
    ['{91493461-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property FullName: WideString readonly dispid 2003;
    property Name: WideString readonly dispid 2004;
    property Path: WideString readonly dispid 2005;
    property Registered: MsoTriState dispid 2006;
    property AutoLoad: MsoTriState dispid 2007;
    property Loaded: MsoTriState dispid 2008;
    property DisplayAlerts: MsoTriState dispid 2009;
    property RegisteredInHKLM: MsoTriState readonly dispid 2010;
  end;

// *********************************************************************//
// Interface: Presentations
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493462-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Presentations = interface(Collection)
    ['{91493462-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: OleVariant): PowerPointPresentation; safecall;
    function Add(WithWindow: MsoTriState): PowerPointPresentation; safecall;
    function Open(const FileName: WideString; ReadOnly: MsoTriState; Untitled: MsoTriState; 
                  WithWindow: MsoTriState): PowerPointPresentation; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  PresentationsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493462-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PresentationsDisp = dispinterface
    ['{91493462-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: OleVariant): PowerPointPresentation; dispid 0;
    function Add(WithWindow: MsoTriState): PowerPointPresentation; dispid 2003;
    function Open(const FileName: WideString; ReadOnly: MsoTriState; Untitled: MsoTriState; 
                  WithWindow: MsoTriState): PowerPointPresentation; dispid 2004;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: PresEvents
// Flags:     (16) Hidden
// GUID:      {91493463-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PresEvents = interface(IUnknown)
    ['{91493463-5A91-11CF-8700-00AA0060263B}']
  end;

// *********************************************************************//
// Interface: _Presentation
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349D-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _Presentation = interface(IDispatch)
    ['{9149349D-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_SlideMaster: _Master; safecall;
    function Get_TitleMaster: _Master; safecall;
    function Get_HasTitleMaster: MsoTriState; safecall;
    function AddTitleMaster: _Master; safecall;
    procedure ApplyTemplate(const FileName: WideString); safecall;
    function Get_TemplateName: WideString; safecall;
    function Get_NotesMaster: _Master; safecall;
    function Get_HandoutMaster: _Master; safecall;
    function Get_Slides: Slides; safecall;
    function Get_PageSetup: PageSetup; safecall;
    function Get_ColorSchemes: ColorSchemes; safecall;
    function Get_ExtraColors: ExtraColors; safecall;
    function Get_SlideShowSettings: SlideShowSettings; safecall;
    function Get_Fonts: Fonts; safecall;
    function Get_Windows: DocumentWindows; safecall;
    function Get_Tags: Tags; safecall;
    function Get_DefaultShape: Shape; safecall;
    function Get_BuiltInDocumentProperties: IDispatch; safecall;
    function Get_CustomDocumentProperties: IDispatch; safecall;
    function Get_VBProject: VBProject; safecall;
    function Get_ReadOnly: MsoTriState; safecall;
    function Get_FullName: WideString; safecall;
    function Get_Name: WideString; safecall;
    function Get_Path: WideString; safecall;
    function Get_Saved: MsoTriState; safecall;
    procedure Set_Saved(Saved: MsoTriState); safecall;
    function Get_LayoutDirection: PpDirection; safecall;
    procedure Set_LayoutDirection(LayoutDirection: PpDirection); safecall;
    function NewWindow: DocumentWindow; safecall;
    procedure FollowHyperlink(const Address: WideString; const SubAddress: WideString; 
                              NewWindow: WordBool; AddHistory: WordBool; 
                              const ExtraInfo: WideString; Method: MsoExtraInfoMethod; 
                              const HeaderInfo: WideString); safecall;
    procedure AddToFavorites; safecall;
    procedure Unused; safecall;
    function Get_PrintOptions: PrintOptions; safecall;
    procedure PrintOut(From: SYSINT; To_: SYSINT; const PrintToFile: WideString; Copies: SYSINT; 
                       Collate: MsoTriState); safecall;
    procedure Save; safecall;
    procedure SaveAs(const FileName: WideString; FileFormat: PpSaveAsFileType; 
                     EmbedTrueTypeFonts: MsoTriState); safecall;
    procedure SaveCopyAs(const FileName: WideString; FileFormat: PpSaveAsFileType; 
                         EmbedTrueTypeFonts: MsoTriState); safecall;
    procedure Export(const Path: WideString; const FilterName: WideString; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT); safecall;
    procedure Close; safecall;
    procedure SetUndoText(const Text: WideString); safecall;
    function Get_Container: IDispatch; safecall;
    function Get_DisplayComments: MsoTriState; safecall;
    procedure Set_DisplayComments(DisplayComments: MsoTriState); safecall;
    function Get_FarEastLineBreakLevel: PpFarEastLineBreakLevel; safecall;
    procedure Set_FarEastLineBreakLevel(FarEastLineBreakLevel: PpFarEastLineBreakLevel); safecall;
    function Get_NoLineBreakBefore: WideString; safecall;
    procedure Set_NoLineBreakBefore(const NoLineBreakBefore: WideString); safecall;
    function Get_NoLineBreakAfter: WideString; safecall;
    procedure Set_NoLineBreakAfter(const NoLineBreakAfter: WideString); safecall;
    procedure UpdateLinks; safecall;
    function Get_SlideShowWindow: SlideShowWindow; safecall;
    function Get_FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID; safecall;
    procedure Set_FarEastLineBreakLanguage(FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID); safecall;
    procedure WebPagePreview; safecall;
    function Get_DefaultLanguageID: MsoLanguageID; safecall;
    procedure Set_DefaultLanguageID(DefaultLanguageID: MsoLanguageID); safecall;
    function Get_CommandBars: CommandBars; safecall;
    function Get_PublishObjects: PublishObjects; safecall;
    function Get_WebOptions: WebOptions; safecall;
    function Get_HTMLProject: HTMLProject; safecall;
    procedure ReloadAs(cp: MsoEncoding); safecall;
    procedure MakeIntoTemplate(IsDesignTemplate: MsoTriState); safecall;
    function Get_EnvelopeVisible: MsoTriState; safecall;
    procedure Set_EnvelopeVisible(EnvelopeVisible: MsoTriState); safecall;
    procedure sblt(const s: WideString); safecall;
    function Get_VBASigned: MsoTriState; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property SlideMaster: _Master read Get_SlideMaster;
    property TitleMaster: _Master read Get_TitleMaster;
    property HasTitleMaster: MsoTriState read Get_HasTitleMaster;
    property TemplateName: WideString read Get_TemplateName;
    property NotesMaster: _Master read Get_NotesMaster;
    property HandoutMaster: _Master read Get_HandoutMaster;
    property Slides: Slides read Get_Slides;
    property PageSetup: PageSetup read Get_PageSetup;
    property ColorSchemes: ColorSchemes read Get_ColorSchemes;
    property ExtraColors: ExtraColors read Get_ExtraColors;
    property SlideShowSettings: SlideShowSettings read Get_SlideShowSettings;
    property Fonts: Fonts read Get_Fonts;
    property Windows: DocumentWindows read Get_Windows;
    property Tags: Tags read Get_Tags;
    property DefaultShape: Shape read Get_DefaultShape;
    property BuiltInDocumentProperties: IDispatch read Get_BuiltInDocumentProperties;
    property CustomDocumentProperties: IDispatch read Get_CustomDocumentProperties;
    property VBProject: VBProject read Get_VBProject;
    property ReadOnly: MsoTriState read Get_ReadOnly;
    property FullName: WideString read Get_FullName;
    property Name: WideString read Get_Name;
    property Path: WideString read Get_Path;
    property Saved: MsoTriState read Get_Saved write Set_Saved;
    property LayoutDirection: PpDirection read Get_LayoutDirection write Set_LayoutDirection;
    property PrintOptions: PrintOptions read Get_PrintOptions;
    property Container: IDispatch read Get_Container;
    property DisplayComments: MsoTriState read Get_DisplayComments write Set_DisplayComments;
    property FarEastLineBreakLevel: PpFarEastLineBreakLevel read Get_FarEastLineBreakLevel write Set_FarEastLineBreakLevel;
    property NoLineBreakBefore: WideString read Get_NoLineBreakBefore write Set_NoLineBreakBefore;
    property NoLineBreakAfter: WideString read Get_NoLineBreakAfter write Set_NoLineBreakAfter;
    property SlideShowWindow: SlideShowWindow read Get_SlideShowWindow;
    property FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID read Get_FarEastLineBreakLanguage write Set_FarEastLineBreakLanguage;
    property DefaultLanguageID: MsoLanguageID read Get_DefaultLanguageID write Set_DefaultLanguageID;
    property CommandBars: CommandBars read Get_CommandBars;
    property PublishObjects: PublishObjects read Get_PublishObjects;
    property WebOptions: WebOptions read Get_WebOptions;
    property HTMLProject: HTMLProject read Get_HTMLProject;
    property EnvelopeVisible: MsoTriState read Get_EnvelopeVisible write Set_EnvelopeVisible;
    property VBASigned: MsoTriState read Get_VBASigned;
  end;

// *********************************************************************//
// DispIntf:  _PresentationDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349D-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _PresentationDisp = dispinterface
    ['{9149349D-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property SlideMaster: _Master readonly dispid 2003;
    property TitleMaster: _Master readonly dispid 2004;
    property HasTitleMaster: MsoTriState readonly dispid 2005;
    function AddTitleMaster: _Master; dispid 2006;
    procedure ApplyTemplate(const FileName: WideString); dispid 2007;
    property TemplateName: WideString readonly dispid 2008;
    property NotesMaster: _Master readonly dispid 2009;
    property HandoutMaster: _Master readonly dispid 2010;
    property Slides: Slides readonly dispid 2011;
    property PageSetup: PageSetup readonly dispid 2012;
    property ColorSchemes: ColorSchemes readonly dispid 2013;
    property ExtraColors: ExtraColors readonly dispid 2014;
    property SlideShowSettings: SlideShowSettings readonly dispid 2015;
    property Fonts: Fonts readonly dispid 2016;
    property Windows: DocumentWindows readonly dispid 2017;
    property Tags: Tags readonly dispid 2018;
    property DefaultShape: Shape readonly dispid 2019;
    property BuiltInDocumentProperties: IDispatch readonly dispid 2020;
    property CustomDocumentProperties: IDispatch readonly dispid 2021;
    property VBProject: VBProject readonly dispid 2022;
    property ReadOnly: MsoTriState readonly dispid 2023;
    property FullName: WideString readonly dispid 2024;
    property Name: WideString readonly dispid 2025;
    property Path: WideString readonly dispid 2026;
    property Saved: MsoTriState dispid 2027;
    property LayoutDirection: PpDirection dispid 2028;
    function NewWindow: DocumentWindow; dispid 2029;
    procedure FollowHyperlink(const Address: WideString; const SubAddress: WideString; 
                              NewWindow: WordBool; AddHistory: WordBool; 
                              const ExtraInfo: WideString; Method: MsoExtraInfoMethod; 
                              const HeaderInfo: WideString); dispid 2030;
    procedure AddToFavorites; dispid 2031;
    procedure Unused; dispid 2032;
    property PrintOptions: PrintOptions readonly dispid 2033;
    procedure PrintOut(From: SYSINT; To_: SYSINT; const PrintToFile: WideString; Copies: SYSINT; 
                       Collate: MsoTriState); dispid 2034;
    procedure Save; dispid 2035;
    procedure SaveAs(const FileName: WideString; FileFormat: PpSaveAsFileType; 
                     EmbedTrueTypeFonts: MsoTriState); dispid 2036;
    procedure SaveCopyAs(const FileName: WideString; FileFormat: PpSaveAsFileType; 
                         EmbedTrueTypeFonts: MsoTriState); dispid 2037;
    procedure Export(const Path: WideString; const FilterName: WideString; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT); dispid 2038;
    procedure Close; dispid 2039;
    procedure SetUndoText(const Text: WideString); dispid 2040;
    property Container: IDispatch readonly dispid 2041;
    property DisplayComments: MsoTriState dispid 2042;
    property FarEastLineBreakLevel: PpFarEastLineBreakLevel dispid 2043;
    property NoLineBreakBefore: WideString dispid 2044;
    property NoLineBreakAfter: WideString dispid 2045;
    procedure UpdateLinks; dispid 2046;
    property SlideShowWindow: SlideShowWindow readonly dispid 2047;
    property FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID dispid 2048;
    procedure WebPagePreview; dispid 2049;
    property DefaultLanguageID: MsoLanguageID dispid 2050;
    property CommandBars: CommandBars readonly dispid 2051;
    property PublishObjects: PublishObjects readonly dispid 2052;
    property WebOptions: WebOptions readonly dispid 2053;
    property HTMLProject: HTMLProject readonly dispid 2054;
    procedure ReloadAs(cp: MsoEncoding); dispid 2055;
    procedure MakeIntoTemplate(IsDesignTemplate: MsoTriState); dispid 2056;
    property EnvelopeVisible: MsoTriState dispid 2057;
    procedure sblt(const s: WideString); dispid 2058;
    property VBASigned: MsoTriState readonly dispid 2059;
  end;

// *********************************************************************//
// Interface: Hyperlinks
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493464-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Hyperlinks = interface(Collection)
    ['{91493464-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): Hyperlink; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  HyperlinksDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493464-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  HyperlinksDisp = dispinterface
    ['{91493464-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): Hyperlink; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: Hyperlink
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493465-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Hyperlink = interface(IDispatch)
    ['{91493465-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_type_: MsoHyperlinkType; safecall;
    function Get_Address: WideString; safecall;
    procedure Set_Address(const Address: WideString); safecall;
    function Get_SubAddress: WideString; safecall;
    procedure Set_SubAddress(const SubAddress: WideString); safecall;
    procedure AddToFavorites; safecall;
    function Get_EmailSubject: WideString; safecall;
    procedure Set_EmailSubject(const EmailSubject: WideString); safecall;
    function Get_ScreenTip: WideString; safecall;
    procedure Set_ScreenTip(const ScreenTip: WideString); safecall;
    function Get_TextToDisplay: WideString; safecall;
    procedure Set_TextToDisplay(const TextToDisplay: WideString); safecall;
    function Get_ShowandReturn: MsoTriState; safecall;
    procedure Set_ShowandReturn(ShowandReturn: MsoTriState); safecall;
    procedure Follow; safecall;
    procedure CreateNewDocument(const FileName: WideString; EditNow: MsoTriState; 
                                Overwrite: MsoTriState); safecall;
    procedure Delete; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property type_: MsoHyperlinkType read Get_type_;
    property Address: WideString read Get_Address write Set_Address;
    property SubAddress: WideString read Get_SubAddress write Set_SubAddress;
    property EmailSubject: WideString read Get_EmailSubject write Set_EmailSubject;
    property ScreenTip: WideString read Get_ScreenTip write Set_ScreenTip;
    property TextToDisplay: WideString read Get_TextToDisplay write Set_TextToDisplay;
    property ShowandReturn: MsoTriState read Get_ShowandReturn write Set_ShowandReturn;
  end;

// *********************************************************************//
// DispIntf:  HyperlinkDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493465-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  HyperlinkDisp = dispinterface
    ['{91493465-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property type_: MsoHyperlinkType readonly dispid 2003;
    property Address: WideString dispid 2004;
    property SubAddress: WideString dispid 2005;
    procedure AddToFavorites; dispid 2006;
    property EmailSubject: WideString dispid 2007;
    property ScreenTip: WideString dispid 2008;
    property TextToDisplay: WideString dispid 2009;
    property ShowandReturn: MsoTriState dispid 2010;
    procedure Follow; dispid 2011;
    procedure CreateNewDocument(const FileName: WideString; EditNow: MsoTriState; 
                                Overwrite: MsoTriState); dispid 2012;
    procedure Delete; dispid 2013;
  end;

// *********************************************************************//
// Interface: PageSetup
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493466-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PageSetup = interface(IDispatch)
    ['{91493466-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_FirstSlideNumber: SYSINT; safecall;
    procedure Set_FirstSlideNumber(FirstSlideNumber: SYSINT); safecall;
    function Get_SlideHeight: Single; safecall;
    procedure Set_SlideHeight(SlideHeight: Single); safecall;
    function Get_SlideWidth: Single; safecall;
    procedure Set_SlideWidth(SlideWidth: Single); safecall;
    function Get_SlideSize: PpSlideSizeType; safecall;
    procedure Set_SlideSize(SlideSize: PpSlideSizeType); safecall;
    function Get_NotesOrientation: MsoOrientation; safecall;
    procedure Set_NotesOrientation(NotesOrientation: MsoOrientation); safecall;
    function Get_SlideOrientation: MsoOrientation; safecall;
    procedure Set_SlideOrientation(SlideOrientation: MsoOrientation); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property FirstSlideNumber: SYSINT read Get_FirstSlideNumber write Set_FirstSlideNumber;
    property SlideHeight: Single read Get_SlideHeight write Set_SlideHeight;
    property SlideWidth: Single read Get_SlideWidth write Set_SlideWidth;
    property SlideSize: PpSlideSizeType read Get_SlideSize write Set_SlideSize;
    property NotesOrientation: MsoOrientation read Get_NotesOrientation write Set_NotesOrientation;
    property SlideOrientation: MsoOrientation read Get_SlideOrientation write Set_SlideOrientation;
  end;

// *********************************************************************//
// DispIntf:  PageSetupDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493466-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PageSetupDisp = dispinterface
    ['{91493466-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property FirstSlideNumber: SYSINT dispid 2003;
    property SlideHeight: Single dispid 2004;
    property SlideWidth: Single dispid 2005;
    property SlideSize: PpSlideSizeType dispid 2006;
    property NotesOrientation: MsoOrientation dispid 2007;
    property SlideOrientation: MsoOrientation dispid 2008;
  end;

// *********************************************************************//
// Interface: Fonts
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493467-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Fonts = interface(Collection)
    ['{91493467-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: OleVariant): Font; safecall;
    procedure Replace(const Original: WideString; const Replacement: WideString); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  FontsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493467-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FontsDisp = dispinterface
    ['{91493467-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: OleVariant): Font; dispid 0;
    procedure Replace(const Original: WideString; const Replacement: WideString); dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: ExtraColors
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493468-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ExtraColors = interface(Collection)
    ['{91493468-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): MsoRGBType; safecall;
    procedure Add(Type_: MsoRGBType); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  ExtraColorsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493468-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ExtraColorsDisp = dispinterface
    ['{91493468-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): MsoRGBType; dispid 0;
    procedure Add(Type_: MsoRGBType); dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: Slides
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493469-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Slides = interface(Collection)
    ['{91493469-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: OleVariant): PowerPointSlide; safecall;
    function FindBySlideID(SlideID: Integer): PowerPointSlide; safecall;
    function Add(index: SYSINT; Layout: PpSlideLayout): PowerPointSlide; safecall;
    function InsertFromFile(const FileName: WideString; index: SYSINT; SlideStart: SYSINT; 
                            SlideEnd: SYSINT): SYSINT; safecall;
    function Range(index: OleVariant): SlideRange; safecall;
    function Paste(index: SYSINT): SlideRange; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  SlidesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493469-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlidesDisp = dispinterface
    ['{91493469-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: OleVariant): PowerPointSlide; dispid 0;
    function FindBySlideID(SlideID: Integer): PowerPointSlide; dispid 2003;
    function Add(index: SYSINT; Layout: PpSlideLayout): PowerPointSlide; dispid 2004;
    function InsertFromFile(const FileName: WideString; index: SYSINT; SlideStart: SYSINT; 
                            SlideEnd: SYSINT): SYSINT; dispid 2005;
    function Range(index: OleVariant): SlideRange; dispid 2006;
    function Paste(index: SYSINT): SlideRange; dispid 2007;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: _Slide
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _Slide = interface(IDispatch)
    ['{9149346A-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Shapes: Shapes; safecall;
    function Get_HeadersFooters: HeadersFooters; safecall;
    function Get_SlideShowTransition: SlideShowTransition; safecall;
    function Get_ColorScheme: ColorScheme; safecall;
    procedure Set_ColorScheme(const ColorScheme: ColorScheme); safecall;
    function Get_Background: ShapeRange; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function Get_SlideID: Integer; safecall;
    function Get_PrintSteps: SYSINT; safecall;
    procedure Select; safecall;
    procedure Cut; safecall;
    procedure Copy; safecall;
    function Get_Layout: PpSlideLayout; safecall;
    procedure Set_Layout(Layout: PpSlideLayout); safecall;
    function Duplicate: SlideRange; safecall;
    procedure Delete; safecall;
    function Get_Tags: Tags; safecall;
    function Get_SlideIndex: SYSINT; safecall;
    function Get_SlideNumber: SYSINT; safecall;
    function Get_DisplayMasterShapes: MsoTriState; safecall;
    procedure Set_DisplayMasterShapes(DisplayMasterShapes: MsoTriState); safecall;
    function Get_FollowMasterBackground: MsoTriState; safecall;
    procedure Set_FollowMasterBackground(FollowMasterBackground: MsoTriState); safecall;
    function Get_NotesPage: SlideRange; safecall;
    function Get_Master: _Master; safecall;
    function Get_Hyperlinks: Hyperlinks; safecall;
    procedure Export(const FileName: WideString; const FilterName: WideString; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT); safecall;
    function Get_Scripts: Scripts; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Shapes: Shapes read Get_Shapes;
    property HeadersFooters: HeadersFooters read Get_HeadersFooters;
    property SlideShowTransition: SlideShowTransition read Get_SlideShowTransition;
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property Background: ShapeRange read Get_Background;
    property Name: WideString read Get_Name write Set_Name;
    property SlideID: Integer read Get_SlideID;
    property PrintSteps: SYSINT read Get_PrintSteps;
    property Layout: PpSlideLayout read Get_Layout write Set_Layout;
    property Tags: Tags read Get_Tags;
    property SlideIndex: SYSINT read Get_SlideIndex;
    property SlideNumber: SYSINT read Get_SlideNumber;
    property DisplayMasterShapes: MsoTriState read Get_DisplayMasterShapes write Set_DisplayMasterShapes;
    property FollowMasterBackground: MsoTriState read Get_FollowMasterBackground write Set_FollowMasterBackground;
    property NotesPage: SlideRange read Get_NotesPage;
    property Master: _Master read Get_Master;
    property Hyperlinks: Hyperlinks read Get_Hyperlinks;
    property Scripts: Scripts read Get_Scripts;
  end;

// *********************************************************************//
// DispIntf:  _SlideDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _SlideDisp = dispinterface
    ['{9149346A-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Shapes: Shapes readonly dispid 2003;
    property HeadersFooters: HeadersFooters readonly dispid 2004;
    property SlideShowTransition: SlideShowTransition readonly dispid 2005;
    property ColorScheme: ColorScheme dispid 2006;
    property Background: ShapeRange readonly dispid 2007;
    property Name: WideString dispid 2008;
    property SlideID: Integer readonly dispid 2009;
    property PrintSteps: SYSINT readonly dispid 2010;
    procedure Select; dispid 2011;
    procedure Cut; dispid 2012;
    procedure Copy; dispid 2013;
    property Layout: PpSlideLayout dispid 2014;
    function Duplicate: SlideRange; dispid 2015;
    procedure Delete; dispid 2016;
    property Tags: Tags readonly dispid 2017;
    property SlideIndex: SYSINT readonly dispid 2018;
    property SlideNumber: SYSINT readonly dispid 2019;
    property DisplayMasterShapes: MsoTriState dispid 2020;
    property FollowMasterBackground: MsoTriState dispid 2021;
    property NotesPage: SlideRange readonly dispid 2022;
    property Master: _Master readonly dispid 2023;
    property Hyperlinks: Hyperlinks readonly dispid 2024;
    procedure Export(const FileName: WideString; const FilterName: WideString; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT); dispid 2025;
    property Scripts: Scripts readonly dispid 2026;
  end;

// *********************************************************************//
// Interface: SlideRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideRange = interface(IDispatch)
    ['{9149346B-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Shapes: Shapes; safecall;
    function Get_HeadersFooters: HeadersFooters; safecall;
    function Get_SlideShowTransition: SlideShowTransition; safecall;
    function Get_ColorScheme: ColorScheme; safecall;
    procedure Set_ColorScheme(const ColorScheme: ColorScheme); safecall;
    function Get_Background: ShapeRange; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function Get_SlideID: Integer; safecall;
    function Get_PrintSteps: SYSINT; safecall;
    procedure Select; safecall;
    procedure Cut; safecall;
    procedure Copy; safecall;
    function Get_Layout: PpSlideLayout; safecall;
    procedure Set_Layout(Layout: PpSlideLayout); safecall;
    function Duplicate: SlideRange; safecall;
    procedure Delete; safecall;
    function Get_Tags: Tags; safecall;
    function Get_SlideIndex: SYSINT; safecall;
    function Get_SlideNumber: SYSINT; safecall;
    function Get_DisplayMasterShapes: MsoTriState; safecall;
    procedure Set_DisplayMasterShapes(DisplayMasterShapes: MsoTriState); safecall;
    function Get_FollowMasterBackground: MsoTriState; safecall;
    procedure Set_FollowMasterBackground(FollowMasterBackground: MsoTriState); safecall;
    function Get_NotesPage: SlideRange; safecall;
    function Get_Master: _Master; safecall;
    function Get_Hyperlinks: Hyperlinks; safecall;
    procedure Export(const FileName: WideString; const FilterName: WideString; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT); safecall;
    function Item(index: OleVariant): PowerPointSlide; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function _Index(index: SYSINT): OleVariant; safecall;
    function Get_Count: Integer; safecall;
    function Get_Scripts: Scripts; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Shapes: Shapes read Get_Shapes;
    property HeadersFooters: HeadersFooters read Get_HeadersFooters;
    property SlideShowTransition: SlideShowTransition read Get_SlideShowTransition;
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property Background: ShapeRange read Get_Background;
    property Name: WideString read Get_Name write Set_Name;
    property SlideID: Integer read Get_SlideID;
    property PrintSteps: SYSINT read Get_PrintSteps;
    property Layout: PpSlideLayout read Get_Layout write Set_Layout;
    property Tags: Tags read Get_Tags;
    property SlideIndex: SYSINT read Get_SlideIndex;
    property SlideNumber: SYSINT read Get_SlideNumber;
    property DisplayMasterShapes: MsoTriState read Get_DisplayMasterShapes write Set_DisplayMasterShapes;
    property FollowMasterBackground: MsoTriState read Get_FollowMasterBackground write Set_FollowMasterBackground;
    property NotesPage: SlideRange read Get_NotesPage;
    property Master: _Master read Get_Master;
    property Hyperlinks: Hyperlinks read Get_Hyperlinks;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
    property Scripts: Scripts read Get_Scripts;
  end;

// *********************************************************************//
// DispIntf:  SlideRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideRangeDisp = dispinterface
    ['{9149346B-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Shapes: Shapes readonly dispid 2003;
    property HeadersFooters: HeadersFooters readonly dispid 2004;
    property SlideShowTransition: SlideShowTransition readonly dispid 2005;
    property ColorScheme: ColorScheme dispid 2006;
    property Background: ShapeRange readonly dispid 2007;
    property Name: WideString dispid 2008;
    property SlideID: Integer readonly dispid 2009;
    property PrintSteps: SYSINT readonly dispid 2010;
    procedure Select; dispid 2011;
    procedure Cut; dispid 2012;
    procedure Copy; dispid 2013;
    property Layout: PpSlideLayout dispid 2014;
    function Duplicate: SlideRange; dispid 2015;
    procedure Delete; dispid 2016;
    property Tags: Tags readonly dispid 2017;
    property SlideIndex: SYSINT readonly dispid 2018;
    property SlideNumber: SYSINT readonly dispid 2019;
    property DisplayMasterShapes: MsoTriState dispid 2020;
    property FollowMasterBackground: MsoTriState dispid 2021;
    property NotesPage: SlideRange readonly dispid 2022;
    property Master: _Master readonly dispid 2023;
    property Hyperlinks: Hyperlinks readonly dispid 2024;
    procedure Export(const FileName: WideString; const FilterName: WideString; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT); dispid 2025;
    function Item(index: OleVariant): PowerPointSlide; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
    property Scripts: Scripts readonly dispid 2026;
  end;

// *********************************************************************//
// Interface: _Master
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _Master = interface(IDispatch)
    ['{9149346C-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Shapes: Shapes; safecall;
    function Get_HeadersFooters: HeadersFooters; safecall;
    function Get_ColorScheme: ColorScheme; safecall;
    procedure Set_ColorScheme(const ColorScheme: ColorScheme); safecall;
    function Get_Background: ShapeRange; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    procedure Delete; safecall;
    function Get_Height: Single; safecall;
    function Get_Width: Single; safecall;
    function Get_TextStyles: TextStyles; safecall;
    function Get_Hyperlinks: Hyperlinks; safecall;
    function Get_Scripts: Scripts; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Shapes: Shapes read Get_Shapes;
    property HeadersFooters: HeadersFooters read Get_HeadersFooters;
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property Background: ShapeRange read Get_Background;
    property Name: WideString read Get_Name write Set_Name;
    property Height: Single read Get_Height;
    property Width: Single read Get_Width;
    property TextStyles: TextStyles read Get_TextStyles;
    property Hyperlinks: Hyperlinks read Get_Hyperlinks;
    property Scripts: Scripts read Get_Scripts;
  end;

// *********************************************************************//
// DispIntf:  _MasterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  _MasterDisp = dispinterface
    ['{9149346C-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Shapes: Shapes readonly dispid 2003;
    property HeadersFooters: HeadersFooters readonly dispid 2004;
    property ColorScheme: ColorScheme dispid 2005;
    property Background: ShapeRange readonly dispid 2006;
    property Name: WideString dispid 2007;
    procedure Delete; dispid 2008;
    property Height: Single readonly dispid 2009;
    property Width: Single readonly dispid 2010;
    property TextStyles: TextStyles readonly dispid 2011;
    property Hyperlinks: Hyperlinks readonly dispid 2012;
    property Scripts: Scripts readonly dispid 2013;
  end;

// *********************************************************************//
// Interface: SldEvents
// Flags:     (16) Hidden
// GUID:      {9149346D-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SldEvents = interface(IUnknown)
    ['{9149346D-5A91-11CF-8700-00AA0060263B}']
  end;

// *********************************************************************//
// Interface: ColorSchemes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ColorSchemes = interface(Collection)
    ['{9149346E-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): ColorScheme; safecall;
    function Add(const Scheme: ColorScheme): ColorScheme; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  ColorSchemesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ColorSchemesDisp = dispinterface
    ['{9149346E-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): ColorScheme; dispid 0;
    function Add(const Scheme: ColorScheme): ColorScheme; dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: ColorScheme
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ColorScheme = interface(Collection)
    ['{9149346F-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Colors(SchemeColor: PpColorSchemeIndex): RGBColor; safecall;
    procedure Delete; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  ColorSchemeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149346F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ColorSchemeDisp = dispinterface
    ['{9149346F-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Colors(SchemeColor: PpColorSchemeIndex): RGBColor; dispid 0;
    procedure Delete; dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: RGBColor
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493470-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  RGBColor = interface(IDispatch)
    ['{91493470-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_RGB: MsoRGBType; safecall;
    procedure Set_RGB(RGB: MsoRGBType); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property RGB: MsoRGBType read Get_RGB write Set_RGB;
  end;

// *********************************************************************//
// DispIntf:  RGBColorDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493470-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  RGBColorDisp = dispinterface
    ['{91493470-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property RGB: MsoRGBType dispid 0;
  end;

// *********************************************************************//
// Interface: SlideShowTransition
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493471-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowTransition = interface(IDispatch)
    ['{91493471-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_AdvanceOnClick: MsoTriState; safecall;
    procedure Set_AdvanceOnClick(AdvanceOnClick: MsoTriState); safecall;
    function Get_AdvanceOnTime: MsoTriState; safecall;
    procedure Set_AdvanceOnTime(AdvanceOnTime: MsoTriState); safecall;
    function Get_AdvanceTime: Single; safecall;
    procedure Set_AdvanceTime(AdvanceTime: Single); safecall;
    function Get_EntryEffect: PpEntryEffect; safecall;
    procedure Set_EntryEffect(EntryEffect: PpEntryEffect); safecall;
    function Get_Hidden: MsoTriState; safecall;
    procedure Set_Hidden(Hidden: MsoTriState); safecall;
    function Get_LoopSoundUntilNext: MsoTriState; safecall;
    procedure Set_LoopSoundUntilNext(LoopSoundUntilNext: MsoTriState); safecall;
    function Get_SoundEffect: SoundEffect; safecall;
    function Get_Speed: PpTransitionSpeed; safecall;
    procedure Set_Speed(Speed: PpTransitionSpeed); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property AdvanceOnClick: MsoTriState read Get_AdvanceOnClick write Set_AdvanceOnClick;
    property AdvanceOnTime: MsoTriState read Get_AdvanceOnTime write Set_AdvanceOnTime;
    property AdvanceTime: Single read Get_AdvanceTime write Set_AdvanceTime;
    property EntryEffect: PpEntryEffect read Get_EntryEffect write Set_EntryEffect;
    property Hidden: MsoTriState read Get_Hidden write Set_Hidden;
    property LoopSoundUntilNext: MsoTriState read Get_LoopSoundUntilNext write Set_LoopSoundUntilNext;
    property SoundEffect: SoundEffect read Get_SoundEffect;
    property Speed: PpTransitionSpeed read Get_Speed write Set_Speed;
  end;

// *********************************************************************//
// DispIntf:  SlideShowTransitionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493471-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SlideShowTransitionDisp = dispinterface
    ['{91493471-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property AdvanceOnClick: MsoTriState dispid 2003;
    property AdvanceOnTime: MsoTriState dispid 2004;
    property AdvanceTime: Single dispid 2005;
    property EntryEffect: PpEntryEffect dispid 2006;
    property Hidden: MsoTriState dispid 2007;
    property LoopSoundUntilNext: MsoTriState dispid 2008;
    property SoundEffect: SoundEffect readonly dispid 2009;
    property Speed: PpTransitionSpeed dispid 2010;
  end;

// *********************************************************************//
// Interface: SoundEffect
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493472-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SoundEffect = interface(IDispatch)
    ['{91493472-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function Get_type_: PpSoundEffectType; safecall;
    procedure Set_type_(Type_: PpSoundEffectType); safecall;
    procedure ImportFromFile(const FileName: WideString); safecall;
    procedure Play; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Name: WideString read Get_Name write Set_Name;
    property type_: PpSoundEffectType read Get_type_ write Set_type_;
  end;

// *********************************************************************//
// DispIntf:  SoundEffectDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493472-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SoundEffectDisp = dispinterface
    ['{91493472-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Name: WideString dispid 2003;
    property type_: PpSoundEffectType dispid 2004;
    procedure ImportFromFile(const FileName: WideString); dispid 2005;
    procedure Play; dispid 2006;
  end;

// *********************************************************************//
// Interface: SoundFormat
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493473-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SoundFormat = interface(IDispatch)
    ['{91493473-5A91-11CF-8700-00AA0060263B}']
    procedure Play; safecall;
    procedure Import(const FileName: WideString); safecall;
    function Export(const FileName: WideString): PpSoundFormatType; safecall;
    function Get_type_: PpSoundFormatType; safecall;
    function Get_SourceFullName: WideString; safecall;
    property type_: PpSoundFormatType read Get_type_;
    property SourceFullName: WideString read Get_SourceFullName;
  end;

// *********************************************************************//
// DispIntf:  SoundFormatDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493473-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  SoundFormatDisp = dispinterface
    ['{91493473-5A91-11CF-8700-00AA0060263B}']
    procedure Play; dispid 2000;
    procedure Import(const FileName: WideString); dispid 2001;
    function Export(const FileName: WideString): PpSoundFormatType; dispid 2002;
    property type_: PpSoundFormatType readonly dispid 2003;
    property SourceFullName: WideString readonly dispid 2004;
  end;

// *********************************************************************//
// Interface: HeadersFooters
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493474-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  HeadersFooters = interface(IDispatch)
    ['{91493474-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_DateAndTime: HeaderFooter; safecall;
    function Get_SlideNumber: HeaderFooter; safecall;
    function Get_Header: HeaderFooter; safecall;
    function Get_Footer: HeaderFooter; safecall;
    function Get_DisplayOnTitleSlide: MsoTriState; safecall;
    procedure Set_DisplayOnTitleSlide(DisplayOnTitleSlide: MsoTriState); safecall;
    procedure Clear; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property DateAndTime: HeaderFooter read Get_DateAndTime;
    property SlideNumber: HeaderFooter read Get_SlideNumber;
    property Header: HeaderFooter read Get_Header;
    property Footer: HeaderFooter read Get_Footer;
    property DisplayOnTitleSlide: MsoTriState read Get_DisplayOnTitleSlide write Set_DisplayOnTitleSlide;
  end;

// *********************************************************************//
// DispIntf:  HeadersFootersDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493474-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  HeadersFootersDisp = dispinterface
    ['{91493474-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property DateAndTime: HeaderFooter readonly dispid 2003;
    property SlideNumber: HeaderFooter readonly dispid 2004;
    property Header: HeaderFooter readonly dispid 2005;
    property Footer: HeaderFooter readonly dispid 2006;
    property DisplayOnTitleSlide: MsoTriState dispid 2007;
    procedure Clear; dispid 2008;
  end;

// *********************************************************************//
// Interface: Shapes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493475-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Shapes = interface(IDispatch)
    ['{91493475-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Count: SYSINT; safecall;
    function Item(index: OleVariant): Shape; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function AddCallout(Type_: MsoCalloutType; Left: Single; Top: Single; Width: Single; 
                        Height: Single): Shape; safecall;
    function AddConnector(Type_: MsoConnectorType; BeginX: Single; BeginY: Single; EndX: Single; 
                          EndY: Single): Shape; safecall;
    function AddCurve(SafeArrayOfPoints: OleVariant): Shape; safecall;
    function AddLabel(Orientation: MsoTextOrientation; Left: Single; Top: Single; Width: Single; 
                      Height: Single): Shape; safecall;
    function AddLine(BeginX: Single; BeginY: Single; EndX: Single; EndY: Single): Shape; safecall;
    function AddPicture(const FileName: WideString; LinkToFile: MsoTriState; 
                        SaveWithDocument: MsoTriState; Left: Single; Top: Single; Width: Single; 
                        Height: Single): Shape; safecall;
    function AddPolyline(SafeArrayOfPoints: OleVariant): Shape; safecall;
    function AddShape(Type_: MsoAutoShapeType; Left: Single; Top: Single; Width: Single; 
                      Height: Single): Shape; safecall;
    function AddTextEffect(PresetTextEffect: MsoPresetTextEffect; const Text: WideString; 
                           const FontName: WideString; FontSize: Single; FontBold: MsoTriState; 
                           FontItalic: MsoTriState; Left: Single; Top: Single): Shape; safecall;
    function AddTextbox(Orientation: MsoTextOrientation; Left: Single; Top: Single; Width: Single; 
                        Height: Single): Shape; safecall;
    function BuildFreeform(EditingType: MsoEditingType; X1: Single; Y1: Single): FreeformBuilder; safecall;
    procedure SelectAll; safecall;
    function Range(index: OleVariant): ShapeRange; safecall;
    function Get_HasTitle: MsoTriState; safecall;
    function AddTitle: Shape; safecall;
    function Get_Title: Shape; safecall;
    function Get_Placeholders: Placeholders; safecall;
    function AddOLEObject(Left: Single; Top: Single; Width: Single; Height: Single; 
                          const ClassName: WideString; const FileName: WideString; 
                          DisplayAsIcon: MsoTriState; const IconFileName: WideString; 
                          IconIndex: SYSINT; const IconLabel: WideString; Link: MsoTriState): Shape; safecall;
    function AddComment(Left: Single; Top: Single; Width: Single; Height: Single): Shape; safecall;
    function AddPlaceholder(Type_: PpPlaceholderType; Left: Single; Top: Single; Width: Single; 
                            Height: Single): Shape; safecall;
    function AddMediaObject(const FileName: WideString; Left: Single; Top: Single; Width: Single; 
                            Height: Single): Shape; safecall;
    function Paste: ShapeRange; safecall;
    function AddTable(NumRows: SYSINT; NumColumns: SYSINT; Left: Single; Top: Single; 
                      Width: Single; Height: Single): Shape; safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
    property HasTitle: MsoTriState read Get_HasTitle;
    property Title: Shape read Get_Title;
    property Placeholders: Placeholders read Get_Placeholders;
  end;

// *********************************************************************//
// DispIntf:  ShapesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493475-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShapesDisp = dispinterface
    ['{91493475-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    property Count: SYSINT readonly dispid 2;
    function Item(index: OleVariant): Shape; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function AddCallout(Type_: MsoCalloutType; Left: Single; Top: Single; Width: Single; 
                        Height: Single): Shape; dispid 10;
    function AddConnector(Type_: MsoConnectorType; BeginX: Single; BeginY: Single; EndX: Single; 
                          EndY: Single): Shape; dispid 11;
    function AddCurve(SafeArrayOfPoints: OleVariant): Shape; dispid 12;
    function AddLabel(Orientation: MsoTextOrientation; Left: Single; Top: Single; Width: Single; 
                      Height: Single): Shape; dispid 13;
    function AddLine(BeginX: Single; BeginY: Single; EndX: Single; EndY: Single): Shape; dispid 14;
    function AddPicture(const FileName: WideString; LinkToFile: MsoTriState; 
                        SaveWithDocument: MsoTriState; Left: Single; Top: Single; Width: Single; 
                        Height: Single): Shape; dispid 15;
    function AddPolyline(SafeArrayOfPoints: OleVariant): Shape; dispid 16;
    function AddShape(Type_: MsoAutoShapeType; Left: Single; Top: Single; Width: Single; 
                      Height: Single): Shape; dispid 17;
    function AddTextEffect(PresetTextEffect: MsoPresetTextEffect; const Text: WideString; 
                           const FontName: WideString; FontSize: Single; FontBold: MsoTriState; 
                           FontItalic: MsoTriState; Left: Single; Top: Single): Shape; dispid 18;
    function AddTextbox(Orientation: MsoTextOrientation; Left: Single; Top: Single; Width: Single; 
                        Height: Single): Shape; dispid 19;
    function BuildFreeform(EditingType: MsoEditingType; X1: Single; Y1: Single): FreeformBuilder; dispid 20;
    procedure SelectAll; dispid 22;
    function Range(index: OleVariant): ShapeRange; dispid 2003;
    property HasTitle: MsoTriState readonly dispid 2004;
    function AddTitle: Shape; dispid 2005;
    property Title: Shape readonly dispid 2006;
    property Placeholders: Placeholders readonly dispid 2007;
    function AddOLEObject(Left: Single; Top: Single; Width: Single; Height: Single; 
                          const ClassName: WideString; const FileName: WideString; 
                          DisplayAsIcon: MsoTriState; const IconFileName: WideString; 
                          IconIndex: SYSINT; const IconLabel: WideString; Link: MsoTriState): Shape; dispid 2008;
    function AddComment(Left: Single; Top: Single; Width: Single; Height: Single): Shape; dispid 2009;
    function AddPlaceholder(Type_: PpPlaceholderType; Left: Single; Top: Single; Width: Single; 
                            Height: Single): Shape; dispid 2010;
    function AddMediaObject(const FileName: WideString; Left: Single; Top: Single; Width: Single; 
                            Height: Single): Shape; dispid 2011;
    function Paste: ShapeRange; dispid 2012;
    function AddTable(NumRows: SYSINT; NumColumns: SYSINT; Left: Single; Top: Single; 
                      Width: Single; Height: Single): Shape; dispid 2013;
  end;

// *********************************************************************//
// Interface: Placeholders
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493476-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Placeholders = interface(Collection)
    ['{91493476-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): Shape; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  PlaceholdersDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493476-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PlaceholdersDisp = dispinterface
    ['{91493476-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): Shape; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: PlaceholderFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493477-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PlaceholderFormat = interface(IDispatch)
    ['{91493477-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_type_: PpPlaceholderType; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property type_: PpPlaceholderType read Get_type_;
  end;

// *********************************************************************//
// DispIntf:  PlaceholderFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493477-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PlaceholderFormatDisp = dispinterface
    ['{91493477-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property type_: PpPlaceholderType readonly dispid 2003;
  end;

// *********************************************************************//
// Interface: FreeformBuilder
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493478-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FreeformBuilder = interface(IDispatch)
    ['{91493478-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure AddNodes(SegmentType: MsoSegmentType; EditingType: MsoEditingType; X1: Single; 
                       Y1: Single; X2: Single; Y2: Single; X3: Single; Y3: Single); safecall;
    function ConvertToShape: Shape; safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  FreeformBuilderDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493478-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FreeformBuilderDisp = dispinterface
    ['{91493478-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    procedure AddNodes(SegmentType: MsoSegmentType; EditingType: MsoEditingType; X1: Single; 
                       Y1: Single; X2: Single; Y2: Single; X3: Single; Y3: Single); dispid 10;
    function ConvertToShape: Shape; dispid 11;
  end;

// *********************************************************************//
// Interface: Shape
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493479-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Shape = interface(IDispatch)
    ['{91493479-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure Apply; safecall;
    procedure Delete; safecall;
    procedure Flip(FlipCmd: MsoFlipCmd); safecall;
    procedure IncrementLeft(Increment: Single); safecall;
    procedure IncrementRotation(Increment: Single); safecall;
    procedure IncrementTop(Increment: Single); safecall;
    procedure PickUp; safecall;
    procedure RerouteConnections; safecall;
    procedure ScaleHeight(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); safecall;
    procedure ScaleWidth(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); safecall;
    procedure SetShapesDefaultProperties; safecall;
    function Ungroup: ShapeRange; safecall;
    procedure ZOrder(ZOrderCmd: MsoZOrderCmd); safecall;
    function Get_Adjustments: Adjustments; safecall;
    function Get_AutoShapeType: MsoAutoShapeType; safecall;
    procedure Set_AutoShapeType(AutoShapeType: MsoAutoShapeType); safecall;
    function Get_BlackWhiteMode: MsoBlackWhiteMode; safecall;
    procedure Set_BlackWhiteMode(BlackWhiteMode: MsoBlackWhiteMode); safecall;
    function Get_Callout: CalloutFormat; safecall;
    function Get_ConnectionSiteCount: SYSINT; safecall;
    function Get_Connector: MsoTriState; safecall;
    function Get_ConnectorFormat: ConnectorFormat; safecall;
    function Get_Fill: FillFormat; safecall;
    function Get_GroupItems: GroupShapes; safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(Height: Single); safecall;
    function Get_HorizontalFlip: MsoTriState; safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(Left: Single); safecall;
    function Get_Line: LineFormat; safecall;
    function Get_LockAspectRatio: MsoTriState; safecall;
    procedure Set_LockAspectRatio(LockAspectRatio: MsoTriState); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function Get_Nodes: ShapeNodes; safecall;
    function Get_Rotation: Single; safecall;
    procedure Set_Rotation(Rotation: Single); safecall;
    function Get_PictureFormat: PictureFormat; safecall;
    function Get_Shadow: ShadowFormat; safecall;
    function Get_TextEffect: TextEffectFormat; safecall;
    function Get_TextFrame: TextFrame; safecall;
    function Get_ThreeD: ThreeDFormat; safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(Top: Single); safecall;
    function Get_type_: MsoShapeType; safecall;
    function Get_VerticalFlip: MsoTriState; safecall;
    function Get_Vertices: OleVariant; safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(Width: Single); safecall;
    function Get_ZOrderPosition: SYSINT; safecall;
    function Get_OLEFormat: OLEFormat; safecall;
    function Get_LinkFormat: LinkFormat; safecall;
    function Get_PlaceholderFormat: PlaceholderFormat; safecall;
    function Get_AnimationSettings: AnimationSettings; safecall;
    function Get_ActionSettings: ActionSettings; safecall;
    function Get_Tags: Tags; safecall;
    procedure Cut; safecall;
    procedure Copy; safecall;
    procedure Select(Replace: MsoTriState); safecall;
    function Duplicate: ShapeRange; safecall;
    function Get_MediaType: PpMediaType; safecall;
    function Get_HasTextFrame: MsoTriState; safecall;
    function Get_SoundFormat: SoundFormat; safecall;
    function Get_Script: Script; safecall;
    function Get_AlternativeText: WideString; safecall;
    procedure Set_AlternativeText(const AlternativeText: WideString); safecall;
    function Get_HasTable: MsoTriState; safecall;
    function Get_Table: Table; safecall;
    procedure Export(const PathName: WideString; Filter: PpShapeFormat; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT; ExportMode: PpExportMode); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Adjustments: Adjustments read Get_Adjustments;
    property AutoShapeType: MsoAutoShapeType read Get_AutoShapeType write Set_AutoShapeType;
    property BlackWhiteMode: MsoBlackWhiteMode read Get_BlackWhiteMode write Set_BlackWhiteMode;
    property Callout: CalloutFormat read Get_Callout;
    property ConnectionSiteCount: SYSINT read Get_ConnectionSiteCount;
    property Connector: MsoTriState read Get_Connector;
    property ConnectorFormat: ConnectorFormat read Get_ConnectorFormat;
    property Fill: FillFormat read Get_Fill;
    property GroupItems: GroupShapes read Get_GroupItems;
    property Height: Single read Get_Height write Set_Height;
    property HorizontalFlip: MsoTriState read Get_HorizontalFlip;
    property Left: Single read Get_Left write Set_Left;
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
    property Top: Single read Get_Top write Set_Top;
    property type_: MsoShapeType read Get_type_;
    property VerticalFlip: MsoTriState read Get_VerticalFlip;
    property Vertices: OleVariant read Get_Vertices;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property Width: Single read Get_Width write Set_Width;
    property ZOrderPosition: SYSINT read Get_ZOrderPosition;
    property OLEFormat: OLEFormat read Get_OLEFormat;
    property LinkFormat: LinkFormat read Get_LinkFormat;
    property PlaceholderFormat: PlaceholderFormat read Get_PlaceholderFormat;
    property AnimationSettings: AnimationSettings read Get_AnimationSettings;
    property ActionSettings: ActionSettings read Get_ActionSettings;
    property Tags: Tags read Get_Tags;
    property MediaType: PpMediaType read Get_MediaType;
    property HasTextFrame: MsoTriState read Get_HasTextFrame;
    property SoundFormat: SoundFormat read Get_SoundFormat;
    property Script: Script read Get_Script;
    property AlternativeText: WideString read Get_AlternativeText write Set_AlternativeText;
    property HasTable: MsoTriState read Get_HasTable;
    property Table: Table read Get_Table;
  end;

// *********************************************************************//
// DispIntf:  ShapeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493479-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShapeDisp = dispinterface
    ['{91493479-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    procedure Apply; dispid 10;
    procedure Delete; dispid 11;
    procedure Flip(FlipCmd: MsoFlipCmd); dispid 13;
    procedure IncrementLeft(Increment: Single); dispid 14;
    procedure IncrementRotation(Increment: Single); dispid 15;
    procedure IncrementTop(Increment: Single); dispid 16;
    procedure PickUp; dispid 17;
    procedure RerouteConnections; dispid 18;
    procedure ScaleHeight(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); dispid 19;
    procedure ScaleWidth(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); dispid 20;
    procedure SetShapesDefaultProperties; dispid 22;
    function Ungroup: ShapeRange; dispid 23;
    procedure ZOrder(ZOrderCmd: MsoZOrderCmd); dispid 24;
    property Adjustments: Adjustments readonly dispid 100;
    property AutoShapeType: MsoAutoShapeType dispid 101;
    property BlackWhiteMode: MsoBlackWhiteMode dispid 102;
    property Callout: CalloutFormat readonly dispid 103;
    property ConnectionSiteCount: SYSINT readonly dispid 104;
    property Connector: MsoTriState readonly dispid 105;
    property ConnectorFormat: ConnectorFormat readonly dispid 106;
    property Fill: FillFormat readonly dispid 107;
    property GroupItems: GroupShapes readonly dispid 108;
    property Height: Single dispid 109;
    property HorizontalFlip: MsoTriState readonly dispid 110;
    property Left: Single dispid 111;
    property Line: LineFormat readonly dispid 112;
    property LockAspectRatio: MsoTriState dispid 113;
    property Name: WideString dispid 115;
    property Nodes: ShapeNodes readonly dispid 116;
    property Rotation: Single dispid 117;
    property PictureFormat: PictureFormat readonly dispid 118;
    property Shadow: ShadowFormat readonly dispid 119;
    property TextEffect: TextEffectFormat readonly dispid 120;
    property TextFrame: TextFrame readonly dispid 121;
    property ThreeD: ThreeDFormat readonly dispid 122;
    property Top: Single dispid 123;
    property type_: MsoShapeType readonly dispid 124;
    property VerticalFlip: MsoTriState readonly dispid 125;
    property Vertices: OleVariant readonly dispid 126;
    property Visible: MsoTriState dispid 127;
    property Width: Single dispid 128;
    property ZOrderPosition: SYSINT readonly dispid 129;
    property OLEFormat: OLEFormat readonly dispid 2003;
    property LinkFormat: LinkFormat readonly dispid 2004;
    property PlaceholderFormat: PlaceholderFormat readonly dispid 2005;
    property AnimationSettings: AnimationSettings readonly dispid 2006;
    property ActionSettings: ActionSettings readonly dispid 2007;
    property Tags: Tags readonly dispid 2008;
    procedure Cut; dispid 2009;
    procedure Copy; dispid 2010;
    procedure Select(Replace: MsoTriState); dispid 2011;
    function Duplicate: ShapeRange; dispid 2012;
    property MediaType: PpMediaType readonly dispid 2013;
    property HasTextFrame: MsoTriState readonly dispid 2014;
    property SoundFormat: SoundFormat readonly dispid 2015;
    property Script: Script readonly dispid 130;
    property AlternativeText: WideString dispid 131;
    property HasTable: MsoTriState readonly dispid 2016;
    property Table: Table readonly dispid 2017;
    procedure Export(const PathName: WideString; Filter: PpShapeFormat; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT; ExportMode: PpExportMode); dispid 2018;
  end;

// *********************************************************************//
// Interface: ShapeRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShapeRange = interface(IDispatch)
    ['{9149347A-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure Apply; safecall;
    procedure Delete; safecall;
    procedure Flip(FlipCmd: MsoFlipCmd); safecall;
    procedure IncrementLeft(Increment: Single); safecall;
    procedure IncrementRotation(Increment: Single); safecall;
    procedure IncrementTop(Increment: Single); safecall;
    procedure PickUp; safecall;
    procedure RerouteConnections; safecall;
    procedure ScaleHeight(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); safecall;
    procedure ScaleWidth(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); safecall;
    procedure SetShapesDefaultProperties; safecall;
    function Ungroup: ShapeRange; safecall;
    procedure ZOrder(ZOrderCmd: MsoZOrderCmd); safecall;
    function Get_Adjustments: Adjustments; safecall;
    function Get_AutoShapeType: MsoAutoShapeType; safecall;
    procedure Set_AutoShapeType(AutoShapeType: MsoAutoShapeType); safecall;
    function Get_BlackWhiteMode: MsoBlackWhiteMode; safecall;
    procedure Set_BlackWhiteMode(BlackWhiteMode: MsoBlackWhiteMode); safecall;
    function Get_Callout: CalloutFormat; safecall;
    function Get_ConnectionSiteCount: SYSINT; safecall;
    function Get_Connector: MsoTriState; safecall;
    function Get_ConnectorFormat: ConnectorFormat; safecall;
    function Get_Fill: FillFormat; safecall;
    function Get_GroupItems: GroupShapes; safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(Height: Single); safecall;
    function Get_HorizontalFlip: MsoTriState; safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(Left: Single); safecall;
    function Get_Line: LineFormat; safecall;
    function Get_LockAspectRatio: MsoTriState; safecall;
    procedure Set_LockAspectRatio(LockAspectRatio: MsoTriState); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function Get_Nodes: ShapeNodes; safecall;
    function Get_Rotation: Single; safecall;
    procedure Set_Rotation(Rotation: Single); safecall;
    function Get_PictureFormat: PictureFormat; safecall;
    function Get_Shadow: ShadowFormat; safecall;
    function Get_TextEffect: TextEffectFormat; safecall;
    function Get_TextFrame: TextFrame; safecall;
    function Get_ThreeD: ThreeDFormat; safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(Top: Single); safecall;
    function Get_type_: MsoShapeType; safecall;
    function Get_VerticalFlip: MsoTriState; safecall;
    function Get_Vertices: OleVariant; safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(Width: Single); safecall;
    function Get_ZOrderPosition: SYSINT; safecall;
    function Get_OLEFormat: OLEFormat; safecall;
    function Get_LinkFormat: LinkFormat; safecall;
    function Get_PlaceholderFormat: PlaceholderFormat; safecall;
    function Get_AnimationSettings: AnimationSettings; safecall;
    function Get_ActionSettings: ActionSettings; safecall;
    function Get_Tags: Tags; safecall;
    procedure Cut; safecall;
    procedure Copy; safecall;
    procedure Select(Replace: MsoTriState); safecall;
    function Duplicate: ShapeRange; safecall;
    function Get_MediaType: PpMediaType; safecall;
    function Get_HasTextFrame: MsoTriState; safecall;
    function Get_SoundFormat: SoundFormat; safecall;
    function Item(index: OleVariant): Shape; safecall;
    function Get__NewEnum: IUnknown; safecall;
    function _Index(index: SYSINT): OleVariant; safecall;
    function Get_Count: Integer; safecall;
    function Group: Shape; safecall;
    function Regroup: Shape; safecall;
    procedure Align(AlignCmd: MsoAlignCmd; RelativeTo: MsoTriState); safecall;
    procedure Distribute(DistributeCmd: MsoDistributeCmd; RelativeTo: MsoTriState); safecall;
    procedure GetPolygonalRepresentation(maxPointsInBuffer: LongWord; var pPoints: Single; 
                                         out numPointsInPolygon: LongWord; out IsOpen: MsoTriState); safecall;
    function Get_Script: Script; safecall;
    function Get_AlternativeText: WideString; safecall;
    procedure Set_AlternativeText(const AlternativeText: WideString); safecall;
    function Get_HasTable: MsoTriState; safecall;
    function Get_Table: Table; safecall;
    procedure Export(const PathName: WideString; Filter: PpShapeFormat; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT; ExportMode: PpExportMode); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Adjustments: Adjustments read Get_Adjustments;
    property AutoShapeType: MsoAutoShapeType read Get_AutoShapeType write Set_AutoShapeType;
    property BlackWhiteMode: MsoBlackWhiteMode read Get_BlackWhiteMode write Set_BlackWhiteMode;
    property Callout: CalloutFormat read Get_Callout;
    property ConnectionSiteCount: SYSINT read Get_ConnectionSiteCount;
    property Connector: MsoTriState read Get_Connector;
    property ConnectorFormat: ConnectorFormat read Get_ConnectorFormat;
    property Fill: FillFormat read Get_Fill;
    property GroupItems: GroupShapes read Get_GroupItems;
    property Height: Single read Get_Height write Set_Height;
    property HorizontalFlip: MsoTriState read Get_HorizontalFlip;
    property Left: Single read Get_Left write Set_Left;
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
    property Top: Single read Get_Top write Set_Top;
    property type_: MsoShapeType read Get_type_;
    property VerticalFlip: MsoTriState read Get_VerticalFlip;
    property Vertices: OleVariant read Get_Vertices;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property Width: Single read Get_Width write Set_Width;
    property ZOrderPosition: SYSINT read Get_ZOrderPosition;
    property OLEFormat: OLEFormat read Get_OLEFormat;
    property LinkFormat: LinkFormat read Get_LinkFormat;
    property PlaceholderFormat: PlaceholderFormat read Get_PlaceholderFormat;
    property AnimationSettings: AnimationSettings read Get_AnimationSettings;
    property ActionSettings: ActionSettings read Get_ActionSettings;
    property Tags: Tags read Get_Tags;
    property MediaType: PpMediaType read Get_MediaType;
    property HasTextFrame: MsoTriState read Get_HasTextFrame;
    property SoundFormat: SoundFormat read Get_SoundFormat;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Count: Integer read Get_Count;
    property Script: Script read Get_Script;
    property AlternativeText: WideString read Get_AlternativeText write Set_AlternativeText;
    property HasTable: MsoTriState read Get_HasTable;
    property Table: Table read Get_Table;
  end;

// *********************************************************************//
// DispIntf:  ShapeRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShapeRangeDisp = dispinterface
    ['{9149347A-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    procedure Apply; dispid 10;
    procedure Delete; dispid 11;
    procedure Flip(FlipCmd: MsoFlipCmd); dispid 13;
    procedure IncrementLeft(Increment: Single); dispid 14;
    procedure IncrementRotation(Increment: Single); dispid 15;
    procedure IncrementTop(Increment: Single); dispid 16;
    procedure PickUp; dispid 17;
    procedure RerouteConnections; dispid 18;
    procedure ScaleHeight(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); dispid 19;
    procedure ScaleWidth(Factor: Single; RelativeToOriginalSize: MsoTriState; fScale: MsoScaleFrom); dispid 20;
    procedure SetShapesDefaultProperties; dispid 22;
    function Ungroup: ShapeRange; dispid 23;
    procedure ZOrder(ZOrderCmd: MsoZOrderCmd); dispid 24;
    property Adjustments: Adjustments readonly dispid 100;
    property AutoShapeType: MsoAutoShapeType dispid 101;
    property BlackWhiteMode: MsoBlackWhiteMode dispid 102;
    property Callout: CalloutFormat readonly dispid 103;
    property ConnectionSiteCount: SYSINT readonly dispid 104;
    property Connector: MsoTriState readonly dispid 105;
    property ConnectorFormat: ConnectorFormat readonly dispid 106;
    property Fill: FillFormat readonly dispid 107;
    property GroupItems: GroupShapes readonly dispid 108;
    property Height: Single dispid 109;
    property HorizontalFlip: MsoTriState readonly dispid 110;
    property Left: Single dispid 111;
    property Line: LineFormat readonly dispid 112;
    property LockAspectRatio: MsoTriState dispid 113;
    property Name: WideString dispid 115;
    property Nodes: ShapeNodes readonly dispid 116;
    property Rotation: Single dispid 117;
    property PictureFormat: PictureFormat readonly dispid 118;
    property Shadow: ShadowFormat readonly dispid 119;
    property TextEffect: TextEffectFormat readonly dispid 120;
    property TextFrame: TextFrame readonly dispid 121;
    property ThreeD: ThreeDFormat readonly dispid 122;
    property Top: Single dispid 123;
    property type_: MsoShapeType readonly dispid 124;
    property VerticalFlip: MsoTriState readonly dispid 125;
    property Vertices: OleVariant readonly dispid 126;
    property Visible: MsoTriState dispid 127;
    property Width: Single dispid 128;
    property ZOrderPosition: SYSINT readonly dispid 129;
    property OLEFormat: OLEFormat readonly dispid 2003;
    property LinkFormat: LinkFormat readonly dispid 2004;
    property PlaceholderFormat: PlaceholderFormat readonly dispid 2005;
    property AnimationSettings: AnimationSettings readonly dispid 2006;
    property ActionSettings: ActionSettings readonly dispid 2007;
    property Tags: Tags readonly dispid 2008;
    procedure Cut; dispid 2009;
    procedure Copy; dispid 2010;
    procedure Select(Replace: MsoTriState); dispid 2011;
    function Duplicate: ShapeRange; dispid 2012;
    property MediaType: PpMediaType readonly dispid 2013;
    property HasTextFrame: MsoTriState readonly dispid 2014;
    property SoundFormat: SoundFormat readonly dispid 2015;
    function Item(index: OleVariant): Shape; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 8;
    property Count: Integer readonly dispid 9;
    function Group: Shape; dispid 2016;
    function Regroup: Shape; dispid 2017;
    procedure Align(AlignCmd: MsoAlignCmd; RelativeTo: MsoTriState); dispid 2018;
    procedure Distribute(DistributeCmd: MsoDistributeCmd; RelativeTo: MsoTriState); dispid 2019;
    procedure GetPolygonalRepresentation(maxPointsInBuffer: LongWord; var pPoints: Single; 
                                         out numPointsInPolygon: LongWord; out IsOpen: MsoTriState); dispid 2020;
    property Script: Script readonly dispid 130;
    property AlternativeText: WideString dispid 131;
    property HasTable: MsoTriState readonly dispid 2021;
    property Table: Table readonly dispid 2022;
    procedure Export(const PathName: WideString; Filter: PpShapeFormat; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT; ExportMode: PpExportMode); dispid 2023;
  end;

// *********************************************************************//
// Interface: GroupShapes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  GroupShapes = interface(IDispatch)
    ['{9149347B-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Count: SYSINT; safecall;
    function Item(index: OleVariant): Shape; safecall;
    function Get__NewEnum: IUnknown; safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  GroupShapesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  GroupShapesDisp = dispinterface
    ['{9149347B-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    property Count: SYSINT readonly dispid 2;
    function Item(index: OleVariant): Shape; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
  end;

// *********************************************************************//
// Interface: Adjustments
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Adjustments = interface(IDispatch)
    ['{9149347C-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Count: SYSINT; safecall;
    function Get_Item(index: SYSINT): Single; safecall;
    procedure Set_Item(index: SYSINT; Val: Single); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property Item[index: SYSINT]: Single read Get_Item write Set_Item; default;
  end;

// *********************************************************************//
// DispIntf:  AdjustmentsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  AdjustmentsDisp = dispinterface
    ['{9149347C-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    property Count: SYSINT readonly dispid 2;
    property Item[index: SYSINT]: Single dispid 0; default;
  end;

// *********************************************************************//
// Interface: PictureFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347D-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PictureFormat = interface(IDispatch)
    ['{9149347D-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure IncrementBrightness(Increment: Single); safecall;
    procedure IncrementContrast(Increment: Single); safecall;
    function Get_Brightness: Single; safecall;
    procedure Set_Brightness(Brightness: Single); safecall;
    function Get_ColorType: MsoPictureColorType; safecall;
    procedure Set_ColorType(ColorType: MsoPictureColorType); safecall;
    function Get_Contrast: Single; safecall;
    procedure Set_Contrast(Contrast: Single); safecall;
    function Get_CropBottom: Single; safecall;
    procedure Set_CropBottom(CropBottom: Single); safecall;
    function Get_CropLeft: Single; safecall;
    procedure Set_CropLeft(CropLeft: Single); safecall;
    function Get_CropRight: Single; safecall;
    procedure Set_CropRight(CropRight: Single); safecall;
    function Get_CropTop: Single; safecall;
    procedure Set_CropTop(CropTop: Single); safecall;
    function Get_TransparencyColor: MsoRGBType; safecall;
    procedure Set_TransparencyColor(TransparencyColor: MsoRGBType); safecall;
    function Get_TransparentBackground: MsoTriState; safecall;
    procedure Set_TransparentBackground(TransparentBackground: MsoTriState); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Brightness: Single read Get_Brightness write Set_Brightness;
    property ColorType: MsoPictureColorType read Get_ColorType write Set_ColorType;
    property Contrast: Single read Get_Contrast write Set_Contrast;
    property CropBottom: Single read Get_CropBottom write Set_CropBottom;
    property CropLeft: Single read Get_CropLeft write Set_CropLeft;
    property CropRight: Single read Get_CropRight write Set_CropRight;
    property CropTop: Single read Get_CropTop write Set_CropTop;
    property TransparencyColor: MsoRGBType read Get_TransparencyColor write Set_TransparencyColor;
    property TransparentBackground: MsoTriState read Get_TransparentBackground write Set_TransparentBackground;
  end;

// *********************************************************************//
// DispIntf:  PictureFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347D-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PictureFormatDisp = dispinterface
    ['{9149347D-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    procedure IncrementBrightness(Increment: Single); dispid 10;
    procedure IncrementContrast(Increment: Single); dispid 11;
    property Brightness: Single dispid 100;
    property ColorType: MsoPictureColorType dispid 101;
    property Contrast: Single dispid 102;
    property CropBottom: Single dispid 103;
    property CropLeft: Single dispid 104;
    property CropRight: Single dispid 105;
    property CropTop: Single dispid 106;
    property TransparencyColor: MsoRGBType dispid 107;
    property TransparentBackground: MsoTriState dispid 108;
  end;

// *********************************************************************//
// Interface: FillFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FillFormat = interface(IDispatch)
    ['{9149347E-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure Background; safecall;
    procedure OneColorGradient(Style: MsoGradientStyle; Variant: SYSINT; Degree: Single); safecall;
    procedure Patterned(Pattern: MsoPatternType); safecall;
    procedure PresetGradient(Style: MsoGradientStyle; Variant: SYSINT; 
                             PresetGradientType: MsoPresetGradientType); safecall;
    procedure PresetTextured(PresetTexture: MsoPresetTexture); safecall;
    procedure Solid; safecall;
    procedure TwoColorGradient(Style: MsoGradientStyle; Variant: SYSINT); safecall;
    procedure UserPicture(const PictureFile: WideString); safecall;
    procedure UserTextured(const TextureFile: WideString); safecall;
    function Get_BackColor: ColorFormat; safecall;
    procedure Set_BackColor(const BackColor: ColorFormat); safecall;
    function Get_ForeColor: ColorFormat; safecall;
    procedure Set_ForeColor(const ForeColor: ColorFormat); safecall;
    function Get_GradientColorType: MsoGradientColorType; safecall;
    function Get_GradientDegree: Single; safecall;
    function Get_GradientStyle: MsoGradientStyle; safecall;
    function Get_GradientVariant: SYSINT; safecall;
    function Get_Pattern: MsoPatternType; safecall;
    function Get_PresetGradientType: MsoPresetGradientType; safecall;
    function Get_PresetTexture: MsoPresetTexture; safecall;
    function Get_TextureName: WideString; safecall;
    function Get_TextureType: MsoTextureType; safecall;
    function Get_Transparency: Single; safecall;
    procedure Set_Transparency(Transparency: Single); safecall;
    function Get_type_: MsoFillType; safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
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
    property type_: MsoFillType read Get_type_;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  FillFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FillFormatDisp = dispinterface
    ['{9149347E-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    procedure Background; dispid 10;
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
    property type_: MsoFillType readonly dispid 112;
    property Visible: MsoTriState dispid 113;
  end;

// *********************************************************************//
// Interface: LineFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  LineFormat = interface(IDispatch)
    ['{9149347F-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_BackColor: ColorFormat; safecall;
    procedure Set_BackColor(const BackColor: ColorFormat); safecall;
    function Get_BeginArrowheadLength: MsoArrowheadLength; safecall;
    procedure Set_BeginArrowheadLength(BeginArrowheadLength: MsoArrowheadLength); safecall;
    function Get_BeginArrowheadStyle: MsoArrowheadStyle; safecall;
    procedure Set_BeginArrowheadStyle(BeginArrowheadStyle: MsoArrowheadStyle); safecall;
    function Get_BeginArrowheadWidth: MsoArrowheadWidth; safecall;
    procedure Set_BeginArrowheadWidth(BeginArrowheadWidth: MsoArrowheadWidth); safecall;
    function Get_DashStyle: MsoLineDashStyle; safecall;
    procedure Set_DashStyle(DashStyle: MsoLineDashStyle); safecall;
    function Get_EndArrowheadLength: MsoArrowheadLength; safecall;
    procedure Set_EndArrowheadLength(EndArrowheadLength: MsoArrowheadLength); safecall;
    function Get_EndArrowheadStyle: MsoArrowheadStyle; safecall;
    procedure Set_EndArrowheadStyle(EndArrowheadStyle: MsoArrowheadStyle); safecall;
    function Get_EndArrowheadWidth: MsoArrowheadWidth; safecall;
    procedure Set_EndArrowheadWidth(EndArrowheadWidth: MsoArrowheadWidth); safecall;
    function Get_ForeColor: ColorFormat; safecall;
    procedure Set_ForeColor(const ForeColor: ColorFormat); safecall;
    function Get_Pattern: MsoPatternType; safecall;
    procedure Set_Pattern(Pattern: MsoPatternType); safecall;
    function Get_Style: MsoLineStyle; safecall;
    procedure Set_Style(Style: MsoLineStyle); safecall;
    function Get_Transparency: Single; safecall;
    procedure Set_Transparency(Transparency: Single); safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    function Get_Weight: Single; safecall;
    procedure Set_Weight(Weight: Single); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
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
    property Weight: Single read Get_Weight write Set_Weight;
  end;

// *********************************************************************//
// DispIntf:  LineFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149347F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  LineFormatDisp = dispinterface
    ['{9149347F-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
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
    property Weight: Single dispid 113;
  end;

// *********************************************************************//
// Interface: ShadowFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493480-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShadowFormat = interface(IDispatch)
    ['{91493480-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure IncrementOffsetX(Increment: Single); safecall;
    procedure IncrementOffsetY(Increment: Single); safecall;
    function Get_ForeColor: ColorFormat; safecall;
    procedure Set_ForeColor(const ForeColor: ColorFormat); safecall;
    function Get_Obscured: MsoTriState; safecall;
    procedure Set_Obscured(Obscured: MsoTriState); safecall;
    function Get_OffsetX: Single; safecall;
    procedure Set_OffsetX(OffsetX: Single); safecall;
    function Get_OffsetY: Single; safecall;
    procedure Set_OffsetY(OffsetY: Single); safecall;
    function Get_Transparency: Single; safecall;
    procedure Set_Transparency(Transparency: Single); safecall;
    function Get_type_: MsoShadowType; safecall;
    procedure Set_type_(Type_: MsoShadowType); safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property ForeColor: ColorFormat read Get_ForeColor write Set_ForeColor;
    property Obscured: MsoTriState read Get_Obscured write Set_Obscured;
    property OffsetX: Single read Get_OffsetX write Set_OffsetX;
    property OffsetY: Single read Get_OffsetY write Set_OffsetY;
    property Transparency: Single read Get_Transparency write Set_Transparency;
    property type_: MsoShadowType read Get_type_ write Set_type_;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  ShadowFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493480-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShadowFormatDisp = dispinterface
    ['{91493480-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    procedure IncrementOffsetX(Increment: Single); dispid 10;
    procedure IncrementOffsetY(Increment: Single); dispid 11;
    property ForeColor: ColorFormat dispid 100;
    property Obscured: MsoTriState dispid 101;
    property OffsetX: Single dispid 102;
    property OffsetY: Single dispid 103;
    property Transparency: Single dispid 104;
    property type_: MsoShadowType dispid 105;
    property Visible: MsoTriState dispid 106;
  end;

// *********************************************************************//
// Interface: ConnectorFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493481-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ConnectorFormat = interface(IDispatch)
    ['{91493481-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure BeginConnect(const ConnectedShape: Shape; ConnectionSite: SYSINT); safecall;
    procedure BeginDisconnect; safecall;
    procedure EndConnect(const ConnectedShape: Shape; ConnectionSite: SYSINT); safecall;
    procedure EndDisconnect; safecall;
    function Get_BeginConnected: MsoTriState; safecall;
    function Get_BeginConnectedShape: Shape; safecall;
    function Get_BeginConnectionSite: SYSINT; safecall;
    function Get_EndConnected: MsoTriState; safecall;
    function Get_EndConnectedShape: Shape; safecall;
    function Get_EndConnectionSite: SYSINT; safecall;
    function Get_type_: MsoConnectorType; safecall;
    procedure Set_type_(Type_: MsoConnectorType); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property BeginConnected: MsoTriState read Get_BeginConnected;
    property BeginConnectedShape: Shape read Get_BeginConnectedShape;
    property BeginConnectionSite: SYSINT read Get_BeginConnectionSite;
    property EndConnected: MsoTriState read Get_EndConnected;
    property EndConnectedShape: Shape read Get_EndConnectedShape;
    property EndConnectionSite: SYSINT read Get_EndConnectionSite;
    property type_: MsoConnectorType read Get_type_ write Set_type_;
  end;

// *********************************************************************//
// DispIntf:  ConnectorFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493481-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ConnectorFormatDisp = dispinterface
    ['{91493481-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
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
    property type_: MsoConnectorType dispid 106;
  end;

// *********************************************************************//
// Interface: TextEffectFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493482-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextEffectFormat = interface(IDispatch)
    ['{91493482-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure ToggleVerticalText; safecall;
    function Get_Alignment: MsoTextEffectAlignment; safecall;
    procedure Set_Alignment(Alignment: MsoTextEffectAlignment); safecall;
    function Get_FontBold: MsoTriState; safecall;
    procedure Set_FontBold(FontBold: MsoTriState); safecall;
    function Get_FontItalic: MsoTriState; safecall;
    procedure Set_FontItalic(FontItalic: MsoTriState); safecall;
    function Get_FontName: WideString; safecall;
    procedure Set_FontName(const FontName: WideString); safecall;
    function Get_FontSize: Single; safecall;
    procedure Set_FontSize(FontSize: Single); safecall;
    function Get_KernedPairs: MsoTriState; safecall;
    procedure Set_KernedPairs(KernedPairs: MsoTriState); safecall;
    function Get_NormalizedHeight: MsoTriState; safecall;
    procedure Set_NormalizedHeight(NormalizedHeight: MsoTriState); safecall;
    function Get_PresetShape: MsoPresetTextEffectShape; safecall;
    procedure Set_PresetShape(PresetShape: MsoPresetTextEffectShape); safecall;
    function Get_PresetTextEffect: MsoPresetTextEffect; safecall;
    procedure Set_PresetTextEffect(Preset: MsoPresetTextEffect); safecall;
    function Get_RotatedChars: MsoTriState; safecall;
    procedure Set_RotatedChars(RotatedChars: MsoTriState); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const Text: WideString); safecall;
    function Get_Tracking: Single; safecall;
    procedure Set_Tracking(Tracking: Single); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Alignment: MsoTextEffectAlignment read Get_Alignment write Set_Alignment;
    property FontBold: MsoTriState read Get_FontBold write Set_FontBold;
    property FontItalic: MsoTriState read Get_FontItalic write Set_FontItalic;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: Single read Get_FontSize write Set_FontSize;
    property KernedPairs: MsoTriState read Get_KernedPairs write Set_KernedPairs;
    property NormalizedHeight: MsoTriState read Get_NormalizedHeight write Set_NormalizedHeight;
    property PresetShape: MsoPresetTextEffectShape read Get_PresetShape write Set_PresetShape;
    property PresetTextEffect: MsoPresetTextEffect read Get_PresetTextEffect write Set_PresetTextEffect;
    property RotatedChars: MsoTriState read Get_RotatedChars write Set_RotatedChars;
    property Text: WideString read Get_Text write Set_Text;
    property Tracking: Single read Get_Tracking write Set_Tracking;
  end;

// *********************************************************************//
// DispIntf:  TextEffectFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493482-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextEffectFormatDisp = dispinterface
    ['{91493482-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    procedure ToggleVerticalText; dispid 10;
    property Alignment: MsoTextEffectAlignment dispid 100;
    property FontBold: MsoTriState dispid 101;
    property FontItalic: MsoTriState dispid 102;
    property FontName: WideString dispid 103;
    property FontSize: Single dispid 104;
    property KernedPairs: MsoTriState dispid 105;
    property NormalizedHeight: MsoTriState dispid 106;
    property PresetShape: MsoPresetTextEffectShape dispid 107;
    property PresetTextEffect: MsoPresetTextEffect dispid 108;
    property RotatedChars: MsoTriState dispid 109;
    property Text: WideString dispid 110;
    property Tracking: Single dispid 111;
  end;

// *********************************************************************//
// Interface: ThreeDFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493483-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ThreeDFormat = interface(IDispatch)
    ['{91493483-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure IncrementRotationX(Increment: Single); safecall;
    procedure IncrementRotationY(Increment: Single); safecall;
    procedure ResetRotation; safecall;
    procedure SetThreeDFormat(PresetThreeDFormat: MsoPresetThreeDFormat); safecall;
    procedure SetExtrusionDirection(PresetExtrusionDirection: MsoPresetExtrusionDirection); safecall;
    function Get_Depth: Single; safecall;
    procedure Set_Depth(Depth: Single); safecall;
    function Get_ExtrusionColor: ColorFormat; safecall;
    function Get_ExtrusionColorType: MsoExtrusionColorType; safecall;
    procedure Set_ExtrusionColorType(ExtrusionColorType: MsoExtrusionColorType); safecall;
    function Get_Perspective: MsoTriState; safecall;
    procedure Set_Perspective(Perspective: MsoTriState); safecall;
    function Get_PresetExtrusionDirection: MsoPresetExtrusionDirection; safecall;
    function Get_PresetLightingDirection: MsoPresetLightingDirection; safecall;
    procedure Set_PresetLightingDirection(PresetLightingDirection: MsoPresetLightingDirection); safecall;
    function Get_PresetLightingSoftness: MsoPresetLightingSoftness; safecall;
    procedure Set_PresetLightingSoftness(PresetLightingSoftness: MsoPresetLightingSoftness); safecall;
    function Get_PresetMaterial: MsoPresetMaterial; safecall;
    procedure Set_PresetMaterial(PresetMaterial: MsoPresetMaterial); safecall;
    function Get_PresetThreeDFormat: MsoPresetThreeDFormat; safecall;
    function Get_RotationX: Single; safecall;
    procedure Set_RotationX(RotationX: Single); safecall;
    function Get_RotationY: Single; safecall;
    procedure Set_RotationY(RotationY: Single); safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Depth: Single read Get_Depth write Set_Depth;
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
// GUID:      {91493483-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ThreeDFormatDisp = dispinterface
    ['{91493483-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    procedure IncrementRotationX(Increment: Single); dispid 10;
    procedure IncrementRotationY(Increment: Single); dispid 11;
    procedure ResetRotation; dispid 12;
    procedure SetThreeDFormat(PresetThreeDFormat: MsoPresetThreeDFormat); dispid 13;
    procedure SetExtrusionDirection(PresetExtrusionDirection: MsoPresetExtrusionDirection); dispid 14;
    property Depth: Single dispid 100;
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
// Interface: TextFrame
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493484-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextFrame = interface(IDispatch)
    ['{91493484-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_MarginBottom: Single; safecall;
    procedure Set_MarginBottom(MarginBottom: Single); safecall;
    function Get_MarginLeft: Single; safecall;
    procedure Set_MarginLeft(MarginLeft: Single); safecall;
    function Get_MarginRight: Single; safecall;
    procedure Set_MarginRight(MarginRight: Single); safecall;
    function Get_MarginTop: Single; safecall;
    procedure Set_MarginTop(MarginTop: Single); safecall;
    function Get_Orientation: MsoTextOrientation; safecall;
    procedure Set_Orientation(Orientation: MsoTextOrientation); safecall;
    function Get_HasText: MsoTriState; safecall;
    function Get_TextRange: TextRange; safecall;
    function Get_Ruler: Ruler; safecall;
    function Get_HorizontalAnchor: MsoHorizontalAnchor; safecall;
    procedure Set_HorizontalAnchor(HorizontalAnchor: MsoHorizontalAnchor); safecall;
    function Get_VerticalAnchor: MsoVerticalAnchor; safecall;
    procedure Set_VerticalAnchor(VerticalAnchor: MsoVerticalAnchor); safecall;
    function Get_AutoSize: PpAutoSize; safecall;
    procedure Set_AutoSize(AutoSize: PpAutoSize); safecall;
    function Get_WordWrap: MsoTriState; safecall;
    procedure Set_WordWrap(WordWrap: MsoTriState); safecall;
    procedure DeleteText; safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property MarginBottom: Single read Get_MarginBottom write Set_MarginBottom;
    property MarginLeft: Single read Get_MarginLeft write Set_MarginLeft;
    property MarginRight: Single read Get_MarginRight write Set_MarginRight;
    property MarginTop: Single read Get_MarginTop write Set_MarginTop;
    property Orientation: MsoTextOrientation read Get_Orientation write Set_Orientation;
    property HasText: MsoTriState read Get_HasText;
    property TextRange: TextRange read Get_TextRange;
    property Ruler: Ruler read Get_Ruler;
    property HorizontalAnchor: MsoHorizontalAnchor read Get_HorizontalAnchor write Set_HorizontalAnchor;
    property VerticalAnchor: MsoVerticalAnchor read Get_VerticalAnchor write Set_VerticalAnchor;
    property AutoSize: PpAutoSize read Get_AutoSize write Set_AutoSize;
    property WordWrap: MsoTriState read Get_WordWrap write Set_WordWrap;
  end;

// *********************************************************************//
// DispIntf:  TextFrameDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493484-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextFrameDisp = dispinterface
    ['{91493484-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    property MarginBottom: Single dispid 100;
    property MarginLeft: Single dispid 101;
    property MarginRight: Single dispid 102;
    property MarginTop: Single dispid 103;
    property Orientation: MsoTextOrientation dispid 104;
    property HasText: MsoTriState readonly dispid 2003;
    property TextRange: TextRange readonly dispid 2004;
    property Ruler: Ruler readonly dispid 2005;
    property HorizontalAnchor: MsoHorizontalAnchor dispid 2006;
    property VerticalAnchor: MsoVerticalAnchor dispid 2007;
    property AutoSize: PpAutoSize dispid 2008;
    property WordWrap: MsoTriState dispid 2009;
    procedure DeleteText; dispid 2010;
  end;

// *********************************************************************//
// Interface: CalloutFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493485-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  CalloutFormat = interface(IDispatch)
    ['{91493485-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure AutomaticLength; safecall;
    procedure CustomDrop(Drop: Single); safecall;
    procedure CustomLength(Length: Single); safecall;
    procedure PresetDrop(DropType: MsoCalloutDropType); safecall;
    function Get_Accent: MsoTriState; safecall;
    procedure Set_Accent(Accent: MsoTriState); safecall;
    function Get_Angle: MsoCalloutAngleType; safecall;
    procedure Set_Angle(Angle: MsoCalloutAngleType); safecall;
    function Get_AutoAttach: MsoTriState; safecall;
    procedure Set_AutoAttach(AutoAttach: MsoTriState); safecall;
    function Get_AutoLength: MsoTriState; safecall;
    function Get_Border: MsoTriState; safecall;
    procedure Set_Border(Border: MsoTriState); safecall;
    function Get_Drop: Single; safecall;
    function Get_DropType: MsoCalloutDropType; safecall;
    function Get_Gap: Single; safecall;
    procedure Set_Gap(Gap: Single); safecall;
    function Get_Length: Single; safecall;
    function Get_type_: MsoCalloutType; safecall;
    procedure Set_type_(Type_: MsoCalloutType); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Accent: MsoTriState read Get_Accent write Set_Accent;
    property Angle: MsoCalloutAngleType read Get_Angle write Set_Angle;
    property AutoAttach: MsoTriState read Get_AutoAttach write Set_AutoAttach;
    property AutoLength: MsoTriState read Get_AutoLength;
    property Border: MsoTriState read Get_Border write Set_Border;
    property Drop: Single read Get_Drop;
    property DropType: MsoCalloutDropType read Get_DropType;
    property Gap: Single read Get_Gap write Set_Gap;
    property Length: Single read Get_Length;
    property type_: MsoCalloutType read Get_type_ write Set_type_;
  end;

// *********************************************************************//
// DispIntf:  CalloutFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493485-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  CalloutFormatDisp = dispinterface
    ['{91493485-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    procedure AutomaticLength; dispid 10;
    procedure CustomDrop(Drop: Single); dispid 11;
    procedure CustomLength(Length: Single); dispid 12;
    procedure PresetDrop(DropType: MsoCalloutDropType); dispid 13;
    property Accent: MsoTriState dispid 100;
    property Angle: MsoCalloutAngleType dispid 101;
    property AutoAttach: MsoTriState dispid 102;
    property AutoLength: MsoTriState readonly dispid 103;
    property Border: MsoTriState dispid 104;
    property Drop: Single readonly dispid 105;
    property DropType: MsoCalloutDropType readonly dispid 106;
    property Gap: Single dispid 107;
    property Length: Single readonly dispid 108;
    property type_: MsoCalloutType dispid 109;
  end;

// *********************************************************************//
// Interface: ShapeNodes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493486-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShapeNodes = interface(IDispatch)
    ['{91493486-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Count: SYSINT; safecall;
    function Item(index: OleVariant): ShapeNode; safecall;
    function Get__NewEnum: IUnknown; safecall;
    procedure Delete(index: SYSINT); safecall;
    procedure Insert(index: SYSINT; SegmentType: MsoSegmentType; EditingType: MsoEditingType; 
                     X1: Single; Y1: Single; X2: Single; Y2: Single; X3: Single; Y3: Single); safecall;
    procedure SetEditingType(index: SYSINT; EditingType: MsoEditingType); safecall;
    procedure SetPosition(index: SYSINT; X1: Single; Y1: Single); safecall;
    procedure SetSegmentType(index: SYSINT; SegmentType: MsoSegmentType); safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property Count: SYSINT read Get_Count;
    property _NewEnum: IUnknown read Get__NewEnum;
  end;

// *********************************************************************//
// DispIntf:  ShapeNodesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493486-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShapeNodesDisp = dispinterface
    ['{91493486-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    property Count: SYSINT readonly dispid 2;
    function Item(index: OleVariant): ShapeNode; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    procedure Delete(index: SYSINT); dispid 11;
    procedure Insert(index: SYSINT; SegmentType: MsoSegmentType; EditingType: MsoEditingType; 
                     X1: Single; Y1: Single; X2: Single; Y2: Single; X3: Single; Y3: Single); dispid 12;
    procedure SetEditingType(index: SYSINT; EditingType: MsoEditingType); dispid 13;
    procedure SetPosition(index: SYSINT; X1: Single; Y1: Single); dispid 14;
    procedure SetSegmentType(index: SYSINT; SegmentType: MsoSegmentType); dispid 15;
  end;

// *********************************************************************//
// Interface: ShapeNode
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493487-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShapeNode = interface(IDispatch)
    ['{91493487-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: IDispatch; safecall;
    function Get_Creator: Integer; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_EditingType: MsoEditingType; safecall;
    function Get_Points: OleVariant; safecall;
    function Get_SegmentType: MsoSegmentType; safecall;
    property Application: IDispatch read Get_Application;
    property Creator: Integer read Get_Creator;
    property Parent: IDispatch read Get_Parent;
    property EditingType: MsoEditingType read Get_EditingType;
    property Points: OleVariant read Get_Points;
    property SegmentType: MsoSegmentType read Get_SegmentType;
  end;

// *********************************************************************//
// DispIntf:  ShapeNodeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493487-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ShapeNodeDisp = dispinterface
    ['{91493487-5A91-11CF-8700-00AA0060263B}']
    property Application: IDispatch readonly dispid 2001;
    property Creator: Integer readonly dispid 2002;
    property Parent: IDispatch readonly dispid 1;
    property EditingType: MsoEditingType readonly dispid 100;
    property Points: OleVariant readonly dispid 101;
    property SegmentType: MsoSegmentType readonly dispid 102;
  end;

// *********************************************************************//
// Interface: OLEFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493488-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  OLEFormat = interface(IDispatch)
    ['{91493488-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_ObjectVerbs: ObjectVerbs; safecall;
    function Get_Object_: IDispatch; safecall;
    function Get_ProgID: WideString; safecall;
    function Get_FollowColors: PpFollowColors; safecall;
    procedure Set_FollowColors(FollowColors: PpFollowColors); safecall;
    procedure DoVerb(index: SYSINT); safecall;
    procedure Activate; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ObjectVerbs: ObjectVerbs read Get_ObjectVerbs;
    property Object_: IDispatch read Get_Object_;
    property ProgID: WideString read Get_ProgID;
    property FollowColors: PpFollowColors read Get_FollowColors write Set_FollowColors;
  end;

// *********************************************************************//
// DispIntf:  OLEFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493488-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  OLEFormatDisp = dispinterface
    ['{91493488-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property ObjectVerbs: ObjectVerbs readonly dispid 2003;
    property Object_: IDispatch readonly dispid 2004;
    property ProgID: WideString readonly dispid 2005;
    property FollowColors: PpFollowColors dispid 2006;
    procedure DoVerb(index: SYSINT); dispid 2007;
    procedure Activate; dispid 2008;
  end;

// *********************************************************************//
// Interface: LinkFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493489-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  LinkFormat = interface(IDispatch)
    ['{91493489-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_SourceFullName: WideString; safecall;
    procedure Set_SourceFullName(const SourceFullName: WideString); safecall;
    function Get_AutoUpdate: PpUpdateOption; safecall;
    procedure Set_AutoUpdate(AutoUpdate: PpUpdateOption); safecall;
    procedure Update; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property SourceFullName: WideString read Get_SourceFullName write Set_SourceFullName;
    property AutoUpdate: PpUpdateOption read Get_AutoUpdate write Set_AutoUpdate;
  end;

// *********************************************************************//
// DispIntf:  LinkFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493489-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  LinkFormatDisp = dispinterface
    ['{91493489-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property SourceFullName: WideString dispid 2003;
    property AutoUpdate: PpUpdateOption dispid 2004;
    procedure Update; dispid 2005;
  end;

// *********************************************************************//
// Interface: ObjectVerbs
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ObjectVerbs = interface(Collection)
    ['{9149348A-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): WideString; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  ObjectVerbsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ObjectVerbsDisp = dispinterface
    ['{9149348A-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): WideString; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: AnimationSettings
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  AnimationSettings = interface(IDispatch)
    ['{9149348B-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_DimColor: ColorFormat; safecall;
    function Get_SoundEffect: SoundEffect; safecall;
    function Get_EntryEffect: PpEntryEffect; safecall;
    procedure Set_EntryEffect(EntryEffect: PpEntryEffect); safecall;
    function Get_AfterEffect: PpAfterEffect; safecall;
    procedure Set_AfterEffect(AfterEffect: PpAfterEffect); safecall;
    function Get_AnimationOrder: SYSINT; safecall;
    procedure Set_AnimationOrder(AnimationOrder: SYSINT); safecall;
    function Get_AdvanceMode: PpAdvanceMode; safecall;
    procedure Set_AdvanceMode(AdvanceMode: PpAdvanceMode); safecall;
    function Get_AdvanceTime: Single; safecall;
    procedure Set_AdvanceTime(AdvanceTime: Single); safecall;
    function Get_PlaySettings: PlaySettings; safecall;
    function Get_TextLevelEffect: PpTextLevelEffect; safecall;
    procedure Set_TextLevelEffect(TextLevelEffect: PpTextLevelEffect); safecall;
    function Get_TextUnitEffect: PpTextUnitEffect; safecall;
    procedure Set_TextUnitEffect(TextUnitEffect: PpTextUnitEffect); safecall;
    function Get_Animate: MsoTriState; safecall;
    procedure Set_Animate(Animate: MsoTriState); safecall;
    function Get_AnimateBackground: MsoTriState; safecall;
    procedure Set_AnimateBackground(AnimateBackground: MsoTriState); safecall;
    function Get_AnimateTextInReverse: MsoTriState; safecall;
    procedure Set_AnimateTextInReverse(AnimateTextInReverse: MsoTriState); safecall;
    function Get_ChartUnitEffect: PpChartUnitEffect; safecall;
    procedure Set_ChartUnitEffect(ChartUnitEffect: PpChartUnitEffect); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property DimColor: ColorFormat read Get_DimColor;
    property SoundEffect: SoundEffect read Get_SoundEffect;
    property EntryEffect: PpEntryEffect read Get_EntryEffect write Set_EntryEffect;
    property AfterEffect: PpAfterEffect read Get_AfterEffect write Set_AfterEffect;
    property AnimationOrder: SYSINT read Get_AnimationOrder write Set_AnimationOrder;
    property AdvanceMode: PpAdvanceMode read Get_AdvanceMode write Set_AdvanceMode;
    property AdvanceTime: Single read Get_AdvanceTime write Set_AdvanceTime;
    property PlaySettings: PlaySettings read Get_PlaySettings;
    property TextLevelEffect: PpTextLevelEffect read Get_TextLevelEffect write Set_TextLevelEffect;
    property TextUnitEffect: PpTextUnitEffect read Get_TextUnitEffect write Set_TextUnitEffect;
    property Animate: MsoTriState read Get_Animate write Set_Animate;
    property AnimateBackground: MsoTriState read Get_AnimateBackground write Set_AnimateBackground;
    property AnimateTextInReverse: MsoTriState read Get_AnimateTextInReverse write Set_AnimateTextInReverse;
    property ChartUnitEffect: PpChartUnitEffect read Get_ChartUnitEffect write Set_ChartUnitEffect;
  end;

// *********************************************************************//
// DispIntf:  AnimationSettingsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  AnimationSettingsDisp = dispinterface
    ['{9149348B-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property DimColor: ColorFormat readonly dispid 2003;
    property SoundEffect: SoundEffect readonly dispid 2004;
    property EntryEffect: PpEntryEffect dispid 2005;
    property AfterEffect: PpAfterEffect dispid 2006;
    property AnimationOrder: SYSINT dispid 2007;
    property AdvanceMode: PpAdvanceMode dispid 2008;
    property AdvanceTime: Single dispid 2009;
    property PlaySettings: PlaySettings readonly dispid 2010;
    property TextLevelEffect: PpTextLevelEffect dispid 2011;
    property TextUnitEffect: PpTextUnitEffect dispid 2012;
    property Animate: MsoTriState dispid 2013;
    property AnimateBackground: MsoTriState dispid 2014;
    property AnimateTextInReverse: MsoTriState dispid 2015;
    property ChartUnitEffect: PpChartUnitEffect dispid 2016;
  end;

// *********************************************************************//
// Interface: ActionSettings
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ActionSettings = interface(Collection)
    ['{9149348C-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: PpMouseActivation): ActionSetting; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  ActionSettingsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ActionSettingsDisp = dispinterface
    ['{9149348C-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: PpMouseActivation): ActionSetting; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: ActionSetting
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348D-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ActionSetting = interface(IDispatch)
    ['{9149348D-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Action: PpActionType; safecall;
    procedure Set_Action(Action: PpActionType); safecall;
    function Get_ActionVerb: WideString; safecall;
    procedure Set_ActionVerb(const ActionVerb: WideString); safecall;
    function Get_AnimateAction: MsoTriState; safecall;
    procedure Set_AnimateAction(AnimateAction: MsoTriState); safecall;
    function Get_Run: WideString; safecall;
    procedure Set_Run(const Run: WideString); safecall;
    function Get_SlideShowName: WideString; safecall;
    procedure Set_SlideShowName(const SlideShowName: WideString); safecall;
    function Get_Hyperlink: Hyperlink; safecall;
    function Get_SoundEffect: SoundEffect; safecall;
    function Get_ShowandReturn: MsoTriState; safecall;
    procedure Set_ShowandReturn(ShowandReturn: MsoTriState); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Action: PpActionType read Get_Action write Set_Action;
    property ActionVerb: WideString read Get_ActionVerb write Set_ActionVerb;
    property AnimateAction: MsoTriState read Get_AnimateAction write Set_AnimateAction;
    property Run: WideString read Get_Run write Set_Run;
    property SlideShowName: WideString read Get_SlideShowName write Set_SlideShowName;
    property Hyperlink: Hyperlink read Get_Hyperlink;
    property SoundEffect: SoundEffect read Get_SoundEffect;
    property ShowandReturn: MsoTriState read Get_ShowandReturn write Set_ShowandReturn;
  end;

// *********************************************************************//
// DispIntf:  ActionSettingDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348D-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ActionSettingDisp = dispinterface
    ['{9149348D-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Action: PpActionType dispid 2003;
    property ActionVerb: WideString dispid 2004;
    property AnimateAction: MsoTriState dispid 2005;
    property Run: WideString dispid 2006;
    property SlideShowName: WideString dispid 2007;
    property Hyperlink: Hyperlink readonly dispid 2008;
    property SoundEffect: SoundEffect readonly dispid 2009;
    property ShowandReturn: MsoTriState dispid 2010;
  end;

// *********************************************************************//
// Interface: PlaySettings
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PlaySettings = interface(IDispatch)
    ['{9149348E-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_ActionVerb: WideString; safecall;
    procedure Set_ActionVerb(const ActionVerb: WideString); safecall;
    function Get_HideWhileNotPlaying: MsoTriState; safecall;
    procedure Set_HideWhileNotPlaying(HideWhileNotPlaying: MsoTriState); safecall;
    function Get_LoopUntilStopped: MsoTriState; safecall;
    procedure Set_LoopUntilStopped(LoopUntilStopped: MsoTriState); safecall;
    function Get_PlayOnEntry: MsoTriState; safecall;
    procedure Set_PlayOnEntry(PlayOnEntry: MsoTriState); safecall;
    function Get_RewindMovie: MsoTriState; safecall;
    procedure Set_RewindMovie(RewindMovie: MsoTriState); safecall;
    function Get_PauseAnimation: MsoTriState; safecall;
    procedure Set_PauseAnimation(PauseAnimation: MsoTriState); safecall;
    function Get_StopAfterSlides: SYSINT; safecall;
    procedure Set_StopAfterSlides(StopAfterSlides: SYSINT); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ActionVerb: WideString read Get_ActionVerb write Set_ActionVerb;
    property HideWhileNotPlaying: MsoTriState read Get_HideWhileNotPlaying write Set_HideWhileNotPlaying;
    property LoopUntilStopped: MsoTriState read Get_LoopUntilStopped write Set_LoopUntilStopped;
    property PlayOnEntry: MsoTriState read Get_PlayOnEntry write Set_PlayOnEntry;
    property RewindMovie: MsoTriState read Get_RewindMovie write Set_RewindMovie;
    property PauseAnimation: MsoTriState read Get_PauseAnimation write Set_PauseAnimation;
    property StopAfterSlides: SYSINT read Get_StopAfterSlides write Set_StopAfterSlides;
  end;

// *********************************************************************//
// DispIntf:  PlaySettingsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PlaySettingsDisp = dispinterface
    ['{9149348E-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property ActionVerb: WideString dispid 2003;
    property HideWhileNotPlaying: MsoTriState dispid 2004;
    property LoopUntilStopped: MsoTriState dispid 2005;
    property PlayOnEntry: MsoTriState dispid 2006;
    property RewindMovie: MsoTriState dispid 2007;
    property PauseAnimation: MsoTriState dispid 2008;
    property StopAfterSlides: SYSINT dispid 2009;
  end;

// *********************************************************************//
// Interface: TextRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextRange = interface(Collection)
    ['{9149348F-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_ActionSettings: ActionSettings; safecall;
    function Get_Start: Integer; safecall;
    function Get_Length: Integer; safecall;
    function Get_BoundLeft: Single; safecall;
    function Get_BoundTop: Single; safecall;
    function Get_BoundWidth: Single; safecall;
    function Get_BoundHeight: Single; safecall;
    function Paragraphs(Start: SYSINT; Length: SYSINT): TextRange; safecall;
    function Sentences(Start: SYSINT; Length: SYSINT): TextRange; safecall;
    function Words(Start: SYSINT; Length: SYSINT): TextRange; safecall;
    function Characters(Start: SYSINT; Length: SYSINT): TextRange; safecall;
    function Lines(Start: SYSINT; Length: SYSINT): TextRange; safecall;
    function Runs(Start: SYSINT; Length: SYSINT): TextRange; safecall;
    function TrimText: TextRange; safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const Text: WideString); safecall;
    function InsertAfter(const NewText: WideString): TextRange; safecall;
    function InsertBefore(const NewText: WideString): TextRange; safecall;
    function InsertDateTime(DateTimeFormat: PpDateTimeFormat; InsertAsField: MsoTriState): TextRange; safecall;
    function InsertSlideNumber: TextRange; safecall;
    function InsertSymbol(const FontName: WideString; CharNumber: SYSINT; Unicode: MsoTriState): TextRange; safecall;
    function Get_Font: Font; safecall;
    function Get_ParagraphFormat: ParagraphFormat; safecall;
    function Get_IndentLevel: SYSINT; safecall;
    procedure Set_IndentLevel(IndentLevel: SYSINT); safecall;
    procedure Select; safecall;
    procedure Cut; safecall;
    procedure Copy; safecall;
    procedure Delete; safecall;
    function Paste: TextRange; safecall;
    procedure ChangeCase(Type_: PpChangeCase); safecall;
    procedure AddPeriods; safecall;
    procedure RemovePeriods; safecall;
    function Find(const FindWhat: WideString; After: SYSINT; MatchCase: MsoTriState; 
                  WholeWords: MsoTriState): TextRange; safecall;
    function Replace(const FindWhat: WideString; const ReplaceWhat: WideString; After: SYSINT; 
                     MatchCase: MsoTriState; WholeWords: MsoTriState): TextRange; safecall;
    procedure RotatedBounds(out X1: Single; out Y1: Single; out X2: Single; out Y2: Single; 
                            out X3: Single; out Y3: Single; out x4: Single; out y4: Single); safecall;
    function Get_LanguageID: MsoLanguageID; safecall;
    procedure Set_LanguageID(LanguageID: MsoLanguageID); safecall;
    procedure RtlRun; safecall;
    procedure LtrRun; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ActionSettings: ActionSettings read Get_ActionSettings;
    property Start: Integer read Get_Start;
    property Length: Integer read Get_Length;
    property BoundLeft: Single read Get_BoundLeft;
    property BoundTop: Single read Get_BoundTop;
    property BoundWidth: Single read Get_BoundWidth;
    property BoundHeight: Single read Get_BoundHeight;
    property Text: WideString read Get_Text write Set_Text;
    property Font: Font read Get_Font;
    property ParagraphFormat: ParagraphFormat read Get_ParagraphFormat;
    property IndentLevel: SYSINT read Get_IndentLevel write Set_IndentLevel;
    property LanguageID: MsoLanguageID read Get_LanguageID write Set_LanguageID;
  end;

// *********************************************************************//
// DispIntf:  TextRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149348F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextRangeDisp = dispinterface
    ['{9149348F-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property ActionSettings: ActionSettings readonly dispid 2003;
    property Start: Integer readonly dispid 2004;
    property Length: Integer readonly dispid 2005;
    property BoundLeft: Single readonly dispid 2006;
    property BoundTop: Single readonly dispid 2007;
    property BoundWidth: Single readonly dispid 2008;
    property BoundHeight: Single readonly dispid 2009;
    function Paragraphs(Start: SYSINT; Length: SYSINT): TextRange; dispid 2010;
    function Sentences(Start: SYSINT; Length: SYSINT): TextRange; dispid 2011;
    function Words(Start: SYSINT; Length: SYSINT): TextRange; dispid 2012;
    function Characters(Start: SYSINT; Length: SYSINT): TextRange; dispid 2013;
    function Lines(Start: SYSINT; Length: SYSINT): TextRange; dispid 2014;
    function Runs(Start: SYSINT; Length: SYSINT): TextRange; dispid 2015;
    function TrimText: TextRange; dispid 2016;
    property Text: WideString dispid 0;
    function InsertAfter(const NewText: WideString): TextRange; dispid 2017;
    function InsertBefore(const NewText: WideString): TextRange; dispid 2018;
    function InsertDateTime(DateTimeFormat: PpDateTimeFormat; InsertAsField: MsoTriState): TextRange; dispid 2019;
    function InsertSlideNumber: TextRange; dispid 2020;
    function InsertSymbol(const FontName: WideString; CharNumber: SYSINT; Unicode: MsoTriState): TextRange; dispid 2021;
    property Font: Font readonly dispid 2022;
    property ParagraphFormat: ParagraphFormat readonly dispid 2023;
    property IndentLevel: SYSINT dispid 2024;
    procedure Select; dispid 2025;
    procedure Cut; dispid 2026;
    procedure Copy; dispid 2027;
    procedure Delete; dispid 2028;
    function Paste: TextRange; dispid 2029;
    procedure ChangeCase(Type_: PpChangeCase); dispid 2030;
    procedure AddPeriods; dispid 2031;
    procedure RemovePeriods; dispid 2032;
    function Find(const FindWhat: WideString; After: SYSINT; MatchCase: MsoTriState; 
                  WholeWords: MsoTriState): TextRange; dispid 2033;
    function Replace(const FindWhat: WideString; const ReplaceWhat: WideString; After: SYSINT; 
                     MatchCase: MsoTriState; WholeWords: MsoTriState): TextRange; dispid 2034;
    procedure RotatedBounds(out X1: Single; out Y1: Single; out X2: Single; out Y2: Single; 
                            out X3: Single; out Y3: Single; out x4: Single; out y4: Single); dispid 2035;
    property LanguageID: MsoLanguageID dispid 2036;
    procedure RtlRun; dispid 2037;
    procedure LtrRun; dispid 2038;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: Ruler
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493490-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Ruler = interface(IDispatch)
    ['{91493490-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_TabStops: TabStops; safecall;
    function Get_Levels: RulerLevels; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property TabStops: TabStops read Get_TabStops;
    property Levels: RulerLevels read Get_Levels;
  end;

// *********************************************************************//
// DispIntf:  RulerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493490-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  RulerDisp = dispinterface
    ['{91493490-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property TabStops: TabStops readonly dispid 2003;
    property Levels: RulerLevels readonly dispid 2004;
  end;

// *********************************************************************//
// Interface: RulerLevels
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493491-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  RulerLevels = interface(Collection)
    ['{91493491-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): RulerLevel; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  RulerLevelsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493491-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  RulerLevelsDisp = dispinterface
    ['{91493491-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): RulerLevel; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: RulerLevel
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493492-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  RulerLevel = interface(IDispatch)
    ['{91493492-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_FirstMargin: Single; safecall;
    procedure Set_FirstMargin(FirstMargin: Single); safecall;
    function Get_LeftMargin: Single; safecall;
    procedure Set_LeftMargin(LeftMargin: Single); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property FirstMargin: Single read Get_FirstMargin write Set_FirstMargin;
    property LeftMargin: Single read Get_LeftMargin write Set_LeftMargin;
  end;

// *********************************************************************//
// DispIntf:  RulerLevelDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493492-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  RulerLevelDisp = dispinterface
    ['{91493492-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property FirstMargin: Single dispid 2003;
    property LeftMargin: Single dispid 2004;
  end;

// *********************************************************************//
// Interface: TabStops
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493493-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TabStops = interface(Collection)
    ['{91493493-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): TabStop; safecall;
    function Get_DefaultSpacing: Single; safecall;
    procedure Set_DefaultSpacing(DefaultSpacing: Single); safecall;
    function Add(Type_: PpTabStopType; Position: Single): TabStop; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property DefaultSpacing: Single read Get_DefaultSpacing write Set_DefaultSpacing;
  end;

// *********************************************************************//
// DispIntf:  TabStopsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493493-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TabStopsDisp = dispinterface
    ['{91493493-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): TabStop; dispid 0;
    property DefaultSpacing: Single dispid 2003;
    function Add(Type_: PpTabStopType; Position: Single): TabStop; dispid 2004;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: TabStop
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493494-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TabStop = interface(IDispatch)
    ['{91493494-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_type_: PpTabStopType; safecall;
    procedure Set_type_(Type_: PpTabStopType); safecall;
    function Get_Position: Single; safecall;
    procedure Set_Position(Position: Single); safecall;
    procedure Clear; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property type_: PpTabStopType read Get_type_ write Set_type_;
    property Position: Single read Get_Position write Set_Position;
  end;

// *********************************************************************//
// DispIntf:  TabStopDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493494-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TabStopDisp = dispinterface
    ['{91493494-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property type_: PpTabStopType dispid 2003;
    property Position: Single dispid 2004;
    procedure Clear; dispid 2005;
  end;

// *********************************************************************//
// Interface: Font
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493495-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Font = interface(IDispatch)
    ['{91493495-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Color: ColorFormat; safecall;
    function Get_Bold: MsoTriState; safecall;
    procedure Set_Bold(Bold: MsoTriState); safecall;
    function Get_Italic: MsoTriState; safecall;
    procedure Set_Italic(Italic: MsoTriState); safecall;
    function Get_Shadow: MsoTriState; safecall;
    procedure Set_Shadow(Shadow: MsoTriState); safecall;
    function Get_Emboss: MsoTriState; safecall;
    procedure Set_Emboss(Emboss: MsoTriState); safecall;
    function Get_Underline: MsoTriState; safecall;
    procedure Set_Underline(Underline: MsoTriState); safecall;
    function Get_Subscript: MsoTriState; safecall;
    procedure Set_Subscript(Subscript: MsoTriState); safecall;
    function Get_Superscript: MsoTriState; safecall;
    procedure Set_Superscript(Superscript: MsoTriState); safecall;
    function Get_BaselineOffset: Single; safecall;
    procedure Set_BaselineOffset(BaselineOffset: Single); safecall;
    function Get_Embedded: MsoTriState; safecall;
    function Get_Embeddable: MsoTriState; safecall;
    function Get_Size: Single; safecall;
    procedure Set_Size(Size: Single); safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function Get_NameFarEast: WideString; safecall;
    procedure Set_NameFarEast(const NameFarEast: WideString); safecall;
    function Get_NameAscii: WideString; safecall;
    procedure Set_NameAscii(const NameAscii: WideString); safecall;
    function Get_AutoRotateNumbers: MsoTriState; safecall;
    procedure Set_AutoRotateNumbers(AutoRotateNumbers: MsoTriState); safecall;
    function Get_NameOther: WideString; safecall;
    procedure Set_NameOther(const NameOther: WideString); safecall;
    function Get_NameComplexScript: WideString; safecall;
    procedure Set_NameComplexScript(const NameComplexScript: WideString); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Color: ColorFormat read Get_Color;
    property Bold: MsoTriState read Get_Bold write Set_Bold;
    property Italic: MsoTriState read Get_Italic write Set_Italic;
    property Shadow: MsoTriState read Get_Shadow write Set_Shadow;
    property Emboss: MsoTriState read Get_Emboss write Set_Emboss;
    property Underline: MsoTriState read Get_Underline write Set_Underline;
    property Subscript: MsoTriState read Get_Subscript write Set_Subscript;
    property Superscript: MsoTriState read Get_Superscript write Set_Superscript;
    property BaselineOffset: Single read Get_BaselineOffset write Set_BaselineOffset;
    property Embedded: MsoTriState read Get_Embedded;
    property Embeddable: MsoTriState read Get_Embeddable;
    property Size: Single read Get_Size write Set_Size;
    property Name: WideString read Get_Name write Set_Name;
    property NameFarEast: WideString read Get_NameFarEast write Set_NameFarEast;
    property NameAscii: WideString read Get_NameAscii write Set_NameAscii;
    property AutoRotateNumbers: MsoTriState read Get_AutoRotateNumbers write Set_AutoRotateNumbers;
    property NameOther: WideString read Get_NameOther write Set_NameOther;
    property NameComplexScript: WideString read Get_NameComplexScript write Set_NameComplexScript;
  end;

// *********************************************************************//
// DispIntf:  FontDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493495-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FontDisp = dispinterface
    ['{91493495-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Color: ColorFormat readonly dispid 2003;
    property Bold: MsoTriState dispid 2004;
    property Italic: MsoTriState dispid 2005;
    property Shadow: MsoTriState dispid 2006;
    property Emboss: MsoTriState dispid 2007;
    property Underline: MsoTriState dispid 2008;
    property Subscript: MsoTriState dispid 2009;
    property Superscript: MsoTriState dispid 2010;
    property BaselineOffset: Single dispid 2011;
    property Embedded: MsoTriState readonly dispid 2012;
    property Embeddable: MsoTriState readonly dispid 2013;
    property Size: Single dispid 2014;
    property Name: WideString dispid 2015;
    property NameFarEast: WideString dispid 2016;
    property NameAscii: WideString dispid 2017;
    property AutoRotateNumbers: MsoTriState dispid 2018;
    property NameOther: WideString dispid 2019;
    property NameComplexScript: WideString dispid 2020;
  end;

// *********************************************************************//
// Interface: ParagraphFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493496-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ParagraphFormat = interface(IDispatch)
    ['{91493496-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Alignment: PpParagraphAlignment; safecall;
    procedure Set_Alignment(Alignment: PpParagraphAlignment); safecall;
    function Get_Bullet: BulletFormat; safecall;
    function Get_LineRuleBefore: MsoTriState; safecall;
    procedure Set_LineRuleBefore(LineRuleBefore: MsoTriState); safecall;
    function Get_LineRuleAfter: MsoTriState; safecall;
    procedure Set_LineRuleAfter(LineRuleAfter: MsoTriState); safecall;
    function Get_LineRuleWithin: MsoTriState; safecall;
    procedure Set_LineRuleWithin(LineRuleWithin: MsoTriState); safecall;
    function Get_SpaceBefore: Single; safecall;
    procedure Set_SpaceBefore(SpaceBefore: Single); safecall;
    function Get_SpaceAfter: Single; safecall;
    procedure Set_SpaceAfter(SpaceAfter: Single); safecall;
    function Get_SpaceWithin: Single; safecall;
    procedure Set_SpaceWithin(SpaceWithin: Single); safecall;
    function Get_BaseLineAlignment: PpBaselineAlignment; safecall;
    procedure Set_BaseLineAlignment(BaseLineAlignment: PpBaselineAlignment); safecall;
    function Get_FarEastLineBreakControl: MsoTriState; safecall;
    procedure Set_FarEastLineBreakControl(FarEastLineBreakControl: MsoTriState); safecall;
    function Get_WordWrap: MsoTriState; safecall;
    procedure Set_WordWrap(WordWrap: MsoTriState); safecall;
    function Get_HangingPunctuation: MsoTriState; safecall;
    procedure Set_HangingPunctuation(HangingPunctuation: MsoTriState); safecall;
    function Get_TextDirection: PpDirection; safecall;
    procedure Set_TextDirection(TextDirection: PpDirection); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Alignment: PpParagraphAlignment read Get_Alignment write Set_Alignment;
    property Bullet: BulletFormat read Get_Bullet;
    property LineRuleBefore: MsoTriState read Get_LineRuleBefore write Set_LineRuleBefore;
    property LineRuleAfter: MsoTriState read Get_LineRuleAfter write Set_LineRuleAfter;
    property LineRuleWithin: MsoTriState read Get_LineRuleWithin write Set_LineRuleWithin;
    property SpaceBefore: Single read Get_SpaceBefore write Set_SpaceBefore;
    property SpaceAfter: Single read Get_SpaceAfter write Set_SpaceAfter;
    property SpaceWithin: Single read Get_SpaceWithin write Set_SpaceWithin;
    property BaseLineAlignment: PpBaselineAlignment read Get_BaseLineAlignment write Set_BaseLineAlignment;
    property FarEastLineBreakControl: MsoTriState read Get_FarEastLineBreakControl write Set_FarEastLineBreakControl;
    property WordWrap: MsoTriState read Get_WordWrap write Set_WordWrap;
    property HangingPunctuation: MsoTriState read Get_HangingPunctuation write Set_HangingPunctuation;
    property TextDirection: PpDirection read Get_TextDirection write Set_TextDirection;
  end;

// *********************************************************************//
// DispIntf:  ParagraphFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493496-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ParagraphFormatDisp = dispinterface
    ['{91493496-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Alignment: PpParagraphAlignment dispid 2003;
    property Bullet: BulletFormat readonly dispid 2004;
    property LineRuleBefore: MsoTriState dispid 2005;
    property LineRuleAfter: MsoTriState dispid 2006;
    property LineRuleWithin: MsoTriState dispid 2007;
    property SpaceBefore: Single dispid 2008;
    property SpaceAfter: Single dispid 2009;
    property SpaceWithin: Single dispid 2010;
    property BaseLineAlignment: PpBaselineAlignment dispid 2011;
    property FarEastLineBreakControl: MsoTriState dispid 2012;
    property WordWrap: MsoTriState dispid 2013;
    property HangingPunctuation: MsoTriState dispid 2014;
    property TextDirection: PpDirection dispid 2015;
  end;

// *********************************************************************//
// Interface: BulletFormat
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493497-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  BulletFormat = interface(IDispatch)
    ['{91493497-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    function Get_Character: SYSINT; safecall;
    procedure Set_Character(Character: SYSINT); safecall;
    function Get_RelativeSize: Single; safecall;
    procedure Set_RelativeSize(RelativeSize: Single); safecall;
    function Get_UseTextColor: MsoTriState; safecall;
    procedure Set_UseTextColor(UseTextColor: MsoTriState); safecall;
    function Get_UseTextFont: MsoTriState; safecall;
    procedure Set_UseTextFont(UseTextFont: MsoTriState); safecall;
    function Get_Font: Font; safecall;
    function Get_type_: PpBulletType; safecall;
    procedure Set_type_(Type_: PpBulletType); safecall;
    function Get_Style: PpNumberedBulletStyle; safecall;
    procedure Set_Style(Style: PpNumberedBulletStyle); safecall;
    function Get_StartValue: SYSINT; safecall;
    procedure Set_StartValue(StartValue: SYSINT); safecall;
    procedure Picture(const Picture: WideString); safecall;
    function Get_Number: SYSINT; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property Character: SYSINT read Get_Character write Set_Character;
    property RelativeSize: Single read Get_RelativeSize write Set_RelativeSize;
    property UseTextColor: MsoTriState read Get_UseTextColor write Set_UseTextColor;
    property UseTextFont: MsoTriState read Get_UseTextFont write Set_UseTextFont;
    property Font: Font read Get_Font;
    property type_: PpBulletType read Get_type_ write Set_type_;
    property Style: PpNumberedBulletStyle read Get_Style write Set_Style;
    property StartValue: SYSINT read Get_StartValue write Set_StartValue;
    property Number: SYSINT read Get_Number;
  end;

// *********************************************************************//
// DispIntf:  BulletFormatDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493497-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  BulletFormatDisp = dispinterface
    ['{91493497-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Visible: MsoTriState dispid 0;
    property Character: SYSINT dispid 2003;
    property RelativeSize: Single dispid 2004;
    property UseTextColor: MsoTriState dispid 2005;
    property UseTextFont: MsoTriState dispid 2006;
    property Font: Font readonly dispid 2007;
    property type_: PpBulletType dispid 2008;
    property Style: PpNumberedBulletStyle dispid 2009;
    property StartValue: SYSINT dispid 2010;
    procedure Picture(const Picture: WideString); dispid 2011;
    property Number: SYSINT readonly dispid 2012;
  end;

// *********************************************************************//
// Interface: TextStyles
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493498-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextStyles = interface(Collection)
    ['{91493498-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(Type_: PpTextStyleType): TextStyle; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  TextStylesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493498-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextStylesDisp = dispinterface
    ['{91493498-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(Type_: PpTextStyleType): TextStyle; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: TextStyle
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493499-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextStyle = interface(IDispatch)
    ['{91493499-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Ruler: Ruler; safecall;
    function Get_TextFrame: TextFrame; safecall;
    function Get_Levels: TextStyleLevels; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Ruler: Ruler read Get_Ruler;
    property TextFrame: TextFrame read Get_TextFrame;
    property Levels: TextStyleLevels read Get_Levels;
  end;

// *********************************************************************//
// DispIntf:  TextStyleDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {91493499-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextStyleDisp = dispinterface
    ['{91493499-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Ruler: Ruler readonly dispid 2003;
    property TextFrame: TextFrame readonly dispid 2004;
    property Levels: TextStyleLevels readonly dispid 2005;
  end;

// *********************************************************************//
// Interface: TextStyleLevels
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextStyleLevels = interface(Collection)
    ['{9149349A-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(Level: SYSINT): TextStyleLevel; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  TextStyleLevelsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349A-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextStyleLevelsDisp = dispinterface
    ['{9149349A-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(Level: SYSINT): TextStyleLevel; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: TextStyleLevel
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextStyleLevel = interface(IDispatch)
    ['{9149349B-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_ParagraphFormat: ParagraphFormat; safecall;
    function Get_Font: Font; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property ParagraphFormat: ParagraphFormat read Get_ParagraphFormat;
    property Font: Font read Get_Font;
  end;

// *********************************************************************//
// DispIntf:  TextStyleLevelDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349B-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TextStyleLevelDisp = dispinterface
    ['{9149349B-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property ParagraphFormat: ParagraphFormat readonly dispid 2003;
    property Font: Font readonly dispid 2004;
  end;

// *********************************************************************//
// Interface: HeaderFooter
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  HeaderFooter = interface(IDispatch)
    ['{9149349C-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const Text: WideString); safecall;
    function Get_UseFormat: MsoTriState; safecall;
    procedure Set_UseFormat(UseFormat: MsoTriState); safecall;
    function Get_Format: PpDateTimeFormat; safecall;
    procedure Set_Format(Format: PpDateTimeFormat); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property Text: WideString read Get_Text write Set_Text;
    property UseFormat: MsoTriState read Get_UseFormat write Set_UseFormat;
    property Format: PpDateTimeFormat read Get_Format write Set_Format;
  end;

// *********************************************************************//
// DispIntf:  HeaderFooterDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349C-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  HeaderFooterDisp = dispinterface
    ['{9149349C-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Visible: MsoTriState dispid 2003;
    property Text: WideString dispid 2004;
    property UseFormat: MsoTriState dispid 2005;
    property Format: PpDateTimeFormat dispid 2006;
  end;

// *********************************************************************//
// Interface: PPDialogs
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPDialogs = interface(Collection)
    ['{9149349E-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Item(index: OleVariant): PPDialog; safecall;
    function AddDialog(Left: Single; Top: Single; Width: Single; Height: Single; 
                       Modal: MsoTriState; const ParentWindow: IUnknown; 
                       Position: PpDialogPositioning; DisplayHelp: MsoTriState): PPDialog; safecall;
    function AddTabDialog(Left: Single; Top: Single; Width: Single; Height: Single; 
                          Modal: MsoTriState; const ParentWindow: IUnknown; 
                          Position: PpDialogPositioning; DisplayHelp: MsoTriState): PPDialog; safecall;
    function LoadDialog(const resourceDLL: WideString; nResID: SYSINT; bModal: MsoTriState; 
                        const ParentWindow: IUnknown; Position: PpDialogPositioning): PPDialog; safecall;
    function AddAlert: PPAlert; safecall;
    function Get_Tags: Tags; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function RunCharacterAlert(const Text: WideString; Type_: PpAlertType; icon: PpAlertIcon; 
                               const ParentWindow: IUnknown): PpAlertButton; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Tags: Tags read Get_Tags;
    property Name: WideString read Get_Name write Set_Name;
  end;

// *********************************************************************//
// DispIntf:  PPDialogsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349E-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPDialogsDisp = dispinterface
    ['{9149349E-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    function Item(index: OleVariant): PPDialog; dispid 0;
    function AddDialog(Left: Single; Top: Single; Width: Single; Height: Single; 
                       Modal: MsoTriState; const ParentWindow: IUnknown; 
                       Position: PpDialogPositioning; DisplayHelp: MsoTriState): PPDialog; dispid 2002;
    function AddTabDialog(Left: Single; Top: Single; Width: Single; Height: Single; 
                          Modal: MsoTriState; const ParentWindow: IUnknown; 
                          Position: PpDialogPositioning; DisplayHelp: MsoTriState): PPDialog; dispid 2003;
    function LoadDialog(const resourceDLL: WideString; nResID: SYSINT; bModal: MsoTriState; 
                        const ParentWindow: IUnknown; Position: PpDialogPositioning): PPDialog; dispid 2004;
    function AddAlert: PPAlert; dispid 2005;
    property Tags: Tags readonly dispid 2006;
    property Name: WideString dispid 2007;
    function RunCharacterAlert(const Text: WideString; Type_: PpAlertType; icon: PpAlertIcon; 
                               const ParentWindow: IUnknown): PpAlertButton; dispid 2008;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: PPAlert
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPAlert = interface(IDispatch)
    ['{9149349F-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    procedure Run(const Title: WideString; Type_: SYSINT; const Text: WideString; 
                  const leftBtn: WideString; const middleBtn: WideString; const rightBtn: WideString); safecall;
    function Get_PressedButton: SYSINT; safecall;
    function Get_OnButton: WideString; safecall;
    procedure Set_OnButton(const OnButton: WideString); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property PressedButton: SYSINT read Get_PressedButton;
    property OnButton: WideString read Get_OnButton write Set_OnButton;
  end;

// *********************************************************************//
// DispIntf:  PPAlertDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {9149349F-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPAlertDisp = dispinterface
    ['{9149349F-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    procedure Run(const Title: WideString; Type_: SYSINT; const Text: WideString; 
                  const leftBtn: WideString; const middleBtn: WideString; const rightBtn: WideString); dispid 2003;
    property PressedButton: SYSINT readonly dispid 2004;
    property OnButton: WideString dispid 2005;
  end;

// *********************************************************************//
// Interface: PPDialog
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A0-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPDialog = interface(IDispatch)
    ['{914934A0-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Style: PpDialogStyle; safecall;
    function Get_Mode: PpDialogMode; safecall;
    procedure Set_Mode(Mode: PpDialogMode); safecall;
    function Get_HelpId: SYSINT; safecall;
    procedure Set_HelpId(HelpId: SYSINT); safecall;
    function Get_HideOnIdle: MsoTriState; safecall;
    procedure Set_HideOnIdle(HideOnIdle: MsoTriState); safecall;
    function Get_resourceDLL: WideString; safecall;
    procedure Set_resourceDLL(const resourceDLL: WideString); safecall;
    function Get_Caption: WideString; safecall;
    procedure Set_Caption(const Caption: WideString); safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(Left: Single); safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(Top: Single); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(Width: Single); safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(Height: Single); safecall;
    function Get_ClientLeft: Single; safecall;
    function Get_ClientTop: Single; safecall;
    function Get_ClientWidth: Single; safecall;
    function Get_ClientHeight: Single; safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    function Get_Controls: PPControls; safecall;
    function Get_Tags: Tags; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function Get_Sheets: PPTabSheets; safecall;
    function Get_TabControl: PPTabControl; safecall;
    function Get_DelayTime: SYSINT; safecall;
    procedure Set_DelayTime(DelayTime: SYSINT); safecall;
    function SaveDialog(const FileName: WideString): SYSINT; safecall;
    procedure Terminate; safecall;
    function Get_HWND: Integer; safecall;
    function Get_OnTerminate: WideString; safecall;
    procedure Set_OnTerminate(const OnTerminate: WideString); safecall;
    function Get_OnIdle: WideString; safecall;
    procedure Set_OnIdle(const OnIdle: WideString); safecall;
    function Get_OnMouseDown: WideString; safecall;
    procedure Set_OnMouseDown(const OnMouseDown: WideString); safecall;
    function Get_OnMouseUp: WideString; safecall;
    procedure Set_OnMouseUp(const OnMouseUp: WideString); safecall;
    function Get_OnKeyPressed: WideString; safecall;
    procedure Set_OnKeyPressed(const OnKeyPressed: WideString); safecall;
    function Get_OnTimer: WideString; safecall;
    procedure Set_OnTimer(const OnTimer: WideString); safecall;
    function Get_OnActivate: WideString; safecall;
    procedure Set_OnActivate(const OnActivate: WideString); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Style: PpDialogStyle read Get_Style;
    property Mode: PpDialogMode read Get_Mode write Set_Mode;
    property HelpId: SYSINT read Get_HelpId write Set_HelpId;
    property HideOnIdle: MsoTriState read Get_HideOnIdle write Set_HideOnIdle;
    property resourceDLL: WideString read Get_resourceDLL write Set_resourceDLL;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Width: Single read Get_Width write Set_Width;
    property Height: Single read Get_Height write Set_Height;
    property ClientLeft: Single read Get_ClientLeft;
    property ClientTop: Single read Get_ClientTop;
    property ClientWidth: Single read Get_ClientWidth;
    property ClientHeight: Single read Get_ClientHeight;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property Controls: PPControls read Get_Controls;
    property Tags: Tags read Get_Tags;
    property Name: WideString read Get_Name write Set_Name;
    property Sheets: PPTabSheets read Get_Sheets;
    property TabControl: PPTabControl read Get_TabControl;
    property DelayTime: SYSINT read Get_DelayTime write Set_DelayTime;
    property HWND: Integer read Get_HWND;
    property OnTerminate: WideString read Get_OnTerminate write Set_OnTerminate;
    property OnIdle: WideString read Get_OnIdle write Set_OnIdle;
    property OnMouseDown: WideString read Get_OnMouseDown write Set_OnMouseDown;
    property OnMouseUp: WideString read Get_OnMouseUp write Set_OnMouseUp;
    property OnKeyPressed: WideString read Get_OnKeyPressed write Set_OnKeyPressed;
    property OnTimer: WideString read Get_OnTimer write Set_OnTimer;
    property OnActivate: WideString read Get_OnActivate write Set_OnActivate;
  end;

// *********************************************************************//
// DispIntf:  PPDialogDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A0-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPDialogDisp = dispinterface
    ['{914934A0-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Style: PpDialogStyle readonly dispid 2003;
    property Mode: PpDialogMode dispid 2004;
    property HelpId: SYSINT dispid 2005;
    property HideOnIdle: MsoTriState dispid 2006;
    property resourceDLL: WideString dispid 2007;
    property Caption: WideString dispid 2008;
    property Left: Single dispid 2009;
    property Top: Single dispid 2010;
    property Width: Single dispid 2011;
    property Height: Single dispid 2012;
    property ClientLeft: Single readonly dispid 2013;
    property ClientTop: Single readonly dispid 2014;
    property ClientWidth: Single readonly dispid 2015;
    property ClientHeight: Single readonly dispid 2016;
    property Visible: MsoTriState dispid 2017;
    property Controls: PPControls readonly dispid 2018;
    property Tags: Tags readonly dispid 2019;
    property Name: WideString dispid 2020;
    property Sheets: PPTabSheets readonly dispid 2021;
    property TabControl: PPTabControl readonly dispid 2022;
    property DelayTime: SYSINT dispid 2023;
    function SaveDialog(const FileName: WideString): SYSINT; dispid 2024;
    procedure Terminate; dispid 2025;
    property HWND: Integer readonly dispid 2026;
    property OnTerminate: WideString dispid 2027;
    property OnIdle: WideString dispid 2028;
    property OnMouseDown: WideString dispid 2029;
    property OnMouseUp: WideString dispid 2030;
    property OnKeyPressed: WideString dispid 2031;
    property OnTimer: WideString dispid 2032;
    property OnActivate: WideString dispid 2033;
  end;

// *********************************************************************//
// Interface: PPTabSheet
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A1-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPTabSheet = interface(IDispatch)
    ['{914934A1-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    procedure Select; safecall;
    function Get_ClientLeft: Single; safecall;
    function Get_ClientTop: Single; safecall;
    function Get_ClientWidth: Single; safecall;
    function Get_ClientHeight: Single; safecall;
    function Get_Controls: PPControls; safecall;
    function Get_Tags: Tags; safecall;
    function Get_OnActivate: WideString; safecall;
    procedure Set_OnActivate(const OnActivate: WideString); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Name: WideString read Get_Name write Set_Name;
    property ClientLeft: Single read Get_ClientLeft;
    property ClientTop: Single read Get_ClientTop;
    property ClientWidth: Single read Get_ClientWidth;
    property ClientHeight: Single read Get_ClientHeight;
    property Controls: PPControls read Get_Controls;
    property Tags: Tags read Get_Tags;
    property OnActivate: WideString read Get_OnActivate write Set_OnActivate;
  end;

// *********************************************************************//
// DispIntf:  PPTabSheetDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A1-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPTabSheetDisp = dispinterface
    ['{914934A1-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Name: WideString dispid 2003;
    procedure Select; dispid 2004;
    property ClientLeft: Single readonly dispid 2005;
    property ClientTop: Single readonly dispid 2006;
    property ClientWidth: Single readonly dispid 2007;
    property ClientHeight: Single readonly dispid 2008;
    property Controls: PPControls readonly dispid 2009;
    property Tags: Tags readonly dispid 2010;
    property OnActivate: WideString dispid 2011;
  end;

// *********************************************************************//
// Interface: PPControls
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A2-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPControls = interface(Collection)
    ['{914934A2-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Item(index: OleVariant): PPControl; safecall;
    function AddPushButton(Left: Single; Top: Single; Width: Single; Height: Single): PPPushButton; safecall;
    function AddToggleButton(Left: Single; Top: Single; Width: Single; Height: Single): PPToggleButton; safecall;
    function AddBitmapButton(Left: Single; Top: Single; Width: Single; Height: Single): PPBitmapButton; safecall;
    function AddListBox(Left: Single; Top: Single; Width: Single; Height: Single): PPListBox; safecall;
    function AddCheckBox(Left: Single; Top: Single; Width: Single; Height: Single): PPCheckBox; safecall;
    function AddRadioCluster(Left: Single; Top: Single; Width: Single; Height: Single): PPRadioCluster; safecall;
    function AddStaticText(Left: Single; Top: Single; Width: Single; Height: Single): PPStaticText; safecall;
    function AddEditText(Left: Single; Top: Single; Width: Single; Height: Single; 
                         VerticalScrollBar: OleVariant): PPEditText; safecall;
    function AddIcon(Left: Single; Top: Single; Width: Single; Height: Single): PPIcon; safecall;
    function AddBitmap(Left: Single; Top: Single; Width: Single; Height: Single): PPBitmap; safecall;
    function AddSpinner(Left: Single; Top: Single; Width: Single; Height: Single): PPSpinner; safecall;
    function AddScrollBar(Style: PpScrollBarStyle; Left: Single; Top: Single; Width: Single; 
                          Height: Single): PPScrollBar; safecall;
    function AddGroupBox(Left: Single; Top: Single; Width: Single; Height: Single): PPGroupBox; safecall;
    function AddDropDown(Left: Single; Top: Single; Width: Single; Height: Single): PPDropDown; safecall;
    function AddDropDownEdit(Left: Single; Top: Single; Width: Single; Height: Single): PPDropDownEdit; safecall;
    function AddMiniature(Left: Single; Top: Single; Width: Single; Height: Single): PPSlideMiniature; safecall;
    function AddFrame(Left: Single; Top: Single; Width: Single; Height: Single): PPFrame; safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
  end;

// *********************************************************************//
// DispIntf:  PPControlsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A2-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPControlsDisp = dispinterface
    ['{914934A2-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    function Item(index: OleVariant): PPControl; dispid 0;
    function AddPushButton(Left: Single; Top: Single; Width: Single; Height: Single): PPPushButton; dispid 2002;
    function AddToggleButton(Left: Single; Top: Single; Width: Single; Height: Single): PPToggleButton; dispid 2003;
    function AddBitmapButton(Left: Single; Top: Single; Width: Single; Height: Single): PPBitmapButton; dispid 2004;
    function AddListBox(Left: Single; Top: Single; Width: Single; Height: Single): PPListBox; dispid 2005;
    function AddCheckBox(Left: Single; Top: Single; Width: Single; Height: Single): PPCheckBox; dispid 2006;
    function AddRadioCluster(Left: Single; Top: Single; Width: Single; Height: Single): PPRadioCluster; dispid 2007;
    function AddStaticText(Left: Single; Top: Single; Width: Single; Height: Single): PPStaticText; dispid 2008;
    function AddEditText(Left: Single; Top: Single; Width: Single; Height: Single; 
                         VerticalScrollBar: OleVariant): PPEditText; dispid 2009;
    function AddIcon(Left: Single; Top: Single; Width: Single; Height: Single): PPIcon; dispid 2010;
    function AddBitmap(Left: Single; Top: Single; Width: Single; Height: Single): PPBitmap; dispid 2011;
    function AddSpinner(Left: Single; Top: Single; Width: Single; Height: Single): PPSpinner; dispid 2012;
    function AddScrollBar(Style: PpScrollBarStyle; Left: Single; Top: Single; Width: Single; 
                          Height: Single): PPScrollBar; dispid 2013;
    function AddGroupBox(Left: Single; Top: Single; Width: Single; Height: Single): PPGroupBox; dispid 2014;
    function AddDropDown(Left: Single; Top: Single; Width: Single; Height: Single): PPDropDown; dispid 2015;
    function AddDropDownEdit(Left: Single; Top: Single; Width: Single; Height: Single): PPDropDownEdit; dispid 2016;
    function AddMiniature(Left: Single; Top: Single; Width: Single; Height: Single): PPSlideMiniature; dispid 2017;
    function AddFrame(Left: Single; Top: Single; Width: Single; Height: Single): PPFrame; dispid 2018;
    property Visible: MsoTriState dispid 2019;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: PPTabSheets
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A3-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPTabSheets = interface(Collection)
    ['{914934A3-5A91-11CF-8700-00AA0060263B}']
    function Item(index: OleVariant): PPTabSheet; safecall;
    function Add(const Name: WideString): PPTabSheet; safecall;
    function Get_ActiveSheet: PPTabSheet; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    property ActiveSheet: PPTabSheet read Get_ActiveSheet;
    property Name: WideString read Get_Name write Set_Name;
  end;

// *********************************************************************//
// DispIntf:  PPTabSheetsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A3-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPTabSheetsDisp = dispinterface
    ['{914934A3-5A91-11CF-8700-00AA0060263B}']
    function Item(index: OleVariant): PPTabSheet; dispid 0;
    function Add(const Name: WideString): PPTabSheet; dispid 2001;
    property ActiveSheet: PPTabSheet readonly dispid 2002;
    property Name: WideString dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: PPControl
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {914934A4-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPControl = interface(IDispatch)
    ['{914934A4-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Enable: MsoTriState; safecall;
    procedure Set_Enable(Enable: MsoTriState); safecall;
    function Get_Visible: MsoTriState; safecall;
    procedure Set_Visible(Visible: MsoTriState); safecall;
    function Get_Focus: MsoTriState; safecall;
    procedure Set_Focus(Focus: MsoTriState); safecall;
    function Get_Label_: WideString; safecall;
    procedure Set_Label_(const Label_: WideString); safecall;
    function Get_HelpId: SYSINT; safecall;
    procedure Set_HelpId(HelpId: SYSINT); safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(Left: Single); safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(Top: Single); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(Width: Single); safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(Height: Single); safecall;
    function Get_HWND: Integer; safecall;
    function Get_OnSetFocus: WideString; safecall;
    procedure Set_OnSetFocus(const OnSetFocus: WideString); safecall;
    function Get_OnKillFocus: WideString; safecall;
    procedure Set_OnKillFocus(const OnKillFocus: WideString); safecall;
    function Get_Tags: Tags; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Enable: MsoTriState read Get_Enable write Set_Enable;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property Focus: MsoTriState read Get_Focus write Set_Focus;
    property Label_: WideString read Get_Label_ write Set_Label_;
    property HelpId: SYSINT read Get_HelpId write Set_HelpId;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Width: Single read Get_Width write Set_Width;
    property Height: Single read Get_Height write Set_Height;
    property HWND: Integer read Get_HWND;
    property OnSetFocus: WideString read Get_OnSetFocus write Set_OnSetFocus;
    property OnKillFocus: WideString read Get_OnKillFocus write Set_OnKillFocus;
    property Tags: Tags read Get_Tags;
    property Name: WideString read Get_Name write Set_Name;
  end;

// *********************************************************************//
// DispIntf:  PPControlDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {914934A4-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPControlDisp = dispinterface
    ['{914934A4-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPPushButton
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A5-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPPushButton = interface(PPControl)
    ['{914934A5-5A91-11CF-8700-00AA0060263B}']
    procedure Click; safecall;
    function Get_IsDefault: MsoTriState; safecall;
    procedure Set_IsDefault(IsDefault: MsoTriState); safecall;
    function Get_IsEscape: MsoTriState; safecall;
    procedure Set_IsEscape(IsEscape: MsoTriState); safecall;
    function Get_OnPressed: WideString; safecall;
    procedure Set_OnPressed(const OnPressed: WideString); safecall;
    property IsDefault: MsoTriState read Get_IsDefault write Set_IsDefault;
    property IsEscape: MsoTriState read Get_IsEscape write Set_IsEscape;
    property OnPressed: WideString read Get_OnPressed write Set_OnPressed;
  end;

// *********************************************************************//
// DispIntf:  PPPushButtonDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A5-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPPushButtonDisp = dispinterface
    ['{914934A5-5A91-11CF-8700-00AA0060263B}']
    procedure Click; dispid 2001;
    property IsDefault: MsoTriState dispid 2002;
    property IsEscape: MsoTriState dispid 2003;
    property OnPressed: WideString dispid 2004;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPToggleButton
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A6-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPToggleButton = interface(PPControl)
    ['{914934A6-5A91-11CF-8700-00AA0060263B}']
    function Get_State: MsoTriState; safecall;
    procedure Set_State(State: MsoTriState); safecall;
    function Get_ResourceID: SYSINT; safecall;
    procedure Set_ResourceID(ResourceID: SYSINT); safecall;
    procedure Click; safecall;
    function Get_OnClick: WideString; safecall;
    procedure Set_OnClick(const OnClick: WideString); safecall;
    property State: MsoTriState read Get_State write Set_State;
    property ResourceID: SYSINT read Get_ResourceID write Set_ResourceID;
    property OnClick: WideString read Get_OnClick write Set_OnClick;
  end;

// *********************************************************************//
// DispIntf:  PPToggleButtonDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A6-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPToggleButtonDisp = dispinterface
    ['{914934A6-5A91-11CF-8700-00AA0060263B}']
    property State: MsoTriState dispid 2001;
    property ResourceID: SYSINT dispid 2002;
    procedure Click; dispid 2003;
    property OnClick: WideString dispid 2004;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPBitmapButton
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A7-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPBitmapButton = interface(PPControl)
    ['{914934A7-5A91-11CF-8700-00AA0060263B}']
    procedure Click; safecall;
    function Get_ResourceID: SYSINT; safecall;
    procedure Set_ResourceID(ResourceID: SYSINT); safecall;
    function Get_OnPressed: WideString; safecall;
    procedure Set_OnPressed(const OnPressed: WideString); safecall;
    function Get_IsDefault: MsoTriState; safecall;
    procedure Set_IsDefault(IsDefault: MsoTriState); safecall;
    function Get_IsEscape: MsoTriState; safecall;
    procedure Set_IsEscape(IsEscape: MsoTriState); safecall;
    property ResourceID: SYSINT read Get_ResourceID write Set_ResourceID;
    property OnPressed: WideString read Get_OnPressed write Set_OnPressed;
    property IsDefault: MsoTriState read Get_IsDefault write Set_IsDefault;
    property IsEscape: MsoTriState read Get_IsEscape write Set_IsEscape;
  end;

// *********************************************************************//
// DispIntf:  PPBitmapButtonDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A7-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPBitmapButtonDisp = dispinterface
    ['{914934A7-5A91-11CF-8700-00AA0060263B}']
    procedure Click; dispid 2001;
    property ResourceID: SYSINT dispid 2002;
    property OnPressed: WideString dispid 2003;
    property IsDefault: MsoTriState dispid 2004;
    property IsEscape: MsoTriState dispid 2005;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPListBox
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A8-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPListBox = interface(PPControl)
    ['{914934A8-5A91-11CF-8700-00AA0060263B}']
    function Get_Strings: PPStrings; safecall;
    function Get_SelectionStyle: PpListBoxSelectionStyle; safecall;
    procedure Set_SelectionStyle(SelectionStyle: PpListBoxSelectionStyle); safecall;
    procedure SetTabStops(safeArrayTabStops: OleVariant); safecall;
    function Get_FocusItem: SYSINT; safecall;
    procedure Set_FocusItem(FocusItem: SYSINT); safecall;
    function Get_TopItem: SYSINT; safecall;
    function Get_OnSelectionChange: WideString; safecall;
    procedure Set_OnSelectionChange(const OnSelectionChange: WideString); safecall;
    function Get_OnDoubleClick: WideString; safecall;
    procedure Set_OnDoubleClick(const OnDoubleClick: WideString); safecall;
    function Get_IsSelected(index: SYSINT): MsoTriState; safecall;
    procedure Set_IsSelected(index: SYSINT; IsSelected: MsoTriState); safecall;
    procedure Abbreviate(Style: PpListBoxAbbreviationStyle); safecall;
    function Get_IsAbbreviated: PpListBoxAbbreviationStyle; safecall;
    property Strings: PPStrings read Get_Strings;
    property SelectionStyle: PpListBoxSelectionStyle read Get_SelectionStyle write Set_SelectionStyle;
    property FocusItem: SYSINT read Get_FocusItem write Set_FocusItem;
    property TopItem: SYSINT read Get_TopItem;
    property OnSelectionChange: WideString read Get_OnSelectionChange write Set_OnSelectionChange;
    property OnDoubleClick: WideString read Get_OnDoubleClick write Set_OnDoubleClick;
    property IsSelected[index: SYSINT]: MsoTriState read Get_IsSelected write Set_IsSelected;
    property IsAbbreviated: PpListBoxAbbreviationStyle read Get_IsAbbreviated;
  end;

// *********************************************************************//
// DispIntf:  PPListBoxDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A8-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPListBoxDisp = dispinterface
    ['{914934A8-5A91-11CF-8700-00AA0060263B}']
    property Strings: PPStrings readonly dispid 2001;
    property SelectionStyle: PpListBoxSelectionStyle dispid 2002;
    procedure SetTabStops(safeArrayTabStops: OleVariant); dispid 2003;
    property FocusItem: SYSINT dispid 2004;
    property TopItem: SYSINT readonly dispid 2005;
    property OnSelectionChange: WideString dispid 2006;
    property OnDoubleClick: WideString dispid 2007;
    property IsSelected[index: SYSINT]: MsoTriState dispid 999;
    procedure Abbreviate(Style: PpListBoxAbbreviationStyle); dispid 2008;
    property IsAbbreviated: PpListBoxAbbreviationStyle readonly dispid 2009;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPStrings
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A9-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPStrings = interface(Collection)
    ['{914934A9-5A91-11CF-8700-00AA0060263B}']
    function Item(index: SYSINT): WideString; safecall;
    function Add(const String_: WideString): WideString; safecall;
    procedure Insert(const String_: WideString; Position: SYSINT); safecall;
    procedure Delete(index: SYSINT); safecall;
  end;

// *********************************************************************//
// DispIntf:  PPStringsDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934A9-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPStringsDisp = dispinterface
    ['{914934A9-5A91-11CF-8700-00AA0060263B}']
    function Item(index: SYSINT): WideString; dispid 0;
    function Add(const String_: WideString): WideString; dispid 2001;
    procedure Insert(const String_: WideString; Position: SYSINT); dispid 2002;
    procedure Delete(index: SYSINT); dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: PPCheckBox
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AA-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPCheckBox = interface(PPControl)
    ['{914934AA-5A91-11CF-8700-00AA0060263B}']
    function Get_State: MsoTriState; safecall;
    procedure Set_State(State: MsoTriState); safecall;
    procedure Click; safecall;
    function Get_OnClick: WideString; safecall;
    procedure Set_OnClick(const OnClick: WideString); safecall;
    property State: MsoTriState read Get_State write Set_State;
    property OnClick: WideString read Get_OnClick write Set_OnClick;
  end;

// *********************************************************************//
// DispIntf:  PPCheckBoxDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AA-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPCheckBoxDisp = dispinterface
    ['{914934AA-5A91-11CF-8700-00AA0060263B}']
    property State: MsoTriState dispid 2001;
    procedure Click; dispid 2002;
    property OnClick: WideString dispid 2003;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPRadioCluster
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AB-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPRadioCluster = interface(PPControl)
    ['{914934AB-5A91-11CF-8700-00AA0060263B}']
    function Item(index: OleVariant): PPRadioButton; safecall;
    function Add(Left: Single; Top: Single; Width: Single; Height: Single): PPRadioButton; safecall;
    function Get_Count: SYSINT; safecall;
    function Get_Selected: PPRadioButton; safecall;
    function Get_OnClick: WideString; safecall;
    procedure Set_OnClick(const OnClick: WideString); safecall;
    property Count: SYSINT read Get_Count;
    property Selected: PPRadioButton read Get_Selected;
    property OnClick: WideString read Get_OnClick write Set_OnClick;
  end;

// *********************************************************************//
// DispIntf:  PPRadioClusterDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AB-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPRadioClusterDisp = dispinterface
    ['{914934AB-5A91-11CF-8700-00AA0060263B}']
    function Item(index: OleVariant): PPRadioButton; dispid 0;
    function Add(Left: Single; Top: Single; Width: Single; Height: Single): PPRadioButton; dispid 2001;
    property Count: SYSINT readonly dispid 2002;
    property Selected: PPRadioButton readonly dispid 2003;
    property OnClick: WideString dispid 2004;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPStaticText
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AC-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPStaticText = interface(PPControl)
    ['{914934AC-5A91-11CF-8700-00AA0060263B}']
    function Get_UseForegroundColor: MsoTriState; safecall;
    procedure Set_UseForegroundColor(UseForegroundColor: MsoTriState); safecall;
    function Get_UseBackgroundColor: MsoTriState; safecall;
    procedure Set_UseBackgroundColor(UseBackgroundColor: MsoTriState); safecall;
    function Get_ForegroundColor: MsoRGBType; safecall;
    procedure Set_ForegroundColor(ForegroundColor: MsoRGBType); safecall;
    function Get_BackgroundColor: MsoRGBType; safecall;
    procedure Set_BackgroundColor(BackgroundColor: MsoRGBType); safecall;
    property UseForegroundColor: MsoTriState read Get_UseForegroundColor write Set_UseForegroundColor;
    property UseBackgroundColor: MsoTriState read Get_UseBackgroundColor write Set_UseBackgroundColor;
    property ForegroundColor: MsoRGBType read Get_ForegroundColor write Set_ForegroundColor;
    property BackgroundColor: MsoRGBType read Get_BackgroundColor write Set_BackgroundColor;
  end;

// *********************************************************************//
// DispIntf:  PPStaticTextDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AC-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPStaticTextDisp = dispinterface
    ['{914934AC-5A91-11CF-8700-00AA0060263B}']
    property UseForegroundColor: MsoTriState dispid 2001;
    property UseBackgroundColor: MsoTriState dispid 2002;
    property ForegroundColor: MsoRGBType dispid 2003;
    property BackgroundColor: MsoRGBType dispid 2004;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPEditText
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AD-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPEditText = interface(PPControl)
    ['{914934AD-5A91-11CF-8700-00AA0060263B}']
    function Get_MultiLine: MsoTriState; safecall;
    procedure Set_MultiLine(MultiLine: MsoTriState); safecall;
    function Get_VerticalScrollBar: MsoTriState; safecall;
    procedure Set_VerticalScrollBar(VerticalScrollBar: MsoTriState); safecall;
    function Get_WordWrap: MsoTriState; safecall;
    procedure Set_WordWrap(WordWrap: MsoTriState); safecall;
    function Get_ReadOnly: MsoTriState; safecall;
    procedure Set_ReadOnly(ReadOnly: MsoTriState); safecall;
    function Get_Text: WideString; safecall;
    procedure Set_Text(const Text: WideString); safecall;
    function Get_MaxLength: SYSINT; safecall;
    procedure Set_MaxLength(MaxLength: SYSINT); safecall;
    function Get_OnAChange: WideString; safecall;
    procedure Set_OnAChange(const OnAChange: WideString); safecall;
    property MultiLine: MsoTriState read Get_MultiLine write Set_MultiLine;
    property VerticalScrollBar: MsoTriState read Get_VerticalScrollBar write Set_VerticalScrollBar;
    property WordWrap: MsoTriState read Get_WordWrap write Set_WordWrap;
    property ReadOnly: MsoTriState read Get_ReadOnly write Set_ReadOnly;
    property Text: WideString read Get_Text write Set_Text;
    property MaxLength: SYSINT read Get_MaxLength write Set_MaxLength;
    property OnAChange: WideString read Get_OnAChange write Set_OnAChange;
  end;

// *********************************************************************//
// DispIntf:  PPEditTextDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AD-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPEditTextDisp = dispinterface
    ['{914934AD-5A91-11CF-8700-00AA0060263B}']
    property MultiLine: MsoTriState dispid 2001;
    property VerticalScrollBar: MsoTriState dispid 2002;
    property WordWrap: MsoTriState dispid 2003;
    property ReadOnly: MsoTriState dispid 2004;
    property Text: WideString dispid 2005;
    property MaxLength: SYSINT dispid 2006;
    property OnAChange: WideString dispid 2007;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPIcon
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AE-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPIcon = interface(PPControl)
    ['{914934AE-5A91-11CF-8700-00AA0060263B}']
    function Get_ResourceID: SYSINT; safecall;
    procedure Set_ResourceID(ResourceID: SYSINT); safecall;
    property ResourceID: SYSINT read Get_ResourceID write Set_ResourceID;
  end;

// *********************************************************************//
// DispIntf:  PPIconDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AE-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPIconDisp = dispinterface
    ['{914934AE-5A91-11CF-8700-00AA0060263B}']
    property ResourceID: SYSINT dispid 2001;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPBitmap
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AF-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPBitmap = interface(PPControl)
    ['{914934AF-5A91-11CF-8700-00AA0060263B}']
    function Get_ResourceID: SYSINT; safecall;
    procedure Set_ResourceID(ResourceID: SYSINT); safecall;
    function Get_OnClick: WideString; safecall;
    procedure Set_OnClick(const OnClick: WideString); safecall;
    property ResourceID: SYSINT read Get_ResourceID write Set_ResourceID;
    property OnClick: WideString read Get_OnClick write Set_OnClick;
  end;

// *********************************************************************//
// DispIntf:  PPBitmapDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934AF-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPBitmapDisp = dispinterface
    ['{914934AF-5A91-11CF-8700-00AA0060263B}']
    property ResourceID: SYSINT dispid 2000;
    property OnClick: WideString dispid 2001;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPSpinner
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B0-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPSpinner = interface(PPControl)
    ['{914934B0-5A91-11CF-8700-00AA0060263B}']
    function Get_Minimum: SYSINT; safecall;
    procedure Set_Minimum(Minimum: SYSINT); safecall;
    function Get_Maximum: SYSINT; safecall;
    procedure Set_Maximum(Maximum: SYSINT); safecall;
    function Get_Increment: SYSINT; safecall;
    procedure Set_Increment(Increment: SYSINT); safecall;
    function Get_PageChange: SYSINT; safecall;
    procedure Set_PageChange(PageChange: SYSINT); safecall;
    function Get_CurrentValue: SYSINT; safecall;
    procedure Set_CurrentValue(CurrentValue: SYSINT); safecall;
    function Get_OnAChange: WideString; safecall;
    procedure Set_OnAChange(const OnAChange: WideString); safecall;
    property Minimum: SYSINT read Get_Minimum write Set_Minimum;
    property Maximum: SYSINT read Get_Maximum write Set_Maximum;
    property Increment: SYSINT read Get_Increment write Set_Increment;
    property PageChange: SYSINT read Get_PageChange write Set_PageChange;
    property CurrentValue: SYSINT read Get_CurrentValue write Set_CurrentValue;
    property OnAChange: WideString read Get_OnAChange write Set_OnAChange;
  end;

// *********************************************************************//
// DispIntf:  PPSpinnerDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B0-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPSpinnerDisp = dispinterface
    ['{914934B0-5A91-11CF-8700-00AA0060263B}']
    property Minimum: SYSINT dispid 2001;
    property Maximum: SYSINT dispid 2002;
    property Increment: SYSINT dispid 2003;
    property PageChange: SYSINT dispid 2004;
    property CurrentValue: SYSINT dispid 2005;
    property OnAChange: WideString dispid 2006;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPScrollBar
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B1-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPScrollBar = interface(PPControl)
    ['{914934B1-5A91-11CF-8700-00AA0060263B}']
    function Get_Minimum: SYSINT; safecall;
    procedure Set_Minimum(Minimum: SYSINT); safecall;
    function Get_Maximum: SYSINT; safecall;
    procedure Set_Maximum(Maximum: SYSINT); safecall;
    function Get_Increment: SYSINT; safecall;
    procedure Set_Increment(Increment: SYSINT); safecall;
    function Get_PageChange: SYSINT; safecall;
    procedure Set_PageChange(PageChange: SYSINT); safecall;
    function Get_CurrentValue: SYSINT; safecall;
    procedure Set_CurrentValue(CurrentValue: SYSINT); safecall;
    function Get_OnScroll: WideString; safecall;
    procedure Set_OnScroll(const OnScroll: WideString); safecall;
    property Minimum: SYSINT read Get_Minimum write Set_Minimum;
    property Maximum: SYSINT read Get_Maximum write Set_Maximum;
    property Increment: SYSINT read Get_Increment write Set_Increment;
    property PageChange: SYSINT read Get_PageChange write Set_PageChange;
    property CurrentValue: SYSINT read Get_CurrentValue write Set_CurrentValue;
    property OnScroll: WideString read Get_OnScroll write Set_OnScroll;
  end;

// *********************************************************************//
// DispIntf:  PPScrollBarDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B1-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPScrollBarDisp = dispinterface
    ['{914934B1-5A91-11CF-8700-00AA0060263B}']
    property Minimum: SYSINT dispid 2001;
    property Maximum: SYSINT dispid 2002;
    property Increment: SYSINT dispid 2003;
    property PageChange: SYSINT dispid 2004;
    property CurrentValue: SYSINT dispid 2005;
    property OnScroll: WideString dispid 2006;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPGroupBox
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B2-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPGroupBox = interface(PPControl)
    ['{914934B2-5A91-11CF-8700-00AA0060263B}']
  end;

// *********************************************************************//
// DispIntf:  PPGroupBoxDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B2-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPGroupBoxDisp = dispinterface
    ['{914934B2-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPFrame
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B3-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPFrame = interface(PPControl)
    ['{914934B3-5A91-11CF-8700-00AA0060263B}']
  end;

// *********************************************************************//
// DispIntf:  PPFrameDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B3-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPFrameDisp = dispinterface
    ['{914934B3-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPTabControl
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B4-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPTabControl = interface(PPControl)
    ['{914934B4-5A91-11CF-8700-00AA0060263B}']
  end;

// *********************************************************************//
// DispIntf:  PPTabControlDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B4-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPTabControlDisp = dispinterface
    ['{914934B4-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPDropDown
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B5-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPDropDown = interface(PPControl)
    ['{914934B5-5A91-11CF-8700-00AA0060263B}']
    function Get_Strings: PPStrings; safecall;
    function Get_FocusItem: SYSINT; safecall;
    procedure Set_FocusItem(FocusItem: SYSINT); safecall;
    function Get_OnSelectionChange: WideString; safecall;
    procedure Set_OnSelectionChange(const OnSelectionChange: WideString); safecall;
    property Strings: PPStrings read Get_Strings;
    property FocusItem: SYSINT read Get_FocusItem write Set_FocusItem;
    property OnSelectionChange: WideString read Get_OnSelectionChange write Set_OnSelectionChange;
  end;

// *********************************************************************//
// DispIntf:  PPDropDownDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B5-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPDropDownDisp = dispinterface
    ['{914934B5-5A91-11CF-8700-00AA0060263B}']
    property Strings: PPStrings readonly dispid 2001;
    property FocusItem: SYSINT dispid 2002;
    property OnSelectionChange: WideString dispid 2003;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPDropDownEdit
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B6-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPDropDownEdit = interface(PPControl)
    ['{914934B6-5A91-11CF-8700-00AA0060263B}']
    function Get_Strings: PPStrings; safecall;
    function Get_FocusItem: SYSINT; safecall;
    procedure Set_FocusItem(FocusItem: SYSINT); safecall;
    function Get_OnSelectionChange: WideString; safecall;
    procedure Set_OnSelectionChange(const OnSelectionChange: WideString); safecall;
    function Get_OnEdit: WideString; safecall;
    procedure Set_OnEdit(const OnEdit: WideString); safecall;
    property Strings: PPStrings read Get_Strings;
    property FocusItem: SYSINT read Get_FocusItem write Set_FocusItem;
    property OnSelectionChange: WideString read Get_OnSelectionChange write Set_OnSelectionChange;
    property OnEdit: WideString read Get_OnEdit write Set_OnEdit;
  end;

// *********************************************************************//
// DispIntf:  PPDropDownEditDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B6-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPDropDownEditDisp = dispinterface
    ['{914934B6-5A91-11CF-8700-00AA0060263B}']
    property Strings: PPStrings readonly dispid 2001;
    property FocusItem: SYSINT dispid 2002;
    property OnSelectionChange: WideString dispid 2003;
    property OnEdit: WideString dispid 2004;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPSlideMiniature
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B7-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPSlideMiniature = interface(PPControl)
    ['{914934B7-5A91-11CF-8700-00AA0060263B}']
    procedure SetImage(const Slide: PowerPointSlide); safecall;
    function Get_Selected: SYSINT; safecall;
    procedure Set_Selected(Selected: SYSINT); safecall;
    function Get_OnClick: WideString; safecall;
    procedure Set_OnClick(const OnClick: WideString); safecall;
    function Get_OnDoubleClick: WideString; safecall;
    procedure Set_OnDoubleClick(const OnDoubleClick: WideString); safecall;
    property Selected: SYSINT read Get_Selected write Set_Selected;
    property OnClick: WideString read Get_OnClick write Set_OnClick;
    property OnDoubleClick: WideString read Get_OnDoubleClick write Set_OnDoubleClick;
  end;

// *********************************************************************//
// DispIntf:  PPSlideMiniatureDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B7-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPSlideMiniatureDisp = dispinterface
    ['{914934B7-5A91-11CF-8700-00AA0060263B}']
    procedure SetImage(const Slide: PowerPointSlide); dispid 2001;
    property Selected: SYSINT dispid 2002;
    property OnClick: WideString dispid 2003;
    property OnDoubleClick: WideString dispid 2004;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: PPRadioButton
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B8-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPRadioButton = interface(PPControl)
    ['{914934B8-5A91-11CF-8700-00AA0060263B}']
    function Get_State: MsoTriState; safecall;
    procedure Set_State(State: MsoTriState); safecall;
    procedure Click; safecall;
    procedure DoubleClick; safecall;
    function Get_OnClick: WideString; safecall;
    procedure Set_OnClick(const OnClick: WideString); safecall;
    function Get_OnDoubleClick: WideString; safecall;
    procedure Set_OnDoubleClick(const OnDoubleClick: WideString); safecall;
    property State: MsoTriState read Get_State write Set_State;
    property OnClick: WideString read Get_OnClick write Set_OnClick;
    property OnDoubleClick: WideString read Get_OnDoubleClick write Set_OnDoubleClick;
  end;

// *********************************************************************//
// DispIntf:  PPRadioButtonDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B8-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PPRadioButtonDisp = dispinterface
    ['{914934B8-5A91-11CF-8700-00AA0060263B}']
    property State: MsoTriState dispid 2001;
    procedure Click; dispid 2002;
    procedure DoubleClick; dispid 2003;
    property OnClick: WideString dispid 2004;
    property OnDoubleClick: WideString dispid 2005;
    property Application: PowerPointApplication readonly dispid 1001;
    property Parent: IDispatch readonly dispid 1002;
    property Enable: MsoTriState dispid 1003;
    property Visible: MsoTriState dispid 1004;
    property Focus: MsoTriState dispid 1005;
    property Label_: WideString dispid 1006;
    property HelpId: SYSINT dispid 1007;
    property Left: Single dispid 1008;
    property Top: Single dispid 1009;
    property Width: Single dispid 1010;
    property Height: Single dispid 1011;
    property HWND: Integer readonly dispid 1012;
    property OnSetFocus: WideString dispid 1013;
    property OnKillFocus: WideString dispid 1014;
    property Tags: Tags readonly dispid 1015;
    property Name: WideString dispid 1016;
  end;

// *********************************************************************//
// Interface: Tags
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B9-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Tags = interface(Collection)
    ['{914934B9-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(const Name: WideString): WideString; safecall;
    procedure Add(const Name: WideString; const Value: WideString); safecall;
    procedure Delete(const Name: WideString); safecall;
    procedure AddBinary(const Name: WideString; const FilePath: WideString); safecall;
    function BinaryValue(const Name: WideString): Integer; safecall;
    function Name(index: SYSINT): WideString; safecall;
    function Value(index: SYSINT): WideString; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  TagsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934B9-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TagsDisp = dispinterface
    ['{914934B9-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(const Name: WideString): WideString; dispid 0;
    procedure Add(const Name: WideString; const Value: WideString); dispid 2003;
    procedure Delete(const Name: WideString); dispid 2004;
    procedure AddBinary(const Name: WideString; const FilePath: WideString); dispid 2005;
    function BinaryValue(const Name: WideString): Integer; dispid 2006;
    function Name(index: SYSINT): WideString; dispid 2007;
    function Value(index: SYSINT): WideString; dispid 2008;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: FileDialogFileList
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934BA-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FileDialogFileList = interface(Collection)
    ['{914934BA-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): WideString; safecall;
    function DisplayName(index: SYSINT): WideString; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  FileDialogFileListDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934BA-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FileDialogFileListDisp = dispinterface
    ['{914934BA-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): WideString; dispid 0;
    function DisplayName(index: SYSINT): WideString; dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: FileDialogExtension
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934BB-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FileDialogExtension = interface(IDispatch)
    ['{914934BB-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Extensions: WideString; safecall;
    procedure Set_Extensions(const Extensions: WideString); safecall;
    function Get_Description: WideString; safecall;
    procedure Set_Description(const Description: WideString); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Extensions: WideString read Get_Extensions write Set_Extensions;
    property Description: WideString read Get_Description write Set_Description;
  end;

// *********************************************************************//
// DispIntf:  FileDialogExtensionDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934BB-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FileDialogExtensionDisp = dispinterface
    ['{914934BB-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Extensions: WideString dispid 2003;
    property Description: WideString dispid 2004;
  end;

// *********************************************************************//
// Interface: FileDialogExtensionList
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934BC-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FileDialogExtensionList = interface(Collection)
    ['{914934BC-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): FileDialogExtension; safecall;
    function Add(const Extension: WideString; const Description: WideString): FileDialogExtension; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  FileDialogExtensionListDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934BC-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FileDialogExtensionListDisp = dispinterface
    ['{914934BC-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): FileDialogExtension; dispid 0;
    function Add(const Extension: WideString; const Description: WideString): FileDialogExtension; dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: FileDialog
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934BD-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FileDialog = interface(IDispatch)
    ['{914934BD-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Extensions: FileDialogExtensionList; safecall;
    function Get_DefaultDirectoryRegKey: WideString; safecall;
    procedure Set_DefaultDirectoryRegKey(const DefaultDirectoryRegKey: WideString); safecall;
    function Get_DialogTitle: WideString; safecall;
    procedure Set_DialogTitle(const DialogTitle: WideString); safecall;
    function Get_ActionButtonName: WideString; safecall;
    procedure Set_ActionButtonName(const ActionButtonName: WideString); safecall;
    function Get_IsMultiSelect: MsoTriState; safecall;
    procedure Set_IsMultiSelect(IsMultiSelect: MsoTriState); safecall;
    function Get_IsPrintEnabled: MsoTriState; safecall;
    procedure Set_IsPrintEnabled(IsPrintEnabled: MsoTriState); safecall;
    function Get_IsReadOnlyEnabled: MsoTriState; safecall;
    procedure Set_IsReadOnlyEnabled(IsReadOnlyEnabled: MsoTriState); safecall;
    function Get_DirectoriesOnly: MsoTriState; safecall;
    procedure Set_DirectoriesOnly(DirectoriesOnly: MsoTriState); safecall;
    function Get_InitialView: PpFileDialogView; safecall;
    procedure Set_InitialView(InitialView: PpFileDialogView); safecall;
    procedure Launch(const pUnk: IUnknown); safecall;
    function Get_OnAction: WideString; safecall;
    procedure Set_OnAction(const OnAction: WideString); safecall;
    function Get_Files: FileDialogFileList; safecall;
    function Get_UseODMADlgs: MsoTriState; safecall;
    procedure Set_UseODMADlgs(UseODMADlgs: MsoTriState); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Extensions: FileDialogExtensionList read Get_Extensions;
    property DefaultDirectoryRegKey: WideString read Get_DefaultDirectoryRegKey write Set_DefaultDirectoryRegKey;
    property DialogTitle: WideString read Get_DialogTitle write Set_DialogTitle;
    property ActionButtonName: WideString read Get_ActionButtonName write Set_ActionButtonName;
    property IsMultiSelect: MsoTriState read Get_IsMultiSelect write Set_IsMultiSelect;
    property IsPrintEnabled: MsoTriState read Get_IsPrintEnabled write Set_IsPrintEnabled;
    property IsReadOnlyEnabled: MsoTriState read Get_IsReadOnlyEnabled write Set_IsReadOnlyEnabled;
    property DirectoriesOnly: MsoTriState read Get_DirectoriesOnly write Set_DirectoriesOnly;
    property InitialView: PpFileDialogView read Get_InitialView write Set_InitialView;
    property OnAction: WideString read Get_OnAction write Set_OnAction;
    property Files: FileDialogFileList read Get_Files;
    property UseODMADlgs: MsoTriState read Get_UseODMADlgs write Set_UseODMADlgs;
  end;

// *********************************************************************//
// DispIntf:  FileDialogDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934BD-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  FileDialogDisp = dispinterface
    ['{914934BD-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Extensions: FileDialogExtensionList readonly dispid 2003;
    property DefaultDirectoryRegKey: WideString dispid 2004;
    property DialogTitle: WideString dispid 2005;
    property ActionButtonName: WideString dispid 2006;
    property IsMultiSelect: MsoTriState dispid 2007;
    property IsPrintEnabled: MsoTriState dispid 2008;
    property IsReadOnlyEnabled: MsoTriState dispid 2009;
    property DirectoriesOnly: MsoTriState dispid 2010;
    property InitialView: PpFileDialogView dispid 2011;
    procedure Launch(const pUnk: IUnknown); dispid 2012;
    property OnAction: WideString dispid 2013;
    property Files: FileDialogFileList readonly dispid 2014;
    property UseODMADlgs: MsoTriState dispid 2015;
  end;

// *********************************************************************//
// Interface: MouseTracker
// Flags:     (16) Hidden
// GUID:      {914934BE-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  MouseTracker = interface(IUnknown)
    ['{914934BE-5A91-11CF-8700-00AA0060263B}']
    function OnTrack(X: Single; Y: Single): HResult; stdcall;
    function EndTrack(X: Single; Y: Single): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: MouseDownHandler
// Flags:     (16) Hidden
// GUID:      {914934BF-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  MouseDownHandler = interface(IUnknown)
    ['{914934BF-5A91-11CF-8700-00AA0060263B}']
    function OnMouseDown(const activeWin: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: OCXExtender
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C0-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  OCXExtender = interface(IDispatch)
    ['{914934C0-5A91-11CF-8700-00AA0060263B}']
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(Visible: WordBool); safecall;
    function Get_Left: Single; safecall;
    procedure Set_Left(Left: Single); safecall;
    function Get_Top: Single; safecall;
    procedure Set_Top(Top: Single); safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(Height: Single); safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(Width: Single); safecall;
    function Get_ZOrderPosition: SYSINT; safecall;
    function Get_Name: WideString; safecall;
    procedure Set_Name(const Name: WideString); safecall;
    function Get_AltHTML: WideString; safecall;
    procedure Set_AltHTML(const AltHTML: WideString); safecall;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Height: Single read Get_Height write Set_Height;
    property Width: Single read Get_Width write Set_Width;
    property ZOrderPosition: SYSINT read Get_ZOrderPosition;
    property Name: WideString read Get_Name write Set_Name;
    property AltHTML: WideString read Get_AltHTML write Set_AltHTML;
  end;

// *********************************************************************//
// DispIntf:  OCXExtenderDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C0-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  OCXExtenderDisp = dispinterface
    ['{914934C0-5A91-11CF-8700-00AA0060263B}']
    property Visible: WordBool dispid -2147418105;
    property Left: Single dispid -2147418109;
    property Top: Single dispid -2147418108;
    property Height: Single dispid -2147418107;
    property Width: Single dispid -2147418106;
    property ZOrderPosition: SYSINT readonly dispid -2147417882;
    property Name: WideString dispid -2147418112;
    property AltHTML: WideString dispid -2147417881;
  end;

// *********************************************************************//
// Interface: OCXExtenderEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {914934C1-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  OCXExtenderEvents = interface(IDispatch)
    ['{914934C1-5A91-11CF-8700-00AA0060263B}']
    function GotFocus: HResult; stdcall;
    function LostFocus: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: Table
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C3-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Table = interface(IDispatch)
    ['{914934C3-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Columns: Columns; safecall;
    function Get_Rows: Rows; safecall;
    function Cell(Row: SYSINT; Column: SYSINT): Cell; safecall;
    function Get_TableDirection: PpDirection; safecall;
    procedure Set_TableDirection(TableDirection: PpDirection); safecall;
    procedure MergeBorders; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Columns: Columns read Get_Columns;
    property Rows: Rows read Get_Rows;
    property TableDirection: PpDirection read Get_TableDirection write Set_TableDirection;
  end;

// *********************************************************************//
// DispIntf:  TableDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C3-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  TableDisp = dispinterface
    ['{914934C3-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Columns: Columns readonly dispid 2003;
    property Rows: Rows readonly dispid 2004;
    function Cell(Row: SYSINT; Column: SYSINT): Cell; dispid 2005;
    property TableDirection: PpDirection dispid 2006;
    procedure MergeBorders; dispid 2007;
  end;

// *********************************************************************//
// Interface: Columns
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C4-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Columns = interface(Collection)
    ['{914934C4-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): Column; safecall;
    function Add(BeforeColumn: SYSINT): Column; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  ColumnsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C4-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ColumnsDisp = dispinterface
    ['{914934C4-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): Column; dispid 0;
    function Add(BeforeColumn: SYSINT): Column; dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: Column
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C5-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Column = interface(IDispatch)
    ['{914934C5-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Cells: CellRange; safecall;
    procedure Select; safecall;
    procedure Delete; safecall;
    function Get_Width: Single; safecall;
    procedure Set_Width(Width: Single); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Cells: CellRange read Get_Cells;
    property Width: Single read Get_Width write Set_Width;
  end;

// *********************************************************************//
// DispIntf:  ColumnDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C5-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  ColumnDisp = dispinterface
    ['{914934C5-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Cells: CellRange readonly dispid 2003;
    procedure Select; dispid 2004;
    procedure Delete; dispid 2005;
    property Width: Single dispid 2006;
  end;

// *********************************************************************//
// Interface: Rows
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C6-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Rows = interface(Collection)
    ['{914934C6-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): Row; safecall;
    function Add(BeforeRow: SYSINT): Row; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  RowsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C6-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  RowsDisp = dispinterface
    ['{914934C6-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): Row; dispid 0;
    function Add(BeforeRow: SYSINT): Row; dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: Row
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C7-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Row = interface(IDispatch)
    ['{914934C7-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Cells: CellRange; safecall;
    procedure Select; safecall;
    procedure Delete; safecall;
    function Get_Height: Single; safecall;
    procedure Set_Height(Height: Single); safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Cells: CellRange read Get_Cells;
    property Height: Single read Get_Height write Set_Height;
  end;

// *********************************************************************//
// DispIntf:  RowDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C7-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  RowDisp = dispinterface
    ['{914934C7-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Cells: CellRange readonly dispid 2003;
    procedure Select; dispid 2004;
    procedure Delete; dispid 2005;
    property Height: Single dispid 2006;
  end;

// *********************************************************************//
// Interface: CellRange
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C8-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  CellRange = interface(Collection)
    ['{914934C8-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): Cell; safecall;
    function Get_Borders: Borders; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Borders: Borders read Get_Borders;
  end;

// *********************************************************************//
// DispIntf:  CellRangeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C8-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  CellRangeDisp = dispinterface
    ['{914934C8-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): Cell; dispid 0;
    property Borders: Borders readonly dispid 2003;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: Cell
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C9-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Cell = interface(IDispatch)
    ['{914934C9-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Shape: Shape; safecall;
    function Get_Borders: Borders; safecall;
    procedure Merge(const MergeTo: Cell); safecall;
    procedure Split(NumRows: SYSINT; NumColumns: SYSINT); safecall;
    procedure Select; safecall;
    function Get_Selected: WordBool; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Shape: Shape read Get_Shape;
    property Borders: Borders read Get_Borders;
    property Selected: WordBool read Get_Selected;
  end;

// *********************************************************************//
// DispIntf:  CellDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934C9-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  CellDisp = dispinterface
    ['{914934C9-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property Shape: Shape readonly dispid 2003;
    property Borders: Borders readonly dispid 2004;
    procedure Merge(const MergeTo: Cell); dispid 2005;
    procedure Split(NumRows: SYSINT; NumColumns: SYSINT); dispid 2006;
    procedure Select; dispid 2007;
    property Selected: WordBool readonly dispid 2008;
  end;

// *********************************************************************//
// Interface: Borders
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CA-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Borders = interface(Collection)
    ['{914934CA-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(BorderType: PpBorderType): LineFormat; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  BordersDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CA-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  BordersDisp = dispinterface
    ['{914934CA-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(BorderType: PpBorderType): LineFormat; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: Panes
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CB-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Panes = interface(Collection)
    ['{914934CB-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Item(index: SYSINT): Pane; safecall;
    function Get_Parent: IDispatch; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  PanesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CB-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PanesDisp = dispinterface
    ['{914934CB-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    function Item(index: SYSINT): Pane; dispid 0;
    property Parent: IDispatch readonly dispid 2002;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: Pane
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CC-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Pane = interface(IDispatch)
    ['{914934CC-5A91-11CF-8700-00AA0060263B}']
    function Get_Parent: IDispatch; safecall;
    procedure Activate; safecall;
    function Get_Active: MsoTriState; safecall;
    function Get_Application: PowerPointApplication; safecall;
    function Get_ViewType: PpViewType; safecall;
    property Parent: IDispatch read Get_Parent;
    property Active: MsoTriState read Get_Active;
    property Application: PowerPointApplication read Get_Application;
    property ViewType: PpViewType read Get_ViewType;
  end;

// *********************************************************************//
// DispIntf:  PaneDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CC-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PaneDisp = dispinterface
    ['{914934CC-5A91-11CF-8700-00AA0060263B}']
    property Parent: IDispatch readonly dispid 2000;
    procedure Activate; dispid 2001;
    property Active: MsoTriState readonly dispid 2002;
    property Application: PowerPointApplication readonly dispid 2003;
    property ViewType: PpViewType readonly dispid 2004;
  end;

// *********************************************************************//
// Interface: DefaultWebOptions
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CD-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  DefaultWebOptions = interface(IDispatch)
    ['{914934CD-5A91-11CF-8700-00AA0060263B}']
    function Get_IncludeNavigation: MsoTriState; safecall;
    procedure Set_IncludeNavigation(IncludeNavigation: MsoTriState); safecall;
    function Get_FrameColors: PpFrameColors; safecall;
    procedure Set_FrameColors(FrameColors: PpFrameColors); safecall;
    function Get_ResizeGraphics: MsoTriState; safecall;
    procedure Set_ResizeGraphics(ResizeGraphics: MsoTriState); safecall;
    function Get_ShowSlideAnimation: MsoTriState; safecall;
    procedure Set_ShowSlideAnimation(ShowSlideAnimation: MsoTriState); safecall;
    function Get_OrganizeInFolder: MsoTriState; safecall;
    procedure Set_OrganizeInFolder(OrganizeInFolder: MsoTriState); safecall;
    function Get_UseLongFileNames: MsoTriState; safecall;
    procedure Set_UseLongFileNames(UseLongFileNames: MsoTriState); safecall;
    function Get_RelyOnVML: MsoTriState; safecall;
    procedure Set_RelyOnVML(RelyOnVML: MsoTriState); safecall;
    function Get_AllowPNG: MsoTriState; safecall;
    procedure Set_AllowPNG(AllowPNG: MsoTriState); safecall;
    function Get_ScreenSize: MsoScreenSize; safecall;
    procedure Set_ScreenSize(ScreenSize: MsoScreenSize); safecall;
    function Get_Encoding: MsoEncoding; safecall;
    procedure Set_Encoding(Encoding: MsoEncoding); safecall;
    function Get_UpdateLinksOnSave: MsoTriState; safecall;
    procedure Set_UpdateLinksOnSave(UpdateLinksOnSave: MsoTriState); safecall;
    function Get_CheckIfOfficeIsHTMLEditor: MsoTriState; safecall;
    procedure Set_CheckIfOfficeIsHTMLEditor(CheckIfOfficeIsHTMLEditor: MsoTriState); safecall;
    function Get_AlwaysSaveInDefaultEncoding: MsoTriState; safecall;
    procedure Set_AlwaysSaveInDefaultEncoding(AlwaysSaveInDefaultEncoding: MsoTriState); safecall;
    function Get_Fonts: WebPageFonts; safecall;
    function Get_FolderSuffix: WideString; safecall;
    property IncludeNavigation: MsoTriState read Get_IncludeNavigation write Set_IncludeNavigation;
    property FrameColors: PpFrameColors read Get_FrameColors write Set_FrameColors;
    property ResizeGraphics: MsoTriState read Get_ResizeGraphics write Set_ResizeGraphics;
    property ShowSlideAnimation: MsoTriState read Get_ShowSlideAnimation write Set_ShowSlideAnimation;
    property OrganizeInFolder: MsoTriState read Get_OrganizeInFolder write Set_OrganizeInFolder;
    property UseLongFileNames: MsoTriState read Get_UseLongFileNames write Set_UseLongFileNames;
    property RelyOnVML: MsoTriState read Get_RelyOnVML write Set_RelyOnVML;
    property AllowPNG: MsoTriState read Get_AllowPNG write Set_AllowPNG;
    property ScreenSize: MsoScreenSize read Get_ScreenSize write Set_ScreenSize;
    property Encoding: MsoEncoding read Get_Encoding write Set_Encoding;
    property UpdateLinksOnSave: MsoTriState read Get_UpdateLinksOnSave write Set_UpdateLinksOnSave;
    property CheckIfOfficeIsHTMLEditor: MsoTriState read Get_CheckIfOfficeIsHTMLEditor write Set_CheckIfOfficeIsHTMLEditor;
    property AlwaysSaveInDefaultEncoding: MsoTriState read Get_AlwaysSaveInDefaultEncoding write Set_AlwaysSaveInDefaultEncoding;
    property Fonts: WebPageFonts read Get_Fonts;
    property FolderSuffix: WideString read Get_FolderSuffix;
  end;

// *********************************************************************//
// DispIntf:  DefaultWebOptionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CD-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  DefaultWebOptionsDisp = dispinterface
    ['{914934CD-5A91-11CF-8700-00AA0060263B}']
    property IncludeNavigation: MsoTriState dispid 2001;
    property FrameColors: PpFrameColors dispid 2002;
    property ResizeGraphics: MsoTriState dispid 2003;
    property ShowSlideAnimation: MsoTriState dispid 2004;
    property OrganizeInFolder: MsoTriState dispid 2005;
    property UseLongFileNames: MsoTriState dispid 2006;
    property RelyOnVML: MsoTriState dispid 2007;
    property AllowPNG: MsoTriState dispid 2008;
    property ScreenSize: MsoScreenSize dispid 2009;
    property Encoding: MsoEncoding dispid 2010;
    property UpdateLinksOnSave: MsoTriState dispid 2011;
    property CheckIfOfficeIsHTMLEditor: MsoTriState dispid 2012;
    property AlwaysSaveInDefaultEncoding: MsoTriState dispid 2013;
    property Fonts: WebPageFonts readonly dispid 2014;
    property FolderSuffix: WideString readonly dispid 2015;
  end;

// *********************************************************************//
// Interface: WebOptions
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CE-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  WebOptions = interface(IDispatch)
    ['{914934CE-5A91-11CF-8700-00AA0060263B}']
    function Get_IncludeNavigation: MsoTriState; safecall;
    procedure Set_IncludeNavigation(IncludeNavigation: MsoTriState); safecall;
    function Get_FrameColors: PpFrameColors; safecall;
    procedure Set_FrameColors(FrameColors: PpFrameColors); safecall;
    function Get_ResizeGraphics: MsoTriState; safecall;
    procedure Set_ResizeGraphics(ResizeGraphics: MsoTriState); safecall;
    function Get_ShowSlideAnimation: MsoTriState; safecall;
    procedure Set_ShowSlideAnimation(ShowSlideAnimation: MsoTriState); safecall;
    function Get_OrganizeInFolder: MsoTriState; safecall;
    procedure Set_OrganizeInFolder(OrganizeInFolder: MsoTriState); safecall;
    function Get_UseLongFileNames: MsoTriState; safecall;
    procedure Set_UseLongFileNames(UseLongFileNames: MsoTriState); safecall;
    function Get_RelyOnVML: MsoTriState; safecall;
    procedure Set_RelyOnVML(RelyOnVML: MsoTriState); safecall;
    function Get_AllowPNG: MsoTriState; safecall;
    procedure Set_AllowPNG(AllowPNG: MsoTriState); safecall;
    function Get_ScreenSize: MsoScreenSize; safecall;
    procedure Set_ScreenSize(ScreenSize: MsoScreenSize); safecall;
    function Get_Encoding: MsoEncoding; safecall;
    procedure Set_Encoding(Encoding: MsoEncoding); safecall;
    function Get_FolderSuffix: WideString; safecall;
    procedure UseDefaultFolderSuffix; safecall;
    property IncludeNavigation: MsoTriState read Get_IncludeNavigation write Set_IncludeNavigation;
    property FrameColors: PpFrameColors read Get_FrameColors write Set_FrameColors;
    property ResizeGraphics: MsoTriState read Get_ResizeGraphics write Set_ResizeGraphics;
    property ShowSlideAnimation: MsoTriState read Get_ShowSlideAnimation write Set_ShowSlideAnimation;
    property OrganizeInFolder: MsoTriState read Get_OrganizeInFolder write Set_OrganizeInFolder;
    property UseLongFileNames: MsoTriState read Get_UseLongFileNames write Set_UseLongFileNames;
    property RelyOnVML: MsoTriState read Get_RelyOnVML write Set_RelyOnVML;
    property AllowPNG: MsoTriState read Get_AllowPNG write Set_AllowPNG;
    property ScreenSize: MsoScreenSize read Get_ScreenSize write Set_ScreenSize;
    property Encoding: MsoEncoding read Get_Encoding write Set_Encoding;
    property FolderSuffix: WideString read Get_FolderSuffix;
  end;

// *********************************************************************//
// DispIntf:  WebOptionsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CE-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  WebOptionsDisp = dispinterface
    ['{914934CE-5A91-11CF-8700-00AA0060263B}']
    property IncludeNavigation: MsoTriState dispid 2001;
    property FrameColors: PpFrameColors dispid 2002;
    property ResizeGraphics: MsoTriState dispid 2003;
    property ShowSlideAnimation: MsoTriState dispid 2004;
    property OrganizeInFolder: MsoTriState dispid 2005;
    property UseLongFileNames: MsoTriState dispid 2006;
    property RelyOnVML: MsoTriState dispid 2007;
    property AllowPNG: MsoTriState dispid 2008;
    property ScreenSize: MsoScreenSize dispid 2009;
    property Encoding: MsoEncoding dispid 2010;
    property FolderSuffix: WideString readonly dispid 2011;
    procedure UseDefaultFolderSuffix; dispid 2012;
  end;

// *********************************************************************//
// Interface: PublishObjects
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CF-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PublishObjects = interface(Collection)
    ['{914934CF-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Item(index: SYSINT): PublishObject; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
  end;

// *********************************************************************//
// DispIntf:  PublishObjectsDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934CF-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PublishObjectsDisp = dispinterface
    ['{914934CF-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    function Item(index: SYSINT): PublishObject; dispid 0;
    property _NewEnum: IUnknown readonly dispid -4;
    function _Index(index: SYSINT): OleVariant; dispid 10;
    property Count: Integer readonly dispid 11;
  end;

// *********************************************************************//
// Interface: PublishObject
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934D0-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PublishObject = interface(IDispatch)
    ['{914934D0-5A91-11CF-8700-00AA0060263B}']
    function Get_Application: PowerPointApplication; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_HTMLVersion: PpHTMLVersion; safecall;
    procedure Set_HTMLVersion(HTMLVersion: PpHTMLVersion); safecall;
    function Get_SourceType: PpPublishSourceType; safecall;
    procedure Set_SourceType(SourceType: PpPublishSourceType); safecall;
    function Get_RangeStart: SYSINT; safecall;
    procedure Set_RangeStart(RangeStart: SYSINT); safecall;
    function Get_RangeEnd: SYSINT; safecall;
    procedure Set_RangeEnd(RangeEnd: SYSINT); safecall;
    function Get_SlideShowName: WideString; safecall;
    procedure Set_SlideShowName(const SlideShowName: WideString); safecall;
    function Get_SpeakerNotes: MsoTriState; safecall;
    procedure Set_SpeakerNotes(SpeakerNotes: MsoTriState); safecall;
    function Get_FileName: WideString; safecall;
    procedure Set_FileName(const FileName: WideString); safecall;
    procedure Publish; safecall;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property HTMLVersion: PpHTMLVersion read Get_HTMLVersion write Set_HTMLVersion;
    property SourceType: PpPublishSourceType read Get_SourceType write Set_SourceType;
    property RangeStart: SYSINT read Get_RangeStart write Set_RangeStart;
    property RangeEnd: SYSINT read Get_RangeEnd write Set_RangeEnd;
    property SlideShowName: WideString read Get_SlideShowName write Set_SlideShowName;
    property SpeakerNotes: MsoTriState read Get_SpeakerNotes write Set_SpeakerNotes;
    property FileName: WideString read Get_FileName write Set_FileName;
  end;

// *********************************************************************//
// DispIntf:  PublishObjectDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934D0-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  PublishObjectDisp = dispinterface
    ['{914934D0-5A91-11CF-8700-00AA0060263B}']
    property Application: PowerPointApplication readonly dispid 2001;
    property Parent: IDispatch readonly dispid 2002;
    property HTMLVersion: PpHTMLVersion dispid 2003;
    property SourceType: PpPublishSourceType dispid 2004;
    property RangeStart: SYSINT dispid 2005;
    property RangeEnd: SYSINT dispid 2006;
    property SlideShowName: WideString dispid 2007;
    property SpeakerNotes: MsoTriState dispid 2008;
    property FileName: WideString dispid 2009;
    procedure Publish; dispid 2010;
  end;

// *********************************************************************//
// Interface: Marker
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934D1-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  Marker = interface(IDispatch)
    ['{914934D1-5A91-11CF-8700-00AA0060263B}']
    function Get_MarkerType: PpMarkerType; safecall;
    procedure Set_MarkerType(MarkerType: PpMarkerType); safecall;
    function Get_Time: SYSINT; safecall;
    property MarkerType: PpMarkerType read Get_MarkerType write Set_MarkerType;
    property Time: SYSINT read Get_Time;
  end;

// *********************************************************************//
// DispIntf:  MarkerDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {914934D1-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  MarkerDisp = dispinterface
    ['{914934D1-5A91-11CF-8700-00AA0060263B}']
    property MarkerType: PpMarkerType dispid 2001;
    property Time: SYSINT readonly dispid 2002;
  end;

// *********************************************************************//
// Interface: MasterEvents
// Flags:     (16) Hidden
// GUID:      {914934D2-5A91-11CF-8700-00AA0060263B}
// *********************************************************************//
  MasterEvents = interface(IUnknown)
    ['{914934D2-5A91-11CF-8700-00AA0060263B}']
  end;

// *********************************************************************//
// The Class CoPowerPointGlobal provides a Create and CreateRemote method to          
// create instances of the default interface _Global exposed by              
// the CoClass PowerPointGlobal. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPowerPointGlobal = class
    class function Create: _Global;
    class function CreateRemote(const MachineName: string): _Global;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPowerPointGlobal
// Help String      : 
// Default Interface: _Global
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (27) AppObject CanCreate Predeclid Hidden
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPowerPointGlobalProperties= class;
{$ENDIF}
  TPowerPointGlobal = class(TOleServer)
  private
    FIntf:        _Global;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPowerPointGlobalProperties;
    function      GetServerProperties: TPowerPointGlobalProperties;
{$ENDIF}
    function      GetDefaultInterface: _Global;
  protected
    procedure InitServerData; override;
    function Get_ActivePresentation: PowerPointPresentation;
    function Get_ActiveWindow: DocumentWindow;
    function Get_AddIns: AddIns;
    function Get_Application: PowerPointApplication;
    function Get_Assistant: Assistant;
    function Get_Dialogs: PPDialogs;
    function Get_Presentations: Presentations;
    function Get_SlideShowWindows: SlideShowWindows;
    function Get_Windows: DocumentWindows;
    function Get_CommandBars: CommandBars;
    function Get_AnswerWizard: AnswerWizard;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Global);
    procedure Disconnect; override;
    property DefaultInterface: _Global read GetDefaultInterface;
    property ActivePresentation: PowerPointPresentation read Get_ActivePresentation;
    property ActiveWindow: DocumentWindow read Get_ActiveWindow;
    property AddIns: AddIns read Get_AddIns;
    property Application: PowerPointApplication read Get_Application;
    property Assistant: Assistant read Get_Assistant;
    property Dialogs: PPDialogs read Get_Dialogs;
    property Presentations: Presentations read Get_Presentations;
    property SlideShowWindows: SlideShowWindows read Get_SlideShowWindows;
    property Windows: DocumentWindows read Get_Windows;
    property CommandBars: CommandBars read Get_CommandBars;
    property AnswerWizard: AnswerWizard read Get_AnswerWizard;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPowerPointGlobalProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPowerPointGlobal
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPowerPointGlobalProperties = class(TPersistent)
  private
    FServer:    TPowerPointGlobal;
    function    GetDefaultInterface: _Global;
    constructor Create(AServer: TPowerPointGlobal);
  protected
    function Get_ActivePresentation: PowerPointPresentation;
    function Get_ActiveWindow: DocumentWindow;
    function Get_AddIns: AddIns;
    function Get_Application: PowerPointApplication;
    function Get_Assistant: Assistant;
    function Get_Dialogs: PPDialogs;
    function Get_Presentations: Presentations;
    function Get_SlideShowWindows: SlideShowWindows;
    function Get_Windows: DocumentWindows;
    function Get_CommandBars: CommandBars;
    function Get_AnswerWizard: AnswerWizard;
  public
    property DefaultInterface: _Global read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPowerPointSlide provides a Create and CreateRemote method to          
// create instances of the default interface _Slide exposed by              
// the CoClass PowerPointSlide. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPowerPointSlide = class
    class function Create: _Slide;
    class function CreateRemote(const MachineName: string): _Slide;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPowerPointSlide
// Help String      : 
// Default Interface: _Slide
// Def. Intf. DISP? : No
// Event   Interface: SldEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPowerPointSlideProperties= class;
{$ENDIF}
  TPowerPointSlide = class(TOleServer)
  private
    FIntf:        _Slide;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPowerPointSlideProperties;
    function      GetServerProperties: TPowerPointSlideProperties;
{$ENDIF}
    function      GetDefaultInterface: _Slide;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Application: PowerPointApplication;
    function Get_Parent: IDispatch;
    function Get_Shapes: Shapes;
    function Get_HeadersFooters: HeadersFooters;
    function Get_SlideShowTransition: SlideShowTransition;
    function Get_ColorScheme: ColorScheme;
    procedure Set_ColorScheme(const ColorScheme: ColorScheme);
    function Get_Background: ShapeRange;
    function Get_Name: WideString;
    procedure Set_Name(const Name: WideString);
    function Get_SlideID: Integer;
    function Get_PrintSteps: SYSINT;
    function Get_Layout: PpSlideLayout;
    procedure Set_Layout(Layout: PpSlideLayout);
    function Get_Tags: Tags;
    function Get_SlideIndex: SYSINT;
    function Get_SlideNumber: SYSINT;
    function Get_DisplayMasterShapes: MsoTriState;
    procedure Set_DisplayMasterShapes(DisplayMasterShapes: MsoTriState);
    function Get_FollowMasterBackground: MsoTriState;
    procedure Set_FollowMasterBackground(FollowMasterBackground: MsoTriState);
    function Get_NotesPage: SlideRange;
    function Get_Master: _Master;
    function Get_Hyperlinks: Hyperlinks;
    function Get_Scripts: Scripts;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Slide);
    procedure Disconnect; override;
    procedure Select;
    procedure Cut;
    procedure Copy;
    function Duplicate: SlideRange;
    procedure Delete;
    procedure Export(const FileName: WideString; const FilterName: WideString; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT);
    property DefaultInterface: _Slide read GetDefaultInterface;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Shapes: Shapes read Get_Shapes;
    property HeadersFooters: HeadersFooters read Get_HeadersFooters;
    property SlideShowTransition: SlideShowTransition read Get_SlideShowTransition;
    property Background: ShapeRange read Get_Background;
    property SlideID: Integer read Get_SlideID;
    property PrintSteps: SYSINT read Get_PrintSteps;
    property Tags: Tags read Get_Tags;
    property SlideIndex: SYSINT read Get_SlideIndex;
    property SlideNumber: SYSINT read Get_SlideNumber;
    property NotesPage: SlideRange read Get_NotesPage;
    property Master: _Master read Get_Master;
    property Hyperlinks: Hyperlinks read Get_Hyperlinks;
    property Scripts: Scripts read Get_Scripts;
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property Name: WideString read Get_Name write Set_Name;
    property Layout: PpSlideLayout read Get_Layout write Set_Layout;
    property DisplayMasterShapes: MsoTriState read Get_DisplayMasterShapes write Set_DisplayMasterShapes;
    property FollowMasterBackground: MsoTriState read Get_FollowMasterBackground write Set_FollowMasterBackground;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPowerPointSlideProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPowerPointSlide
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPowerPointSlideProperties = class(TPersistent)
  private
    FServer:    TPowerPointSlide;
    function    GetDefaultInterface: _Slide;
    constructor Create(AServer: TPowerPointSlide);
  protected
    function Get_Application: PowerPointApplication;
    function Get_Parent: IDispatch;
    function Get_Shapes: Shapes;
    function Get_HeadersFooters: HeadersFooters;
    function Get_SlideShowTransition: SlideShowTransition;
    function Get_ColorScheme: ColorScheme;
    procedure Set_ColorScheme(const ColorScheme: ColorScheme);
    function Get_Background: ShapeRange;
    function Get_Name: WideString;
    procedure Set_Name(const Name: WideString);
    function Get_SlideID: Integer;
    function Get_PrintSteps: SYSINT;
    function Get_Layout: PpSlideLayout;
    procedure Set_Layout(Layout: PpSlideLayout);
    function Get_Tags: Tags;
    function Get_SlideIndex: SYSINT;
    function Get_SlideNumber: SYSINT;
    function Get_DisplayMasterShapes: MsoTriState;
    procedure Set_DisplayMasterShapes(DisplayMasterShapes: MsoTriState);
    function Get_FollowMasterBackground: MsoTriState;
    procedure Set_FollowMasterBackground(FollowMasterBackground: MsoTriState);
    function Get_NotesPage: SlideRange;
    function Get_Master: _Master;
    function Get_Hyperlinks: Hyperlinks;
    function Get_Scripts: Scripts;
  public
    property DefaultInterface: _Slide read GetDefaultInterface;
  published
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property Name: WideString read Get_Name write Set_Name;
    property Layout: PpSlideLayout read Get_Layout write Set_Layout;
    property DisplayMasterShapes: MsoTriState read Get_DisplayMasterShapes write Set_DisplayMasterShapes;
    property FollowMasterBackground: MsoTriState read Get_FollowMasterBackground write Set_FollowMasterBackground;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPowerPointPresentation provides a Create and CreateRemote method to          
// create instances of the default interface _Presentation exposed by              
// the CoClass PowerPointPresentation. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPowerPointPresentation = class
    class function Create: _Presentation;
    class function CreateRemote(const MachineName: string): _Presentation;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPowerPointPresentation
// Help String      : 
// Default Interface: _Presentation
// Def. Intf. DISP? : No
// Event   Interface: PresEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPowerPointPresentationProperties= class;
{$ENDIF}
  TPowerPointPresentation = class(TOleServer)
  private
    FIntf:        _Presentation;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPowerPointPresentationProperties;
    function      GetServerProperties: TPowerPointPresentationProperties;
{$ENDIF}
    function      GetDefaultInterface: _Presentation;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Application: PowerPointApplication;
    function Get_Parent: IDispatch;
    function Get_SlideMaster: _Master;
    function Get_TitleMaster: _Master;
    function Get_HasTitleMaster: MsoTriState;
    function Get_TemplateName: WideString;
    function Get_NotesMaster: _Master;
    function Get_HandoutMaster: _Master;
    function Get_Slides: Slides;
    function Get_PageSetup: PageSetup;
    function Get_ColorSchemes: ColorSchemes;
    function Get_ExtraColors: ExtraColors;
    function Get_SlideShowSettings: SlideShowSettings;
    function Get_Fonts: Fonts;
    function Get_Windows: DocumentWindows;
    function Get_Tags: Tags;
    function Get_DefaultShape: Shape;
    function Get_BuiltInDocumentProperties: IDispatch;
    function Get_CustomDocumentProperties: IDispatch;
    function Get_VBProject: VBProject;
    function Get_ReadOnly: MsoTriState;
    function Get_FullName: WideString;
    function Get_Name: WideString;
    function Get_Path: WideString;
    function Get_Saved: MsoTriState;
    procedure Set_Saved(Saved: MsoTriState);
    function Get_LayoutDirection: PpDirection;
    procedure Set_LayoutDirection(LayoutDirection: PpDirection);
    function Get_PrintOptions: PrintOptions;
    function Get_Container: IDispatch;
    function Get_DisplayComments: MsoTriState;
    procedure Set_DisplayComments(DisplayComments: MsoTriState);
    function Get_FarEastLineBreakLevel: PpFarEastLineBreakLevel;
    procedure Set_FarEastLineBreakLevel(FarEastLineBreakLevel: PpFarEastLineBreakLevel);
    function Get_NoLineBreakBefore: WideString;
    procedure Set_NoLineBreakBefore(const NoLineBreakBefore: WideString);
    function Get_NoLineBreakAfter: WideString;
    procedure Set_NoLineBreakAfter(const NoLineBreakAfter: WideString);
    function Get_SlideShowWindow: SlideShowWindow;
    function Get_FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID;
    procedure Set_FarEastLineBreakLanguage(FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID);
    function Get_DefaultLanguageID: MsoLanguageID;
    procedure Set_DefaultLanguageID(DefaultLanguageID: MsoLanguageID);
    function Get_CommandBars: CommandBars;
    function Get_PublishObjects: PublishObjects;
    function Get_WebOptions: WebOptions;
    function Get_HTMLProject: HTMLProject;
    function Get_EnvelopeVisible: MsoTriState;
    procedure Set_EnvelopeVisible(EnvelopeVisible: MsoTriState);
    function Get_VBASigned: MsoTriState;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Presentation);
    procedure Disconnect; override;
    function AddTitleMaster: _Master;
    procedure ApplyTemplate(const FileName: WideString);
    function NewWindow: DocumentWindow;
    procedure FollowHyperlink(const Address: WideString; const SubAddress: WideString; 
                              NewWindow: WordBool; AddHistory: WordBool; 
                              const ExtraInfo: WideString; Method: MsoExtraInfoMethod; 
                              const HeaderInfo: WideString);
    procedure AddToFavorites;
    procedure PrintOut(From: SYSINT; To_: SYSINT; const PrintToFile: WideString; Copies: SYSINT; 
                       Collate: MsoTriState);
    procedure Save;
    procedure SaveAs(const FileName: WideString; FileFormat: PpSaveAsFileType; 
                     EmbedTrueTypeFonts: MsoTriState);
    procedure SaveCopyAs(const FileName: WideString; FileFormat: PpSaveAsFileType; 
                         EmbedTrueTypeFonts: MsoTriState);
    procedure Export(const Path: WideString; const FilterName: WideString; ScaleWidth: SYSINT; 
                     ScaleHeight: SYSINT);
    procedure Close;
    procedure SetUndoText(const Text: WideString);
    procedure UpdateLinks;
    procedure WebPagePreview;
    procedure ReloadAs(cp: MsoEncoding);
    procedure MakeIntoTemplate(IsDesignTemplate: MsoTriState);
    procedure sblt(const s: WideString);
    property DefaultInterface: _Presentation read GetDefaultInterface;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property SlideMaster: _Master read Get_SlideMaster;
    property TitleMaster: _Master read Get_TitleMaster;
    property HasTitleMaster: MsoTriState read Get_HasTitleMaster;
    property TemplateName: WideString read Get_TemplateName;
    property NotesMaster: _Master read Get_NotesMaster;
    property HandoutMaster: _Master read Get_HandoutMaster;
    property Slides: Slides read Get_Slides;
    property PageSetup: PageSetup read Get_PageSetup;
    property ColorSchemes: ColorSchemes read Get_ColorSchemes;
    property ExtraColors: ExtraColors read Get_ExtraColors;
    property SlideShowSettings: SlideShowSettings read Get_SlideShowSettings;
    property Fonts: Fonts read Get_Fonts;
    property Windows: DocumentWindows read Get_Windows;
    property Tags: Tags read Get_Tags;
    property DefaultShape: Shape read Get_DefaultShape;
    property BuiltInDocumentProperties: IDispatch read Get_BuiltInDocumentProperties;
    property CustomDocumentProperties: IDispatch read Get_CustomDocumentProperties;
    property VBProject: VBProject read Get_VBProject;
    property ReadOnly: MsoTriState read Get_ReadOnly;
    property FullName: WideString read Get_FullName;
    property Name: WideString read Get_Name;
    property Path: WideString read Get_Path;
    property PrintOptions: PrintOptions read Get_PrintOptions;
    property Container: IDispatch read Get_Container;
    property SlideShowWindow: SlideShowWindow read Get_SlideShowWindow;
    property CommandBars: CommandBars read Get_CommandBars;
    property PublishObjects: PublishObjects read Get_PublishObjects;
    property WebOptions: WebOptions read Get_WebOptions;
    property HTMLProject: HTMLProject read Get_HTMLProject;
    property VBASigned: MsoTriState read Get_VBASigned;
    property Saved: MsoTriState read Get_Saved write Set_Saved;
    property LayoutDirection: PpDirection read Get_LayoutDirection write Set_LayoutDirection;
    property DisplayComments: MsoTriState read Get_DisplayComments write Set_DisplayComments;
    property FarEastLineBreakLevel: PpFarEastLineBreakLevel read Get_FarEastLineBreakLevel write Set_FarEastLineBreakLevel;
    property NoLineBreakBefore: WideString read Get_NoLineBreakBefore write Set_NoLineBreakBefore;
    property NoLineBreakAfter: WideString read Get_NoLineBreakAfter write Set_NoLineBreakAfter;
    property FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID read Get_FarEastLineBreakLanguage write Set_FarEastLineBreakLanguage;
    property DefaultLanguageID: MsoLanguageID read Get_DefaultLanguageID write Set_DefaultLanguageID;
    property EnvelopeVisible: MsoTriState read Get_EnvelopeVisible write Set_EnvelopeVisible;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPowerPointPresentationProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPowerPointPresentation
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPowerPointPresentationProperties = class(TPersistent)
  private
    FServer:    TPowerPointPresentation;
    function    GetDefaultInterface: _Presentation;
    constructor Create(AServer: TPowerPointPresentation);
  protected
    function Get_Application: PowerPointApplication;
    function Get_Parent: IDispatch;
    function Get_SlideMaster: _Master;
    function Get_TitleMaster: _Master;
    function Get_HasTitleMaster: MsoTriState;
    function Get_TemplateName: WideString;
    function Get_NotesMaster: _Master;
    function Get_HandoutMaster: _Master;
    function Get_Slides: Slides;
    function Get_PageSetup: PageSetup;
    function Get_ColorSchemes: ColorSchemes;
    function Get_ExtraColors: ExtraColors;
    function Get_SlideShowSettings: SlideShowSettings;
    function Get_Fonts: Fonts;
    function Get_Windows: DocumentWindows;
    function Get_Tags: Tags;
    function Get_DefaultShape: Shape;
    function Get_BuiltInDocumentProperties: IDispatch;
    function Get_CustomDocumentProperties: IDispatch;
    function Get_VBProject: VBProject;
    function Get_ReadOnly: MsoTriState;
    function Get_FullName: WideString;
    function Get_Name: WideString;
    function Get_Path: WideString;
    function Get_Saved: MsoTriState;
    procedure Set_Saved(Saved: MsoTriState);
    function Get_LayoutDirection: PpDirection;
    procedure Set_LayoutDirection(LayoutDirection: PpDirection);
    function Get_PrintOptions: PrintOptions;
    function Get_Container: IDispatch;
    function Get_DisplayComments: MsoTriState;
    procedure Set_DisplayComments(DisplayComments: MsoTriState);
    function Get_FarEastLineBreakLevel: PpFarEastLineBreakLevel;
    procedure Set_FarEastLineBreakLevel(FarEastLineBreakLevel: PpFarEastLineBreakLevel);
    function Get_NoLineBreakBefore: WideString;
    procedure Set_NoLineBreakBefore(const NoLineBreakBefore: WideString);
    function Get_NoLineBreakAfter: WideString;
    procedure Set_NoLineBreakAfter(const NoLineBreakAfter: WideString);
    function Get_SlideShowWindow: SlideShowWindow;
    function Get_FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID;
    procedure Set_FarEastLineBreakLanguage(FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID);
    function Get_DefaultLanguageID: MsoLanguageID;
    procedure Set_DefaultLanguageID(DefaultLanguageID: MsoLanguageID);
    function Get_CommandBars: CommandBars;
    function Get_PublishObjects: PublishObjects;
    function Get_WebOptions: WebOptions;
    function Get_HTMLProject: HTMLProject;
    function Get_EnvelopeVisible: MsoTriState;
    procedure Set_EnvelopeVisible(EnvelopeVisible: MsoTriState);
    function Get_VBASigned: MsoTriState;
  public
    property DefaultInterface: _Presentation read GetDefaultInterface;
  published
    property Saved: MsoTriState read Get_Saved write Set_Saved;
    property LayoutDirection: PpDirection read Get_LayoutDirection write Set_LayoutDirection;
    property DisplayComments: MsoTriState read Get_DisplayComments write Set_DisplayComments;
    property FarEastLineBreakLevel: PpFarEastLineBreakLevel read Get_FarEastLineBreakLevel write Set_FarEastLineBreakLevel;
    property NoLineBreakBefore: WideString read Get_NoLineBreakBefore write Set_NoLineBreakBefore;
    property NoLineBreakAfter: WideString read Get_NoLineBreakAfter write Set_NoLineBreakAfter;
    property FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID read Get_FarEastLineBreakLanguage write Set_FarEastLineBreakLanguage;
    property DefaultLanguageID: MsoLanguageID read Get_DefaultLanguageID write Set_DefaultLanguageID;
    property EnvelopeVisible: MsoTriState read Get_EnvelopeVisible write Set_EnvelopeVisible;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoOLECtrl provides a Create and CreateRemote method to          
// create instances of the default interface OCXExtender exposed by              
// the CoClass OLECtrl. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoOLECtrl = class
    class function Create: OCXExtender;
    class function CreateRemote(const MachineName: string): OCXExtender;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TOLECtrl
// Help String      : 
// Default Interface: OCXExtender
// Def. Intf. DISP? : No
// Event   Interface: OCXExtenderEvents
// TypeFlags        : (18) CanCreate Hidden
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TOLECtrlProperties= class;
{$ENDIF}
  TOLECtrl = class(TOleServer)
  private
    FOnGotFocus: TNotifyEvent;
    FOnLostFocus: TNotifyEvent;
    FIntf:        OCXExtender;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TOLECtrlProperties;
    function      GetServerProperties: TOLECtrlProperties;
{$ENDIF}
    function      GetDefaultInterface: OCXExtender;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Visible: WordBool;
    procedure Set_Visible(Visible: WordBool);
    function Get_Left: Single;
    procedure Set_Left(Left: Single);
    function Get_Top: Single;
    procedure Set_Top(Top: Single);
    function Get_Height: Single;
    procedure Set_Height(Height: Single);
    function Get_Width: Single;
    procedure Set_Width(Width: Single);
    function Get_ZOrderPosition: SYSINT;
    function Get_Name: WideString;
    procedure Set_Name(const Name: WideString);
    function Get_AltHTML: WideString;
    procedure Set_AltHTML(const AltHTML: WideString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: OCXExtender);
    procedure Disconnect; override;
    property DefaultInterface: OCXExtender read GetDefaultInterface;
    property ZOrderPosition: SYSINT read Get_ZOrderPosition;
    property AltHTML: WideString read Get_AltHTML write Set_AltHTML;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Height: Single read Get_Height write Set_Height;
    property Width: Single read Get_Width write Set_Width;
    property Name: WideString read Get_Name write Set_Name;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TOLECtrlProperties read GetServerProperties;
{$ENDIF}
    property OnGotFocus: TNotifyEvent read FOnGotFocus write FOnGotFocus;
    property OnLostFocus: TNotifyEvent read FOnLostFocus write FOnLostFocus;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TOLECtrl
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TOLECtrlProperties = class(TPersistent)
  private
    FServer:    TOLECtrl;
    function    GetDefaultInterface: OCXExtender;
    constructor Create(AServer: TOLECtrl);
  protected
    function Get_Visible: WordBool;
    procedure Set_Visible(Visible: WordBool);
    function Get_Left: Single;
    procedure Set_Left(Left: Single);
    function Get_Top: Single;
    procedure Set_Top(Top: Single);
    function Get_Height: Single;
    procedure Set_Height(Height: Single);
    function Get_Width: Single;
    procedure Set_Width(Width: Single);
    function Get_ZOrderPosition: SYSINT;
    function Get_Name: WideString;
    procedure Set_Name(const Name: WideString);
    function Get_AltHTML: WideString;
    procedure Set_AltHTML(const AltHTML: WideString);
  public
    property DefaultInterface: OCXExtender read GetDefaultInterface;
  published
    property Visible: WordBool read Get_Visible write Set_Visible;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Height: Single read Get_Height write Set_Height;
    property Width: Single read Get_Width write Set_Width;
    property Name: WideString read Get_Name write Set_Name;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoPowerPointApplication provides a Create and CreateRemote method to          
// create instances of the default interface _Application exposed by              
// the CoClass PowerPointApplication. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoPowerPointApplication = class
    class function Create: _Application;
    class function CreateRemote(const MachineName: string): _Application;
  end;

  TPowerPointApplicationWindowSelectionChange = procedure(ASender: TObject; const Sel: Selection) of object;
  TPowerPointApplicationWindowBeforeRightClick = procedure(ASender: TObject; const Sel: Selection; 
                                                                             var Cancel: WordBool) of object;
  TPowerPointApplicationWindowBeforeDoubleClick = procedure(ASender: TObject; const Sel: Selection; 
                                                                              var Cancel: WordBool) of object;
  TPowerPointApplicationPresentationClose = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TPowerPointApplicationPresentationSave = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TPowerPointApplicationPresentationOpen = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TPowerPointApplicationNewPresentation = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TPowerPointApplicationPresentationNewSlide = procedure(ASender: TObject; const Sld: PowerPointSlide) of object;
  TPowerPointApplicationWindowActivate = procedure(ASender: TObject; const Pres: PowerPointPresentation; 
                                                                     const Wn: DocumentWindow) of object;
  TPowerPointApplicationWindowDeactivate = procedure(ASender: TObject; const Pres: PowerPointPresentation; 
                                                                       const Wn: DocumentWindow) of object;
  TPowerPointApplicationSlideShowBegin = procedure(ASender: TObject; const Wn: SlideShowWindow) of object;
  TPowerPointApplicationSlideShowNextBuild = procedure(ASender: TObject; const Wn: SlideShowWindow) of object;
  TPowerPointApplicationSlideShowNextSlide = procedure(ASender: TObject; const Wn: SlideShowWindow) of object;
  TPowerPointApplicationSlideShowEnd = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;
  TPowerPointApplicationPresentationPrint = procedure(ASender: TObject; const Pres: PowerPointPresentation) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TPowerPointApplication
// Help String      : 
// Default Interface: _Application
// Def. Intf. DISP? : No
// Event   Interface: EApplication
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TPowerPointApplicationProperties= class;
{$ENDIF}
  TPowerPointApplication = class(TOleServer)
  private
    FOnWindowSelectionChange: TPowerPointApplicationWindowSelectionChange;
    FOnWindowBeforeRightClick: TPowerPointApplicationWindowBeforeRightClick;
    FOnWindowBeforeDoubleClick: TPowerPointApplicationWindowBeforeDoubleClick;
    FOnPresentationClose: TPowerPointApplicationPresentationClose;
    FOnPresentationSave: TPowerPointApplicationPresentationSave;
    FOnPresentationOpen: TPowerPointApplicationPresentationOpen;
    FOnNewPresentation: TPowerPointApplicationNewPresentation;
    FOnPresentationNewSlide: TPowerPointApplicationPresentationNewSlide;
    FOnWindowActivate: TPowerPointApplicationWindowActivate;
    FOnWindowDeactivate: TPowerPointApplicationWindowDeactivate;
    FOnSlideShowBegin: TPowerPointApplicationSlideShowBegin;
    FOnSlideShowNextBuild: TPowerPointApplicationSlideShowNextBuild;
    FOnSlideShowNextSlide: TPowerPointApplicationSlideShowNextSlide;
    FOnSlideShowEnd: TPowerPointApplicationSlideShowEnd;
    FOnPresentationPrint: TPowerPointApplicationPresentationPrint;
    FAutoQuit:    Boolean;
    FIntf:        _Application;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TPowerPointApplicationProperties;
    function      GetServerProperties: TPowerPointApplicationProperties;
{$ENDIF}
    function      GetDefaultInterface: _Application;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Presentations: Presentations;
    function Get_Windows: DocumentWindows;
    function Get_Dialogs: PPDialogs;
    function Get_ActiveWindow: DocumentWindow;
    function Get_ActivePresentation: PowerPointPresentation;
    function Get_SlideShowWindows: SlideShowWindows;
    function Get_CommandBars: CommandBars;
    function Get_Path: WideString;
    function Get_Name: WideString;
    function Get_Caption: WideString;
    procedure Set_Caption(const Caption: WideString);
    function Get_Assistant: Assistant;
    function Get_FileSearch: FileSearch;
    function Get_FileFind: IFind;
    function Get_Build: WideString;
    function Get_Version: WideString;
    function Get_OperatingSystem: WideString;
    function Get_ActivePrinter: WideString;
    function Get_Creator: Integer;
    function Get_AddIns: AddIns;
    function Get_VBE: VBE;
    function Get_Left: Single;
    procedure Set_Left(Left: Single);
    function Get_Top: Single;
    procedure Set_Top(Top: Single);
    function Get_Width: Single;
    procedure Set_Width(Width: Single);
    function Get_Height: Single;
    procedure Set_Height(Height: Single);
    function Get_WindowState: PpWindowState;
    procedure Set_WindowState(WindowState: PpWindowState);
    function Get_Visible: MsoTriState;
    procedure Set_Visible(Visible: MsoTriState);
    function Get_Active: MsoTriState;
    function Get_AnswerWizard: AnswerWizard;
    function Get_COMAddIns: COMAddIns;
    function Get_ProductCode: WideString;
    function Get_DefaultWebOptions: DefaultWebOptions;
    function Get_LanguageSettings: LanguageSettings;
    function Get_MsoDebugOptions: MsoDebugOptions;
    function Get_ShowWindowsInTaskbar: MsoTriState;
    procedure Set_ShowWindowsInTaskbar(ShowWindowsInTaskbar: MsoTriState);
    function Get_Marker: Marker;
    function Get_FeatureInstall: MsoFeatureInstall;
    procedure Set_FeatureInstall(FeatureInstall: MsoFeatureInstall);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Application);
    procedure Disconnect; override;
    procedure Help(const HelpFile: WideString; ContextID: SYSINT);
    procedure Quit;
    function Run(const MacroName: WideString; var safeArrayOfParams: PSafeArray): OleVariant;
    function FileDialog(Type_: PpFileDialogType): FileDialog;
    procedure Activate;
    function GetOptionFlag(Option: Integer; Persist: WordBool): WordBool;
    procedure SetOptionFlag(Option: Integer; State: WordBool; Persist: WordBool);
    property DefaultInterface: _Application read GetDefaultInterface;
    property Presentations: Presentations read Get_Presentations;
    property Windows: DocumentWindows read Get_Windows;
    property Dialogs: PPDialogs read Get_Dialogs;
    property ActiveWindow: DocumentWindow read Get_ActiveWindow;
    property ActivePresentation: PowerPointPresentation read Get_ActivePresentation;
    property SlideShowWindows: SlideShowWindows read Get_SlideShowWindows;
    property CommandBars: CommandBars read Get_CommandBars;
    property Path: WideString read Get_Path;
    property Name: WideString read Get_Name;
    property Assistant: Assistant read Get_Assistant;
    property FileSearch: FileSearch read Get_FileSearch;
    property FileFind: IFind read Get_FileFind;
    property Build: WideString read Get_Build;
    property Version: WideString read Get_Version;
    property OperatingSystem: WideString read Get_OperatingSystem;
    property ActivePrinter: WideString read Get_ActivePrinter;
    property Creator: Integer read Get_Creator;
    property AddIns: AddIns read Get_AddIns;
    property VBE: VBE read Get_VBE;
    property Active: MsoTriState read Get_Active;
    property AnswerWizard: AnswerWizard read Get_AnswerWizard;
    property COMAddIns: COMAddIns read Get_COMAddIns;
    property ProductCode: WideString read Get_ProductCode;
    property DefaultWebOptions: DefaultWebOptions read Get_DefaultWebOptions;
    property LanguageSettings: LanguageSettings read Get_LanguageSettings;
    property MsoDebugOptions: MsoDebugOptions read Get_MsoDebugOptions;
    property Marker: Marker read Get_Marker;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Width: Single read Get_Width write Set_Width;
    property Height: Single read Get_Height write Set_Height;
    property WindowState: PpWindowState read Get_WindowState write Set_WindowState;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property ShowWindowsInTaskbar: MsoTriState read Get_ShowWindowsInTaskbar write Set_ShowWindowsInTaskbar;
    property FeatureInstall: MsoFeatureInstall read Get_FeatureInstall write Set_FeatureInstall;
  published
    property AutoQuit: Boolean read FAutoQuit write FAutoQuit; 
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TPowerPointApplicationProperties read GetServerProperties;
{$ENDIF}
    property OnWindowSelectionChange: TPowerPointApplicationWindowSelectionChange read FOnWindowSelectionChange write FOnWindowSelectionChange;
    property OnWindowBeforeRightClick: TPowerPointApplicationWindowBeforeRightClick read FOnWindowBeforeRightClick write FOnWindowBeforeRightClick;
    property OnWindowBeforeDoubleClick: TPowerPointApplicationWindowBeforeDoubleClick read FOnWindowBeforeDoubleClick write FOnWindowBeforeDoubleClick;
    property OnPresentationClose: TPowerPointApplicationPresentationClose read FOnPresentationClose write FOnPresentationClose;
    property OnPresentationSave: TPowerPointApplicationPresentationSave read FOnPresentationSave write FOnPresentationSave;
    property OnPresentationOpen: TPowerPointApplicationPresentationOpen read FOnPresentationOpen write FOnPresentationOpen;
    property OnNewPresentation: TPowerPointApplicationNewPresentation read FOnNewPresentation write FOnNewPresentation;
    property OnPresentationNewSlide: TPowerPointApplicationPresentationNewSlide read FOnPresentationNewSlide write FOnPresentationNewSlide;
    property OnWindowActivate: TPowerPointApplicationWindowActivate read FOnWindowActivate write FOnWindowActivate;
    property OnWindowDeactivate: TPowerPointApplicationWindowDeactivate read FOnWindowDeactivate write FOnWindowDeactivate;
    property OnSlideShowBegin: TPowerPointApplicationSlideShowBegin read FOnSlideShowBegin write FOnSlideShowBegin;
    property OnSlideShowNextBuild: TPowerPointApplicationSlideShowNextBuild read FOnSlideShowNextBuild write FOnSlideShowNextBuild;
    property OnSlideShowNextSlide: TPowerPointApplicationSlideShowNextSlide read FOnSlideShowNextSlide write FOnSlideShowNextSlide;
    property OnSlideShowEnd: TPowerPointApplicationSlideShowEnd read FOnSlideShowEnd write FOnSlideShowEnd;
    property OnPresentationPrint: TPowerPointApplicationPresentationPrint read FOnPresentationPrint write FOnPresentationPrint;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TPowerPointApplication
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TPowerPointApplicationProperties = class(TPersistent)
  private
    FServer:    TPowerPointApplication;
    function    GetDefaultInterface: _Application;
    constructor Create(AServer: TPowerPointApplication);
  protected
    function Get_Presentations: Presentations;
    function Get_Windows: DocumentWindows;
    function Get_Dialogs: PPDialogs;
    function Get_ActiveWindow: DocumentWindow;
    function Get_ActivePresentation: PowerPointPresentation;
    function Get_SlideShowWindows: SlideShowWindows;
    function Get_CommandBars: CommandBars;
    function Get_Path: WideString;
    function Get_Name: WideString;
    function Get_Caption: WideString;
    procedure Set_Caption(const Caption: WideString);
    function Get_Assistant: Assistant;
    function Get_FileSearch: FileSearch;
    function Get_FileFind: IFind;
    function Get_Build: WideString;
    function Get_Version: WideString;
    function Get_OperatingSystem: WideString;
    function Get_ActivePrinter: WideString;
    function Get_Creator: Integer;
    function Get_AddIns: AddIns;
    function Get_VBE: VBE;
    function Get_Left: Single;
    procedure Set_Left(Left: Single);
    function Get_Top: Single;
    procedure Set_Top(Top: Single);
    function Get_Width: Single;
    procedure Set_Width(Width: Single);
    function Get_Height: Single;
    procedure Set_Height(Height: Single);
    function Get_WindowState: PpWindowState;
    procedure Set_WindowState(WindowState: PpWindowState);
    function Get_Visible: MsoTriState;
    procedure Set_Visible(Visible: MsoTriState);
    function Get_Active: MsoTriState;
    function Get_AnswerWizard: AnswerWizard;
    function Get_COMAddIns: COMAddIns;
    function Get_ProductCode: WideString;
    function Get_DefaultWebOptions: DefaultWebOptions;
    function Get_LanguageSettings: LanguageSettings;
    function Get_MsoDebugOptions: MsoDebugOptions;
    function Get_ShowWindowsInTaskbar: MsoTriState;
    procedure Set_ShowWindowsInTaskbar(ShowWindowsInTaskbar: MsoTriState);
    function Get_Marker: Marker;
    function Get_FeatureInstall: MsoFeatureInstall;
    procedure Set_FeatureInstall(FeatureInstall: MsoFeatureInstall);
  public
    property DefaultInterface: _Application read GetDefaultInterface;
  published
    property Caption: WideString read Get_Caption write Set_Caption;
    property Left: Single read Get_Left write Set_Left;
    property Top: Single read Get_Top write Set_Top;
    property Width: Single read Get_Width write Set_Width;
    property Height: Single read Get_Height write Set_Height;
    property WindowState: PpWindowState read Get_WindowState write Set_WindowState;
    property Visible: MsoTriState read Get_Visible write Set_Visible;
    property ShowWindowsInTaskbar: MsoTriState read Get_ShowWindowsInTaskbar write Set_ShowWindowsInTaskbar;
    property FeatureInstall: MsoFeatureInstall read Get_FeatureInstall write Set_FeatureInstall;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMaster provides a Create and CreateRemote method to          
// create instances of the default interface _Master exposed by              
// the CoClass Master. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMaster = class
    class function Create: _Master;
    class function CreateRemote(const MachineName: string): _Master;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMaster
// Help String      : 
// Default Interface: _Master
// Def. Intf. DISP? : No
// Event   Interface: MasterEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMasterProperties= class;
{$ENDIF}
  TMaster = class(TOleServer)
  private
    FIntf:        _Master;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TMasterProperties;
    function      GetServerProperties: TMasterProperties;
{$ENDIF}
    function      GetDefaultInterface: _Master;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Application: PowerPointApplication;
    function Get_Parent: IDispatch;
    function Get_Shapes: Shapes;
    function Get_HeadersFooters: HeadersFooters;
    function Get_ColorScheme: ColorScheme;
    procedure Set_ColorScheme(const ColorScheme: ColorScheme);
    function Get_Background: ShapeRange;
    function Get_Name: WideString;
    procedure Set_Name(const Name: WideString);
    function Get_Height: Single;
    function Get_Width: Single;
    function Get_TextStyles: TextStyles;
    function Get_Hyperlinks: Hyperlinks;
    function Get_Scripts: Scripts;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: _Master);
    procedure Disconnect; override;
    procedure Delete;
    property DefaultInterface: _Master read GetDefaultInterface;
    property Application: PowerPointApplication read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Shapes: Shapes read Get_Shapes;
    property HeadersFooters: HeadersFooters read Get_HeadersFooters;
    property Background: ShapeRange read Get_Background;
    property Height: Single read Get_Height;
    property Width: Single read Get_Width;
    property TextStyles: TextStyles read Get_TextStyles;
    property Hyperlinks: Hyperlinks read Get_Hyperlinks;
    property Scripts: Scripts read Get_Scripts;
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property Name: WideString read Get_Name write Set_Name;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMasterProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMaster
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMasterProperties = class(TPersistent)
  private
    FServer:    TMaster;
    function    GetDefaultInterface: _Master;
    constructor Create(AServer: TMaster);
  protected
    function Get_Application: PowerPointApplication;
    function Get_Parent: IDispatch;
    function Get_Shapes: Shapes;
    function Get_HeadersFooters: HeadersFooters;
    function Get_ColorScheme: ColorScheme;
    procedure Set_ColorScheme(const ColorScheme: ColorScheme);
    function Get_Background: ShapeRange;
    function Get_Name: WideString;
    procedure Set_Name(const Name: WideString);
    function Get_Height: Single;
    function Get_Width: Single;
    function Get_TextStyles: TextStyles;
    function Get_Hyperlinks: Hyperlinks;
    function Get_Scripts: Scripts;
  public
    property DefaultInterface: _Master read GetDefaultInterface;
  published
    property ColorScheme: ColorScheme read Get_ColorScheme write Set_ColorScheme;
    property Name: WideString read Get_Name write Set_Name;
  end;
{$ENDIF}


implementation

uses ComObj;

class function CoPowerPointGlobal.Create: _Global;
begin
  Result := CreateComObject(CLASS_PowerPointGlobal) as _Global;
end;

class function CoPowerPointGlobal.CreateRemote(const MachineName: string): _Global;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PowerPointGlobal) as _Global;
end;

procedure TPowerPointGlobal.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{91493443-5A91-11CF-8700-00AA0060263B}';
    IntfIID:   '{91493451-5A91-11CF-8700-00AA0060263B}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPowerPointGlobal.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as _Global;
  end;
end;

procedure TPowerPointGlobal.ConnectTo(svrIntf: _Global);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TPowerPointGlobal.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TPowerPointGlobal.GetDefaultInterface: _Global;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPowerPointGlobal.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPowerPointGlobalProperties.Create(Self);
{$ENDIF}
end;

destructor TPowerPointGlobal.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPowerPointGlobal.GetServerProperties: TPowerPointGlobalProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TPowerPointGlobal.Get_ActivePresentation: PowerPointPresentation;
begin
    Result := DefaultInterface.ActivePresentation;
end;

function TPowerPointGlobal.Get_ActiveWindow: DocumentWindow;
begin
    Result := DefaultInterface.ActiveWindow;
end;

function TPowerPointGlobal.Get_AddIns: AddIns;
begin
    Result := DefaultInterface.AddIns;
end;

function TPowerPointGlobal.Get_Application: PowerPointApplication;
begin
    Result := DefaultInterface.Application;
end;

function TPowerPointGlobal.Get_Assistant: Assistant;
begin
    Result := DefaultInterface.Assistant;
end;

function TPowerPointGlobal.Get_Dialogs: PPDialogs;
begin
    Result := DefaultInterface.Dialogs;
end;

function TPowerPointGlobal.Get_Presentations: Presentations;
begin
    Result := DefaultInterface.Presentations;
end;

function TPowerPointGlobal.Get_SlideShowWindows: SlideShowWindows;
begin
    Result := DefaultInterface.SlideShowWindows;
end;

function TPowerPointGlobal.Get_Windows: DocumentWindows;
begin
    Result := DefaultInterface.Windows;
end;

function TPowerPointGlobal.Get_CommandBars: CommandBars;
begin
    Result := DefaultInterface.CommandBars;
end;

function TPowerPointGlobal.Get_AnswerWizard: AnswerWizard;
begin
    Result := DefaultInterface.AnswerWizard;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPowerPointGlobalProperties.Create(AServer: TPowerPointGlobal);
begin
  inherited Create;
  FServer := AServer;
end;

function TPowerPointGlobalProperties.GetDefaultInterface: _Global;
begin
  Result := FServer.DefaultInterface;
end;

function TPowerPointGlobalProperties.Get_ActivePresentation: PowerPointPresentation;
begin
    Result := DefaultInterface.ActivePresentation;
end;

function TPowerPointGlobalProperties.Get_ActiveWindow: DocumentWindow;
begin
    Result := DefaultInterface.ActiveWindow;
end;

function TPowerPointGlobalProperties.Get_AddIns: AddIns;
begin
    Result := DefaultInterface.AddIns;
end;

function TPowerPointGlobalProperties.Get_Application: PowerPointApplication;
begin
    Result := DefaultInterface.Application;
end;

function TPowerPointGlobalProperties.Get_Assistant: Assistant;
begin
    Result := DefaultInterface.Assistant;
end;

function TPowerPointGlobalProperties.Get_Dialogs: PPDialogs;
begin
    Result := DefaultInterface.Dialogs;
end;

function TPowerPointGlobalProperties.Get_Presentations: Presentations;
begin
    Result := DefaultInterface.Presentations;
end;

function TPowerPointGlobalProperties.Get_SlideShowWindows: SlideShowWindows;
begin
    Result := DefaultInterface.SlideShowWindows;
end;

function TPowerPointGlobalProperties.Get_Windows: DocumentWindows;
begin
    Result := DefaultInterface.Windows;
end;

function TPowerPointGlobalProperties.Get_CommandBars: CommandBars;
begin
    Result := DefaultInterface.CommandBars;
end;

function TPowerPointGlobalProperties.Get_AnswerWizard: AnswerWizard;
begin
    Result := DefaultInterface.AnswerWizard;
end;

{$ENDIF}

class function CoPowerPointSlide.Create: _Slide;
begin
  Result := CreateComObject(CLASS_PowerPointSlide) as _Slide;
end;

class function CoPowerPointSlide.CreateRemote(const MachineName: string): _Slide;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PowerPointSlide) as _Slide;
end;

procedure TPowerPointSlide.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{91493445-5A91-11CF-8700-00AA0060263B}';
    IntfIID:   '{9149346A-5A91-11CF-8700-00AA0060263B}';
    EventIID:  '{9149346D-5A91-11CF-8700-00AA0060263B}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPowerPointSlide.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Slide;
  end;
end;

procedure TPowerPointSlide.ConnectTo(svrIntf: _Slide);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TPowerPointSlide.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TPowerPointSlide.GetDefaultInterface: _Slide;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPowerPointSlide.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPowerPointSlideProperties.Create(Self);
{$ENDIF}
end;

destructor TPowerPointSlide.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPowerPointSlide.GetServerProperties: TPowerPointSlideProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TPowerPointSlide.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
  end; {case DispID}
end;

function TPowerPointSlide.Get_Application: PowerPointApplication;
begin
    Result := DefaultInterface.Application;
end;

function TPowerPointSlide.Get_Parent: IDispatch;
begin
    Result := DefaultInterface.Parent;
end;

function TPowerPointSlide.Get_Shapes: Shapes;
begin
    Result := DefaultInterface.Shapes;
end;

function TPowerPointSlide.Get_HeadersFooters: HeadersFooters;
begin
    Result := DefaultInterface.HeadersFooters;
end;

function TPowerPointSlide.Get_SlideShowTransition: SlideShowTransition;
begin
    Result := DefaultInterface.SlideShowTransition;
end;

function TPowerPointSlide.Get_ColorScheme: ColorScheme;
begin
    Result := DefaultInterface.ColorScheme;
end;

procedure TPowerPointSlide.Set_ColorScheme(const ColorScheme: ColorScheme);
begin
  DefaultInterface.Set_ColorScheme(ColorScheme);
end;

function TPowerPointSlide.Get_Background: ShapeRange;
begin
    Result := DefaultInterface.Background;
end;

function TPowerPointSlide.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

procedure TPowerPointSlide.Set_Name(const Name: WideString);
  { Warning: The property Name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Name := Name;
end;

function TPowerPointSlide.Get_SlideID: Integer;
begin
    Result := DefaultInterface.SlideID;
end;

function TPowerPointSlide.Get_PrintSteps: SYSINT;
begin
    Result := DefaultInterface.PrintSteps;
end;

function TPowerPointSlide.Get_Layout: PpSlideLayout;
begin
    Result := DefaultInterface.Layout;
end;

procedure TPowerPointSlide.Set_Layout(Layout: PpSlideLayout);
begin
  DefaultInterface.Set_Layout(Layout);
end;

function TPowerPointSlide.Get_Tags: Tags;
begin
    Result := DefaultInterface.Tags;
end;

function TPowerPointSlide.Get_SlideIndex: SYSINT;
begin
    Result := DefaultInterface.SlideIndex;
end;

function TPowerPointSlide.Get_SlideNumber: SYSINT;
begin
    Result := DefaultInterface.SlideNumber;
end;

function TPowerPointSlide.Get_DisplayMasterShapes: MsoTriState;
begin
    Result := DefaultInterface.DisplayMasterShapes;
end;

procedure TPowerPointSlide.Set_DisplayMasterShapes(DisplayMasterShapes: MsoTriState);
begin
  DefaultInterface.Set_DisplayMasterShapes(DisplayMasterShapes);
end;

function TPowerPointSlide.Get_FollowMasterBackground: MsoTriState;
begin
    Result := DefaultInterface.FollowMasterBackground;
end;

procedure TPowerPointSlide.Set_FollowMasterBackground(FollowMasterBackground: MsoTriState);
begin
  DefaultInterface.Set_FollowMasterBackground(FollowMasterBackground);
end;

function TPowerPointSlide.Get_NotesPage: SlideRange;
begin
    Result := DefaultInterface.NotesPage;
end;

function TPowerPointSlide.Get_Master: _Master;
begin
    Result := DefaultInterface.Master;
end;

function TPowerPointSlide.Get_Hyperlinks: Hyperlinks;
begin
    Result := DefaultInterface.Hyperlinks;
end;

function TPowerPointSlide.Get_Scripts: Scripts;
begin
    Result := DefaultInterface.Scripts;
end;

procedure TPowerPointSlide.Select;
begin
  DefaultInterface.Select;
end;

procedure TPowerPointSlide.Cut;
begin
  DefaultInterface.Cut;
end;

procedure TPowerPointSlide.Copy;
begin
  DefaultInterface.Copy;
end;

function TPowerPointSlide.Duplicate: SlideRange;
begin
  Result := DefaultInterface.Duplicate;
end;

procedure TPowerPointSlide.Delete;
begin
  DefaultInterface.Delete;
end;

procedure TPowerPointSlide.Export(const FileName: WideString; const FilterName: WideString; 
                                  ScaleWidth: SYSINT; ScaleHeight: SYSINT);
begin
  DefaultInterface.Export(FileName, FilterName, ScaleWidth, ScaleHeight);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPowerPointSlideProperties.Create(AServer: TPowerPointSlide);
begin
  inherited Create;
  FServer := AServer;
end;

function TPowerPointSlideProperties.GetDefaultInterface: _Slide;
begin
  Result := FServer.DefaultInterface;
end;

function TPowerPointSlideProperties.Get_Application: PowerPointApplication;
begin
    Result := DefaultInterface.Application;
end;

function TPowerPointSlideProperties.Get_Parent: IDispatch;
begin
    Result := DefaultInterface.Parent;
end;

function TPowerPointSlideProperties.Get_Shapes: Shapes;
begin
    Result := DefaultInterface.Shapes;
end;

function TPowerPointSlideProperties.Get_HeadersFooters: HeadersFooters;
begin
    Result := DefaultInterface.HeadersFooters;
end;

function TPowerPointSlideProperties.Get_SlideShowTransition: SlideShowTransition;
begin
    Result := DefaultInterface.SlideShowTransition;
end;

function TPowerPointSlideProperties.Get_ColorScheme: ColorScheme;
begin
    Result := DefaultInterface.ColorScheme;
end;

procedure TPowerPointSlideProperties.Set_ColorScheme(const ColorScheme: ColorScheme);
begin
  DefaultInterface.Set_ColorScheme(ColorScheme);
end;

function TPowerPointSlideProperties.Get_Background: ShapeRange;
begin
    Result := DefaultInterface.Background;
end;

function TPowerPointSlideProperties.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

procedure TPowerPointSlideProperties.Set_Name(const Name: WideString);
  { Warning: The property Name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Name := Name;
end;

function TPowerPointSlideProperties.Get_SlideID: Integer;
begin
    Result := DefaultInterface.SlideID;
end;

function TPowerPointSlideProperties.Get_PrintSteps: SYSINT;
begin
    Result := DefaultInterface.PrintSteps;
end;

function TPowerPointSlideProperties.Get_Layout: PpSlideLayout;
begin
    Result := DefaultInterface.Layout;
end;

procedure TPowerPointSlideProperties.Set_Layout(Layout: PpSlideLayout);
begin
  DefaultInterface.Set_Layout(Layout);
end;

function TPowerPointSlideProperties.Get_Tags: Tags;
begin
    Result := DefaultInterface.Tags;
end;

function TPowerPointSlideProperties.Get_SlideIndex: SYSINT;
begin
    Result := DefaultInterface.SlideIndex;
end;

function TPowerPointSlideProperties.Get_SlideNumber: SYSINT;
begin
    Result := DefaultInterface.SlideNumber;
end;

function TPowerPointSlideProperties.Get_DisplayMasterShapes: MsoTriState;
begin
    Result := DefaultInterface.DisplayMasterShapes;
end;

procedure TPowerPointSlideProperties.Set_DisplayMasterShapes(DisplayMasterShapes: MsoTriState);
begin
  DefaultInterface.Set_DisplayMasterShapes(DisplayMasterShapes);
end;

function TPowerPointSlideProperties.Get_FollowMasterBackground: MsoTriState;
begin
    Result := DefaultInterface.FollowMasterBackground;
end;

procedure TPowerPointSlideProperties.Set_FollowMasterBackground(FollowMasterBackground: MsoTriState);
begin
  DefaultInterface.Set_FollowMasterBackground(FollowMasterBackground);
end;

function TPowerPointSlideProperties.Get_NotesPage: SlideRange;
begin
    Result := DefaultInterface.NotesPage;
end;

function TPowerPointSlideProperties.Get_Master: _Master;
begin
    Result := DefaultInterface.Master;
end;

function TPowerPointSlideProperties.Get_Hyperlinks: Hyperlinks;
begin
    Result := DefaultInterface.Hyperlinks;
end;

function TPowerPointSlideProperties.Get_Scripts: Scripts;
begin
    Result := DefaultInterface.Scripts;
end;

{$ENDIF}

class function CoPowerPointPresentation.Create: _Presentation;
begin
  Result := CreateComObject(CLASS_PowerPointPresentation) as _Presentation;
end;

class function CoPowerPointPresentation.CreateRemote(const MachineName: string): _Presentation;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PowerPointPresentation) as _Presentation;
end;

procedure TPowerPointPresentation.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{91493444-5A91-11CF-8700-00AA0060263B}';
    IntfIID:   '{9149349D-5A91-11CF-8700-00AA0060263B}';
    EventIID:  '{91493463-5A91-11CF-8700-00AA0060263B}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPowerPointPresentation.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Presentation;
  end;
end;

procedure TPowerPointPresentation.ConnectTo(svrIntf: _Presentation);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TPowerPointPresentation.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TPowerPointPresentation.GetDefaultInterface: _Presentation;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPowerPointPresentation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPowerPointPresentationProperties.Create(Self);
{$ENDIF}
end;

destructor TPowerPointPresentation.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPowerPointPresentation.GetServerProperties: TPowerPointPresentationProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TPowerPointPresentation.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
  end; {case DispID}
end;

function TPowerPointPresentation.Get_Application: PowerPointApplication;
begin
    Result := DefaultInterface.Application;
end;

function TPowerPointPresentation.Get_Parent: IDispatch;
begin
    Result := DefaultInterface.Parent;
end;

function TPowerPointPresentation.Get_SlideMaster: _Master;
begin
    Result := DefaultInterface.SlideMaster;
end;

function TPowerPointPresentation.Get_TitleMaster: _Master;
begin
    Result := DefaultInterface.TitleMaster;
end;

function TPowerPointPresentation.Get_HasTitleMaster: MsoTriState;
begin
    Result := DefaultInterface.HasTitleMaster;
end;

function TPowerPointPresentation.Get_TemplateName: WideString;
begin
    Result := DefaultInterface.TemplateName;
end;

function TPowerPointPresentation.Get_NotesMaster: _Master;
begin
    Result := DefaultInterface.NotesMaster;
end;

function TPowerPointPresentation.Get_HandoutMaster: _Master;
begin
    Result := DefaultInterface.HandoutMaster;
end;

function TPowerPointPresentation.Get_Slides: Slides;
begin
    Result := DefaultInterface.Slides;
end;

function TPowerPointPresentation.Get_PageSetup: PageSetup;
begin
    Result := DefaultInterface.PageSetup;
end;

function TPowerPointPresentation.Get_ColorSchemes: ColorSchemes;
begin
    Result := DefaultInterface.ColorSchemes;
end;

function TPowerPointPresentation.Get_ExtraColors: ExtraColors;
begin
    Result := DefaultInterface.ExtraColors;
end;

function TPowerPointPresentation.Get_SlideShowSettings: SlideShowSettings;
begin
    Result := DefaultInterface.SlideShowSettings;
end;

function TPowerPointPresentation.Get_Fonts: Fonts;
begin
    Result := DefaultInterface.Fonts;
end;

function TPowerPointPresentation.Get_Windows: DocumentWindows;
begin
    Result := DefaultInterface.Windows;
end;

function TPowerPointPresentation.Get_Tags: Tags;
begin
    Result := DefaultInterface.Tags;
end;

function TPowerPointPresentation.Get_DefaultShape: Shape;
begin
    Result := DefaultInterface.DefaultShape;
end;

function TPowerPointPresentation.Get_BuiltInDocumentProperties: IDispatch;
begin
    Result := DefaultInterface.BuiltInDocumentProperties;
end;

function TPowerPointPresentation.Get_CustomDocumentProperties: IDispatch;
begin
    Result := DefaultInterface.CustomDocumentProperties;
end;

function TPowerPointPresentation.Get_VBProject: VBProject;
begin
    Result := DefaultInterface.VBProject;
end;

function TPowerPointPresentation.Get_ReadOnly: MsoTriState;
begin
    Result := DefaultInterface.ReadOnly;
end;

function TPowerPointPresentation.Get_FullName: WideString;
begin
    Result := DefaultInterface.FullName;
end;

function TPowerPointPresentation.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TPowerPointPresentation.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

function TPowerPointPresentation.Get_Saved: MsoTriState;
begin
    Result := DefaultInterface.Saved;
end;

procedure TPowerPointPresentation.Set_Saved(Saved: MsoTriState);
begin
  DefaultInterface.Set_Saved(Saved);
end;

function TPowerPointPresentation.Get_LayoutDirection: PpDirection;
begin
    Result := DefaultInterface.LayoutDirection;
end;

procedure TPowerPointPresentation.Set_LayoutDirection(LayoutDirection: PpDirection);
begin
  DefaultInterface.Set_LayoutDirection(LayoutDirection);
end;

function TPowerPointPresentation.Get_PrintOptions: PrintOptions;
begin
    Result := DefaultInterface.PrintOptions;
end;

function TPowerPointPresentation.Get_Container: IDispatch;
begin
    Result := DefaultInterface.Container;
end;

function TPowerPointPresentation.Get_DisplayComments: MsoTriState;
begin
    Result := DefaultInterface.DisplayComments;
end;

procedure TPowerPointPresentation.Set_DisplayComments(DisplayComments: MsoTriState);
begin
  DefaultInterface.Set_DisplayComments(DisplayComments);
end;

function TPowerPointPresentation.Get_FarEastLineBreakLevel: PpFarEastLineBreakLevel;
begin
    Result := DefaultInterface.FarEastLineBreakLevel;
end;

procedure TPowerPointPresentation.Set_FarEastLineBreakLevel(FarEastLineBreakLevel: PpFarEastLineBreakLevel);
begin
  DefaultInterface.Set_FarEastLineBreakLevel(FarEastLineBreakLevel);
end;

function TPowerPointPresentation.Get_NoLineBreakBefore: WideString;
begin
    Result := DefaultInterface.NoLineBreakBefore;
end;

procedure TPowerPointPresentation.Set_NoLineBreakBefore(const NoLineBreakBefore: WideString);
  { Warning: The property NoLineBreakBefore has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.NoLineBreakBefore := NoLineBreakBefore;
end;

function TPowerPointPresentation.Get_NoLineBreakAfter: WideString;
begin
    Result := DefaultInterface.NoLineBreakAfter;
end;

procedure TPowerPointPresentation.Set_NoLineBreakAfter(const NoLineBreakAfter: WideString);
  { Warning: The property NoLineBreakAfter has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.NoLineBreakAfter := NoLineBreakAfter;
end;

function TPowerPointPresentation.Get_SlideShowWindow: SlideShowWindow;
begin
    Result := DefaultInterface.SlideShowWindow;
end;

function TPowerPointPresentation.Get_FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID;
begin
    Result := DefaultInterface.FarEastLineBreakLanguage;
end;

procedure TPowerPointPresentation.Set_FarEastLineBreakLanguage(FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID);
begin
  DefaultInterface.Set_FarEastLineBreakLanguage(FarEastLineBreakLanguage);
end;

function TPowerPointPresentation.Get_DefaultLanguageID: MsoLanguageID;
begin
    Result := DefaultInterface.DefaultLanguageID;
end;

procedure TPowerPointPresentation.Set_DefaultLanguageID(DefaultLanguageID: MsoLanguageID);
begin
  DefaultInterface.Set_DefaultLanguageID(DefaultLanguageID);
end;

function TPowerPointPresentation.Get_CommandBars: CommandBars;
begin
    Result := DefaultInterface.CommandBars;
end;

function TPowerPointPresentation.Get_PublishObjects: PublishObjects;
begin
    Result := DefaultInterface.PublishObjects;
end;

function TPowerPointPresentation.Get_WebOptions: WebOptions;
begin
    Result := DefaultInterface.WebOptions;
end;

function TPowerPointPresentation.Get_HTMLProject: HTMLProject;
begin
    Result := DefaultInterface.HTMLProject;
end;

function TPowerPointPresentation.Get_EnvelopeVisible: MsoTriState;
begin
    Result := DefaultInterface.EnvelopeVisible;
end;

procedure TPowerPointPresentation.Set_EnvelopeVisible(EnvelopeVisible: MsoTriState);
begin
  DefaultInterface.Set_EnvelopeVisible(EnvelopeVisible);
end;

function TPowerPointPresentation.Get_VBASigned: MsoTriState;
begin
    Result := DefaultInterface.VBASigned;
end;

function TPowerPointPresentation.AddTitleMaster: _Master;
begin
  Result := DefaultInterface.AddTitleMaster;
end;

procedure TPowerPointPresentation.ApplyTemplate(const FileName: WideString);
begin
  DefaultInterface.ApplyTemplate(FileName);
end;

function TPowerPointPresentation.NewWindow: DocumentWindow;
begin
  Result := DefaultInterface.NewWindow;
end;

procedure TPowerPointPresentation.FollowHyperlink(const Address: WideString; 
                                                  const SubAddress: WideString; 
                                                  NewWindow: WordBool; AddHistory: WordBool; 
                                                  const ExtraInfo: WideString; 
                                                  Method: MsoExtraInfoMethod; 
                                                  const HeaderInfo: WideString);
begin
  DefaultInterface.FollowHyperlink(Address, SubAddress, NewWindow, AddHistory, ExtraInfo, Method, 
                                   HeaderInfo);
end;

procedure TPowerPointPresentation.AddToFavorites;
begin
  DefaultInterface.AddToFavorites;
end;

procedure TPowerPointPresentation.PrintOut(From: SYSINT; To_: SYSINT; 
                                           const PrintToFile: WideString; Copies: SYSINT; 
                                           Collate: MsoTriState);
begin
  DefaultInterface.PrintOut(From, To_, PrintToFile, Copies, Collate);
end;

procedure TPowerPointPresentation.Save;
begin
  DefaultInterface.Save;
end;

procedure TPowerPointPresentation.SaveAs(const FileName: WideString; FileFormat: PpSaveAsFileType; 
                                         EmbedTrueTypeFonts: MsoTriState);
begin
  DefaultInterface.SaveAs(FileName, FileFormat, EmbedTrueTypeFonts);
end;

procedure TPowerPointPresentation.SaveCopyAs(const FileName: WideString; 
                                             FileFormat: PpSaveAsFileType; 
                                             EmbedTrueTypeFonts: MsoTriState);
begin
  DefaultInterface.SaveCopyAs(FileName, FileFormat, EmbedTrueTypeFonts);
end;

procedure TPowerPointPresentation.Export(const Path: WideString; const FilterName: WideString; 
                                         ScaleWidth: SYSINT; ScaleHeight: SYSINT);
begin
  DefaultInterface.Export(Path, FilterName, ScaleWidth, ScaleHeight);
end;

procedure TPowerPointPresentation.Close;
begin
  DefaultInterface.Close;
end;

procedure TPowerPointPresentation.SetUndoText(const Text: WideString);
begin
  DefaultInterface.SetUndoText(Text);
end;

procedure TPowerPointPresentation.UpdateLinks;
begin
  DefaultInterface.UpdateLinks;
end;

procedure TPowerPointPresentation.WebPagePreview;
begin
  DefaultInterface.WebPagePreview;
end;

procedure TPowerPointPresentation.ReloadAs(cp: MsoEncoding);
begin
  DefaultInterface.ReloadAs(cp);
end;

procedure TPowerPointPresentation.MakeIntoTemplate(IsDesignTemplate: MsoTriState);
begin
  DefaultInterface.MakeIntoTemplate(IsDesignTemplate);
end;

procedure TPowerPointPresentation.sblt(const s: WideString);
begin
  DefaultInterface.sblt(s);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPowerPointPresentationProperties.Create(AServer: TPowerPointPresentation);
begin
  inherited Create;
  FServer := AServer;
end;

function TPowerPointPresentationProperties.GetDefaultInterface: _Presentation;
begin
  Result := FServer.DefaultInterface;
end;

function TPowerPointPresentationProperties.Get_Application: PowerPointApplication;
begin
    Result := DefaultInterface.Application;
end;

function TPowerPointPresentationProperties.Get_Parent: IDispatch;
begin
    Result := DefaultInterface.Parent;
end;

function TPowerPointPresentationProperties.Get_SlideMaster: _Master;
begin
    Result := DefaultInterface.SlideMaster;
end;

function TPowerPointPresentationProperties.Get_TitleMaster: _Master;
begin
    Result := DefaultInterface.TitleMaster;
end;

function TPowerPointPresentationProperties.Get_HasTitleMaster: MsoTriState;
begin
    Result := DefaultInterface.HasTitleMaster;
end;

function TPowerPointPresentationProperties.Get_TemplateName: WideString;
begin
    Result := DefaultInterface.TemplateName;
end;

function TPowerPointPresentationProperties.Get_NotesMaster: _Master;
begin
    Result := DefaultInterface.NotesMaster;
end;

function TPowerPointPresentationProperties.Get_HandoutMaster: _Master;
begin
    Result := DefaultInterface.HandoutMaster;
end;

function TPowerPointPresentationProperties.Get_Slides: Slides;
begin
    Result := DefaultInterface.Slides;
end;

function TPowerPointPresentationProperties.Get_PageSetup: PageSetup;
begin
    Result := DefaultInterface.PageSetup;
end;

function TPowerPointPresentationProperties.Get_ColorSchemes: ColorSchemes;
begin
    Result := DefaultInterface.ColorSchemes;
end;

function TPowerPointPresentationProperties.Get_ExtraColors: ExtraColors;
begin
    Result := DefaultInterface.ExtraColors;
end;

function TPowerPointPresentationProperties.Get_SlideShowSettings: SlideShowSettings;
begin
    Result := DefaultInterface.SlideShowSettings;
end;

function TPowerPointPresentationProperties.Get_Fonts: Fonts;
begin
    Result := DefaultInterface.Fonts;
end;

function TPowerPointPresentationProperties.Get_Windows: DocumentWindows;
begin
    Result := DefaultInterface.Windows;
end;

function TPowerPointPresentationProperties.Get_Tags: Tags;
begin
    Result := DefaultInterface.Tags;
end;

function TPowerPointPresentationProperties.Get_DefaultShape: Shape;
begin
    Result := DefaultInterface.DefaultShape;
end;

function TPowerPointPresentationProperties.Get_BuiltInDocumentProperties: IDispatch;
begin
    Result := DefaultInterface.BuiltInDocumentProperties;
end;

function TPowerPointPresentationProperties.Get_CustomDocumentProperties: IDispatch;
begin
    Result := DefaultInterface.CustomDocumentProperties;
end;

function TPowerPointPresentationProperties.Get_VBProject: VBProject;
begin
    Result := DefaultInterface.VBProject;
end;

function TPowerPointPresentationProperties.Get_ReadOnly: MsoTriState;
begin
    Result := DefaultInterface.ReadOnly;
end;

function TPowerPointPresentationProperties.Get_FullName: WideString;
begin
    Result := DefaultInterface.FullName;
end;

function TPowerPointPresentationProperties.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TPowerPointPresentationProperties.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

function TPowerPointPresentationProperties.Get_Saved: MsoTriState;
begin
    Result := DefaultInterface.Saved;
end;

procedure TPowerPointPresentationProperties.Set_Saved(Saved: MsoTriState);
begin
  DefaultInterface.Set_Saved(Saved);
end;

function TPowerPointPresentationProperties.Get_LayoutDirection: PpDirection;
begin
    Result := DefaultInterface.LayoutDirection;
end;

procedure TPowerPointPresentationProperties.Set_LayoutDirection(LayoutDirection: PpDirection);
begin
  DefaultInterface.Set_LayoutDirection(LayoutDirection);
end;

function TPowerPointPresentationProperties.Get_PrintOptions: PrintOptions;
begin
    Result := DefaultInterface.PrintOptions;
end;

function TPowerPointPresentationProperties.Get_Container: IDispatch;
begin
    Result := DefaultInterface.Container;
end;

function TPowerPointPresentationProperties.Get_DisplayComments: MsoTriState;
begin
    Result := DefaultInterface.DisplayComments;
end;

procedure TPowerPointPresentationProperties.Set_DisplayComments(DisplayComments: MsoTriState);
begin
  DefaultInterface.Set_DisplayComments(DisplayComments);
end;

function TPowerPointPresentationProperties.Get_FarEastLineBreakLevel: PpFarEastLineBreakLevel;
begin
    Result := DefaultInterface.FarEastLineBreakLevel;
end;

procedure TPowerPointPresentationProperties.Set_FarEastLineBreakLevel(FarEastLineBreakLevel: PpFarEastLineBreakLevel);
begin
  DefaultInterface.Set_FarEastLineBreakLevel(FarEastLineBreakLevel);
end;

function TPowerPointPresentationProperties.Get_NoLineBreakBefore: WideString;
begin
    Result := DefaultInterface.NoLineBreakBefore;
end;

procedure TPowerPointPresentationProperties.Set_NoLineBreakBefore(const NoLineBreakBefore: WideString);
  { Warning: The property NoLineBreakBefore has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.NoLineBreakBefore := NoLineBreakBefore;
end;

function TPowerPointPresentationProperties.Get_NoLineBreakAfter: WideString;
begin
    Result := DefaultInterface.NoLineBreakAfter;
end;

procedure TPowerPointPresentationProperties.Set_NoLineBreakAfter(const NoLineBreakAfter: WideString);
  { Warning: The property NoLineBreakAfter has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.NoLineBreakAfter := NoLineBreakAfter;
end;

function TPowerPointPresentationProperties.Get_SlideShowWindow: SlideShowWindow;
begin
    Result := DefaultInterface.SlideShowWindow;
end;

function TPowerPointPresentationProperties.Get_FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID;
begin
    Result := DefaultInterface.FarEastLineBreakLanguage;
end;

procedure TPowerPointPresentationProperties.Set_FarEastLineBreakLanguage(FarEastLineBreakLanguage: MsoFarEastLineBreakLanguageID);
begin
  DefaultInterface.Set_FarEastLineBreakLanguage(FarEastLineBreakLanguage);
end;

function TPowerPointPresentationProperties.Get_DefaultLanguageID: MsoLanguageID;
begin
    Result := DefaultInterface.DefaultLanguageID;
end;

procedure TPowerPointPresentationProperties.Set_DefaultLanguageID(DefaultLanguageID: MsoLanguageID);
begin
  DefaultInterface.Set_DefaultLanguageID(DefaultLanguageID);
end;

function TPowerPointPresentationProperties.Get_CommandBars: CommandBars;
begin
    Result := DefaultInterface.CommandBars;
end;

function TPowerPointPresentationProperties.Get_PublishObjects: PublishObjects;
begin
    Result := DefaultInterface.PublishObjects;
end;

function TPowerPointPresentationProperties.Get_WebOptions: WebOptions;
begin
    Result := DefaultInterface.WebOptions;
end;

function TPowerPointPresentationProperties.Get_HTMLProject: HTMLProject;
begin
    Result := DefaultInterface.HTMLProject;
end;

function TPowerPointPresentationProperties.Get_EnvelopeVisible: MsoTriState;
begin
    Result := DefaultInterface.EnvelopeVisible;
end;

procedure TPowerPointPresentationProperties.Set_EnvelopeVisible(EnvelopeVisible: MsoTriState);
begin
  DefaultInterface.Set_EnvelopeVisible(EnvelopeVisible);
end;

function TPowerPointPresentationProperties.Get_VBASigned: MsoTriState;
begin
    Result := DefaultInterface.VBASigned;
end;

{$ENDIF}

class function CoOLECtrl.Create: OCXExtender;
begin
  Result := CreateComObject(CLASS_OLECtrl) as OCXExtender;
end;

class function CoOLECtrl.CreateRemote(const MachineName: string): OCXExtender;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_OLECtrl) as OCXExtender;
end;

procedure TOLECtrl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{91493446-5A91-11CF-8700-00AA0060263B}';
    IntfIID:   '{914934C0-5A91-11CF-8700-00AA0060263B}';
    EventIID:  '{914934C1-5A91-11CF-8700-00AA0060263B}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TOLECtrl.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as OCXExtender;
  end;
end;

procedure TOLECtrl.ConnectTo(svrIntf: OCXExtender);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TOLECtrl.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TOLECtrl.GetDefaultInterface: OCXExtender;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TOLECtrl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TOLECtrlProperties.Create(Self);
{$ENDIF}
end;

destructor TOLECtrl.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TOLECtrl.GetServerProperties: TOLECtrlProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TOLECtrl.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    -2147417888: if Assigned(FOnGotFocus) then
         FOnGotFocus(Self);
    -2147417887: if Assigned(FOnLostFocus) then
         FOnLostFocus(Self);
  end; {case DispID}
end;

function TOLECtrl.Get_Visible: WordBool;
begin
    Result := DefaultInterface.Visible;
end;

procedure TOLECtrl.Set_Visible(Visible: WordBool);
begin
  DefaultInterface.Set_Visible(Visible);
end;

function TOLECtrl.Get_Left: Single;
begin
    Result := DefaultInterface.Left;
end;

procedure TOLECtrl.Set_Left(Left: Single);
begin
  DefaultInterface.Set_Left(Left);
end;

function TOLECtrl.Get_Top: Single;
begin
    Result := DefaultInterface.Top;
end;

procedure TOLECtrl.Set_Top(Top: Single);
begin
  DefaultInterface.Set_Top(Top);
end;

function TOLECtrl.Get_Height: Single;
begin
    Result := DefaultInterface.Height;
end;

procedure TOLECtrl.Set_Height(Height: Single);
begin
  DefaultInterface.Set_Height(Height);
end;

function TOLECtrl.Get_Width: Single;
begin
    Result := DefaultInterface.Width;
end;

procedure TOLECtrl.Set_Width(Width: Single);
begin
  DefaultInterface.Set_Width(Width);
end;

function TOLECtrl.Get_ZOrderPosition: SYSINT;
begin
    Result := DefaultInterface.ZOrderPosition;
end;

function TOLECtrl.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

procedure TOLECtrl.Set_Name(const Name: WideString);
  { Warning: The property Name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Name := Name;
end;

function TOLECtrl.Get_AltHTML: WideString;
begin
    Result := DefaultInterface.AltHTML;
end;

procedure TOLECtrl.Set_AltHTML(const AltHTML: WideString);
  { Warning: The property AltHTML has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AltHTML := AltHTML;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TOLECtrlProperties.Create(AServer: TOLECtrl);
begin
  inherited Create;
  FServer := AServer;
end;

function TOLECtrlProperties.GetDefaultInterface: OCXExtender;
begin
  Result := FServer.DefaultInterface;
end;

function TOLECtrlProperties.Get_Visible: WordBool;
begin
    Result := DefaultInterface.Visible;
end;

procedure TOLECtrlProperties.Set_Visible(Visible: WordBool);
begin
  DefaultInterface.Set_Visible(Visible);
end;

function TOLECtrlProperties.Get_Left: Single;
begin
    Result := DefaultInterface.Left;
end;

procedure TOLECtrlProperties.Set_Left(Left: Single);
begin
  DefaultInterface.Set_Left(Left);
end;

function TOLECtrlProperties.Get_Top: Single;
begin
    Result := DefaultInterface.Top;
end;

procedure TOLECtrlProperties.Set_Top(Top: Single);
begin
  DefaultInterface.Set_Top(Top);
end;

function TOLECtrlProperties.Get_Height: Single;
begin
    Result := DefaultInterface.Height;
end;

procedure TOLECtrlProperties.Set_Height(Height: Single);
begin
  DefaultInterface.Set_Height(Height);
end;

function TOLECtrlProperties.Get_Width: Single;
begin
    Result := DefaultInterface.Width;
end;

procedure TOLECtrlProperties.Set_Width(Width: Single);
begin
  DefaultInterface.Set_Width(Width);
end;

function TOLECtrlProperties.Get_ZOrderPosition: SYSINT;
begin
    Result := DefaultInterface.ZOrderPosition;
end;

function TOLECtrlProperties.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

procedure TOLECtrlProperties.Set_Name(const Name: WideString);
  { Warning: The property Name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Name := Name;
end;

function TOLECtrlProperties.Get_AltHTML: WideString;
begin
    Result := DefaultInterface.AltHTML;
end;

procedure TOLECtrlProperties.Set_AltHTML(const AltHTML: WideString);
  { Warning: The property AltHTML has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.AltHTML := AltHTML;
end;

{$ENDIF}

class function CoPowerPointApplication.Create: _Application;
begin
  Result := CreateComObject(CLASS_PowerPointApplication) as _Application;
end;

class function CoPowerPointApplication.CreateRemote(const MachineName: string): _Application;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_PowerPointApplication) as _Application;
end;

procedure TPowerPointApplication.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{91493441-5A91-11CF-8700-00AA0060263B}';
    IntfIID:   '{91493442-5A91-11CF-8700-00AA0060263B}';
    EventIID:  '{914934C2-5A91-11CF-8700-00AA0060263B}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TPowerPointApplication.Connect;
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

procedure TPowerPointApplication.ConnectTo(svrIntf: _Application);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TPowerPointApplication.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    if FAutoQuit then
      Quit();
    FIntf := nil;
  end;
end;

function TPowerPointApplication.GetDefaultInterface: _Application;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TPowerPointApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TPowerPointApplicationProperties.Create(Self);
{$ENDIF}
end;

destructor TPowerPointApplication.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TPowerPointApplication.GetServerProperties: TPowerPointApplicationProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TPowerPointApplication.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    2001: if Assigned(FOnWindowSelectionChange) then
         FOnWindowSelectionChange(Self, IUnknown(TVarData(Params[0]).VPointer) as Selection {const Selection});
    2002: if Assigned(FOnWindowBeforeRightClick) then
         FOnWindowBeforeRightClick(Self,
                                   IUnknown(TVarData(Params[0]).VPointer) as Selection {const Selection},
                                   WordBool((TVarData(Params[1]).VPointer)^) {var WordBool});
    2003: if Assigned(FOnWindowBeforeDoubleClick) then
         FOnWindowBeforeDoubleClick(Self,
                                    IUnknown(TVarData(Params[0]).VPointer) as Selection {const Selection},
                                    WordBool((TVarData(Params[1]).VPointer)^) {var WordBool});
    2004: if Assigned(FOnPresentationClose) then
         FOnPresentationClose(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation {const PowerPointPresentation});
    2005: if Assigned(FOnPresentationSave) then
         FOnPresentationSave(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation {const PowerPointPresentation});
    2006: if Assigned(FOnPresentationOpen) then
         FOnPresentationOpen(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation {const PowerPointPresentation});
    2007: if Assigned(FOnNewPresentation) then
         FOnNewPresentation(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation {const PowerPointPresentation});
    2008: if Assigned(FOnPresentationNewSlide) then
         FOnPresentationNewSlide(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointSlide {const PowerPointSlide});
    2009: if Assigned(FOnWindowActivate) then
         FOnWindowActivate(Self,
                           IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation {const PowerPointPresentation},
                           IUnknown(TVarData(Params[1]).VPointer) as DocumentWindow {const DocumentWindow});
    2010: if Assigned(FOnWindowDeactivate) then
         FOnWindowDeactivate(Self,
                             IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation {const PowerPointPresentation},
                             IUnknown(TVarData(Params[1]).VPointer) as DocumentWindow {const DocumentWindow});
    2011: if Assigned(FOnSlideShowBegin) then
         FOnSlideShowBegin(Self, IUnknown(TVarData(Params[0]).VPointer) as SlideShowWindow {const SlideShowWindow});
    2012: if Assigned(FOnSlideShowNextBuild) then
         FOnSlideShowNextBuild(Self, IUnknown(TVarData(Params[0]).VPointer) as SlideShowWindow {const SlideShowWindow});
    2013: if Assigned(FOnSlideShowNextSlide) then
         FOnSlideShowNextSlide(Self, IUnknown(TVarData(Params[0]).VPointer) as SlideShowWindow {const SlideShowWindow});
    2014: if Assigned(FOnSlideShowEnd) then
         FOnSlideShowEnd(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation {const PowerPointPresentation});
    2015: if Assigned(FOnPresentationPrint) then
         FOnPresentationPrint(Self, IUnknown(TVarData(Params[0]).VPointer) as PowerPointPresentation {const PowerPointPresentation});
  end; {case DispID}
end;

function TPowerPointApplication.Get_Presentations: Presentations;
begin
    Result := DefaultInterface.Presentations;
end;

function TPowerPointApplication.Get_Windows: DocumentWindows;
begin
    Result := DefaultInterface.Windows;
end;

function TPowerPointApplication.Get_Dialogs: PPDialogs;
begin
    Result := DefaultInterface.Dialogs;
end;

function TPowerPointApplication.Get_ActiveWindow: DocumentWindow;
begin
    Result := DefaultInterface.ActiveWindow;
end;

function TPowerPointApplication.Get_ActivePresentation: PowerPointPresentation;
begin
    Result := DefaultInterface.ActivePresentation;
end;

function TPowerPointApplication.Get_SlideShowWindows: SlideShowWindows;
begin
    Result := DefaultInterface.SlideShowWindows;
end;

function TPowerPointApplication.Get_CommandBars: CommandBars;
begin
    Result := DefaultInterface.CommandBars;
end;

function TPowerPointApplication.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

function TPowerPointApplication.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TPowerPointApplication.Get_Caption: WideString;
begin
    Result := DefaultInterface.Caption;
end;

procedure TPowerPointApplication.Set_Caption(const Caption: WideString);
  { Warning: The property Caption has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Caption := Caption;
end;

function TPowerPointApplication.Get_Assistant: Assistant;
begin
    Result := DefaultInterface.Assistant;
end;

function TPowerPointApplication.Get_FileSearch: FileSearch;
begin
    Result := DefaultInterface.FileSearch;
end;

function TPowerPointApplication.Get_FileFind: IFind;
begin
    Result := DefaultInterface.FileFind;
end;

function TPowerPointApplication.Get_Build: WideString;
begin
    Result := DefaultInterface.Build;
end;

function TPowerPointApplication.Get_Version: WideString;
begin
    Result := DefaultInterface.Version;
end;

function TPowerPointApplication.Get_OperatingSystem: WideString;
begin
    Result := DefaultInterface.OperatingSystem;
end;

function TPowerPointApplication.Get_ActivePrinter: WideString;
begin
    Result := DefaultInterface.ActivePrinter;
end;

function TPowerPointApplication.Get_Creator: Integer;
begin
    Result := DefaultInterface.Creator;
end;

function TPowerPointApplication.Get_AddIns: AddIns;
begin
    Result := DefaultInterface.AddIns;
end;

function TPowerPointApplication.Get_VBE: VBE;
begin
    Result := DefaultInterface.VBE;
end;

function TPowerPointApplication.Get_Left: Single;
begin
    Result := DefaultInterface.Left;
end;

procedure TPowerPointApplication.Set_Left(Left: Single);
begin
  DefaultInterface.Set_Left(Left);
end;

function TPowerPointApplication.Get_Top: Single;
begin
    Result := DefaultInterface.Top;
end;

procedure TPowerPointApplication.Set_Top(Top: Single);
begin
  DefaultInterface.Set_Top(Top);
end;

function TPowerPointApplication.Get_Width: Single;
begin
    Result := DefaultInterface.Width;
end;

procedure TPowerPointApplication.Set_Width(Width: Single);
begin
  DefaultInterface.Set_Width(Width);
end;

function TPowerPointApplication.Get_Height: Single;
begin
    Result := DefaultInterface.Height;
end;

procedure TPowerPointApplication.Set_Height(Height: Single);
begin
  DefaultInterface.Set_Height(Height);
end;

function TPowerPointApplication.Get_WindowState: PpWindowState;
begin
    Result := DefaultInterface.WindowState;
end;

procedure TPowerPointApplication.Set_WindowState(WindowState: PpWindowState);
begin
  DefaultInterface.Set_WindowState(WindowState);
end;

function TPowerPointApplication.Get_Visible: MsoTriState;
begin
    Result := DefaultInterface.Visible;
end;

procedure TPowerPointApplication.Set_Visible(Visible: MsoTriState);
begin
  DefaultInterface.Set_Visible(Visible);
end;

function TPowerPointApplication.Get_Active: MsoTriState;
begin
    Result := DefaultInterface.Active;
end;

function TPowerPointApplication.Get_AnswerWizard: AnswerWizard;
begin
    Result := DefaultInterface.AnswerWizard;
end;

function TPowerPointApplication.Get_COMAddIns: COMAddIns;
begin
    Result := DefaultInterface.COMAddIns;
end;

function TPowerPointApplication.Get_ProductCode: WideString;
begin
    Result := DefaultInterface.ProductCode;
end;

function TPowerPointApplication.Get_DefaultWebOptions: DefaultWebOptions;
begin
    Result := DefaultInterface.DefaultWebOptions;
end;

function TPowerPointApplication.Get_LanguageSettings: LanguageSettings;
begin
    Result := DefaultInterface.LanguageSettings;
end;

function TPowerPointApplication.Get_MsoDebugOptions: MsoDebugOptions;
begin
    Result := DefaultInterface.MsoDebugOptions;
end;

function TPowerPointApplication.Get_ShowWindowsInTaskbar: MsoTriState;
begin
    Result := DefaultInterface.ShowWindowsInTaskbar;
end;

procedure TPowerPointApplication.Set_ShowWindowsInTaskbar(ShowWindowsInTaskbar: MsoTriState);
begin
  DefaultInterface.Set_ShowWindowsInTaskbar(ShowWindowsInTaskbar);
end;

function TPowerPointApplication.Get_Marker: Marker;
begin
    Result := DefaultInterface.Marker;
end;

function TPowerPointApplication.Get_FeatureInstall: MsoFeatureInstall;
begin
    Result := DefaultInterface.FeatureInstall;
end;

procedure TPowerPointApplication.Set_FeatureInstall(FeatureInstall: MsoFeatureInstall);
begin
  DefaultInterface.Set_FeatureInstall(FeatureInstall);
end;

procedure TPowerPointApplication.Help(const HelpFile: WideString; ContextID: SYSINT);
begin
  DefaultInterface.Help(HelpFile, ContextID);
end;

procedure TPowerPointApplication.Quit;
begin
  DefaultInterface.Quit;
end;

function TPowerPointApplication.Run(const MacroName: WideString; var safeArrayOfParams: PSafeArray): OleVariant;
begin
  Result := DefaultInterface.Run(MacroName, safeArrayOfParams);
end;

function TPowerPointApplication.FileDialog(Type_: PpFileDialogType): FileDialog;
begin
  Result := DefaultInterface.FileDialog(Type_);
end;

procedure TPowerPointApplication.Activate;
begin
  DefaultInterface.Activate;
end;

function TPowerPointApplication.GetOptionFlag(Option: Integer; Persist: WordBool): WordBool;
begin
  Result := DefaultInterface.GetOptionFlag(Option, Persist);
end;

procedure TPowerPointApplication.SetOptionFlag(Option: Integer; State: WordBool; Persist: WordBool);
begin
  DefaultInterface.SetOptionFlag(Option, State, Persist);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TPowerPointApplicationProperties.Create(AServer: TPowerPointApplication);
begin
  inherited Create;
  FServer := AServer;
end;

function TPowerPointApplicationProperties.GetDefaultInterface: _Application;
begin
  Result := FServer.DefaultInterface;
end;

function TPowerPointApplicationProperties.Get_Presentations: Presentations;
begin
    Result := DefaultInterface.Presentations;
end;

function TPowerPointApplicationProperties.Get_Windows: DocumentWindows;
begin
    Result := DefaultInterface.Windows;
end;

function TPowerPointApplicationProperties.Get_Dialogs: PPDialogs;
begin
    Result := DefaultInterface.Dialogs;
end;

function TPowerPointApplicationProperties.Get_ActiveWindow: DocumentWindow;
begin
    Result := DefaultInterface.ActiveWindow;
end;

function TPowerPointApplicationProperties.Get_ActivePresentation: PowerPointPresentation;
begin
    Result := DefaultInterface.ActivePresentation;
end;

function TPowerPointApplicationProperties.Get_SlideShowWindows: SlideShowWindows;
begin
    Result := DefaultInterface.SlideShowWindows;
end;

function TPowerPointApplicationProperties.Get_CommandBars: CommandBars;
begin
    Result := DefaultInterface.CommandBars;
end;

function TPowerPointApplicationProperties.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

function TPowerPointApplicationProperties.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TPowerPointApplicationProperties.Get_Caption: WideString;
begin
    Result := DefaultInterface.Caption;
end;

procedure TPowerPointApplicationProperties.Set_Caption(const Caption: WideString);
  { Warning: The property Caption has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Caption := Caption;
end;

function TPowerPointApplicationProperties.Get_Assistant: Assistant;
begin
    Result := DefaultInterface.Assistant;
end;

function TPowerPointApplicationProperties.Get_FileSearch: FileSearch;
begin
    Result := DefaultInterface.FileSearch;
end;

function TPowerPointApplicationProperties.Get_FileFind: IFind;
begin
    Result := DefaultInterface.FileFind;
end;

function TPowerPointApplicationProperties.Get_Build: WideString;
begin
    Result := DefaultInterface.Build;
end;

function TPowerPointApplicationProperties.Get_Version: WideString;
begin
    Result := DefaultInterface.Version;
end;

function TPowerPointApplicationProperties.Get_OperatingSystem: WideString;
begin
    Result := DefaultInterface.OperatingSystem;
end;

function TPowerPointApplicationProperties.Get_ActivePrinter: WideString;
begin
    Result := DefaultInterface.ActivePrinter;
end;

function TPowerPointApplicationProperties.Get_Creator: Integer;
begin
    Result := DefaultInterface.Creator;
end;

function TPowerPointApplicationProperties.Get_AddIns: AddIns;
begin
    Result := DefaultInterface.AddIns;
end;

function TPowerPointApplicationProperties.Get_VBE: VBE;
begin
    Result := DefaultInterface.VBE;
end;

function TPowerPointApplicationProperties.Get_Left: Single;
begin
    Result := DefaultInterface.Left;
end;

procedure TPowerPointApplicationProperties.Set_Left(Left: Single);
begin
  DefaultInterface.Set_Left(Left);
end;

function TPowerPointApplicationProperties.Get_Top: Single;
begin
    Result := DefaultInterface.Top;
end;

procedure TPowerPointApplicationProperties.Set_Top(Top: Single);
begin
  DefaultInterface.Set_Top(Top);
end;

function TPowerPointApplicationProperties.Get_Width: Single;
begin
    Result := DefaultInterface.Width;
end;

procedure TPowerPointApplicationProperties.Set_Width(Width: Single);
begin
  DefaultInterface.Set_Width(Width);
end;

function TPowerPointApplicationProperties.Get_Height: Single;
begin
    Result := DefaultInterface.Height;
end;

procedure TPowerPointApplicationProperties.Set_Height(Height: Single);
begin
  DefaultInterface.Set_Height(Height);
end;

function TPowerPointApplicationProperties.Get_WindowState: PpWindowState;
begin
    Result := DefaultInterface.WindowState;
end;

procedure TPowerPointApplicationProperties.Set_WindowState(WindowState: PpWindowState);
begin
  DefaultInterface.Set_WindowState(WindowState);
end;

function TPowerPointApplicationProperties.Get_Visible: MsoTriState;
begin
    Result := DefaultInterface.Visible;
end;

procedure TPowerPointApplicationProperties.Set_Visible(Visible: MsoTriState);
begin
  DefaultInterface.Set_Visible(Visible);
end;

function TPowerPointApplicationProperties.Get_Active: MsoTriState;
begin
    Result := DefaultInterface.Active;
end;

function TPowerPointApplicationProperties.Get_AnswerWizard: AnswerWizard;
begin
    Result := DefaultInterface.AnswerWizard;
end;

function TPowerPointApplicationProperties.Get_COMAddIns: COMAddIns;
begin
    Result := DefaultInterface.COMAddIns;
end;

function TPowerPointApplicationProperties.Get_ProductCode: WideString;
begin
    Result := DefaultInterface.ProductCode;
end;

function TPowerPointApplicationProperties.Get_DefaultWebOptions: DefaultWebOptions;
begin
    Result := DefaultInterface.DefaultWebOptions;
end;

function TPowerPointApplicationProperties.Get_LanguageSettings: LanguageSettings;
begin
    Result := DefaultInterface.LanguageSettings;
end;

function TPowerPointApplicationProperties.Get_MsoDebugOptions: MsoDebugOptions;
begin
    Result := DefaultInterface.MsoDebugOptions;
end;

function TPowerPointApplicationProperties.Get_ShowWindowsInTaskbar: MsoTriState;
begin
    Result := DefaultInterface.ShowWindowsInTaskbar;
end;

procedure TPowerPointApplicationProperties.Set_ShowWindowsInTaskbar(ShowWindowsInTaskbar: MsoTriState);
begin
  DefaultInterface.Set_ShowWindowsInTaskbar(ShowWindowsInTaskbar);
end;

function TPowerPointApplicationProperties.Get_Marker: Marker;
begin
    Result := DefaultInterface.Marker;
end;

function TPowerPointApplicationProperties.Get_FeatureInstall: MsoFeatureInstall;
begin
    Result := DefaultInterface.FeatureInstall;
end;

procedure TPowerPointApplicationProperties.Set_FeatureInstall(FeatureInstall: MsoFeatureInstall);
begin
  DefaultInterface.Set_FeatureInstall(FeatureInstall);
end;

{$ENDIF}

class function CoMaster.Create: _Master;
begin
  Result := CreateComObject(CLASS_Master) as _Master;
end;

class function CoMaster.CreateRemote(const MachineName: string): _Master;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Master) as _Master;
end;

procedure TMaster.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{91493447-5A91-11CF-8700-00AA0060263B}';
    IntfIID:   '{9149346C-5A91-11CF-8700-00AA0060263B}';
    EventIID:  '{914934D2-5A91-11CF-8700-00AA0060263B}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMaster.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as _Master;
  end;
end;

procedure TMaster.ConnectTo(svrIntf: _Master);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TMaster.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TMaster.GetDefaultInterface: _Master;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TMaster.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMasterProperties.Create(Self);
{$ENDIF}
end;

destructor TMaster.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMaster.GetServerProperties: TMasterProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMaster.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
  end; {case DispID}
end;

function TMaster.Get_Application: PowerPointApplication;
begin
    Result := DefaultInterface.Application;
end;

function TMaster.Get_Parent: IDispatch;
begin
    Result := DefaultInterface.Parent;
end;

function TMaster.Get_Shapes: Shapes;
begin
    Result := DefaultInterface.Shapes;
end;

function TMaster.Get_HeadersFooters: HeadersFooters;
begin
    Result := DefaultInterface.HeadersFooters;
end;

function TMaster.Get_ColorScheme: ColorScheme;
begin
    Result := DefaultInterface.ColorScheme;
end;

procedure TMaster.Set_ColorScheme(const ColorScheme: ColorScheme);
begin
  DefaultInterface.Set_ColorScheme(ColorScheme);
end;

function TMaster.Get_Background: ShapeRange;
begin
    Result := DefaultInterface.Background;
end;

function TMaster.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

procedure TMaster.Set_Name(const Name: WideString);
  { Warning: The property Name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Name := Name;
end;

function TMaster.Get_Height: Single;
begin
    Result := DefaultInterface.Height;
end;

function TMaster.Get_Width: Single;
begin
    Result := DefaultInterface.Width;
end;

function TMaster.Get_TextStyles: TextStyles;
begin
    Result := DefaultInterface.TextStyles;
end;

function TMaster.Get_Hyperlinks: Hyperlinks;
begin
    Result := DefaultInterface.Hyperlinks;
end;

function TMaster.Get_Scripts: Scripts;
begin
    Result := DefaultInterface.Scripts;
end;

procedure TMaster.Delete;
begin
  DefaultInterface.Delete;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMasterProperties.Create(AServer: TMaster);
begin
  inherited Create;
  FServer := AServer;
end;

function TMasterProperties.GetDefaultInterface: _Master;
begin
  Result := FServer.DefaultInterface;
end;

function TMasterProperties.Get_Application: PowerPointApplication;
begin
    Result := DefaultInterface.Application;
end;

function TMasterProperties.Get_Parent: IDispatch;
begin
    Result := DefaultInterface.Parent;
end;

function TMasterProperties.Get_Shapes: Shapes;
begin
    Result := DefaultInterface.Shapes;
end;

function TMasterProperties.Get_HeadersFooters: HeadersFooters;
begin
    Result := DefaultInterface.HeadersFooters;
end;

function TMasterProperties.Get_ColorScheme: ColorScheme;
begin
    Result := DefaultInterface.ColorScheme;
end;

procedure TMasterProperties.Set_ColorScheme(const ColorScheme: ColorScheme);
begin
  DefaultInterface.Set_ColorScheme(ColorScheme);
end;

function TMasterProperties.Get_Background: ShapeRange;
begin
    Result := DefaultInterface.Background;
end;

function TMasterProperties.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

procedure TMasterProperties.Set_Name(const Name: WideString);
  { Warning: The property Name has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Name := Name;
end;

function TMasterProperties.Get_Height: Single;
begin
    Result := DefaultInterface.Height;
end;

function TMasterProperties.Get_Width: Single;
begin
    Result := DefaultInterface.Width;
end;

function TMasterProperties.Get_TextStyles: TextStyles;
begin
    Result := DefaultInterface.TextStyles;
end;

function TMasterProperties.Get_Hyperlinks: Hyperlinks;
begin
    Result := DefaultInterface.Hyperlinks;
end;

function TMasterProperties.Get_Scripts: Scripts;
begin
    Result := DefaultInterface.Scripts;
end;

{$ENDIF}

end.
