unit evdKW;
{* Таблица ключевых слов формата evd. }

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evdKW -         }
{ Начат: 13.10.1999 12:09 }
{ $Id: evdKW.pas,v 1.6 2010/02/27 10:50:25 lulin Exp $ }

// $Log: evdKW.pas,v $
// Revision 1.6  2010/02/27 10:50:25  lulin
// {RequestLink:193822954}.
// - упрощаем структуры.
//
// Revision 1.5  2009/07/21 15:10:14  lulin
// - bug fix: не собирался и не работал Архивариус в ветке.
//
// Revision 1.4  2008/02/06 09:55:27  lulin
// - глобальные объекты сделаны индексированным свойством.
//
// Revision 1.3  2008/02/05 09:58:07  lulin
// - выделяем базовые объекты в отдельные файлы и переносим их на модель.
//
// Revision 1.2  2007/08/29 15:04:50  lulin
// - страхуемся от попытки чтнения неверного формата.
//
// Revision 1.1  2005/06/23 13:08:26  lulin
// - файл с ключевыми словами переехал в папку EVD.
//
// Revision 1.11.4.1  2005/05/18 12:42:46  lulin
// - отвел новую ветку.
//
// Revision 1.10.6.2  2005/05/18 12:32:08  lulin
// - очередной раз объединил ветку с HEAD.
//
// Revision 1.10.6.1  2005/04/28 09:18:29  lulin
// - объединил с веткой B_Tag_Box.
//
// Revision 1.10.14.1  2005/04/26 14:30:39  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.11  2005/04/28 15:03:37  lulin
// - переложил ветку B_Tag_Box в HEAD.
//
// Revision 1.10.14.1  2005/04/26 14:30:39  lulin
// - ускоряем l3Free и _l3Use.
//
// Revision 1.10  2004/09/28 17:21:56  lulin
// - в первом приближении сделал кеш документов. Пока без вымещения покументов на диск.
//
// Revision 1.9  2004/04/15 09:59:01  law
// - bug fix: защитил глобальные объекты для многозадачности.
//
// Revision 1.8  2003/03/11 10:30:17  law
// - new class: Tl3StringMap.
//
// Revision 1.7  2001/09/04 16:47:26  law
// - comments: xHelpGen.
//
// Revision 1.6  2000/12/19 15:52:40  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.5  2000/12/15 15:10:35  law
// - вставлены директивы Log.
//

{$Include evdDefine.inc }

interface

uses
  l3Types,
  l3Base,
  l3KeyWrd
  ;

const
  evd_kwBinary       = 0;
    {* - начало бинарных данных. }
  evd_kwProducer     = 1;
    {* - создатель документа. }
  evd_kwBrackets     = 2;
    {* - директива смены скобок объекта. }
  evd_kwInary        = 3;
    {* - конец бинарных данных. }
  evd_kwNdBinary     = 4;
    {* - конец бинарных данных. }
  evd_kwEndPlainText = 5;
    {* - конец неформатированного текста. }
  evd_kwPlainText    = 6;
    {* - начало неформатированного текста. }
  evd_kwVersion      = 7;
    {* - версия. }
  evd_kwRevision     = 8;
    {* - ревизия. }
  evd_kwDate         = 9;
    {* - дата. }
  evd_kwComment      = 10;
    {* - директива смены строкового комментария. }
  evd_kwLineComment  = 11;
    {* - директива смены строкового комментария. }
  evd_kwFormat       = 12;
    {* - признак смены формата. }
  evd_kwEndBinary    = 13;
    {* - конец бинарных данных. }
  evd_kwPBinary      = 14;
    {* - начало бинарных данных. }

function EvdKeyWords: Tl3KeyWords;
 {* Таблица ключевых слов формата evd. }

implementation

var g_EvdKeyWords : Tl3KeyWords = nil;

procedure EvdKeyWordsFree;
begin
 l3Free(g_EvdKeyWords);
end;

function EvdKeyWords: Tl3KeyWords;
begin
 with l3System do
 begin
  EnterGlobalCS;
  try
   if (g_EvdKeyWords = nil) then
   begin
    AddExitProc(EvdKeyWordsFree);
    g_EvdKeyWords := Tl3KeyWords.Create;
    try
     g_EvdKeyWords.AddKeyWord('binary', evd_kwBinary);
     g_EvdKeyWords.AddKeyWord('producer', evd_kwProducer);
     g_EvdKeyWords.AddKeyWord('brackets', evd_kwBrackets);
     g_EvdKeyWords.AddKeyWord('inary', evd_kwInary);
     g_EvdKeyWords.AddKeyWord('ndbinary', evd_kwNdBinary);
     g_EvdKeyWords.AddKeyWord('endplaintext', evd_kwEndPlainText);
     g_EvdKeyWords.AddKeyWord('plaintext', evd_kwPlainText);
     g_EvdKeyWords.AddKeyWord('version', evd_kwVersion);
     g_EvdKeyWords.AddKeyWord('revision', evd_kwRevision);
     g_EvdKeyWords.AddKeyWord('date', evd_kwDate);
     g_EvdKeyWords.AddKeyWord('comment', evd_kwComment);
     g_EvdKeyWords.AddKeyWord('linecomment', evd_kwLineComment);
     g_EvdKeyWords.AddKeyWord('format', evd_kwFormat);
     g_EvdKeyWords.AddKeyWord('endbinary', evd_kwEndBinary);
     g_EvdKeyWords.AddKeyWord('pbinary', evd_kwPBinary);
     Result := g_EvdKeyWords;
    except
     l3Free(g_EvdKeyWords);
     raise;
    end;//try..except
   end//g_EvdKeyWords = nil
   else
    Result := g_EvdKeyWords;
  finally
   LeaveGlobalCS;
  end;//try..finally
 end;//with l3System
end;

end.

