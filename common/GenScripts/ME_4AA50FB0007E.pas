unit deAdmin;
 {* Интерфейс обмена данными содержащий Node }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\deAdmin.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoObject
 , AdminInterfaces
;

type
 TdeAdmin = class(Tl3ProtoObject, IdeAdmin)
  {* Интерфейс обмена данными содержащий Node }
  private
   f_Groups: IdeNode;
   f_Users: IdeNode;
  protected
   function pm_GetGroups: IdeNode;
   function pm_GetUsers: IdeNode;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aGroups: IdeNode;
    const aUsers: IdeNode); reintroduce;
   class function Make(const aGroups: IdeNode;
    const aUsers: IdeNode): IdeAdmin; reintroduce;
 end;//TdeAdmin
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

constructor TdeAdmin.Create(const aGroups: IdeNode;
 const aUsers: IdeNode);
//#UC START# *4AA5118C031E_4AA50FB0007E_var*
//#UC END# *4AA5118C031E_4AA50FB0007E_var*
begin
//#UC START# *4AA5118C031E_4AA50FB0007E_impl*
 inherited Create;
 f_Groups := aGroups;
 f_Users := aUsers;
//#UC END# *4AA5118C031E_4AA50FB0007E_impl*
end;//TdeAdmin.Create

class function TdeAdmin.Make(const aGroups: IdeNode;
 const aUsers: IdeNode): IdeAdmin;
var
 l_Inst : TdeAdmin;
begin
 l_Inst := Create(aGroups, aUsers);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeAdmin.Make

function TdeAdmin.pm_GetGroups: IdeNode;
//#UC START# *4AA510B00041_4AA50FB0007Eget_var*
//#UC END# *4AA510B00041_4AA50FB0007Eget_var*
begin
//#UC START# *4AA510B00041_4AA50FB0007Eget_impl*
 Result := f_Groups;
//#UC END# *4AA510B00041_4AA50FB0007Eget_impl*
end;//TdeAdmin.pm_GetGroups

function TdeAdmin.pm_GetUsers: IdeNode;
//#UC START# *4AA510C90109_4AA50FB0007Eget_var*
//#UC END# *4AA510C90109_4AA50FB0007Eget_var*
begin
//#UC START# *4AA510C90109_4AA50FB0007Eget_impl*
 Result := f_Users;
//#UC END# *4AA510C90109_4AA50FB0007Eget_impl*
end;//TdeAdmin.pm_GetUsers

procedure TdeAdmin.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AA50FB0007E_var*
//#UC END# *479731C50290_4AA50FB0007E_var*
begin
//#UC START# *479731C50290_4AA50FB0007E_impl*
 f_Groups := nil;
 f_Users := nil;
 inherited;
//#UC END# *479731C50290_4AA50FB0007E_impl*
end;//TdeAdmin.Cleanup
{$IfEnd} // Defined(Admin)

end.
