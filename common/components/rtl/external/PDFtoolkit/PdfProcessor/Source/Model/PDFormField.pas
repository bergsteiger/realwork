unit PDFormField;
{$I ..\Utils\gtCompilerDefines.inc}

interface

uses
  gtObject, PDTypes, PDElement, PDBaseObject, PDAnnot, PDInheritedProperty, gtFont,
  Classes, PDIndirectRef, FontProcessor, PDStream, MemoryStream, Windows, Graphics,
  PDXFADocument, PDRect, PDFont,PDDictionary {$IFDEF VCL6ORABOVE}, XMLIntf{$ENDIF};

type
  //Types of FormFields
  TgtFormFieldType = (ftText, ftCheckBox, ftRadio, ftButton, ftSignature, ftListBox, ftComboBox);

  //Alignment of FormFields
  TgtFieldJustification = (fjLeftJustified, fjCentered, fjRightJustified);

  //Form field selection symbol
  TgtSelectionSymbol = (csCheck, csCircle, csCross, csDiamond,
    csSquare, csStar);

  //Preferences of a FormField
  TgtAcroFieldPreferences = set of TgtAcroFieldPreferencesType;

  //Additional preferences - Annotation flags
//  TgtAdditionalPreferences = set of TgtAdditionalPreferencesType;

  TgtFormHighlightMode = (
    //No highlighting.
    fmNone,

    //Invert the contents of the annotation rectangle.
    fmInvert,

    //Invert the annotation’s border.
    fmOutline,

    //Display the annotation’s down appearance,
    fmPush,

    //Same as P (which is preferred).
    fmToggle);

  TgtPDFormField = class(TgtPDAnnot)
  private
    FRotationAngle: Integer;
    FBorderColor: TgtPDColorValue;
    FBackGround: TgtPDColorValue;
//    FNormalCaption: AnsiString;
    FHighlightMode: TgtFormHighlightMode;
    FFieldType: TgtFormFieldType;
    FValue: AnsiString;
    FDefaultValue: AnsiString;
    FFieldName: AnsiString;
    FJustification: TgtFieldJustification;
    FAltFieldName: AnsiString;
    FIsReadOnly: Boolean;
    FPreferences: TgtAcroFieldPreferences;
    FTransparent: Boolean;
    FFullQualifiedName: AnsiString;
    FTrigger: TgtFormFieldActionTriggers;
{$IFDEF VCL6ORABOVE}
    FXFA: TgtPDXFADocument;
{$ENDIF}
    FOrientation: TgtPDFormFieldOrientation;
    FNeedAppearences: Boolean;

    function GetRotationAngle: Integer;
    function GetBorderColor: TgtPDColorValue;
    function GetBackGroundColor: TgtPDColorValue;
    function GetHighlightMode: TgtFormHighlightMode;
    function GetDefaultValue: AnsiString;
    function GetFieldName: AnsiString;
    function GetPreferences: TgtAcroFieldPreferences;
    function GetJustification: TgtFieldJustification;
    function GetAltFieldName: AnsiString;
    function GetTransparent: Boolean;
    function GetFormFieldType: TgtFormFieldType;
    function GetIsReadOnly: Boolean;
    function GetFlag: Integer;
    function GetFont: TgtFont;
    function GetFullQualifiedName: AnsiString;

    procedure SetRotationAngle(Value: Integer);
    procedure SetBorderColor(Value: TgtPDColorValue);
    procedure SetBackGroundColor(Value: TgtPDColorValue);
    procedure SetHighlightMode(Value: TgtFormHighlightMode);
    procedure SetDefaultValue(Value: AnsiString);
    procedure SetFieldName(Value: AnsiString);
    procedure SetPreferences(Value: TgtAcroFieldPreferences);
    procedure SetJustification(Value: TgtFieldJustification);
    procedure SetAltFieldName(Value: AnsiString);
    procedure SetTransparent(Value: Boolean);
    procedure SetFormFieldType(Value: TgtFormFieldType);
    procedure SetIsReadOnly(Value: Boolean);
    procedure SetFullQualifiedName(Value: AnsiString);

    function GetNeedAppearances: Boolean;
    procedure SetNeedAppearances(AValue: Boolean);
{$IFDEF VCL6ORABOVE}
    function GetXFA: TgtPDXFADocument;
{$ENDIF}
//    procedure UpdateAppDict(AObj: TgtPDFormField);
    procedure SetValue(AValue: AnsiString);
    function GetValue: AnsiString;
    function GetOrientation: TgtPDFormFieldOrientation;
    procedure SetOrientation(const Value: TgtPDFormFieldOrientation);

//Appearance streams related functions
    function GetTextFieldFormStream(AY, AWidth, AHeight: Double;
      AFontTag: AnsiString; AI: Integer): TMemoryStream;
    function CreateAppearanceStream(var AFontTag: AnsiString; AI: Integer = 0): TgtPDIndirectRef;
    function CreateAppDict(AFontTag: AnsiString): TgtPDDictionary;
    procedure GetTransformedRect(AInputRect: TgtPDRect;
      AAngle: TgtPDFormFieldOrientation; var AOutputRect: TgtPDRect);
    function GetFontObject(AParentDoc: TgtObject;
      AParentElt: TgtPDElement; AgtFont: TgtFont): TgtPDFont;
    function GetPushButtonFormStream(AX, AY, AWidth, AHeight: Double;
      AFontTag: AnsiString; AI: Integer): TMemoryStream;
    function GetCheckBoxFormStream(AWidth, AHeight: Double;
      AFontTag: AnsiString; AI: Integer): TMemoryStream;
    function GetComboBoxFormStream(AWidth, AHeight: Double;
      AFontTag: AnsiString): TMemoryStream;
    function GetListBoxFormStream(AWidth, AHeight: Double; AFontTag: AnsiString): TMemoryStream;
  protected
    FFlag: Integer;
    FFieldRec: TgtFormFieldVals;
    FFont: TgtFont;
    //Returns the sub string of AStr until AChar
    function SubStr(AStr: AnsiString; AChar: AnsiChar): AnsiString;
    property NeedAppearances: Boolean read GetNeedAppearances write SetNeedAppearances;
    property RotationAngle: Integer read GetRotationAngle write SetRotationAngle;
    property BorderColor: TgtPDColorValue read GetBorderColor write SetBorderColor;
    property HighlightMode: TgtFormHighlightMode read GetHighlightMode
      write SetHighlightMode;
    property DefaultValue: AnsiString read GetDefaultValue write SetDefaultValue;
    property Preferences: TgtAcroFieldPreferences read GetPreferences
      write SetPreferences;
    property Justification: TgtFieldJustification read GetJustification
      write SetJustification;
    property AltFieldName: AnsiString read GetAltFieldName write SetAltFieldName;
    property Transparent: Boolean read GetTransparent write SetTransparent;
    property IsReadOnly: Boolean read GetIsReadOnly write SetIsReadOnly;
    property Flag: Integer read GetFlag;
    property Font: TgtFont read GetFont;
    property BorderStyle;
    property Action;
    property Rect;
    property Page;
    property BorderWidth;
{$IFDEF VCL6ORABOVE}
    property XFA: TgtPDXFADocument read GetXFA;
{$ENDIF}
  public
    constructor Create(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject); overload;
    constructor Create; overload;
    destructor Destroy; override;

    function Clone: TgtPDFormField; virtual;

    class function MakeFormField(AParentDoc: TgtObject; AParentElement: TgtPDElement;
      ABaseObject: TgtPDBaseObject; FieldRec: TgtFormFieldVals): TgtPDFormField; overload;
{$IFDEF VCL6ORABOVE}
    class function MakeFormField(AFieldNode: IXMLNode; FieldRec: TgtFormFieldVals):
      TgtPDFormField; overload;
{$ENDIF}
    
    property Orientation: TgtPDFormFieldOrientation read GetOrientation write SetOrientation;
    property FieldName: AnsiString read GetFieldName write SetFieldName;
    property FullQualifiedName: AnsiString read GetFullQualifiedName write SetFullQualifiedName;
    property FormFieldType: TgtFormFieldType read GetFormFieldType write SetFormFieldType;
    property Value: AnsiString read GetValue write SetValue;
    property TriggerType: TgtFormFieldActionTriggers read FTrigger write FTrigger;
    property BackGroundColor: TgtPDColorValue read GetBackGroundColor
      write SetBackGroundColor;
  end;

implementation

