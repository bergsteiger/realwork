unit dd_lcParticipantEraser;
{ Фильтр для удаления участнико дела из названия документа }


{ $Id: dd_lcParticipantEraser.pas,v 1.5 2014/04/29 14:06:17 lulin Exp $ }

// $Log: dd_lcParticipantEraser.pas,v $
// Revision 1.5  2014/04/29 14:06:17  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.4  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.3  2011/12/20 13:53:10  fireton
// - исправление ошибки (AV если не было слов "(ключевые темы")
// - оптимизация по скорости
//
// Revision 1.2  2011/10/21 13:12:56  narry
// Накопившиеся изменения
//
// Revision 1.1  2011/09/07 11:43:34  narry
// Забытый модуль
//

interface

uses
 l3Interfaces, l3Types,
 ddParticipantsConst, dd_lcBaseHeaderFilter, k2Interfaces, l3Base, k2TagGen, dt_types;

type
 Tdd_lcParticipantsString = record
  rString: Il3CString;
  rBT    : Tl3BMTable;
 end;

 Tdd_lcParticipants = array [TlcParticipantType] of Tdd_lcParticipantsString;
 Tdd_lcParticipantEraserFilter = class(Tdd_lcBaseHeaderFilter)
 private
  f_Participants: Tdd_lcParticipants;
  f_KTString : Tl3WString;
  f_KTBMTable: Tl3BMTable;
 protected
  procedure BeforeFlushHeader(aHeaderRoot: Tl3Tag); override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner); override;
 end;

implementation

uses
  k2Tags,  StrUtils, SysUtils,
  l3Const,
  l3String,
  l3BMSearch;

const
 cKTStr = '(КЛЮЧЕВЫЕ ТЕМЫ';

constructor Tdd_lcParticipantEraserFilter.Create(anOwner: Tk2TagGeneratorOwner);
var
 i: TlcParticipantType;
begin
 inherited Create(anOwner);
 for i:= Low(TlcParticipantType) to High(TlcParticipantType) do
 begin
  f_Participants[i].rString := l3Upper(l3CStr('. ' + cParticipants[i] + ': '));
  with f_Participants[i].rString.AsWStr do
   BMMakeTable(S, f_Participants[i].rBT, SLen);
 end;
 f_KTString := l3PAnsiCharLen(String(cKTStr));
 BMMakeTable(f_KTString.S, f_KTBMTable, f_KTString.SLen);
end;

procedure Tdd_lcParticipantEraserFilter.BeforeFlushHeader(aHeaderRoot: Tl3Tag);
var
 l_Pos1, l_Pos2: Cardinal;
 l_Name: Tl3Tag;
 i: TlcParticipantType;
 l_Topic: AnsiString;
 l_NameStr: Il3CString;
 l_Part: Tl3WString;
begin
 l_Name:= aHeaderRoot.Attr[k2_tiName];
 if l_Name.IsValid then
 begin
  l_NameStr := l3CStr(l_Name.AsPAnsiCharLen);
  if not l3IsNil(l_NameStr) then
  begin
   // Нужно искать предложения, начинающиеся с "Участник:" и удалять их из названия
   for i:= Low(TlcParticipantType) to High(TlcParticipantType) do
   begin
    //l_Pos1 := l3Pos(l_NameStr, f_Participants[i], False);
    if l3SearchStrUC(l_NameStr.AsWStr, f_Participants[i].rBT, f_Participants[i].rString.AsWStr, l_Pos1) then
    begin
     l_Part := l3Copy(l_NameStr.AsWStr, Succ(l_Pos1));
     if l3SearchStrUC(l_Part, f_KTBMTable, f_KTString, l_Pos2) then
      l_Pos2 := l_Pos2 + Succ(l_Pos1)
     else
      l_Pos2 := MaxInt;
     l3Delete(l_NameStr, l_Pos1, l_Pos2 - l_Pos1 - 1);
     l_Topic:= IntToStr(aHeaderRoot.IntA[k2_tiExternalHandle]);
     ErrorReaction(l_Topic);
    end; // if l_Pos1 <> l3NotFound
   end; // for i
   aHeaderRoot.PAnsiCharLenW[k2_tiName, nil] := l_NameStr.AsWStr;
  end;
 end;
end;

end.
