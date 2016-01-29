unit k2Reader;
{* Базовые классы для "читателей" тегов. }

{ Библиотека "K-2"    }
{ Автор: Люлин А.В. © }
{ Модуль: k2Reader - }
{ Начат: 22.09.1999 11:47 }
{ $Id: k2Reader.pas,v 1.53 2015/10/19 14:36:07 lulin Exp $ }

// $Log: k2Reader.pas,v $
// Revision 1.53  2015/10/19 14:36:07  lulin
// - bug fix: не собиралось.
//
// Revision 1.52  2015/10/15 11:32:35  lulin
// - при чтении из NSRC преобразуем формулы обратно в юникод.
//
// Revision 1.51  2015/06/04 10:43:45  lulin
// - пытаемся разрулить зависимости.
//
// Revision 1.50  2015/05/21 11:46:04  lulin
// - развязываем зависимости.
//
// Revision 1.49  2015/05/21 11:19:13  lulin
// - развязываем зависимости.
//
// Revision 1.48  2014/03/27 14:20:07  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.47  2014/03/20 12:24:03  lulin
// - перетряхиваем работу с тегами.
//
// Revision 1.46  2014/02/28 14:54:26  lulin
// - перетряхиваем генераторы.
//
// Revision 1.45  2013/10/18 14:11:33  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.44  2013/04/04 11:21:38  lulin
// - портируем.
//
// Revision 1.43  2011/09/28 14:27:39  lulin
// {RequestLink:288010443}.
//
// Revision 1.42  2011/09/19 10:12:45  lulin
// - делаем Filer'ам возможность быть не компонентами и кешируемыми.
//
// Revision 1.41  2011/07/21 16:31:49  lulin
// {RequestLink:269058433}.
//
// Revision 1.40  2010/09/16 11:36:38  lulin
// {RequestLink:235048829}.
//
// Revision 1.39  2010/01/22 18:55:45  lulin
// - упорядочиваем код.
// - пишем тест на проверку того, что стиль при заливке из NSRC меняется.
//
// Revision 1.38  2008/04/01 15:33:51  lulin
// - в нулевом приближении нарисовал контейнер докмента на модели.
//
// Revision 1.37  2007/08/29 12:22:46  lulin
// - cleanup.
//
// Revision 1.36  2007/08/29 08:15:40  lulin
// - даем присваивать парсер.
//
// Revision 1.35  2007/08/28 19:39:20  lulin
// - не достаем парсер из свойства по нескольку раз.
//
// Revision 1.34  2006/11/25 16:53:48  lulin
// - удалена запись,чтение маски заполненных тегов.
//
// Revision 1.33  2006/04/18 08:39:09  lulin
// - bug fix: не пишем сообщения в лог о незакрытых скобках при попытке вставки комментариев, т.к. поднятие исключения - это штатная ситуация.
//
// Revision 1.32  2006/01/16 16:41:44  lulin
// - сделана возможность работать со строками без теговых оберток (почему-то на производительность не повлияло).
//
// Revision 1.31  2005/11/15 12:23:26  lulin
// - cleanup.
//
// Revision 1.30  2005/11/15 09:36:47  lulin
// - от реализации переходим к интерфейсам.
//
// Revision 1.29  2005/11/15 08:02:45  lulin
// - чтение/запись документа практически польностью перенесены с TextSource на контейнер документа.
//
// Revision 1.28  2005/03/30 10:14:55  lulin
// - переходим от классов к интерфейсам.
//
// Revision 1.27  2005/03/28 14:30:09  lulin
// - от класса генераторов переходим к интерфейсу.
//
// Revision 1.26  2005/02/15 15:23:00  lulin
// - new method version: Tk2CustomFileReader.SetTo.
//
// Revision 1.25  2005/02/15 15:19:46  lulin
// - new method version: Tk2CustomFileReader.SetTo.
//
// Revision 1.24  2004/09/21 12:04:25  lulin
// - Release заменил на Cleanup.
//
// Revision 1.23  2004/04/02 13:40:31  law
// - new behavior: не записываем в лог сообщении о прерывании загрузки документа.
//
// Revision 1.22  2004/04/02 11:43:17  law
// - new behavior: в _Tk2CustomReader не глотаем Exception El3AbortLoad.
//
// Revision 1.21  2003/06/16 12:17:30  law
// - new behavior: сделана возможность индексировать в пустоту.
//
// Revision 1.20  2002/09/18 07:08:03  law
// - new units: k2StackGenerator, _k2Ver.
// - new behavior: _Tk2CustomReader теперь наследуется от Tk2CustomStackGenerator и соответственно наследует его поведение.
//
// Revision 1.19  2002/09/18 06:03:33  law
// - cleanup: удален параметр IsDefault.
//
// Revision 1.18  2002/09/11 15:43:03  law
// - change: адаптация к Delphi 7.0.
//
// Revision 1.17  2002/01/29 16:18:49  law
// - bug fix: Range Check Error при записывании размера маски.
//
// Revision 1.16  2001/05/31 09:23:40  law
// - cleanup: убрана работа со старой логикой масок тегов.
//
// Revision 1.15  2001/05/30 13:36:34  law
// - new behavior: сделана обработка ошибок чтения.
//
// Revision 1.14  2001/05/30 12:16:44  law
// - new behavior: обработка ошибок добавления тегов и детей.
//
// Revision 1.13  2001/05/30 09:11:19  law
// - new behavior: пытаемся централизовать обработку ошибок чтения документов.
//
// Revision 1.12  2001/04/27 12:23:06  voba
// - bug fix: сделана обработка ошибок чтения файла.
//
// Revision 1.11  2001/04/18 13:25:23  law
// - comments: добавлены комментарии для xHelpGen.
//
// Revision 1.10  2001/03/27 13:59:43  law
// - bug fix: неправильно выливалась таблица шрифтов.
//
// Revision 1.9  2001/03/14 13:24:55  law
// - some cleaup and tuning.
//
// Revision 1.8  2000/12/19 15:52:40  law
// - убраны ненужные директивы компиляции.
//
// Revision 1.7  2000/12/15 15:18:58  law
// - вставлены директивы Log.
//