uses
  gtConstants, gtMethods, gtLogger, PDName, PDString, PDInteger, PDArray,
  PDFormCheckBox, PDFormPushButton, PDFormRadioButton, PDFormTextField, PDReal,
  PDFormComboBox, PDFormListBox, PDCatalog, SysUtils,
  PDPage, PDPageTree, {$IFDEF VCL6ORABOVE}StrUtils{$ELSE} gtStrUtils{$ENDIF},
  PDDocument, PDBoolean, PDParser, PDLexer, PDSignatureField, PD8bitFont,
  PDResource, math;

type

  THackPDPage = class(TgtPDPage)

  end;

{ TgtPDFormField }

constructor TgtPDFormField.Create(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject);
begin
  FParentDoc := AParentDoc;
  FParentElement := AParentElement;
  FBaseObject := ABaseObject;
  AnnotType := annotWidget;
  FFont := TgtFont.Create;
  FNeedAppearences := False;
end;

function TgtPDFormField.Clone: TgtPDFormField;
begin
  Result := nil;
end;

constructor TgtPDFormField.Create;
begin
  inherited;
  FFont := TgtFont.Create;
  FOrientation := ffo0;
  FNeedAppearences := False;
end;

destructor TgtPDFormField.Destroy;
begin
  if Assigned(FFont) then
    FreeObject(FFont);
  inherited;
end;

//function TgtPDFormField.GetAdditionalPref: TgtAdditionalPreferences;
//begin
//
//end;

function TgtPDFormField.GetFontObject(AParentDoc: TgtObject;
  AParentElt: TgtPDElement; AgtFont: TgtFont): TgtPDFont;
var
  LFontObj: TgtPD8bitFont;
begin
  Result := nil;
  //create a new TgtPDFont obj
  LFontObj := TgtPD8bitFont.Create(AParentDoc, AParentElt, AgtFont);

  //if not found, get a res tag for new LFontObj
  if ((LFontObj.Tag = '') and Assigned(TgtPDPage(Self.Page).Resource)) then
  begin
    LFontObj.Tag := TgtPDPage(Self.Page).Resource.GetResourceName(resFont);
    TgtPDPage(Self.Page).Resource.AddFont(LFontObj);
    LFontObj.CreateFontDict;
    TgtPDPage(Self.Page).AddResource(resFont, LFontObj.Tag, LFontObj.BaseObject);
    Result := LFontObj;
  end;
end;

function TgtPDFormField.CreateAppDict(
  AFontTag: AnsiString): TgtPDDictionary;
var
  LApDict, LNApDict, LDefAppDict: TgtPDDictionary;
begin
   //create new Apperance Dictionary
  LApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);

  if FormFieldType = ftButton then
  begin
    LApDict.Add(PDF_N, CreateAppearanceStream(AFontTag, 0));
    LApDict.Add(PDF_D, CreateAppearanceStream(AFontTag, 2));
    LApDict.Add(PDF_R, CreateAppearanceStream(AFontTag, 1));
  end
  else if FormFieldType = ftText then
  begin
    if TgtPDFormTextField(Self).IsMultiline then
      LApDict.Add(PDF_N, CreateAppearanceStream(AFontTag, 0))
    else
      LApDict.Add(PDF_N, CreateAppearanceStream(AFontTag, 1));
  end
  else if FormFieldType = ftListBox then
  begin
    LApDict.Add(PDF_N, CreateAppearanceStream(AFontTag));
  end
  else if FormFieldType = ftComboBox then
  begin
    LApDict.Add(PDF_N, CreateAppearanceStream(AFontTag));
  end
  else if FormFieldType = ftCheckBox then
  begin
    //Normal appearence
    LNApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LNApDict.Add(PDF_YES, CreateAppearanceStream(AFontTag, 0));
    LNApDict.Add(PDF_OFF, CreateAppearanceStream(AFontTag, 1));

    //Apperance Dictionary
    LApDict.Add(PDF_N, LNApDict);
    LApDict.Add(PDF_D, CreateAppearanceStream(AFontTag, 2));
  end
  else if FormFieldType = ftRadio then
  begin
//    //Normal appearence
//    LNApDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//    LNApDict.Add(ARadioItem.Value,
//      CreateFormObject(AFormField, AFontTag, 0, ARadioItem, False));
//    LNApDict.Add(PDF_OFF,
//      CreateFormObject(AFormField, AFontTag, 1, ARadioItem, False));
//
//    //Default Appearance
//    LDefAppDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
//    LDefAppDict.Add(ARadioItem.Value,
//      CreateFormObject(AFormField, AFontTag, 0, ARadioItem, True));
//    LDefAppDict.Add(PDF_OFF,
//      CreateFormObject(AFormField, AFontTag, 1, ARadioItem, True));
//
//    //Adding of Apperance Dictionary
//    LApDict.Add(PDF_N, LNApDict);
//    LApDict.Add(PDF_D, LDefAppDict);
  end;
  Result := LApDict;
end;

procedure TgtPDFormField.GetTransformedRect(AInputRect: TgtPDRect;
  AAngle: TgtPDFormFieldOrientation; var AOutputRect: TgtPDRect);
var
  LWidth, LHeight, LTemp: Double;
  LRect: TgtPDRect;
begin
  AOutputRect.Left := AInputRect.Left;
  AOutputRect.Top := AInputRect.Top;
  AOutputRect.Right := AInputRect.Right;
  AOutputRect.Bottom := AInputRect.Bottom;

  LWidth := AInputRect.Right - AInputRect.Left;
  LHeight := AInputRect.Bottom - AInputRect.Top;

  case AAngle of
    ffo0:;//do nothing
    ffo90:
    begin
      AOutputRect.Top := AInputRect.Top - LWidth;
      LTemp := LWidth;
      LWidth := LHeight;
      LHeight := LTemp;
      AOutputRect.Right := AInputRect.Left + LWidth;
      AOutputRect.Bottom := AOutputRect.Top + LHeight;
    end;
    ffo180:
    begin
      AOutputRect.Left := AInputRect.Left - LWidth;
      AOutputRect.Top := AInputRect.Top - LHeight;
      AOutputRect.Right := AOutputRect.Left + LWidth;
      AOutputRect.Bottom := AOutputRect.Top + LHeight;
    end;
    ffo270:
    begin
      AOutputRect.Left := AInputRect.Left - LHeight;
      LTemp := LWidth;
      LWidth := LHeight;
      LHeight := LTemp;
      AOutputRect.Right := AOutputRect.Left + LWidth;
      AOutputRect.Bottom := AInputRect.Top + LHeight;
    end;
  end;
end;

function TgtPDFormField.GetPushButtonFormStream(AX, AY, AWidth, AHeight: Double;
  AFontTag: AnsiString; AI: Integer): TMemoryStream;
var
  LStr: AnsiString;
  AFormField: TgtPDFormPushButton;
