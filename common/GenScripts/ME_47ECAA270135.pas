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
  {* ������� ����������� ����� ��� ����������� �����. }
  procedure AddAtom(AtomIndex: Integer;
   aValue: Tl3Variant); overload;
  procedure StartChild(TypeID: Tl3Type); overload;
  procedure StartTag(TagID: Integer); overload;
  procedure OpenStream;
   {* ���������� ���� ��� ��� ������ ���������. ��� ���������� � ��������. }
  procedure CloseStream(NeedUndo: Boolean);
   {* ���������� ���� ��� � ����� ���������. ��� ���������� � ��������. }
  procedure CloseStructure(NeedUndo: Boolean);
   {* ���������� �� ������������� "������". ��� ���������� � ��������. }
  procedure GeneratorChanged;
   {* ����������� � ����� ���������� ����������. ��� ���������� � ��������. }
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
   {* �������� ��������� ����. }
  procedure AddStringAtom(TagID: Integer;
   const Value: Tl3WString); overload;
   {* �������� ��������� ����. }
  procedure AddStreamAtom(TagID: Integer;
   aStream: TStream);
   {* �������� ���� �� ������. }
  procedure AddTransparentAtom(TagID: Integer);
   {* �������� "����������" ����. }
  procedure AddIntegerAtom(TagID: Integer;
   Value: Integer);
   {* �������� ������������� ����. }
  procedure AddBoolAtom(TagID: Integer;
   Value: Boolean);
  procedure AddAtom(AtomIndex: Integer;
   aValue: Tl3Variant); overload;
   {* �������� ����. }
  procedure AddAtomEx(AtomIndex: Integer;
   const Value: Ik2Variant); overload;
  procedure Start;
   {* ������ ���������. }
  procedure StartChild(TypeID: Tl3VariantDef); overload;
   {* ������ �������� ������ ����. }
  procedure StartDefaultChild;
   {* ������ �������� ������ ���� � ����� ��-���������. }
  procedure StartTag(TagID: Integer); overload;
   {* ������ �������� ���. }
  procedure Finish(NeedUndo: Boolean);
   {* ������� ������ ����� ���������. }
  function CharsInLine: Integer;
  function NextGenerator: Ik2TagGenerator;
   {* ��������� ��������� � �������. }
  function CurrentStartLevel: Integer;
  procedure Rollback(CheckBrackets: Boolean);
   {* �������� ��� �������� "������". }
  function Pixel2Char(Pixel: Integer): Integer;
  function CurrentVersion: Integer;
   {* ������� ������ ������� }
  procedure AddInt64Atom(aTagID: Integer;
   aValue: Int64);
   {* ��������� 64-������ ���� }
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
