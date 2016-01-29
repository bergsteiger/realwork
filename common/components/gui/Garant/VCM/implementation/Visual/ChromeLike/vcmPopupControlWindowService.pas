unit vcmPopupControlWindowService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/vcmPopupControlWindowService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmPopupControlWindowService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3ProtoObject,
  l3PopupControlService,
  Windows
  ;

type
 TvcmPopupControlWindowService = {final} class(Tl3ProtoObject, Il3PopupControlService)
 public
 // realized methods
   function IsPopupControlWindow(aControlWnd: HWND): Boolean;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TvcmPopupControlWindowService;
    {- возвращает экземпляр синглетона. }
 end;//TvcmPopupControlWindowService
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  l3Base {a},
  vcmDropDownMenuForChromeLike
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;


// start class TvcmPopupControlWindowService

var g_TvcmPopupControlWindowService : TvcmPopupControlWindowService = nil;

procedure TvcmPopupControlWindowServiceFree;
begin
 l3Free(g_TvcmPopupControlWindowService);
end;

class function TvcmPopupControlWindowService.Instance: TvcmPopupControlWindowService;
begin
 if (g_TvcmPopupControlWindowService = nil) then
 begin
  l3System.AddExitProc(TvcmPopupControlWindowServiceFree);
  g_TvcmPopupControlWindowService := Create;
 end;
 Result := g_TvcmPopupControlWindowService;
end;


class function TvcmPopupControlWindowService.Exists: Boolean;
 {-}
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
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TvcmPopupControlWindowService
 Tl3PopupControlService.Instance.Alien := TvcmPopupControlWindowService.Instance;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.