begin
//  Result := nil;
  AFormField := (self as TgtPDFormPushButton);
  if (AI = 0) then
  begin
    LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
      ' rg 0 0 ' + FloatToStringLocale(AWidth) +
      ' ' + FloatToStringLocale(AHeight) + ' re f ' +
      FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[2]) +
      ' RG 0 w 1 1 ' + FloatToStringLocale(AWidth) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re s 1 g 2 2 m 2 ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 4) + ' ' +
      FloatToStringLocale(AHeight - 4) + ' l 4 ' + FloatToStringLocale(AHeight - 4) +
      ' l 4 4 l f 0.502 g ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' m ' + FloatToStringLocale(AWidth - 2) +
      ' 2 l 2 2 l 4 4 l ' + FloatToStringLocale(AWidth - 4) + ' 4 l ' +
      FloatToStringLocale(AWidth - 4) + ' ' + FloatToStringLocale(AHeight - 4) + ' l f q 4 4 ' +
      FloatToStringLocale(AWidth - 8) + ' ' + FloatToStringLocale(AHeight - 8) +
      ' re W n BT /' + AFontTag + ' ' +
      IntToStr(Round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 ' + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' Tm (' +
      AFormField.NormalCaption + ') Tj ET Q';
  end
  else if (AI = 2) then
  begin
    LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
      ' rg 0 0 ' + FloatToStringLocale(AWidth) +
      ' ' + FloatToStringLocale(AHeight) + ' re f ' +
      FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[2]) +
      ' RG 0 w 1 1 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re s 1 g 2 2 m 2 ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 4) + ' ' +
      FloatToStringLocale(AHeight - 4) + ' l 4 ' + FloatToStringLocale(AHeight - 4) +
      ' l 4 4 l f 0.502 g ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' m ' + FloatToStringLocale(AWidth - 2) +
      ' 2 l 2 2 l 4 4 l ' + FloatToStringLocale(AWidth - 4) + ' 4 l ' +
      FloatToStringLocale(AWidth - 4) + ' ' + FloatToStringLocale(AHeight - 4) + ' l f q 4 4 ' +
      FloatToStringLocale(AWidth - 8) + ' ' + FloatToStringLocale(AHeight - 8) +
      ' re W n BT /' + AFontTag + ' ' +
      IntToStr(round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 ' + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' Tm (' +
      AFormField.DownCaption + ') Tj ET Q';
  end
  else if (AI = 1) then
  begin
    LStr := FloatToStringLocale(AFormField.BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BackgroundColor.Value[2]) +
      ' rg 0 0 ' + FloatToStringLocale(AWidth) +
      ' ' + FloatToStringLocale(AHeight) + ' re f ' +
      FloatToStringLocale(AFormField.BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(AFormField.BorderColor.Value[2]) +
      ' RG 0 w 1 1 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re s 1 g 2 2 m 2 ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' l ' + FloatToStringLocale(AWidth - 4) + ' ' +
      FloatToStringLocale(AHeight - 4) + ' l 4 ' + FloatToStringLocale(AHeight - 4) +
      ' l 4 4 l f 0.502 g ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' m ' + FloatToStringLocale(AWidth - 2) +
      ' 2 l 2 2 l 4 4 l ' + FloatToStringLocale(AWidth - 4) + ' 4 l ' +
      FloatToStringLocale(AWidth - 4) + ' ' + FloatToStringLocale(AHeight - 4) + ' l f q 4 4 ' +
      FloatToStringLocale(AWidth - 8) + ' ' + FloatToStringLocale(AHeight - 8) +
      ' re W n BT /' + AFontTag + ' ' +
      IntToStr(round((72 / 96) * (AFormField.Font.Size))) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(AFormField.Font.Color)),
      GetGValue(ColorToRGB(AFormField.Font.Color)),
      GetBValue(ColorToRGB(AFormField.Font.Color))) +
      ' rg ' + ' 1 0 0 1 ' + FloatToStringLocale(AX) + ' ' + FloatToStringLocale(AY) + ' Tm ('
      + AFormField.RolloverCaption + ') Tj ET Q';
  end;
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

function TgtPDFormField.CreateAppearanceStream(var AFontTag: AnsiString; AI: Integer = 0): TgtPDIndirectRef;
var
  LStream: TMemoryStream;
  LStr: AnsiString;
  LHeight, LWidth, LX, LY: Double;
  LFontProc: TgtFontProcessor;
  LFont: TFont;
  LEC: ErrorCodes;
  LFormDict, LResDict, LDict: TgtPDDictionary;
  LFormStream: TgtPDStream;
  LgtPDFont: TgtPDFont;
  LArray: TgtPDArray;
  LgtMemStream: TgtMemoryStream;
  LRect: TgtPDRect;
  LTempWidth, LTempHeight, LTemp: Double;
  LPageSize: TgtPageSize;

begin
  LX := 0;
  LY := 0;

  LFont := TFont.Create;
  LFont.Name := Font.Name;
  LFont.Size := Font.Size;
  LFont.Style := Font.Style;

  //Get the PSName using Font Proc
  LFontProc := TgtFontProcessor.Create(LFont, LEC);
  
  LRect := TgtPDRect.Create;
  //Modify for Radio item
  try
    //Returns Rect in user coord
    GetTransformedRect(Rect, Orientation, LRect);
    //Convert Rect to PDF coord
    LPageSize := TgtPDPage(Page).GetPageSize;
    LRect.Top := LPageSize.Height - LRect.Top;
    LRect.Bottom := LPageSize.Height - LRect.Bottom;
    
    LHeight := Abs(LRect.Bottom - LRect.Top);
    LWidth := Abs(LRect.Right - LRect.Left);
  finally
//    FreeAndNil(LRect);
  end;

  if Font.Name = '' then
    Font.Name := 'Arial';

  //Get gtPDFont obj
  LgtPDFont := GetFontObject(FParentDoc, Page, Font);

  AFontTag := LgtPDFont.Tag;

  //Create FormField Dict and add common entries
  LFormDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
  with LFormDict do
  begin
    //subtype
    Add(PDF_SUBTYPE, TgtPDName.Create(PDF_FORM));

    //formfield BBox
    LTempWidth := LWidth;
    LTempHeight := LHeight;
    //swap LTempWidth & LTempHeight
    if ((Orientation = ffo90) or
      (Orientation = ffo270)) then
    begin
      LTemp := LTempWidth;
      LTempWidth := LTempHeight;
      LTempHeight := LTemp;
    end;

    if LWidth < 0 then
      LTempWidth := Max(LRect.Left, LRect.Right)
    else
      LTempWidth := Min(LRect.Left, LRect.Right);

    if LHeight < 0 then
      LTempHeight := Max(LRect.Top, LRect.Bottom)
    else
      LTempHeight := Min(LRect.Top, LRect.Bottom);

    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDReal.Create(0));
    LArray.Add(TgtPDReal.Create(0));
    LArray.Add(TgtPDReal.Create(LTempWidth));
    LArray.Add(TgtPDReal.Create(LTempHeight));
    Add(PDF_BBOX, LArray);

    //add matrix entry based on Orientation set
    case Orientation of
      ffo0:
      begin
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        LArray.Add(TgtPDReal.Create(1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(0));
        Add(PDF_MATRIX, LArray);
      end;
      ffo90:
      begin
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(1));
        LArray.Add(TgtPDReal.Create(-1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(LTempHeight));
        LArray.Add(TgtPDReal.Create(0));
        Add(PDF_MATRIX, LArray);
      end;
      ffo180:
      begin
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        LArray.Add(TgtPDReal.Create(-1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(-1));
        LArray.Add(TgtPDReal.Create(LTempWidth));
        LArray.Add(TgtPDReal.Create(LTempHeight));
        Add(PDF_MATRIX, LArray);
      end;
      ffo270:
      begin
        LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(-1));
        LArray.Add(TgtPDReal.Create(1));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(0));
        LArray.Add(TgtPDReal.Create(LTempWidth));
        Add(PDF_MATRIX, LArray);
      end;
    end;
    //form res dict
    LResDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    Add(PDF_RESOURCES, LResDict);
    //add procset array to the res dict
    LArray := TgtPDArray.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LArray.Add(TgtPDName.Create(PDF_PDF));
    LArray.Add(TgtPDName.Create(PDF_TEXT));
    LResDict.Add(PDF_PROCSET, LArray);

    //add font dict to the res dict
    LDict := TgtPDDictionary.Create(TgtPDDocument(FParentDoc).BaseDoc);
    LResDict.Add(PDF_FONT, LDict);
    LDict.Add(LgtPDFont.Tag, TgtPDIndirectRef.Create(
      LgtPDFont.BaseObject.ObjNumber, LgtPDFont.BaseObject.GenNumber));
  end;

  //Get the corresponding FormField stream
  LStream := nil;

  case FFieldType of
    ftText:
      begin
        //Place the text at the Vertical center of BBox or Rect (3/20 earlier?)
        LY := ((LHeight - abs(Font.Size)) / 2) + (Font.Size * 0.4);
        LStream := GetTextFieldFormStream(LY, LWidth, LHeight, LgtPDFont.Tag, AI);
      end;
    ftCheckBox:
      begin
        if (TgtPDFormCheckBox(Self).Font.Size = 0) then
          TgtPDFormCheckBox(Self).Font.Size := 16;
        LStream := GetCheckBoxFormStream(LWidth, LHeight, LgtPDFont.Tag, AI);
      end;
    ftRadio:
      begin
//        LStream := GetRadioItemFormStream(LWidth, LHeight, LgtPDFont.Tag, AI,
//          Self as TgtPDFormRadioButton, AFormItem, ADef);
      end;
    ftButton:
      begin
        if LEC = Success then
        begin
          LX := (LWidth - LFontProc.GetTextWidth(
            TgtPDFormPushButton(Self).NormalCaption)) / 2;
          LY := LHeight - (Floor(abs(LHeight - (
            TgtPDFormPushButton(Self).Font.Size)) / 2) +
            ((72 / 96) * (TgtPDFormPushButton(Self).Font.Size)));
        end;
        LStream := GetPushButtonFormStream(LX, LY, LWidth, LHeight, LgtPDFont.Tag, AI);
      end;
    ftSignature:
      begin

      end;
    ftListBox:
      begin
        LStream := GetListBoxFormStream(LWidth, LHeight, LgtPDFont.Tag);
      end;
    ftComboBox:
      begin
        LStream := GetComboBoxFormStream(LWidth, LHeight, LgtPDFont.Tag);
      end;
  end;

  //Return indirect ref of the FormField obj
  LgtMemStream := TgtMemoryStream.Create(LStream, 0, 0, False);
  LgtMemStream.Reset;

  LFormDict.Add(PDF_LENGTH, TgtPDInteger.Create(LStream.Size));

  TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber :=
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber + 1;

  LFormStream := TgtPDStream.Create(LgtMemStream, LFormDict,
    TgtPDDocument(FParentDoc).BaseDoc.Reader.XRef.LastObjectNumber, 0);

  TgtPDDocument(FParentDoc).BaseDoc.AddToCollection(LFormStream);
  Result := TgtPDIndirectRef.Create(LFormStream.ObjNumber, LFormStream.GenNumber);

  if Assigned(LFontProc) then
    FreeAndNil(LFontProc);
  if Assigned(LFont) then
    FreeAndNil(LFont);
end;

function TgtPDFormField.GetTextFieldFormStream(AY, AWidth, AHeight: Double;
  AFontTag: AnsiString; AI: Integer): TMemoryStream;
var
  LStr: AnsiString;
  LBGR, LBGG, LBGB, LBCR, LBCG, LBCB: Double;
  LMultiLines: TStringList;
  I: Integer;
begin
  if ((BorderColor.Value[0] = 0) and (BorderColor.Value[1] = 0)
    and (BorderColor.Value[1] = 0)) then
  begin
    LBCR := 1;
    LBCG := 1;
    LBCB := 1;
  end
  else
  begin
    LBCR := BorderColor.Value[0];
    LBCG := BorderColor.Value[1];
    LBCB := BorderColor.Value[2];
  end;

  if ((BackGroundColor.Value[0] = 0) and (BackGroundColor.Value[1] = 0)
    and (BackGroundColor.Value[1] = 0)) then
  begin
    LBGR := 1;
    LBGG := 1;
    LBGB := 1;
  end
  else
  begin
    LBGR := BackGroundColor.Value[0];
    LBGG := BackGroundColor.Value[1];
    LBGB := BackGroundColor.Value[2];
  end;

  LStr := FloatToStringLocale(LBGR) + ' ' +
    FloatToStringLocale(LBGG) + ' ' +
    FloatToStringLocale(LBGB) +
    ' rg 0 0 ' + FloatToStringLocale(AWidth) + ' ' + FloatToStringLocale(AHeight) + ' re f ' +
    FloatToStringLocale(LBCR) + ' ' +
    FloatToStringLocale(LBCG) + ' ' +
    FloatToStringLocale(LBCB) +
    ' RG 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' + FloatToStringLocale(AHeight - 1) +
    ' re S /Tx BMC q 1 1 ' + FloatToStringLocale(AWidth - 2) + ' ' +
    FloatToStringLocale(AHeight - 2) + ' re W n BT /' + AFontTag + ' ' +
    IntToStr(Round((Font.Size))) + ' Tf ' +
    ColorToPDFColor(GetRValue(ColorToRGB(Font.Color)),
    GetGValue(ColorToRGB(Font.Color)),
    GetBValue(ColorToRGB(Font.Color))) + ' rg ';
  if (AI = 0) then
  begin
    LMultiLines := TStringList.Create;
    try
      LMultiLines.Text := Value;
      LStr := LStr + IntToStr(Round((Font.Size))) + ' TL ' +
              ' 2 ' + FloatToStringLocale(AHeight - Font.Size - 2) + ' TD ';
      for I := 0 to LMultiLines.Count - 1 do
      begin
         LStr :=  LStr + '(' + LMultiLines[I] + ') Tj ';
        if (I + 1) <> LMultiLines.Count then
          LStr := LStr + 'T* ';
      end;
      LStr := LStr + 'ET Q EMC';
    finally
      LMultiLines.Free;
    end;
  end
  else
  begin
    LStr := LStr + ' 2 ' + FloatToStringLocale(AHeight - Font.Size - 2);
    LStr := LStr + ' Td (' + Value + ') Tj ET Q EMC';
  end;
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

function TgtPDFormField.GetAltFieldName: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_TU);
    if Assigned(LObj) then
    begin
      if TgtPDString(LObj).IsHexString then
        FAltFieldName := HexToStr(TgtPDString(LObj).Value)
      else
        FAltFieldName := TgtPDString(LObj).Value;
    end;
  end;
  Result := FAltFieldName;
