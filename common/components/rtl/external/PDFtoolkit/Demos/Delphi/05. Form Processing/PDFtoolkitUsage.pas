unit PDFtoolkitUsage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, gtPDFClasses, gtCstPDFDoc, gtExPDFDoc,
  gtPDFDoc, gtPDFUtils, PDTypes, gtCrypt;

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
function CreateBorderAttrib(ABorderWidth: Double; ABorderStyle: Integer):TgtBorderAttribute;
procedure AddPushButton(APDFDoc: TgtPDFDocument; ARect: TgtRect;
  ANormalCap, ADownCap, ARolloverCap, ASubmitURL, AJavascript, AFieldname: string;
  ABorderwidth, APageno, AAction, ASubmitFormat: Integer; ABCKcolor, ABorderColor: TColor; AFont: TFont);
procedure AddCheckBox(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname: string;
  ABorderwidth, APageno, ASymbol, ABorderStyle: Integer; ABCKcolor, ABordercolor:TColor; AValue: Boolean);
procedure AddRadioButton(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname, AfieldValue: string;
  APageno, ASymbol, ABorderWidth, ABorderStyle, AItemIndex: Integer; ABCKcolor, ABorderColor: TColor;
  AFont: TFont; AAtleastone: Boolean);
procedure AddTextBox(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname, AfieldValue: string;
  APageno, AJustification, ABorderWidth, ABorderStyle: Integer; ABCKcolor, ABorderColor: TColor;
  ATansparent, AIsMulti, AIsPass, AIsFileSelect, AIsDoNotScroll, AIsDoNotSpellCheck: Boolean; AFont: TFont);
procedure AddComboBox(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname: string;
  APageno, ABorderwidth, ABorderStyle, ASelectedItemIndex: Integer; ABCKcolor, ABorderColor: TColor;
  AIsEditable, AIsSortedList: Boolean; AItems: TStringList; AFont: TFont);
procedure AddListBox(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname: string;
  APageno, ABorderwidth, ABorderStyle: Integer; ABCKcolor, ABorderColor: TColor;
  AIsMultiSelect, AIsSortedList: Boolean; AItems: TStringList; Afont: TFont);
procedure SetPDFFormfields(APDFDoc:TgtPDFDocument; AFieldIndex: Integer; AFieldname,
  AFieldValue: string; AReadOnly, ATransparent: Boolean; ADefaultValue: string);
procedure FlattenFormFieldByIndex(APDFDoc: TgtPDFDocument; AFieldIndex: Integer);
procedure FlattenFormFieldByName(APDFDoc: TgtPDFDocument; AFieldName: string);
procedure FlattenFormFieldOnPage(APDFDoc: TgtPDFDocument; APagerange: string);


const

FieldTypes: array[TgtPDFFormFieldType] of string = ('TextField','CheckBox',
  'Radio','Button', 'Signature','Choice');

implementation

