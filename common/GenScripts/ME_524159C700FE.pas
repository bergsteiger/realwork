unit ddHTMLTag;

// Модуль: "w:\common\components\rtl\Garant\dd\ddHTMLTag.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , l3Base
 , l3RegEx
 , ddHTMLTags
 , l3Types
 , l3ProtoDataContainer
 , l3Memory
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddHTMLParam;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3RecordListPrim.imp.pas}
 TddParamsList = class(_l3RecordListPrim_)
 end;//TddParamsList

 TddParseParamAction = (
  dd_ppaAddNewValue
  , dd_ppaExtendString
 );//TddParseParamAction

 TddHTMLTag = class(Tl3SimpleObject)
  private
   f_ParamsString: Tl3String;
   f_ParamsList: TddParamsList;
   f_ParamCount: Integer;
   f_Start: Integer;
   f_ParserAction: TddParseParamAction;
   f_WasQuoter: Boolean;
   f_TagID: Integer;
    {* Поле для свойства TagID }
  private
   function GetKeyID: TddHTMLParamID;
   procedure AddKeyValue(aValue: TddHTMLParamID);
   procedure AddIntValue(aHRefSeacher: Tl3RegularSearch);
   procedure AddStringValue(aHRefSeacher: Tl3RegularSearch);
   function GetPrevParamType: TddHTMLParamID;
   procedure TryAddValue(aKeyValue: Boolean;
    aHRefSeacher: Tl3RegularSearch);
   function CanAddNewValue: Boolean;
   procedure AnalyseCharSet;
   procedure AddVAlignValue;
   procedure TryAddPercent;
   procedure AnalyseHREF(aHRefSeacher: Tl3RegularSearch);
   procedure AnalyseStyle;
   procedure AddAlignValue(const aStr: Tl3String = nil);
   function CheckServiceDocID(aDocID: Integer): Boolean;
    {* Исключаем ссылки на служебные топики с www-ссылками }
   procedure AddWidthValue;
   procedure AnalyseBorder;
  protected
   function pm_GetTagID: Integer; virtual;
   function pm_GetIsClosed: Boolean; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddChar(aChar: AnsiChar;
    aHRefSeacher: Tl3RegularSearch);
   constructor Create(aTagID: Integer); reintroduce;
   procedure AddString(const aString: Tl3String;
    aHRefSeacher: Tl3RegularSearch);
   function IsNil: Boolean;
    {* Проверяет есть ли данные в теге. }
   function HasKey(anKeyID: TddHTMLParamID;
    var aParam: TddHTMLParam): Boolean;
   procedure AlnalyseValue(aHRefSeacher: Tl3RegularSearch);
   function Param2PCharLen(const aParam: TddHTMLParam): Tl3PCharLen;
  public
   property TagID: Integer
    read pm_GetTagID;
   property IsClosed: Boolean
    read pm_GetIsClosed;
 end;//TddHTMLTag

implementation

uses
 l3ImplUses
 , l3Chars
 , l3String
 , ddTypes
 , l3UnitsTools
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_5242B1A4025D_var*
//#UC END# *47B07CF403D0_5242B1A4025D_var*
begin
//#UC START# *47B07CF403D0_5242B1A4025D_impl*
 Result := A.rType = B.rType;
//#UC END# *47B07CF403D0_5242B1A4025D_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5242B1A4025D_var*
//#UC END# *47B2C42A0163_5242B1A4025D_var*
begin
//#UC START# *47B2C42A0163_5242B1A4025D_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5242B1A4025D_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_5242B1A4025D_var*
//#UC END# *47B99D4503A2_5242B1A4025D_var*
begin
//#UC START# *47B99D4503A2_5242B1A4025D_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_5242B1A4025D_impl*
end;//CompareExistingItems

type _Instance_R_ = TddParamsList;

{$Include l3RecordListPrim.imp.pas}

function TddHTMLTag.pm_GetTagID: Integer;
//#UC START# *52415A3602DA_524159C700FEget_var*
//#UC END# *52415A3602DA_524159C700FEget_var*
begin
//#UC START# *52415A3602DA_524159C700FEget_impl*
 Result := Abs(f_TagID);
//#UC END# *52415A3602DA_524159C700FEget_impl*
end;//TddHTMLTag.pm_GetTagID