end;

function TgtPDFormField.GetBackGroundColor: TgtPDColorValue;
var
  LObj, LObj2, LObj3: TgtPDBaseObject;
  LI: Integer;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      if LObj.IsDict then
      begin
        LObj2 := TgtPDDictionary(LObj).LookUp(PDF_BG);
        if Assigned(LObj2) then
        begin
          for LI := 0 to TgtPDArray(LObj2).GetLength - 1 do
          begin
            LObj3 := TgtPDArray(LObj2).Get(LI);
            if LObj3.IsReal then
              FBackGround.Value[LI] := TgtPDReal(LObj3).Value
            else
              FBackGround.Value[LI] := TgtPDInteger(LObj3).Value;
          end;
          case TgtPDArray(LObj2).GetLength of
            1: FBackGround.ColorSpace := DeviceGray;
            3: FBackGround.ColorSpace := DeviceRGB;
            4: FBackGround.ColorSpace := DeviceCMYK;
          end;
        end;
      end;
    end;
  end;
  Result := FBackGround;
end;

function TgtPDFormField.GetBorderColor: TgtPDColorValue;
var
  LObj, LObj2, LObj3: TgtPDBaseObject;
  LI: Integer;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      if LObj.IsDict then
      begin
        LObj2 := TgtPDDictionary(LObj).LookUp(PDF_BC);
        if Assigned(LObj2) then
        begin
          for LI := 0 to TgtPDArray(LObj2).GetLength - 1 do
          begin
            LObj3 := TgtPDArray(LObj2).Get(LI);
            if LObj3.IsReal then
              FBorderColor.Value[LI] := TgtPDReal(LObj3).Value
            else
              FBorderColor.Value[LI] := TgtPDInteger(LObj3).Value;
          end;
          case TgtPDArray(LObj2).GetLength of
            1: FBorderColor.ColorSpace := DeviceGray;
            3: FBorderColor.ColorSpace := DeviceRGB;
            4: FBorderColor.ColorSpace := DeviceCMYK;
          end;
        end;
      end;
    end;
  end;
  Result := FBorderColor;
end;

function TgtPDFormField.GetCheckBoxFormStream(AWidth, AHeight: Double;
  AFontTag: AnsiString; AI: Integer): TMemoryStream;
var
  LCh: AnsiChar;
  LStr: AnsiString;
