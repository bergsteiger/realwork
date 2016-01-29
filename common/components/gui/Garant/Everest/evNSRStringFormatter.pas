unit evNSRStringFormatter;

{ Библиотека "Эверест"    }
{ Начал: Инишев Д.А.       }
{ Модуль: evNSRStringFormatter - форматтер строки с гиперссылками для NSR. }
{ Начат: 21.09.2006 10:18 }
{ $Id: evNSRStringFormatter.pas,v 1.5 2010/08/11 09:05:17 dinishev Exp $ }

// $Log: evNSRStringFormatter.pas,v $
// Revision 1.5  2010/08/11 09:05:17  dinishev
// [$182452385]. Вернул, т.к. в Немезисе и в модели разъехалось - недоглядел. :-(
//
// Revision 1.4  2010/08/11 06:48:44  dinishev
// [$182452385]
//
// Revision 1.3  2007/12/04 13:04:55  lulin
// - объединяем два каталога с исходниками Эвереста.
//
// Revision 1.2  2006/11/03 10:59:46  lulin
// - объединил с веткой 6.4.
//
// Revision 1.1.2.2  2006/10/12 16:10:18  lulin
// - переехали в общую папку.
//
// Revision 1.1  2006/10/12 15:26:30  lulin
// - переехали в общую папку.
//
// Revision 1.1  2006/09/21 12:27:40  dinishev
// new class: TevNSRCStringFormatter - для формирования строк с гиперссылками
//

{$Include evDefine.inc }

interface

uses
 l3Base,
 l3Types,
 l3StringFormatter;

type 
 TevNSRCStringFormatter = class(Tl3StringFormatted) 
 private
  f_HypLnkStartText : Long;
    {* - Позиция начала текста гиперссылки. }
  f_HypLnkEndText   : Long;
    {* - Позиция окончания текста гиперссылки. }
  f_HypLnkEndPos    : Long; 
    {* - Позиция окончания данных о гиперссылке. }
  procedure InitHyperlinkPositions;
    {-}    
 protected
  procedure DoBeforeFormatting; override;
    {* - Действия перед началом форматирования строки. }
  procedure DoBeforeInsertSpaces; override;
    {* - Действия перед вставкой пробелов. }
  procedure DoAfterInsertSpaces; override;
    {* - Действия после вставкой пробелов. } 
 end;

implementation

uses
 l3Chars;

{ TevNSRCStringFormatter }

procedure TevNSRCStringFormatter.DoAfterInsertSpaces;
begin
 if f_HypLnkStartText > -1 then
  // - Если была вставка пробелов, то могли "поехать" координаты гиперссылки. 
  InitHyperlinkPositions;
end;

procedure TevNSRCStringFormatter.DoBeforeFormatting;
begin
 f_HypLnkStartText := 0;
 InitHyperlinkPositions;
end;

procedure TevNSRCStringFormatter.DoBeforeInsertSpaces;
begin
 if f_HypLnkStartText > -1 then
 // - Анализируем гиперссылки...
 begin
  if f_CurrSpacePos > f_HypLnkEndPos then 
  // - Вышли за границу гиперссылки.
  begin
   f_HypLnkStartText := f_HypLnkEndPos + 1;
   InitHyperlinkPositions;
  end;//if l_CharIndex > l_HypLnkEndPos then
  if (f_HypLnkStartText > -1) and (f_HypLnkEndText < f_CurrSpacePos) 
     and (f_CurrSpacePos < f_HypLnkEndPos) then
  // - Попали в область с данными о гиперссылке - не нужно добавлять пробелы.
   f_CurrSpaceCnt := 0;
 end;//if l_HypLnkStartText > -1 then
end;

procedure TevNSRCStringFormatter.InitHyperlinkPositions;
begin
 f_HypLnkStartText := f_String.FindChar(f_HypLnkStartText, cc_HyperLinkChar); 
 if f_HypLnkStartText > -1 then
 begin  
  f_HypLnkEndText := f_HypLnkStartText + 1;
  f_HypLnkEndText := f_String.FindChar(f_HypLnkEndText, cc_HyperLinkChar);
  if f_HypLnkEndText > -1 then 
  begin
   f_HypLnkEndPos := f_HypLnkEndText + 1;
   f_HypLnkEndPos := f_String.FindChar(f_HypLnkEndPos, cc_HyperLinkChar);
  end
  else
   f_HypLnkEndPos := f_HypLnkEndText;
 end
 else
 begin
  f_HypLnkEndText := -1; 
  f_HypLnkEndPos := -1;
 end; 
end;

end.

