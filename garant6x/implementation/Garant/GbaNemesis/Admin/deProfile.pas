unit deProfile;
 {* Интерфейс обмена данными для формы "efUserProfile" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\deProfile.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdeProfile" MUID: (4AA5275401A5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoObject
 , AdminInterfaces
 , SecurityUnit
;

type
 TdeProfile = class(Tl3ProtoObject, IdeProfile)
  {* Интерфейс обмена данными для формы "efUserProfile" }
  private
   f_Profile: IUserProfile;
   f_IsNew: Boolean;
  protected
   function pm_GetUserProfile: IUserProfile;
   function pm_GetIsNewProfile: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aProfile: IUserProfile;
    aNew: Boolean); reintroduce;
   class function Make(const aProfile: IUserProfile;
    aNew: Boolean = False): IdeProfile; reintroduce;
 end;//TdeProfile
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

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
 aNew: Boolean = False): IdeProfile;
var
 l_Inst : TdeProfile;
begin
 l_Inst := Create(aProfile, aNew);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeProfile.Make

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
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AA5275401A5_var*
//#UC END# *479731C50290_4AA5275401A5_var*
begin
//#UC START# *479731C50290_4AA5275401A5_impl*
 f_Profile := nil;
 f_IsNew := False;
 inherited;
//#UC END# *479731C50290_4AA5275401A5_impl*
end;//TdeProfile.Cleanup
{$IfEnd} // Defined(Admin)

end.
