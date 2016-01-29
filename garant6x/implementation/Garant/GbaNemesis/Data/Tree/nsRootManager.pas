unit nsRootManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Data"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/nsRootManager.pas"
// Начат: 2005/11/22 17:28:11
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Data::Tree::TnsRootManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3CProtoObject,
  l3PureMixIns,
  DynamicTreeUnit,
  l3CacheableBase,
  l3Core,
  l3Interfaces,
  l3NotifyPtrList,
  l3IID
  ;

type
 _l3Changing_Parent_ = Tl3CProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}
 _nsRootManager_Parent_ = _l3Changing_;
 {$Include ..\Tree\nsRootManager.imp.pas}
 _l3COMQueryInterface_Parent_ = _nsRootManager_;
 {$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}
 TnsRootManager = class(_l3COMQueryInterface_)
 end;//TnsRootManager

implementation

uses
  nsTypes,
  Classes,
  Windows,
  l3Base,
  Messages,
  l3Interlocked,
  l3Types,
  SysUtils,
  l3InterfacesMisc
  ;

{$Include w:\common\components\rtl\Garant\L3\l3Changing.imp.pas}

{$Include ..\Tree\nsRootManager.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3COMQueryInterface.imp.pas}

end.