function TddHTMLTag.pm_GetIsClosed: Boolean;
//#UC START# *52415A87021F_524159C700FEget_var*
//#UC END# *52415A87021F_524159C700FEget_var*
begin
//#UC START# *52415A87021F_524159C700FEget_impl*
 Result := f_TagID < 0;
//#UC END# *52415A87021F_524159C700FEget_impl*
end;//TddHTMLTag.pm_GetIsClosed

procedure TddHTMLTag.AddChar(aChar: AnsiChar;
 aHRefSeacher: Tl3RegularSearch);
//#UC START# *52415AC40279_524159C700FE_var*
const
 csIgnoreChars = cc_WhiteSpaceExt + [cc_HardEnter, cc_SoftEnter] + cc_Quotes;
//#UC END# *52415AC40279_524159C700FE_var*
begin
//#UC START# *52415AC40279_524159C700FE_impl*
 if aChar in csIgnoreChars then
 begin
  AlnalyseValue(aHRefSeacher);
  f_ParserAction := dd_ppaAddNewValue;
 end // if aChar in csIgnoreChars then
 else
 begin
  if aChar in [cc_Equal, cc_SemiColon] then
   TryAddValue(aChar = cc_Equal, aHRefSeacher)
  else
   if aChar = cc_PercentSign then
    TryAddPercent
   else
    f_ParserAction := dd_ppaExtendString;
  f_ParamsString.Append(aChar);
 end; // if not (aChar in csIgnoreChars) then
//#UC END# *52415AC40279_524159C700FE_impl*
end;//TddHTMLTag.AddChar

constructor TddHTMLTag.Create(aTagID: Integer);
//#UC START# *52415BC2014B_524159C700FE_var*
//#UC END# *52415BC2014B_524159C700FE_var*
begin
//#UC START# *52415BC2014B_524159C700FE_impl*
 inherited Create;
 f_TagID := aTagID;
 f_Start := -1;
 f_ParamCount := 0;
 f_ParamsList := TddParamsList.Create; 
 f_ParamsString := Tl3String.Create;
//#UC END# *52415BC2014B_524159C700FE_impl*
end;//TddHTMLTag.Create

procedure TddHTMLTag.AddString(const aString: Tl3String;
 aHRefSeacher: Tl3RegularSearch);
//#UC START# *5241705E00DB_524159C700FE_var*
//#UC END# *5241705E00DB_524159C700FE_var*
begin
//#UC START# *5241705E00DB_524159C700FE_impl*
 aString.TrimAll;
 if f_ParserAction = dd_ppaAddNewValue then
  f_Start := f_ParamsString.Len;
 f_ParamsString.Append(aString.AsWStr);
 TryAddValue(False, aHRefSeacher);
//#UC END# *5241705E00DB_524159C700FE_impl*
end;//TddHTMLTag.AddString

function TddHTMLTag.IsNil: Boolean;
 {* Проверяет есть ли данные в теге. }
//#UC START# *5241781E030B_524159C700FE_var*
//#UC END# *5241781E030B_524159C700FE_var*
begin
//#UC START# *5241781E030B_524159C700FE_impl*
 Result := f_ParamsList.Count = 0;
//#UC END# *5241781E030B_524159C700FE_impl*
end;//TddHTMLTag.IsNil

function TddHTMLTag.HasKey(anKeyID: TddHTMLParamID;
 var aParam: TddHTMLParam): Boolean;
//#UC START# *52417862037A_524159C700FE_var*
var
 i       : Integer;
 l_Param : TddHTMLParam;
 l_Count : Integer;
//#UC END# *52417862037A_524159C700FE_var*
begin
//#UC START# *52417862037A_524159C700FE_impl*
 Result := not IsNil;
 if Result then
 begin
  l_Count := f_ParamsList.Count - 1;
  Result := False;
  for i := 0 to l_Count do
  begin
   l_Param := f_ParamsList[i];
   if (l_Param.rType = dd_parKey) and (l_Param.rKeyValue = anKeyID) then
   begin
    Result := i < l_Count;
    if Result then
    begin
     aParam := f_ParamsList[i + 1];
     Result := aParam.rType > dd_parKey;
     Break;
    end; // if Result then
   end; // if (l_Param.rType = l_Param) and (l_Param.rKeyValue = anKeyID) then
  end; // for i := 0 to l_Count do
 end; // if Result then
//#UC END# *52417862037A_524159C700FE_impl*
end;//TddHTMLTag.HasKey

