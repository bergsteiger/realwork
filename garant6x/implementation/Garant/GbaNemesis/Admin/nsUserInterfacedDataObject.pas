unit nsUserInterfacedDataObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/nsUserInterfacedDataObject.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::UsersDataObjects::TnsUserInterfacedDataObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  evDataObject,
  l3IID
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TnsUserInterfacedDataObject = class(TevDataObject)
 protected
 // overridden protected methods
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 end;//TnsUserInterfacedDataObject
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  bsInterfaces,
  SysUtils
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TnsUserInterfacedDataObject

function TnsUserInterfacedDataObject.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
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

{$IfEnd} //Admin

end.