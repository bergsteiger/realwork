unit deProfile;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/deProfile.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::Admin::TdeProfile
//
// Интерфейс обмена данными для формы "efUserProfile"
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
  SecurityUnit,
  AdminInterfaces,
  l3ProtoObject
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TdeProfile = class(Tl3ProtoObject, IdeProfile)
  {* Интерфейс обмена данными для формы "efUserProfile" }
 private
 // private fields
   f_Profile : IUserProfile;
   f_IsNew : Boolean;
 protected
 // realized methods
   function pm_GetUserProfile: IUserProfile;
   function pm_GetIsNewProfile: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aProfile: IUserProfile;
    aNew: Boolean); reintroduce;
   class function Make(const aProfile: IUserProfile;
    aNew: Boolean = false): IdeProfile; reintroduce;
 end;//TdeProfile
{$IfEnd} //Admin

implementation

{$If defined(Admin)}

// start class TdeProfile

constructor TdeProfile.Create(const aProfile: IUserProfile;
  aNew: Boolean);
//#UC START# *4AA5279D0119_4AA5275401A5_var*
//#UC END# *4AA5279D0119_4AA5275401A5_var*
begin
//#UC START# *4AA5279D0119_4AA5275401A5_impl*
 inherited Create;
 f_Profile := aProfile;
 f_IsNew := aNew;
//#UC END# *4AA5279D0119_4AA5275401A5_impl*
end;//TdeProfile.Create

class function TdeProfile.Make(const aProfile: IUserProfile;
  aNew: Boolean = false): IdeProfile;
var
 l_Inst : TdeProfile;
begin
 l_Inst := Create(aProfile, aNew);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TdeProfile.pm_GetUserProfile: IUserProfile;
//#UC START# *4AA526EC03C7_4AA5275401A5get_var*
//#UC END# *4AA526EC03C7_4AA5275401A5get_var*
begin
//#UC START# *4AA526EC03C7_4AA5275401A5get_impl*
 Result := f_Profile;
//#UC END# *4AA526EC03C7_4AA5275401A5get_impl*
end;//TdeProfile.pm_GetUserProfile

function TdeProfile.pm_GetIsNewProfile: Boolean;
//#UC START# *4AA527110040_4AA5275401A5get_var*
//#UC END# *4AA527110040_4AA5275401A5get_var*
begin
//#UC START# *4AA527110040_4AA5275401A5get_impl*
 Result := f_IsNew;
//#UC END# *4AA527110040_4AA5275401A5get_impl*
end;//TdeProfile.pm_GetIsNewProfile

procedure TdeProfile.Cleanup;
//#UC START# *479731C50290_4AA5275401A5_var*
//#UC END# *479731C50290_4AA5275401A5_var*
begin
//#UC START# *479731C50290_4AA5275401A5_impl*
 f_Profile := nil;
 f_IsNew := False;
 inherited;
//#UC END# *479731C50290_4AA5275401A5_impl*
end;//TdeProfile.Cleanup

{$IfEnd} //Admin

end.