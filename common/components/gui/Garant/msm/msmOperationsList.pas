unit msmOperationsList;

// Модуль: "w:\common\components\gui\Garant\msm\msmOperationsList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmOperationsList" MUID: (57CEB10702AD)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmOperations
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = ImsmOperation;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TmsmOperationsList = class(_l3InterfaceRefList_, ImsmOperationsList)
  protected
   function Get_Count: Integer;
   function Get_Items(anIndex: Integer): ImsmOperation;
 end;//TmsmOperationsList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57CEB10702ADimpl_uses*
 //#UC END# *57CEB10702ADimpl_uses*
;

type _Instance_R_ = TmsmOperationsList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

function TmsmOperationsList.Get_Count: Integer;
//#UC START# *57CEADDB0029_57CEB10702ADget_var*
//#UC END# *57CEADDB0029_57CEB10702ADget_var*
begin
//#UC START# *57CEADDB0029_57CEB10702ADget_impl*
 Result := Self.Count;
//#UC END# *57CEADDB0029_57CEB10702ADget_impl*
end;//TmsmOperationsList.Get_Count

function TmsmOperationsList.Get_Items(anIndex: Integer): ImsmOperation;
//#UC START# *57CEADF5039E_57CEB10702ADget_var*
//#UC END# *57CEADF5039E_57CEB10702ADget_var*
begin
//#UC START# *57CEADF5039E_57CEB10702ADget_impl*
 Result := Self.pm_GetItems(anIndex);
//#UC END# *57CEADF5039E_57CEB10702ADget_impl*
end;//TmsmOperationsList.Get_Items

end.