{$Include k2Define.inc }

interface

uses
  l3Types,
  l3Interfaces,
  l3Base,
  l3Filer,
  l3Parser,
  l3Variant,

  k2Types,
  k2Interfaces,
  k2InternalInterfaces,
  k2TagGen,
  k2StackGenerator
  ;

type
  Tk2CustomReader = class(Tk2CustomStackGenerator, Ik2TagReader)
   {* Базовый класс "читателей" тегов. }
    private
    // internal fields
      f_Level     : Long;
      f_SkipLevel : Long;
    protected
    // internal methods
      procedure Read;
        virtual;
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-вызывается один раз в конце генерации}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-вызывается на закрывающуюся скобку}
    public
    // public methods
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure AddAtom(AtomIndex: Long; aValue: Tl3Variant);
        override;
        {-}
      procedure Execute;
        virtual;
        {* - запустить процесс чтения. }
      function As_Il3Reader: Il3Reader;  
    public
    // public properties
      property Generator;
        {* - генератор в который "читатель" читает теги. }
      property Level: Long
        read f_Level;
        {* - текущий уровень вложенности читаемого тега. }
      property SkipLevel: Long
        read f_SkipLevel;
        {* - текущий уровень пропускаемого тега. }
  end;//Tk2CustomReader

  Tk2CustomFileReader = class(Tk2CustomReader, Ik2FilerSource2)
   {* Базовый класс "читателей" тегов из "файла". }
    private
    // internal fields
      f_Filer : Tl3CustomFiler;
    protected
    // property methods
      function  pm_GetFiler: Tl3CustomFiler;
      procedure pm_SetFiler(Value: Tl3CustomFiler);
        {-}
    private
    // stored specifiers
      function  FilerStored: Bool;
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-вызывается один раз в конце генерации}
      procedure FilerChanged;
        virtual;
        {-}
      function  NeedConvertFolmulasToUnicode: Boolean; virtual;  
      function  pm_GetNextGenerator: Ik2TagGenerator; override;
      procedure pm_SetNextGenerator(const Value: Ik2TagGenerator); override;
        {-}
    public
    // public methods
      constructor Make(const aFileName  : AnsiString);
        {-}
      class function SetTo(var theGenerator : Tk2TagGenerator;
                           const aFileName  : AnsiString): Tk2CustomFileReader;
        overload;
        {* - создает экземпляр класа и цепляет его к генератору. }
      class function SetTo(var theGenerator : Tk2TagGenerator;
                           const aStream    : IStream): Tk2CustomFileReader;
        overload;
        {* - создает экземпляр класа и цепляет его к генератору. }
      class function SetTo(var theGenerator : Ik2TagGenerator;
                           const aStream    : IStream): Ik2TagReader;
        overload;
        {* - создает экземпляр класа и цепляет его к генератору. }
      class function SetFromStringTo(var theGenerator : Ik2TagGenerator;
                                     const aStr : Tl3WString): Ik2TagReader;
    public
    // public properties
      property Filer: Tl3CustomFiler
        read pm_GetFiler
        write pm_SetFiler
        stored FilerStored;
        {* - "файл" из которого читается тег. }
  end;//Tk2CustomFileReader

  Tk2CustomFileParser = class(Tk2CustomFileReader)
   {* Базовый класс "читателей" тегов, обладающий парсером. }
    private
    // property fields
      f_Parser : Tl3CustomParser;
    protected
    // property methods
      function  pm_GetParser: Tl3CustomParser;
      procedure pm_SetParser(const aValue: Tl3CustomParser);
        {-}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      procedure FilerChanged;
        override;
        {-}
    public
    // public methods
      procedure Error(const Message: AnsiString; NeedException : Bool = true);
        override;
        {-}
    public
    // public properties
      property Parser: Tl3CustomParser
        read pm_GetParser
        write pm_SetParser;
        {* - парсер для разбора выражений. }
  end;//Tk2CustomFileParser

