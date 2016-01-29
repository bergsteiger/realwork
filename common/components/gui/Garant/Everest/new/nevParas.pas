unit nevParas;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevParas.pas"
// Начат: 27.02.2008 12:02
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::nevUtils::TnevParas
//
// Список параграфов.
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
 _ItemType_ = InevPara;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevParas = class(_l3InterfaceRefList_, InevParas)
  {* Список параграфов. }
 protected
 // realized methods
   function pm_GetCount: Integer;
 end;//TnevParas

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TnevParas;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class TnevParas

function TnevParas.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_47C5271101E3get_var*
//#UC END# *4BB08B8902F2_47C5271101E3get_var*
begin
//#UC START# *4BB08B8902F2_47C5271101E3get_impl*
 Result := Count;
//#UC END# *4BB08B8902F2_47C5271101E3get_impl*
end;//TnevParas.pm_GetCount

end.