unit m3StorageElementIDList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3$DB"
// Модуль: "w:/common/components/rtl/Garant/m3/m3StorageElementIDList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3$DB::m3DBContainers::Tm3StorageElementIDList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  m3StorageInterfaces,
  l3LongintList,
  l3PureMixIns
  ;

type
 _ListType_ = Im3StorageElementIDList;
 _l3InterfacedList_Parent_ = Tl3LongintList;
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}
 Tm3StorageElementIDList = class(_l3InterfacedList_)
 protected
 // overridden protected methods
   procedure InitFields; override;
 end;//Tm3StorageElementIDList

implementation

type _Instance_R_ = Tm3StorageElementIDList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}

// start class Tm3StorageElementIDList

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