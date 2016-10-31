unit vcmPopupControlWindowService;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmPopupControlWindowService.pas"
// ���������: "UtilityPack"
// ������� ������: "vcmPopupControlWindowService" MUID: (5587AAF10290)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3PopupControlService
 , Windows
;

type
 TvcmPopupControlWindowService = {final} class(Tl3ProtoObject, Il3PopupControlService)
  public
   function IsPopupControlWindow(aControlWnd: HWND): Boolean;
   class function Instance: TvcmPopupControlWindowService;
    {* ����� ��������� ���������� ���������� TvcmPopupControlWindowService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TvcmPopupControlWindowService
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , vcmDropDownMenuForChromeLike
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , SysUtils
 , l3Base
 //#UC START# *5587AAF10290impl_uses*
 //#UC END# *5587AAF10290impl_uses*
;

var g_TvcmPopupControlWindowService: TvcmPopupControlWindowService = nil;
 {* ��������� ���������� TvcmPopupControlWindowService }

procedure TvcmPopupControlWindowServiceFree;
 {* ����� ������������ ���������� ���������� TvcmPopupControlWindowService }
begin
 l3Free(g_TvcmPopupControlWindowService);
end;//TvcmPopupControlWindowServiceFree

function TvcmPopupControlWindowService.IsPopupControlWindow(aControlWnd: HWND): Boolean;
//#UC START# *55879E4401FC_5587AB210223_var*
const
 cMenuClassName: String = '#32768';
var
 l_Control: TWinControl;
 l_ClassName: String;
//#UC END# *55879E4401FC_5587AB210223_var*
begin
//#UC START# *55879E4401FC_5587AB210223_impl*
 l_Control := FindControl(aControlWnd);
 if (l_Control <> nil) then
  Result := l_Control is TvcmDropDownMenuForChromeLike
 else
 begin
  SetLength(l_ClassName, 128);
  GetClassName(aControlWnd, PChar(l_ClassName), 128);
  l_ClassName := PChar(l_ClassName);
  Result := (l_ClassName = cMenuClassName);
 end;
//#UC END# *55879E4401FC_5587AB210223_impl*
end;//TvcmPopupControlWindowService.IsPopupControlWindow

class function TvcmPopupControlWindowService.Instance: TvcmPopupControlWindowService;
 {* ����� ��������� ���������� ���������� TvcmPopupControlWindowService }
begin
 if (g_TvcmPopupControlWindowService = nil) then
 begin
  l3System.AddExitProc(TvcmPopupControlWindowServiceFree);
  g_TvcmPopupControlWindowService := Create;
 end;
 Result := g_TvcmPopupControlWindowService;
end;//TvcmPopupControlWindowService.Instance

class function TvcmPopupControlWindowService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvcmPopupControlWindowService <> nil;
end;//TvcmPopupControlWindowService.Exists

initialization
 Tl3PopupControlService.Instance.Alien := TvcmPopupControlWindowService.Instance;
 {* ����������� TvcmPopupControlWindowService }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
