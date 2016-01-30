unit l3ObjectsMemoryManager;

// ������: "w:\common\components\rtl\Garant\L3\l3ObjectsMemoryManager.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleMemoryManager
;

type
 Tl3ObjectsMemoryManager = class(Tl3SimpleMemoryManager)
  public
   constructor Create; reintroduce;
   procedure FreeMem(anObject: TObject);
   procedure GetMem(out thePlace: TObject;
    aClass: TClass);
 end;//Tl3ObjectsMemoryManager

implementation

uses
 l3ImplUses
 , l3MemUtils
 , SysUtils
;

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
