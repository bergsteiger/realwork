unit deAdmin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/deAdmin.pas"
// Начат: 07.09.2009 17:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::Admin::TdeAdmin
//
// Интерфейс обмена данными содержащий Node
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
  AdminInterfaces,
  l3ProtoObject
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TdeAdmin = class(Tl3ProtoObject, IdeAdmin)
  {* Интерфейс обмена данными содержащий Node }
 private
 // private fields
   f_Groups : IdeNode;
   f_Users : IdeNode;
 protected
 // realized methods
   function pm_GetGroups: IdeNode;
   function pm_GetUsers: IdeNode;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aGroups: IdeNode;
    const aUsers: IdeNode); reintroduce;
   class function Make(const aGroups: IdeNode;
    const aUsers: IdeNode): IdeAdmin; reintroduce;
 end;//TdeAdmin
{$IfEnd} //Admin

implementation

{$If defined(Admin)}

// start class TdeAdmin

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
end;

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
//#UC START# *479731C50290_4AA50FB0007E_var*
//#UC END# *479731C50290_4AA50FB0007E_var*
begin
//#UC START# *479731C50290_4AA50FB0007E_impl*
 f_Groups := nil;
 f_Users := nil;
 inherited;
//#UC END# *479731C50290_4AA50FB0007E_impl*
end;//TdeAdmin.Cleanup

{$IfEnd} //Admin

end.