implementation

uses
  SysUtils,
  
  l3Except,
  l3Memory,

  k2Except
  {$IfNDef NoEVD}
  ,
  evUnicodeFormulasToUnicodeConverter
  {$EndIf  NoEVD}
  ;

// start class Tk2CustomReader 

procedure Tk2CustomReader.Read;
  {virtual;}
  {-}
begin
end;

procedure Tk2CustomReader.OpenStream;
  {override;}
  {-}
begin
 inherited;
 Inc(f_Level);
 if (Generator <> nil) then
  Generator.Start;
end;

procedure Tk2CustomReader.CloseStream(NeedUndo: Bool);
  {override;}
  {-вызывается один раз в конце генерации}
begin
 if (Generator <> nil) then
  Generator.Finish(NeedUndo);
 Dec(f_Level);
 inherited;
end;

procedure Tk2CustomReader.Execute;
  {-}
var
 l_StartLevel : Long;
begin
 try
  try
   Start;
   l_StartLevel := CurrentStartLevel;
   try
    Read;
   except
    on E: Exception do
    begin
     if not (E Is El3AbortLoad) AND
        not (E Is Ek2ReadOnly) AND
        not (E Is Ek2LimitReached) then
     begin
      {$IfDef nsTest}
      if not (E Is El3BadPictureFormat) then
      {$EndIf nsTest}
       Error(Format('%s %d', [E.Message, E.HelpContext]), false);
     end;//not (E Is El3AbortLoad)..
     while (CurrentStartLevel > l_StartLevel) do
      Finish(true);
     raise; 
    end;//on E: Exception
   end;//try..except
  finally
   Finish;
  end;//try..finally
 except
  on Ek2ReadOnly do
  begin
   Rollback;
   raise;
  end;//on EevReadOnly
  on El3AbortLoad do
  begin
   Rollback;
   raise;
  end;//on El3AbortLoad
 end;//try..except
