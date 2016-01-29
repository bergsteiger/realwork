unit k2FileGenerator;
{* Базовый писатель тегов в файл. }

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2FileGenerator - }
{ Начат: 21.02.2005 18:55 }
{ $Id: k2FileGenerator.pas,v 1.8 2013/04/05 16:44:40 lulin Exp $ }

// $Log: k2FileGenerator.pas,v $
// Revision 1.8  2013/04/05 16:44:40  lulin
// - портируем.
//
// Revision 1.7  2013/04/04 11:21:38  lulin
// - портируем.
//
// Revision 1.6  2011/09/19 10:12:45  lulin
// - делаем Filer'ам возможность быть не компонентами и кешируемыми.
//
// Revision 1.5  2011/09/15 12:48:20  voba
// - k : 281525254
//
// Revision 1.4  2009/03/18 14:59:54  lulin
// - делаем возможность отката, если во время записи произошло исключение.
//
// Revision 1.3  2008/02/05 12:49:23  lulin
// - упрощаем базовые объекты.
//
// Revision 1.2  2005/07/21 10:20:08  lulin
// - теперь TextSource не знает как создавать Reader'ы, а про это знает контейнер документа.
//
// Revision 1.1  2005/02/21 16:04:14  lulin
// - new unit: k2FileGenerator.
//

{$Include k2Define.inc }

interface

uses
  l3Types,
  l3Base,
  l3Filer,
  l3KeyWrd,
  
  k2InternalInterfaces,
  k2TagGen,
  k2StackGenerator
  ;

type
  Tk2CustomFileGenerator = class(Tk2CustomStackGeneratorEx, Ik2FilerSource)
   {* Базовый писатель тегов в файл. }
    protected
    // property fields
      f_Filer    : Tl3CustomFiler;
    private
    // property fields
      f_KeyWords : Tl3KeyWords;
    protected
    {property methods}
      function  pm_GetFiler: Tl3CustomFiler;
      procedure pm_SetFiler(Value: Tl3CustomFiler);
        virtual;
        {-}
      procedure pm_SetKeyWords(Value: Tl3KeyWords);
        {-}
    private
    {stored specifiers}
      function FilerStored: Bool;
        {-}
    protected
    {internal methods}
      procedure FilerChanged(aFiler: Tl3CustomFiler);
        virtual;
        {-}
      procedure OutShortString(const S: ShortString);
        {-}
      procedure OutString(S: Tl3PrimString);
        overload;
        {-}
      procedure OutString(const S: AnsiString);
        overload;
        {-}
      procedure OutStringLn(S: Tl3CustomString);
        overload;
        {-}
      procedure OutStringLn(const S: AnsiString);
        overload;
        {-}
      function  WriteBuf(B: PAnsiChar; Len: Long): Long;
        virtual;
        {-}
      function  WriteLong(L: Long): Long;
        {-}
      function  WriteWord(W: Word): Long;
        {-}
      function  WriteByte(B: Byte): Long;
        {-}
      procedure Cleanup;
        override;
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-вызывается один раз в конце генерации}
    public
    {public methods}
      class function SetTo(var theGenerator : Tk2TagGenerator;
                           const aFileName  : AnsiString): Pointer;
        overload;
        {* - создает экземпляр класа и цепляет его к генератору. }
      class function SetTo(var theGenerator : Tk2TagGenerator;
                           const aStream    : IStream): Pointer;
        overload;
        {* - создает экземпляр класа и цепляет его к генератору. }
      procedure OutEOL;
        virtual;
        {-}
    public
    {public properties}
      property Filer: Tl3CustomFiler
        read pm_GetFiler
        write pm_SetFiler
        stored FilerStored;
        {* - файл куда пишутся теги. }
      property KeyWords: Tl3KeyWords
        read f_KeyWords
        write pm_SetKeyWords;
        {* - таблица ключевых слов. }
  end;//Tk2CustomFileGenerator
  {* Предназначен для записи тегов в файл.
     Для использования как предка для писателей в различные форматы. }

implementation

uses
  l3Interfaces,
  l3String
  ;

// start class Tk2CustomFileGenerator 

procedure Tk2CustomFileGenerator.OpenStream;
  {override;}
  {-}
begin
 inherited;
 Filer.Mode := l3_fmWrite;
 Filer.Open;
end;

procedure Tk2CustomFileGenerator.CloseStream(NeedUndo: Bool);
  {override;}
  {-вызывается один раз в конце генерации}
