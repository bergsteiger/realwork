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

unit adxMSFormsControls;

{$I adxDefs.inc}

interface

uses Windows, ActiveX, Classes, Graphics, OleServer, 
{$IFDEF DELPHI_7_UP}
  MSForms2000;
{$ELSE}
  MSForms97;
{$ENDIF}

type
  TBeforeDragOverEvent = procedure(ASender: TObject; const Cancel: ReturnBoolean;
                                                     const Data: DataObject;
                                                     X: Single; Y: Single;
                                                     DragState: fmDragState;
                                                     const Effect: ReturnEffect;
                                                     Shift: Smallint) of object;
  TBeforeDropOrPasteEvent = procedure(ASender: TObject; const Cancel: ReturnBoolean;
                                                        Action: fmAction;
                                                        const Data: DataObject;
                                                        X: Single; Y: Single;
                                                        const Effect: ReturnEffect;
                                                        Shift: Smallint) of object;
  TDblClickEvent = procedure(ASender: TObject; const Cancel: ReturnBoolean) of object;
  TErrorEvent = procedure(ASender: TObject; Number: Smallint;
                                            const Description: ReturnString;
                                            SCode: Integer;
                                            const Source: WideString;
                                            const HelpFile: WideString;
                                            HelpContext: Integer;
                                            const CancelDisplay: ReturnBoolean) of object;
  TKeyDownEvent = procedure(ASender: TObject; const KeyCode: ReturnInteger;
                                              Shift: Smallint) of object;
  TKeyPressEvent = procedure(ASender: TObject; const KeyAscii: ReturnInteger) of object;
  TKeyUpEvent = procedure(ASender: TObject; const KeyCode: ReturnInteger;
                                            Shift: Smallint) of object;
  TMouseDownEvent = procedure(ASender: TObject; Button: Smallint; Shift: Smallint;
                                                X: Single; Y: Single) of object;
  TMouseMoveEvent = procedure(ASender: TObject; Button: Smallint; Shift: Smallint;
                                                X: Single; Y: Single) of object;
  TMouseUpEvent = procedure(ASender: TObject; Button: Smallint; Shift: Smallint;
                                              X: Single; Y: Single) of object;

	TadxNativeMSFControl = (msfUnknown, msfCheckBox, msfComboBox, msfCommandButton,
    msfImage, msfLabel, msfListBox, msfOptionButton, msfScrollBar, msfSpinButton,
    msfTextBox, msfToggleButton);

  TadxMSFormsControl = class(TOleServer)
  private
    FControlName: string;
    FOnConnect: TNotifyEvent;
    function GetControlType: TadxNativeMSFControl; virtual;
    function GetConnected: boolean; virtual; abstract;
  protected
    function GetVersionIndependentProgID: string; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ConnectTo(svrIntf: IDispatch); virtual; abstract;
    property ControlType: TadxNativeMSFControl read GetControlType;
    property Connected: boolean read GetConnected;
  published
    property ControlName: string read FControlName write FControlName;
    property OnConnect: TNotifyEvent read FOnConnect write FOnConnect;
  end;

  TadxMSFormsCheckBox = class(TadxMSFormsControl)
  private
    FIntf: IMdcCheckBox;
    FOnBeforeDragOver: TBeforeDragOverEvent;
    FOnBeforeDropOrPaste: TBeforeDropOrPasteEvent;
    FOnChange: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TDblClickEvent;
    FOnError: TErrorEvent;
    FOnKeyDown: TKeyDownEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyUpEvent;
    FOnMouseDown: TMouseDownEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseUpEvent;
    function GetDefaultInterface: IMdcCheckBox;
    function GetControlType: TadxNativeMSFControl; override;
    function GetConnected: boolean; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure Set_Accelerator(const Accelerator: WideString);
    function Get_Accelerator: WideString;
    procedure Set_Alignment(Alignment: fmAlignment);
    function Get_Alignment: fmAlignment;
    procedure Set_AutoSize(AutoSize: WordBool);
    function Get_AutoSize: WordBool;
    procedure Set_BackColor(BackColor: OLE_COLOR);
    function Get_BackColor: OLE_COLOR;
    procedure Set_BackStyle(BackStyle: fmBackStyle);
    function Get_BackStyle: fmBackStyle;
    procedure Set_BordersSuppress(BordersSuppress: WordBool);
    function Get_BordersSuppress: WordBool;
    procedure Set_Caption(const Caption: WideString);
    function Get_Caption: WideString;
    procedure Set_Enabled(Enabled: WordBool);
    function Get_Enabled: WordBool;
    procedure Set__Font_Reserved(const Param1: IFontDisp);
    procedure _Set_Font(const Font: IFontDisp);
    function Get_Font: IFontDisp;
    procedure Set_FontBold(FontBold: WordBool);
    function Get_FontBold: WordBool;
    procedure Set_FontItalic(FontItalic: WordBool);
    function Get_FontItalic: WordBool;
    procedure Set_FontName(const FontName: WideString);
    function Get_FontName: WideString;
    procedure Set_FontSize(FontSize: Currency);
    function Get_FontSize: Currency;
    procedure Set_FontStrikethru(FontStrikethru: WordBool);
    function Get_FontStrikethru: WordBool;
    procedure Set_FontUnderline(FontUnderline: WordBool);
    function Get_FontUnderline: WordBool;
    procedure Set_FontWeight(FontWeight: Smallint);
    function Get_FontWeight: Smallint;
    procedure Set_ForeColor(ForeColor: OLE_COLOR);
    function Get_ForeColor: OLE_COLOR;
    procedure Set_Locked(Locked: WordBool);
    function Get_Locked: WordBool;
    procedure Set_MouseIcon(const MouseIcon: IPictureDisp);
    procedure _Set_MouseIcon(const MouseIcon: IPictureDisp);
    function Get_MouseIcon: IPictureDisp;
    procedure Set_MousePointer(MousePointer: fmMousePointer);
    function Get_MousePointer: fmMousePointer;
    procedure Set_MultiSelect(MultiSelect: fmMultiSelect);
    function Get_MultiSelect: fmMultiSelect;
    procedure Set_Picture(const Picture: IPictureDisp);
    procedure _Set_Picture(const Picture: IPictureDisp);
    function Get_Picture: IPictureDisp;
    procedure Set_PicturePosition(PicPos: fmPicturePosition);
    function Get_PicturePosition: fmPicturePosition;
    procedure Set_SpecialEffect(SpecialEffect: fmButtonEffect);
    function Get_SpecialEffect: fmButtonEffect;
    procedure Set_TripleState(TripleState: WordBool);
    function Get_TripleState: WordBool;
    function Get_Valid: WordBool;
    procedure Set_Value(var Value: OleVariant);
    procedure Set_Value2(Value: OleVariant);
    function Get_Value: OleVariant;
    procedure Set_WordWrap(WordWrap: WordBool);
    function Get_WordWrap: WordBool;
    function Get_DisplayStyle: fmDisplayStyle;
    procedure Set_GroupName(const GroupName: WideString);
    function Get_GroupName: WideString;
{$IFNDEF ADX_VCL6}
    procedure Set_TextAlign(TextAlign: fmTextAlign);
    function Get_TextAlign: fmTextAlign;
{$ENDIF}
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;
    
    property DefaultInterface: IMdcCheckBox read GetDefaultInterface;

    property Accelerator: WideString read Get_Accelerator write Set_Accelerator;
    property Alignment: fmAlignment read Get_Alignment write Set_Alignment;
    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property BackStyle: fmBackStyle read Get_BackStyle write Set_BackStyle;
    property BordersSuppress: WordBool read Get_BordersSuppress write Set_BordersSuppress;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property _Font_Reserved: IFontDisp write Set__Font_Reserved;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property FontBold: WordBool read Get_FontBold write Set_FontBold;
    property FontItalic: WordBool read Get_FontItalic write Set_FontItalic;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: Currency read Get_FontSize write Set_FontSize;
    property FontStrikethru: WordBool read Get_FontStrikethru write Set_FontStrikethru;
    property FontUnderline: WordBool read Get_FontUnderline write Set_FontUnderline;
    property FontWeight: Smallint read Get_FontWeight write Set_FontWeight;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property Locked: WordBool read Get_Locked write Set_Locked;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: fmMousePointer read Get_MousePointer write Set_MousePointer;
    property MultiSelect: fmMultiSelect read Get_MultiSelect write Set_MultiSelect;
    property Picture: IPictureDisp read Get_Picture write Set_Picture;
    property PicturePosition: fmPicturePosition read Get_PicturePosition write Set_PicturePosition;
    property SpecialEffect: fmButtonEffect read Get_SpecialEffect write Set_SpecialEffect;
    property TripleState: WordBool read Get_TripleState write Set_TripleState;
    property Valid: WordBool read Get_Valid;
    property Value: OleVariant read Get_Value write Set_Value2;
    property WordWrap: WordBool read Get_WordWrap write Set_WordWrap;
    property DisplayStyle: fmDisplayStyle read Get_DisplayStyle;
    property GroupName: WideString read Get_GroupName write Set_GroupName;
{$IFNDEF ADX_VCL6}
    property TextAlign: fmTextAlign read Get_TextAlign write Set_TextAlign;
{$ENDIF}
  published
    property OnBeforeDragOver: TBeforeDragOverEvent read FOnBeforeDragOver write FOnBeforeDragOver;
    property OnBeforeDropOrPaste: TBeforeDropOrPasteEvent read FOnBeforeDropOrPaste write FOnBeforeDropOrPaste;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TDblClickEvent read FOnDblClick write FOnDblClick;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnKeyDown: TKeyDownEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyUpEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TMouseDownEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseUpEvent read FOnMouseUp write FOnMouseUp;
  end;

  TadxMSFormsComboBox = class(TadxMSFormsControl)
  private
    FIntf: IMdcCombo;
    FOnBeforeDragOver: TBeforeDragOverEvent;
    FOnBeforeDropOrPaste: TBeforeDropOrPasteEvent;
    FOnChange: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TDblClickEvent;
    FOnDropButtonClick: TNotifyEvent;
    FOnError: TErrorEvent;
    FOnKeyDown: TKeyDownEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyUpEvent;
    FOnMouseDown: TMouseDownEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseUpEvent;
    function GetDefaultInterface: IMdcCombo;
    function GetControlType: TadxNativeMSFControl; override;
    function GetConnected: boolean; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure Set_AutoSize(AutoSize: WordBool);
    function Get_AutoSize: WordBool;
    procedure Set_AutoTab(AutoTab: WordBool);
    function Get_AutoTab: WordBool;
    procedure Set_AutoWordSelect(AutoWordSelect: WordBool);
    function Get_AutoWordSelect: WordBool;
    procedure Set_BackColor(BackColor: OLE_COLOR);
    function Get_BackColor: OLE_COLOR;
    procedure Set_BackStyle(BackStyle: fmBackStyle);
    function Get_BackStyle: fmBackStyle;
    procedure Set_BorderColor(BorderColor: OLE_COLOR);
    function Get_BorderColor: OLE_COLOR;
    procedure Set_BorderStyle(BorderStyle: fmBorderStyle);
    function Get_BorderStyle: fmBorderStyle;
    procedure Set_BordersSuppress(BordersSuppress: WordBool);
    function Get_BordersSuppress: WordBool;
    procedure Set_BoundColumn(var BoundColumn: OleVariant);
    procedure Set_BoundColumn2(BoundColumn: OleVariant);
    function Get_BoundColumn: OleVariant;
    function Get_CanPaste: WordBool;
    procedure Set_ColumnCount(ColumnCount: Integer);
    function Get_ColumnCount: Integer;
    procedure Set_ColumnHeads(ColumnHeads: WordBool);
    function Get_ColumnHeads: WordBool;
    procedure Set_ColumnWidths(const ColumnWidths: WideString);
    function Get_ColumnWidths: WideString;
    function Get_CurTargetX: Integer;
    function Get_CurTargetY: Integer;
    procedure Set_CurX(CurX: Integer);
    function Get_CurX: Integer;
    procedure Set_DropButtonStyle(DropButtonStyle: fmDropButtonStyle);
    function Get_DropButtonStyle: fmDropButtonStyle;
    procedure Set_Enabled(Enabled: WordBool);
    function Get_Enabled: WordBool;
    procedure Set__Font_Reserved(const Param1: IFontDisp);
    procedure _Set_Font(const Font: IFontDisp);
    function Get_Font: IFontDisp;
    procedure Set_FontBold(FontBold: WordBool);
    function Get_FontBold: WordBool;
    procedure Set_FontItalic(FontItalic: WordBool);
    function Get_FontItalic: WordBool;
    procedure Set_FontName(const FontName: WideString);
    function Get_FontName: WideString;
    procedure Set_FontSize(FontSize: Currency);
    function Get_FontSize: Currency;
    procedure Set_FontStrikethru(FontStrikethru: WordBool);
    function Get_FontStrikethru: WordBool;
    procedure Set_FontUnderline(FontUnderline: WordBool);
    function Get_FontUnderline: WordBool;
    procedure Set_FontWeight(FontWeight: Smallint);
    function Get_FontWeight: Smallint;
    procedure Set_ForeColor(ForeColor: OLE_COLOR);
    function Get_ForeColor: OLE_COLOR;
    procedure Set_HideSelection(HideSelection: WordBool);
    function Get_HideSelection: WordBool;
    function Get_LineCount: Integer;
    function Get_ListCount: Integer;
    procedure Set_ListCursor(const ListCursor: PIROWSET);
    function Get_ListCursor: PIROWSET;
    procedure Set_ListIndex(var ListIndex: OleVariant);
    procedure Set_ListIndex2(ListIndex: OleVariant);
    function Get_ListIndex: OleVariant;
    procedure Set_ListRows(ListRows: Integer);
    function Get_ListRows: Integer;
    procedure Set_ListStyle(ListStyle: fmListStyle);
    function Get_ListStyle: fmListStyle;
    procedure Set_ListWidth(var ListWidth: OleVariant);
    procedure Set_ListWidth2(ListWidth: OleVariant);
    function Get_ListWidth: OleVariant;
    procedure Set_Locked(Locked: WordBool);
    function Get_Locked: WordBool;
    procedure Set_MatchEntry(MatchEntry: fmMatchEntry);
    function Get_MatchEntry: fmMatchEntry;
    function Get_MatchFound: WordBool;
    procedure Set_MatchRequired(MatchRequired: WordBool);
    function Get_MatchRequired: WordBool;
    procedure Set_MaxLength(MaxLength: Integer);
    function Get_MaxLength: Integer;
    procedure Set_MouseIcon(const MouseIcon: IPictureDisp);
    procedure _Set_MouseIcon(const MouseIcon: IPictureDisp);
    function Get_MouseIcon: IPictureDisp;
    procedure Set_MousePointer(MousePointer: fmMousePointer);
    function Get_MousePointer: fmMousePointer;
    procedure Set_SelectionMargin(SelectionMargin: WordBool);
    function Get_SelectionMargin: WordBool;
    procedure Set_SelLength(SelLength: Integer);
    function Get_SelLength: Integer;
    procedure Set_SelStart(SelStart: Integer);
    function Get_SelStart: Integer;
    procedure Set_SelText(const SelText: WideString);
    function Get_SelText: WideString;
    procedure Set_ShowDropButtonWhen(ShowDropButtonWhen: fmShowDropButtonWhen);
    function Get_ShowDropButtonWhen: fmShowDropButtonWhen;
    procedure Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
    function Get_SpecialEffect: fmSpecialEffect;
    procedure Set_Style(Style: fmStyle);
    function Get_Style: fmStyle;
    procedure Set_Text(const Text: WideString);
    function Get_Text: WideString;
    procedure Set_TextAlign(TextAlign: fmTextAlign);
    function Get_TextAlign: fmTextAlign;
    procedure Set_TextColumn(var TextColumn: OleVariant);
    procedure Set_TextColumn2(TextColumn: OleVariant);
    function Get_TextColumn: OleVariant;
    function Get_TextLength: Integer;
    procedure Set_TopIndex(var TopIndex: OleVariant);
    procedure Set_TopIndex2(TopIndex: OleVariant);
    function Get_TopIndex: OleVariant;
    function Get_Valid: WordBool;
    procedure Set_Value(var Value: OleVariant);
    procedure Set_Value2(Value: OleVariant);
    function Get_Value: OleVariant;
    function Get_Column(var pvargColumn: OleVariant; var pvargIndex: OleVariant): OleVariant;
    procedure Set_Column(var pvargColumn: OleVariant; var pvargIndex: OleVariant;
                         var pvargValue: OleVariant);
    procedure Set_Column2(var pvargColumn: OleVariant; var pvargIndex: OleVariant;
                          pvargValue: OleVariant);
    function Get_List(var pvargIndex: OleVariant; var pvargColumn: OleVariant): OleVariant;
    procedure Set_List(var pvargIndex: OleVariant; var pvargColumn: OleVariant;
                       var pvargValue: OleVariant);
    procedure Set_List2(var pvargIndex: OleVariant; var pvargColumn: OleVariant;
                        pvargValue: OleVariant);
    procedure Set_IMEMode(IMEMode: fmIMEMode);
    function Get_IMEMode: fmIMEMode;
    procedure Set_EnterFieldBehavior(EnterFieldBehavior: fmEnterFieldBehavior);
    function Get_EnterFieldBehavior: fmEnterFieldBehavior;
    procedure Set_DragBehavior(DragBehavior: fmDragBehavior);
    function Get_DragBehavior: fmDragBehavior;
    function Get_DisplayStyle: fmDisplayStyle;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    procedure AddItem(var pvargItem: OleVariant; var pvargIndex: OleVariant);
    procedure Clear;
    procedure DropDown;
    procedure RemoveItem(var pvargIndex: OleVariant);
    procedure Copy;
    procedure Cut;
    procedure Paste;

    property DefaultInterface: IMdcCombo read GetDefaultInterface;

    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property AutoTab: WordBool read Get_AutoTab write Set_AutoTab;
    property AutoWordSelect: WordBool read Get_AutoWordSelect write Set_AutoWordSelect;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property BackStyle: fmBackStyle read Get_BackStyle write Set_BackStyle;
    property BorderColor: OLE_COLOR read Get_BorderColor write Set_BorderColor;
    property BorderStyle: fmBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property BordersSuppress: WordBool read Get_BordersSuppress write Set_BordersSuppress;
    property BoundColumn: OleVariant read Get_BoundColumn write Set_BoundColumn2;
    property CanPaste: WordBool read Get_CanPaste;
    property ColumnCount: Integer read Get_ColumnCount write Set_ColumnCount;
    property ColumnHeads: WordBool read Get_ColumnHeads write Set_ColumnHeads;
    property ColumnWidths: WideString read Get_ColumnWidths write Set_ColumnWidths;
    property CurTargetX: Integer read Get_CurTargetX;
    property CurTargetY: Integer read Get_CurTargetY;
    property CurX: Integer read Get_CurX write Set_CurX;
    property DropButtonStyle: fmDropButtonStyle read Get_DropButtonStyle write Set_DropButtonStyle;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property _Font_Reserved: IFontDisp write Set__Font_Reserved;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property FontBold: WordBool read Get_FontBold write Set_FontBold;
    property FontItalic: WordBool read Get_FontItalic write Set_FontItalic;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: Currency read Get_FontSize write Set_FontSize;
    property FontStrikethru: WordBool read Get_FontStrikethru write Set_FontStrikethru;
    property FontUnderline: WordBool read Get_FontUnderline write Set_FontUnderline;
    property FontWeight: Smallint read Get_FontWeight write Set_FontWeight;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property HideSelection: WordBool read Get_HideSelection write Set_HideSelection;
    property LineCount: Integer read Get_LineCount;
    property ListCount: Integer read Get_ListCount;
    property ListCursor: PIROWSET read Get_ListCursor write Set_ListCursor;
    property ListIndex: OleVariant read Get_ListIndex write Set_ListIndex2;
    property ListRows: Integer read Get_ListRows write Set_ListRows;
    property ListStyle: fmListStyle read Get_ListStyle write Set_ListStyle;
    property ListWidth: OleVariant read Get_ListWidth write Set_ListWidth2;
    property Locked: WordBool read Get_Locked write Set_Locked;
    property MatchEntry: fmMatchEntry read Get_MatchEntry write Set_MatchEntry;
    property MatchFound: WordBool read Get_MatchFound;
    property MatchRequired: WordBool read Get_MatchRequired write Set_MatchRequired;
    property MaxLength: Integer read Get_MaxLength write Set_MaxLength;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: fmMousePointer read Get_MousePointer write Set_MousePointer;
    property SelectionMargin: WordBool read Get_SelectionMargin write Set_SelectionMargin;
    property SelLength: Integer read Get_SelLength write Set_SelLength;
    property SelStart: Integer read Get_SelStart write Set_SelStart;
    property SelText: WideString read Get_SelText write Set_SelText;
    property ShowDropButtonWhen: fmShowDropButtonWhen read Get_ShowDropButtonWhen write Set_ShowDropButtonWhen;
    property SpecialEffect: fmSpecialEffect read Get_SpecialEffect write Set_SpecialEffect;
    property Style: fmStyle read Get_Style write Set_Style;
    property Text: WideString read Get_Text write Set_Text;
    property TextAlign: fmTextAlign read Get_TextAlign write Set_TextAlign;
    property TextColumn: OleVariant read Get_TextColumn write Set_TextColumn2;
    property TextLength: Integer read Get_TextLength;
    property TopIndex: OleVariant read Get_TopIndex write Set_TopIndex2;
    property Valid: WordBool read Get_Valid;
    property Value: OleVariant read Get_Value write Set_Value2;
    property Column[var pvargColumn: OleVariant; var pvargIndex: OleVariant]: OleVariant read Get_Column write Set_Column2;
    property List[var pvargIndex: OleVariant; var pvargColumn: OleVariant]: OleVariant read Get_List write Set_List2;
    property IMEMode: fmIMEMode read Get_IMEMode write Set_IMEMode;
    property EnterFieldBehavior: fmEnterFieldBehavior read Get_EnterFieldBehavior write Set_EnterFieldBehavior;
    property DragBehavior: fmDragBehavior read Get_DragBehavior write Set_DragBehavior;
    property DisplayStyle: fmDisplayStyle read Get_DisplayStyle;
  published
    property OnBeforeDragOver: TBeforeDragOverEvent read FOnBeforeDragOver write FOnBeforeDragOver;
    property OnBeforeDropOrPaste: TBeforeDropOrPasteEvent read FOnBeforeDropOrPaste write FOnBeforeDropOrPaste;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TDblClickEvent read FOnDblClick write FOnDblClick;
    property OnDropButtonClick: TNotifyEvent read FOnDropButtonClick write FOnDropButtonClick;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnKeyDown: TKeyDownEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyUpEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TMouseDownEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseUpEvent read FOnMouseUp write FOnMouseUp;
  end;

  TadxMSFormsCommandButton = class(TadxMSFormsControl)
  private
    FIntf: ICommandButton;
    FOnBeforeDragOver: TBeforeDragOverEvent;
    FOnBeforeDropOrPaste: TBeforeDropOrPasteEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TDblClickEvent;
    FOnError: TErrorEvent;
    FOnKeyDown: TKeyDownEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyUpEvent;
    FOnMouseDown: TMouseDownEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseUpEvent;
    function GetDefaultInterface: ICommandButton;
    function GetControlType: TadxNativeMSFControl; override;
    function GetConnected: boolean; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure Set_AutoSize(fvbAutoSize: WordBool);
    function Get_AutoSize: WordBool;
    procedure Set_BackColor(BackColor: OLE_COLOR);
    function Get_BackColor: OLE_COLOR;
    procedure Set_BackStyle(BackStyle: fmBackStyle);
    function Get_BackStyle: fmBackStyle;
    procedure Set_Caption(const bstrCaption: WideString);
    function Get_Caption: WideString;
    procedure Set_Enabled(fEnabled: WordBool);
    function Get_Enabled: WordBool;
    procedure Set__Font_Reserved(const Param1: IFontDisp);
    procedure _Set_Font(const Font: IFontDisp);
    function Get_Font: IFontDisp;
    procedure Set_FontBold(FontBold: WordBool);
    function Get_FontBold: WordBool;
    procedure Set_FontItalic(FontItalic: WordBool);
    function Get_FontItalic: WordBool;
    procedure Set_FontName(const FontName: WideString);
    function Get_FontName: WideString;
    procedure Set_FontSize(FontSize: Currency);
    function Get_FontSize: Currency;
    procedure Set_FontStrikethru(FontStrikethru: WordBool);
    function Get_FontStrikethru: WordBool;
    procedure Set_FontUnderline(FontUnderline: WordBool);
    function Get_FontUnderline: WordBool;
    procedure Set_ForeColor(ForeColor: OLE_COLOR);
    function Get_ForeColor: OLE_COLOR;
    procedure Set_TakeFocusOnClick(TakeFocusOnClick: WordBool);
    function Get_TakeFocusOnClick: WordBool;
    procedure Set_Locked(fLocked: WordBool);
    function Get_Locked: WordBool;
    procedure Set_MouseIcon(const MouseIcon: IPictureDisp);
    procedure _Set_MouseIcon(const MouseIcon: IPictureDisp);
    function Get_MouseIcon: IPictureDisp;
    procedure Set_MousePointer(mouseptr: fmMousePointer);
    function Get_MousePointer: fmMousePointer;
    procedure Set_Picture(const Picture: IPictureDisp);
    procedure _Set_Picture(const Picture: IPictureDisp);
    function Get_Picture: IPictureDisp;
    procedure Set_PicturePosition(PicturePosition: fmPicturePosition);
    function Get_PicturePosition: fmPicturePosition;
    procedure Set_Accelerator(const Accelerator: WideString);
    function Get_Accelerator: WideString;
    procedure Set_WordWrap(WordWrap: WordBool);
    function Get_WordWrap: WordBool;
    procedure Set_Value(fValue: WordBool);
    function Get_Value: WordBool;
    procedure Set_FontWeight(FontWeight: Smallint);
    function Get_FontWeight: Smallint;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    property DefaultInterface: ICommandButton read GetDefaultInterface;

    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property BackStyle: fmBackStyle read Get_BackStyle write Set_BackStyle;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property _Font_Reserved: IFontDisp write Set__Font_Reserved;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property FontBold: WordBool read Get_FontBold write Set_FontBold;
    property FontItalic: WordBool read Get_FontItalic write Set_FontItalic;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: Currency read Get_FontSize write Set_FontSize;
    property FontStrikethru: WordBool read Get_FontStrikethru write Set_FontStrikethru;
    property FontUnderline: WordBool read Get_FontUnderline write Set_FontUnderline;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property TakeFocusOnClick: WordBool read Get_TakeFocusOnClick write Set_TakeFocusOnClick;
    property Locked: WordBool read Get_Locked write Set_Locked;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: fmMousePointer read Get_MousePointer write Set_MousePointer;
    property Picture: IPictureDisp read Get_Picture write Set_Picture;
    property PicturePosition: fmPicturePosition read Get_PicturePosition write Set_PicturePosition;
    property Accelerator: WideString read Get_Accelerator write Set_Accelerator;
    property WordWrap: WordBool read Get_WordWrap write Set_WordWrap;
    property Value: WordBool read Get_Value write Set_Value;
    property FontWeight: Smallint read Get_FontWeight write Set_FontWeight;
  published
    property OnBeforeDragOver: TBeforeDragOverEvent read FOnBeforeDragOver write FOnBeforeDragOver;
    property OnBeforeDropOrPaste: TBeforeDropOrPasteEvent read FOnBeforeDropOrPaste write FOnBeforeDropOrPaste;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TDblClickEvent read FOnDblClick write FOnDblClick;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnKeyDown: TKeyDownEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyUpEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TMouseDownEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseUpEvent read FOnMouseUp write FOnMouseUp;
  end;

  TadxMSFormsImage = class(TadxMSFormsControl)
  private
    FIntf: IImage;
    FOnBeforeDragOver: TBeforeDragOverEvent;
    FOnBeforeDropOrPaste: TBeforeDropOrPasteEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TDblClickEvent;
    FOnError: TErrorEvent;
    FOnMouseDown: TMouseDownEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseUpEvent;
    function GetDefaultInterface: IImage;
    function GetControlType: TadxNativeMSFControl; override;
    function GetConnected: boolean; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure Set_Enabled(fEnabled: WordBool);
    function Get_Enabled: WordBool;
    procedure Set_MousePointer(MousePointer: fmMousePointer);
    function Get_MousePointer: fmMousePointer;
    procedure Set_AutoSize(fAutoSize: WordBool);
    function Get_AutoSize: WordBool;
    procedure Set_BackColor(BackColor: OLE_COLOR);
    function Get_BackColor: OLE_COLOR;
    procedure Set_BackStyle(BackStyle: fmBackStyle);
    function Get_BackStyle: fmBackStyle;
    procedure Set_BorderColor(BorderColor: OLE_COLOR);
    function Get_BorderColor: OLE_COLOR;
    procedure Set_BorderStyle(Style: fmBorderStyle);
    function Get_BorderStyle: fmBorderStyle;
    procedure Set_Picture(const Picture: IPictureDisp);
    procedure _Set_Picture(const Picture: IPictureDisp);
    function Get_Picture: IPictureDisp;
    procedure Set_MouseIcon(const MouseIcon: IPictureDisp);
    procedure _Set_MouseIcon(const MouseIcon: IPictureDisp);
    function Get_MouseIcon: IPictureDisp;
    procedure Set_PictureSizeMode(PictureSizeMode: fmPictureSizeMode);
    function Get_PictureSizeMode: fmPictureSizeMode;
    procedure Set_PictureAlignment(PictureAlignment: fmPictureAlignment);
    function Get_PictureAlignment: fmPictureAlignment;
    procedure Set_PictureTiling(PictureTiling: WordBool);
    function Get_PictureTiling: WordBool;
    procedure Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
    function Get_SpecialEffect: fmSpecialEffect;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    property DefaultInterface: IImage read GetDefaultInterface;

    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property MousePointer: fmMousePointer read Get_MousePointer write Set_MousePointer;
    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property BackStyle: fmBackStyle read Get_BackStyle write Set_BackStyle;
    property BorderColor: OLE_COLOR read Get_BorderColor write Set_BorderColor;
    property BorderStyle: fmBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property Picture: IPictureDisp read Get_Picture write Set_Picture;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property PictureSizeMode: fmPictureSizeMode read Get_PictureSizeMode write Set_PictureSizeMode;
    property PictureAlignment: fmPictureAlignment read Get_PictureAlignment write Set_PictureAlignment;
    property PictureTiling: WordBool read Get_PictureTiling write Set_PictureTiling;
    property SpecialEffect: fmSpecialEffect read Get_SpecialEffect write Set_SpecialEffect;
  published
    property OnBeforeDragOver: TBeforeDragOverEvent read FOnBeforeDragOver write FOnBeforeDragOver;
    property OnBeforeDropOrPaste: TBeforeDropOrPasteEvent read FOnBeforeDropOrPaste write FOnBeforeDropOrPaste;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TDblClickEvent read FOnDblClick write FOnDblClick;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnMouseDown: TMouseDownEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseUpEvent read FOnMouseUp write FOnMouseUp;
  end;

  TadxMSFormsLabelControl = class(TadxMSFormsControl)
  private
    FIntf: ILabelControl;
    FOnBeforeDragOver: TBeforeDragOverEvent;
    FOnBeforeDropOrPaste: TBeforeDropOrPasteEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TDblClickEvent;
    FOnError: TErrorEvent;
    FOnMouseDown: TMouseDownEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseUpEvent;
    function GetDefaultInterface: ILabelControl;
    function GetControlType: TadxNativeMSFControl; override;
    function GetConnected: boolean; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure Set_AutoSize(fvbAutoSize: WordBool);
    function Get_AutoSize: WordBool;
    procedure Set_BackColor(BackColor: OLE_COLOR);
    function Get_BackColor: OLE_COLOR;
    procedure Set_BackStyle(BackStyle: fmBackStyle);
    function Get_BackStyle: fmBackStyle;
    procedure Set_BorderColor(BorderColor: OLE_COLOR);
    function Get_BorderColor: OLE_COLOR;
    procedure Set_BorderStyle(BorderStyle: fmBorderStyle);
    function Get_BorderStyle: fmBorderStyle;
    procedure Set_Caption(const bstrCaption: WideString);
    function Get_Caption: WideString;
    procedure Set_Enabled(fEnabled: WordBool);
    function Get_Enabled: WordBool;
    procedure Set__Font_Reserved(const Param1: IFontDisp);
    procedure _Set_Font(const Font: IFontDisp);
    function Get_Font: IFontDisp;
    procedure Set_FontItalic(FontItalic: WordBool);
    function Get_FontItalic: WordBool;
    procedure Set_FontBold(FontBold: WordBool);
    function Get_FontBold: WordBool;
    procedure Set_FontName(const FontName: WideString);
    function Get_FontName: WideString;
    procedure Set_FontSize(FontSize: Currency);
    function Get_FontSize: Currency;
    procedure Set_FontStrikethru(FontStrikethru: WordBool);
    function Get_FontStrikethru: WordBool;
    procedure Set_FontUnderline(FontUnderline: WordBool);
    function Get_FontUnderline: WordBool;
    procedure Set_ForeColor(ForeColor: OLE_COLOR);
    function Get_ForeColor: OLE_COLOR;
    procedure Set_MouseIcon(const MouseIcon: IPictureDisp);
    procedure _Set_MouseIcon(const MouseIcon: IPictureDisp);
    function Get_MouseIcon: IPictureDisp;
    procedure Set_MousePointer(MousePointer: fmMousePointer);
    function Get_MousePointer: fmMousePointer;
    procedure Set_Picture(const pPicture: IPictureDisp);
    procedure _Set_Picture(const pPicture: IPictureDisp);
    function Get_Picture: IPictureDisp;
    procedure Set_PicturePosition(PicPos: fmPicturePosition);
    function Get_PicturePosition: fmPicturePosition;
    procedure Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
    function Get_SpecialEffect: fmSpecialEffect;
    procedure Set_TextAlign(TextAlign: fmTextAlign);
    function Get_TextAlign: fmTextAlign;
    procedure Set_WordWrap(WordWrap: WordBool);
    function Get_WordWrap: WordBool;
    procedure Set_Accelerator(const Accelerator: WideString);
    function Get_Accelerator: WideString;
    procedure Set_FontWeight(FontWeight: Smallint);
    function Get_FontWeight: Smallint;
    procedure Set__Value(const bstrCaption: WideString);
    function Get__Value: WideString;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    property DefaultInterface: ILabelControl read GetDefaultInterface;

    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property BackStyle: fmBackStyle read Get_BackStyle write Set_BackStyle;
    property BorderColor: OLE_COLOR read Get_BorderColor write Set_BorderColor;
    property BorderStyle: fmBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property Caption: WideString read Get_Caption write Set_Caption;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property _Font_Reserved: IFontDisp write Set__Font_Reserved;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property FontItalic: WordBool read Get_FontItalic write Set_FontItalic;
    property FontBold: WordBool read Get_FontBold write Set_FontBold;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: Currency read Get_FontSize write Set_FontSize;
    property FontStrikethru: WordBool read Get_FontStrikethru write Set_FontStrikethru;
    property FontUnderline: WordBool read Get_FontUnderline write Set_FontUnderline;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: fmMousePointer read Get_MousePointer write Set_MousePointer;
    property Picture: IPictureDisp read Get_Picture write Set_Picture;
    property PicturePosition: fmPicturePosition read Get_PicturePosition write Set_PicturePosition;
    property SpecialEffect: fmSpecialEffect read Get_SpecialEffect write Set_SpecialEffect;
    property TextAlign: fmTextAlign read Get_TextAlign write Set_TextAlign;
    property WordWrap: WordBool read Get_WordWrap write Set_WordWrap;
    property Accelerator: WideString read Get_Accelerator write Set_Accelerator;
    property FontWeight: Smallint read Get_FontWeight write Set_FontWeight;
    property _Value: WideString read Get__Value write Set__Value;
  published
    property OnBeforeDragOver: TBeforeDragOverEvent read FOnBeforeDragOver write FOnBeforeDragOver;
    property OnBeforeDropOrPaste: TBeforeDropOrPasteEvent read FOnBeforeDropOrPaste write FOnBeforeDropOrPaste;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TDblClickEvent read FOnDblClick write FOnDblClick;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnMouseDown: TMouseDownEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseUpEvent read FOnMouseUp write FOnMouseUp;
  end;

  TadxMSFormsListBox = class(TadxMSFormsControl)
  private
    FIntf: IMdcList;
    FOnBeforeDragOver: TBeforeDragOverEvent;
    FOnBeforeDropOrPaste: TBeforeDropOrPasteEvent;
    FOnChange: TNotifyEvent;
    FOnClick: TNotifyEvent;
    FOnDblClick: TDblClickEvent;
    FOnError: TErrorEvent;
    FOnKeyDown: TKeyDownEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyUpEvent;
    FOnMouseDown: TMouseDownEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseUpEvent;
    function GetDefaultInterface: IMdcList;
    function GetControlType: TadxNativeMSFControl; override;
    function GetConnected: boolean; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure Set_BackColor(BackColor: OLE_COLOR);
    function Get_BackColor: OLE_COLOR;
    procedure Set_BorderColor(BorderColor: OLE_COLOR);
    function Get_BorderColor: OLE_COLOR;
    procedure Set_BorderStyle(BorderStyle: fmBorderStyle);
    function Get_BorderStyle: fmBorderStyle;
    procedure Set_BordersSuppress(BordersSuppress: WordBool);
    function Get_BordersSuppress: WordBool;
    procedure Set_BoundColumn(var BoundColumn: OleVariant);
    procedure Set_BoundColumn2(BoundColumn: OleVariant);
    function Get_BoundColumn: OleVariant;
    procedure Set_ColumnCount(ColumnCount: Integer);
    function Get_ColumnCount: Integer;
    procedure Set_ColumnHeads(ColumnHeads: WordBool);
    function Get_ColumnHeads: WordBool;
    procedure Set_ColumnWidths(const ColumnWidths: WideString);
    function Get_ColumnWidths: WideString;
    procedure Set_Enabled(Enabled: WordBool);
    function Get_Enabled: WordBool;
    procedure Set__Font_Reserved(const Param1: IFontDisp);
    procedure _Set_Font(const Font: IFontDisp);
    function Get_Font: IFontDisp;
    procedure Set_FontBold(FontBold: WordBool);
    function Get_FontBold: WordBool;
    procedure Set_FontItalic(FontItalic: WordBool);
    function Get_FontItalic: WordBool;
    procedure Set_FontName(const FontName: WideString);
    function Get_FontName: WideString;
    procedure Set_FontSize(FontSize: Currency);
    function Get_FontSize: Currency;
    procedure Set_FontStrikethru(FontStrikethru: WordBool);
    function Get_FontStrikethru: WordBool;
    procedure Set_FontUnderline(FontUnderline: WordBool);
    function Get_FontUnderline: WordBool;
    procedure Set_FontWeight(FontWeight: Smallint);
    function Get_FontWeight: Smallint;
    procedure Set_ForeColor(ForeColor: OLE_COLOR);
    function Get_ForeColor: OLE_COLOR;
    procedure Set_IntegralHeight(IntegralHeight: WordBool);
    function Get_IntegralHeight: WordBool;
    function Get_ListCount: Integer;
    procedure Set_ListCursor(const ListCursor: PIROWSET);
    function Get_ListCursor: PIROWSET;
    procedure Set_ListIndex(var ListIndex: OleVariant);
    procedure Set_ListIndex2(ListIndex: OleVariant);
    function Get_ListIndex: OleVariant;
    procedure Set_ListStyle(ListStyle: fmListStyle);
    function Get_ListStyle: fmListStyle;
    procedure Set_ListWidth(var ListWidth: OleVariant);
    procedure Set_ListWidth2(ListWidth: OleVariant);
    function Get_ListWidth: OleVariant;
    procedure Set_Locked(Locked: WordBool);
    function Get_Locked: WordBool;
    procedure Set_MatchEntry(MatchEntry: fmMatchEntry);
    function Get_MatchEntry: fmMatchEntry;
    procedure Set_MouseIcon(const MouseIcon: IPictureDisp);
    procedure _Set_MouseIcon(const MouseIcon: IPictureDisp);
    function Get_MouseIcon: IPictureDisp;
    procedure Set_MousePointer(MousePointer: fmMousePointer);
    function Get_MousePointer: fmMousePointer;
    procedure Set_MultiSelect(MultiSelect: fmMultiSelect);
    function Get_MultiSelect: fmMultiSelect;
    procedure Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
    function Get_SpecialEffect: fmSpecialEffect;
    procedure Set_Text(const Text: WideString);
    function Get_Text: WideString;
    procedure Set_TextColumn(var TextColumn: OleVariant);
    procedure Set_TextColumn2(TextColumn: OleVariant);
    function Get_TextColumn: OleVariant;
    procedure Set_TopIndex(var TopIndex: OleVariant);
    procedure Set_TopIndex2(TopIndex: OleVariant);
    function Get_TopIndex: OleVariant;
    function Get_Valid: WordBool;
    procedure Set_Value(var Value: OleVariant);
    procedure Set_Value2(Value: OleVariant);
    function Get_Value: OleVariant;
    function Get_Column(var pvargColumn: OleVariant; var pvargIndex: OleVariant): OleVariant;
    procedure Set_Column(var pvargColumn: OleVariant; var pvargIndex: OleVariant; var pvargValue: OleVariant);
    procedure Set_Column2(var pvargColumn: OleVariant; var pvargIndex: OleVariant; pvargValue: OleVariant);
    function Get_List(var pvargIndex: OleVariant; var pvargColumn: OleVariant): OleVariant;
    procedure Set_List(var pvargIndex: OleVariant; var pvargColumn: OleVariant; var pvargValue: OleVariant);
    procedure Set_List2(var pvargIndex: OleVariant; var pvargColumn: OleVariant; pvargValue: OleVariant);
    function Get_Selected(var pvargIndex: OleVariant): WordBool;
    procedure Set_Selected(var pvargIndex: OleVariant; pfvb: WordBool);
    procedure Set_IMEMode(IMEMode: fmIMEMode);
    function Get_IMEMode: fmIMEMode;
    function Get_DisplayStyle: fmDisplayStyle;
{$IFNDEF ADX_VCL6}
    procedure Set_TextAlign(TextAlign: fmTextAlign);
    function Get_TextAlign: fmTextAlign;
{$ENDIF}
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    procedure AddItem(var pvargItem: OleVariant; var pvargIndex: OleVariant);
    procedure Clear;
    procedure RemoveItem(var pvargIndex: OleVariant);

    property DefaultInterface: IMdcList read GetDefaultInterface;

    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property BorderColor: OLE_COLOR read Get_BorderColor write Set_BorderColor;
    property BorderStyle: fmBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property BordersSuppress: WordBool read Get_BordersSuppress write Set_BordersSuppress;
    property BoundColumn: OleVariant read Get_BoundColumn write Set_BoundColumn2;
    property ColumnCount: Integer read Get_ColumnCount write Set_ColumnCount;
    property ColumnHeads: WordBool read Get_ColumnHeads write Set_ColumnHeads;
    property ColumnWidths: WideString read Get_ColumnWidths write Set_ColumnWidths;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property _Font_Reserved: IFontDisp write Set__Font_Reserved;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property FontBold: WordBool read Get_FontBold write Set_FontBold;
    property FontItalic: WordBool read Get_FontItalic write Set_FontItalic;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: Currency read Get_FontSize write Set_FontSize;
    property FontStrikethru: WordBool read Get_FontStrikethru write Set_FontStrikethru;
    property FontUnderline: WordBool read Get_FontUnderline write Set_FontUnderline;
    property FontWeight: Smallint read Get_FontWeight write Set_FontWeight;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property IntegralHeight: WordBool read Get_IntegralHeight write Set_IntegralHeight;
    property ListCount: Integer read Get_ListCount;
    property ListCursor: PIROWSET read Get_ListCursor write Set_ListCursor;
    property ListIndex: OleVariant read Get_ListIndex write Set_ListIndex2;
    property ListStyle: fmListStyle read Get_ListStyle write Set_ListStyle;
    property ListWidth: OleVariant read Get_ListWidth write Set_ListWidth2;
    property Locked: WordBool read Get_Locked write Set_Locked;
    property MatchEntry: fmMatchEntry read Get_MatchEntry write Set_MatchEntry;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: fmMousePointer read Get_MousePointer write Set_MousePointer;
    property MultiSelect: fmMultiSelect read Get_MultiSelect write Set_MultiSelect;
    property SpecialEffect: fmSpecialEffect read Get_SpecialEffect write Set_SpecialEffect;
    property Text: WideString read Get_Text write Set_Text;
    property TextColumn: OleVariant read Get_TextColumn write Set_TextColumn2;
    property TopIndex: OleVariant read Get_TopIndex write Set_TopIndex2;
    property Valid: WordBool read Get_Valid;
    property Value: OleVariant read Get_Value write Set_Value2;
    property Column[var pvargColumn: OleVariant; var pvargIndex: OleVariant]: OleVariant read Get_Column write Set_Column2;
    property List[var pvargIndex: OleVariant; var pvargColumn: OleVariant]: OleVariant read Get_List write Set_List2;
    property Selected[var pvargIndex: OleVariant]: WordBool read Get_Selected write Set_Selected;
    property IMEMode: fmIMEMode read Get_IMEMode write Set_IMEMode;
    property DisplayStyle: fmDisplayStyle read Get_DisplayStyle;
{$IFNDEF ADX_VCL6}
    property TextAlign: fmTextAlign read Get_TextAlign write Set_TextAlign;
{$ENDIF}
  published
    property OnBeforeDragOver: TBeforeDragOverEvent read FOnBeforeDragOver write FOnBeforeDragOver;
    property OnBeforeDropOrPaste: TBeforeDropOrPasteEvent read FOnBeforeDropOrPaste write FOnBeforeDropOrPaste;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TDblClickEvent read FOnDblClick write FOnDblClick;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnKeyDown: TKeyDownEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyUpEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TMouseDownEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseUpEvent read FOnMouseUp write FOnMouseUp;
  end;

  TadxMSFormsOptionButton = class(TadxMSFormsCheckBox)
  private
    FIntf: IMdcOptionButton;
    function GetDefaultInterface: IMdcOptionButton;
    function GetControlType: TadxNativeMSFControl; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    property DefaultInterface: IMdcOptionButton read GetDefaultInterface;
  published
  end;

  TadxMSFormsScrollBar = class(TadxMSFormsControl)
  private
    FIntf: IScrollbar;
    FOnBeforeDragOver: TBeforeDragOverEvent;
    FOnBeforeDropOrPaste: TBeforeDropOrPasteEvent;
    FOnChange: TNotifyEvent;
    FOnError: TErrorEvent;
    FOnKeyDown: TKeyDownEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyUpEvent;
    FOnScroll: TNotifyEvent;
    function GetDefaultInterface: IScrollbar;
    function GetControlType: TadxNativeMSFControl; override;
    function GetConnected: boolean; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure Set_BackColor(BackColor: OLE_COLOR);
    function Get_BackColor: OLE_COLOR;
    procedure Set_ForeColor(ForeColor: OLE_COLOR);
    function Get_ForeColor: OLE_COLOR;
    procedure Set_Enabled(Enabled: WordBool);
    function Get_Enabled: WordBool;
    procedure Set_MousePointer(MousePointer: fmMousePointer);
    function Get_MousePointer: fmMousePointer;
    procedure Set_Value(Value: Integer);
    function Get_Value: Integer;
    procedure Set_Min(Min: Integer);
    function Get_Min: Integer;
    procedure Set_Max(Max: Integer);
    function Get_Max: Integer;
    procedure Set_SmallChange(SmallChange: Integer);
    function Get_SmallChange: Integer;
    procedure Set_LargeChange(LargeChange: Integer);
    function Get_LargeChange: Integer;
    procedure Set_ProportionalThumb(ProportionalThumb: WordBool);
    function Get_ProportionalThumb: WordBool;
    procedure Set_Orientation(Orientation: fmOrientation);
    function Get_Orientation: fmOrientation;
    procedure Set_Delay(Delay: Integer);
    function Get_Delay: Integer;
    procedure Set_MouseIcon(const MouseIcon: IPictureDisp);
    procedure _Set_MouseIcon(const MouseIcon: IPictureDisp);
    function Get_MouseIcon: IPictureDisp;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    property DefaultInterface: IScrollbar read GetDefaultInterface;

    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property MousePointer: fmMousePointer read Get_MousePointer write Set_MousePointer;
    property Value: Integer read Get_Value write Set_Value;
    property Min: Integer read Get_Min write Set_Min;
    property Max: Integer read Get_Max write Set_Max;
    property SmallChange: Integer read Get_SmallChange write Set_SmallChange;
    property LargeChange: Integer read Get_LargeChange write Set_LargeChange;
    property ProportionalThumb: WordBool read Get_ProportionalThumb write Set_ProportionalThumb;
    property Orientation: fmOrientation read Get_Orientation write Set_Orientation;
    property Delay: Integer read Get_Delay write Set_Delay;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
  published
    property OnBeforeDragOver: TBeforeDragOverEvent read FOnBeforeDragOver write FOnBeforeDragOver;
    property OnBeforeDropOrPaste: TBeforeDropOrPasteEvent read FOnBeforeDropOrPaste write FOnBeforeDropOrPaste;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnKeyDown: TKeyDownEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyUpEvent read FOnKeyUp write FOnKeyUp;
    property OnScroll: TNotifyEvent read FOnScroll write FOnScroll;
  end;

  TadxMSFormsSpinButton = class(TadxMSFormsControl)
  private
    FIntf: ISpinbutton;
    FOnBeforeDragOver: TBeforeDragOverEvent;
    FOnBeforeDropOrPaste: TBeforeDropOrPasteEvent;
    FOnChange: TNotifyEvent;
    FOnError: TErrorEvent;
    FOnKeyDown: TKeyDownEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyUpEvent;
    FOnSpinUp: TNotifyEvent;
    FOnSpinDown: TNotifyEvent;
    function GetDefaultInterface: ISpinbutton;
    function GetControlType: TadxNativeMSFControl; override;
    function GetConnected: boolean; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure Set_BackColor(BackColor: OLE_COLOR);
    function Get_BackColor: OLE_COLOR;
    procedure Set_ForeColor(ForeColor: OLE_COLOR);
    function Get_ForeColor: OLE_COLOR;
    procedure Set_Enabled(Enabled: WordBool);
    function Get_Enabled: WordBool;
    procedure Set_MousePointer(MousePointer: fmMousePointer);
    function Get_MousePointer: fmMousePointer;
    procedure Set_Value(Value: Integer);
    function Get_Value: Integer;
    procedure Set_Min(Min: Integer);
    function Get_Min: Integer;
    procedure Set_Max(Max: Integer);
    function Get_Max: Integer;
    procedure Set_SmallChange(SmallChange: Integer);
    function Get_SmallChange: Integer;
    procedure Set_Orientation(Orientation: fmOrientation);
    function Get_Orientation: fmOrientation;
    procedure Set_MouseIcon(const MouseIcon: IPictureDisp);
    procedure _Set_MouseIcon(const MouseIcon: IPictureDisp);
    function Get_MouseIcon: IPictureDisp;
    procedure Set_Delay(Delay: Integer);
    function Get_Delay: Integer; 
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    property DefaultInterface: ISpinbutton read GetDefaultInterface;

    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property MousePointer: fmMousePointer read Get_MousePointer write Set_MousePointer;
    property Value: Integer read Get_Value write Set_Value;
    property Min: Integer read Get_Min write Set_Min;
    property Max: Integer read Get_Max write Set_Max;
    property SmallChange: Integer read Get_SmallChange write Set_SmallChange;
    property Orientation: fmOrientation read Get_Orientation write Set_Orientation;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property Delay: Integer read Get_Delay write Set_Delay;
  published
    property OnBeforeDragOver: TBeforeDragOverEvent read FOnBeforeDragOver write FOnBeforeDragOver;
    property OnBeforeDropOrPaste: TBeforeDropOrPasteEvent read FOnBeforeDropOrPaste write FOnBeforeDropOrPaste;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnKeyDown: TKeyDownEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyUpEvent read FOnKeyUp write FOnKeyUp;
    property OnSpinUp: TNotifyEvent read FOnSpinUp write FOnSpinUp;
    property OnSpinDown: TNotifyEvent read FOnSpinDown write FOnSpinDown;
  end;

  TadxMSFormsTextBox = class(TadxMSFormsControl)
  private
    FIntf: IMdcText;
    FOnBeforeDragOver: TBeforeDragOverEvent;
    FOnBeforeDropOrPaste: TBeforeDropOrPasteEvent;
    FOnChange: TNotifyEvent;
    FOnDblClick: TDblClickEvent;
    FOnDropButtonClick: TNotifyEvent;
    FOnError: TErrorEvent;
    FOnKeyDown: TKeyDownEvent;
    FOnKeyPress: TKeyPressEvent;
    FOnKeyUp: TKeyUpEvent;
    FOnMouseDown: TMouseDownEvent;
    FOnMouseMove: TMouseMoveEvent;
    FOnMouseUp: TMouseUpEvent;
    function GetDefaultInterface: IMdcText;
    function GetControlType: TadxNativeMSFControl; override;
    function GetConnected: boolean; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;

    procedure Set_AutoSize(AutoSize: WordBool);
    function Get_AutoSize: WordBool;
    procedure Set_AutoTab(AutoTab: WordBool);
    function Get_AutoTab: WordBool;
    procedure Set_AutoWordSelect(AutoWordSelect: WordBool);
    function Get_AutoWordSelect: WordBool;
    procedure Set_BackColor(BackColor: OLE_COLOR);
    function Get_BackColor: OLE_COLOR;
    procedure Set_BackStyle(BackStyle: fmBackStyle);
    function Get_BackStyle: fmBackStyle;
    procedure Set_BorderColor(BorderColor: OLE_COLOR);
    function Get_BorderColor: OLE_COLOR;
    procedure Set_BorderStyle(BorderStyle: fmBorderStyle);
    function Get_BorderStyle: fmBorderStyle;
    procedure Set_BordersSuppress(BordersSuppress: WordBool);
    function Get_BordersSuppress: WordBool;
    function Get_CanPaste: WordBool;
    procedure Set_CurLine(CurLine: Integer);
    function Get_CurLine: Integer;
    function Get_CurTargetX: Integer;
    function Get_CurTargetY: Integer;
    procedure Set_CurX(CurX: Integer);
    function Get_CurX: Integer;
    procedure Set_CurY(CurY: Integer);
    function Get_CurY: Integer;
    procedure Set_DropButtonStyle(DropButtonStyle: fmDropButtonStyle);
    function Get_DropButtonStyle: fmDropButtonStyle;
    procedure Set_EnterKeyBehavior(EnterKeyBehavior: WordBool);
    function Get_EnterKeyBehavior: WordBool;
    procedure Set_Enabled(Enabled: WordBool);
    function Get_Enabled: WordBool;
    procedure Set__Font_Reserved(const Param1: IFontDisp);
    procedure _Set_Font(const Font: IFontDisp);
    function Get_Font: IFontDisp;
    procedure Set_FontBold(FontBold: WordBool);
    function Get_FontBold: WordBool;
    procedure Set_FontItalic(FontItalic: WordBool);
    function Get_FontItalic: WordBool;
    procedure Set_FontName(const FontName: WideString);
    function Get_FontName: WideString;
    procedure Set_FontSize(FontSize: Currency);
    function Get_FontSize: Currency;
    procedure Set_FontStrikethru(FontStrikethru: WordBool);
    function Get_FontStrikethru: WordBool;
    procedure Set_FontUnderline(FontUnderline: WordBool);
    function Get_FontUnderline: WordBool;
    procedure Set_FontWeight(FontWeight: Smallint);
    function Get_FontWeight: Smallint;
    procedure Set_ForeColor(ForeColor: OLE_COLOR);
    function Get_ForeColor: OLE_COLOR;
    procedure Set_HideSelection(HideSelection: WordBool);
    function Get_HideSelection: WordBool;
    procedure Set_IntegralHeight(IntegralHeight: WordBool);
    function Get_IntegralHeight: WordBool;
    function Get_LineCount: Integer;
    procedure Set_Locked(Locked: WordBool);
    function Get_Locked: WordBool;
    procedure Set_MaxLength(MaxLength: Integer);
    function Get_MaxLength: Integer;
    procedure Set_MouseIcon(const MouseIcon: IPictureDisp);
    procedure _Set_MouseIcon(const MouseIcon: IPictureDisp);
    function Get_MouseIcon: IPictureDisp;
    procedure Set_MousePointer(MousePointer: fmMousePointer);
    function Get_MousePointer: fmMousePointer;
    procedure Set_MultiLine(MultiLine: WordBool);
    function Get_MultiLine: WordBool;
    procedure Set_PasswordChar(const PasswordChar: WideString);
    function Get_PasswordChar: WideString;
    procedure Set_ScrollBars(ScrollBars: fmScrollBars);
    function Get_ScrollBars: fmScrollBars;
    procedure Set_SelectionMargin(SelectionMargin: WordBool);
    function Get_SelectionMargin: WordBool;
    procedure Set_SelLength(SelLength: Integer);
    function Get_SelLength: Integer;
    procedure Set_SelStart(SelStart: Integer);
    function Get_SelStart: Integer;
    procedure Set_SelText(const SelText: WideString);
    function Get_SelText: WideString;
    procedure Set_ShowDropButtonWhen(ShowDropButtonWhen: fmShowDropButtonWhen);
    function Get_ShowDropButtonWhen: fmShowDropButtonWhen;
    procedure Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
    function Get_SpecialEffect: fmSpecialEffect;
    procedure Set_TabKeyBehavior(TabKeyBehavior: WordBool);
    function Get_TabKeyBehavior: WordBool;
    procedure Set_Text(const Text: WideString);
    function Get_Text: WideString;
    procedure Set_TextAlign(TextAlign: fmTextAlign);
    function Get_TextAlign: fmTextAlign;
    function Get_TextLength: Integer;
    function Get_Valid: WordBool;
    procedure Set_Value(var Value: OleVariant);
    procedure Set_Value2(Value: OleVariant);
    function Get_Value: OleVariant;
    procedure Set_WordWrap(WordWrap: WordBool);
    function Get_WordWrap: WordBool;
    procedure Set_IMEMode(IMEMode: fmIMEMode);
    function Get_IMEMode: fmIMEMode;
    procedure Set_EnterFieldBehavior(EnterFieldBehavior: fmEnterFieldBehavior);
    function Get_EnterFieldBehavior: fmEnterFieldBehavior;
    procedure Set_DragBehavior(DragBehavior: fmDragBehavior);
    function Get_DragBehavior: fmDragBehavior;
    function Get_DisplayStyle: fmDisplayStyle;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    procedure Copy;
    procedure Cut;
    procedure Paste;

    property DefaultInterface: IMdcText read GetDefaultInterface;

    property AutoSize: WordBool read Get_AutoSize write Set_AutoSize;
    property AutoTab: WordBool read Get_AutoTab write Set_AutoTab;
    property AutoWordSelect: WordBool read Get_AutoWordSelect write Set_AutoWordSelect;
    property BackColor: OLE_COLOR read Get_BackColor write Set_BackColor;
    property BackStyle: fmBackStyle read Get_BackStyle write Set_BackStyle;
    property BorderColor: OLE_COLOR read Get_BorderColor write Set_BorderColor;
    property BorderStyle: fmBorderStyle read Get_BorderStyle write Set_BorderStyle;
    property BordersSuppress: WordBool read Get_BordersSuppress write Set_BordersSuppress;
    property CanPaste: WordBool read Get_CanPaste;
    property CurLine: Integer read Get_CurLine write Set_CurLine;
    property CurTargetX: Integer read Get_CurTargetX;
    property CurTargetY: Integer read Get_CurTargetY;
    property CurX: Integer read Get_CurX write Set_CurX;
    property CurY: Integer read Get_CurY write Set_CurY;
    property DropButtonStyle: fmDropButtonStyle read Get_DropButtonStyle write Set_DropButtonStyle;
    property EnterKeyBehavior: WordBool read Get_EnterKeyBehavior write Set_EnterKeyBehavior;
    property Enabled: WordBool read Get_Enabled write Set_Enabled;
    property _Font_Reserved: IFontDisp write Set__Font_Reserved;
    property Font: IFontDisp read Get_Font write _Set_Font;
    property FontBold: WordBool read Get_FontBold write Set_FontBold;
    property FontItalic: WordBool read Get_FontItalic write Set_FontItalic;
    property FontName: WideString read Get_FontName write Set_FontName;
    property FontSize: Currency read Get_FontSize write Set_FontSize;
    property FontStrikethru: WordBool read Get_FontStrikethru write Set_FontStrikethru;
    property FontUnderline: WordBool read Get_FontUnderline write Set_FontUnderline;
    property FontWeight: Smallint read Get_FontWeight write Set_FontWeight;
    property ForeColor: OLE_COLOR read Get_ForeColor write Set_ForeColor;
    property HideSelection: WordBool read Get_HideSelection write Set_HideSelection;
    property IntegralHeight: WordBool read Get_IntegralHeight write Set_IntegralHeight;
    property LineCount: Integer read Get_LineCount;
    property Locked: WordBool read Get_Locked write Set_Locked;
    property MaxLength: Integer read Get_MaxLength write Set_MaxLength;
    property MouseIcon: IPictureDisp read Get_MouseIcon write Set_MouseIcon;
    property MousePointer: fmMousePointer read Get_MousePointer write Set_MousePointer;
    property MultiLine: WordBool read Get_MultiLine write Set_MultiLine;
    property PasswordChar: WideString read Get_PasswordChar write Set_PasswordChar;
    property ScrollBars: fmScrollBars read Get_ScrollBars write Set_ScrollBars;
    property SelectionMargin: WordBool read Get_SelectionMargin write Set_SelectionMargin;
    property SelLength: Integer read Get_SelLength write Set_SelLength;
    property SelStart: Integer read Get_SelStart write Set_SelStart;
    property SelText: WideString read Get_SelText write Set_SelText;
    property ShowDropButtonWhen: fmShowDropButtonWhen read Get_ShowDropButtonWhen write Set_ShowDropButtonWhen;
    property SpecialEffect: fmSpecialEffect read Get_SpecialEffect write Set_SpecialEffect;
    property TabKeyBehavior: WordBool read Get_TabKeyBehavior write Set_TabKeyBehavior;
    property Text: WideString read Get_Text write Set_Text;
    property TextAlign: fmTextAlign read Get_TextAlign write Set_TextAlign;
    property TextLength: Integer read Get_TextLength;
    property Valid: WordBool read Get_Valid;
    property Value: OleVariant read Get_Value write Set_Value2;
    property WordWrap: WordBool read Get_WordWrap write Set_WordWrap;
    property IMEMode: fmIMEMode read Get_IMEMode write Set_IMEMode;
    property EnterFieldBehavior: fmEnterFieldBehavior read Get_EnterFieldBehavior write Set_EnterFieldBehavior;
    property DragBehavior: fmDragBehavior read Get_DragBehavior write Set_DragBehavior;
    property DisplayStyle: fmDisplayStyle read Get_DisplayStyle;
  published
    property OnBeforeDragOver: TBeforeDragOverEvent read FOnBeforeDragOver write FOnBeforeDragOver;
    property OnBeforeDropOrPaste: TBeforeDropOrPasteEvent read FOnBeforeDropOrPaste write FOnBeforeDropOrPaste;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDblClick: TDblClickEvent read FOnDblClick write FOnDblClick;
    property OnDropButtonClick: TNotifyEvent read FOnDropButtonClick write FOnDropButtonClick;
    property OnError: TErrorEvent read FOnError write FOnError;
    property OnKeyDown: TKeyDownEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress: TKeyPressEvent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp: TKeyUpEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown: TMouseDownEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp: TMouseUpEvent read FOnMouseUp write FOnMouseUp;
  end;

  TadxMSFormsToggleButton = class(TadxMSFormsCheckBox)
  private
    FIntf: IMdcToggleButton;
    function GetDefaultInterface: IMdcToggleButton;
    function GetControlType: TadxNativeMSFControl; override;
  protected
    function GetVersionIndependentProgID: string; override;
    procedure InitServerData; override;
  public
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDispatch); override;
    procedure Disconnect; override;

    property DefaultInterface: IMdcToggleButton read GetDefaultInterface;
  published
  end;