begin
//  Result := nil;
//  LCh := '4';
  case (Self as TgtPDFormCheckBox).Symbol of
    csCheck: LCh := '4';
    csCircle: LCh := 'l';
    csCross: LCh := '8';
    csDiamond: LCh := 'u';
    csSquare: LCh := 'n';
    csStar: LCh := 'H';
    else LCh := '4'
  end;
  if (AI = 0) then
  begin
    LStr := FloatToStringLocale(BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(BackgroundColor.Value[2]) +
      ' rg 0 w 0.6 0.6 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re f ' +
      FloatToStringLocale(BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(BorderColor.Value[2]) +
      ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
      FloatToStringLocale(AHeight - 1) + ' re s q 1 1 ' + FloatToStringLocale(AWidth - 2) + ' '
      + FloatToStringLocale(AHeight - 2) + ' re W n BT /' + AFontTag + ' ' +
      IntToStr(Font.Size) + ' Tf ' +
      ColorToPDFColor(GetRValue(ColorToRGB(Font.Color)),
      GetGValue(ColorToRGB(Font.Color)),
      GetBValue(ColorToRGB(Font.Color))) +
      ' rg ' + ' 1 0 0 1 0.77 1.405 Tm (' + LCh + ') Tj ET Q';
  end
  else if (AI = 1) then
  begin
    LStr := FloatToStringLocale(BackgroundColor.Value[0]) + ' ' +
      FloatToStringLocale(BackgroundColor.Value[1]) + ' ' +
      FloatToStringLocale(BackgroundColor.Value[2]) +
      ' rg 0 w 0.6 0.6 ' + FloatToStringLocale(AWidth - 2) + ' ' +
      FloatToStringLocale(AHeight - 2) + ' re f ' +
      FloatToStringLocale(BorderColor.Value[0]) + ' ' +
      FloatToStringLocale(BorderColor.Value[1]) + ' ' +
      FloatToStringLocale(BorderColor.Value[2]) +
      ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
      FloatToStringLocale(AHeight - 1) + ' re s';
  end;
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

function TgtPDFormField.GetComboBoxFormStream(AWidth, AHeight: Double;
  AFontTag: AnsiString): TMemoryStream;
var
  LStr: AnsiString;
begin
  LStr := FloatToStringLocale(BackgroundColor.Value[0]) + ' ' +
    FloatToStringLocale(BackgroundColor.Value[1]) + ' ' +
    FloatToStringLocale(BackgroundColor.Value[2]) +
    ' rg 0 0 ' + FloatToStringLocale(AWidth) + ' ' + FloatToStringLocale(AHeight) + ' re f ' +
    FloatToStringLocale(BorderColor.Value[0]) + ' ' +
    FloatToStringLocale(BorderColor.Value[1]) + ' ' +
    FloatToStringLocale(BorderColor.Value[2]) +
    ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' re s 0.502 g 1 1 m 1 ' +
    FloatToStringLocale(AHeight - 1) + ' l ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
    FloatToStringLocale(AHeight - 2) + ' l 2 ' + FloatToStringLocale(AHeight - 2) +
    ' l 2 2 l f 0.7529 g ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' m ' + FloatToStringLocale(AWidth - 1) +
    ' 1 l 1 1 l 2 2 l ' + FloatToStringLocale(AWidth - 2) + ' 2 l ' +
    FloatToStringLocale(AWidth - 2) + ' ' + FloatToStringLocale(AHeight - 2) +
    ' l f /Tx BMC q 2 2 ' + FloatToStringLocale(AWidth - 4) + ' ' +
    FloatToStringLocale(AHeight - 4) + ' re W n BT /' + AFontTag + ' ' +
    IntToStr(Round((72 / 96) * (Font.Size))) + ' Tf ' +
    ColorToPDFColor(GetRValue(ColorToRGB(Font.Color)),
    GetGValue(ColorToRGB(Font.Color)),
    GetBValue(ColorToRGB(Font.Color))) + ' rg ' +
    ' 1 0 0 1 4 4.59 Tm (' + Value + ') Tj ET Q EMC';
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

function TgtPDFormField.GetDefaultValue: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DV);
    if Assigned(LObj) and LObj.IsString then
    begin
      if TgtPDString(LObj).IsHexString then
        FDefaultValue := HexToStr(TgtPDString(LObj).Value)
      else
        FDefaultValue := TgtPDString(LObj).Value;
    end
    else if Assigned(LObj) and LObj.IsName then
      FDefaultValue := TgtPDName(LObj).Value;
  end;
  Result := FDefaultValue;
end;

function TgtPDFormField.GetFieldName: AnsiString;
var
  LObj: TgtPDBaseObject;
begin
//   if Assigned(XFA) then
//  begin

//  end;

  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_T);
    if Assigned(LObj) then
    begin
      if TgtPDString(LObj).IsHexString then
        FFieldName := HexToStr(TgtPDString(LObj).Value)
      else if ((TgtPDString(LObj).Value[1] = #254) and (TgtPDString(LObj).Value[2] = #255))then
        FFieldName := FromUnicodeHexToStr(TgtPDString(LObj).Value)
      else
        FFieldName := TgtPDString(LObj).Value;
    end;
  end;
  Result := FFieldName;
end;

function TgtPDFormField.GetFlag: Integer;
begin
  Result := FFlag;
end;

function TgtPDFormField.GetFont: TgtFont;
begin
  Result := FFont;
end;

function TgtPDFormField.GetFormFieldType: TgtFormFieldType;
begin
  Result := FFieldType;
end;

function TgtPDFormField.GetFullQualifiedName: AnsiString;
begin
  Result := FFullQualifiedName;
end;

function TgtPDFormField.GetHighlightMode: TgtFormHighlightMode;
begin
  Result := fmNone;
end;

function TgtPDFormField.GetIsReadOnly: Boolean;
begin
  Result := FIsReadOnly;
end;

function TgtPDFormField.GetJustification: TgtFieldJustification;
var
  LObj: TgtPDBaseObject;
  LJustification: Integer;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_Q);
    if Assigned(LObj) then
    begin
      LJustification := TgtPDInteger(LObj).Value;
      case LJustification of
        0: FJustification := fjLeftJustified;
        1: FJustification := fjCentered;
        2: FJustification := fjRightJustified;
      end;
    end;
  end;
  Result := FJustification;
end;

function TgtPDFormField.GetListBoxFormStream(AWidth, AHeight: Double;
  AFontTag: AnsiString): TMemoryStream;
var
  LStr: AnsiString;
begin
  LStr := FloatToStringLocale(BackgroundColor.Value[0]) + ' ' +
    FloatToStringLocale(BackgroundColor.Value[1]) + ' ' +
    FloatToStringLocale(BackgroundColor.Value[2]) +
    ' rg 0 0 ' + FloatToStringLocale(AWidth) + ' ' + FloatToStringLocale(AHeight) + ' re f ' +
    FloatToStringLocale(BorderColor.Value[0]) + ' ' +
    FloatToStringLocale(BorderColor.Value[1]) + ' ' +
    FloatToStringLocale(BorderColor.Value[2]) +
    ' RG 1 w 0.5 0.5 ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' re s 0.502 g 1 1 m 1 ' +
    FloatToStringLocale(AHeight - 1) + ' l ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' l ' + FloatToStringLocale(AWidth - 2) + ' ' +
    FloatToStringLocale(AHeight - 2) + ' l 2 ' + FloatToStringLocale(AHeight - 2) +
    ' l 2 2 l f 0.7529 g ' + FloatToStringLocale(AWidth - 1) + ' ' +
    FloatToStringLocale(AHeight - 1) + ' m ' + FloatToStringLocale(AWidth - 1) +
    ' 1 l 1 1 l 2 2 l ' + FloatToStringLocale(AWidth - 2) + ' 2 l ' +
    FloatToStringLocale(AWidth - 2) + ' ' + FloatToStringLocale(AHeight - 2) +
    ' l f /Tx BMC q 2 2 ' + FloatToStringLocale(AWidth - 4) + ' ' +
    FloatToStringLocale(AHeight - 4) + ' re W n BT /' + AFontTag + ' ' +
    IntToStr(Round((72 / 96) * (Font.Size))) + ' Tf ' +
    ColorToPDFColor(GetRValue(ColorToRGB(Font.Color)),
    GetGValue(ColorToRGB(Font.Color)),
    GetBValue(ColorToRGB(Font.Color))) +
    ' rg ' + ' 1 0 0 1 4 4.59 Tm (' + Value + ') Tj ET Q EMC';
  Result := TMemoryStream.Create;
  Result.Write(Pointer(LStr)^, Length(LStr));
end;

function TgtPDFormField.GetNeedAppearances: Boolean;
var
  LObj2, LAcroField: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LAcroField := TgtPDDocument(FParentElement.ParentDoc).Catalog.AcroFormField;
    if Assigned(LAcroField) then
    begin
      LObj2 := TgtPDDictionary(LAcroField).LookUp(PDF_NEEDAPPEARANCES);
      if Assigned(LObj2) then
      begin
        if (TgtPDBoolean(LObj2).Value = True) then
          FNeedAppearences := True;
      end;
    end;
  end;
  Result := FNeedAppearences;
end;

function TgtPDFormField.GetOrientation: TgtPDFormFieldOrientation;
var
  LObj: TgtPDBaseObject;
  LValue: Integer;
begin
  Result := FOrientation;
  if Assigned(FBaseObject) then
  begin
    LValue := 0;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      if Assigned(TgtPDDictionary(LObj).LookUp(PDF_R)) then
        LValue := TgtPDInteger(TgtPDDictionary(LObj).LookUp(PDF_R)).Value;
    end;
    case LValue of
      0: Result := ffo0;
      90: Result := ffo90;
      180: Result := ffo180;
      270: Result := ffo270;
    end;
  end;
end;

function TgtPDFormField.GetPreferences: TgtAcroFieldPreferences;
begin
  if Assigned(FBaseObject) then
  begin
    if (FFlag and 1) = 1 then
      FPreferences := FPreferences + [afpReadOnly];
    if ((FFlag shr 1) and 1) = 1 then
      FPreferences := FPreferences + [afpRequired];
    if ((FFlag shr 2) and 1) = 1 then
      FPreferences := FPreferences + [afpNoExport];
  end;

  Result := FPreferences;
end;

function TgtPDFormField.GetRotationAngle: Integer;
var
  LObj, LObj2: TgtPDBaseObject;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      LObj2 := TgtPDDictionary(LObj).LookUp(PDF_R);
      if Assigned(LObj2) then
      begin
        FRotationAngle := TgtPDInteger(LObj2).Value;
      end;
    end;
  end;
  Result := FRotationAngle;
end;

function TgtPDFormField.GetTransparent: Boolean;
var
  LObj, LObj2, LObj3: TgtPDBaseObject;
  LLength1, LLength2: Integer;
begin
  if Assigned(FBaseObject) then
  begin
    LLength1 := 0;
    LLength2 := 0;
    FTransparent := False;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      LObj2 := TgtPDDictionary(LObj).LookUp(PDF_BG);
      LObj3 := TgtPDDictionary(LObj).LookUp(PDF_BC);
      if Assigned(LObj2) then
        LLength1 := TgtPDArray(LObj2).GetLength;
      if Assigned(LObj3) then
        LLength2 := TgtPDArray(LObj3).GetLength;

      if (LLength1 = 0) and (LLength2 = 0) then
        FTransparent := True;
    end;
  end;
  Result := FTransparent;
end;

function TgtPDFormField.GetValue: AnsiString;
var
  LObj: TgtPDBaseObject;
//  LFieldName: AnsiString;
begin
  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_V);
    if Assigned(LObj) then
    begin
      if LObj.IsName then
        FValue := TgtPDName(LObj).Value
      else if LObj.IsString then
      begin
        if TgtPDString(LObj).IsHexString then
          FValue := HexToStr(TgtPDString(LObj).Value)
        else
          FValue := TgtPDString(LObj).Value;
      end;
    end;
  end;

