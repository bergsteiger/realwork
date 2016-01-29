unit vcmIEntityList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmIEntityList.pas"
// Начат: 24.01.2012 19:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Containers::TvcmIEntityList
//
// Список ссылок на IvcmEntity
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 _ItemType_ = IvcmEntity;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TvcmIEntityList = class(_l3InterfaceRefList_)
  {* Список ссылок на IvcmEntity }
 end;//TvcmIEntityList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

type _Instance_R_ = TvcmIEntityList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}


{$IfEnd} //not NoVCM
end.