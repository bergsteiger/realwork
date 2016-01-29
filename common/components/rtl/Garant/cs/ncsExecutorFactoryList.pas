unit ncsExecutorFactoryList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsExecutorFactoryList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsExecutorFactoryList
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
type
 _ItemType_ = IncsMessageExecutorFactory;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TncsExecutorFactoryList = class(_l3InterfacePtrList_)
 end;//TncsExecutorFactoryList
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

type _Instance_R_ = TncsExecutorFactoryList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}


{$IfEnd} //not Nemesis
end.