//  if Assigned(XFA) then
//  begin
//    LFieldName := SubStr(FieldName, '[');
//    FValue := FXFA.GetNodeValue(FXFA.DataRootNode, LFieldName);
//    if ((FormFieldType = ftCheckBox) and (FValue = '0')) then
//      FValue := PDF_OFF;
//  end;

  Result := FValue;
end;
{$IFDEF VCL6ORABOVE}
function TgtPDFormField.GetXFA: TgtPDXFADocument;
begin
  if not Assigned(FXFA) then
  begin
    if Assigned(FBaseObject) then
      FXFA := TgtPDDocument(FParentElement.ParentDoc).Catalog.PDXFADoc;
  end;
  Result := FXFA;
end;
{$ENDIF}

{$IFDEF VCL6ORABOVE}
class function TgtPDFormField.MakeFormField(AFieldNode: IXMLNode;
  FieldRec: TgtFormFieldVals): TgtPDFormField;
var
  LI: Integer;
//  LFieldName: AnsiString;
  LUINode: IXMLNode;
  LJ: Integer;
begin
  Result := nil;
  for LI := 0 to AFieldNode.ChildNodes.Count - 1 do
  begin
    if AFieldNode.ChildNodes[LI].NodeName = 'ui' then
    begin
      LUINode := AFieldNode.ChildNodes[LI];
      for LJ := 0 to LUINode.ChildNodes.Count - 1 do
      begin
        if LUINode.ChildNodes[LJ].NodeName = 'button' then
        begin
          Result := TgtPDFormPushButton.Create;
          Result.FFieldType := ftButton;
          Result.FFieldRec := FieldRec;

        end
        else if LUINode.ChildNodes[LJ].NodeName = 'checkButton' then
        begin
          if LUINode.ChildNodes[LJ].Attributes['shape'] = 'square' then
          begin
            Result := TgtPDFormCheckBox.Create;
            Result.FFieldType := ftCheckBox;
            Result.FFieldRec := FieldRec;
          end
          else if LUINode.ChildNodes[LJ].Attributes['shape'] = 'round' then
          begin
            Result := TgtPDFormRadioButton.Create;
            Result.FFieldType := ftRadio;
            Result.FFieldRec := FieldRec;
          end;
        end
        else if LUINode.ChildNodes[LJ].NodeName = 'choiceList' then
        begin
          if LUINode.ChildNodes[LJ].Attributes['open'] = 'onEntry' then
          begin
            Result := TgtPDFormComboBox.Create;
            Result.FFieldType := ftComboBox;
            Result.FFieldRec := FieldRec;
          end
          else if LUINode.ChildNodes[LJ].Attributes['open'] = 'always' then
          begin
            Result := TgtPDFormListBox.Create;
            Result.FFieldType := ftListBox;
            Result.FFieldRec := FieldRec;
          end;
        end
        else if ((LUINode.ChildNodes[LJ].NodeName = 'passwordEdit') and
          (LUINode.ChildNodes[LJ].NodeName = 'textEdit'))then
        begin
          Result := TgtPDFormTextField.Create;
          Result.FFieldType := ftText;
          Result.FFieldRec := FieldRec;
          if (LUINode.ChildNodes[LJ].NodeName = 'passwordEdit') then
//            Result.Flag := Result.Flag or (1 shl 13);
        end;
      end;
    end;
  end;
end;
{$ENDIF}

class function TgtPDFormField.MakeFormField(AParentDoc: TgtObject;
  AParentElement: TgtPDElement; ABaseObject: TgtPDBaseObject;
  FieldRec: TgtFormFieldVals): TgtPDFormField;
var
  LObj, LObj2: TgtPDBaseObject;
  LFieldType: AnsiString;
  LFlag: Integer;
begin
  Result := nil;
  LObj := TgtPDDictionary(ABaseObject).LookUp(PDF_FT);

  LObj2 := TgtPDDictionary(ABaseObject).LookUp(PDF_FF);
  if Assigned(LObj2) then
    LFlag := TgtPDInteger(LObj2).Value
  else
    LFlag := 0;

  if Assigned(LObj) then
  begin
    LFieldType := TgtPDName(LObj).Value;
    if LFieldType = PDF_BTN then //Push button, Radio Button, Check Box
    begin
      if LFlag = -1 then //Check Box
      begin
        Result := TgtPDFormCheckBox.Create(AParentDoc, AParentElement, ABaseObject);
        Result.FFieldType := ftCheckBox;
        Result.FFlag := LFlag;
        Result.FIsReadOnly := ((LFlag <> -1) and ((LFlag and 1) = 1));
        Result.FFieldRec := FieldRec;
        Exit;
      end
      else if (((LFlag shr 16) and 1) = 1) then // Push Button
      begin
        Result := TgtPDFormPushButton.Create(AParentDoc, AParentElement, ABaseObject);
        Result.FFieldType := ftButton;
        Result.FFlag := LFlag;
        Result.FIsReadOnly := ((LFlag <> -1) and ((LFlag and 1) = 1));
        Result.FFieldRec := FieldRec;
        Exit;
      end
      else if (((LFlag shr 15) and 1) = 1) then //Radio Button
      begin
        Result := TgtPDFormRadioButton.Create(AParentDoc, AParentElement, ABaseObject);
        Result.FFieldType := ftRadio;
        Result.FFlag := LFlag;
        Result.FIsReadOnly := ((LFlag <> -1) and ((LFlag and 1) = 1));
        Result.FFieldRec := FieldRec;
        Exit;
      end
      else
      begin
        Result := TgtPDFormCheckBox.Create(AParentDoc, AParentElement, ABaseObject);
        Result.FFieldType := ftCheckBox;
        Result.FFlag := LFlag;
        Result.FIsReadOnly := ((LFlag <> -1) and ((LFlag and 1) = 1));
        Result.FFieldRec := FieldRec;
        Exit;
      end;
    end
    else if (LFieldType = PDF_TX) then //Text Box
    begin
      Result := TgtPDFormTextField.Create(AParentDoc, AParentElement, ABaseObject);
      Result.FFieldType := ftText;
      Result.FFlag := LFlag;
      Result.FIsReadOnly := ((LFlag <> -1) and ((LFlag and 1) = 1));
      Result.FFieldRec := FieldRec;
      Exit;
    end
    else if (LFieldType = PDF_CH) then //Combo Box, List Box
    begin
      if (((LFlag shr 17) and 1) = 1) then
      begin
        Result := TgtPDFormComboBox.Create(AParentDoc, AParentElement, ABaseObject);
        Result.FFieldType := ftComboBox;
        Result.FFlag := LFlag;
        Result.FIsReadOnly := ((LFlag <> -1) and ((LFlag and 1) = 1));
        Result.FFieldRec := FieldRec;
        Exit;
      end
      else
      begin //List Box
        Result := TgtPDFormListBox.Create(AParentDoc, AParentElement, ABaseObject);
        Result.FFieldType := ftListBox;
        Result.FFlag := LFlag;
        Result.FIsReadOnly := ((LFlag <> -1) and ((LFlag and 1) = 1));
        Result.FFieldRec := FieldRec;
        Exit;
      end;
    end
    else if (LFieldType = PDF_SIG) then
    begin
      //DigSig to be implimented latter
      Result := TgtPDSignatureField.Create(AParentDoc, AParentElement, ABaseObject);
      Result.FFieldType := ftSignature;
      Result.FFlag := LFlag;
      Result.FIsReadOnly := ((LFlag <> -1) and ((LFlag and 1) = 1));
      Result.FFieldRec := FieldRec;
      Exit;
    end
  end
  else
  begin
    Logger.LogError('Not a Valid Widget Annot type of FormField Type not found');
    Exit;
  end;
