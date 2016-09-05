unit m3StorageHolderList;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StorageHolderList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3StorageHolderList" MUID: (542E7AD00050)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3StorageHolderListPrim1
 , SyncObjs
;

type
 _l3CriticalSectionHolder_Parent_ = Tm3StorageHolderListPrim1;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 Tm3StorageHolderList = class(_l3CriticalSectionHolder_)
  protected
   procedure InitFields; override;
  public
   class function Exists: Boolean;
   class procedure Drop(const aFileName: WideString);
   class procedure DropAll;
   class function Instance: Tm3StorageHolderList;
    {* Метод получения экземпляра синглетона Tm3StorageHolderList }
 end;//Tm3StorageHolderList

implementation

uses
 l3ImplUses
 , l3Types
 , SysUtils
 , m3StorageHolder
 , l3Memory
 , l3Base
 //#UC START# *542E7AD00050impl_uses*
 //#UC END# *542E7AD00050impl_uses*
;

var g_Tm3StorageHolderList: Tm3StorageHolderList = nil;
 {* Экземпляр синглетона Tm3StorageHolderList }

procedure Tm3StorageHolderListFree;
 {* Метод освобождения экземпляра синглетона Tm3StorageHolderList }
begin
 l3Free(g_Tm3StorageHolderList);
end;//Tm3StorageHolderListFree

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

class function Tm3StorageHolderList.Exists: Boolean;
begin
 Result := g_Tm3StorageHolderList <> nil;
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

class function Tm3StorageHolderList.Instance: Tm3StorageHolderList;
 {* Метод получения экземпляра синглетона Tm3StorageHolderList }
begin
 if (g_Tm3StorageHolderList = nil) then
 begin
  l3System.AddExitProc(Tm3StorageHolderListFree);
  g_Tm3StorageHolderList := Create;
 end;
 Result := g_Tm3StorageHolderList;
end;//Tm3StorageHolderList.Instance

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
