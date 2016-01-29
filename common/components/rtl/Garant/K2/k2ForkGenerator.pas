unit k2ForkGenerator;
{* Генератор, транслирующий теги в два генератора. }

{ Библиотека "K-2"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: k2ForkGenerator - }
{ Начат: 26.11.2004 16:02 }
{ $Id: k2ForkGenerator.pas,v 1.8 2014/03/28 06:14:26 dinishev Exp $ }

// $Log: k2ForkGenerator.pas,v $
// Revision 1.8  2014/03/28 06:14:26  dinishev
// Bug fix: не собиралось почити ничего.
//
// Revision 1.7  2013/10/18 15:38:59  lulin
// - потихоньку избавляемся от использования идентификаторов типов тегов.
//
// Revision 1.6  2010/06/18 14:49:26  lulin
// {RequestLink:182452717}.
// - теперь про версию формата знает любой генератор из цепочки.
//
// Revision 1.5  2007/08/09 12:38:17  lulin
// - убираем замороченную логику с присвоением таблицы тегов.
//
// Revision 1.4  2005/03/28 11:32:28  lulin
// - интерфейсы переехали в "правильный" модуль.
//
// Revision 1.3  2005/03/03 14:12:27  narry
// - bug fix: не компилировалось
//
// Revision 1.2  2005/03/03 12:42:01  lulin
// - new method version: Tk2ForkGenerator.SetTo.
//
// Revision 1.1  2004/11/26 13:30:27  lulin
// - new unit: k2ForkGenerator.
//

{$I k2Define.inc }

interface

uses
  l3Types,
  l3Base,
  l3Variant,

  k2Types,
  k2Interfaces,
  k2TagGen,
  k2TagTranslator
  ;

type
  Tk2ForkGenerator = class(Tk2TagTranslator)
    protected
    // internal methods
      f_Generator2: Tk2TagGenerator;
    protected
    // property methods
      procedure pm_SetGenerator2(Value: Tk2TagGenerator);
        {-}
      procedure pm_SetCharsInLine(Value: Long);
        override;
        {-}
   procedure Set_CurrentVersion(aValue: Integer);
        override;
        {-}
    protected
    // internal methods
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Boolean);
        override;
        {-}
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
        override;
        {-}
      procedure CloseStructure(NeedUndo: Boolean);
        override;
        {-вызывается на закрывающуюся скобку}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      class function SetTo(var theGenerator: Tk2TagGenerator;
                           var theGenerator2: Tk2TagGenerator): Pointer;
        overload;
        {* - создает экземпляр класа и цепляет его к генератору. }
    public
    // public properties
      property Generator;
        {-}
      property Generator2: Tk2TagGenerator
        read f_Generator2
        write pm_SetGenerator2;
        {* - следующий генератор в цепочке. }
  end;//Tk2ForkGenerator

implementation

uses
  SysUtils,

  k2InternalInterfaces
  ;

// start class Tk2ForkGenerator

class function Tk2ForkGenerator.SetTo(var theGenerator: Tk2TagGenerator;
                                      var theGenerator2: Tk2TagGenerator): Pointer;
  //overload;
  {* - создает экземпляр класа и цепляет его к генератору. }
begin
 Result := inherited SetTo(theGenerator);
 (TObject(Result) As Tk2ForkGenerator).Generator2 := theGenerator2;
 l3Free(theGenerator2);
end;

procedure Tk2ForkGenerator.Cleanup;
  //override;
  {-}
begin
 Generator2 := nil;
 inherited;
end;

procedure Tk2ForkGenerator.OpenStream;
  //override;
  {-}
begin
 inherited;
 if (Generator2 <> nil) then
  Generator2.Start;
end;

procedure Tk2ForkGenerator.CloseStream(NeedUndo: Boolean);
  //override;
  {-}
begin
 if (Generator2 <> nil) then
  Generator2.Finish(NeedUndo);
 inherited;
end;

procedure Tk2ForkGenerator.StartTag(TagID: Long);
  //override;
  {-}
begin
 inherited;
 if (Generator2 <> nil) then
  Generator2.StartTag(TagID);
end;

procedure Tk2ForkGenerator.StartChild(TypeID: Tl3VariantDef);
  //override;
  {-}
begin
 inherited;
 if (Generator2 <> nil) then
  Generator2.StartChild(TypeID);
end;

procedure Tk2ForkGenerator.AddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
  //override;
  {-}
begin
 inherited;
 if (Generator2 <> nil) then
  Generator2.AddAtomEx(AtomIndex, Value);
end;

procedure Tk2ForkGenerator.CloseStructure(NeedUndo: Boolean);
  //override;
  {-вызывается на закрывающуюся скобку}
begin
 if (Generator2 <> nil) then
  Generator2.Finish(NeedUndo);
 inherited;
end;

procedure Tk2ForkGenerator.pm_SetGenerator2(Value: Tk2TagGenerator);
  {-}
begin
 if l3Set(f_Generator2, Value) then
  if (Generator2 <> nil) then
  begin
   Generator2.CharsInLine := CharsInLine;
   Ik2TagGenerator(Generator2).CurrentVersion := CurrentVersion;
  end;//Generator2 <> nil
end;

procedure Tk2ForkGenerator.pm_SetCharsInLine(Value: Long);
  //override;
  {-}
begin
 inherited;
 if (Generator2 <> nil) then
  Generator2.CharsInLine := Value;
end;

procedure Tk2ForkGenerator.Set_CurrentVersion(aValue: Integer);
begin
 inherited;
 if (Generator2 <> nil) then
  Ik2TagGenerator(Generator2).CurrentVersion := aValue;
end;

end.