begin
 //Filer.Flush;
 if NeedUndo then
  if (f_Filer <> nil) then
   f_Filer.Rollback;
 Filer.Close;
 inherited;
end;

function Tk2CustomFileGenerator.pm_GetFiler: Tl3CustomFiler;
  {-}
begin
 if (f_Filer = nil) then f_Filer := Tl3CustomFiler.Create;
 Result := f_Filer;
end;

procedure Tk2CustomFileGenerator.pm_SetFiler(Value: Tl3CustomFiler);
  {-}
begin
 if l3Set(f_Filer, Value) then
  FilerChanged(f_Filer);
end;

procedure Tk2CustomFileGenerator.FilerChanged(aFiler: Tl3CustomFiler);
  //virtual;
  {-}
begin
end;
  
procedure Tk2CustomFileGenerator.pm_SetKeyWords(Value: Tl3KeyWords);
  {-}
begin
 l3Set(f_KeyWords, Value);
end;

function Tk2CustomFileGenerator.FilerStored: Bool;
  {-}
begin
 {$IfDef l3FilerIsComponent}
 Result := (f_Filer <> nil) AND (f_Filer.Owner <> nil);
 {$Else  l3FilerIsComponent}
 Result := false;
 {$EndIf l3FilerIsComponent}
end;

procedure Tk2CustomFileGenerator.OutString(S: Tl3PrimString);
  {overload;}
  {-}
var
 l_S : Tl3WString;
 l_CharSize : Integer;
begin
 l_S := S.AsWStr;
 if not l3IsNil(l_S) then
 begin
  if (l_S.SCodePage = CP_Unicode) then
   l_CharSize := SizeOf(WideChar)
  else
   l_CharSize := SizeOf(ANSIChar);
  WriteBuf(l_S.S, l_S.SLen * l_CharSize);
 end;//not S.Empty
end;

procedure Tk2CustomFileGenerator.OutString(const S: AnsiString);
  {overload;}
  {-}
begin
 if (S <> '') then WriteBuf(PAnsiChar(S), Length(S));
end;

procedure Tk2CustomFileGenerator.OutShortString(const S: ShortString);
  {overload;}
  {-}
begin
 if (Byte(S[0]) > 0) then WriteBuf(PAnsiChar(@S[1]), Byte(S[0]));
end;

procedure Tk2CustomFileGenerator.OutStringLn(S: Tl3CustomString);
  //overload;
  {-}
begin
 OutString(S);
 OutEOL;
end;

procedure Tk2CustomFileGenerator.OutStringLn(const S: AnsiString);
  //overload;
  {-}
begin
 OutString(S);
 OutEOL;
end;

procedure Tk2CustomFileGenerator.Cleanup;
  {override;}
  {-}
begin
 KeyWords := nil;
 Filer := nil;
 inherited;
end;

class function Tk2CustomFileGenerator.SetTo(var theGenerator : Tk2TagGenerator;
                                            const aFileName  : AnsiString): Pointer;
  //overload;
  {* - создает экземпляр класа и цепляет его к генератору. }
var
 l_Filer : Tl3CustomFiler;
begin
 Result := SetTo(theGenerator);
 l_Filer := Tl3CustomDOSFiler.Make(aFileName, l3_fmWrite, false);
 try
  (theGenerator As Tk2CustomFileGenerator).Filer := l_Filer;
 finally
  l3Free(l_Filer);
 end;//try..finally
end;

class function Tk2CustomFileGenerator.SetTo(var theGenerator : Tk2TagGenerator;
                                            const aStream    : IStream): Pointer;
  //overload;
  {* - создает экземпляр класа и цепляет его к генератору. }
begin
 Result := SetTo(theGenerator);
 (theGenerator As Tk2CustomFileGenerator).Filer.COMStream := aStream;
end;

procedure Tk2CustomFileGenerator.OutEOL;
  {-}
begin
 f_Filer.OutEOL;
end;

function Tk2CustomFileGenerator.WriteBuf(B: PAnsiChar; Len: Long): Long;
  {-}
begin
 Result := f_Filer.Write(B, Len);
end;

function Tk2CustomFileGenerator.WriteLong(L: Long): Long;
  {-}
begin
 Result := WriteBuf(@L, SizeOf(L));
end;

function Tk2CustomFileGenerator.WriteWord(W: Word): Long;
  {-}
begin
 Result := WriteBuf(@W, SizeOf(W));
end;

function Tk2CustomFileGenerator.WriteByte(B: Byte): Long;
  {-}
begin
 Result := WriteBuf(@B, SizeOf(B));
end;

end.

