unit dd_lcMisspellFilter;
// Фильтр исправления опечаток

{ $Id: dd_lcMisspellFilter.pas,v 1.12 2015/11/26 08:45:43 lukyanets Exp $ }
// $Log: dd_lcMisspellFilter.pas,v $
// Revision 1.12  2015/11/26 08:45:43  lukyanets
// КОнстанты переехали
//
// Revision 1.11  2014/04/04 07:14:45  dinishev
// Bug fix: не собирался Арчи.
//
// Revision 1.10  2013/10/21 17:31:11  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.9  2013/10/21 10:31:05  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.8  2013/04/15 05:59:22  narry
// Не собиралось
//
// Revision 1.7  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.6  2012/07/13 11:26:25  narry
// Уточнение для исправления опечаток из Арчи
//
// Revision 1.5  2011/09/13 11:10:04  narry
// Исправлять опечатки в словах с точкой на конце (283613254)
//
// Revision 1.4  2011/09/07 11:41:03  narry
// Логирование изменений CVS
//

interface

uses dd_lcBaseDocFilter, dd_lcBaseFilter, l3PrimString, l3ValLst, l3Types, l3Base, k2Types, l3Interfaces;

type
 Tdd_lcMisspellFilter = class(Tdd_lcSynoFilter, Il3DocIDSource)
 private
  f_DocID: Integer;
  f_ExtDocID: Integer;
  f_text: Tl3String;
  function CheckWord(const aStr : Tl3PCharLen; IsLast: Bool): Boolean;
 protected
        {-}
  procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
  function pm_GetDocID: Integer;
  procedure pm_SetDocID(aValue: Integer);
 public
  property DocID: Integer read pm_GetDocID write pm_SetDocID;
 end;

implementation

uses
 l3String, l3Chars, SysUtils, l3BMSearch, TextPara_Const, l3Variant,
 Participant_Const, DT_LinkServ, daSchemeConsts;

function Tdd_lcMisspellFilter.CheckWord(const aStr : Tl3PCharLen; IsLast: Bool): Boolean;
var
 l_CorrectText, l_WrongText: AnsiString;
 l_Pos: Cardinal;
begin
 Result := True;
 l_WrongText:= l3PCharLen2String(aStr);
 if CheckValue(l_WrongText,  l_CorrectText) or CheckValue(l_WrongText+'.',  l_CorrectText) then
 begin
  if f_ExtDocID <> -1 then
   ErrorReaction('%d %s->%s', [f_ExtDocID, l_WrongText,  l_CorrectText])
  else
   ErrorReaction('%d (внутр.) %s->%s', [DocID, l_WrongText,  l_CorrectText]);
  l_Pos:= AnsiPos(l_WrongText, f_Text.AsString);
  if l_Pos > 0 then
  begin
   f_Text.Delete(Pred(l_Pos), aStr.SLen);
   f_text.Insert(l3PCharLen(l_CorrectText), Pred(l_Pos));
  end; // l_Pos > 0
 end // CheckValue(l_WrongText,  l_CorrectText)
 else
  l_CorrectText:= StrPas(aStr.S);
end;

procedure Tdd_lcMisspellFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
begin
 if CurrentType.IsKindOf([k2_typTextPara, k2_typParticipant]) then
 begin
  if Value.Kind = k2_vkString then
  begin
   f_text:= Tl3String.Make(Value.AsString as Tl3String);
   try
    l3ParseWordsEx(Value.AsString.AsWStr, CheckWord, cc_WordDelimANSISet); //не найдет опечатки в словах с точкой 
    Value.AsString.AssignString(f_text);
   finally
    FreeAndNil(f_Text);
   end; // try..finally
  end // Value.Kind = k2_vkString
 end;
 inherited DoAddAtomEx(AtomIndex, Value);
end;

function Tdd_lcMisspellFilter.pm_GetDocID: Integer;
begin
 Result:= f_DocID;
end;

procedure Tdd_lcMisspellFilter.pm_SetDocID(aValue: Integer);
begin
 f_DocID:= aValue;
 if LinkServer(CurrentFamily) <> nil then
  f_ExtDocID:=  LinkServer(CurrentFamily).Renum.GetExtDocID(DocID)
 else
  f_ExtDocID:= -1;
end;

end.
