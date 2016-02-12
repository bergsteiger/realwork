unit m3StorageElementIDList;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StorageElementIDList.pas"
// Стереотип: "SimpleClass"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
 , l3LongintList
 , m3StorageInterfaces
 , l3PureMixIns
;

type
 _ListType_ = Im3StorageElementIDList;
 _l3InterfacedList_Parent_ = Tl3LongintList;
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}
 Tm3StorageElementIDList = class(_l3InterfacedList_)
  protected
   procedure InitFields; override;
 end;//Tm3StorageElementIDList

implementation

uses
 l3ImplUses
;

type _Instance_R_ = Tm3StorageElementIDList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}

procedure Tm3StorageElementIDList.InitFields;
//#UC START# *47A042E100E2_48294B450060_var*
//#UC END# *47A042E100E2_48294B450060_var*
begin
//#UC START# *47A042E100E2_48294B450060_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_48294B450060_impl*
end;//Tm3StorageElementIDList.InitFields

end.
