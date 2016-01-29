unit nsNodesInterfacedDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/List/nsNodesInterfacedDataObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::ListDataObjects::TnsNodesInterfacedDataObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  evDataObject,
  l3IID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsNodesInterfacedDataObject = class(TevDataObject)
 protected
 // overridden protected methods
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 end;//TnsNodesInterfacedDataObject
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicTreeUnit,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsNodesInterfacedDataObject

function TnsNodesInterfacedDataObject.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_48F744610382_var*
//#UC END# *4A60B23E00C3_48F744610382_var*
begin
//#UC START# *4A60B23E00C3_48F744610382_impl*
 if IID.EQ(INodesClipboard) then
 begin
  if Supports(Block, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
 end//IID.EQ(INodesClipboard)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_48F744610382_impl*
end;//TnsNodesInterfacedDataObject.COMQueryInterface

{$IfEnd} //not Admin AND not Monitorings

end.