unit arTextUtils;

{ $Id: arTextUtils.pas,v 1.5 2015/07/08 12:03:59 dinishev Exp $ }

{$Include evDefine.inc }

interface

uses
 evCustomEditor,
 evCommonTypes,

 l3Chars;

const
 cc_DigitEX = cc_Digits + [cc_Dot];
 cc_SeparatorChars = [cc_Dot, cc_HardSpace];

 function arMakeNameStr(const aEditor      : TevCustomEditor;
                        const aBlockCursor : InevCommonPoint;
                        aCodePage          : Integer): string;

 function GetNumberFromStr(aStr : AnsiString) : Longint;

implementation

uses
 SysUtils,

 k2Tags,

 evdStyles,

 l3Interfaces,
 l3Types,
 l3String,

 evInternalInterfaces,
 evFacadeSelection,
 nevFacade,
 evEditorWindow,

 TextPara_Const
 ;

function arGetNewBlockName(const aEditor: TevCustomEditor): Tl3PCharLen;
var
 l_BlockName: Tl3PCharLen absolute Result;

 function CheckRange(const aSelection : TnevIRange;
                           anIndex    : Long): Boolean;
 begin
  if aSelection.Obj.IsKindOf(k2_typTextPara) then
   Tl3WString(l_BlockName) := aSelection.Obj.Attr[k2_tiText].AsWStr;
  Result := l_BlockName.SLen = 0; 
 end;

var
 l_Block : TnevIRange;
 l_Range : InevRange;
begin
 Result := aEditor.CurText;
 if aEditor.Selection <> nil then
 begin
  l_Block := evGetSel(aEditor);
  if l_Block <> nil then
  begin
   l_Range := evGetBottomChildBlock(l_Block, aEditor);
   if l_Range <> nil then
    l_Range.IterateF(evL2TSA(@CheckRange));
  end // if l_Block <> nil then
 end // if aEditor.Selection <> nil then
end;

function arMakeNameStr(const aEditor      : TevCustomEditor;
                       const aBlockCursor : InevCommonPoint;
                       aCodePage          : Integer): string;
var
 I                  : Integer;
 l_NameStrLen       : Integer;
 l_IsSubArticleTest : Boolean;
 l_IsSubArticle     : Boolean;
begin
 Result := l3DeleteDoubleSpace(Trim(l3ReplaceNonReadable(l3PCharLen2String(arGetNewBlockName(aEditor), aCodePage))));

 l_NameStrLen := Length(Result);

 if (l_NameStrLen > 0) then
 begin
  if (Result[1] in cc_Digits) then
  begin
   I := 0;
   l_IsSubArticle := False;
   l_IsSubArticleTest := False;
   while (Succ(I) <= l_NameStrLen) and (Result[I + 1] in cc_DigitEX) do
   begin
    Inc(I);
    if Result[I] = cc_Dot then  //Ищем точку и след. цифру
     l_IsSubArticleTest := True
    else
     if l_IsSubArticleTest and (Result[I] in cc_Digits) then
      l_IsSubArticle := True
     else
      l_IsSubArticleTest := False;
   end; // while (Succ(I) <= l_NameStrLen) and (Result[Succ(I)] in ['0'..'9', '.']) do

   if Result[I] = cc_Dot then
    Dec(I);

   if (aBlockCursor.Obj.Attr[k2_tiStyle].AsLong = ev_saTxtHeader1) then
    Result := 'Раздел ' + System.Copy(Result, 1, I)
   else
    if l_IsSubArticle then
     Result := 'Подпункт ' + System.Copy(Result, 1, I)
    else
     Result := 'Пункт ' + System.Copy(Result, 1, I);
  end // if (Result[1] in cc_Digits) then
  else
   if (Result[1] in cc_RomeDigits) then
   begin
    I := 1;
    while (I < l_NameStrLen) and (Result[I] in cc_RomeDigits) do
     Inc(I);
    if Result[I] in cc_SeparatorChars then
     Result := 'Раздел ' + System.Copy(Result, 1, I - 1);
   end // if (Result[1] in cc_RomeDigits) then
   else
   if AnsiUpperCase(System.Copy(Result, 1, 5)) = 'ГЛАВА' then
   begin
    I := 6;
    while (I < l_NameStrLen) and (Result[I] <> cc_Dot) do
     Inc(I);
    Result := System.Copy(Result, 1, I - 1);
   end // if AnsiUpperCase(System.Copy(Result, 1, 5)) = 'ГЛАВА' then
   else
    if (AnsiUpperCase(System.Copy(Result, 1, 6)) = 'РАЗДЕЛ') or
       ((AnsiUpperCase(System.Copy(Result, 1, 6)) = 'СТАТЬЯ') and
        (aBlockCursor.Obj.Attr[k2_tiStyle].AsLong <> ev_saArticleHeader)) then
    begin
     I := 7;
     while (I <= l_NameStrLen) and not (Result[I] = cc_Dot) do
      Inc(I);
     Result := System.Copy(Result, 1, I - 1);
    end; // if (AnsiUpperCase(System.Copy(Result, 1, 6)) = 'РАЗДЕЛ') or
 end; // if (l_NameStrLen > 0) then
end;

 (*
  //вариант, который берет только первое число ло точки "4.1.1" = 4
 function GetNumberFromStr(aStr : AnsiString) : Longint;
   {Ищет число в строке. Используется при простановке номера Sub'a}
  var
    IB,IE : Integer;
  begin
   IB:=1;
   Result := -1;
   While (IB <= Length(aStr)) and not (aStr[IB] in cc_Digits) do Inc(IB);
   If (IB > Length(aStr)) then Exit;
   IE := Succ(IB);
   While (IE <= Length(aStr)) and (aStr[IE] in cc_Digits) do Inc(IE);
   try
    Result := StrToInt(Copy(aStr,IB,IE-IB));
   except
   end;
  end;
 *)

 //вариант, который берет все цифры "4.1.1" = 411
function GetNumberFromStr(aStr : AnsiString) : Longint;
 {Ищет число в строке. Используется при простановке номера Sub'a}
var
 I      : Integer;
 lStr   : AnsiString;
 l_Start: Integer;
begin
 lStr := '';
 Result := 0;
 l_Start := 1;
 while (l_Start <= Length(aStr)) and not (aStr[l_Start] in cc_Digits) do // http://mdp.garant.ru/pages/viewpage.action?pageId=603181885
  Inc(l_Start);
 for I := l_Start to Length(aStr) do
  if aStr[I] in cc_Digits then
   lStr := lStr + aStr[I]
  else
   if aStr[I] <> '.' then
    Break;
 TryStrToInt(lStr, Result);
end;

end.
