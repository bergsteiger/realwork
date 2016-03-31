unit NOT_COMPLETED_evMultiSelectionLocation;

// ������: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evMultiSelectionLocation.pas"
// ���������: "SimpleClass"
// ������� ������: "TevMultiSelectionLocation" MUID: (48ECCE2903AD)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , k2TagTool
 , nevTools
 , l3Variant
;

type
 _nevParaTool_Parent_ = Tk2TagTool;
 {$Include w:\common\components\gui\Garant\Everest\new\nevParaTool.imp.pas}
 TevMultiSelectionLocation = class(_nevParaTool_, InevLocation)
  protected
   function GetRange: InevRange; virtual; abstract;
   function GetFormatting: InevDataFormatting; virtual; abstract;
   function GetText: InevText; virtual; abstract;
   function Range: InevRange;
   function pm_GetFormatting: InevDataFormatting;
   function Get_Obj: PInevObject;
   function pm_GetText: InevText;
   function AsPoint: InevBasePoint;
 end;//TevMultiSelectionLocation

implementation

uses
 l3ImplUses
 , SysUtils
;

type _Instance_R_ = TevMultiSelectionLocation;

{$Include w:\common\components\gui\Garant\Everest\new\nevParaTool.imp.pas}

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
