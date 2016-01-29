unit evEditorControlList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/qf/evEditorControlList.pas"
// Начат: 05.03.2008 18:34
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::qf::TevEditorControlList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  evQueryCardInt,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes,
  l3PureMixIns
  ;

type
 _ItemType_ = IevEditorControl;
 _ListType_ = IevEditorControlList;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 _l3InterfacedList_Parent_ = _l3InterfaceRefList_;
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}
 TevEditorControlList = class(_l3InterfacedList_)
 end;//TevEditorControlList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TevEditorControlList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}


{$Include w:\common\components\rtl\Garant\L3\l3InterfacedList.imp.pas}

end.