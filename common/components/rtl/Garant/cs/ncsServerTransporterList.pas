unit ncsServerTransporterList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsServerTransporterList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsServerTransporterList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoDataContainer,
  ncsMessageInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
 {$Define l3Items_NoSort}

type
 _ItemType_ = IncsServerTransporter;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TncsServerTransporterList = class(_l3InterfaceRefList_)
 end;//TncsServerTransporterList
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

type _Instance_R_ = TncsServerTransporterList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}


{$IfEnd} //not Nemesis
end.