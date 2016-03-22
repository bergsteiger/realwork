unit m3TOCHandleList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3TOCHandleList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::m3::m3CoreObjects::Tm3TOCHandleList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

uses
  l3Interfaces,
  m3TOCHandle,
  ActiveX,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Tm3TOCHandle;
 _KeyType_ = Tl3WString;
 {$Include ..\m3\m3PersistentList.imp.pas}
 Tm3TOCHandleList = class(_m3PersistentList_)
 private
 // private fields
   f_Modified : Boolean;
    {* Поле для свойства Modified}
 protected
 // property methods
   function pm_GetModified: Boolean;
   procedure pm_SetModified(aValue: Boolean);
 protected
 // realized methods
   function CompareKeyByItem(const aKey: _KeyType_;
     const anItem: _ItemType_): Integer; override;
 protected
 // overridden protected methods
   procedure InitFields; override;
 public
 // public properties
   property Modified: Boolean
     read pm_GetModified
     write pm_SetModified;
 end;//Tm3TOCHandleList

implementation

uses
  l3String,
  m2COMLib,
  l3Base,
  m3BuffStream,
  m2S32Lib,
  m3Persistent,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tm3TOCHandleList;

{$Include ..\m3\m3PersistentList.imp.pas}

// start class Tm3TOCHandleList

function Tm3TOCHandleList.pm_GetModified: Boolean;
//#UC START# *5422B20901DA_54219FC800B5get_var*
//#UC END# *5422B20901DA_54219FC800B5get_var*
begin
//#UC START# *5422B20901DA_54219FC800B5get_impl*
 if (Self = nil) then
  Result := false
 else
  Result := f_Modified; 
//#UC END# *5422B20901DA_54219FC800B5get_impl*
end;//Tm3TOCHandleList.pm_GetModified

procedure Tm3TOCHandleList.pm_SetModified(aValue: Boolean);
//#UC START# *5422B20901DA_54219FC800B5set_var*
//#UC END# *5422B20901DA_54219FC800B5set_var*
begin
//#UC START# *5422B20901DA_54219FC800B5set_impl*
 if (Self = nil) then
  Exit;
 f_Modified := aValue;
//#UC END# *5422B20901DA_54219FC800B5set_impl*
end;//Tm3TOCHandleList.pm_SetModified

function Tm3TOCHandleList.CompareKeyByItem(const aKey: _KeyType_;
  const anItem: _ItemType_): Integer;
//#UC START# *5421A06902CD_54219FC800B5_var*
//#UC END# *5421A06902CD_54219FC800B5_var*
begin
//#UC START# *5421A06902CD_54219FC800B5_impl*
 Result := l3Compare(aKey,
                     anItem.HandleName.AsPCharLen,
                     l3_siCaseUnsensitive);
//#UC END# *5421A06902CD_54219FC800B5_impl*
end;//Tm3TOCHandleList.CompareKeyByItem

procedure Tm3TOCHandleList.InitFields;
//#UC START# *47A042E100E2_54219FC800B5_var*
//#UC END# *47A042E100E2_54219FC800B5_var*
begin
//#UC START# *47A042E100E2_54219FC800B5_impl*
 inherited;
 f_Modified := false;
//#UC END# *47A042E100E2_54219FC800B5_impl*
end;//Tm3TOCHandleList.InitFields

end.