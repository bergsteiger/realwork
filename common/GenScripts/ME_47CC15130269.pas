unit evMarkersList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\evMarkersList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevMarkersList" MUID: (47CC15130269)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IevMarker;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevMarkersList = class(_l3InterfaceRefList_{$If Defined(evNeedMarkers)}
 , IevMarkersList
 {$IfEnd} // Defined(evNeedMarkers)
 )
  protected
   function pm_GetCount: Integer;
 end;//TevMarkersList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type _Instance_R_ = TevMarkersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

function TevMarkersList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_47CC15130269get_var*
//#UC END# *4BB08B8902F2_47CC15130269get_var*
begin
//#UC START# *4BB08B8902F2_47CC15130269get_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_47CC15130269get_impl*
end;//TevMarkersList.pm_GetCount

end.
