unit evTreeDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evTreeDataObject.pas"
// Начат: 27.12.2006 18:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DataObjects::TevTreeDataObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  evTreeStorable,
  l3Interfaces,
  evPersistentDataObjectEx,
  ActiveX,
  Windows
  ;

type
 _DataType_ = TevTreeStorableData;
 _StorableClass_ = TevTreeStorable;
 {$Include ..\Everest\evDataObjectFromStorable.imp.pas}
 TevTreeDataObject = class(_evDataObjectFromStorable_)
 public
 // public methods
   class function MakeStorable(const aData: TevTreeStorableData): InevDataObjectPrim2; reintroduce;
 end;//TevTreeDataObject

implementation

uses
  evFormats,
  evTypes,
  l3Base
  ;

{$Include ..\Everest\evDataObjectFromStorable.imp.pas}

// start class TevTreeDataObject

class function TevTreeDataObject.MakeStorable(const aData: TevTreeStorableData): InevDataObjectPrim2;
var
 l_Inst : TevTreeDataObject;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

end.