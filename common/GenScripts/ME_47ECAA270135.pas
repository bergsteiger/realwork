unit k2TagGen;

interface

uses
 l3IntfUses
 , l3_Base
 , l3Variant
 , l3Interfaces
 , Classes
;

type
 Ik2TagGeneratorWrap = interface
 end;//Ik2TagGeneratorWrap
 
 Tk2TagGeneratorOwner = class
 end;//Tk2TagGeneratorOwner
 
 Ik2TagGeneratorChainEnd = interface
 end;//Ik2TagGeneratorChainEnd
 
 Tk2TagGenerator = class(Tl3_Base, Ik2TagGenerator, Ik2TagGeneratorWrap, Ik2TagGeneratorChainEnd)
  {* Базовый абстрактный класс для генераторов тегов. }
  procedure AddAtom(AtomIndex: Integer;
   aValue: Tl3Variant); overload;
  procedure StartChild(TypeID: Tl3Type); overload;
  procedure StartTag(TagID: Integer); overload;
  procedure OpenStream;
   {* вызывается один раз при начале генерации. Для перекрытия в потомках. }
  procedure CloseStream(NeedUndo: Boolean);
   {* вызывается один раз в конце генерации. Для перекрытия в потомках. }
  procedure CloseStructure(NeedUndo: Boolean);
   {* вызывается на закрывающуюся "скобку". Для перекрытия в потомках. }
  procedure GeneratorChanged;
   {* нотификация о смене следующего генератора. Для перекрытия в потомках. }
  function GetObjectID(const Name: AnsiString;
   Child: Boolean): Integer;
  procedure AddAtomEx(AtomIndex: Integer;
   const Value: Ik2Variant); overload;
  procedure AfterStreamOpened;
  procedure Error(Message: PAnsiChar;
   NeedException: Boolean);
  procedure Create(anOwner: Tk2TagGeneratorOwner);
  procedure AddStringAtom(TagID: Integer;
   const Value: AnsiString;
   aCodePage: Integer); overload;
   {* добавить строковый атом. }
  procedure AddStringAtom(TagID: Integer;
   const Value: Tl3WString); overload;
   {* добавить строковый атом. }
  procedure AddStreamAtom(TagID: Integer;
   aStream: TStream);
   {* добавить атом из потока. }
  procedure AddTransparentAtom(TagID: Integer);
   {* добавить "прозрачный" атом. }
  procedure AddIntegerAtom(TagID: Integer;
   Value: Integer);
   {* добавить целочисленный атом. }
  procedure AddBoolAtom(TagID: Integer;
   Value: Boolean);
  procedure AddAtom(AtomIndex: Integer;
   aValue: Tl3Variant); overload;
   {* добавить атом. }
  procedure AddAtomEx(AtomIndex: Integer;
   const Value: Ik2Variant); overload;
  procedure Start;
   {* начать генерацию. }
  procedure StartChild(TypeID: Tl3VariantDef); overload;
   {* начать дочерний объект тега. }
  procedure StartDefaultChild;
   {* начать дочерний объект тега с типом по-умолчанию. }
  procedure StartTag(TagID: Integer); overload;
   {* начать вложеный тег. }
  procedure Finish(NeedUndo: Boolean);
   {* закрыть скобку этапа генерации. }
  function CharsInLine: Integer;
  function NextGenerator: Ik2TagGenerator;
   {* следующий генератор в цепочке. }
  function CurrentStartLevel: Integer;
  procedure Rollback(CheckBrackets: Boolean);
   {* откатить все открытые "скобки". }
  function Pixel2Char(Pixel: Integer): Integer;
  function CurrentVersion: Integer;
   {* Текущая версия формата }
  procedure AddInt64Atom(aTagID: Integer;
   aValue: Int64);
   {* Добавляет 64-битный атом }
  function Char2Pixel(aCh: Integer): Integer;
  function Context: Il3OpPack;
 end;//Tk2TagGenerator
 
implementation

uses
 l3ImplUses
 , k2VariantImpl
 , kwFiltersAndGeneratorsPack
;

end.
