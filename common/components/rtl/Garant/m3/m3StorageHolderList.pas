unit m3StorageHolderList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3StorageHolderList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::m3::StorageHolder::Tm3StorageHolderList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3StorageHolderListPrim1,
  SyncObjs
  ;

type
 _l3CriticalSectionHolder_Parent_ = Tm3StorageHolderListPrim1;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 Tm3StorageHolderList = class(_l3CriticalSectionHolder_)
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public methods
   class function Exists: Boolean;
   class procedure Drop(const aFileName: WideString);
   class procedure DropAll;
     {* Сигнатура метода DropAll }
 public
 // singleton factory method
   class function Instance: Tm3StorageHolderList;
    {- возвращает экземпляр синглетона. }
 end;//Tm3StorageHolderList

implementation

uses
  l3Base {a},
  l3Types,
  SysUtils
  ;


// start class Tm3StorageHolderList

var g_Tm3StorageHolderList : Tm3StorageHolderList = nil;

procedure Tm3StorageHolderListFree;
begin
 l3Free(g_Tm3StorageHolderList);
end;

class function Tm3StorageHolderList.Instance: Tm3StorageHolderList;
begin
 if (g_Tm3StorageHolderList = nil) then
 begin
  l3System.AddExitProc(Tm3StorageHolderListFree);
  g_Tm3StorageHolderList := Create;
 end;
 Result := g_Tm3StorageHolderList;
end;


{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

// start class Tm3StorageHolderList

class function Tm3StorageHolderList.Exists: Boolean;
//#UC START# *542E9D1B0264_542E7AD00050_var*
//#UC END# *542E9D1B0264_542E7AD00050_var*
begin
//#UC START# *542E9D1B0264_542E7AD00050_impl*
 Result := (g_Tm3StorageHolderList <> nil);
//#UC END# *542E9D1B0264_542E7AD00050_impl*
end;//Tm3StorageHolderList.Exists

class procedure Tm3StorageHolderList.Drop(const aFileName: WideString);
//#UC START# *542EA0C5023C_542E7AD00050_var*
var
 l_Index : Integer;
//#UC END# *542EA0C5023C_542E7AD00050_var*
begin
//#UC START# *542EA0C5023C_542E7AD00050_impl*
 if Exists then
 begin
  if Instance.FindData(aFileName, l_Index) then
   Instance.Delete(l_Index);
  //Instance.Clear;
 end;//Exists
//#UC END# *542EA0C5023C_542E7AD00050_impl*
end;//Tm3StorageHolderList.Drop

class procedure Tm3StorageHolderList.DropAll;
//#UC START# *555481D1035F_542E7AD00050_var*
//#UC END# *555481D1035F_542E7AD00050_var*
begin
//#UC START# *555481D1035F_542E7AD00050_impl*
 if Exists then
  Instance.Clear;
//#UC END# *555481D1035F_542E7AD00050_impl*
end;//Tm3StorageHolderList.DropAll

procedure Tm3StorageHolderList.InitFields;
//#UC START# *47A042E100E2_542E7AD00050_var*
//#UC END# *47A042E100E2_542E7AD00050_var*
begin
//#UC START# *47A042E100E2_542E7AD00050_impl*
 inherited;
 Sorted := true;
 Duplicates := l3_dupError;
//#UC END# *47A042E100E2_542E7AD00050_impl*
end;//Tm3StorageHolderList.InitFields

end.