end;

function Tk2CustomReader.As_Il3Reader: Il3Reader;
begin
 Result := Ik2TagReader(Self);
end;

procedure Tk2CustomReader.CloseStructure(NeedUndo: Bool);
  //override;
  {-вызывается на закрывающуюся скобку}
begin
 if (f_SkipLevel = 0) then begin
  if (Generator <> nil) then
   Generator.Finish(NeedUndo);
  Dec(f_Level);
  inherited;
 end else
  Dec(f_SkipLevel);
end;

procedure Tk2CustomReader.StartTag(TagID: Long);
  {-}
begin
 if (f_SkipLevel = 0) then begin
  inherited;
  Inc(f_Level);
  try
   if (Generator <> nil) then
    Generator.StartTag(TagID);
  except
   on E: Exception do begin
    Error(E.Message, false);
    Inc(f_SkipLevel);
   end;
  end{try..except}
 end else
  Inc(f_SkipLevel);
end;

procedure Tk2CustomReader.StartChild(TypeID: Tl3VariantDef);
  {-}
begin
 if (f_SkipLevel = 0) then begin
  inherited;
  Inc(f_Level);
  try
   if (Generator <> nil) then
    Generator.StartChild(TypeID);
  except
   on El3AbortLoad do
    raise;
   on E: Exception do begin
    Error(E.Message, false);
    Inc(f_SkipLevel);
   end;
  end{try..except}
 end else
  Inc(f_SkipLevel); 
end;

procedure Tk2CustomReader.AddAtom(AtomIndex: Long; aValue: Tl3Variant);
  {-}
begin
 if (SkipLevel = 0) AND (Generator <> nil) then
  Generator.AddAtom(AtomIndex, aValue);
end;

// start class Tk2CustomFileReader

constructor Tk2CustomFileReader.Make(const aFileName  : AnsiString);
  {-}
var
 l_Filer : Tl3CustomFiler;
begin
 Create;
 l_Filer := Tl3CustomDOSFiler.Make(aFileName, l3_fmRead, false);
 try
  Self.Filer := l_Filer;
 finally
  l3Free(l_Filer);
 end;//try..finally
end;

class function Tk2CustomFileReader.SetTo(var theGenerator : Tk2TagGenerator;
                                         const aFileName  : AnsiString): Tk2CustomFileReader;
  //overload;
  {* - создает экземпляр класа и цепляет его к генератору. }
var
 l_Filer : Tl3CustomFiler;
begin
 SetTo(theGenerator);
 Result := theGenerator As Tk2CustomFileReader;
 l_Filer := Tl3CustomDOSFiler.Make(aFileName, l3_fmRead, false);
 try
  Result.Filer := l_Filer;
 finally
  l3Free(l_Filer);
 end;//try..finally
end;

class function Tk2CustomFileReader.SetTo(var theGenerator : Tk2TagGenerator;
                                         const aStream    : IStream): Tk2CustomFileReader;
  //overload;
  {* - создает экземпляр класа и цепляет его к генератору. }
begin
 SetTo(theGenerator);
 Result := theGenerator As Tk2CustomFileReader;
 with Result.Filer do
 begin
  Mode := l3_fmRead;
  COMStream := aStream;
 end;//with Result.Filer
end;

class function Tk2CustomFileReader.SetTo(var theGenerator : Ik2TagGenerator;
                                         const aStream    : IStream): Ik2TagReader;
  //overload;
  {* - создает экземпляр класа и цепляет его к генератору. }
var
 l_Filter : Tk2CustomFileReader;
begin
 l_Filter := Create;
 try
  l_Filter.Generator := theGenerator;
  l_Filter.Filer.Mode := l3_fmRead;
  l_Filter.Filer.COMStream := aStream;
  theGenerator := l_Filter;
  Result := l_Filter;
 finally
  l3Free(l_Filter);
 end;//try..finally