implementation

uses SysUtils, adxAddIn;

{ TadxMSFormsControl }

constructor TadxMSFormsControl.Create(AOwner: TComponent);
const
  adxECode = 31100;
  adxECodeCantContain = adxECode + 12;
  adxErrorCantContain = 'The %s class cannot be contained in the %s class.';
begin
  inherited Create(AOwner);
  if AOwner = nil then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, 'nil']), adxECodeCantContain, 0);
  if not (AOwner is TadxCustomDocumentModule) then
    raise EADXException.Create(Format(adxErrorCantContain, [ClassName, AOwner.ClassName]), adxECodeCantContain, 0);
end;

function TadxMSFormsControl.GetControlType: TadxNativeMSFControl;
begin
  Result := msfUnknown;
end;

type
  TadxCOMAddInModuleAccess = class(TadxCOMAddInModule);

{ TadxMSFormsCheckBox }

function TadxMSFormsCheckBox.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.CheckBox';
end;

function TadxMSFormsCheckBox.GetControlType: TadxNativeMSFControl;
begin
  Result := msfCheckBox;
end;

function TadxMSFormsCheckBox.GetConnected: boolean;
begin
  Result := DefaultInterface <> nil;
end;

procedure TadxMSFormsCheckBox.Connect;
begin
end;

