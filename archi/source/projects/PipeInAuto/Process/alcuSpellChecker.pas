unit alcuSpellChecker;
{ Автоматическая проверка орфографии }

{ $Id: alcuSpellChecker.pas,v 1.5 2015/04/07 07:35:53 lukyanets Exp $ }

// $Log: alcuSpellChecker.pas,v $
// Revision 1.5  2015/04/07 07:35:53  lukyanets
// Изолируем HT
//
// Revision 1.4  2014/08/26 14:10:43  lukyanets
// Учимся прерывать
//
// Revision 1.3  2014/08/25 13:38:49  lukyanets
// Переносим логику в таск
//
// Revision 1.2  2014/08/05 06:30:30  lukyanets
// {Requestlink:558466572}. Правильные Define
//
// Revision 1.1  2014/07/28 15:18:16  lukyanets
// {Requestlink:557844282}. Используем правильный ProjectDefine.inc
//
// Revision 1.15  2012/10/26 07:28:35  narry
// Залить новую партию НСРов (406126937)
//
// Revision 1.14  2012/01/25 12:34:32  fireton
// - находилось только первое ошибочное слово в параграфе (К 330140650)
//
// Revision 1.13  2012/01/24 10:13:02  fireton
// - проверка слов с помощью префиксов, стоп-слов и словаря заведомо валидных слов (К 321986535)
//
// Revision 1.12  2011/10/10 10:43:25  narry
// Не работала проверка орфографии в выборке
//
// Revision 1.11  2011/09/08 08:03:05  fireton
// - поменялось название метода (Update -> ProcessUpdate)
//
// Revision 1.10  2011/06/14 13:48:40  narry
// Фильтрация "хороших" ошибок (269065128)
//
// Revision 1.9  2011/05/31 14:07:40  narry
// Забытый модуль
//
// Revision 1.8  2011/05/16 13:37:00  narry
// Обработка запроса на импорт "подготовленных" постановлений (266409024)
//
// Revision 1.7  2011/05/13 09:28:16  narry
// Проверка орфографии документов выборки (клиент)  (260447411)
//
// Revision 1.6  2011/05/12 12:33:33  narry
// Проверка орфографии документов выборки (клиент)  (260447411)
//
// Revision 1.5  2011/05/12 11:07:47  narry
// Проверка орфографии документов выборки (клиент)  (260447411)
//
// Revision 1.3  2011/05/12 08:55:57  narry
// Проверка орфографии документов выборки (клиент)  (260447411)
//
// Revision 1.2  2011/05/11 09:03:37  narry
// Проверка орфографии в выборке (сервер) (260447428)
//
// Revision 1.1  2011/05/11 08:09:27  narry
// Проверка орфографии в выборке (сервер) (260447428)
//

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses
  l3ProtoObject, ddProgressObj, l3LongintList, evdLeafParaFilter, k2Interfaces,
  evSearch, m3StorageInterfaces, l3Types, k2Types, nevTools, Classes,
  l3Interfaces, k2TagGen, csAutoSpell, ddSpellCheckFilter;

type
 TalcuSpellChecker = class(Tl3ProtoObject)
 private
  f_ErrorsList: TStrings;
  f_GoodWords: TStrings;
  f_SpellFilter: TddSpellCheckFilter;
  procedure FilterErrorList;
  procedure WrongWordFound(aTopicID: Integer; aWrongWord: Il3CString);
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  procedure AbortProcess;
  procedure Execute(aTopicsList: Im3StorageElementIDList; aProgressor:
      TddProgressObject);
  property ErrorsList: TStrings read f_ErrorsList;
 end;

implementation
Uses
 m3DBInterfaces,
 daDataProvider,
 m3DB, DT_Const, SysUtils, evTypes, k2Tags,
 evParaTools, Document_Const, Forms, l3String, l3Chars, l3Const,
 CsTaskTypes, CsProcessTask, TextPara_Const;

constructor TalcuSpellChecker.Create;
var
 l_GWFileName: String;
begin
 inherited Create;
 f_ErrorsList := TStringList.Create;
 f_GoodWords := TStringList.Create;
 l_GWFileName:= ExtractFilePath(Application.ExeName) +'\GoodWords.txt';
 if FileExists(l_GWFileName) then
  f_GoodWords.LoadFromFile(l_GWFileName);
end;

procedure TalcuSpellChecker.Cleanup;
begin
 inherited;
 FreeAndNil(f_ErrorsList);
 FreeAndNil(f_GoodWords);
end;

procedure TalcuSpellChecker.Execute(aTopicsList: Im3StorageElementIDList;
    aProgressor: TddProgressObject);
var
 l_Storage: Im3DB;
 l_Range : Im3DBRange;
 l_Errors: TStrings;
begin
 f_SpellFilter:= TddSpellCheckFilter.Create;
 try
   f_SpellFilter.OnWrongWordFound:= WrongWordFound;
   if aProgressor <> nil then
    l_Storage:= Tm3DB.Make(GlobalDataProvider.TextBase[CurrentFamily], nil, nil, aProgressor.ProcessUpdate)
   else
    l_Storage:= Tm3DB.Make(GlobalDataProvider.TextBase[CurrentFamily]);
   try
    l_Range:= l_Storage.FilesInList(aTopicsList);
    try
     l_Range.Iterate(f_SpellFilter, False, [m3_dsMain]);
    finally
     l_Range:= nil;
    end;
   finally
    l_Storage:= nil;
   end;
 finally
  FreeAndNil(f_SpellFilter);
 end;
end;

procedure TalcuSpellChecker.FilterErrorList;
var
 i: Integer;
begin
 if f_GoodWords.Count > 0 then
 begin
  i:= 0;
  while i < f_ErrorsList.Count do
  begin
   if f_GoodWords.IndexOf(AnsiLowerCase(f_ErrorsList[i])) <> -1 then
    f_ErrorsList.Delete(i)
   else
    Inc(i);
  end;
 end;
end;

procedure TalcuSpellChecker.WrongWordFound(aTopicID: Integer; aWrongWord:
    Il3CString);
begin
 f_ErrorsList.Add(SysUtils.Format('%d %s', [aTopicID, aWrongWord.AsWStr.S]));
end;

procedure TalcuSpellChecker.AbortProcess;
begin
  if Assigned(f_SpellFilter) then
    f_SpellFilter.AbortProcess;
end;

end.
