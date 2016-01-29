unit dd_rtfFields;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/dd_rtfFields.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::RTFSupport::dd_rtfFields
//
// Обработка полей и форм из RTF
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Base,
  l3StringList,
  RTFtypes,
  ddRTFdestination,
  destNorm,
  ddRTFState,
  ddCustomRTFReader
  ;

type
 TddValueType = (
   dd_vtEmpty
 , dd_vtAddData
 , dd_vtFull
 , dd_vtFormula
 );//TddValueType

 TddSkipText = (
   dd_stNone
 , dd_stCheckNextSymbol
 , dd_stSkip
 );//TddSkipText

 TdestFormFieldItem = class(TddRTFDestination)
 private
 // private fields
   f_Item : AnsiString;
    {* Поле для свойства Item}
 protected
 // realized methods
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 public
 // overridden public methods
   procedure AddAnsiChar(aText: AnsiChar;
     aState: TddRTFState); override;
   procedure AddString(aText: Tl3String;
     aState: TddRTFState); override;
   procedure AddUnicodeChar(aText: Word;
     aState: TddRTFState); override;
 public
 // public properties
   property Item: AnsiString
     read f_Item
     write f_Item;
 end;//TdestFormFieldItem

 TdestFormField = class(TddRTFDestination)
 private
 // private fields
   f_Items : Tl3StringList;
   f_DefaultResult : Integer;
    {* Поле для свойства DefaultResult}
   f_FormResult : Integer;
    {* Поле для свойства FormResult}
   f_FormSize : Integer;
    {* Поле для свойства FormSize}
   f_FormType : Integer;
    {* Поле для свойства FormType}
   f_TextType : Integer;
    {* Поле для свойства TextType}
 protected
 // realized methods
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   procedure Clear; override;
   procedure ApplyProperty(propType: TPropType;
     What: TIProp;
     Value: LongInt;
     aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
 public
 // public methods
   procedure AddItem(const aItem: AnsiString);
   function GetFormResult: AnsiString;
 public
 // public properties
   property DefaultResult: Integer
     read f_DefaultResult
     write f_DefaultResult;
   property FormResult: Integer
     read f_FormResult
     write f_FormResult;
   property FormSize: Integer
     read f_FormSize
     write f_FormSize;
   property FormType: Integer
     read f_FormType
     write f_FormType;
   property TextType: Integer
     read f_TextType
     write f_TextType;
 end;//TdestFormField

 TddCheckFontType = (
   dd_cfNone
 , dd_cfWaitName
 , dd_cfTry2Convert
 , dd_cfApply
 );//TddCheckFontType

 TdestFieldInstruction = class(TddRTFDestination)
 private
 // private fields
   f_Instruction : AnsiString;
   f_ValueType : TddValueType;
   f_CheckFont : TddCheckFontType;
   f_Char : AnsiChar;
   f_FontName : Tl3String;
   f_FieldType : TddFieldType;
    {* Поле для свойства FieldType}
 private
 // private methods
   function CheckFieldType(aText: Tl3String): Boolean;
 protected
 // property methods
   function Get_FieldType: TddFieldType;
 protected
 // realized methods
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   procedure Clear; override;
   procedure AddAnsiChar(aText: AnsiChar;
     aState: TddRTFState); override;
   procedure AddString(aText: Tl3String;
     aState: TddRTFState); override;
   procedure ParseSymbol(Symbol: Integer;
     propType: TPropType;
     aState: TddRTFState); override;
 public
 // public methods
   procedure Instruction2Result;
 public
 // public properties
   property FieldType: TddFieldType
     read Get_FieldType;
 end;//TdestFieldInstruction

 TdestFieldResult = class(TdestNorm)
 private
 // private fields
   f_SkipText : TddSkipText;
 protected
 // overridden protected methods
   function CanAddTable: Boolean; override;
 public
 // overridden public methods
   procedure Clear; override;
   procedure AddAnsiChar(aText: AnsiChar;
     aState: TddRTFState); override;
   procedure AddString(aText: Tl3String;
     aState: TddRTFState); override;
   procedure AddUnicodeChar(aText: Word;
     aState: TddRTFState); override;
   constructor Create(aRTFReader: TddCustomRTFReader); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 public
 // public methods
   procedure AppendData(aFieldDest: TddRTFDestination);
 end;//TdestFieldResult

 TdestField = class(TddRTFDestination)
 private
 // private fields
   f_FielsInsruction : TdestFieldInstruction;
    {* Поле для свойства FielsInsruction}
   f_FormField : TdestFormField;
    {* Поле для свойства FormField}
   f_FieldResult : TdestFieldResult;
    {* Поле для свойства FieldResult}
 protected
 // realized methods
   procedure Close(aState: TddRTFState;
     aNewDest: TddRTFDestination); override;
   procedure WriteText(aRDS: TRDS;
     aText: Tl3String;
     aState: TddRTFState); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public properties
   property FielsInsruction: TdestFieldInstruction
     read f_FielsInsruction
     write f_FielsInsruction;
   property FormField: TdestFormField
     read f_FormField
     write f_FormField;
   property FieldResult: TdestFieldResult
     read f_FieldResult
     write f_FieldResult;
 end;//TdestField

implementation

uses
  Math,
  StrUtils,
  SysUtils,
  l3Chars,
  l3Types,
  l3String
  ;

// start class TdestFormFieldItem

procedure TdestFormFieldItem.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51D278030255_var*
//#UC END# *5461BEC2017D_51D278030255_var*
begin
//#UC START# *5461BEC2017D_51D278030255_impl*
 TdestFormField(aNewDest).AddItem(Item);
 Clear;
//#UC END# *5461BEC2017D_51D278030255_impl*
end;//TdestFormFieldItem.Close

procedure TdestFormFieldItem.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_51D278030255_var*
//#UC END# *54E1F08400F9_51D278030255_var*
begin
//#UC START# *54E1F08400F9_51D278030255_impl*
 WriteText(aText, aState);
//#UC END# *54E1F08400F9_51D278030255_impl*
end;//TdestFormFieldItem.WriteText

procedure TdestFormFieldItem.AddAnsiChar(aText: AnsiChar;
  aState: TddRTFState);
//#UC START# *51D27C0402E9_51D278030255_var*
//#UC END# *51D27C0402E9_51D278030255_var*
begin
//#UC START# *51D27C0402E9_51D278030255_impl*
 f_Item := f_Item + aText;
//#UC END# *51D27C0402E9_51D278030255_impl*
end;//TdestFormFieldItem.AddAnsiChar

procedure TdestFormFieldItem.AddString(aText: Tl3String;
  aState: TddRTFState);
//#UC START# *51D27C3302EC_51D278030255_var*
//#UC END# *51D27C3302EC_51D278030255_var*
begin
//#UC START# *51D27C3302EC_51D278030255_impl*
 f_Item := aText.AsString;
//#UC END# *51D27C3302EC_51D278030255_impl*
end;//TdestFormFieldItem.AddString

procedure TdestFormFieldItem.AddUnicodeChar(aText: Word;
  aState: TddRTFState);
//#UC START# *51D27DFA0308_51D278030255_var*
//#UC END# *51D27DFA0308_51D278030255_var*
begin
//#UC START# *51D27DFA0308_51D278030255_impl*

//#UC END# *51D27DFA0308_51D278030255_impl*
end;//TdestFormFieldItem.AddUnicodeChar
// start class TdestFormField

procedure TdestFormField.AddItem(const aItem: AnsiString);
//#UC START# *51D27F3F005B_51D27E5801D3_var*
//#UC END# *51D27F3F005B_51D27E5801D3_var*
begin
//#UC START# *51D27F3F005B_51D27E5801D3_impl*
 f_Items.Add(aItem);
//#UC END# *51D27F3F005B_51D27E5801D3_impl*
end;//TdestFormField.AddItem

function TdestFormField.GetFormResult: AnsiString;
//#UC START# *51D27F740338_51D27E5801D3_var*
//#UC END# *51D27F740338_51D27E5801D3_var*
begin
//#UC START# *51D27F740338_51D27E5801D3_impl*
 Result := '';
 if (FormType = 2) and (InRange(FormResult, 0, f_Items.Hi) or (InRange(DefaultResult, 0, f_Items.Hi))) then
 begin
  if InRange(FormResult, 0, f_Items.Hi) then
   Result := f_Items.Items[FormResult].AsString
  else
   Result := f_Items.Items[DefaultResult].AsString;
 end; // InRange
//#UC END# *51D27F740338_51D27E5801D3_impl*
end;//TdestFormField.GetFormResult

procedure TdestFormField.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51D27E5801D3_var*
//#UC END# *5461BEC2017D_51D27E5801D3_var*
begin
//#UC START# *5461BEC2017D_51D27E5801D3_impl*

//#UC END# *5461BEC2017D_51D27E5801D3_impl*
end;//TdestFormField.Close

procedure TdestFormField.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_51D27E5801D3_var*
//#UC END# *54E1F08400F9_51D27E5801D3_var*
begin
//#UC START# *54E1F08400F9_51D27E5801D3_impl*
 Assert(False);
//#UC END# *54E1F08400F9_51D27E5801D3_impl*
end;//TdestFormField.WriteText

procedure TdestFormField.Cleanup;
//#UC START# *479731C50290_51D27E5801D3_var*
//#UC END# *479731C50290_51D27E5801D3_var*
begin
//#UC START# *479731C50290_51D27E5801D3_impl*
 inherited;
 FreeAndNil(f_Items);
//#UC END# *479731C50290_51D27E5801D3_impl*
end;//TdestFormField.Cleanup

procedure TdestFormField.Clear;
//#UC START# *51D27A48038E_51D27E5801D3_var*
//#UC END# *51D27A48038E_51D27E5801D3_var*
begin
//#UC START# *51D27A48038E_51D27E5801D3_impl*
 FormType:= -1;
 FormSize:= -1;
 DefaultResult:= -1;
 TextType:= -1;
 f_Items.Clear;
//#UC END# *51D27A48038E_51D27E5801D3_impl*
end;//TdestFormField.Clear

procedure TdestFormField.ApplyProperty(propType: TPropType;
  What: TIProp;
  Value: LongInt;
  aState: TddRTFState);
//#UC START# *51D27EC50388_51D27E5801D3_var*
//#UC END# *51D27EC50388_51D27E5801D3_var*
begin
//#UC START# *51D27EC50388_51D27E5801D3_impl*
 case What of
  ipropfftype: FormType:= Value;
  ipropffdefres: DefaultResult:= Value;
  ipropffres: FormResult:= Value;
 end;
//#UC END# *51D27EC50388_51D27E5801D3_impl*
end;//TdestFormField.ApplyProperty

constructor TdestFormField.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_51D27E5801D3_var*
//#UC END# *51E7C9DB0213_51D27E5801D3_var*
begin
//#UC START# *51E7C9DB0213_51D27E5801D3_impl*
 inherited Create(aRTFReader);
 f_Items := Tl3StringList.Create();
//#UC END# *51E7C9DB0213_51D27E5801D3_impl*
end;//TdestFormField.Create
// start class TdestFieldInstruction

function TdestFieldInstruction.CheckFieldType(aText: Tl3String): Boolean;
//#UC START# *550A97780325_51D277ED01E9_var*
var
 i: TddFieldType;
//#UC END# *550A97780325_51D277ED01E9_var*
begin
//#UC START# *550A97780325_51D277ED01E9_impl*
 Result := f_FieldType = dd_fieldUnknown;
 if Result then
 begin
  Result := False;
  for i := Low(TddFieldType) to High(TddFieldType) do
   if l3Compare(caFieldStrArray[i], aText.AsWStr, l3_siCaseUnsensitive) = 0 then
   begin
    f_FieldType := i;
    Result := True;
    Break;
   end; // if l3Compare(caFieldStrArray[i], aText, l3_siCaseUnsensitive) = 0 then
 end // if not Result then
 else
  if f_FieldType = dd_fieldHyperlink then
   if l3Compare(caFieldStrArray[dd_fieldHyperlinkMailTo], aText.AsWStr, l3_siCaseUnsensitive) = 0 then
   begin
    f_FieldType := dd_fieldHyperlinkMailTo;
    Result := True;
   end; // if l3Compare(caFieldStrArray[dd_fieldHyperlinkMailTo], aText.AsWStr, l3_siCaseUnsensitive) = 0 then
//#UC END# *550A97780325_51D277ED01E9_impl*
end;//TdestFieldInstruction.CheckFieldType

procedure TdestFieldInstruction.Instruction2Result;
//#UC START# *51D27B1A00FA_51D277ED01E9_var*

 procedure lp_Try2ConvertSymbolChar;
 const
  cnLargeDashInSymbol = 45;
 var
  l_CharID     : Byte;
  l_FormulaType: TddFormulaRepresent;
 begin
  l_CharID := StrToIntDef(f_Instruction, 32);
  l_FormulaType := carCharID2FormualRepresent[AnsiChar(l_CharID)];
  if l_FormulaType = dd_frUnknown then
   f_ValueType := dd_vtEmpty
  else
   if l_FormulaType = dd_frCharID then
    if l_CharID = cnLargeDashInSymbol then
     f_Char := cc_LargeDash
    else
     f_Char := AnsiChar(l_CharID)
   else
   begin
    f_Char := AnsiChar(l_CharID);
    f_ValueType := dd_vtFormula;
   end; // if l_FormulaType <> dd_frUnknown then
 end; // lp_Try2ConvertSymbolChar

//#UC END# *51D27B1A00FA_51D277ED01E9_var*
begin
//#UC START# *51D27B1A00FA_51D277ED01E9_impl*
 case f_FieldType of
  dd_fieldHyperlinkMailTo: f_ValueType := dd_vtFull;
  dd_fieldSymbol:
   begin
    if (f_ValueType = dd_vtFull) then
    begin
     if (f_CheckFont = dd_cfApply) or (f_CheckFont = dd_cfWaitName) then
      f_Char := AnsiChar(StrToIntDef(f_Instruction, 32))
     else
      if f_CheckFont = dd_cfTry2Convert then
       lp_Try2ConvertSymbolChar;
    end // if (f_ValueType = dd_vtFull) then
    else
     f_ValueType := dd_vtEmpty;
   end;
  else
   f_ValueType := dd_vtEmpty;
 end; // case aFieldType of
//#UC END# *51D27B1A00FA_51D277ED01E9_impl*
end;//TdestFieldInstruction.Instruction2Result

function TdestFieldInstruction.Get_FieldType: TddFieldType;
//#UC START# *51D27B9A01B2_51D277ED01E9get_var*

{
'CREATEDATE' | 'DATE' | 'EDITTIME' | 'PRINTDATE' | 'SAVEDATE' | 'TIME'
'COMPARE' | 'DOCVARIABLE' | 'GOTOBUTTON' | 'IF' | 'MACROBUTTON' | 'PRINT'
'AUTHOR' | 'COMMENTS' | 'DOCPROPERTY' | 'FILENAME' | 'FILESIZE' | 'INFO' | 'KEYWORDS' | 'LASTSAVEDBY' | 'NUMCHARS' | 'NUMPAGES' | 'NUMWORDS' | 'SUBJECT' | 'TEMPLATE' | 'TITLE'
'FORMTEXT' | 'FORMCHECKBOX' | 'FORMDROPDOWN'
('=' <formula>) | 'ADVANCE' | 'EQ' | 'SYMBOL'
'INDEX' | 'RD' | 'TA' | 'TC' | 'TOA' | 'TOC' | 'XE'
'AUTOTEXT' | 'AUTOTEXTLIST' | 'HYPERLINK' | 'INCLUDEPICTURE' | 'INCLUDETEXT' | 'LINK' | 'NOTEREF' | 'PAGEREF' | 'QUOTE' | 'REF' | 'STYLEREF'
'ADDRESSBLOCK' | 'ASK' | 'COMPARE' | 'DATABASE' | 'FILLIN' | 'GREETINGLINE' | 'IF' | 'MERGEFIELD' | 'MERGEREC' | 'MERGESEQ' | 'NEXT' | 'NEXTIF' | 'SET' | 'SKIPIF'
'AUTONUM' | 'AUTONUMLGL' | 'AUTONUMOUT' | 'BARCODE' | 'LISTNUM' | 'PAGE' | 'REVNUM' | 'SECTION' | 'SECTIONPAGES' | 'SEQ'
'USERADDRESS' | 'USERINITIALS' | 'USERNAME'
}
//#UC END# *51D27B9A01B2_51D277ED01E9get_var*
begin
//#UC START# *51D27B9A01B2_51D277ED01E9get_impl*
 Result := f_FieldType;
//#UC END# *51D27B9A01B2_51D277ED01E9get_impl*
end;//TdestFieldInstruction.Get_FieldType

procedure TdestFieldInstruction.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51D277ED01E9_var*
//#UC END# *5461BEC2017D_51D277ED01E9_var*
begin
//#UC START# *5461BEC2017D_51D277ED01E9_impl*

//#UC END# *5461BEC2017D_51D277ED01E9_impl*
end;//TdestFieldInstruction.Close

procedure TdestFieldInstruction.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_51D277ED01E9_var*
//#UC END# *54E1F08400F9_51D277ED01E9_var*
begin
//#UC START# *54E1F08400F9_51D277ED01E9_impl*
 WriteText(aText, aState);
 f_ValueType := dd_vtEmpty;
 f_CheckFont := dd_cfNone;
 f_FieldType := dd_fieldUnknown;
//#UC END# *54E1F08400F9_51D277ED01E9_impl*
end;//TdestFieldInstruction.WriteText

procedure TdestFieldInstruction.Cleanup;
//#UC START# *479731C50290_51D277ED01E9_var*
//#UC END# *479731C50290_51D277ED01E9_var*
begin
//#UC START# *479731C50290_51D277ED01E9_impl*
 inherited;
 FreeAndNil(f_FontName);
//#UC END# *479731C50290_51D277ED01E9_impl*
end;//TdestFieldInstruction.Cleanup

procedure TdestFieldInstruction.Clear;
//#UC START# *51D27A48038E_51D277ED01E9_var*
//#UC END# *51D27A48038E_51D277ED01E9_var*
begin
//#UC START# *51D27A48038E_51D277ED01E9_impl*
 f_Instruction := '';
 f_ValueType := dd_vtEmpty;
 f_CheckFont := dd_cfNone;
 f_FieldType := dd_fieldUnknown;
 FreeAndNil(f_FontName);
 inherited;
//#UC END# *51D27A48038E_51D277ED01E9_impl*
end;//TdestFieldInstruction.Clear

procedure TdestFieldInstruction.AddAnsiChar(aText: AnsiChar;
  aState: TddRTFState);
//#UC START# *51D27C0402E9_51D277ED01E9_var*
//#UC END# *51D27C0402E9_51D277ED01E9_var*
begin
//#UC START# *51D27C0402E9_51D277ED01E9_impl*
 if f_FieldType = dd_fieldSymbol then
 begin
  if (f_CheckFont = dd_cfWaitName) and (aText = cc_DoubleQuote) then
  begin
   if f_FontName = nil then
    f_FontName := Tl3String.Create
   else
    if l3Compare(caFieldStrArray[dd_fieldSymbol], f_FontName.AsWStr, l3_siCaseUnsensitive) = 0 then
     f_CheckFont := dd_cfTry2Convert
    else
     f_CheckFont := dd_cfApply;
  end; // if (f_CheckFont = dd_cfWaitName) and (aText = cc_DoubleQuote) then
  if (aText in cc_Digits) then
  begin
   if f_ValueType < dd_vtFull then
    f_Instruction := f_Instruction + aText;
   if f_ValueType = dd_vtEmpty then
    f_ValueType := dd_vtAddData
  end // if (aText in cc_Digits) then
  else
   if f_ValueType = dd_vtAddData then
    f_ValueType := dd_vtFull
 end // if f_FieldType = dd_fieldSymbol then   
 else
  if (f_FieldType in [dd_fieldHyperlink, dd_fieldHyperlinkMailTo]) then
  begin
   if not (aText in [cc_HardSpace, cc_DoubleQuote, cc_Colon]) then
    f_Instruction := f_Instruction + aText;
  end // if (f_FieldType in [dd_fieldHyperlink, dd_fieldHyperlinkMailTo]) then
  else
   f_Instruction := f_Instruction + aText;
//#UC END# *51D27C0402E9_51D277ED01E9_impl*
end;//TdestFieldInstruction.AddAnsiChar

procedure TdestFieldInstruction.AddString(aText: Tl3String;
  aState: TddRTFState);
//#UC START# *51D27C3302EC_51D277ED01E9_var*
//#UC END# *51D27C3302EC_51D277ED01E9_var*
begin
//#UC START# *51D27C3302EC_51D277ED01E9_impl*
 if not CheckFieldType(aText) then
  if f_FieldType = dd_fieldSymbol then
  begin
   if (f_CheckFont = dd_cfNone) and (l3Compare(csFontNameInField, aText.AsWStr, l3_siCaseUnsensitive) = 0) then
    f_CheckFont := dd_cfWaitName
   else
    if (f_CheckFont = dd_cfWaitName) and (f_FontName <> nil) then
     f_FontName.Append(aText.AsWStr);
  end // if f_FieldType = dd_fieldSymbol then
  else
   f_Instruction := f_Instruction + aText.AsString;
//#UC END# *51D27C3302EC_51D277ED01E9_impl*
end;//TdestFieldInstruction.AddString

procedure TdestFieldInstruction.ParseSymbol(Symbol: Integer;
  propType: TPropType;
  aState: TddRTFState);
//#UC START# *51E8CFEF027A_51D277ED01E9_var*
//#UC END# *51E8CFEF027A_51D277ED01E9_var*
begin
//#UC START# *51E8CFEF027A_51D277ED01E9_impl*
 inherited; 
 if (Symbol = symbolRepeateText) and (f_FieldType = dd_fieldHyperlinkMailTo) then
 begin
  f_FieldType := dd_fieldHyperlink;
  f_Instruction := '';
 end; // if Symbol = symbolRepeateText then
//#UC END# *51E8CFEF027A_51D277ED01E9_impl*
end;//TdestFieldInstruction.ParseSymbol
// start class TdestFieldResult

procedure TdestFieldResult.AppendData(aFieldDest: TddRTFDestination);
//#UC START# *550BDF10022A_51D2785D029C_var*

 procedure lp_CheckLastPara;
 begin
  if LastParagraph = nil then
   AddTextPara(False, 1);
 end;

var
 l_FieldInsruction: TdestFieldInstruction;
//#UC END# *550BDF10022A_51D2785D029C_var*
begin
//#UC START# *550BDF10022A_51D2785D029C_impl*
 if aFieldDest is TdestFormField then
 begin
  lp_CheckLastPara;
  LastParagraph.Text.AsString := (aFieldDest as TdestFormField).GetFormResult;
 end // if aFieldDest is TdestFormField then
 else
  if aFieldDest is TdestFieldInstruction then
  begin
   l_FieldInsruction := aFieldDest as TdestFieldInstruction;
   l_FieldInsruction.Instruction2Result;
   if l_FieldInsruction.f_ValueType > dd_vtAddData then
   begin
    lp_CheckLastPara;
    if l_FieldInsruction.f_FieldType = dd_fieldSymbol then
     if l_FieldInsruction.f_ValueType = dd_vtFull then
      LastParagraph.Text.Append(l_FieldInsruction.f_Char)
     else
      AddFormula(LastParagraph, csFormulaRepresent[carCharID2FormualRepresent[l_FieldInsruction.f_Char]])
    else
     LastParagraph.Text.AsString := l_FieldInsruction.f_Instruction;
   end; // if l_FieldInsruction.f_ValueType <>
  end; // if aFieldDest is TdestFieldInstruction then
//#UC END# *550BDF10022A_51D2785D029C_impl*
end;//TdestFieldResult.AppendData

procedure TdestFieldResult.Clear;
//#UC START# *51D27A48038E_51D2785D029C_var*
//#UC END# *51D27A48038E_51D2785D029C_var*
begin
//#UC START# *51D27A48038E_51D2785D029C_impl*
 f_SkipText := dd_stNone;
 inherited;
//#UC END# *51D27A48038E_51D2785D029C_impl*
end;//TdestFieldResult.Clear

procedure TdestFieldResult.AddAnsiChar(aText: AnsiChar;
  aState: TddRTFState);
//#UC START# *51D27C0402E9_51D2785D029C_var*
//#UC END# *51D27C0402E9_51D2785D029C_var*
begin
//#UC START# *51D27C0402E9_51D2785D029C_impl*
 if f_SkipText = dd_stNone then
  inherited
 else
  if aText = cc_DoubleQuote then
   if f_SkipText = dd_stCheckNextSymbol then
    f_SkipText := dd_stSkip
   else
    f_SkipText := dd_stNone;
//#UC END# *51D27C0402E9_51D2785D029C_impl*
end;//TdestFieldResult.AddAnsiChar

procedure TdestFieldResult.AddString(aText: Tl3String;
  aState: TddRTFState);
//#UC START# *51D27C3302EC_51D2785D029C_var*
//#UC END# *51D27C3302EC_51D2785D029C_var*
begin
//#UC START# *51D27C3302EC_51D2785D029C_impl*
 if l3Compare(caFieldStrArray[dd_fieldHyperlink], aText.AsWStr, l3_siCaseUnsensitive) = 0 then
  f_SkipText := dd_stCheckNextSymbol
 else
  if f_SkipText = dd_stNone then
   inherited;
//#UC END# *51D27C3302EC_51D2785D029C_impl*
end;//TdestFieldResult.AddString

procedure TdestFieldResult.AddUnicodeChar(aText: Word;
  aState: TddRTFState);
//#UC START# *51D27DFA0308_51D2785D029C_var*
//#UC END# *51D27DFA0308_51D2785D029C_var*
begin
//#UC START# *51D27DFA0308_51D2785D029C_impl*
 if f_SkipText = dd_stNone then
  inherited;
//#UC END# *51D27DFA0308_51D2785D029C_impl*
end;//TdestFieldResult.AddUnicodeChar

constructor TdestFieldResult.Create(aRTFReader: TddCustomRTFReader);
//#UC START# *51E7C9DB0213_51D2785D029C_var*
//#UC END# *51E7C9DB0213_51D2785D029C_var*
begin
//#UC START# *51E7C9DB0213_51D2785D029C_impl*
 inherited;
 f_SkipText := dd_stNone;
//#UC END# *51E7C9DB0213_51D2785D029C_impl*
end;//TdestFieldResult.Create

procedure TdestFieldResult.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_51D2785D029C_var*
//#UC END# *54E1F08400F9_51D2785D029C_var*
begin
//#UC START# *54E1F08400F9_51D2785D029C_impl*
 WriteText(aText, aState);
 f_SkipText := dd_stNone;
//#UC END# *54E1F08400F9_51D2785D029C_impl*
end;//TdestFieldResult.WriteText

function TdestFieldResult.CanAddTable: Boolean;
//#UC START# *559516AA0098_51D2785D029C_var*
//#UC END# *559516AA0098_51D2785D029C_var*
begin
//#UC START# *559516AA0098_51D2785D029C_impl*
 Result := False;
//#UC END# *559516AA0098_51D2785D029C_impl*
end;//TdestFieldResult.CanAddTable
// start class TdestField

procedure TdestField.Close(aState: TddRTFState;
  aNewDest: TddRTFDestination);
//#UC START# *5461BEC2017D_51D2776D03C3_var*
var
 l_FieldType       : TddFieldType;
 l_FieldResult     : AnsiString;
 l_ClearFieldResult: Boolean;
//#UC END# *5461BEC2017D_51D2776D03C3_var*
begin
//#UC START# *5461BEC2017D_51D2776D03C3_impl*                       
 l_ClearFieldResult := f_FieldResult <> nil;
 if (aNewDest is TdestNorm) then
 begin
  l_FieldType := f_FielsInsruction.FieldType;
  if aNewDest = f_FieldResult then
   l_ClearFieldResult := False
  else
  if l_FieldType <> dd_fieldPAGE then
  begin
   if l_FieldType = dd_fieldForm then
    f_FieldResult.AppendData(f_FormField)
   else
    f_FieldResult.AppendData(f_FielsInsruction);
   TdestNorm(aNewDest).Append(aState, f_FieldResult, True);
  end; // if aNewDest <> f_FieldResult then
 end;
 f_FielsInsruction.Clear;
 if f_FormField <> nil then
  f_FormField.Clear;
 if l_ClearFieldResult then
 begin
  f_FieldResult.Clear;
  f_FieldResult.ParagraphsClear;
 end; // if l_ClearFieldResult then
//#UC END# *5461BEC2017D_51D2776D03C3_impl*
end;//TdestField.Close

procedure TdestField.WriteText(aRDS: TRDS;
  aText: Tl3String;
  aState: TddRTFState);
//#UC START# *54E1F08400F9_51D2776D03C3_var*
//#UC END# *54E1F08400F9_51D2776D03C3_var*
begin
//#UC START# *54E1F08400F9_51D2776D03C3_impl*
 Assert(False);
//#UC END# *54E1F08400F9_51D2776D03C3_impl*
end;//TdestField.WriteText

procedure TdestField.Cleanup;
//#UC START# *479731C50290_51D2776D03C3_var*
//#UC END# *479731C50290_51D2776D03C3_var*
begin
//#UC START# *479731C50290_51D2776D03C3_impl*
 inherited;
 f_FielsInsruction := nil;
 f_FormField := nil;
 f_FieldResult := nil;
//#UC END# *479731C50290_51D2776D03C3_impl*
end;//TdestField.Cleanup

end.