procedure SetMeasurementUnit(APDFDoc:TgtPDFDocument; AMUnit: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.MeasurementUnit := TgtMeasurementUnit(AMUnit);
  end;
end;

function CreateBorderAttrib(ABorderWidth: Double; ABorderStyle: Integer):TgtBorderAttribute;
begin
  Result := TgtBorderAttribute.Create;
  Result.BorderWidth := ABorderWidth;
  Result.BorderStyle := TgtAnnotBorderStyle(ABorderStyle);
end;

procedure AddPushButton(APDFDoc: TgtPDFDocument; ARect: TgtRect;
  ANormalCap, ADownCap, ARolloverCap, ASubmitURL, AJavascript, AFieldname: string;
  ABorderwidth, APageno, AAction, ASubmitFormat: Integer; ABCKcolor, ABorderColor: TColor; AFont: TFont);
var
  LPushButton: TgtPDFFormPushButton;

  function CreatePushButton: TgtPDFFormPushButton;
  begin
    Result := TgtPDFFormPushButton.Create;
    with Result do
    begin
      FieldName := AFieldname;
      Rect := ARect;
      NormalCaption := ANormalCap;
      DownCaption := ADownCap;
      RolloverCaption := ARolloverCap;
      BorderColor := ABorderColor;
      BackgroundColor := ABCKcolor;
      Transparent := False;
      BorderColor := ABorderColor;
      BorderAttribute := CreateBorderAttrib(ABorderwidth,0);
      if Assigned(AFont) then
        Font := AFont;
      case AAction of
        0:Action := pbaNone;
        1:
          begin
            Action := pbaSubmit;
            SubmitURL := ASubmitURL;
            FormSubmitFormat := TgtFormSubmitFormat(ASubmitFormat);
          end;
        2:Action := pbaReset;
        3:
          begin
            Action := pbaJavaScript;
            JavaScript := AJavascript;
          end;
      end;
    end;
  end;
begin
  LPushButton := CreatePushButton;
  try
    APDFDoc.AddFormField(LPushButton, APageno);
  finally
    LPushButton.Free;
  end;
end;

procedure AddCheckBox(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname: string;
  ABorderwidth, APageno, ASymbol, ABorderStyle: Integer; ABCKcolor, ABordercolor:TColor; AValue: Boolean);
var
  LCheckbox: TgtPDFFormCheckBox;

  function CreateCheckbox: TgtPDFFormCheckBox;
  begin
    Result := TgtPDFFormCheckBox.Create;
    with Result do
    begin
      FieldName :=  AFieldname;
      Checked := AValue;
      Symbol := TgtPDFFormCheckboxSymbol(ASymbol);
      Rect := ARect;
      BackgroundColor := ABCKcolor;
      BorderAttribute := CreateBorderAttrib(ABorderwidth,ABorderStyle);
      Transparent := False;
      BorderColor := ABordercolor;
    end;
  end;
begin
  LCheckbox := CreateCheckbox;
  try
    APDFDoc.AddFormField(LCheckbox, APageno);
  finally
    LCheckbox.Free;
  end;
end;

procedure AddRadioButton(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname, AfieldValue: string;
  APageno, ASymbol, ABorderWidth, ABorderStyle, AItemIndex: Integer; ABCKcolor, ABorderColor: TColor;
  AFont: TFont; AAtleastone: Boolean);
var
  LRadioButton: TgtPDFFormRadioButton;
  LRadioItem: TgtPDFFormRadioItem;

  function CreateRadioButton: TgtPDFFormRadioButton;
  begin
    Result := TgtPDFFormRadioButton.Create;
    LRadioItem := TgtPDFFormRadioItem.Create;
    LRadioItem.Rect := ARect;
    LRadioItem.Value := AfieldValue;
    LRadioItem.BackgroundColor := ABCKcolor;
    LRadioItem.BorderColor := ABorderColor;
    with Result do
    begin
      FieldName :=  AFieldname;
      AtleastOneSelectedItem := AAtleastone;
      SelectedItemIndex := AItemIndex;
      Symbol := TgtPDFFormCheckboxSymbol(ASymbol);
      Transparent := True;
      if Assigned(AFont) then
        Font := AFont;
      BorderAttribute := CreateBorderAttrib(ABorderWidth,ABorderStyle);
      AddItem(LRadioItem);
    end;
  end;
begin
  LRadioButton := CreateRadioButton;
  try
    APDFDoc.AddFormField(LRadioButton, APageno);
  finally
    LRadioButton.Free;
//    LRadioItem.Free;
  end;
end;

procedure AddTextBox(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname, AfieldValue: string;
  APageno, AJustification, ABorderWidth, ABorderStyle: Integer; ABCKcolor, ABorderColor: TColor;
  ATansparent, AIsMulti, AIsPass, AIsFileSelect, AIsDoNotScroll, AIsDoNotSpellCheck: Boolean; AFont: TFont);
var
  LTextbox: TgtPDFFormTextField;
//  LBorderAttr: TgtBorderAttribute;
  function CreateTextbox: TgtPDFFormTextField;
  begin
    Result := TgtPDFFormTextField.Create;
    with Result do
    begin
      FieldName :=  AFieldname;
      Value := AfieldValue;
      Rect := ARect;
      if Assigned(AFont) then
        Font := AFont;
      BackgroundColor := ABCKcolor;
      BorderColor := ABorderColor;
      IsMultiline := AIsMulti;
      IsFileSelect := AIsFileSelect;
      IsDoNotSpellCheck := AIsDoNotSpellCheck;
      IsDoNotScroll := AIsDoNotScroll;
      IsPassword := AIsPass;
      Transparent := ATansparent;
      Justification := TgtPDFFieldJustification(AJustification);
//      LBorderAttr := CreateBorderAttrib(ABorderWidth,ABorderStyle);
      BorderAttribute.BorderWidth := ABorderWidth;
      BorderAttribute.BorderStyle := TgtAnnotBorderStyle(ABorderStyle);
    end;
  end;
begin
//  LBorderAttr := nil;
  LTextbox := CreateTextbox;
  try
    APDFDoc.AddFormField(LTextbox, APageno);
  finally
//    if Assigned(LBorderAttr) then
//      FreeAndNil(LBorderAttr);    
    LTextbox.Free;
  end;
end;

procedure AddComboBox(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname: string;
  APageno, ABorderwidth, ABorderStyle, ASelectedItemIndex: Integer; ABCKcolor, ABorderColor: TColor;
  AIsEditable, AIsSortedList: Boolean; AItems: TStringList; AFont: TFont);
var
  LCombobox: TgtPDFFormComboBox;

  function CreateComboBox: TgtPDFFormComboBox;
  var
    Li: Integer;
  begin
    Result := TgtPDFFormComboBox.Create;
    with Result do
    begin
      FieldName :=  AFieldname;
      Rect := ARect;
      if Assigned(AFont) then
        Font := AFont;
      BackgroundColor := ABCKcolor;
      BorderColor := ABorderColor;
      IsEditable := AIsEditable;
      //IsSortList := AIsSortedList;
      Transparent := False;
      SelectedItemIndex := ASelectedItemIndex;
      BorderAttribute := CreateBorderAttrib(ABorderwidth,ABorderStyle);
      for Li := 0 to AItems.Count - 1 do
        AddItem(AItems.Strings[li]);
    end;
  end;
begin
  LCombobox := CreateComboBox;
  try
    APDFDoc.AddFormField(LCombobox, APageno);
  finally
    LCombobox.Free;
  end;
end;

procedure AddListBox(APDFDoc: TgtPDFDocument; ARect: TgtRect;AFieldname: string;
  APageno, ABorderwidth, ABorderStyle: Integer; ABCKcolor, ABorderColor: TColor;
  AIsMultiSelect, AIsSortedList: Boolean; AItems: TStringList; Afont: TFont);
var
  LListbox: TgtPDFFormListBox;

  function CreateListBox: TgtPDFFormListBox;
  var
    Li: Integer;
  begin
    Result := TgtPDFFormListBox.Create;
    with Result do
    begin
      FieldName :=  AFieldname;
      Rect := ARect;
      if Assigned(AFont) then
        Font := AFont;
      BackgroundColor := ABCKcolor;
      BorderColor := ABorderColor;
      Transparent := False;
      IsSortList := AIsSortedList;
      IsMultiSelect := AIsMultiSelect;
      BorderAttribute := CreateBorderAttrib(ABorderwidth,ABorderStyle);
      for Li := 0 to AItems.Count - 1 do
        AddItem(AItems.Strings[li]);
    end;
  end;
begin
  LListbox := CreateListBox;
  try
    APDFDoc.AddFormField(LListbox, APageno);
  finally
    LListbox.Free;
  end;
end;

procedure SetPDFFormfields(APDFDoc:TgtPDFDocument; AFieldIndex: Integer; AFieldname,
  AFieldValue: string; AReadOnly, ATransparent: Boolean; ADefaultValue: string);
var
   LFormField: TgtFormField;
begin
  if APDFDoc.IsLoaded then
  begin
    LFormField := APDFDoc.GetFormField(AFieldIndex);
    LFormField.FieldName := AFieldname;
    LFormField.FieldValue := AFieldValue;
    LFormField.Transparent := ATransparent;
    LFormField.DefaultValue := ADefaultValue;
    LFormField.ReadOnly := AReadOnly;
  end;
end;

procedure FlattenFormFieldByIndex(APDFDoc: TgtPDFDocument; AFieldIndex: Integer);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.FlattenFormFields(AFieldIndex);
  end;
end;

procedure FlattenFormFieldByName(APDFDoc: TgtPDFDocument; AFieldName: string);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.FlattenFormFields(AFieldName);
  end;
end;

procedure FlattenFormFieldOnPage(APDFDoc: TgtPDFDocument; APagerange: string);
begin
  if APDFDoc.IsLoaded then
  begin
    APDFDoc.FlattenFormFieldsOnPage(APagerange);
  end;
end;

end.