end;

//procedure TgtPDFormField.SetAdditionalPref(Value: TgtAdditionalPreferences);
//begin
//
//end;

procedure TgtPDFormField.SetAltFieldName(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  FAltFieldName := Value;

  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_TU);
    if Assigned(LObj) then
      TgtPDString(LObj).Value := FAltFieldName
    else
    begin
      TgtPDDictionary(FBaseObject).Add(PDF_TU, TgtPDString.Create(FAltFieldName, False));
    end;
  end;

  if NeedAppearances = False then
    NeedAppearances := True;
end;

procedure TgtPDFormField.SetBackGroundColor(Value: TgtPDColorValue);
var
  LMKObj, LBGObj, LObj: TgtPDBaseObject;
  LI: Integer;
begin
  FBackGround := Value;

  if Assigned(FBaseObject) then
  begin
    LMKObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LMKObj) then
    begin
      // Gets and sets the BG object
      LBGObj := TgtPDDictionary(LMKObj).LookUp(PDF_BG);
      if Assigned(LBGObj) then
      begin
        //Reset each value of the Array
        for LI := 0 to TgtPDArray(LBGObj).GetLength - 1 do
        begin
          LObj := TgtPDArray(LBGObj).Get(LI);
          if LObj.IsReal then
            TgtPDReal(LObj).Value := FBackGround.Value[LI]
          else
          begin
            //Remove the integer obj and create a Double obj
            TgtPDArray(LBGObj).Remove(LI);
            LObj := TgtPDReal.Create(FBackGround.Value[LI]);
            TgtPDArray(LBGObj).Insert(LObj, LI);
          end;
        end;
      end
      else // No back ground color, create a BG object
      begin
        LBGObj := TgtPDArray.Create(Self);
        TgtPDArray(LBGObj).Add(TgtPDReal.Create(FBackGround.Value[0])); //Add colors
        TgtPDArray(LBGObj).Add(TgtPDReal.Create(FBackGround.Value[1]));
        TgtPDArray(LBGObj).Add(TgtPDReal.Create(FBackGround.Value[2]));
        TgtPDDictionary(LMKObj).Add(PDF_BG, LBGObj);
      end;
    end
    else // MK Dict does not exists, create a MK Dict and Add BG object
    begin
      LMKObj := TgtPDDictionary.Create(Self); //Create MK Dict
      LBGObj := TgtPDArray.Create(Self); // Create BG Object
      TgtPDArray(LBGObj).Add(TgtPDReal.Create(FBackGround.Value[0])); //Add colors
      TgtPDArray(LBGObj).Add(TgtPDReal.Create(FBackGround.Value[1]));
      TgtPDArray(LBGObj).Add(TgtPDReal.Create(FBackGround.Value[2]));
      TgtPDDictionary(LMKObj).Add(PDF_BG, LBGObj); //Add BG object to MK Dict
      TgtPDDictionary(FBaseObject).Add(PDF_MK, LMKObj); //Add MK Dict to Widget Dict
    end;
  end;
end;

procedure TgtPDFormField.SetBorderColor(Value: TgtPDColorValue);
var
  LMKObj, LBCObj, LObj: TgtPDBaseObject;
  LI: Integer;
begin
  FBorderColor := Value;

  if Assigned(FBaseObject) then
  begin
    LMKObj := TgtPDDictionary(FBaseObject).LookUp(PDF_MK);
    if Assigned(LMKObj) then
    begin
      // Gets and sets the BC object
      LBCObj := TgtPDDictionary(LMKObj).LookUp(PDF_BC);
      if Assigned(LBCObj) then
      begin
        //Reset each value of the Array
        for LI := 0 to TgtPDArray(LBCObj).GetLength - 1 do
        begin
          LObj := TgtPDArray(LBCObj).Get(LI);
          if LObj.IsReal then
            TgtPDReal(LObj).Value := FBorderColor.Value[LI]
          else
          begin
            //Remove the integer obj and create a Double obj
            TgtPDArray(LBCObj).Remove(LI);
            LObj := TgtPDReal.Create(FBorderColor.Value[LI]);
            TgtPDArray(LBCObj).Insert(LObj, LI);
          end;
        end;
      end
      else // No back ground color, create a BC object
      begin
        LBCObj := TgtPDArray.Create(Self);
        TgtPDArray(LBCObj).Add(TgtPDReal.Create(FBorderColor.Value[0])); //Add colors
        TgtPDArray(LBCObj).Add(TgtPDReal.Create(FBorderColor.Value[1]));
        TgtPDArray(LBCObj).Add(TgtPDReal.Create(FBorderColor.Value[2]));
        TgtPDDictionary(LMKObj).Add(PDF_BC, LBCObj);
      end;
    end
    else // MK Dict does not exists, create a MK Dict and Add BG object
    begin
      LMKObj := TgtPDDictionary.Create(Self); //Create MK Dict
      LBCObj := TgtPDArray.Create(Self); // Create BG Object
      TgtPDArray(LBCObj).Add(TgtPDReal.Create(FBorderColor.Value[0])); //Add colors
      TgtPDArray(LBCObj).Add(TgtPDReal.Create(FBorderColor.Value[1]));
      TgtPDArray(LBCObj).Add(TgtPDReal.Create(FBorderColor.Value[2]));
      TgtPDDictionary(LMKObj).Add(PDF_BC, LBCObj); //Add BG object to MK Dict
      TgtPDDictionary(FBaseObject).Add(PDF_MK, LMKObj); //Add MK Dict to Widget Dict
    end;
  end;
end;

procedure TgtPDFormField.SetDefaultValue(Value: AnsiString);
var
  LObj: TgtPDBaseObject;
begin
  FDefaultValue := Value;

  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_DV);
    if Assigned(LObj) then
      TgtPDString(LObj).Value := FDefaultValue
    else
    begin
      TgtPDDictionary(FBaseObject).Add(PDF_DV, TgtPDString.Create(FDefaultValue, False));
    end;
  end;

  if NeedAppearances = False then
    NeedAppearances := True;
end;

procedure TgtPDFormField.SetFieldName(Value: AnsiString);
//var
//  LObj: TgtPDBaseObject;
//  LFieldName: AnsiString;
begin
//  if Assigned(XFA) then
//  begin
//    LFieldName := SubStr(FieldName, '[');
//
//    //changing the name of the node in template
//    FXFA.SetNodeName(FXFA.TempRootNode, LFieldName, Value);
//
//    //changing the name of the node in datasets
//    if ((FormFieldType = ftCheckBox) and (Self.Value = PDF_OFF)) then
//      FXFA.UpdateNodeAt(FXFA.DataRootNode, LFieldName, Value, '0')
//    else if ((FormFieldType = ftCheckBox) and not (Self.Value = PDF_OFF)) then
//      FXFA.UpdateNodeAt(FXFA.DataRootNode, LFieldName, Value, '1')
//    else
//      FXFA.UpdateNodeAt(FXFA.DataRootNode, LFieldName, Value, Self.Value);
//  end;

  FFieldName := Value;

  if Assigned(FBaseObject) then
  begin
    TgtPDDictionary(FBaseObject).SetKeyValue(PDF_T,
      TgtPDString.Create(FFieldName, False));
  end;

  if NeedAppearances = False then
    NeedAppearances := True;
end;

procedure TgtPDFormField.SetFormFieldType(Value: TgtFormFieldType);
begin
  FFieldType := Value;
end;

procedure TgtPDFormField.SetFullQualifiedName(Value: AnsiString);
begin
  FFullQualifiedName := Value;
end;

