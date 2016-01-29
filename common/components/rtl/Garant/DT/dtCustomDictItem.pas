unit dtCustomDictItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DT"
// Модуль: "w:/common/components/rtl/Garant/DT/dtCustomDictItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::DT::Dictionary::TdtCustomDictItem
//
// Базовый элемент словаря.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DT\DtDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3NCString,
  dt_Types
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TdtCustomDictItem = class(Tl3NCString)
  {* Базовый элемент словаря. }
 protected
 // property methods
   function Get_Handle: TDictID; virtual;
   procedure Set_Handle(aValue: TDictID); virtual;
 protected
 // overridden property methods
   function pm_GetStringID: Integer; override;
   procedure pm_SetStringID(aValue: Integer); override;
 public
 // public properties
   property Handle: TDictID
     read Get_Handle
     write Set_Handle;
 end;//TdtCustomDictItem
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}

// start class TdtCustomDictItem

function TdtCustomDictItem.Get_Handle: TDictID;
//#UC START# *47BC528601A2_47BC507501ABget_var*
//#UC END# *47BC528601A2_47BC507501ABget_var*
begin
//#UC START# *47BC528601A2_47BC507501ABget_impl*
 Result := 0;
//#UC END# *47BC528601A2_47BC507501ABget_impl*
end;//TdtCustomDictItem.Get_Handle

procedure TdtCustomDictItem.Set_Handle(aValue: TDictID);
//#UC START# *47BC528601A2_47BC507501ABset_var*
//#UC END# *47BC528601A2_47BC507501ABset_var*
begin
//#UC START# *47BC528601A2_47BC507501ABset_impl*
//#UC END# *47BC528601A2_47BC507501ABset_impl*
end;//TdtCustomDictItem.Set_Handle

function TdtCustomDictItem.pm_GetStringID: Integer;
//#UC START# *47BC3BFD017F_47BC507501ABget_var*
//#UC END# *47BC3BFD017F_47BC507501ABget_var*
begin
//#UC START# *47BC3BFD017F_47BC507501ABget_impl*
 Result := Get_Handle;
//#UC END# *47BC3BFD017F_47BC507501ABget_impl*
end;//TdtCustomDictItem.pm_GetStringID

procedure TdtCustomDictItem.pm_SetStringID(aValue: Integer);
//#UC START# *47BC3BFD017F_47BC507501ABset_var*
//#UC END# *47BC3BFD017F_47BC507501ABset_var*
begin
//#UC START# *47BC3BFD017F_47BC507501ABset_impl*
 Set_Handle(aValue);
//#UC END# *47BC3BFD017F_47BC507501ABset_impl*
end;//TdtCustomDictItem.pm_SetStringID

{$IfEnd} //not Nemesis

end.