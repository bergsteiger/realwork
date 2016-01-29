unit evMultiSelectionLocation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evMultiSelectionLocation.pas"
// Начат: 08.10.2008 19:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Editors::TevMultiSelectionLocation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2TagTool,
  nevTools,
  l3Variant
  ;

type
 _nevParaTool_Parent_ = Tk2TagTool;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaTool.imp.pas}
 TevMultiSelectionLocation = class(_nevParaTool_, InevLocation)
 protected
 // realized methods
   function Range: InevRange;
   function pm_GetFormatting: InevDataFormatting;
   function Get_Obj: PInevObject;
   function pm_GetText: InevText;
   function AsPoint: InevBasePoint;
 protected
 // protected methods
   function GetRange: InevRange; virtual; abstract;
   function GetFormatting: InevDataFormatting; virtual; abstract;
   function GetText: InevText; virtual; abstract;
 end;//TevMultiSelectionLocation

implementation

uses
  SysUtils
  ;

{$Include w:\common\components\gui\Garant\Everest\new\nevParaTool.imp.pas}

// start class TevMultiSelectionLocation

function TevMultiSelectionLocation.Range: InevRange;
//#UC START# *47C5B55D00B4_48ECCE2903AD_var*
//#UC END# *47C5B55D00B4_48ECCE2903AD_var*
begin
//#UC START# *47C5B55D00B4_48ECCE2903AD_impl*
 Result := GetRange;
//#UC END# *47C5B55D00B4_48ECCE2903AD_impl*
end;//TevMultiSelectionLocation.Range

function TevMultiSelectionLocation.pm_GetFormatting: InevDataFormatting;
//#UC START# *47C5B603039F_48ECCE2903ADget_var*
//#UC END# *47C5B603039F_48ECCE2903ADget_var*
begin
//#UC START# *47C5B603039F_48ECCE2903ADget_impl*
 Result := GetFormatting;
//#UC END# *47C5B603039F_48ECCE2903ADget_impl*
end;//TevMultiSelectionLocation.pm_GetFormatting

function TevMultiSelectionLocation.Get_Obj: PInevObject;
//#UC START# *49DDD02D00E3_48ECCE2903ADget_var*
//#UC END# *49DDD02D00E3_48ECCE2903ADget_var*
begin
//#UC START# *49DDD02D00E3_48ECCE2903ADget_impl*
 Result := @f_ParaX;
//#UC END# *49DDD02D00E3_48ECCE2903ADget_impl*
end;//TevMultiSelectionLocation.Get_Obj

function TevMultiSelectionLocation.pm_GetText: InevText;
//#UC START# *49E6FB10002A_48ECCE2903ADget_var*
//#UC END# *49E6FB10002A_48ECCE2903ADget_var*
begin
//#UC START# *49E6FB10002A_48ECCE2903ADget_impl*
 Result := GetText;
//#UC END# *49E6FB10002A_48ECCE2903ADget_impl*
end;//TevMultiSelectionLocation.pm_GetText

function TevMultiSelectionLocation.AsPoint: InevBasePoint;
//#UC START# *4A5C6DB4014D_48ECCE2903AD_var*
//#UC END# *4A5C6DB4014D_48ECCE2903AD_var*
begin
//#UC START# *4A5C6DB4014D_48ECCE2903AD_impl*
 Result := nil;
//#UC END# *4A5C6DB4014D_48ECCE2903AD_impl*
end;//TevMultiSelectionLocation.AsPoint

end.