procedure TgtPDFormField.SetHighlightMode(Value: TgtFormHighlightMode);
begin
  FHighlightMode := Value;
end;

procedure TgtPDFormField.SetIsReadOnly(Value: Boolean);
var
  LObj: TgtPDBaseObject;
begin
  FIsReadOnly := Value;
  if Assigned(FBaseObject) then
  begin
    //FFlag := FFlag or 1;
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_FF);
    if Assigned(LObj) then
    begin
      if (FIsReadOnly = True) then
      begin
      FFlag := ((FFlag shr 6) or 1)
      end;
      TgtPDInteger(LObj).Value := FFlag
    end
    else
      TgtPDDictionary(FBaseObject).Add(PDF_FF, TgtPDInteger.Create(FFlag));
  end;

  if NeedAppearances = False then
    NeedAppearances := True;
end;

procedure TgtPDFormField.SetJustification(Value: TgtFieldJustification);
var
  LObj: TgtPDBaseObject;
begin
  FJustification := Value;

  if Assigned(FBaseObject) then
  begin
    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_Q);
    if Assigned(LObj) then
    begin
      case FJustification of
        fjLeftJustified: TgtPDInteger(LObj).Value := 0;
        fjCentered: TgtPDInteger(LObj).Value := 1;
        fjRightJustified: TgtPDInteger(LObj).Value := 2;
      end;
    end
    else
    begin
      TgtPDDictionary(FBaseObject).Add(PDF_Q, TgtPDInteger.Create(Integer(FJustification)));
    end;
  end;

  if NeedAppearances = False then
    NeedAppearances := True;
end;

procedure TgtPDFormField.SetNeedAppearances(AValue: Boolean);
var
  LAcroField: TgtPDBaseObject;
begin
  FNeedAppearences := AValue;
  if Assigned(FBaseObject) then
  begin
    LAcroField := TgtPDDocument(FParentElement.ParentDoc).Catalog.AcroFormField;

    if Assigned(LAcroField) then
    begin
      TgtPDDictionary(LAcroField).SetKeyValue(PDF_NEEDAPPEARANCES,
        TgtPDBoolean.Create(AValue));
    end;
  end;
end;

procedure TgtPDFormField.SetOrientation(const Value: TgtPDFormFieldOrientation);
begin
  FOrientation := Value;
end;

procedure TgtPDFormField.SetPreferences(Value: TgtAcroFieldPreferences);
begin
  FPreferences := Value;
end;

procedure TgtPDFormField.SetRotationAngle(Value: Integer);
begin
//  FRotationAngle := Value;
//
//  if Assigned(FBaseObject) then
//  begin
//    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_R);
//    if Assigned(LObj) then
//      TgtPDInteger(LObj).Value := FRotationAngle
//    else
//      TgtPDDictionary(FBaseObject).Add(PDF_R, TgtPDInteger.Create(FRotationAngle));
//  end;
  if Value <> FRotationAngle then
    FIsChanged := TRUE;
  FRotationAngle := Value;
end;

procedure TgtPDFormField.SetTransparent(Value: Boolean);
var
  LI: Integer;
//  LAcroField: TgtPDBaseObject;

  Procedure MakeTransparent(AObj: TgtPDBaseObject);
  var
    LObj, LObj2, LObj3: TgtPDBaseObject;
    LI: Integer;
  begin
    LObj := TgtPDDictionary(AObj).LookUp(PDF_MK);
    if Assigned(LObj) then
    begin
      LObj2 := TgtPDDictionary(LObj).LookUp(PDF_BG);
      LObj3 := TgtPDDictionary(LObj).LookUp(PDF_BC);
      if Assigned(LObj2) then
      begin
        for LI := TgtPDArray(LObj2).GetLength - 1 downto 0 do
        begin
          TgtPDArray(LObj2).Remove(LI);
        end;
      end;
      if Assigned(LObj3) then
      begin
        for LI := TgtPDArray(LObj3).GetLength - 1 downto 0 do
        begin
          TgtPDArray(LObj3).Remove(LI);
        end;
      end;
    end;
  end;

begin
  FTransparent := Value;
  if (Value = True) then
  begin
    if Assigned(FBaseObject) then
    begin
      if (FormFieldType = ftRadio) then
      begin
        for LI := 0 to TgtPDFormRadioButton(Self).GetItemCount - 1 do
        begin
           MakeTransparent(TgtPDFormField(TgtPDFormRadioButton(Self).
            GetRadioItem(LI)).FBaseObject);
        end;
      end
      else
        MakeTransparent(FBaseObject);
    end;
  end;

  if NeedAppearances = False then
    NeedAppearances := True;
end;

procedure TgtPDFormField.SetValue(AValue: AnsiString);
var
  LI: Integer;
  aSetValue: AnsiString;
  LAPObj: TgtPDBaseObject;
begin
  FValue := AValue;

  if Assigned(FBaseObject) then
  begin
    //Check if the forms dictionary has /AP else added a new /AP
    //if already existing then update the appearance stream
    if (FormFieldType = ftCheckBox) then
    begin
      if (AValue = PDF_OFF) then
      begin
        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_AS,
          TgtPDName.Create(PDF_OFF));
      end
      else
      begin
        for LI := 0 to TgtPDFormCheckBox(self).OptionCount - 1 do
        begin
          if (LowerCase(AValue) = LowerCase(TgtPDFormCheckBox(self).Option[LI])) then
          begin
            TgtPDDictionary(FBaseObject).SetKeyValue(PDF_AS,
              TgtPDName.Create(TgtPDFormCheckBox(self).Option[LI]));
            aSetValue := TgtPDFormCheckBox(self).Option[LI];
            Break;
          end;
        end;
      end;
      if TgtPDFormCheckBox(self).OptionCount = 0 then
         aSetValue := AValue;
      TgtPDDictionary(FBaseObject).
        SetKeyValue(PDF_V, TgtPDName.Create(aSetValue));
    end
    else if (FormFieldType = ftRadio) then
    begin
      TgtPDDictionary(FBaseObject).
        SetKeyValue(PDF_V, TgtPDName.Create(AValue));
    end
    else if (FormFieldType = ftComboBox) then
    begin
      for LI := 0 to TgtPDFormComboBox(self).OptionCount - 1 do
      begin
        if TgtPDFormComboBox(self).Options[LI] = AValue then
        begin
          TgtPDDictionary(FBaseObject).SetKeyValue(PDF_V,
            TgtPDString.Create(AValue, False));
          TgtPDDictionary(FBaseObject).SetKeyValue(PDF_I,
            TgtPDInteger.Create(LI));
        end;
      end;
    end
    else
    begin
      TgtPDDictionary(FBaseObject).
        SetKeyValue(PDF_V, TgtPDString.Create(AValue, False));
    end;
  end;

  LAPObj := TgtPDDictionary(FBaseObject).LookUp(PDF_AP);
  if not Assigned(LAPObj) then
  begin
    TgtPDDictionary(FBaseObject).Add(PDF_AP, CreateAppDict(FFont.Name));
  end
  else
  begin
    TgtPDDictionary(FBaseObject).Remove(PDF_AP);
    TgtPDDictionary(FBaseObject).Add(PDF_AP, CreateAppDict(FFont.Name));
  end;
  
  if NeedAppearances = False then
    NeedAppearances := True;
end;

function TgtPDFormField.SubStr(AStr: AnsiString; AChar: AnsiChar): AnsiString;
begin
  Result := AStr;
  if (Pos(AChar, AStr) > 0) then
  begin
    Result := LeftStr(AStr, Pos('[', AStr) - 1);
  end;
end;

//procedure TgtPDFormField.UpdateAppDict(AObj: TgtPDFormField);
//var
//  LObj: TgtPDBaseObject;
//  LI: Integer;
//begin
//  if Assigned(FBaseObject) then
//  begin
//    LObj := TgtPDDictionary(FBaseObject).LookUp(PDF_AP);
//    if Assigned(LObj) then
//    begin
//      if FormFieldType = ftRadio then
//      begin
//        for LI := 0 to (TgtPDFormRadioButton(Self).GetItemCount - 1) do
//        begin
//          TgtPDDictionary(LObj).SetKeyValue(PDF_AP, THackPDPage(FParentElement).
//            CreateAppDict(Self, TgtPDFormRadioButton(Self).GetRadioItem(LI)));
//        end;
//      end
//      else
//      begin
//        TgtPDDictionary(FBaseObject).SetKeyValue(PDF_AP,
//          THackPDPage(FParentElement).CreateAppDict(Self));
//      end;
//    end;
//  end;
//end;

end.