function TddHTMLTag.GetKeyID: TddHTMLParamID;
//#UC START# *5241837B0215_524159C700FE_var*
var
 i        : TddHTMLParamID;
 l_FindStr: Tl3PCharLen;
//#UC END# *5241837B0215_524159C700FE_var*
begin
//#UC START# *5241837B0215_524159C700FE_impl*
 Result := dd_paridUnknown;
 l_FindStr := l3PCharLenPart(f_ParamsString.St, f_Start, f_ParamsString.Len, f_ParamsString.CodePage);
 for i := dd_paridHREF to cnHTMLParamLast do
  if l3Compare(carHTMLParamStrArray[i], l_FindStr, l3_siCaseUnsensitive) = 0 then
  begin
   Result := i;
   Break;
  end;
//#UC END# *5241837B0215_524159C700FE_impl*
end;//TddHTMLTag.GetKeyID

procedure TddHTMLTag.AddKeyValue(aValue: TddHTMLParamID);
//#UC START# *5242C2B50032_524159C700FE_var*
var
 l_Param     : TddHTMLParam;
 l_ParamType : TddHTMLParamID;
//#UC END# *5242C2B50032_524159C700FE_var*
begin
//#UC START# *5242C2B50032_524159C700FE_impl*
 l_ParamType := aValue;
 if l_ParamType = dd_paridUnknown then Exit;
 l_Param.rType := dd_parKey;
 l_Param.rKeyValue := l_ParamType;
 f_ParamsList.Add(l_Param);
 Inc(f_ParamCount);
 f_ParserAction := dd_ppaAddNewValue;
 f_Start := -1;
//#UC END# *5242C2B50032_524159C700FE_impl*
end;//TddHTMLTag.AddKeyValue

procedure TddHTMLTag.AddIntValue(aHRefSeacher: Tl3RegularSearch);
//#UC START# *5242C2C403BA_524159C700FE_var*
var
 l_Param : TddHTMLParam;
//#UC END# *5242C2C403BA_524159C700FE_var*
begin
//#UC START# *5242C2C403BA_524159C700FE_impl*
 if not CanAddNewValue then Exit;
 l_Param.rType := dd_parInteger;
 l_Param.rValue := l3StrToIntDef(l3PCharLenPart(f_ParamsString.St, f_Start, f_ParamsString.Len, f_ParamsString.CodePage), 0);
 l_Param.rIsPercent := False;
 f_ParamsList.Add(l_Param);
 f_Start := -1;
 f_ParserAction := dd_ppaAddNewValue;
//#UC END# *5242C2C403BA_524159C700FE_impl*
end;//TddHTMLTag.AddIntValue

procedure TddHTMLTag.AddStringValue(aHRefSeacher: Tl3RegularSearch);
//#UC START# *5242C2E901A2_524159C700FE_var*
var
 l_Prev  : TddHTMLParam;
 l_Param : TddHTMLParam;
//#UC END# *5242C2E901A2_524159C700FE_var*
begin
//#UC START# *5242C2E901A2_524159C700FE_impl*
 if not IsNil then
 begin
  l_Prev := f_ParamsList.Last;
  if (l_Prev.rType = dd_parString) then
   if (l_Prev.rFinish < f_ParamsString.Len) then
    f_ParamsList.DeleteLast
   else
    Exit;
 end; // if not IsNil then
 l_Param.rType := dd_parString;
 l_Param.rStart := f_Start;
 l_Param.rFinish := f_ParamsString.Len;
 f_ParamsList.Add(l_Param);
//#UC END# *5242C2E901A2_524159C700FE_impl*
end;//TddHTMLTag.AddStringValue

function TddHTMLTag.GetPrevParamType: TddHTMLParamID;
//#UC START# *5242C6280096_524159C700FE_var*
var
 i     : Integer;
 l_Len : Integer;
//#UC END# *5242C6280096_524159C700FE_var*
begin
//#UC START# *5242C6280096_524159C700FE_impl*
 Result := dd_paridUnknown;
 l_Len := f_ParamsList.Count - 1;
 for i := l_Len downto 0 do
  if f_ParamsList[i].rType = dd_parKey then
  begin
   Result := f_ParamsList[i].rKeyValue;
   Exit;
  end;
//#UC END# *5242C6280096_524159C700FE_impl*
end;//TddHTMLTag.GetPrevParamType

procedure TddHTMLTag.TryAddValue(aKeyValue: Boolean;
 aHRefSeacher: Tl3RegularSearch);
