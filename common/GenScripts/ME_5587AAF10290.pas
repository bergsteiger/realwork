unit vcmPopupControlWindowService;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmPopupControlWindowService.pas"
// ���������: "UtilityPack"

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
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   function IsPopupControlWindow(aControlWnd: HWND): Boolean;
   class function Instance: TvcmPopupControlWindowService;
    {* ����� ��������� ���������� ���������� TvcmPopupControlWindowService }
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
;

var g_TvcmPopupControlWindowService: TvcmPopupControlWindowService = nil;
 {* ��������� ���������� TvcmPopupControlWindowService }

procedure TvcmPopupControlWindowServiceFree;
 {* ����� ������������ ���������� ���������� TvcmPopupControlWindowService }
begin
 l3Free(g_TvcmPopupControlWindowService);
end;//TvcmPopupControlWindowServiceFree

class function TvcmPopupControlWindowService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvcmPopupControlWindowService <> nil;
end;//TvcmPopupControlWindowService.Exists

function TvcmPopupControlWindowService.IsPopupControlWindow(aControlWnd: HWND): Boolean;
//#UC START# *D2E4642CC7BC_5587AB210223_var*
const
 cMenuClassName: String = '#32768';
var
 l_Control: TWinControl;
 l_ClassName: String;
//#UC END# *D2E4642CC7BC_5587AB210223_var*
begin
//#UC START# *D2E4642CC7BC_5587AB210223_impl*
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
//#UC END# *D2E4642CC7BC_5587AB210223_impl*
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

initialization
 Tl3PopupControlService.Instance.Alien := TvcmPopupControlWindowService.Instance;
 {* ����������� TvcmPopupControlWindowService }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
