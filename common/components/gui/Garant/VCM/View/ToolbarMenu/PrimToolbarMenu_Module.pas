unit PrimToolbarMenu_Module;

// Модуль: "w:\common\components\gui\Garant\VCM\View\ToolbarMenu\PrimToolbarMenu_Module.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "PrimToolbarMenu" MUID: (4C8E340C0148)
// Имя типа: "TPrimToolbarMenuModule"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmToolbarsInterfaces
 , vcmBaseMenuManager
 , Classes
 , vcmBase
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , vcmExternalInterfaces
 , vcmModule
;

type
 _ItemType_ = IvcmToolbarsCustomizeListener;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TIvcmToolbarsCustomizeListenerPtrList = class(_l3InterfacePtrList_)
  {* Список указателей на IvcmToolbarsCustomizeListener }
 end;//TIvcmToolbarsCustomizeListenerPtrList

 TPrimToolbarMenuModule = {abstract} class(TvcmModule, IvcmToolbarsCustomizeNotify, IvcmToolbarsCustomize)
  private
   f_MenuManager: TvcmBaseMenuManager;
  protected
   f_CustomizeVisible: Boolean;
   f_LargeIconsVisible: Boolean;
   f_Listeners: TIvcmToolbarsCustomizeListenerPtrList;
  private
   procedure opCustomizeTest(const aParams: IvcmTestParamsPrim);
    {* Настройка... }
   procedure opCustomizeExecute(const aParams: IvcmExecuteParamsPrim);
    {* Настройка... }
   {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
   procedure opAvailableOperationsTest(const aParams: IvcmTestParamsPrim);
    {* Доступные операции... }
   {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
   {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
   procedure opAvailableOperationsExecute(const aParams: IvcmExecuteParamsPrim);
    {* Доступные операции... }
   {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
   procedure opIconsSizeTest(const aParams: IvcmTestParamsPrim);
    {* Размер кнопок }
   procedure opIconsSizeExecute(const aParams: IvcmExecuteParamsPrim);
    {* Размер кнопок }
   procedure opFastenTest(const aParams: IvcmTestParamsPrim);
    {* Закрепить панели инструментов }
   procedure opFastenExecute(const aParams: IvcmExecuteParamsPrim);
    {* Закрепить панели инструментов }
  protected
   procedure DoNotify;
   procedure pmToolbarPopup(Sender: TObject);
   procedure AddListener(const aListener: IvcmToolbarsCustomizeListener);
   procedure RemoveListener(const aListener: IvcmToolbarsCustomizeListener);
   function pm_GetNotify: IvcmToolbarsCustomizeNotify;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure Loaded; override;
   class procedure GetEntityForms(aList: TvcmClassList); override;
  public
   constructor Create(AOwner: TComponent); override;
  public
   property MenuManager: TvcmBaseMenuManager
    read f_MenuManager
    write f_MenuManager;
 end;//TPrimToolbarMenuModule
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , afwFacade
 , vcmToolbarMenuRes
 , vcmMenuManager
 , vcmInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmCustomizeAvailableToolbarOps
 , vcmEntityForm
 , vcmUserControls
 , vcmMenus
 , vcmToolbar
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , CustomizeTools_Form
 //#UC START# *4C8E340C0148impl_uses*
 , StdRes
 //#UC END# *4C8E340C0148impl_uses*
;

type _Instance_R_ = TIvcmToolbarsCustomizeListenerPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}

procedure TPrimToolbarMenuModule.opCustomizeTest(const aParams: IvcmTestParamsPrim);
 {* Настройка... }
//#UC START# *4C8E3A170399_4C8E340C0148test_var*
//#UC END# *4C8E3A170399_4C8E340C0148test_var*
begin
//#UC START# *4C8E3A170399_4C8E340C0148test_impl*
 aParams.Op.Flag[vcm_ofVisible] := f_CustomizeVisible;
//#UC END# *4C8E3A170399_4C8E340C0148test_impl*
end;//TPrimToolbarMenuModule.opCustomizeTest

procedure TPrimToolbarMenuModule.opCustomizeExecute(const aParams: IvcmExecuteParamsPrim);
 {* Настройка... }
//#UC START# *4C8E3A170399_4C8E340C0148exec_var*
//#UC END# *4C8E3A170399_4C8E340C0148exec_var*
begin
//#UC START# *4C8E3A170399_4C8E340C0148exec_impl*
 DoNotify;
 {$IfNDef DesignTimeLibrary}
 TCustomizeToolsForm.Execute(MenuManager, MenuManager.ToolbarPopup.PopupComponent);
 {$EndIf DesignTimeLibrary}
//#UC END# *4C8E3A170399_4C8E340C0148exec_impl*
end;//TPrimToolbarMenuModule.opCustomizeExecute

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure TPrimToolbarMenuModule.opAvailableOperationsTest(const aParams: IvcmTestParamsPrim);
 {* Доступные операции... }
//#UC START# *4C8E3A290341_4C8E340C0148test_var*
//#UC END# *4C8E3A290341_4C8E340C0148test_var*
begin
//#UC START# *4C8E3A290341_4C8E340C0148test_impl*
 aParams.Op.Flag[vcm_ofVisible] := f_CustomizeVisible
  {$If not Defined(Nemesis) OR Defined(NewGen)}
  and
  afw.Application.IsInternal
  {$IfEnd}
  ;
//#UC END# *4C8E3A290341_4C8E340C0148test_impl*
end;//TPrimToolbarMenuModule.opAvailableOperationsTest
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
procedure TPrimToolbarMenuModule.opAvailableOperationsExecute(const aParams: IvcmExecuteParamsPrim);
 {* Доступные операции... }
//#UC START# *4C8E3A290341_4C8E340C0148exec_var*
{$IfNDef Admin}
{$IfNDef Monitorings}
var
 l_Toolbar : TComponent;
 l_Form    : IvcmEntityForm;
{$EndIf Monitorings}
{$EndIf Admin}
//#UC END# *4C8E3A290341_4C8E340C0148exec_var*
begin
//#UC START# *4C8E3A290341_4C8E340C0148exec_impl*
 {$IfNDef Admin}
 {$IfNDef Monitorings}
 l_Toolbar := MenuManager.ToolbarPopup.PopupComponent;
 while (l_Toolbar <> nil) and not (l_Toolbar is TvcmToolbarDef) do
  l_Toolbar := TControl(l_Toolbar).Parent;
 if (l_Toolbar <> nil) then
 begin
  Assert(l_Toolbar.Owner is TvcmEntityForm);
  if not Supports(l_Toolbar.Owner, IvcmEntityForm, l_Form) then
   Assert(False);
  {$IfDef Nemesis}
  TdmStdRes.CustomizePanel(TvcmCustAvailableToolbarOps.Make(l_Form));
  {$Else}
  Assert(false);
  {$EndIf Nemesis}
 end;//l_Toolbar <> nil
 {$EndIf Monitorings}
 {$EndIf Admin}
//#UC END# *4C8E3A290341_4C8E340C0148exec_impl*
end;//TPrimToolbarMenuModule.opAvailableOperationsExecute
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

procedure TPrimToolbarMenuModule.opIconsSizeTest(const aParams: IvcmTestParamsPrim);
 {* Размер кнопок }
//#UC START# *4C8E3A3E011D_4C8E340C0148test_var*
var
 l_Strings: IvcmItems;
//#UC END# *4C8E3A3E011D_4C8E340C0148test_var*
begin
//#UC START# *4C8E3A3E011D_4C8E340C0148test_impl*
 with aParams do
 begin
  Op.Flag[vcm_ofEnabled] := true;
  Op.Flag[vcm_ofVisible] := f_LargeIconsVisible;
  l_Strings := Op.SubItems;
  if (l_Strings <> nil) and
     (l_Strings.Count = 0) then
   vcmIconSizeMapHelper.FillStrings(l_Strings);
  Op.SelectedString := vcmIconSizeMap[(g_MenuManager as TvcmCustomMenuManager).GlyphSize].AsCStr;
 end;
//#UC END# *4C8E3A3E011D_4C8E340C0148test_impl*
end;//TPrimToolbarMenuModule.opIconsSizeTest

procedure TPrimToolbarMenuModule.opIconsSizeExecute(const aParams: IvcmExecuteParamsPrim);
 {* Размер кнопок }
//#UC START# *4C8E3A3E011D_4C8E340C0148exec_var*
//#UC END# *4C8E3A3E011D_4C8E340C0148exec_var*
begin
//#UC START# *4C8E3A3E011D_4C8E340C0148exec_impl*
 TvcmToolbarGlyphService.Instance.SetGlyphSize(vcmIconSizeMapHelper.DisplayNameToValue(aParams.SelectedString));
//#UC END# *4C8E3A3E011D_4C8E340C0148exec_impl*
end;//TPrimToolbarMenuModule.opIconsSizeExecute

procedure TPrimToolbarMenuModule.opFastenTest(const aParams: IvcmTestParamsPrim);
 {* Закрепить панели инструментов }
//#UC START# *4C8E3A5002FF_4C8E340C0148test_var*
//#UC END# *4C8E3A5002FF_4C8E340C0148test_var*
begin
//#UC START# *4C8E3A5002FF_4C8E340C0148test_impl*
 aParams.Op.Flag[vcm_ofChecked] := (g_MenuManager as TvcmCustomMenuManager).
  GetFastenMode;
//#UC END# *4C8E3A5002FF_4C8E340C0148test_impl*
end;//TPrimToolbarMenuModule.opFastenTest

procedure TPrimToolbarMenuModule.opFastenExecute(const aParams: IvcmExecuteParamsPrim);
 {* Закрепить панели инструментов }
//#UC START# *4C8E3A5002FF_4C8E340C0148exec_var*
//#UC END# *4C8E3A5002FF_4C8E340C0148exec_var*
begin
//#UC START# *4C8E3A5002FF_4C8E340C0148exec_impl*
 g_MenuManager.FastenToolbars;
//#UC END# *4C8E3A5002FF_4C8E340C0148exec_impl*
end;//TPrimToolbarMenuModule.opFastenExecute

procedure TPrimToolbarMenuModule.DoNotify;
//#UC START# *4C90B2F500F9_4C8E340C0148_var*
var
 l_Index: Integer;
//#UC END# *4C90B2F500F9_4C8E340C0148_var*
begin
//#UC START# *4C90B2F500F9_4C8E340C0148_impl*
 if f_Listeners <> nil then
  for l_Index := 0 to Pred(f_Listeners.Count) do
   f_Listeners.Items[l_Index].BeforeCustomize;
//#UC END# *4C90B2F500F9_4C8E340C0148_impl*
end;//TPrimToolbarMenuModule.DoNotify

procedure TPrimToolbarMenuModule.pmToolbarPopup(Sender: TObject);
//#UC START# *4C90C066016F_4C8E340C0148_var*
Var
 l_Component : TComponent;
 l_Control   : TControl;
 l_Form      : TvcmEntityForm;
 l_DocDef    : TvcmDockDef;
 l_Idx       : Integer;

 function lp_GetForm(const aControl: TControl): TvcmEntityForm;
 var
  l_Control: TControl;
 begin
  l_Control := aControl;
  Result := nil;
  if not (l_Control is TvcmDockDef) then
  begin
   while (l_Control <> nil) and not (l_Control is TvcmToolbarDef) do
    l_Control := l_Control.Parent;

   if (l_Control <> nil) and
      ((l_Control as TvcmToolbarDef).Owner <> nil) and
      ((l_Control as TvcmToolbarDef).Owner is TvcmEntityForm) then
    Result := (l_Control as TvcmToolbarDef).Owner as TvcmEntityForm;
  end;
 end;

 function lp_CalcLargeIconsVisible(const aForm: TvcmEntityForm; const aControl: TControl): Boolean;
 begin
  Result := False;
  if aControl is TvcmToolbarDef then
  begin
   with aForm.Style.Toolbars do
    case TvcmToolbarDef(aControl).Pos of
     vcm_tbpTop:
      Result := Top.ImageSize = isNone;
     vcm_tbpBottom:
      Result := Bottom.ImageSize = isNone;
     vcm_tbpLeft:
      Result := Left.ImageSize = isNone;
     vcm_tbpRight:
      Result := Right.ImageSize = isNone;
    end;//case aToolbar.DockPos of
  end;
 end;

var
 l_UserType: IvcmUserTypeDef;
//#UC END# *4C90C066016F_4C8E340C0148_var*
begin
//#UC START# *4C90C066016F_4C8E340C0148_impl*
 l_Component := MenuManager.ToolbarPopup.PopupComponent;
 f_CustomizeVisible := False;
 f_LargeIconsVisible := False;
 l_Form := nil;
 if (l_Component <> nil) and (l_Component is TControl) then
 begin
  l_Control := l_Component as TControl;
  if not (l_Control is TvcmDockDef) then
  begin
   l_Form := lp_GetForm(l_Control);
   if Assigned(l_Form) then
   begin
    l_UserType := l_Form.CurUseToolbarOfUserType;
    if (l_UserType = nil) then
     {$If not Defined(Nemesis) OR Defined(NewGen)}
     f_CustomizeVisible := true
     {$Else}
     f_CustomizeVisible := false
     {$IfEnd}
    else
     f_CustomizeVisible := TvcmUserTypeInfo.AllowCustomizeToolbars(l_UserType);
    f_LargeIconsVisible := lp_CalcLargeIconsVisible(l_Form, l_COntrol);
   end;//Assigned(l_Form)
  end//not (l_Control is TvcmDockDef)
  else
  begin
   l_DocDef := l_Control as TvcmDockDef;
   for l_Idx := 0 to l_DocDef.ControlCount - 1 do
   begin
    l_Form := lp_GetForm(l_DocDef.Controls[l_Idx]);
    if Assigned(l_Form) then
     f_LargeIconsVisible := f_LargeIconsVisible or lp_CalcLargeIconsVisible(l_Form, l_DocDef.Controls[l_Idx]);
   end;//for l_Idx
  end;//not (l_Control is TvcmDockDef)
 end;//(l_Component <> nil) and (l_Component is TControl)
//#UC END# *4C90C066016F_4C8E340C0148_impl*
end;//TPrimToolbarMenuModule.pmToolbarPopup

procedure TPrimToolbarMenuModule.AddListener(const aListener: IvcmToolbarsCustomizeListener);
//#UC START# *4992FC7A0212_4C8E340C0148_var*
//#UC END# *4992FC7A0212_4C8E340C0148_var*
begin
//#UC START# *4992FC7A0212_4C8E340C0148_impl*
 if f_Listeners = nil then
  f_Listeners := TIvcmToolbarsCustomizeListenerPtrList.Make;
 if f_Listeners.IndexOf(aListener) = -1 then
  f_Listeners.Add(aListener);
//#UC END# *4992FC7A0212_4C8E340C0148_impl*
end;//TPrimToolbarMenuModule.AddListener

procedure TPrimToolbarMenuModule.RemoveListener(const aListener: IvcmToolbarsCustomizeListener);
//#UC START# *4992FC8900E1_4C8E340C0148_var*
//#UC END# *4992FC8900E1_4C8E340C0148_var*
begin
//#UC START# *4992FC8900E1_4C8E340C0148_impl*
 if (f_Listeners <> nil) then
  f_Listeners.Remove(aListener);
//#UC END# *4992FC8900E1_4C8E340C0148_impl*
end;//TPrimToolbarMenuModule.RemoveListener

function TPrimToolbarMenuModule.pm_GetNotify: IvcmToolbarsCustomizeNotify;
//#UC START# *4992FCAD02D1_4C8E340C0148get_var*
//#UC END# *4992FCAD02D1_4C8E340C0148get_var*
begin
//#UC START# *4992FCAD02D1_4C8E340C0148get_impl*
 Result := Self;
//#UC END# *4992FCAD02D1_4C8E340C0148get_impl*
end;//TPrimToolbarMenuModule.pm_GetNotify

procedure TPrimToolbarMenuModule.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4C8E340C0148_var*
//#UC END# *479731C50290_4C8E340C0148_var*
begin
//#UC START# *479731C50290_4C8E340C0148_impl*
 FreeAndNil(f_Listeners);
 inherited;
//#UC END# *479731C50290_4C8E340C0148_impl*
end;//TPrimToolbarMenuModule.Cleanup

constructor TPrimToolbarMenuModule.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4C8E340C0148_var*
//#UC END# *47D1602000C6_4C8E340C0148_var*
begin
//#UC START# *47D1602000C6_4C8E340C0148_impl*
 inherited;
 Assert(g_ToolbarsCustomize = nil);
 g_ToolbarsCustomize := Self;
 MenuManager := g_MenuManager;
 Assert(MenuManager <> nil);
 MenuManager.ToolbarPopup.OnPopup := pmToolbarPopup;
 // Это нужно чтобы был найден группирующий элемент
 MenuManager.ToolbarPopup.Items.Caption := vcmStr(ModuleDef.ModuleDef.Caption);
 // Контекстные операции модуля
 vcmMakeModuleMenu(MenuManager.ToolbarPopup.Items,
                   ModuleDef.ModuleDef,
                   [{vcm_ooShowInContextMenu}],
                   False);
//#UC END# *47D1602000C6_4C8E340C0148_impl*
end;//TPrimToolbarMenuModule.Create

procedure TPrimToolbarMenuModule.Loaded;
begin
 inherited;
 PublishOp('opCustomize', opCustomizeExecute, opCustomizeTest);
 ShowInToolbar('opCustomize', False);
{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 PublishOp('opAvailableOperations', opAvailableOperationsExecute, opAvailableOperationsTest);
 ShowInToolbar('opAvailableOperations', False);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

 PublishOp('opIconsSize', opIconsSizeExecute, opIconsSizeTest);
 ShowInToolbar('opIconsSize', False);
 PublishOp('opFasten', opFastenExecute, opFastenTest);
 ShowInToolbar('opFasten', False);
end;//TPrimToolbarMenuModule.Loaded

class procedure TPrimToolbarMenuModule.GetEntityForms(aList: TvcmClassList);
begin
 inherited;
 aList.Add(TCustomizeToolsForm);
end;//TPrimToolbarMenuModule.GetEntityForms
{$IfEnd} // NOT Defined(NoVCM)

end.
