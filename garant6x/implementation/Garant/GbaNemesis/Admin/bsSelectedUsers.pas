unit bsSelectedUsers;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/bsSelectedUsers.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::UsersDataObjects::TbsSelectedUsers
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
  l3Interfaces,
  l3SimpleObject,
  bsInterfaces
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TbsSelectedUsers = class(Tl3SimpleObject, IbsSelectedUsers)
 private
 // private fields
   f_Items : Il3StringsEx;
 protected
 // realized methods
   procedure AddUser(const aName: Il3CString;
    anUID: Integer);
   function pm_GetName(anIndex: Integer): Il3CString;
   function pm_GetCount: Integer;
   function pm_GetUID(anIndex: Integer): Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   class function Make: IbsSelectedUsers; reintroduce;
   constructor Create; reintroduce;
 end;//TbsSelectedUsers
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  l3VCLStrings
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TbsSelectedUsers

class function TbsSelectedUsers.Make: IbsSelectedUsers;
var
 l_Inst : TbsSelectedUsers;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

constructor TbsSelectedUsers.Create;
//#UC START# *49F5A7D70158_49F59C46028B_var*
//#UC END# *49F5A7D70158_49F59C46028B_var*
begin
//#UC START# *49F5A7D70158_49F59C46028B_impl*
 inherited Create;
 f_Items := Tl3Strings.Make;
//#UC END# *49F5A7D70158_49F59C46028B_impl*
end;//TbsSelectedUsers.Create

procedure TbsSelectedUsers.AddUser(const aName: Il3CString;
  anUID: Integer);
//#UC START# *49F1ADEF0280_49F59C46028B_var*
//#UC END# *49F1ADEF0280_49F59C46028B_var*
begin
//#UC START# *49F1ADEF0280_49F59C46028B_impl*
 f_Items.AddObject(aName, TObject(anUID));
//#UC END# *49F1ADEF0280_49F59C46028B_impl*
end;//TbsSelectedUsers.AddUser

function TbsSelectedUsers.pm_GetName(anIndex: Integer): Il3CString;
//#UC START# *49F1AE8F03C3_49F59C46028Bget_var*
//#UC END# *49F1AE8F03C3_49F59C46028Bget_var*
begin
//#UC START# *49F1AE8F03C3_49F59C46028Bget_impl*
 Result := f_Items.ItemC[anIndex];
//#UC END# *49F1AE8F03C3_49F59C46028Bget_impl*
end;//TbsSelectedUsers.pm_GetName

function TbsSelectedUsers.pm_GetCount: Integer;
//#UC START# *49F1AED002EE_49F59C46028Bget_var*
//#UC END# *49F1AED002EE_49F59C46028Bget_var*
begin
//#UC START# *49F1AED002EE_49F59C46028Bget_impl*
 Result := f_Items.Count;
//#UC END# *49F1AED002EE_49F59C46028Bget_impl*
end;//TbsSelectedUsers.pm_GetCount

function TbsSelectedUsers.pm_GetUID(anIndex: Integer): Integer;
//#UC START# *49F1AEFF0284_49F59C46028Bget_var*
//#UC END# *49F1AEFF0284_49F59C46028Bget_var*
begin
//#UC START# *49F1AEFF0284_49F59C46028Bget_impl*
 Result := Integer(f_Items.Objects[anIndex]);
//#UC END# *49F1AEFF0284_49F59C46028Bget_impl*
end;//TbsSelectedUsers.pm_GetUID

procedure TbsSelectedUsers.Cleanup;
//#UC START# *479731C50290_49F59C46028B_var*
//#UC END# *479731C50290_49F59C46028B_var*
begin
//#UC START# *479731C50290_49F59C46028B_impl*
 f_Items := nil;
 inherited Cleanup;
//#UC END# *479731C50290_49F59C46028B_impl*
end;//TbsSelectedUsers.Cleanup

{$IfEnd} //Admin

end.