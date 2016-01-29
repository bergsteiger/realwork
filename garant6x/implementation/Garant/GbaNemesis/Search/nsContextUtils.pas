unit nsContextUtils;

{-----------------------------------------------------------------------------
 Название:   nsContextUtils
 Автор:      М. Морозов
 Назначение: Процедуры и функции для работы с контекстом.
 История:    $Id: nsContextUtils.pas,v 1.17 2012/03/23 13:03:46 lulin Exp $
             $Log: nsContextUtils.pas,v $
             Revision 1.17  2012/03/23 13:03:46  lulin
             - отпиливаем настройки.

             Revision 1.16  2009/02/20 12:25:15  lulin
             - <K>: 136941122.

             Revision 1.15  2008/10/21 12:07:08  oman
             - fix: Обрабатываем одинарную кавычку (К-121157521)

             Revision 1.14  2008/10/21 11:47:33  oman
             - fix: Не обрываем одинарные кавычки (К-121157521)

             Revision 1.13  2008/07/14 13:42:56  oman
             - fix: Не правильно разбирали контекст по фразам  (К-100008827)

             Revision 1.12  2007/07/11 12:55:41  oman
             - fix: При контекстном поиске парные двойные кавычки заменяем
              прямыми (cq25909)

             Revision 1.11  2007/04/05 12:20:56  lulin
             - cleanup.

             Revision 1.10  2007/02/16 14:53:09  lulin
             - избавляемся от использования стандартных строк.

             Revision 1.9  2007/02/13 09:37:53  lulin
             - cleanup.

             Revision 1.8  2007/02/13 09:33:52  lulin
             - переводим на строки с кодировкой.

             Revision 1.7  2007/02/02 08:39:25  lulin
             - переводим на строки с кодировкой.

             Revision 1.6  2004/12/10 10:31:42  mmorozov
             change: название модуля перенесено выше;

             Revision 1.5  2004/09/17 12:59:13  lulin
             - все что было возможно перевел с _TStrings на IvcmStrings.

             Revision 1.4  2004/09/15 14:11:45  lulin
             - заменил _TStringList на _TvcmStringList.

             Revision 1.3  2004/07/05 06:21:08  mmorozov
             change: comment;

             Revision 1.2  2004/07/02 14:41:56  mmorozov
             new: cvs log;
-----------------------------------------------------------------------------}

{$Include nsDefine.inc}

interface

// <no_string>

uses
  Classes,

  l3Interfaces,
  
  vcmExternalInterfaces,
  vcmInterfaces
  ;

function CheckContext(const aContext : Il3CString) : Il3CString;
  {* - проверяет верность введенного контекста. }
function AddPhrase(const aContext : Il3CString; const aPhrase : Il3CString): Il3CString;
  {* - добавляет фразу к строке контекста. }
function ContextToPhrases(const aContext : Il3CString) : IvcmStrings;
  {* - делит строку контекста на фразы. }

implementation

uses
  StrUtils,
  SysUtils,

  l3String,
  l3Chars,

  vcmStringList,

  nsTypes
  ;

const
  cPhraseSeparator = ';';
    {* - символ использующийся для разделения фраз. }

function AddPhrase(const aContext : Il3CString; const aPhrase : Il3CString) : Il3CString;
  {* - добавляет фразу к строке контекста. }
begin
 Result := aContext;
 if not l3IsNil(aPhrase) then
 begin
  if l3IsNil(aContext) then
   Result := CheckContext(aPhrase)
  else
   Result := l3Cat([l3Cat(aContext, cPhraseSeparator), CheckContext(aPhrase)]);
 end;//not l3IsNil(aPhrase)
end;

function CheckContext(const aContext : Il3CString) : Il3CString;
  {* - проверяет верность введенного контекста. }
begin
 Result := aContext;
 if not l3IsNil(Result) then
 begin
  Result := l3Trim(aContext);
  l3Replace(Result, cc_PairDoubleQuotes, cc_DoubleQuote);
  l3Replace(Result, cc_PairSingleQuotes, cc_SingleQuote);
  Result := l3DeleteSerias(Result, cPhraseSeparator);
 end;//not l3IsNil(Result)
end;

function ContextToPhrases(const aContext : Il3CString) : IvcmStrings;
  {* - делит строку контекста на фразы. }
var
 lTemp : Il3CString;
 lPos  : Integer;
begin
 Result := TvcmStringList.Make;
 lTemp := aContext;
 lPos := l3Pos(lTemp, cPhraseSeparator);
 while (lPos >= 0) do
 begin
  // фраза
  Result.Add(l3Copy(lTemp, 0, lPos));
  // удалим фразу из строки
  lTemp := l3Copy(lTemp, lPos + 1, l3Len(lTemp) - lPos - 1);
  // новая фраза
  lPos := l3Pos(lTemp, cPhraseSeparator);
 end;//while lPos >= 0
 Result.Add(lTemp);
end;

end.
