unit l3ObjectsMemoryManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3ObjectsMemoryManager.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::MemoryManagers::Tl3ObjectsMemoryManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleMemoryManager
  ;

type
 Tl3ObjectsMemoryManager = class(Tl3SimpleMemoryManager)
 public
 // public methods
   constructor Create; reintroduce;
   procedure FreeMem(anObject: TObject);
   procedure GetMem(out thePlace: TObject;
     aClass: TClass);
 end;//Tl3ObjectsMemoryManager

implementation

uses
  l3MemUtils,
  SysUtils
  ;

// start class Tl3ObjectsMemoryManager

constructor Tl3ObjectsMemoryManager.Create;
//#UC START# *545CDFD70320_545CDF7D0249_var*
//#UC END# *545CDFD70320_545CDF7D0249_var*
begin
//#UC START# *545CDFD70320_545CDF7D0249_impl*
 inherited Create({$IfDef Nemesis}
                  32
                  {$Else  Nemesis}
                  128
                  {$EndIf Nemesis}
                  * 1024 {* anInstanceSize});
//#UC END# *545CDFD70320_545CDF7D0249_impl*
end;//Tl3ObjectsMemoryManager.Create

procedure Tl3ObjectsMemoryManager.FreeMem(anObject: TObject);
//#UC START# *545CE0010153_545CDF7D0249_var*
var
 l_P : Pointer;
//#UC END# *545CE0010153_545CDF7D0249_var*
begin
//#UC START# *545CE0010153_545CDF7D0249_impl*
 if (Self = nil) then
  Exit;
 Assert(Tl3MemUtils.IsDown, '���������� ������� ����� ������� ������ � ����� ������ ����������');
 l_P := anObject;
 l_P := PAnsiChar(l_P) - SizeOf(Integer);
 Assert(PInteger(l_P)^ = 0, '������ ' + anObject.ClassName + ' ��� �������� ' + IntToStr(PInteger(l_P)^ + 1) + ' ���');
 Inc(PInteger(l_P)^); 
 inherited FreeMem(l_P);
//#UC END# *545CE0010153_545CDF7D0249_impl*
end;//Tl3ObjectsMemoryManager.FreeMem

procedure Tl3ObjectsMemoryManager.GetMem(out thePlace: TObject;
  aClass: TClass);
//#UC START# *545CE0BF0347_545CDF7D0249_var*
//#UC END# *545CE0BF0347_545CDF7D0249_var*
begin
//#UC START# *545CE0BF0347_545CDF7D0249_impl*
 Assert(Self <> nil, '�������� ������ �������� �� ����������');
 inherited GetMem(thePlace, aClass.InstanceSize + SizeOf(Integer));
 PInteger(thePlace)^ := 0;
 thePlace := TObject(PAnsiChar(thePlace) + SizeOf(Integer));
//#UC END# *545CE0BF0347_545CDF7D0249_impl*
end;//Tl3ObjectsMemoryManager.GetMem

end.