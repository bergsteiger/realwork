unit OvcKeyDataListenerList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Orpheus"
// Модуль: "w:/common/components/rtl/external/Orpheus/OvcKeyDataListenerList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Orpheus::OvcKeyDataListeners::TOvcKeyDataListenerList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Orpheus\OVC.INC}

interface

uses
  l3InternalInterfaces,
  l3SimpleDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Il3KeyDataListener;
 _l3InterfacePtrList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TOvcKeyDataListenerList = class(_l3InterfacePtrList_)
 end;//TOvcKeyDataListenerList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TOvcKeyDataListenerList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.