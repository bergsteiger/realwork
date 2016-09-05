unit PrimEditionsRes_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimEditionsRes_Form.pas"
// Стереотип: "VCMDataModule"
// Элемент модели: "PrimEditionsRes" MUID: (4B5082500342)
// Имя типа: "TPrimEditionsResForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , vtPngImgList
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Classes
;

type
 TPrimEditionsResForm = class(TDataModule)
  private
   f_EditionsStateIcons: TvtPngImageList;
  protected
   function pm_GetEditionsStateIcons: TvtPngImageList;
  public
   class function Instance: TPrimEditionsResForm;
    {* Метод получения экземпляра синглетона TPrimEditionsResForm }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property EditionsStateIcons: TvtPngImageList
    read pm_GetEditionsStateIcons;
 end;//TPrimEditionsResForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4B5082500342impl_uses*
 //#UC END# *4B5082500342impl_uses*
;

var g_TPrimEditionsResForm: TPrimEditionsResForm = nil;
 {* Экземпляр синглетона TPrimEditionsResForm }

procedure TPrimEditionsResFormFree;
 {* Метод освобождения экземпляра синглетона TPrimEditionsResForm }
begin
 l3Free(g_TPrimEditionsResForm);
end;//TPrimEditionsResFormFree

function TPrimEditionsResForm.pm_GetEditionsStateIcons: TvtPngImageList;
begin
 if (f_EditionsStateIcons = nil) then
  f_EditionsStateIcons := FindComponent('EditionsStateIcons') As TvtPngImageList;
 Result := f_EditionsStateIcons;
end;//TPrimEditionsResForm.pm_GetEditionsStateIcons

class function TPrimEditionsResForm.Instance: TPrimEditionsResForm;
 {* Метод получения экземпляра синглетона TPrimEditionsResForm }
begin
 if (g_TPrimEditionsResForm = nil) then
 begin
  l3System.AddExitProc(TPrimEditionsResFormFree);
  g_TPrimEditionsResForm := Create(nil);
 end;
 Result := g_TPrimEditionsResForm;
end;//TPrimEditionsResForm.Instance

class function TPrimEditionsResForm.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TPrimEditionsResForm <> nil;
end;//TPrimEditionsResForm.Exists

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimEditionsResForm);
 {* Регистрация PrimEditionsRes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
