unit lukDocumentFilter;
{ Фильтрует документ до дате публикации }

// $Id: lukDocumentFilter.pas,v 1.5 2014/04/30 13:11:37 lulin Exp $

// $Log: lukDocumentFilter.pas,v $
// Revision 1.5  2014/04/30 13:11:37  lulin
// - вычищаем ненужные зависимости.
//
// Revision 1.4  2011/09/20 09:58:00  narry
// 65. Разнообразие в шапках недействующих документов (286228951)
//
// Revision 1.3  2011/09/09 09:02:57  narry
// 53. Пропускать справку вместе с документом (281525149)
//
// Revision 1.2  2011/08/29 07:48:28  narry
// 34. Оформление ключевых слов перед распорядительной частью документов (278839498)
//
// Revision 1.1  2011/08/12 11:27:14  narry
// 32. Ограничение на преобразование (278839289)
//

interface

uses
  ddDocumentFilter, k2Interfaces;

type
 TlukDocFilter = class(TddDocumentFilter)
 private
  f_LimitDate: Integer;
  f_RelID: Integer;
 protected
  function NeedFlushBuffer(const aLeaf: Tl3Tag; aTagId: Integer): Boolean; override;
 public
  property LimitDate: Integer read f_LimitDate write f_LimitDate;
 end;

implementation

uses
  k2Tags, DT_Types, l3Base, TextPara_Const;

function TlukDocFilter.NeedFlushBuffer(const aLeaf: Tl3Tag; aTagId: Integer): Boolean;
var
 l_DateNumbers: Tl3Tag;
 l_DN: Tl3Tag;
 i: Integer;
 l_Haspara: Boolean;
begin
 Result := true;
 f_RelID:= 0;
 if aLeaf.Attr[k2_tiNumAndDates].IsValid then
 begin
  l_DateNumbers:= aLeaf.Attr[k2_tiNumAndDates];
  for i:= 0 to Pred(l_DateNumbers.ChildrenCount) do
  begin
   l_DN:= l_DateNumbers.Child[i];
   if (l_DN.IntA[k2_tiType] = Ord(dnPublish)) and (l_DN.IntA[k2_tiStart] > LimitDate) then
   begin
    Result:= False;
    f_RelID:= aLeaf.IntA[k2_tiRelExternalHandle];
    l3System.Msg2Log('Слишком свежий документ, пропущен');
    break
   end; // (l_DN.IntA[k2_tiType] = Ord(dnPublish)) and (l_DN.IntA[k2_tiStart] > LimitDate)
  end; // for i
 end // aLeaf.Attr[k2_tiNumAndDates].IsValid
 else
 begin
  if (aLeaf.Attr[k2_tiExternalHandle].IsValid) and (aLeaf.IntA[k2_tiExternalHandle] = f_RelID) then
  begin
   Result:= False;
   f_RelID:= 0;
  end;
 end;
 if Result then // Ищем абзацы с текстом
 begin
  l_HasPara:= False;
  for i:= 0 to Pred(aLeaf.ChildrenCount) do
   if aLeaf.Child[i].InheritsFrom(k2_idTextPara) then
   begin
    l_HasPara:= True;
    break;
   end; // if aLeaf.Child[i].InheritsFrom(k2_idTextPara)
  Result:= l_HasPara;
  if not Result then
  begin
   f_RelID:= aLeaf.IntA[k2_tiRelExternalHandle];
   l3System.Msg2Log('Документ без текста, пропущен');
  end;
 end; // result
end;

end.