end;

class function Tk2CustomFileReader.SetFromStringTo(var theGenerator : Ik2TagGenerator;
                                                   const aStr : Tl3WString): Ik2TagReader;
var
 l_S : Tl3ConstMemoryStream;                                                   
begin
 l_S := Tl3ConstMemoryStream.Create(aStr.S, aStr.SLen);
 try
  Result := SetTo(theGenerator, l_S);
 finally
  FreeAndNil(l_S);
 end;//try..finally
end;

procedure Tk2CustomFileReader.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Filer);
 inherited;
end;

function Tk2CustomFileReader.pm_GetFiler: Tl3CustomFiler;
  {-}
var
 l_Filer : Tl3CustomFiler;
begin
 if (f_Filer = nil) then
 begin
  l_Filer := Tl3CustomFiler.Create;
  try
   Filer := l_Filer;
  finally
   l3Free(l_Filer);
  end;//try..finally
 end;
 Result := f_Filer;
end;

procedure Tk2CustomFileReader.pm_SetFiler(Value: Tl3CustomFiler);
  {-}
begin
 if l3Set(f_Filer, Value) then FilerChanged;
end;

function Tk2CustomFileReader.FilerStored: Bool;
  {-}
begin
 {$IfDef l3FilerIsComponent}
 Result := (f_Filer <> nil) AND (f_Filer.Owner <> nil);
 {$Else  l3FilerIsComponent}
 Result := false;
 {$EndIf l3FilerIsComponent}
end;

procedure Tk2CustomFileReader.OpenStream;
  {override;}
  {-}
begin
 inherited;
 Filer.Mode := l3_fmRead;
 Filer.Open;
end;

procedure Tk2CustomFileReader.CloseStream(NeedUndo: Bool);
  {override;}
  {-вызывается один раз в конце генерации}
begin
 Filer.Close;
 inherited;
end;

procedure Tk2CustomFileReader.FilerChanged;
  {virtual;}
  {-}
begin
end;

function Tk2CustomFileReader.NeedConvertFolmulasToUnicode: Boolean;
begin
 Result := false;
end;

function  Tk2CustomFileReader.pm_GetNextGenerator: Ik2TagGenerator;
  {-}
begin
 Result := inherited pm_GetNextGenerator;
end;

procedure Tk2CustomFileReader.pm_SetNextGenerator(const Value: Ik2TagGenerator);
  {-}
var
 l_Gen : Ik2TagGenerator;
begin
 l_Gen := Value;
 if (l_Gen <> nil) then
 begin
  {$IfNDef NoEVD}
  if NeedConvertFolmulasToUnicode then
   TevUnicodeFormulasToUnicodeConverter.SetTo(l_Gen);
  {$EndIf NoEVD} 
 end;//l_Gen <> nil
 inherited pm_SetNextGenerator(l_Gen);
end;

// start class Tk2CustomFileParser

function  Tk2CustomFileParser.pm_GetParser: Tl3CustomParser;
  {-}
begin
 if (f_Parser = nil) then
 begin
  f_Parser := Tl3CustomParser.Create;
  f_Parser.Filer := Filer;
 end;//f_Parser = nil
 Result := f_Parser;
end;

procedure Tk2CustomFileParser.pm_SetParser(const aValue: Tl3CustomParser);
  {-}
begin
 l3Set(f_Parser, aValue);
end;

procedure Tk2CustomFileParser.Cleanup;
  {override;}
  {-}
begin
 l3Free(f_Parser);
 inherited;
end;

procedure Tk2CustomFileParser.FilerChanged;
  {override;}
  {-}
begin
 if (f_Parser <> nil) then f_Parser.Filer := Filer;
end;

procedure Tk2CustomFileParser.Error(const Message: AnsiString; NeedException : Bool = true);
  //override;
  {-}
begin
 Parser.Error(Message, NeedException);
end;

end.

