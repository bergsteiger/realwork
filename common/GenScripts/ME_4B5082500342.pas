unit PrimEditionsRes_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimEditionsRes_Form.pas"
// ���������: "VCMDataModule"
// ������� ������: "PrimEditionsRes" MUID: (4B5082500342)
// ��� ����: "TPrimEditionsResForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , vtPngImgList
;

type
 TPrimEditionsResForm = class
  private
   f_EditionsStateIcons: TvtPngImageList;
    {* ���� ��� �������� EditionsStateIcons }
  protected
   function pm_GetEditionsStateIcons: TvtPngImageList;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TPrimEditionsResForm;
    {* ����� ��������� ���������� ���������� TPrimEditionsResForm }
  public
   property EditionsStateIcons: TvtPngImageList
    read pm_GetEditionsStateIcons;
 end;//TPrimEditionsResForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
;

var g_TPrimEditionsResForm: TPrimEditionsResForm = nil;
 {* ��������� ���������� TPrimEditionsResForm }

procedure TPrimEditionsResFormFree;
 {* ����� ������������ ���������� ���������� TPrimEditionsResForm }
begin
 l3Free(g_TPrimEditionsResForm);
end;//TPrimEditionsResFormFree

function TPrimEditionsResForm.pm_GetEditionsStateIcons: TvtPngImageList;
//#UC START# *4B50956D00B2_4B5082500342get_var*
//#UC END# *4B50956D00B2_4B5082500342get_var*
begin
//#UC START# *4B50956D00B2_4B5082500342get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B50956D00B2_4B5082500342get_impl*
end;//TPrimEditionsResForm.pm_GetEditionsStateIcons

class function TPrimEditionsResForm.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TPrimEditionsResForm <> nil;
end;//TPrimEditionsResForm.Exists

class function TPrimEditionsResForm.Instance: TPrimEditionsResForm;
 {* ����� ��������� ���������� ���������� TPrimEditionsResForm }
begin
 if (g_TPrimEditionsResForm = nil) then
 begin
  l3System.AddExitProc(TPrimEditionsResFormFree);
  g_TPrimEditionsResForm := Create;
 end;
 Result := g_TPrimEditionsResForm;
end;//TPrimEditionsResForm.Instance

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimEditionsResForm);
 {* ����������� PrimEditionsRes }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
