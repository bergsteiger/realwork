unit evNodeDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evNodeDataObject.pas"
// Начат: 26.12.2006 16:16
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevNodeDataObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  l3TreeInterfaces,
  evNodeStorable,
  l3Interfaces,
  evPersistentDataObjectEx,
  ActiveX,
  Windows
  ;

type
 _StorableClass_ = TevNodeStorable;
 _DataType_ = Il3SimpleNode;
 {$Include ..\Everest\evDataObjectFromStorable.imp.pas}
 TevNodeDataObject = class(_evDataObjectFromStorable_)
 end;//TevNodeDataObject

implementation

uses
  evFormats,
  evTypes,
  nevTools,
  l3Base
  ;

{$Include ..\Everest\evDataObjectFromStorable.imp.pas}

end.