//#UC START# *5242CC830209_524159C700FE_var*
var
 l_ParamType: TddHTMLParamID;
//#UC END# *5242CC830209_524159C700FE_var*
begin
//#UC START# *5242CC830209_524159C700FE_impl*
 if f_Start = -1 then Exit;
 if aKeyValue then
  AddKeyValue(GetKeyID)
 else
 begin
  l_ParamType := GetPrevParamType;
  if l_ParamType = dd_paridUnknown then Exit;
  case l_ParamType of
   dd_paridHREF: AddStringValue(aHRefSeacher);
   dd_paridALIGN: AddAlignValue;
   dd_paridVALIGN: AddVAlignValue;
   dd_paridCOLSPAN: AddIntValue(aHRefSeacher);
   dd_paridROWSPAN: AddIntValue(aHRefSeacher);
   dd_paridSTYLE: AddStringValue(aHRefSeacher);
   dd_paridWIDTH: AddWidthValue;
   dd_paridCLASS: AddStringValue(aHRefSeacher);
   dd_paridCHARSET: AddStringValue(aHRefSeacher);
   dd_paridSRC: AddStringValue(aHRefSeacher);
  end; // case l_ParamType of
 end;
//#UC END# *5242CC830209_524159C700FE_impl*
end;//TddHTMLTag.TryAddValue

function TddHTMLTag.CanAddNewValue: Boolean;
//#UC START# *5243BCE0031D_524159C700FE_var*
//#UC END# *5243BCE0031D_524159C700FE_var*
begin
//#UC START# *5243BCE0031D_524159C700FE_impl*
 Result := f_ParamsList.Last.rType = dd_parKey;
//#UC END# *5243BCE0031D_524159C700FE_impl*
end;//TddHTMLTag.CanAddNewValue

procedure TddHTMLTag.AlnalyseValue(aHRefSeacher: Tl3RegularSearch);
//#UC START# *5243D88E026F_524159C700FE_var*
var
 l_ParamType: TddHTMLParamID;
//#UC END# *5243D88E026F_524159C700FE_var*
begin
//#UC START# *5243D88E026F_524159C700FE_impl*
 if not IsNil and (f_ParamsList.Last.rType = dd_parString) then
 begin
  l_ParamType := GetPrevParamType;
  if l_ParamType = dd_paridUnknown then Exit;
  case l_ParamType of
   dd_paridCHARSET: AnalyseCharSet;
   dd_paridHREF: AnalyseHREF(aHRefSeacher);
   dd_paridSTYLE: AnalyseStyle;
   dd_paridCLASS: AddStringValue(aHRefSeacher);
  end;
 end; // if not IsNil
 f_ParserAction := dd_ppaAddNewValue;
//#UC END# *5243D88E026F_524159C700FE_impl*
end;//TddHTMLTag.AlnalyseValue

procedure TddHTMLTag.AnalyseCharSet;
//#UC START# *5243DC4B004C_524159C700FE_var*
var
 i         : TddHTMLCodePage;
 l_Param   : TddHTMLParam;
 l_FindStr : Tl3PCharLen;
 l_NewParam: TddHTMLParam;
//#UC END# *5243DC4B004C_524159C700FE_var*
begin
//#UC START# *5243DC4B004C_524159C700FE_impl*
 l_Param := f_ParamsList.Last;
 l_Param.rFinish := Max(l_Param.rFinish, f_ParamsString.Len);
 l_FindStr := l3PCharLenPart(f_ParamsString.St, l_Param.rStart, l_Param.rFinish, f_ParamsString.CodePage);
 l_NewParam.rType := dd_parCharet;
 l_NewParam.rCharset := cp_Ansi;
 for i := Low(TddHTMLCodePage) to High(TddHTMLCodePage) do
  if l3Compare(carHTMLCodePage[i], l_FindStr, l3_siCaseUnsensitive) = 0 then
  begin
   l_NewParam.rCharset := ddHTMLCodePage2CodePage(i);
   Break;
  end;
 f_ParamsList.DeleteLast;
 f_ParamsList.Add(l_NewParam);
//#UC END# *5243DC4B004C_524159C700FE_impl*
end;//TddHTMLTag.AnalyseCharSet

procedure TddHTMLTag.AddVAlignValue;
//#UC START# *5243EEC40233_524159C700FE_var*
var
 i        : TddCellJust;
 l_Param  : TddHTMLParam; 
 l_FindStr: Tl3PCharLen;
