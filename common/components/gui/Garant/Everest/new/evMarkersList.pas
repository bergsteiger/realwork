unit evMarkersList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/evMarkersList.pas"
// Начат: 03.03.2008 18:11
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::nevUtils::TevMarkersList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevTools,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = IevMarker;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TevMarkersList = class(_l3InterfaceRefList_ {$If defined(evNeedMarkers)}, IevMarkersList{$IfEnd} //evNeedMarkers
 )
 protected
 // realized methods
   function pm_GetCount: Integer;
 end;//TevMarkersList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TevMarkersList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class TevMarkersList

function TevMarkersList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_47CC15130269get_var*
//#UC END# *4BB08B8902F2_47CC15130269get_var*
begin
//#UC START# *4BB08B8902F2_47CC15130269get_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_47CC15130269get_impl*
end;//TevMarkersList.pm_GetCount

end.