procedure TadxMSFormsCheckBox.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as IMdcCheckBox;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsCheckBox.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsCheckBox.GetDefaultInterface: IMdcCheckBox;
begin
  Result := FIntf;
end;

procedure TadxMSFormsCheckBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{8BD21D40-EC42-11CE-9E0D-00AA006002F3}';
    IntfIID:  '{8BD21D43-EC42-11CE-9E0D-00AA006002F3}';
    EventIID: '{8BD21D42-EC42-11CE-9E0D-00AA006002F3}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMSFormsCheckBox.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  try
    case DispID of
      -1: Exit;  // DISPID_UNKNOWN
      3: if Assigned(FOnBeforeDragOver) then
          FOnBeforeDragOver(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            IUnknown(TVarData(Params[1]).VPointer) as DataObject,
            Params[2], Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      4: if Assigned(FOnBeforeDropOrPaste) then
          FOnBeforeDropOrPaste(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            Params[1], IUnknown(TVarData(Params[2]).VPointer) as DataObject,
            Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      2: if Assigned(FOnChange) then FOnChange(Self);
      -610: if Assigned(FOnClick) then FOnClick(Self);
      -601: if Assigned(FOnDblClick) then
          FOnDblClick(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean);
      -608: if Assigned(FOnError) then
          FOnError(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ReturnString,
            Params[2], Params[3], Params[4], Params[5],
            IUnknown(TVarData(Params[6]).VPointer) as ReturnBoolean);
      -602: if Assigned(FOnKeyDown) then
          FOnKeyDown(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -603: if Assigned(FOnKeyPress) then
          FOnKeyPress(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger);
      -604: if Assigned(FOnKeyUp) then
          FOnKeyUp(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -605: if Assigned(FOnMouseDown) then
          FOnMouseDown(Self, Params[0], Params[1], Params[2], Params[3]);
      -606: if Assigned(FOnMouseMove) then
          FOnMouseMove(Self, Params[0], Params[1], Params[2], Params[3]);
      -607: if Assigned(FOnMouseUp) then
          FOnMouseUp(Self, Params[0], Params[1], Params[2], Params[3]);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxMSFormsCheckBox.Set_Accelerator(const Accelerator: WideString);
begin
  if Connected then
    DefaultInterface.Set_Accelerator(Accelerator);
end;

function TadxMSFormsCheckBox.Get_Accelerator: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_Accelerator;
end;

procedure TadxMSFormsCheckBox.Set_Alignment(Alignment: fmAlignment);
begin
  if Connected then
    DefaultInterface.Set_Alignment(Alignment);
end;

function TadxMSFormsCheckBox.Get_Alignment: fmAlignment;
begin
  Result := fmAlignmentLeft;
  if Connected then
    Result := DefaultInterface.Get_Alignment;
end;

procedure TadxMSFormsCheckBox.Set_AutoSize(AutoSize: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoSize(AutoSize);
end;

function TadxMSFormsCheckBox.Get_AutoSize: WordBool;
begin
  Result := False; 
  if Connected then
    Result := DefaultInterface.Get_AutoSize;
end;

procedure TadxMSFormsCheckBox.Set_BackColor(BackColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BackColor(BackColor);
end;

function TadxMSFormsCheckBox.Get_BackColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BackColor;
end;

procedure TadxMSFormsCheckBox.Set_BackStyle(BackStyle: fmBackStyle);
begin
  if Connected then
    DefaultInterface.Set_BackStyle(BackStyle);
end;

function TadxMSFormsCheckBox.Get_BackStyle: fmBackStyle;
begin
  Result := fmBackStyleTransparent;
  if Connected then
    Result := DefaultInterface.Get_BackStyle;
end;

procedure TadxMSFormsCheckBox.Set_BordersSuppress(BordersSuppress: WordBool);
begin
  if Connected then
    DefaultInterface.Set_BordersSuppress(BordersSuppress);
end;

function TadxMSFormsCheckBox.Get_BordersSuppress: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_BordersSuppress;
end;

procedure TadxMSFormsCheckBox.Set_Caption(const Caption: WideString);
begin
  if Connected then
    DefaultInterface.Set_Caption(Caption);
end;

function TadxMSFormsCheckBox.Get_Caption: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_Caption;
end;

procedure TadxMSFormsCheckBox.Set_Enabled(Enabled: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Enabled(Enabled);
end;

function TadxMSFormsCheckBox.Get_Enabled: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Enabled;
end;

procedure TadxMSFormsCheckBox.Set__Font_Reserved(const Param1: IFontDisp);
begin
  if Connected then
    DefaultInterface.Set__Font_Reserved(Param1);
end;

procedure TadxMSFormsCheckBox._Set_Font(const Font: IFontDisp);
begin
  if Connected then
{$IFDEF ADX_VCL5}
    DefaultInterface.Set_Font(Font);
{$ELSE}
    DefaultInterface._Set_Font(Font);
{$ENDIF}
end;

function TadxMSFormsCheckBox.Get_Font: IFontDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_Font;
end;

procedure TadxMSFormsCheckBox.Set_FontBold(FontBold: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontBold(FontBold);
end;

function TadxMSFormsCheckBox.Get_FontBold: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontBold;
end;

procedure TadxMSFormsCheckBox.Set_FontItalic(FontItalic: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontItalic(FontItalic);
end;

function TadxMSFormsCheckBox.Get_FontItalic: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontItalic;
end;

procedure TadxMSFormsCheckBox.Set_FontName(const FontName: WideString);
begin
  if Connected then
    DefaultInterface.Set_FontName(FontName);
end;

function TadxMSFormsCheckBox.Get_FontName: WideString;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_FontName;
end;

procedure TadxMSFormsCheckBox.Set_FontSize(FontSize: Currency);
begin
  if Connected then
    DefaultInterface.Set_FontSize(FontSize);
end;

function TadxMSFormsCheckBox.Get_FontSize: Currency;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontSize;
end;

procedure TadxMSFormsCheckBox.Set_FontStrikethru(FontStrikethru: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontStrikethru(FontStrikethru);
end;

function TadxMSFormsCheckBox.Get_FontStrikethru: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontStrikethru;
end;

procedure TadxMSFormsCheckBox.Set_FontUnderline(FontUnderline: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontUnderline(FontUnderline);
end;

function TadxMSFormsCheckBox.Get_FontUnderline: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontUnderline;
end;

procedure TadxMSFormsCheckBox.Set_FontWeight(FontWeight: Smallint);
begin
  if Connected then
    DefaultInterface.Set_FontWeight(FontWeight);
end;

function TadxMSFormsCheckBox.Get_FontWeight: Smallint;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontWeight;
end;

procedure TadxMSFormsCheckBox.Set_ForeColor(ForeColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_ForeColor(ForeColor);
end;

function TadxMSFormsCheckBox.Get_ForeColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ForeColor;
end;

procedure TadxMSFormsCheckBox.Set_Locked(Locked: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Locked(Locked);
end;

function TadxMSFormsCheckBox.Get_Locked: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Locked;
end;

procedure TadxMSFormsCheckBox.Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_MouseIcon(MouseIcon);
end;

procedure TadxMSFormsCheckBox._Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_MouseIcon(MouseIcon);
end;

function TadxMSFormsCheckBox.Get_MouseIcon: IPictureDisp;
begin
  Result := nil;
  if Connected then
    Result := DefaultInterface.Get_MouseIcon;
end;

procedure TadxMSFormsCheckBox.Set_MousePointer(MousePointer: fmMousePointer);
begin
  if Connected then
    DefaultInterface.Set_MousePointer(MousePointer);
end;

function TadxMSFormsCheckBox.Get_MousePointer: fmMousePointer;
begin
  Result := fmMousePointerDefault;
  if Connected then
    Result := DefaultInterface.Get_MousePointer;
end;

procedure TadxMSFormsCheckBox.Set_MultiSelect(MultiSelect: fmMultiSelect);
begin
  if Connected then
    DefaultInterface.Set_MultiSelect(MultiSelect);
end;

function TadxMSFormsCheckBox.Get_MultiSelect: fmMultiSelect;
begin
  Result := fmMultiSelectSingle;
  if Connected then
    Result := DefaultInterface.Get_MultiSelect;
end;

procedure TadxMSFormsCheckBox.Set_Picture(const Picture: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_Picture(Picture);
end;

procedure TadxMSFormsCheckBox._Set_Picture(const Picture: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_Picture(Picture);
end;

function TadxMSFormsCheckBox.Get_Picture: IPictureDisp;
begin
  Result := nil;
  if Connected then
    Result := DefaultInterface.Get_Picture;
end;

procedure TadxMSFormsCheckBox.Set_PicturePosition(PicPos: fmPicturePosition);
begin
  if Connected then
    DefaultInterface.Set_PicturePosition(PicPos);
end;

function TadxMSFormsCheckBox.Get_PicturePosition: fmPicturePosition;
begin
  Result := fmPicturePositionLeftTop;
  if Connected then
    Result := DefaultInterface.Get_PicturePosition;
end;

procedure TadxMSFormsCheckBox.Set_SpecialEffect(SpecialEffect: fmButtonEffect);
begin
  if Connected then
    DefaultInterface.Set_SpecialEffect(SpecialEffect);
end;

function TadxMSFormsCheckBox.Get_SpecialEffect: fmButtonEffect;
begin
  Result := fmButtonEffectFlat;
  if Connected then
    Result := DefaultInterface.Get_SpecialEffect;
end;

procedure TadxMSFormsCheckBox.Set_TripleState(TripleState: WordBool);
begin
  if Connected then
    DefaultInterface.Set_TripleState(TripleState);
end;

function TadxMSFormsCheckBox.Get_TripleState: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_TripleState;
end;

function TadxMSFormsCheckBox.Get_Valid: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Valid;
end;

procedure TadxMSFormsCheckBox.Set_Value(var Value: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

procedure TadxMSFormsCheckBox.Set_Value2(Value: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

function TadxMSFormsCheckBox.Get_Value: OleVariant;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_Value;
end;

procedure TadxMSFormsCheckBox.Set_WordWrap(WordWrap: WordBool);
begin
  if Connected then
    DefaultInterface.Set_WordWrap(WordWrap);
end;

function TadxMSFormsCheckBox.Get_WordWrap: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_WordWrap;
end;

function TadxMSFormsCheckBox.Get_DisplayStyle: fmDisplayStyle;
begin
  Result := fmDisplayStyleText;
  if Connected then
    Result := DefaultInterface.Get_DisplayStyle;
end;

procedure TadxMSFormsCheckBox.Set_GroupName(const GroupName: WideString);
begin
  if Connected then
    DefaultInterface.Set_GroupName(GroupName);
end;

function TadxMSFormsCheckBox.Get_GroupName: WideString;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_GroupName;
end;

{$IFNDEF ADX_VCL6}
procedure TadxMSFormsCheckBox.Set_TextAlign(TextAlign: fmTextAlign);
begin
  if Connected then
    DefaultInterface.Set_TextAlign(TextAlign);
end;

function TadxMSFormsCheckBox.Get_TextAlign: fmTextAlign;
begin
  Result := fmTextAlignLeft;
  if Connected then
    Result := DefaultInterface.Get_TextAlign;
end;
{$ENDIF}

{ TadxMSFormsComboBox }

function TadxMSFormsComboBox.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.ComboBox';
end;

function TadxMSFormsComboBox.GetControlType: TadxNativeMSFControl;
begin
  Result := msfComboBox;
end;

function TadxMSFormsComboBox.GetConnected: boolean;
begin
  Result := DefaultInterface <> nil;
end;

procedure TadxMSFormsComboBox.Connect;
begin
end;

procedure TadxMSFormsComboBox.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as IMdcCombo;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsComboBox.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsComboBox.GetDefaultInterface: IMdcCombo;
begin
  Result := FIntf;
end;

procedure TadxMSFormsComboBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{8BD21D30-EC42-11CE-9E0D-00AA006002F3}';
    IntfIID:  '{8BD21D33-EC42-11CE-9E0D-00AA006002F3}';
    EventIID: '{8BD21D32-EC42-11CE-9E0D-00AA006002F3}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMSFormsComboBox.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  try
    case DispID of
      -1: Exit;  // DISPID_UNKNOWN
      3: if Assigned(FOnBeforeDragOver) then
          FOnBeforeDragOver(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            IUnknown(TVarData(Params[1]).VPointer) as DataObject,
            Params[2], Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      4: if Assigned(FOnBeforeDropOrPaste) then
          FOnBeforeDropOrPaste(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            Params[1], IUnknown(TVarData(Params[2]).VPointer) as DataObject,
            Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      2: if Assigned(FOnChange) then FOnChange(Self);
      -610: if Assigned(FOnClick) then FOnClick(Self);
      -601: if Assigned(FOnDblClick) then
          FOnDblClick(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean);
      2002: if Assigned(FOnDropButtonClick) then
          FOnDropButtonClick(Self);
      -608: if Assigned(FOnError) then
          FOnError(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ReturnString,
            Params[2], Params[3], Params[4], Params[5],
            IUnknown(TVarData(Params[6]).VPointer) as ReturnBoolean);
      -602: if Assigned(FOnKeyDown) then
          FOnKeyDown(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -603: if Assigned(FOnKeyPress) then
          FOnKeyPress(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger);
      -604: if Assigned(FOnKeyUp) then
          FOnKeyUp(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -605: if Assigned(FOnMouseDown) then
          FOnMouseDown(Self, Params[0], Params[1], Params[2], Params[3]);
      -606: if Assigned(FOnMouseMove) then
          FOnMouseMove(Self, Params[0], Params[1], Params[2], Params[3]);
      -607: if Assigned(FOnMouseUp) then
          FOnMouseUp(Self, Params[0], Params[1], Params[2], Params[3]);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxMSFormsComboBox.Set_AutoSize(AutoSize: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoSize(AutoSize);
end;

function TadxMSFormsComboBox.Get_AutoSize: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_AutoSize;
end;

procedure TadxMSFormsComboBox.Set_AutoTab(AutoTab: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoTab(AutoTab);
end;

function TadxMSFormsComboBox.Get_AutoTab: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_AutoTab;
end;

procedure TadxMSFormsComboBox.Set_AutoWordSelect(AutoWordSelect: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoWordSelect(AutoWordSelect);
end;

function TadxMSFormsComboBox.Get_AutoWordSelect: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_AutoWordSelect;
end;

procedure TadxMSFormsComboBox.Set_BackColor(BackColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BackColor(BackColor);
end;

function TadxMSFormsComboBox.Get_BackColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BackColor;
end;

procedure TadxMSFormsComboBox.Set_BackStyle(BackStyle: fmBackStyle);
begin
  if Connected then
    DefaultInterface.Set_BackStyle(BackStyle);
end;

function TadxMSFormsComboBox.Get_BackStyle: fmBackStyle;
begin
  Result := fmBackStyleTransparent;
  if Connected then
    Result := DefaultInterface.Get_BackStyle;
end;

procedure TadxMSFormsComboBox.Set_BorderColor(BorderColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BorderColor(BorderColor);
end;

function TadxMSFormsComboBox.Get_BorderColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BorderColor;
end;

procedure TadxMSFormsComboBox.Set_BorderStyle(BorderStyle: fmBorderStyle);
begin
  if Connected then
    DefaultInterface.Set_BorderStyle(BorderStyle);
end;

function TadxMSFormsComboBox.Get_BorderStyle: fmBorderStyle;
begin
  Result := fmBorderStyleNone;
  if Connected then
    Result := DefaultInterface.Get_BorderStyle;
end;

procedure TadxMSFormsComboBox.Set_BordersSuppress(BordersSuppress: WordBool);
begin
  if Connected then
    DefaultInterface.Set_BordersSuppress(BordersSuppress);
end;

function TadxMSFormsComboBox.Get_BordersSuppress: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_BordersSuppress;
end;

procedure TadxMSFormsComboBox.Set_BoundColumn(var BoundColumn: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_BoundColumn(BoundColumn);
end;

procedure TadxMSFormsComboBox.Set_BoundColumn2(BoundColumn: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_BoundColumn(BoundColumn);
end;

function TadxMSFormsComboBox.Get_BoundColumn: OleVariant;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BoundColumn;
end;

function TadxMSFormsComboBox.Get_CanPaste: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_CanPaste;
end;

procedure TadxMSFormsComboBox.Set_ColumnCount(ColumnCount: Integer);
begin
  if Connected then
    DefaultInterface.Set_ColumnCount(ColumnCount);
end;

function TadxMSFormsComboBox.Get_ColumnCount: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ColumnCount;
end;

procedure TadxMSFormsComboBox.Set_ColumnHeads(ColumnHeads: WordBool);
begin
  if Connected then
    DefaultInterface.Set_ColumnHeads(ColumnHeads);
end;

function TadxMSFormsComboBox.Get_ColumnHeads: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_ColumnHeads;
end;

procedure TadxMSFormsComboBox.Set_ColumnWidths(const ColumnWidths: WideString);
begin
  if Connected then
    DefaultInterface.Set_ColumnWidths(ColumnWidths);
end;

function TadxMSFormsComboBox.Get_ColumnWidths: WideString;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_ColumnWidths;
end;

function TadxMSFormsComboBox.Get_CurTargetX: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_CurTargetX;
end;

function TadxMSFormsComboBox.Get_CurTargetY: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_CurTargetY;
end;

procedure TadxMSFormsComboBox.Set_CurX(CurX: Integer);
begin
  if Connected then
    DefaultInterface.Set_CurX(CurX);
end;

function TadxMSFormsComboBox.Get_CurX: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_CurX;
end;

procedure TadxMSFormsComboBox.Set_DropButtonStyle(DropButtonStyle: fmDropButtonStyle);
begin
  if Connected then
    DefaultInterface.Set_DropButtonStyle(DropButtonStyle);
end;

function TadxMSFormsComboBox.Get_DropButtonStyle: fmDropButtonStyle;
begin
  Result := fmDropButtonStylePlain;
  if Connected then
    Result := DefaultInterface.Get_DropButtonStyle;
end;

procedure TadxMSFormsComboBox.Set_Enabled(Enabled: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Enabled(Enabled);
end;

function TadxMSFormsComboBox.Get_Enabled: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Enabled;
end;

procedure TadxMSFormsComboBox.Set__Font_Reserved(const Param1: IFontDisp);
begin
  if Connected then
    DefaultInterface.Set__Font_Reserved(Param1);
end;

procedure TadxMSFormsComboBox._Set_Font(const Font: IFontDisp);
begin
  if Connected then
{$IFDEF ADX_VCL5}
    DefaultInterface.Set_Font(Font);
{$ELSE}
    DefaultInterface._Set_Font(Font);
{$ENDIF}
end;

function TadxMSFormsComboBox.Get_Font: IFontDisp;
begin
  Result := nil;
  if Connected then
    Result := DefaultInterface.Get_Font;
end;

procedure TadxMSFormsComboBox.Set_FontBold(FontBold: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontBold(FontBold);
end;

function TadxMSFormsComboBox.Get_FontBold: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontBold;
end;

procedure TadxMSFormsComboBox.Set_FontItalic(FontItalic: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontItalic(FontItalic);
end;

function TadxMSFormsComboBox.Get_FontItalic: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontItalic;
end;

procedure TadxMSFormsComboBox.Set_FontName(const FontName: WideString);
begin
  if Connected then
    DefaultInterface.Set_FontName(FontName);
end;

function TadxMSFormsComboBox.Get_FontName: WideString;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_FontName;
end;

procedure TadxMSFormsComboBox.Set_FontSize(FontSize: Currency);
begin
  if Connected then
    DefaultInterface.Set_FontSize(FontSize);
end;

function TadxMSFormsComboBox.Get_FontSize: Currency;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontSize;
end;

procedure TadxMSFormsComboBox.Set_FontStrikethru(FontStrikethru: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontStrikethru(FontStrikethru);
end;

function TadxMSFormsComboBox.Get_FontStrikethru: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontStrikethru;
end;

procedure TadxMSFormsComboBox.Set_FontUnderline(FontUnderline: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontUnderline(FontUnderline);
end;

function TadxMSFormsComboBox.Get_FontUnderline: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontUnderline;
end;

procedure TadxMSFormsComboBox.Set_FontWeight(FontWeight: Smallint);
begin
  if Connected then
    DefaultInterface.Set_FontWeight(FontWeight);
end;

function TadxMSFormsComboBox.Get_FontWeight: Smallint;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontWeight;
end;

procedure TadxMSFormsComboBox.Set_ForeColor(ForeColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_ForeColor(ForeColor);
end;

function TadxMSFormsComboBox.Get_ForeColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ForeColor;
end;

procedure TadxMSFormsComboBox.Set_HideSelection(HideSelection: WordBool);
begin
  if Connected then
    DefaultInterface.Set_HideSelection(HideSelection);
end;

function TadxMSFormsComboBox.Get_HideSelection: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_HideSelection;
end;

function TadxMSFormsComboBox.Get_LineCount: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_LineCount;
end;

function TadxMSFormsComboBox.Get_ListCount: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ListCount;
end;

procedure TadxMSFormsComboBox.Set_ListCursor(const ListCursor: PIROWSET);
begin
  if Connected then
    DefaultInterface.Set_ListCursor(ListCursor);
end;

function TadxMSFormsComboBox.Get_ListCursor: PIROWSET;
begin
  Result := nil;
  if Connected then
    Result := DefaultInterface.Get_ListCursor;
end;

procedure TadxMSFormsComboBox.Set_ListIndex(var ListIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_ListIndex(ListIndex);
end;

procedure TadxMSFormsComboBox.Set_ListIndex2(ListIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_ListIndex(ListIndex);
end;

function TadxMSFormsComboBox.Get_ListIndex: OleVariant;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ListIndex;
end;

procedure TadxMSFormsComboBox.Set_ListRows(ListRows: Integer);
begin
  if Connected then
    DefaultInterface.Set_ListRows(ListRows);
end;

function TadxMSFormsComboBox.Get_ListRows: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ListRows;
end;

procedure TadxMSFormsComboBox.Set_ListStyle(ListStyle: fmListStyle);
begin
  if Connected then
    DefaultInterface.Set_ListStyle(ListStyle);
end;

function TadxMSFormsComboBox.Get_ListStyle: fmListStyle;
begin
  Result := fmListStylePlain;
  if Connected then
    Result := DefaultInterface.Get_ListStyle;
end;

procedure TadxMSFormsComboBox.Set_ListWidth(var ListWidth: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_ListWidth(ListWidth);
end;

procedure TadxMSFormsComboBox.Set_ListWidth2(ListWidth: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_ListWidth(ListWidth);
end;

function TadxMSFormsComboBox.Get_ListWidth: OleVariant;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ListWidth;
end;

procedure TadxMSFormsComboBox.Set_Locked(Locked: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Locked(Locked);
end;

function TadxMSFormsComboBox.Get_Locked: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Locked;
end;

procedure TadxMSFormsComboBox.Set_MatchEntry(MatchEntry: fmMatchEntry);
begin
  if Connected then
    DefaultInterface.Set_MatchEntry(MatchEntry);
end;

function TadxMSFormsComboBox.Get_MatchEntry: fmMatchEntry;
begin
  Result := fmListStylePlain;
  if Connected then
    Result := DefaultInterface.Get_MatchEntry;
end;

function TadxMSFormsComboBox.Get_MatchFound: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_MatchFound;
end;

procedure TadxMSFormsComboBox.Set_MatchRequired(MatchRequired: WordBool);
begin
  if Connected then
    DefaultInterface.Set_MatchRequired(MatchRequired);
end;

function TadxMSFormsComboBox.Get_MatchRequired: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_MatchRequired;
end;

procedure TadxMSFormsComboBox.Set_MaxLength(MaxLength: Integer);
begin
  if Connected then
    DefaultInterface.Set_MaxLength(MaxLength);
end;

function TadxMSFormsComboBox.Get_MaxLength: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_MaxLength;
end;

procedure TadxMSFormsComboBox.Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_MouseIcon(MouseIcon);
end;

procedure TadxMSFormsComboBox._Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_MouseIcon(MouseIcon);
end;

function TadxMSFormsComboBox.Get_MouseIcon: IPictureDisp;
begin
  Result := nil;
  if Connected then
    Result := DefaultInterface.Get_MouseIcon;
end;

procedure TadxMSFormsComboBox.Set_MousePointer(MousePointer: fmMousePointer);
begin
  if Connected then
    DefaultInterface.Set_MousePointer(MousePointer);
end;

function TadxMSFormsComboBox.Get_MousePointer: fmMousePointer;
begin
  Result := fmMousePointerDefault;
  if Connected then
    Result := DefaultInterface.Get_MousePointer;
end;

procedure TadxMSFormsComboBox.Set_SelectionMargin(SelectionMargin: WordBool);
begin
  if Connected then
    DefaultInterface.Set_SelectionMargin(SelectionMargin);
end;

function TadxMSFormsComboBox.Get_SelectionMargin: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_SelectionMargin;
end;

procedure TadxMSFormsComboBox.Set_SelLength(SelLength: Integer);
begin
  if Connected then
    DefaultInterface.Set_SelLength(SelLength);
end;

function TadxMSFormsComboBox.Get_SelLength: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_SelLength;
end;

procedure TadxMSFormsComboBox.Set_SelStart(SelStart: Integer);
begin
  if Connected then
    DefaultInterface.Set_SelStart(SelStart);
end;

function TadxMSFormsComboBox.Get_SelStart: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_SelStart;
end;

procedure TadxMSFormsComboBox.Set_SelText(const SelText: WideString);
begin
  if Connected then
    DefaultInterface.Set_SelText(SelText);
end;

function TadxMSFormsComboBox.Get_SelText: WideString;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_SelText;
end;

procedure TadxMSFormsComboBox.Set_ShowDropButtonWhen(ShowDropButtonWhen: fmShowDropButtonWhen);
begin
  if Connected then
    DefaultInterface.Set_ShowDropButtonWhen(ShowDropButtonWhen);
end;

function TadxMSFormsComboBox.Get_ShowDropButtonWhen: fmShowDropButtonWhen;
begin
  Result := fmShowDropButtonWhenNever;
  if Connected then
    Result := DefaultInterface.Get_ShowDropButtonWhen;
end;

procedure TadxMSFormsComboBox.Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
begin
  if Connected then
    DefaultInterface.Set_SpecialEffect(SpecialEffect);
end;

function TadxMSFormsComboBox.Get_SpecialEffect: fmSpecialEffect;
begin
  Result := fmSpecialEffectFlat;
  if Connected then
    Result := DefaultInterface.Get_SpecialEffect;
end;

procedure TadxMSFormsComboBox.Set_Style(Style: fmStyle);
begin
  if Connected then
    DefaultInterface.Set_Style(Style);
end;

function TadxMSFormsComboBox.Get_Style: fmStyle;
begin
  Result := fmStyleDropDownCombo;
  if Connected then
    Result := DefaultInterface.Get_Style;
end;

procedure TadxMSFormsComboBox.Set_Text(const Text: WideString);
begin
  if Connected then
    DefaultInterface.Set_Text(Text);
end;

function TadxMSFormsComboBox.Get_Text: WideString;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_Text;
end;

procedure TadxMSFormsComboBox.Set_TextAlign(TextAlign: fmTextAlign);
begin
  if Connected then
    DefaultInterface.Set_TextAlign(TextAlign);
end;

function TadxMSFormsComboBox.Get_TextAlign: fmTextAlign;
begin
  Result := fmTextAlignLeft;
  if Connected then
    Result := DefaultInterface.Get_TextAlign;
end;

procedure TadxMSFormsComboBox.Set_TextColumn(var TextColumn: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_TextColumn(TextColumn);
end;

procedure TadxMSFormsComboBox.Set_TextColumn2(TextColumn: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_TextColumn(TextColumn);
end;

function TadxMSFormsComboBox.Get_TextColumn: OleVariant;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_TextColumn;
end;

function TadxMSFormsComboBox.Get_TextLength: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_TextLength;
end;

procedure TadxMSFormsComboBox.Set_TopIndex(var TopIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_TopIndex(TopIndex);
end;

procedure TadxMSFormsComboBox.Set_TopIndex2(TopIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_TopIndex(TopIndex);
end;

function TadxMSFormsComboBox.Get_TopIndex: OleVariant;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_TopIndex;
end;

function TadxMSFormsComboBox.Get_Valid: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Valid;
end;

procedure TadxMSFormsComboBox.Set_Value(var Value: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

procedure TadxMSFormsComboBox.Set_Value2(Value: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

function TadxMSFormsComboBox.Get_Value: OleVariant;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_Value;
end;

function TadxMSFormsComboBox.Get_Column(var pvargColumn: OleVariant; var pvargIndex: OleVariant): OleVariant;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_Column(pvargColumn, pvargIndex);
end;

procedure TadxMSFormsComboBox.Set_Column(var pvargColumn: OleVariant; var pvargIndex: OleVariant; var pvargValue: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Column(pvargColumn, pvargIndex, pvargValue);
end;

procedure TadxMSFormsComboBox.Set_Column2(var pvargColumn: OleVariant; var pvargIndex: OleVariant; pvargValue: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Column(pvargColumn, pvargIndex, pvargValue);
end;

function TadxMSFormsComboBox.Get_List(var pvargIndex: OleVariant; var pvargColumn: OleVariant): OleVariant;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_List(pvargIndex, pvargColumn);
end;

procedure TadxMSFormsComboBox.Set_List(var pvargIndex: OleVariant; var pvargColumn: OleVariant; var pvargValue: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_List(pvargIndex, pvargColumn, pvargValue);
end;

procedure TadxMSFormsComboBox.Set_List2(var pvargIndex: OleVariant; var pvargColumn: OleVariant; pvargValue: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_List(pvargIndex, pvargColumn, pvargValue);
end;

procedure TadxMSFormsComboBox.AddItem(var pvargItem: OleVariant; var pvargIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.AddItem(pvargItem, pvargIndex);
end;

procedure TadxMSFormsComboBox.Clear;
begin
  if Connected then
    DefaultInterface.Clear;
end;

procedure TadxMSFormsComboBox.DropDown;
begin
  if Connected then
    DefaultInterface.DropDown;
end;

procedure TadxMSFormsComboBox.RemoveItem(var pvargIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.RemoveItem(pvargIndex);
end;

procedure TadxMSFormsComboBox.Copy;
begin
  if Connected then
    DefaultInterface.Copy;
end;

procedure TadxMSFormsComboBox.Cut;
begin
  if Connected then
    DefaultInterface.Cut;
end;

procedure TadxMSFormsComboBox.Paste;
begin
  if Connected then
    DefaultInterface.Paste;
end;

procedure TadxMSFormsComboBox.Set_IMEMode(IMEMode: fmIMEMode);
begin
  if Connected then
    DefaultInterface.Set_IMEMode(IMEMode);
end;

function TadxMSFormsComboBox.Get_IMEMode: fmIMEMode;
begin
  Result := fmIMEModeNoControl;
  if Connected then
    Result := DefaultInterface.Get_IMEMode;
end;

procedure TadxMSFormsComboBox.Set_EnterFieldBehavior(EnterFieldBehavior: fmEnterFieldBehavior);
begin
  if Connected then
    DefaultInterface.Set_EnterFieldBehavior(EnterFieldBehavior);
end;

function TadxMSFormsComboBox.Get_EnterFieldBehavior: fmEnterFieldBehavior;
begin
  Result := fmEnterFieldBehaviorSelectAll;
  if Connected then
    Result := DefaultInterface.Get_EnterFieldBehavior;
end;

procedure TadxMSFormsComboBox.Set_DragBehavior(DragBehavior: fmDragBehavior);
begin
  if Connected then
    DefaultInterface.Set_DragBehavior(DragBehavior);
end;

function TadxMSFormsComboBox.Get_DragBehavior: fmDragBehavior;
begin
  Result := fmDragBehaviorDisabled;
  if Connected then
    Result := DefaultInterface.Get_DragBehavior;
end;

function TadxMSFormsComboBox.Get_DisplayStyle: fmDisplayStyle;
begin
  Result := fmDisplayStyleText;
  if Connected then
    Result := DefaultInterface.Get_DisplayStyle;
end;

{ TadxMSFormsCommandButton }

function TadxMSFormsCommandButton.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.CommandButton';
end;

function TadxMSFormsCommandButton.GetControlType: TadxNativeMSFControl;
begin
  Result := msfCommandButton;
end;

function TadxMSFormsCommandButton.GetConnected: boolean;
begin
  Result := DefaultInterface <> nil;
end;

procedure TadxMSFormsCommandButton.Connect;
begin
end;

procedure TadxMSFormsCommandButton.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as ICommandButton;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsCommandButton.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsCommandButton.GetDefaultInterface: ICommandButton;
begin
  Result := FIntf;
end;

procedure TadxMSFormsCommandButton.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{D7053240-CE69-11CD-A777-00DD01143C57}';
    IntfIID:  '{04598FC4-866C-11CF-AB7C-00AA00C08FCF}';
    EventIID: '{7B020EC1-AF6C-11CE-9F46-00AA00574A4F}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMSFormsCommandButton.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  try
    case DispID of
      -1: Exit;  // DISPID_UNKNOWN
      3: if Assigned(FOnBeforeDragOver) then
          FOnBeforeDragOver(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            IUnknown(TVarData(Params[1]).VPointer) as DataObject,
            Params[2], Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      4: if Assigned(FOnBeforeDropOrPaste) then
          FOnBeforeDropOrPaste(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            Params[1], IUnknown(TVarData(Params[2]).VPointer) as DataObject,
            Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      -600: if Assigned(FOnClick) then FOnClick(Self);
      -601: if Assigned(FOnDblClick) then
          FOnDblClick(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean);
      -608: if Assigned(FOnError) then
          FOnError(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ReturnString,
            Params[2], Params[3], Params[4], Params[5],
            IUnknown(TVarData(Params[6]).VPointer) as ReturnBoolean);
      -602: if Assigned(FOnKeyDown) then
          FOnKeyDown(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -603: if Assigned(FOnKeyPress) then
          FOnKeyPress(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger);
      -604: if Assigned(FOnKeyUp) then
          FOnKeyUp(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -605: if Assigned(FOnMouseDown) then
          FOnMouseDown(Self, Params[0], Params[1], Params[2], Params[3]);
      -606: if Assigned(FOnMouseMove) then
          FOnMouseMove(Self, Params[0], Params[1], Params[2], Params[3]);
      -607: if Assigned(FOnMouseUp) then
          FOnMouseUp(Self, Params[0], Params[1], Params[2], Params[3]);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxMSFormsCommandButton.Set_AutoSize(fvbAutoSize: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoSize(fvbAutoSize);
end;

function TadxMSFormsCommandButton.Get_AutoSize: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_AutoSize;
end;

procedure TadxMSFormsCommandButton.Set_BackColor(BackColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BackColor(BackColor);
end;

function TadxMSFormsCommandButton.Get_BackColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BackColor;
end;

procedure TadxMSFormsCommandButton.Set_BackStyle(BackStyle: fmBackStyle);
begin
  if Connected then
    DefaultInterface.Set_BackStyle(BackStyle);
end;

function TadxMSFormsCommandButton.Get_BackStyle: fmBackStyle;
begin
  Result := fmBackStyleTransparent;
  if Connected then
    Result := DefaultInterface.Get_BackStyle;
end;

procedure TadxMSFormsCommandButton.Set_Caption(const bstrCaption: WideString);
begin
  if Connected then
    DefaultInterface.Set_Caption(bstrCaption);
end;

function TadxMSFormsCommandButton.Get_Caption: WideString;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_Caption;
end;

procedure TadxMSFormsCommandButton.Set_Enabled(fEnabled: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Enabled(fEnabled);
end;

function TadxMSFormsCommandButton.Get_Enabled: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Enabled;
end;

procedure TadxMSFormsCommandButton.Set__Font_Reserved(const Param1: IFontDisp);
begin
  if Connected then
    DefaultInterface.Set__Font_Reserved(Param1);
end;

procedure TadxMSFormsCommandButton._Set_Font(const Font: IFontDisp);
begin
  if Connected then
{$IFDEF ADX_VCL5}
    DefaultInterface.Set_Font(Font);
{$ELSE}
    DefaultInterface._Set_Font(Font);
{$ENDIF}
end;

function TadxMSFormsCommandButton.Get_Font: IFontDisp;
begin
  Result := nil;
  if Connected then
    Result := DefaultInterface.Get_Font;
end;

procedure TadxMSFormsCommandButton.Set_FontBold(FontBold: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontBold(FontBold);
end;

function TadxMSFormsCommandButton.Get_FontBold: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontBold;
end;

procedure TadxMSFormsCommandButton.Set_FontItalic(FontItalic: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontItalic(FontItalic);
end;

function TadxMSFormsCommandButton.Get_FontItalic: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontItalic;
end;

procedure TadxMSFormsCommandButton.Set_FontName(const FontName: WideString);
begin
  if Connected then
    DefaultInterface.Set_FontName(FontName);
end;

function TadxMSFormsCommandButton.Get_FontName: WideString;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_FontName;
end;

procedure TadxMSFormsCommandButton.Set_FontSize(FontSize: Currency);
begin
  if Connected then
    DefaultInterface.Set_FontSize(FontSize);
end;

function TadxMSFormsCommandButton.Get_FontSize: Currency;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontSize;
end;

procedure TadxMSFormsCommandButton.Set_FontStrikethru(FontStrikethru: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontStrikethru(FontStrikethru);
end;

function TadxMSFormsCommandButton.Get_FontStrikethru: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontStrikethru;
end;

procedure TadxMSFormsCommandButton.Set_FontUnderline(FontUnderline: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontUnderline(FontUnderline);
end;

function TadxMSFormsCommandButton.Get_FontUnderline: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontUnderline;
end;

procedure TadxMSFormsCommandButton.Set_ForeColor(ForeColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_ForeColor(ForeColor);
end;

function TadxMSFormsCommandButton.Get_ForeColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ForeColor;
end;

procedure TadxMSFormsCommandButton.Set_TakeFocusOnClick(TakeFocusOnClick: WordBool);
begin
  if Connected then
    DefaultInterface.Set_TakeFocusOnClick(TakeFocusOnClick);
end;

function TadxMSFormsCommandButton.Get_TakeFocusOnClick: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_TakeFocusOnClick;
end;

procedure TadxMSFormsCommandButton.Set_Locked(fLocked: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Locked(fLocked);
end;

function TadxMSFormsCommandButton.Get_Locked: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Locked;
end;

procedure TadxMSFormsCommandButton.Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_MouseIcon(MouseIcon);
end;

procedure TadxMSFormsCommandButton._Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_MouseIcon(MouseIcon);
end;

function TadxMSFormsCommandButton.Get_MouseIcon: IPictureDisp;
begin
  Result := nil;
  if Connected then
    Result := DefaultInterface.Get_MouseIcon;
end;

procedure TadxMSFormsCommandButton.Set_MousePointer(mouseptr: fmMousePointer);
begin
  if Connected then
    DefaultInterface.Set_MousePointer(mouseptr);
end;

function TadxMSFormsCommandButton.Get_MousePointer: fmMousePointer;
begin
  Result := fmMousePointerDefault;
  if Connected then
    Result := DefaultInterface.Get_MousePointer;
end;

procedure TadxMSFormsCommandButton.Set_Picture(const Picture: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_Picture(Picture);
end;

procedure TadxMSFormsCommandButton._Set_Picture(const Picture: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_Picture(Picture);
end;

function TadxMSFormsCommandButton.Get_Picture: IPictureDisp;
begin
  Result := nil;
  if Connected then
    Result := DefaultInterface.Get_Picture;
end;

procedure TadxMSFormsCommandButton.Set_PicturePosition(PicturePosition: fmPicturePosition);
begin
  if Connected then
    DefaultInterface.Set_PicturePosition(PicturePosition);
end;

function TadxMSFormsCommandButton.Get_PicturePosition: fmPicturePosition;
begin
  Result := fmPicturePositionLeftTop;
  if Connected then
    Result := DefaultInterface.Get_PicturePosition;
end;

procedure TadxMSFormsCommandButton.Set_Accelerator(const Accelerator: WideString);
begin
  if Connected then
    DefaultInterface.Set_Accelerator(Accelerator);
end;

function TadxMSFormsCommandButton.Get_Accelerator: WideString;
begin
  Result := '';
  if Connected then
    Result := DefaultInterface.Get_Accelerator;
end;

procedure TadxMSFormsCommandButton.Set_WordWrap(WordWrap: WordBool);
begin
  if Connected then
    DefaultInterface.Set_WordWrap(WordWrap);
end;

function TadxMSFormsCommandButton.Get_WordWrap: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_WordWrap;
end;

procedure TadxMSFormsCommandButton.Set_Value(fValue: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Value(fValue);
end;

function TadxMSFormsCommandButton.Get_Value: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Value;
end;

procedure TadxMSFormsCommandButton.Set_FontWeight(FontWeight: Smallint);
begin
  if Connected then
    DefaultInterface.Set_FontWeight(FontWeight);
end;

function TadxMSFormsCommandButton.Get_FontWeight: Smallint;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontWeight;
end;

{ TadxMSFormsImage }

function TadxMSFormsImage.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.Image';
end;

function TadxMSFormsImage.GetControlType: TadxNativeMSFControl;
begin
  Result := msfImage;
end;

function TadxMSFormsImage.GetConnected: boolean;
begin
  Result := DefaultInterface <> nil;
end;

procedure TadxMSFormsImage.Connect;
begin
end;

procedure TadxMSFormsImage.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as IImage;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsImage.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsImage.GetDefaultInterface: IImage;
begin
  Result := FIntf;
end;

procedure TadxMSFormsImage.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{4C599241-6926-101B-9992-00000B65C6F9}';
    IntfIID:  '{4C599243-6926-101B-9992-00000B65C6F9}';
    EventIID: '{4C5992A5-6926-101B-9992-00000B65C6F9}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMSFormsImage.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  try
    case DispID of
      -1: Exit;  // DISPID_UNKNOWN
      3: if Assigned(FOnBeforeDragOver) then
          FOnBeforeDragOver(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            IUnknown(TVarData(Params[1]).VPointer) as DataObject,
            Params[2], Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      4: if Assigned(FOnBeforeDropOrPaste) then
          FOnBeforeDropOrPaste(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            Params[1], IUnknown(TVarData(Params[2]).VPointer) as DataObject,
            Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      -600: if Assigned(FOnClick) then FOnClick(Self);
      -601: if Assigned(FOnDblClick) then
          FOnDblClick(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean);
      -608: if Assigned(FOnError) then
          FOnError(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ReturnString,
            Params[2], Params[3], Params[4], Params[5],
            IUnknown(TVarData(Params[6]).VPointer) as ReturnBoolean);
      -605: if Assigned(FOnMouseDown) then
          FOnMouseDown(Self, Params[0], Params[1], Params[2], Params[3]);
      -606: if Assigned(FOnMouseMove) then
          FOnMouseMove(Self, Params[0], Params[1], Params[2], Params[3]);
      -607: if Assigned(FOnMouseUp) then
          FOnMouseUp(Self, Params[0], Params[1], Params[2], Params[3]);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxMSFormsImage.Set_Enabled(fEnabled: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Enabled(fEnabled);
end;

function TadxMSFormsImage.Get_Enabled: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Enabled;
end;

procedure TadxMSFormsImage.Set_MousePointer(MousePointer: fmMousePointer);
begin
  if Connected then
    DefaultInterface.Set_MousePointer(MousePointer);
end;

function TadxMSFormsImage.Get_MousePointer: fmMousePointer;
begin
  Result := fmMousePointerDefault;
  if Connected then
    Result := DefaultInterface.Get_MousePointer;
end;

procedure TadxMSFormsImage.Set_AutoSize(fAutoSize: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoSize(fAutoSize);
end;

function TadxMSFormsImage.Get_AutoSize: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_AutoSize;
end;

procedure TadxMSFormsImage.Set_BackColor(BackColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BackColor(BackColor);
end;

function TadxMSFormsImage.Get_BackColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BackColor;
end;

procedure TadxMSFormsImage.Set_BackStyle(BackStyle: fmBackStyle);
begin
  if Connected then
    DefaultInterface.Set_BackStyle(BackStyle);
end;

function TadxMSFormsImage.Get_BackStyle: fmBackStyle;
begin
  Result := fmBackStyleTransparent;
  if Connected then
    Result := DefaultInterface.Get_BackStyle;
end;

procedure TadxMSFormsImage.Set_BorderColor(BorderColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BorderColor(BorderColor);
end;

function TadxMSFormsImage.Get_BorderColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BorderColor;
end;

procedure TadxMSFormsImage.Set_BorderStyle(Style: fmBorderStyle);
begin
  if Connected then
    DefaultInterface.Set_BorderStyle(Style);
end;

function TadxMSFormsImage.Get_BorderStyle: fmBorderStyle;
begin
  Result := fmBorderStyleNone;
  if Connected then
    Result := DefaultInterface.Get_BorderStyle;
end;

procedure TadxMSFormsImage.Set_Picture(const Picture: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_Picture(Picture);
end;

procedure TadxMSFormsImage._Set_Picture(const Picture: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_Picture(Picture);
end;

function TadxMSFormsImage.Get_Picture: IPictureDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_Picture;
end;

procedure TadxMSFormsImage.Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_MouseIcon(MouseIcon);
end;

procedure TadxMSFormsImage._Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_MouseIcon(MouseIcon);
end;

function TadxMSFormsImage.Get_MouseIcon: IPictureDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_MouseIcon;
end;

procedure TadxMSFormsImage.Set_PictureSizeMode(PictureSizeMode: fmPictureSizeMode);
begin
  if Connected then
    DefaultInterface.Set_PictureSizeMode(PictureSizeMode);
end;

function TadxMSFormsImage.Get_PictureSizeMode: fmPictureSizeMode;
begin
  Result := fmPictureSizeModeClip;
  if Connected then
    Result := DefaultInterface.Get_PictureSizeMode;
end;

procedure TadxMSFormsImage.Set_PictureAlignment(PictureAlignment: fmPictureAlignment);
begin
  if Connected then
    DefaultInterface.Set_PictureAlignment(PictureAlignment);
end;

function TadxMSFormsImage.Get_PictureAlignment: fmPictureAlignment;
begin
  Result := fmPictureAlignmentTopLeft;
  if Connected then
    Result := DefaultInterface.Get_PictureAlignment;
end;

procedure TadxMSFormsImage.Set_PictureTiling(PictureTiling: WordBool);
begin
  if Connected then
    DefaultInterface.Set_PictureTiling(PictureTiling);
end;

function TadxMSFormsImage.Get_PictureTiling: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_PictureTiling;
end;

procedure TadxMSFormsImage.Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
begin
  if Connected then
    DefaultInterface.Set_SpecialEffect(SpecialEffect);
end;

function TadxMSFormsImage.Get_SpecialEffect: fmSpecialEffect;
begin
  Result := fmSpecialEffectFlat;
  if Connected then
    Result := DefaultInterface.Get_SpecialEffect;
end;

{ TadxMSFormsLabelControl }

function TadxMSFormsLabelControl.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.Label';
end;

function TadxMSFormsLabelControl.GetControlType: TadxNativeMSFControl;
begin
  Result := msfLabel;
end;

function TadxMSFormsLabelControl.GetConnected: boolean;
begin
  Result := DefaultInterface <> nil;
end;

procedure TadxMSFormsLabelControl.Connect;
begin
end;

procedure TadxMSFormsLabelControl.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as ILabelControl;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsLabelControl.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsLabelControl.GetDefaultInterface: ILabelControl;
begin
  Result := FIntf;
end;

procedure TadxMSFormsLabelControl.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{978C9E23-D4B0-11CE-BF2D-00AA003F40D0}';
    IntfIID:  '{04598FC1-866C-11CF-AB7C-00AA00C08FCF}';
    EventIID: '{978C9E22-D4B0-11CE-BF2D-00AA003F40D0}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMSFormsLabelControl.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  try
    case DispID of
      -1: Exit;  // DISPID_UNKNOWN
      3: if Assigned(FOnBeforeDragOver) then
          FOnBeforeDragOver(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            IUnknown(TVarData(Params[1]).VPointer) as DataObject,
            Params[2], Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      4: if Assigned(FOnBeforeDropOrPaste) then
          FOnBeforeDropOrPaste(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            Params[1], IUnknown(TVarData(Params[2]).VPointer) as DataObject,
            Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      -600: if Assigned(FOnClick) then FOnClick(Self);
      -601: if Assigned(FOnDblClick) then
          FOnDblClick(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean);
      -608: if Assigned(FOnError) then
          FOnError(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ReturnString,
            Params[2], Params[3], Params[4], Params[5],
            IUnknown(TVarData(Params[6]).VPointer) as ReturnBoolean);
      -605: if Assigned(FOnMouseDown) then
          FOnMouseDown(Self, Params[0], Params[1], Params[2], Params[3]);
      -606: if Assigned(FOnMouseMove) then
          FOnMouseMove(Self, Params[0], Params[1], Params[2], Params[3]);
      -607: if Assigned(FOnMouseUp) then
          FOnMouseUp(Self, Params[0], Params[1], Params[2], Params[3]);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxMSFormsLabelControl.Set_AutoSize(fvbAutoSize: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoSize(fvbAutoSize);
end;

function TadxMSFormsLabelControl.Get_AutoSize: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_AutoSize;
end;

procedure TadxMSFormsLabelControl.Set_BackColor(BackColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BackColor(BackColor);
end;

function TadxMSFormsLabelControl.Get_BackColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BackColor;
end;

procedure TadxMSFormsLabelControl.Set_BackStyle(BackStyle: fmBackStyle);
begin
  if Connected then
    DefaultInterface.Set_BackStyle(BackStyle);
end;

function TadxMSFormsLabelControl.Get_BackStyle: fmBackStyle;
begin
  Result := fmBackStyleTransparent;
  if Connected then
    Result := DefaultInterface.Get_BackStyle;
end;

procedure TadxMSFormsLabelControl.Set_BorderColor(BorderColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BorderColor(BorderColor);
end;

function TadxMSFormsLabelControl.Get_BorderColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BorderColor;
end;

procedure TadxMSFormsLabelControl.Set_BorderStyle(BorderStyle: fmBorderStyle);
begin
  if Connected then
    DefaultInterface.Set_BorderStyle(BorderStyle);
end;

function TadxMSFormsLabelControl.Get_BorderStyle: fmBorderStyle;
begin
  Result := fmBorderStyleNone;
  if Connected then
    Result := DefaultInterface.Get_BorderStyle;
end;

procedure TadxMSFormsLabelControl.Set_Caption(const bstrCaption: WideString);
begin
  if Connected then
    DefaultInterface.Set_Caption(bstrCaption);
end;

function TadxMSFormsLabelControl.Get_Caption: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_Caption;
end;

procedure TadxMSFormsLabelControl.Set_Enabled(fEnabled: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Enabled(fEnabled);
end;

function TadxMSFormsLabelControl.Get_Enabled: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Enabled;
end;

procedure TadxMSFormsLabelControl.Set__Font_Reserved(const Param1: IFontDisp);
begin
  if Connected then
    DefaultInterface.Set__Font_Reserved(Param1);
end;

procedure TadxMSFormsLabelControl._Set_Font(const Font: IFontDisp);
begin
  if Connected then
{$IFDEF ADX_VCL5}
    DefaultInterface.Set_Font(Font);
{$ELSE}
    DefaultInterface._Set_Font(Font);
{$ENDIF}
end;

function TadxMSFormsLabelControl.Get_Font: IFontDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_Font;
end;

procedure TadxMSFormsLabelControl.Set_FontItalic(FontItalic: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontItalic(FontItalic);
end;

function TadxMSFormsLabelControl.Get_FontItalic: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontItalic;
end;

procedure TadxMSFormsLabelControl.Set_FontBold(FontBold: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontBold(FontBold);
end;

function TadxMSFormsLabelControl.Get_FontBold: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontBold;
end;

procedure TadxMSFormsLabelControl.Set_FontName(const FontName: WideString);
begin
  if Connected then
    DefaultInterface.Set_FontName(FontName);
end;

function TadxMSFormsLabelControl.Get_FontName: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_FontName;
end;

procedure TadxMSFormsLabelControl.Set_FontSize(FontSize: Currency);
begin
  if Connected then
    DefaultInterface.Set_FontSize(FontSize);
end;

function TadxMSFormsLabelControl.Get_FontSize: Currency;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontSize;
end;

procedure TadxMSFormsLabelControl.Set_FontStrikethru(FontStrikethru: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontStrikethru(FontStrikethru);
end;

function TadxMSFormsLabelControl.Get_FontStrikethru: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontStrikethru;
end;

procedure TadxMSFormsLabelControl.Set_FontUnderline(FontUnderline: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontUnderline(FontUnderline);
end;

function TadxMSFormsLabelControl.Get_FontUnderline: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontUnderline;
end;

procedure TadxMSFormsLabelControl.Set_ForeColor(ForeColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_ForeColor(ForeColor);
end;

function TadxMSFormsLabelControl.Get_ForeColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ForeColor;
end;

procedure TadxMSFormsLabelControl.Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_MouseIcon(MouseIcon);
end;

procedure TadxMSFormsLabelControl._Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_MouseIcon(MouseIcon);
end;

function TadxMSFormsLabelControl.Get_MouseIcon: IPictureDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_MouseIcon;
end;

procedure TadxMSFormsLabelControl.Set_MousePointer(MousePointer: fmMousePointer);
begin
  if Connected then
    DefaultInterface.Set_MousePointer(MousePointer);
end;

function TadxMSFormsLabelControl.Get_MousePointer: fmMousePointer;
begin
  Result := fmMousePointerDefault;
  if Connected then
    Result := DefaultInterface.Get_MousePointer;
end;

procedure TadxMSFormsLabelControl.Set_Picture(const pPicture: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_Picture(pPicture);
end;

procedure TadxMSFormsLabelControl._Set_Picture(const pPicture: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_Picture(pPicture);
end;

function TadxMSFormsLabelControl.Get_Picture: IPictureDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_Picture;
end;

procedure TadxMSFormsLabelControl.Set_PicturePosition(PicPos: fmPicturePosition);
begin
  if Connected then
    DefaultInterface.Set_PicturePosition(PicPos);
end;

function TadxMSFormsLabelControl.Get_PicturePosition: fmPicturePosition;
begin
  Result := fmPicturePositionLeftTop;
  if Connected then
    Result := DefaultInterface.Get_PicturePosition;
end;

procedure TadxMSFormsLabelControl.Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
begin
  if Connected then
    DefaultInterface.Set_SpecialEffect(SpecialEffect);
end;

function TadxMSFormsLabelControl.Get_SpecialEffect: fmSpecialEffect;
begin
  Result := fmSpecialEffectFlat;
  if Connected then
    Result := DefaultInterface.Get_SpecialEffect;
end;

procedure TadxMSFormsLabelControl.Set_TextAlign(TextAlign: fmTextAlign);
begin
  if Connected then
    DefaultInterface.Set_TextAlign(TextAlign);
end;

function TadxMSFormsLabelControl.Get_TextAlign: fmTextAlign;
begin
  Result := fmTextAlignLeft;
  if Connected then
    Result := DefaultInterface.Get_TextAlign;
end;

procedure TadxMSFormsLabelControl.Set_WordWrap(WordWrap: WordBool);
begin
  if Connected then
    DefaultInterface.Set_WordWrap(WordWrap);
end;

function TadxMSFormsLabelControl.Get_WordWrap: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_WordWrap;
end;

procedure TadxMSFormsLabelControl.Set_Accelerator(const Accelerator: WideString);
begin
  if Connected then
    DefaultInterface.Set_Accelerator(Accelerator);
end;

function TadxMSFormsLabelControl.Get_Accelerator: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_Accelerator;
end;

procedure TadxMSFormsLabelControl.Set_FontWeight(FontWeight: Smallint);
begin
  if Connected then
    DefaultInterface.Set_FontWeight(FontWeight);
end;

function TadxMSFormsLabelControl.Get_FontWeight: Smallint;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontWeight;
end;

procedure TadxMSFormsLabelControl.Set__Value(const bstrCaption: WideString);
begin
  if Connected then
    DefaultInterface.Set__Value(bstrCaption);
end;

function TadxMSFormsLabelControl.Get__Value: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get__Value;
end;

{ TadxMSFormsListBox }

function TadxMSFormsListBox.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.ListBox';
end;

function TadxMSFormsListBox.GetControlType: TadxNativeMSFControl;
begin
  Result := msfListBox;
end;

function TadxMSFormsListBox.GetConnected: boolean;
begin
  Result := DefaultInterface <> nil;
end;

procedure TadxMSFormsListBox.Connect;
begin
end;

procedure TadxMSFormsListBox.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as IMdcList;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsListBox.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsListBox.GetDefaultInterface: IMdcList;
begin
  Result := FIntf;
end;

procedure TadxMSFormsListBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{8BD21D20-EC42-11CE-9E0D-00AA006002F3}';
    IntfIID:  '{8BD21D23-EC42-11CE-9E0D-00AA006002F3}';
    EventIID: '{8BD21D22-EC42-11CE-9E0D-00AA006002F3}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMSFormsListBox.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  try
    case DispID of
      -1: Exit;  // DISPID_UNKNOWN
      3: if Assigned(FOnBeforeDragOver) then
          FOnBeforeDragOver(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            IUnknown(TVarData(Params[1]).VPointer) as DataObject,
            Params[2], Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      4: if Assigned(FOnBeforeDropOrPaste) then
          FOnBeforeDropOrPaste(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            Params[1], IUnknown(TVarData(Params[2]).VPointer) as DataObject,
            Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      2: if Assigned(FOnChange) then FOnChange(Self);
      -610: if Assigned(FOnClick) then FOnClick(Self);
      -601: if Assigned(FOnDblClick) then
          FOnDblClick(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean);
      -608: if Assigned(FOnError) then
          FOnError(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ReturnString,
            Params[2], Params[3], Params[4], Params[5],
            IUnknown(TVarData(Params[6]).VPointer) as ReturnBoolean);
      -602: if Assigned(FOnKeyDown) then
          FOnKeyDown(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -603: if Assigned(FOnKeyPress) then
          FOnKeyPress(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger);
      -604: if Assigned(FOnKeyUp) then
          FOnKeyUp(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -605: if Assigned(FOnMouseDown) then
          FOnMouseDown(Self, Params[0], Params[1], Params[2], Params[3]);
      -606: if Assigned(FOnMouseMove) then
          FOnMouseMove(Self, Params[0], Params[1], Params[2], Params[3]);
      -607: if Assigned(FOnMouseUp) then
          FOnMouseUp(Self, Params[0], Params[1], Params[2], Params[3]);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxMSFormsListBox.AddItem(var pvargItem: OleVariant; var pvargIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.AddItem(pvargItem, pvargIndex);
end;

procedure TadxMSFormsListBox.Clear;
begin
  if Connected then
    DefaultInterface.Clear;
end;

procedure TadxMSFormsListBox.RemoveItem(var pvargIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.RemoveItem(pvargIndex);
end;

procedure TadxMSFormsListBox.Set_BackColor(BackColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BackColor(BackColor);
end;

function TadxMSFormsListBox.Get_BackColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BackColor;
end;

procedure TadxMSFormsListBox.Set_BorderColor(BorderColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BorderColor(BorderColor);
end;

function TadxMSFormsListBox.Get_BorderColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BorderColor;
end;

procedure TadxMSFormsListBox.Set_BorderStyle(BorderStyle: fmBorderStyle);
begin
  if Connected then
    DefaultInterface.Set_BorderStyle(BorderStyle);
end;

function TadxMSFormsListBox.Get_BorderStyle: fmBorderStyle;
begin
  Result := fmBorderStyleNone;
  if Connected then
    Result := DefaultInterface.Get_BorderStyle;
end;

procedure TadxMSFormsListBox.Set_BordersSuppress(BordersSuppress: WordBool);
begin
  if Connected then
    DefaultInterface.Set_BordersSuppress(BordersSuppress);
end;

function TadxMSFormsListBox.Get_BordersSuppress: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_BordersSuppress;
end;

procedure TadxMSFormsListBox.Set_BoundColumn(var BoundColumn: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_BoundColumn(BoundColumn);
end;

procedure TadxMSFormsListBox.Set_BoundColumn2(BoundColumn: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_BoundColumn(BoundColumn);
end;

function TadxMSFormsListBox.Get_BoundColumn: OleVariant;
begin
  if Connected then
    Result := DefaultInterface.Get_BoundColumn;
end;

procedure TadxMSFormsListBox.Set_ColumnCount(ColumnCount: Integer);
begin
  if Connected then
    DefaultInterface.Set_ColumnCount(ColumnCount);
end;

function TadxMSFormsListBox.Get_ColumnCount: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ColumnCount;
end;

procedure TadxMSFormsListBox.Set_ColumnHeads(ColumnHeads: WordBool);
begin
  if Connected then
    DefaultInterface.Set_ColumnHeads(ColumnHeads);
end;

function TadxMSFormsListBox.Get_ColumnHeads: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_ColumnHeads;
end;

procedure TadxMSFormsListBox.Set_ColumnWidths(const ColumnWidths: WideString);
begin
  if Connected then
    DefaultInterface.Set_ColumnWidths(ColumnWidths);
end;

function TadxMSFormsListBox.Get_ColumnWidths: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_ColumnWidths;
end;

procedure TadxMSFormsListBox.Set_Enabled(Enabled: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Enabled(Enabled);
end;

function TadxMSFormsListBox.Get_Enabled: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Enabled;
end;

procedure TadxMSFormsListBox.Set__Font_Reserved(const Param1: IFontDisp);
begin
  if Connected then
    DefaultInterface.Set__Font_Reserved(Param1);
end;

procedure TadxMSFormsListBox._Set_Font(const Font: IFontDisp);
begin
  if Connected then
{$IFDEF ADX_VCL5}
    DefaultInterface.Set_Font(Font);
{$ELSE}
    DefaultInterface._Set_Font(Font);
{$ENDIF}
end;

function TadxMSFormsListBox.Get_Font: IFontDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_Font;
end;

procedure TadxMSFormsListBox.Set_FontBold(FontBold: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontBold(FontBold);
end;

function TadxMSFormsListBox.Get_FontBold: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontBold;
end;

procedure TadxMSFormsListBox.Set_FontItalic(FontItalic: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontItalic(FontItalic);
end;

function TadxMSFormsListBox.Get_FontItalic: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontItalic;
end;

procedure TadxMSFormsListBox.Set_FontName(const FontName: WideString);
begin
  if Connected then
    DefaultInterface.Set_FontName(FontName);
end;

function TadxMSFormsListBox.Get_FontName: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_FontName;
end;

procedure TadxMSFormsListBox.Set_FontSize(FontSize: Currency);
begin
  if Connected then
    DefaultInterface.Set_FontSize(FontSize);
end;

function TadxMSFormsListBox.Get_FontSize: Currency;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontSize;
end;

procedure TadxMSFormsListBox.Set_FontStrikethru(FontStrikethru: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontStrikethru(FontStrikethru);
end;

function TadxMSFormsListBox.Get_FontStrikethru: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontStrikethru;
end;

procedure TadxMSFormsListBox.Set_FontUnderline(FontUnderline: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontUnderline(FontUnderline);
end;

function TadxMSFormsListBox.Get_FontUnderline: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontUnderline;
end;

procedure TadxMSFormsListBox.Set_FontWeight(FontWeight: Smallint);
begin
  if Connected then
    DefaultInterface.Set_FontWeight(FontWeight);
end;

function TadxMSFormsListBox.Get_FontWeight: Smallint;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontWeight;
end;

procedure TadxMSFormsListBox.Set_ForeColor(ForeColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_ForeColor(ForeColor);
end;

function TadxMSFormsListBox.Get_ForeColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ForeColor;
end;

procedure TadxMSFormsListBox.Set_IntegralHeight(IntegralHeight: WordBool);
begin
  if Connected then
    DefaultInterface.Set_IntegralHeight(IntegralHeight);
end;

function TadxMSFormsListBox.Get_IntegralHeight: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_IntegralHeight;
end;

function TadxMSFormsListBox.Get_ListCount: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ListCount;
end;

procedure TadxMSFormsListBox.Set_ListCursor(const ListCursor: PIROWSET);
begin
  if Connected then
    DefaultInterface.Set_ListCursor(ListCursor);
end;

function TadxMSFormsListBox.Get_ListCursor: PIROWSET;
begin
  if Connected then
    Result := DefaultInterface.Get_ListCursor;
end;

procedure TadxMSFormsListBox.Set_ListIndex(var ListIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_ListIndex(ListIndex);
end;

procedure TadxMSFormsListBox.Set_ListIndex2(ListIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_ListIndex(ListIndex);
end;

function TadxMSFormsListBox.Get_ListIndex: OleVariant;
begin
  if Connected then
    Result := DefaultInterface.Get_ListIndex;
end;

procedure TadxMSFormsListBox.Set_ListStyle(ListStyle: fmListStyle);
begin
  if Connected then
    DefaultInterface.Set_ListStyle(ListStyle);
end;

function TadxMSFormsListBox.Get_ListStyle: fmListStyle;
begin
  Result := fmListStylePlain;
  if Connected then
    Result := DefaultInterface.Get_ListStyle;
end;

procedure TadxMSFormsListBox.Set_ListWidth(var ListWidth: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_ListWidth(ListWidth);
end;

procedure TadxMSFormsListBox.Set_ListWidth2(ListWidth: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_ListWidth(ListWidth);
end;

function TadxMSFormsListBox.Get_ListWidth: OleVariant;
begin
  if Connected then
    Result := DefaultInterface.Get_ListWidth;
end;

procedure TadxMSFormsListBox.Set_Locked(Locked: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Locked(Locked);
end;

function TadxMSFormsListBox.Get_Locked: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Locked;
end;

procedure TadxMSFormsListBox.Set_MatchEntry(MatchEntry: fmMatchEntry);
begin
  if Connected then
    DefaultInterface.Set_MatchEntry(MatchEntry);
end;

function TadxMSFormsListBox.Get_MatchEntry: fmMatchEntry;
begin
  Result := fmMatchEntryFirstLetter;
  if Connected then
    Result := DefaultInterface.Get_MatchEntry;
end;

procedure TadxMSFormsListBox.Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_MouseIcon(MouseIcon);
end;

procedure TadxMSFormsListBox._Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_MouseIcon(MouseIcon);
end;

function TadxMSFormsListBox.Get_MouseIcon: IPictureDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_MouseIcon;
end;

procedure TadxMSFormsListBox.Set_MousePointer(MousePointer: fmMousePointer);
begin
  if Connected then
    DefaultInterface.Set_MousePointer(MousePointer);
end;

function TadxMSFormsListBox.Get_MousePointer: fmMousePointer;
begin
  Result := fmMousePointerDefault;
  if Connected then
    Result := DefaultInterface.Get_MousePointer;
end;

procedure TadxMSFormsListBox.Set_MultiSelect(MultiSelect: fmMultiSelect);
begin
  if Connected then
    DefaultInterface.Set_MultiSelect(MultiSelect);
end;

function TadxMSFormsListBox.Get_MultiSelect: fmMultiSelect;
begin
  Result := fmMultiSelectSingle;
  if Connected then
    Result := DefaultInterface.Get_MultiSelect;
end;

procedure TadxMSFormsListBox.Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
begin
  if Connected then
    DefaultInterface.Set_SpecialEffect(SpecialEffect);
end;

function TadxMSFormsListBox.Get_SpecialEffect: fmSpecialEffect;
begin
  Result := fmSpecialEffectFlat;
  if Connected then
    Result := DefaultInterface.Get_SpecialEffect;
end;

procedure TadxMSFormsListBox.Set_Text(const Text: WideString);
begin
  if Connected then
    DefaultInterface.Set_Text(Text);
end;

function TadxMSFormsListBox.Get_Text: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_Text;
end;

procedure TadxMSFormsListBox.Set_TextColumn(var TextColumn: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_TextColumn(TextColumn);
end;

procedure TadxMSFormsListBox.Set_TextColumn2(TextColumn: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_TextColumn(TextColumn);
end;

function TadxMSFormsListBox.Get_TextColumn: OleVariant;
begin
  if Connected then
    Result := DefaultInterface.Get_TextColumn;
end;

procedure TadxMSFormsListBox.Set_TopIndex(var TopIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_TopIndex(TopIndex);
end;

procedure TadxMSFormsListBox.Set_TopIndex2(TopIndex: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_TopIndex(TopIndex);
end;

function TadxMSFormsListBox.Get_TopIndex: OleVariant;
begin
  if Connected then
    Result := DefaultInterface.Get_TopIndex;
end;

function TadxMSFormsListBox.Get_Valid: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Valid;
end;

procedure TadxMSFormsListBox.Set_Value(var Value: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

procedure TadxMSFormsListBox.Set_Value2(Value: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

function TadxMSFormsListBox.Get_Value: OleVariant;
begin
  if Connected then
    Result := DefaultInterface.Get_Value;
end;

function TadxMSFormsListBox.Get_Column(var pvargColumn: OleVariant; var pvargIndex: OleVariant): OleVariant;
begin
  if Connected then
    Result := DefaultInterface.Get_Column(pvargColumn, pvargIndex);
end;

procedure TadxMSFormsListBox.Set_Column(var pvargColumn: OleVariant; var pvargIndex: OleVariant; var pvargValue: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Column(pvargColumn, pvargIndex, pvargValue);
end;

procedure TadxMSFormsListBox.Set_Column2(var pvargColumn: OleVariant; var pvargIndex: OleVariant; pvargValue: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Column(pvargColumn, pvargIndex, pvargValue);
end;

function TadxMSFormsListBox.Get_List(var pvargIndex: OleVariant; var pvargColumn: OleVariant): OleVariant;
begin
  if Connected then
    Result := DefaultInterface.Get_List(pvargIndex, pvargColumn);
end;

procedure TadxMSFormsListBox.Set_List(var pvargIndex: OleVariant; var pvargColumn: OleVariant; var pvargValue: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_List(pvargIndex, pvargColumn, pvargValue);
end;

procedure TadxMSFormsListBox.Set_List2(var pvargIndex: OleVariant; var pvargColumn: OleVariant; pvargValue: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_List(pvargIndex, pvargColumn, pvargValue);
end;

function TadxMSFormsListBox.Get_Selected(var pvargIndex: OleVariant): WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Selected(pvargIndex);
end;

procedure TadxMSFormsListBox.Set_Selected(var pvargIndex: OleVariant; pfvb: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Selected(pvargIndex, pfvb);
end;

procedure TadxMSFormsListBox.Set_IMEMode(IMEMode: fmIMEMode);
begin
  if Connected then
    DefaultInterface.Set_IMEMode(IMEMode);
end;

function TadxMSFormsListBox.Get_IMEMode: fmIMEMode;
begin
  Result := fmIMEModeNoControl;
  if Connected then
    Result := DefaultInterface.Get_IMEMode;
end;

function TadxMSFormsListBox.Get_DisplayStyle: fmDisplayStyle;
begin
  Result := fmDisplayStyleText;
  if Connected then
    Result := DefaultInterface.Get_DisplayStyle;
end;

{$IFNDEF ADX_VCL6}
procedure TadxMSFormsListBox.Set_TextAlign(TextAlign: fmTextAlign);
begin
  if Connected then
    DefaultInterface.Set_TextAlign(TextAlign);
end;

function TadxMSFormsListBox.Get_TextAlign: fmTextAlign;
begin
  Result := fmTextAlignLeft;
  if Connected then
    Result := DefaultInterface.Get_TextAlign;
end;
{$ENDIF ADX_VCL6}

{ TadxMSFormsOptionButton }

function TadxMSFormsOptionButton.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.OptionButton';
end;

function TadxMSFormsOptionButton.GetControlType: TadxNativeMSFControl;
begin
  Result := msfOptionButton;
end;

procedure TadxMSFormsOptionButton.Connect;
begin
end;

procedure TadxMSFormsOptionButton.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as IMdcOptionButton;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsOptionButton.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsOptionButton.GetDefaultInterface: IMdcOptionButton;
begin
  Result := FIntf;
end;

procedure TadxMSFormsOptionButton.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{8BD21D50-EC42-11CE-9E0D-00AA006002F3}';
    IntfIID:  '{8BD21D53-EC42-11CE-9E0D-00AA006002F3}';
    EventIID: '{8BD21D52-EC42-11CE-9E0D-00AA006002F3}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

{ TadxMSFormsScrollBar }

function TadxMSFormsScrollBar.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.ScrollBar';
end;

function TadxMSFormsScrollBar.GetControlType: TadxNativeMSFControl;
begin
  Result := msfScrollBar;
end;

function TadxMSFormsScrollBar.GetConnected: boolean;
begin
  Result := DefaultInterface <> nil;
end;

procedure TadxMSFormsScrollBar.Connect;
begin
end;

procedure TadxMSFormsScrollBar.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as IScrollbar;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsScrollBar.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsScrollBar.GetDefaultInterface: IScrollbar;
begin
  Result := FIntf;
end;

procedure TadxMSFormsScrollBar.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{DFD181E0-5E2F-11CE-A449-00AA004A803D}';
    IntfIID:  '{04598FC3-866C-11CF-AB7C-00AA00C08FCF}';
    EventIID: '{7B020EC2-AF6C-11CE-9F46-00AA00574A4F}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMSFormsScrollBar.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  try
    case DispID of
      -1: Exit;  // DISPID_UNKNOWN
      3: if Assigned(FOnBeforeDragOver) then
          FOnBeforeDragOver(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            IUnknown(TVarData(Params[1]).VPointer) as DataObject,
            Params[2], Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      4: if Assigned(FOnBeforeDropOrPaste) then
          FOnBeforeDropOrPaste(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            Params[1], IUnknown(TVarData(Params[2]).VPointer) as DataObject,
            Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      2: if Assigned(FOnChange) then FOnChange(Self);
      -608: if Assigned(FOnError) then
          FOnError(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ReturnString,
            Params[2], Params[3], Params[4], Params[5],
            IUnknown(TVarData(Params[6]).VPointer) as ReturnBoolean);
      -602: if Assigned(FOnKeyDown) then
          FOnKeyDown(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -603: if Assigned(FOnKeyPress) then
          FOnKeyPress(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger);
      -604: if Assigned(FOnKeyUp) then
          FOnKeyUp(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      7: if Assigned(FOnScroll) then FOnScroll(Self);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxMSFormsScrollBar.Set_BackColor(BackColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BackColor(BackColor);
end;

function TadxMSFormsScrollBar.Get_BackColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BackColor;
end;

procedure TadxMSFormsScrollBar.Set_ForeColor(ForeColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_ForeColor(ForeColor);
end;

function TadxMSFormsScrollBar.Get_ForeColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ForeColor;
end;

procedure TadxMSFormsScrollBar.Set_Enabled(Enabled: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Enabled(Enabled);
end;

function TadxMSFormsScrollBar.Get_Enabled: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Enabled;
end;

procedure TadxMSFormsScrollBar.Set_MousePointer(MousePointer: fmMousePointer);
begin
  if Connected then
    DefaultInterface.Set_MousePointer(MousePointer);
end;

function TadxMSFormsScrollBar.Get_MousePointer: fmMousePointer;
begin
  Result := fmMousePointerDefault;
  if Connected then
    Result := DefaultInterface.Get_MousePointer;
end;

procedure TadxMSFormsScrollBar.Set_Value(Value: Integer);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

function TadxMSFormsScrollBar.Get_Value: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_Value;
end;

procedure TadxMSFormsScrollBar.Set_Min(Min: Integer);
begin
  if Connected then
    DefaultInterface.Set_Min(Min);
end;

function TadxMSFormsScrollBar.Get_Min: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_Min;
end;

procedure TadxMSFormsScrollBar.Set_Max(Max: Integer);
begin
  if Connected then
    DefaultInterface.Set_Max(Max);
end;

function TadxMSFormsScrollBar.Get_Max: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_Max;
end;

procedure TadxMSFormsScrollBar.Set_SmallChange(SmallChange: Integer);
begin
  if Connected then
    DefaultInterface.Set_SmallChange(SmallChange);
end;

function TadxMSFormsScrollBar.Get_SmallChange: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_SmallChange;
end;

procedure TadxMSFormsScrollBar.Set_LargeChange(LargeChange: Integer);
begin
  if Connected then
    DefaultInterface.Set_LargeChange(LargeChange);
end;

function TadxMSFormsScrollBar.Get_LargeChange: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_LargeChange;
end;

procedure TadxMSFormsScrollBar.Set_ProportionalThumb(ProportionalThumb: WordBool);
begin
  if Connected then
    DefaultInterface.Set_ProportionalThumb(ProportionalThumb);
end;

function TadxMSFormsScrollBar.Get_ProportionalThumb: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_ProportionalThumb;
end;

procedure TadxMSFormsScrollBar.Set_Orientation(Orientation: fmOrientation);
begin
  if Connected then
    DefaultInterface.Set_Orientation(Orientation);
end;

function TadxMSFormsScrollBar.Get_Orientation: fmOrientation;
begin
  Result := TOleEnum(fmOrientationAuto);
  if Connected then
    Result := DefaultInterface.Get_Orientation;
end;

procedure TadxMSFormsScrollBar.Set_Delay(Delay: Integer);
begin
  if Connected then
    DefaultInterface.Set_Delay(Delay);
end;

function TadxMSFormsScrollBar.Get_Delay: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_Delay;
end;

procedure TadxMSFormsScrollBar.Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_MouseIcon(MouseIcon);
end;

procedure TadxMSFormsScrollBar._Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_MouseIcon(MouseIcon);
end;

function TadxMSFormsScrollBar.Get_MouseIcon: IPictureDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_MouseIcon;
end;

{ TadxMSFormsSpinButton }

function TadxMSFormsSpinButton.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.SpinButton';
end;

function TadxMSFormsSpinButton.GetControlType: TadxNativeMSFControl;
begin
  Result := msfSpinButton;
end;

function TadxMSFormsSpinButton.GetConnected: boolean;
begin
  Result := DefaultInterface <> nil;
end;

procedure TadxMSFormsSpinButton.Connect;
begin
end;

procedure TadxMSFormsSpinButton.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as ISpinbutton;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsSpinButton.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsSpinButton.GetDefaultInterface: ISpinbutton;
begin
  Result := FIntf;
end;

procedure TadxMSFormsSpinButton.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{79176FB0-B7F2-11CE-97EF-00AA006D2776}';
    IntfIID:  '{79176FB3-B7F2-11CE-97EF-00AA006D2776}';
    EventIID: '{79176FB2-B7F2-11CE-97EF-00AA006D2776}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMSFormsSpinButton.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  try
    case DispID of
      -1: Exit;  // DISPID_UNKNOWN
      3: if Assigned(FOnBeforeDragOver) then
          FOnBeforeDragOver(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            IUnknown(TVarData(Params[1]).VPointer) as DataObject,
            Params[2], Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      4: if Assigned(FOnBeforeDropOrPaste) then
          FOnBeforeDropOrPaste(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            Params[1], IUnknown(TVarData(Params[2]).VPointer) as DataObject,
            Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      2: if Assigned(FOnChange) then FOnChange(Self);
      -608: if Assigned(FOnError) then
          FOnError(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ReturnString,
            Params[2], Params[3], Params[4], Params[5],
            IUnknown(TVarData(Params[6]).VPointer) as ReturnBoolean);
      -602: if Assigned(FOnKeyDown) then
          FOnKeyDown(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -603: if Assigned(FOnKeyPress) then
          FOnKeyPress(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger);
      -604: if Assigned(FOnKeyUp) then
          FOnKeyUp(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      5: if Assigned(FOnSpinUp) then FOnSpinUp(Self);
      6: if Assigned(FOnSpinDown) then FOnSpinDown(Self);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxMSFormsSpinButton.Set_BackColor(BackColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BackColor(BackColor);
end;

function TadxMSFormsSpinButton.Get_BackColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BackColor;
end;

procedure TadxMSFormsSpinButton.Set_ForeColor(ForeColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_ForeColor(ForeColor);
end;

function TadxMSFormsSpinButton.Get_ForeColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ForeColor;
end;

procedure TadxMSFormsSpinButton.Set_Enabled(Enabled: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Enabled(Enabled);
end;

function TadxMSFormsSpinButton.Get_Enabled: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Enabled;
end;

procedure TadxMSFormsSpinButton.Set_MousePointer(MousePointer: fmMousePointer);
begin
  if Connected then
    DefaultInterface.Set_MousePointer(MousePointer);
end;

function TadxMSFormsSpinButton.Get_MousePointer: fmMousePointer;
begin
  Result := fmMousePointerDefault;
  if Connected then
    Result := DefaultInterface.Get_MousePointer;
end;

procedure TadxMSFormsSpinButton.Set_Value(Value: Integer);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

function TadxMSFormsSpinButton.Get_Value: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_Value;
end;

procedure TadxMSFormsSpinButton.Set_Min(Min: Integer);
begin
  if Connected then
    DefaultInterface.Set_Min(Min);
end;

function TadxMSFormsSpinButton.Get_Min: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_Min;
end;

procedure TadxMSFormsSpinButton.Set_Max(Max: Integer);
begin
  if Connected then
    DefaultInterface.Set_Max(Max);
end;

function TadxMSFormsSpinButton.Get_Max: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_Max;
end;

procedure TadxMSFormsSpinButton.Set_SmallChange(SmallChange: Integer);
begin
  if Connected then
    DefaultInterface.Set_SmallChange(SmallChange);
end;

function TadxMSFormsSpinButton.Get_SmallChange: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_SmallChange;
end;

procedure TadxMSFormsSpinButton.Set_Orientation(Orientation: fmOrientation);
begin
  if Connected then
    DefaultInterface.Set_Orientation(Orientation);
end;

function TadxMSFormsSpinButton.Get_Orientation: fmOrientation;
begin
  Result := TOleEnum(fmOrientationAuto);
  if Connected then
    Result := DefaultInterface.Get_Orientation;
end;

procedure TadxMSFormsSpinButton.Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_MouseIcon(MouseIcon);
end;

procedure TadxMSFormsSpinButton._Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_MouseIcon(MouseIcon);
end;

function TadxMSFormsSpinButton.Get_MouseIcon: IPictureDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_MouseIcon;
end;

procedure TadxMSFormsSpinButton.Set_Delay(Delay: Integer);
begin
  if Connected then
    DefaultInterface.Set_Delay(Delay);
end;

function TadxMSFormsSpinButton.Get_Delay: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_Delay;
end;

{ TadxMSFormsTextBox }

function TadxMSFormsTextBox.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.TextBox';
end;

function TadxMSFormsTextBox.GetControlType: TadxNativeMSFControl;
begin
  Result := msfTextBox;
end;

function TadxMSFormsTextBox.GetConnected: boolean;
begin
  Result := DefaultInterface <> nil;
end;

procedure TadxMSFormsTextBox.Connect;
begin
end;

procedure TadxMSFormsTextBox.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as IMdcText;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsTextBox.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsTextBox.GetDefaultInterface: IMdcText;
begin
  Result := FIntf;
end;

procedure TadxMSFormsTextBox.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{8BD21D10-EC42-11CE-9E0D-00AA006002F3}';
    IntfIID:  '{8BD21D13-EC42-11CE-9E0D-00AA006002F3}';
    EventIID: '{8BD21D12-EC42-11CE-9E0D-00AA006002F3}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TadxMSFormsTextBox.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  try
    case DispID of
      -1: Exit;  // DISPID_UNKNOWN
      3: if Assigned(FOnBeforeDragOver) then
          FOnBeforeDragOver(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            IUnknown(TVarData(Params[1]).VPointer) as DataObject,
            Params[2], Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      4: if Assigned(FOnBeforeDropOrPaste) then
          FOnBeforeDropOrPaste(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean,
            Params[1], IUnknown(TVarData(Params[2]).VPointer) as DataObject,
            Params[3], Params[4],
            IUnknown(TVarData(Params[5]).VPointer) as ReturnEffect, Params[6]);
      2: if Assigned(FOnChange) then FOnChange(Self);
      -601: if Assigned(FOnDblClick) then
          FOnDblClick(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnBoolean);
      2002: if Assigned(FOnDropButtonClick) then
          FOnDropButtonClick(Self);
      -608: if Assigned(FOnError) then
          FOnError(Self, Params[0], IUnknown(TVarData(Params[1]).VPointer) as ReturnString,
            Params[2], Params[3], Params[4], Params[5],
            IUnknown(TVarData(Params[6]).VPointer) as ReturnBoolean);
      -602: if Assigned(FOnKeyDown) then
          FOnKeyDown(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -603: if Assigned(FOnKeyPress) then
          FOnKeyPress(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger);
      -604: if Assigned(FOnKeyUp) then
          FOnKeyUp(Self, IUnknown(TVarData(Params[0]).VPointer) as ReturnInteger, Params[1]);
      -605: if Assigned(FOnMouseDown) then
          FOnMouseDown(Self, Params[0], Params[1], Params[2], Params[3]);
      -606: if Assigned(FOnMouseMove) then
          FOnMouseMove(Self, Params[0], Params[1], Params[2], Params[3]);
      -607: if Assigned(FOnMouseUp) then
          FOnMouseUp(Self, Params[0], Params[1], Params[2], Params[3]);
    end;
  except
    on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
  end;
end;

procedure TadxMSFormsTextBox.Copy;
begin
  if Connected then
    DefaultInterface.Copy;
end;

procedure TadxMSFormsTextBox.Cut;
begin
  if Connected then
    DefaultInterface.Cut;
end;

procedure TadxMSFormsTextBox.Paste;
begin
  if Connected then
    DefaultInterface.Paste;
end;

procedure TadxMSFormsTextBox.Set_AutoSize(AutoSize: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoSize(AutoSize);
end;

function TadxMSFormsTextBox.Get_AutoSize: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_AutoSize;
end;

procedure TadxMSFormsTextBox.Set_AutoTab(AutoTab: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoTab(AutoTab);
end;

function TadxMSFormsTextBox.Get_AutoTab: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_AutoTab;
end;

procedure TadxMSFormsTextBox.Set_AutoWordSelect(AutoWordSelect: WordBool);
begin
  if Connected then
    DefaultInterface.Set_AutoWordSelect(AutoWordSelect);
end;

function TadxMSFormsTextBox.Get_AutoWordSelect: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_AutoWordSelect;
end;

procedure TadxMSFormsTextBox.Set_BackColor(BackColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BackColor(BackColor);
end;

function TadxMSFormsTextBox.Get_BackColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BackColor;
end;

procedure TadxMSFormsTextBox.Set_BackStyle(BackStyle: fmBackStyle);
begin
  if Connected then
    DefaultInterface.Set_BackStyle(BackStyle);
end;

function TadxMSFormsTextBox.Get_BackStyle: fmBackStyle;
begin
  Result := fmBackStyleTransparent;
  if Connected then
    Result := DefaultInterface.Get_BackStyle;
end;

procedure TadxMSFormsTextBox.Set_BorderColor(BorderColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_BorderColor(BorderColor);
end;

function TadxMSFormsTextBox.Get_BorderColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_BorderColor;
end;

procedure TadxMSFormsTextBox.Set_BorderStyle(BorderStyle: fmBorderStyle);
begin
  if Connected then
    DefaultInterface.Set_BorderStyle(BorderStyle);
end;

function TadxMSFormsTextBox.Get_BorderStyle: fmBorderStyle;
begin
  Result := fmBorderStyleNone;
  if Connected then
    Result := DefaultInterface.Get_BorderStyle;
end;

procedure TadxMSFormsTextBox.Set_BordersSuppress(BordersSuppress: WordBool);
begin
  if Connected then
    DefaultInterface.Set_BordersSuppress(BordersSuppress);
end;

function TadxMSFormsTextBox.Get_BordersSuppress: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_BordersSuppress;
end;

function TadxMSFormsTextBox.Get_CanPaste: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_CanPaste;
end;

procedure TadxMSFormsTextBox.Set_CurLine(CurLine: Integer);
begin
  if Connected then
    DefaultInterface.Set_CurLine(CurLine);
end;

function TadxMSFormsTextBox.Get_CurLine: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_CurLine;
end;

function TadxMSFormsTextBox.Get_CurTargetX: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_CurTargetX;
end;

function TadxMSFormsTextBox.Get_CurTargetY: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_CurTargetY;
end;

procedure TadxMSFormsTextBox.Set_CurX(CurX: Integer);
begin
  if Connected then
    DefaultInterface.Set_CurX(CurX);
end;

function TadxMSFormsTextBox.Get_CurX: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_CurX;
end;

procedure TadxMSFormsTextBox.Set_CurY(CurY: Integer);
begin
  if Connected then
    DefaultInterface.Set_CurY(CurY);
end;

function TadxMSFormsTextBox.Get_CurY: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_CurY;
end;

procedure TadxMSFormsTextBox.Set_DropButtonStyle(DropButtonStyle: fmDropButtonStyle);
begin
  if Connected then
    DefaultInterface.Set_DropButtonStyle(DropButtonStyle);
end;

function TadxMSFormsTextBox.Get_DropButtonStyle: fmDropButtonStyle;
begin
  Result := fmDropButtonStylePlain;
  if Connected then
    Result := DefaultInterface.Get_DropButtonStyle;
end;

procedure TadxMSFormsTextBox.Set_EnterKeyBehavior(EnterKeyBehavior: WordBool);
begin
  if Connected then
    DefaultInterface.Set_EnterKeyBehavior(EnterKeyBehavior);
end;

function TadxMSFormsTextBox.Get_EnterKeyBehavior: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_EnterKeyBehavior;
end;

procedure TadxMSFormsTextBox.Set_Enabled(Enabled: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Enabled(Enabled);
end;

function TadxMSFormsTextBox.Get_Enabled: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Enabled;
end;

procedure TadxMSFormsTextBox.Set__Font_Reserved(const Param1: IFontDisp);
begin
  if Connected then
    DefaultInterface.Set__Font_Reserved(Param1);
end;

procedure TadxMSFormsTextBox._Set_Font(const Font: IFontDisp);
begin
  if Connected then
{$IFDEF ADX_VCL5}
    DefaultInterface.Set_Font(Font);
{$ELSE}
    DefaultInterface._Set_Font(Font);
{$ENDIF}
end;

function TadxMSFormsTextBox.Get_Font: IFontDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_Font;
end;

procedure TadxMSFormsTextBox.Set_FontBold(FontBold: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontBold(FontBold);
end;

function TadxMSFormsTextBox.Get_FontBold: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontBold;
end;

procedure TadxMSFormsTextBox.Set_FontItalic(FontItalic: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontItalic(FontItalic);
end;

function TadxMSFormsTextBox.Get_FontItalic: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontItalic;
end;

procedure TadxMSFormsTextBox.Set_FontName(const FontName: WideString);
begin
  if Connected then
    DefaultInterface.Set_FontName(FontName);
end;

function TadxMSFormsTextBox.Get_FontName: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_FontName;
end;

procedure TadxMSFormsTextBox.Set_FontSize(FontSize: Currency);
begin
  if Connected then
    DefaultInterface.Set_FontSize(FontSize);
end;

function TadxMSFormsTextBox.Get_FontSize: Currency;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontSize;
end;

procedure TadxMSFormsTextBox.Set_FontStrikethru(FontStrikethru: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontStrikethru(FontStrikethru);
end;

function TadxMSFormsTextBox.Get_FontStrikethru: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontStrikethru;
end;

procedure TadxMSFormsTextBox.Set_FontUnderline(FontUnderline: WordBool);
begin
  if Connected then
    DefaultInterface.Set_FontUnderline(FontUnderline);
end;

function TadxMSFormsTextBox.Get_FontUnderline: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_FontUnderline;
end;

procedure TadxMSFormsTextBox.Set_FontWeight(FontWeight: Smallint);
begin
  if Connected then
    DefaultInterface.Set_FontWeight(FontWeight);
end;

function TadxMSFormsTextBox.Get_FontWeight: Smallint;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_FontWeight;
end;

procedure TadxMSFormsTextBox.Set_ForeColor(ForeColor: OLE_COLOR);
begin
  if Connected then
    DefaultInterface.Set_ForeColor(ForeColor);
end;

function TadxMSFormsTextBox.Get_ForeColor: OLE_COLOR;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_ForeColor;
end;

procedure TadxMSFormsTextBox.Set_HideSelection(HideSelection: WordBool);
begin
  if Connected then
    DefaultInterface.Set_HideSelection(HideSelection);
end;

function TadxMSFormsTextBox.Get_HideSelection: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_HideSelection;
end;

procedure TadxMSFormsTextBox.Set_IntegralHeight(IntegralHeight: WordBool);
begin
  if Connected then
    DefaultInterface.Set_IntegralHeight(IntegralHeight);
end;

function TadxMSFormsTextBox.Get_IntegralHeight: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_IntegralHeight;
end;

function TadxMSFormsTextBox.Get_LineCount: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_LineCount;
end;

procedure TadxMSFormsTextBox.Set_Locked(Locked: WordBool);
begin
  if Connected then
    DefaultInterface.Set_Locked(Locked);
end;

function TadxMSFormsTextBox.Get_Locked: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Locked;
end;

procedure TadxMSFormsTextBox.Set_MaxLength(MaxLength: Integer);
begin
  if Connected then
    DefaultInterface.Set_MaxLength(MaxLength);
end;

function TadxMSFormsTextBox.Get_MaxLength: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_MaxLength;
end;

procedure TadxMSFormsTextBox.Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface.Set_MouseIcon(MouseIcon);
end;

procedure TadxMSFormsTextBox._Set_MouseIcon(const MouseIcon: IPictureDisp);
begin
  if Connected then
    DefaultInterface._Set_MouseIcon(MouseIcon);
end;

function TadxMSFormsTextBox.Get_MouseIcon: IPictureDisp;
begin
  if Connected then
    Result := DefaultInterface.Get_MouseIcon;
end;

procedure TadxMSFormsTextBox.Set_MousePointer(MousePointer: fmMousePointer);
begin
  if Connected then
    DefaultInterface.Set_MousePointer(MousePointer);
end;

function TadxMSFormsTextBox.Get_MousePointer: fmMousePointer;
begin
  Result := fmMousePointerDefault;
  if Connected then
    Result := DefaultInterface.Get_MousePointer;
end;

procedure TadxMSFormsTextBox.Set_MultiLine(MultiLine: WordBool);
begin
  if Connected then
    DefaultInterface.Set_MultiLine(MultiLine);
end;

function TadxMSFormsTextBox.Get_MultiLine: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_MultiLine;
end;

procedure TadxMSFormsTextBox.Set_PasswordChar(const PasswordChar: WideString);
begin
  if Connected then
    DefaultInterface.Set_PasswordChar(PasswordChar);
end;

function TadxMSFormsTextBox.Get_PasswordChar: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_PasswordChar;
end;

procedure TadxMSFormsTextBox.Set_ScrollBars(ScrollBars: fmScrollBars);
begin
  if Connected then
    DefaultInterface.Set_ScrollBars(ScrollBars);
end;

function TadxMSFormsTextBox.Get_ScrollBars: fmScrollBars;
begin
  Result := fmScrollBarsNone;
  if Connected then
    Result := DefaultInterface.Get_ScrollBars;
end;

procedure TadxMSFormsTextBox.Set_SelectionMargin(SelectionMargin: WordBool);
begin
  if Connected then
    DefaultInterface.Set_SelectionMargin(SelectionMargin);
end;

function TadxMSFormsTextBox.Get_SelectionMargin: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_SelectionMargin;
end;

procedure TadxMSFormsTextBox.Set_SelLength(SelLength: Integer);
begin
  if Connected then
    DefaultInterface.Set_SelLength(SelLength);
end;

function TadxMSFormsTextBox.Get_SelLength: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_SelLength;
end;

procedure TadxMSFormsTextBox.Set_SelStart(SelStart: Integer);
begin
  if Connected then
    DefaultInterface.Set_SelStart(SelStart);
end;

function TadxMSFormsTextBox.Get_SelStart: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_SelStart;
end;

procedure TadxMSFormsTextBox.Set_SelText(const SelText: WideString);
begin
  if Connected then
    DefaultInterface.Set_SelText(SelText);
end;

function TadxMSFormsTextBox.Get_SelText: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_SelText;
end;

procedure TadxMSFormsTextBox.Set_ShowDropButtonWhen(ShowDropButtonWhen: fmShowDropButtonWhen);
begin
  if Connected then
    DefaultInterface.Set_ShowDropButtonWhen(ShowDropButtonWhen);
end;

function TadxMSFormsTextBox.Get_ShowDropButtonWhen: fmShowDropButtonWhen;
begin
  Result := fmShowDropButtonWhenNever;
  if Connected then
    Result := DefaultInterface.Get_ShowDropButtonWhen;
end;

procedure TadxMSFormsTextBox.Set_SpecialEffect(SpecialEffect: fmSpecialEffect);
begin
  if Connected then
    DefaultInterface.Set_SpecialEffect(SpecialEffect);
end;

function TadxMSFormsTextBox.Get_SpecialEffect: fmSpecialEffect;
begin
  Result := fmSpecialEffectFlat;
  if Connected then
    Result := DefaultInterface.Get_SpecialEffect;
end;

procedure TadxMSFormsTextBox.Set_TabKeyBehavior(TabKeyBehavior: WordBool);
begin
  if Connected then
    DefaultInterface.Set_TabKeyBehavior(TabKeyBehavior);
end;

function TadxMSFormsTextBox.Get_TabKeyBehavior: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_TabKeyBehavior;
end;

procedure TadxMSFormsTextBox.Set_Text(const Text: WideString);
begin
  if Connected then
    DefaultInterface.Set_Text(Text);
end;

function TadxMSFormsTextBox.Get_Text: WideString;
begin
  if Connected then
    Result := DefaultInterface.Get_Text;
end;

procedure TadxMSFormsTextBox.Set_TextAlign(TextAlign: fmTextAlign);
begin
  if Connected then
    DefaultInterface.Set_TextAlign(TextAlign);
end;

function TadxMSFormsTextBox.Get_TextAlign: fmTextAlign;
begin
  Result := fmTextAlignLeft;
  if Connected then
    Result := DefaultInterface.Get_TextAlign;
end;

function TadxMSFormsTextBox.Get_TextLength: Integer;
begin
  Result := 0;
  if Connected then
    Result := DefaultInterface.Get_TextLength;
end;

function TadxMSFormsTextBox.Get_Valid: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_Valid;
end;

procedure TadxMSFormsTextBox.Set_Value(var Value: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

procedure TadxMSFormsTextBox.Set_Value2(Value: OleVariant);
begin
  if Connected then
    DefaultInterface.Set_Value(Value);
end;

function TadxMSFormsTextBox.Get_Value: OleVariant;
begin
  if Connected then
    Result := DefaultInterface.Get_Value;
end;

procedure TadxMSFormsTextBox.Set_WordWrap(WordWrap: WordBool);
begin
  if Connected then
    DefaultInterface.Set_WordWrap(WordWrap);
end;

function TadxMSFormsTextBox.Get_WordWrap: WordBool;
begin
  Result := False;
  if Connected then
    Result := DefaultInterface.Get_WordWrap;
end;

procedure TadxMSFormsTextBox.Set_IMEMode(IMEMode: fmIMEMode);
begin
  if Connected then
    DefaultInterface.Set_IMEMode(IMEMode);
end;

function TadxMSFormsTextBox.Get_IMEMode: fmIMEMode;
begin
  Result := fmIMEModeNoControl;
  if Connected then
    Result := DefaultInterface.Get_IMEMode;
end;

procedure TadxMSFormsTextBox.Set_EnterFieldBehavior(EnterFieldBehavior: fmEnterFieldBehavior);
begin
  if Connected then
    DefaultInterface.Set_EnterFieldBehavior(EnterFieldBehavior);
end;

function TadxMSFormsTextBox.Get_EnterFieldBehavior: fmEnterFieldBehavior;
begin
  Result := fmEnterFieldBehaviorSelectAll;
  if Connected then
    Result := DefaultInterface.Get_EnterFieldBehavior;
end;

procedure TadxMSFormsTextBox.Set_DragBehavior(DragBehavior: fmDragBehavior);
begin
  if Connected then
    DefaultInterface.Set_DragBehavior(DragBehavior);
end;

function TadxMSFormsTextBox.Get_DragBehavior: fmDragBehavior;
begin
  Result := fmDragBehaviorDisabled;
  if Connected then
    Result := DefaultInterface.Get_DragBehavior;
end;

function TadxMSFormsTextBox.Get_DisplayStyle: fmDisplayStyle;
begin
  Result := fmDisplayStyleText;
  if Connected then
    Result := DefaultInterface.Get_DisplayStyle;
end;

{ TadxMSFormsToggleButton }

function TadxMSFormsToggleButton.GetVersionIndependentProgID: string;
begin
  Result := 'Forms.ToggleButton';
end;

function TadxMSFormsToggleButton.GetControlType: TadxNativeMSFControl;
begin
  Result := msfToggleButton;
end;

procedure TadxMSFormsToggleButton.Connect;
begin
end;

procedure TadxMSFormsToggleButton.ConnectTo(svrIntf: IDispatch);
begin
  Disconnect;
  FIntf := svrIntf as IMdcToggleButton;
  ConnectEvents(FIntf);
  if Assigned(FOnConnect) then
    try
      FOnConnect(Self);
    except
      on E: SysUtils.Exception do TadxCOMAddInModuleAccess(Self.Owner).DoError(E);
    end;
end;

procedure TadxMSFormsToggleButton.Disconnect;
begin
  if Assigned(FIntf) then begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TadxMSFormsToggleButton.GetDefaultInterface: IMdcToggleButton;
begin
  Result := FIntf;
end;

procedure TadxMSFormsToggleButton.InitServerData;
const
  CServerData: TServerData = (
    ClassID:  '{8BD21D60-EC42-11CE-9E0D-00AA006002F3}';
    IntfIID:  '{8BD21D63-EC42-11CE-9E0D-00AA006002F3}';
    EventIID: '{8BD21D62-EC42-11CE-9E0D-00AA006002F3}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

end.
