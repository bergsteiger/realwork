unit nsNodesInterfacedDataObject;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\nsNodesInterfacedDataObject.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , evDataObject
 , l3IID
;

type
 TnsNodesInterfacedDataObject = class(TevDataObject)
  public
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
 end;//TnsNodesInterfacedDataObject
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DynamicTreeUnit
 , SysUtils
;

function TnsNodesInterfacedDataObject.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