//#UC END# *5243EEC40233_524159C700FE_var*
begin
//#UC START# *5243EEC40233_524159C700FE_impl*
 if not CanAddNewValue then Exit;
 l_Param.rType := dd_parVAlign;
 l_FindStr := l3PCharLenPart(f_ParamsString.St, f_Start, f_ParamsString.Len, f_ParamsString.CodePage);
 l_Param.rVAlign := cellTop;
 for i := Low(carHTMLVAign) to High(carHTMLVAign) do
  if l3Compare(carHTMLVAign[i], l_FindStr, l3_siCaseUnsensitive) = 0 then
  begin
   l_Param.rVAlign := i;
   Break;
  end; // if l3Compare(carHTMLVAign[i], l_FindStr, l3_siCaseUnsensitive) = 0 then
 f_ParamsList.Add(l_Param);
 f_Start := -1;
 f_ParserAction := dd_ppaAddNewValue;
//#UC END# *5243EEC40233_524159C700FE_impl*
end;//TddHTMLTag.AddVAlignValue

procedure TddHTMLTag.TryAddPercent;
//#UC START# *524404A90270_524159C700FE_var*
var
 l_Param     : TddHTMLParam;
 l_ParamType : TddHTMLParamID;
//#UC END# *524404A90270_524159C700FE_var*
begin
//#UC START# *524404A90270_524159C700FE_impl*
 if not IsNil then
 begin
  l_Param := f_ParamsList.Last;
  if (l_Param.rType = dd_parInteger) then
  begin
   l_ParamType := GetPrevParamType;
   if l_ParamType <> dd_paridWidth then Exit;
   l_Param.rIsPercent := True;
   f_ParamsList.DeleteLast;
   f_ParamsList.Add(l_Param);
  end; // if (l_Param.rType = dd_parInteger) then
 end;
//#UC END# *524404A90270_524159C700FE_impl*
end;//TddHTMLTag.TryAddPercent

procedure TddHTMLTag.AnalyseHREF(aHRefSeacher: Tl3RegularSearch);
//#UC START# *524564CF0269_524159C700FE_var*
var
 l_Param      : TddHTMLParam;
 l_HREFStr    : Tl3PCharLen;
 l_NewParam   : TddHTMLParam;
 l_REPosition : Tl3MatchPosition;
//#UC END# *524564CF0269_524159C700FE_var*
begin
//#UC START# *524564CF0269_524159C700FE_impl*
 l_Param := f_ParamsList.Last;
 l_Param.rFinish := Max(l_Param.rFinish, f_ParamsString.Len);
 l_HREFStr := l3PCharLenPart(f_ParamsString.St, l_Param.rStart, l_Param.rFinish, f_ParamsString.CodePage);
 l_NewParam.rType := dd_parHREF;
 l_NewParam.rDocID := 0;
 l_NewParam.rSubID := 0;
 if aHRefSeacher.SearchInString(l_HREFStr.S, 0, l_HREFStr.SLen, l_REPosition) and
     (aHRefSeacher.TagParts.Count = 2) then
 begin
  l_NewParam.rDocID := StrToInt(aHRefSeacher.TagParts[0].AsString);

  if (Length(aHRefSeacher.TagParts[1].AsString) > 0) then
    l_NewParam.rSubID := StrToInt(aHRefSeacher.TagParts[1].AsString)
  else
    l_NewParam.rSubID := 0;

  // Исключаем ссылки на служебные топики с www-ссылками
  if CheckServiceDocID(l_NewParam.rDocID) then
   l_NewParam.rDocID := 0;
 end;
 f_ParamsList.DeleteLast;
 f_ParamsList.Add(l_NewParam);
//#UC END# *524564CF0269_524159C700FE_impl*
end;//TddHTMLTag.AnalyseHREF

procedure TddHTMLTag.AnalyseStyle;
//#UC START# *525BAB8C0005_524159C700FE_var*
var
 l_Param    : TddHTMLParam;
 l_AlignStr : Tl3PCharLen;
