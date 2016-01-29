unit l3StringMapPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/Implementation/l3StringMapPrim.pas"
// Начат: 01.03.2010 16:24
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::L3 for VCM::Tl3StringMapPrim
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
  l3ProtoDataContainer,
  l3Variant,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
 {$Define l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

type
 _l3StringList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3StringList.imp.pas}
 Tl3StringMapPrim = class(_l3StringList_)
 end;//Tl3StringMapPrim
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3String,
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

type _Instance_R_ = Tl3StringMapPrim;

{$Include w:\common\components\rtl\Garant\L3\l3StringList.imp.pas}


{$IfEnd} //not NoVCM
end.