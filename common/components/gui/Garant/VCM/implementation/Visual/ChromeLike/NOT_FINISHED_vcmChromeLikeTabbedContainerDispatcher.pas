unit NOT_FINISHED_vcmChromeLikeTabbedContainerDispatcher;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/ChromeLike/NOT_FINISHED_vcmChromeLikeTabbedContainerDispatcher.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Visual$ChromeLike::vcmChromeLikeTabbedContainerDispatcher
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  Classes,
  vcmEntityForm,
  vcmChromeLikeTabbedContainerForm
  ;

type
 TvcmChromeLikeTabbedContainerDispatcher = class
 protected
 // protected methods
   function ContainerFormClass: RvcmChromeLikeTabbedContainerFormClass; virtual;
 public
 // public methods
   function MakeNewTabbedContainer(aOwner: TComponent;
     aChildForm: TvcmEntityForm): TvcmChromeLikeTabbedContainerForm; overload; 
   function MakeNewTabbedContainer(aOwner: TComponent;
     aPrevContainer: TvcmChromeLikeTabbedContainerForm): TvcmChromeLikeTabbedContainerForm; overload; 
   function CheckContainer(aOwner: TComponent;
     aContainer: TvcmChromeLikeTabbedContainerForm): TvcmChromeLikeTabbedContainerForm;
   function DockableFormClass: RvcmEntityForm;
 public
 // singleton factory method
   class function Instance: TvcmChromeLikeTabbedContainerDispatcher;
    {- возвращает экземпляр синглетона. }
 end;//TvcmChromeLikeTabbedContainerDispatcher
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a},
  Windows,
  SysUtils,
  ChromeLikeWinUtils,
  Forms
  ;


// start class TvcmChromeLikeTabbedContainerDispatcher

var g_TvcmChromeLikeTabbedContainerDispatcher : TvcmChromeLikeTabbedContainerDispatcher = nil;

procedure TvcmChromeLikeTabbedContainerDispatcherFree;
begin
 l3Free(g_TvcmChromeLikeTabbedContainerDispatcher);
end;

class function TvcmChromeLikeTabbedContainerDispatcher.Instance: TvcmChromeLikeTabbedContainerDispatcher;
begin
 if (g_TvcmChromeLikeTabbedContainerDispatcher = nil) then
 begin
  l3System.AddExitProc(TvcmChromeLikeTabbedContainerDispatcherFree);
  g_TvcmChromeLikeTabbedContainerDispatcher := Create;
 end;
 Result := g_TvcmChromeLikeTabbedContainerDispatcher;
end;


function TvcmChromeLikeTabbedContainerDispatcher.MakeNewTabbedContainer(aOwner: TComponent;
  aChildForm: TvcmEntityForm): TvcmChromeLikeTabbedContainerForm;
//#UC START# *53426E14020D_53426D690044_var*
//#UC END# *53426E14020D_53426D690044_var*
begin
//#UC START# *53426E14020D_53426D690044_impl*
 Result := ContainerFormClass.Make(aOwner, aChildForm);
//#UC END# *53426E14020D_53426D690044_impl*
end;//TvcmChromeLikeTabbedContainerDispatcher.MakeNewTabbedContainer

function TvcmChromeLikeTabbedContainerDispatcher.MakeNewTabbedContainer(aOwner: TComponent;
  aPrevContainer: TvcmChromeLikeTabbedContainerForm): TvcmChromeLikeTabbedContainerForm;
//#UC START# *53426E2903AD_53426D690044_var*
//#UC END# *53426E2903AD_53426D690044_var*
begin
//#UC START# *53426E2903AD_53426D690044_impl*
 Result := ContainerFormClass.Make(aOwner, aPrevContainer);
//#UC END# *53426E2903AD_53426D690044_impl*
end;//TvcmChromeLikeTabbedContainerDispatcher.MakeNewTabbedContainer

function TvcmChromeLikeTabbedContainerDispatcher.CheckContainer(aOwner: TComponent;
  aContainer: TvcmChromeLikeTabbedContainerForm): TvcmChromeLikeTabbedContainerForm;
//#UC START# *53426E3E01EC_53426D690044_var*
var
 l_BoundsRect: TRect;
 l_IsFocused: Boolean;
 l_ZOrderInfo: TWindowZOrderInfo;
 l_WndState: TWindowState;
//#UC END# *53426E3E01EC_53426D690044_var*
begin
//#UC START# *53426E3E01EC_53426D690044_impl*
 GetWindowRect(aContainer.Handle, l_BoundsRect);
// l_ZOrderInfo := aContainer.ZOrderInfo;
 l_WndState := aContainer.WindowState;
 Result := MakeNewTabbedContainer(aOwner, aContainer);
 l_BoundsRect := aContainer.BoundsRect;
 aContainer.Visible := False;
 aContainer.SafeClose;
 Result.BoundsRect := l_BoundsRect;
 Result.Visible := True;
 SetWindowZOrderInfo(Result.Handle, l_ZOrderInfo);
 Result.BoundsRect := l_BoundsRect;
 Result.WindowState := l_WndState; 
//#UC END# *53426E3E01EC_53426D690044_impl*
end;//TvcmChromeLikeTabbedContainerDispatcher.CheckContainer

function TvcmChromeLikeTabbedContainerDispatcher.DockableFormClass: RvcmEntityForm;
//#UC START# *53426E51002C_53426D690044_var*
//#UC END# *53426E51002C_53426D690044_var*
begin
//#UC START# *53426E51002C_53426D690044_impl*
 Result := TvcmEntityForm;
//#UC END# *53426E51002C_53426D690044_impl*
end;//TvcmChromeLikeTabbedContainerDispatcher.DockableFormClass

function TvcmChromeLikeTabbedContainerDispatcher.ContainerFormClass: RvcmChromeLikeTabbedContainerFormClass;
//#UC START# *5343B08D0229_53426D690044_var*
//#UC END# *5343B08D0229_53426D690044_var*
begin
//#UC START# *5343B08D0229_53426D690044_impl*
 Result := TTabbedContainer;
//#UC END# *5343B08D0229_53426D690044_impl*
end;//TvcmChromeLikeTabbedContainerDispatcher.ContainerFormClass
{$IfEnd} //not NoVCM

end.