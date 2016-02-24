unit nsUserInterfacedDataObject;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\nsUserInterfacedDataObject.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , evDataObject
 , l3IID
;

type
 TnsUserInterfacedDataObject = class(TevDataObject)
  protected
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
 end;//TnsUserInterfacedDataObject
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , bsInterfaces
 , SysUtils
;

function TnsUserInterfacedDataObject.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_49F57FF400B2_var*
//#UC END# *4A60B23E00C3_49F57FF400B2_var*
begin
//#UC START# *4A60B23E00C3_49F57FF400B2_impl*
 if IID.EQ(IbsSelectedUsers) then
 begin
  if Supports(Block, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
 end//IID.EQ(IbsSelectedUsers)
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_49F57FF400B2_impl*
end;//TnsUserInterfacedDataObject.COMQueryInterface
{$IfEnd} // Defined(Admin)

end.
