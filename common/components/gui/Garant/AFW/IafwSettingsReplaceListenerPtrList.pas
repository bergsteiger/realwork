unit IafwSettingsReplaceListenerPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/AFW/IafwSettingsReplaceListenerPtrList.pas"
// Начат: 07.11.2008 16:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::AFW::afwSettings::TIafwSettingsReplaceListenerPtrList
//
// Список УКАЗАТЕЛЕЙ на IafwSettingsReplaceListener
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\AFW\afwDefine.inc}

interface

uses
  afwInterfaces,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = IafwSettingsReplaceListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TIafwSettingsReplaceListenerPtrList = class(_l3InterfacePtrList_)
  {* Список УКАЗАТЕЛЕЙ на IafwSettingsReplaceListener }
 end;//TIafwSettingsReplaceListenerPtrList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = TIafwSettingsReplaceListenerPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

end.