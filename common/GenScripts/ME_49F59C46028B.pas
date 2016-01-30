unit bsSelectedUsers;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\bsSelectedUsers.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3SimpleObject
 , bsInterfaces
 , l3Interfaces
;

type
 TbsSelectedUsers = class(Tl3SimpleObject, IbsSelectedUsers)
  private
   f_Items: Il3StringsEx;
  protected
   procedure AddUser(const aName: Il3CString;
    anUID: Integer);
   function pm_GetName(anIndex: Integer): Il3CString;
   function pm_GetCount: Integer;
   function pm_GetUID(anIndex: Integer): Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make: IbsSelectedUsers; reintroduce;
   constructor Create; reintroduce;
 end;//TbsSelectedUsers
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3VCLStrings
;

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
end;//TbsSelectedUsers.Make

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49F59C46028B_var*
//#UC END# *479731C50290_49F59C46028B_var*
begin
//#UC START# *479731C50290_49F59C46028B_impl*
 f_Items := nil;
 inherited Cleanup;
//#UC END# *479731C50290_49F59C46028B_impl*
end;//TbsSelectedUsers.Cleanup
{$IfEnd} // Defined(Admin)

end.