//#UC END# *525BAB8C0005_524159C700FE_var*
begin
//#UC START# *525BAB8C0005_524159C700FE_impl*
 l_Param := f_ParamsList.Last;
 l_Param.rFinish := Max(l_Param.rFinish, f_ParamsString.Len);
 l_AlignStr := l3PCharLenPart(f_ParamsString.St, l_Param.rStart, l_Param.rFinish, f_ParamsString.CodePage);
 if l3Compare(csHTMLTextAlign, l_AlignStr, l3_siCaseUnsensitive) = 0 then
 begin
  f_ParamsList.DeleteLast; // Удаляем строковое значение...
  f_ParamsList.DeleteLast; // Удаляем ключевое слово стиля...
  Dec(f_ParamCount);
  AddKeyValue(dd_paridALIGN);
 end; // if l3Compare(carHTMLParamStrArray[i], l_FindStr, l3_siCaseUnsensitive) = 0 then
 l_AlignStr.SLen := l_AlignStr.SLen - 1;
 if l3Compare(carHTMLParamStrArray[dd_paridWIDTH], l_AlignStr, l3_siCaseUnsensitive) = 0 then
 begin
  f_ParamsList.DeleteLast; // Удаляем строковое значение...
  f_ParamsList.DeleteLast; // Удаляем ключевое слово стиля...
  Dec(f_ParamCount);
  AddKeyValue(dd_paridWIDTH);
 end; // if l3Compare(carHTMLParamStrArray[i], l_FindStr, l3_siCaseUnsensitive) = 0 then
//#UC END# *525BAB8C0005_524159C700FE_impl*
end;//TddHTMLTag.AnalyseStyle

function TddHTMLTag.Param2PCharLen(const aParam: TddHTMLParam): Tl3PCharLen;
//#UC START# *525CD0F20229_524159C700FE_var*
//#UC END# *525CD0F20229_524159C700FE_var*
begin
//#UC START# *525CD0F20229_524159C700FE_impl*
 Result := l3PCharLenPart(f_ParamsString.St, aParam.rStart, aParam.rFinish, f_ParamsString.CodePage);
//#UC END# *525CD0F20229_524159C700FE_impl*
end;//TddHTMLTag.Param2PCharLen

procedure TddHTMLTag.AddAlignValue(const aStr: Tl3String = nil);
//#UC START# *525CE52200D1_524159C700FE_var*
var
 i        : TJust;
 l_Param  : TddHTMLParam;
 l_FindStr: Tl3PCharLen;
//#UC END# *525CE52200D1_524159C700FE_var*
begin
//#UC START# *525CE52200D1_524159C700FE_impl*
 if not CanAddNewValue then Exit;
 if aStr = nil then
  l_FindStr := l3PCharLenPart(f_ParamsString.St, f_Start, f_ParamsString.Len, f_ParamsString.CodePage)
 else
  l_FindStr := l3PCharLenPart(aStr.St, 0, aStr.Len, aStr.CodePage);
 l_Param.rType := dd_parAlign;
 l_Param.rAlign := justL;
 for i := Low(carHTMLAign) to High(carHTMLAign) do
  if l3Compare(carHTMLAign[i], l_FindStr, l3_siCaseUnsensitive) = 0 then
  begin
   l_Param.rAlign := i;
   Break;
  end;
 f_ParamsList.Add(l_Param);
 f_Start := -1;
 f_ParserAction := dd_ppaAddNewValue;
//#UC END# *525CE52200D1_524159C700FE_impl*
end;//TddHTMLTag.AddAlignValue

function TddHTMLTag.CheckServiceDocID(aDocID: Integer): Boolean;
 {* Исключаем ссылки на служебные топики с www-ссылками }
//#UC START# *534FC1FC01C3_524159C700FE_var*
const
 cnServiceTopics: array [0..1] of Integer = (5273641, 890941);
var
 i: Integer;
//#UC END# *534FC1FC01C3_524159C700FE_var*
begin
//#UC START# *534FC1FC01C3_524159C700FE_impl*
 Result := False;
 for i := 0 to High(cnServiceTopics) do
 begin
  if cnServiceTopics[i] = aDocID then
  begin
   Result := True;
   Break;
  end; // if cnServiceTopics[i] = aDocID then
 end; // for i := 0 to High(cnServiceTopics) do
//#UC END# *534FC1FC01C3_524159C700FE_impl*
end;//TddHTMLTag.CheckServiceDocID

