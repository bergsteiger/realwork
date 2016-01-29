unit l3MouseWheelListener;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3MouseWheelListener.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Listeners::Tl3MouseWheelListener
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3SimpleDataContainer,
  l3Types,
  l3Memory,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Il3MouseWheelListener;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 Tl3MouseWheelListener = class(_l3InterfacePtrList_)
 end;//Tl3MouseWheelListener

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3MouseWheelListener;
type _l3InterfacePtrList_R_ = Tl3MouseWheelListener;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.