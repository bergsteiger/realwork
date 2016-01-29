unit nsGroupTreeStructWithDrop;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/nsGroupTreeStructWithDrop.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::Users::TnsGroupTreeStructWithDrop
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
  nsGroupTreeStruct,
  l3TreeInterfaces
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TnsGroupTreeStructWithDrop = class(TnsGroupTreeStruct)
 protected
 // overridden protected methods
   function DoCanAcceptData(const aTargetNode: Il3SimpleNode;
    const aData: Tl3TreeData;
    aProcessed: PBoolean): Boolean; override;
   function DoDropData(const aTargetNode: Il3SimpleNode;
    const aData: Tl3TreeData;
    var aProcessed: Boolean): Boolean; override;
 end;//TnsGroupTreeStructWithDrop
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  bsInterfaces,
  SysUtils,
  DataAdapter,
  SecurityUnit,
  nsUserNodes
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TnsGroupTreeStructWithDrop

function TnsGroupTreeStructWithDrop.DoCanAcceptData(const aTargetNode: Il3SimpleNode;
  const aData: Tl3TreeData;
  aProcessed: PBoolean): Boolean;
//#UC START# *48FEE78E01B2_49F16EE7010F_var*
var
 l_Data: IbsUserTreeData;
//#UC END# *48FEE78E01B2_49F16EE7010F_var*
begin
//#UC START# *48FEE78E01B2_49F16EE7010F_impl*
 if Supports(aData.rNodes, IbsUserTreeData, l_Data) then
 begin
  Result := Assigned(aTargetNode);
  if aProcessed <> nil then
   aProcessed^ := true;
 end//if Supports(aData.rNodes, IbsUserTreeData, l_Data) then
 else
  Result := inherited DoCanAcceptData(aTargetNode, aData, aProcessed);
//#UC END# *48FEE78E01B2_49F16EE7010F_impl*
end;//TnsGroupTreeStructWithDrop.DoCanAcceptData

function TnsGroupTreeStructWithDrop.DoDropData(const aTargetNode: Il3SimpleNode;
  const aData: Tl3TreeData;
  var aProcessed: Boolean): Boolean;
//#UC START# *48FEE9D303B6_49F16EE7010F_var*
var
 l_Data: IbsUserTreeData;
 l_UIDList: IUIDList;
 l_Idx: Integer;
//#UC END# *48FEE9D303B6_49F16EE7010F_var*
begin
//#UC START# *48FEE9D303B6_49F16EE7010F_impl*
 Result := DoCanAcceptData(aTargetNode, aData, nil);
 if Result and Supports(aData.rNodes, IbsUserTreeData, l_Data) then
 begin
  l_UIDList := defDataAdapter.NativeAdapter.MakeUIDList;
  try
   for l_Idx := 0 To l_Data.Users.Count - 1 do
    l_UIDList.Add(l_Data.Users.UID[l_IDX]);
   defDataAdapter.NativeAdapter.MakeUserManager.ChangeUsersGroup(l_UIDList, GetUserID(aTargetNode));
  finally
   l_UIDList := nil;
  end;
  aProcessed := True;
 end
 else
  Result := inherited DoDropData(aTargetNode, aData, aProcessed);
//#UC END# *48FEE9D303B6_49F16EE7010F_impl*
end;//TnsGroupTreeStructWithDrop.DoDropData

{$IfEnd} //Admin

end.