procedure TddHTMLTag.AddWidthValue;
//#UC START# *53984619001D_524159C700FE_var*
var
 l_ValType: TddCSSValueType;

 procedure lp_AddValue(aValue: Integer);
 var
  l_Param  : TddHTMLParam;
 begin
  l_Param.rType := dd_parInteger;
  l_Param.rValue := aValue;
  l_Param.rIsPercent := l_ValType = css_vtPercent;
  f_ParamsList.Add(l_Param);
  f_Start := -1;
  f_ParserAction := dd_ppaAddNewValue;
 end;

 function lp_CorrectvalueByValueType(aValue: Integer; aValueType: TddCSSValueType): Integer;
 begin
  Result := aValue;
  case aValueType of
   css_vtCM: Result := L3Cm2Inch(aValue);
   css_vtPixel: Result := EvPixel2Cm(L3Cm2Inch(aValue));
   css_vtPoint: Result := aValue;
  end;
 end;

var
 l_TimeStr: Tl3PCharLen;

 function lp_CheckValueType: TddCSSValueType;
 var
  i: TddCSSValueType;
 begin
  Result := Low(TddCSSValueType);
  for i := css_vtPixel to High(TddCSSValueType) do
   if l3Ends(carCSSValueTypeArray[i], l_TimeStr) then
   begin
    Dec(l_TimeStr.SLen, carCSSValueTypeArray[i].SLen);
    Result := i;
    Break;
   end;
 end;

var
 l_Value  : Integer;
 l_SepPos : Integer;
//#UC END# *53984619001D_524159C700FE_var*
begin
//#UC START# *53984619001D_524159C700FE_impl*
 if not CanAddNewValue then Exit;
 l_ValType := css_vtNone;
 l_TimeStr := l3PCharLenPart(f_ParamsString.St, f_Start, f_ParamsString.Len, f_ParamsString.CodePage);
 l_SepPos := ev_lpCharIndex(cc_HardSpace, l_TimeStr);
 if l_SepPos > 0 then
  l_TimeStr.SLen := l_SepPos;
 l_ValType := lp_CheckValueType;
 l_SepPos := ev_lpCharIndex(cc_Dot, l_TimeStr);
 if l_SepPos > 0 then
  l_TimeStr.SLen := l_SepPos;
 l_Value := l3StrToIntDef(l_TimeStr, propUndefined);
 l_Value := lp_CorrectvalueByValueType(l_Value, l_ValType);
 lp_AddValue(l_Value);
//#UC END# *53984619001D_524159C700FE_impl*
end;//TddHTMLTag.AddWidthValue

procedure TddHTMLTag.AnalyseBorder;
//#UC START# *56A071C8034A_524159C700FE_var*
var
 l_Prev   : TddHTMLParam;
 l_Param  : TddHTMLParam;
 l_FindStr: Tl3PCharLen;
//#UC END# *56A071C8034A_524159C700FE_var*
begin
//#UC START# *56A071C8034A_524159C700FE_impl*
 l_Param.rHasBorder := False;
 if not IsNil then
 begin
  l_Prev := f_ParamsList.Last;
  if (l_Prev.rType = dd_parString) then
   f_ParamsList.DeleteLast
 end; // if not IsNil then
 if not IsNil then
 begin
  l_Param := f_ParamsList.Last;
  if (l_Param.rType = dd_BorderPart) then
   f_ParamsList.DeleteLast;
 end; // if not IsNil then
 l_Param.rType := dd_BorderPart;
 l_FindStr := l3PCharLenPart(f_ParamsString.St, f_Start, f_ParamsString.Len, f_ParamsString.CodePage);
 if l3Compare(carHTMLBorderStyle, l_FindStr, l3_siCaseUnsensitive) = 0 then
  l_Param.rHasBorder := True;
 f_ParamsList.Add(l_Param);
 f_Start := -1;
 f_ParserAction := dd_ppaAddNewValue;
 if f_ParamsString.Last = cc_SemiColon then
  AddKeyValue(dd_paridSTYLE);
//#UC END# *56A071C8034A_524159C700FE_impl*
end;//TddHTMLTag.AnalyseBorder

procedure TddHTMLTag.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_524159C700FE_var*
//#UC END# *479731C50290_524159C700FE_var*
begin
//#UC START# *479731C50290_524159C700FE_impl*
 f_Start := -1;
 f_ParserAction := dd_ppaAddNewValue;
 f_ParamCount := 0;
 l3Free(f_ParamsList);
 l3Free(f_ParamsString);
 inherited;
//#UC END# *479731C50290_524159C700FE_impl*
end;//TddHTMLTag.Cleanup

end.
