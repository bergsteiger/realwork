unit m3TOCHandleList;

// Модуль: "w:\common\components\rtl\Garant\m3\m3TOCHandleList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tm3TOCHandleList" MUID: (54219FC800B5)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , m3TOCHandle
 , l3Interfaces
 , ActiveX
 , l3ProtoDataContainer
 , Classes
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
;

type
 _ItemType_ = Tm3TOCHandle;
 _KeyType_ = Tl3WString;
 {$Include w:\common\components\rtl\Garant\m3\m3PersistentList.imp.pas}
 Tm3TOCHandleList = class(_m3PersistentList_)
  private
   f_Modified: Boolean;
    {* Поле для свойства Modified }
  protected
   function pm_GetModified: Boolean;
   procedure pm_SetModified(aValue: Boolean);
   function CompareKeyByItem(const aKey: _KeyType_;
    const anItem: _ItemType_): Integer; override;
   procedure InitFields; override;
  public
   property Modified: Boolean
    read pm_GetModified
    write pm_SetModified;
 end;//Tm3TOCHandleList

implementation

uses
 l3ImplUses
 , l3String
 , m3Persistent
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , m2COMLib
 , m3BuffStream
 , m2S32Lib
;

type _Instance_R_ = Tm3TOCHandleList;

{$Include w:\common\components\rtl\Garant\m3\m3PersistentList.imp.pas}

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
