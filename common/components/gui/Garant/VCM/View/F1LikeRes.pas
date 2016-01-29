unit F1LikeRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/F1LikeRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMApplication::Class>> Shared Delphi F1 Like Application::F1Like::View::F1Like
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmContainerForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmMainForm
  {$IfEnd} //not NoVCM
  ,
  PresentationInterfaces
  {$If defined(Nemesis)}
  ,
  nscNavigator
  {$IfEnd} //Nemesis
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel
  {$If not defined(NoVCM)}
  ,
  OfficeLikeRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLikeMain_Form
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscStatusBar
  {$IfEnd} //Nemesis
  ,
  MainPrim_Form
  {$If not defined(NoVCM)}
  ,
  OfficeLike_System_Controls
  {$IfEnd} //not NoVCM
  ,
  F1Like_InternalOperations_Controls,
  Classes {a},
  vcmExternalInterfaces {a}
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  vcmTaskPanelInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  PrimTasksPanelMenu_Module
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmPopupMenuPrim
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  StdCtrls
  {$IfEnd} //not NoVCL
  ,
  eeTreeView,
  vtCtrls,
  eeCheckBox,
  vtGroupBox,
  vtLabel
  {$If not defined(NoVCL)}
  ,
  Buttons
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  ,
  eeButton
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  ,
  vtButton
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  ,
  F1Like_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  ,
  ElPgCtl
  {$If defined(Nemesis)}
  ,
  nscFormsPageControl
  {$IfEnd} //Nemesis
  
  ;

type
TF1LikeRes = {abstract} class(TOfficeLikeRes)
protected
   procedure RegisterFormSetFactories; override;
   class procedure RegisterModules(aMain: TvcmMainForm); override;
   procedure Loaded; override;
protected
// overridden protected methods
    {$If not defined(NoVCM)}
   class procedure MakeResources; override;
    {$IfEnd} //not NoVCM
 public
 // modules operations
    {$If not defined(NoVCM)}
   class procedure CustomizePanel(const aPanel: IvcmCustOps);
     {* Настроить панель иструментов }
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   class function TasksPanelPopupMenu: TPopupMenu;
    {$IfEnd} //not NoVCM
   class function MakeChild(aMainForm: TvcmMainForm;
     anOwner: TvcmEntityForm): IvcmEntityForm;
   class function MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
 public
 // operations codes
   class function opcode_Common_ShowSplitter : TvcmOpID;
     {  ->  }
   class function opcode_Common_CheckChildZone : TvcmOpID;
     {  ->  }
   class function mod_opcode_TasksPanelMenu_Customize : TvcmMOpID;
     {  -> Настройка... }
   class function opcode_Switcher_BecomeActive : TvcmOpID;
     { Сущность для управления закладками формы-контейнера ->  }
   class function opcode_Switcher_SetFirstPageActive : TvcmOpID;
     { Сущность для управления закладками формы-контейнера ->  }
end;//TF1LikeRes

implementation

uses
  Graphics
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCM)}
  ,
  nsWindowsList
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  afwFacade,
  Windows,
  SysUtils
  {$If not defined(NoVCM)}
  ,
  OfficeLikeAppInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3String,
  nsFormUtils,
  nsSettingsConst
  {$If not defined(NoVCM)}
  ,
  vcmHistory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vtNavigator
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  vcmBase {a},
  StdRes {a}
  {$If not defined(NoVCM)}
  ,
  moTasksPanelMenu
  {$IfEnd} //not NoVCM
  ,
  moParentAndChild,
  vtStdRes,
  ParentAndChildPrim_Module
  ;

// start class TF1LikeRes

{$If not defined(NoVCM)}
class procedure TF1LikeRes.MakeResources;
//#UC START# *4F6AF5F00058_4F6B607F027E_var*
//#UC END# *4F6AF5F00058_4F6B607F027E_var*
begin
//#UC START# *4F6AF5F00058_4F6B607F027E_impl*
 Application.CreateForm(TvtStdResources, vtStdResources);
//#UC END# *4F6AF5F00058_4F6B607F027E_impl*
end;//TF1LikeRes.MakeResources
{$IfEnd} //not NoVCM

procedure TF1LikeRes.RegisterFormSetFactories;
begin
 inherited;
end;

class procedure TF1LikeRes.RegisterModules(aMain: TvcmMainForm);
begin
 inherited;
 {$If not defined(NoVCM)}
 aMain.RegisterModule(Tmo_TasksPanelMenu);
 {$IfEnd} //not NoVCM
 aMain.RegisterModule(Tmo_ParentAndChild);
end;

var
 g_opcode_Common_ShowSplitter : TvcmOpID;
 g_opcode_Common_CheckChildZone : TvcmOpID;
 g_module_opcode_TasksPanelMenu_Customize : TvcmMOpID;
 g_opcode_Switcher_BecomeActive : TvcmOpID;
 g_opcode_Switcher_SetFirstPageActive : TvcmOpID;

procedure TF1LikeRes.Loaded;
begin
 inherited;
 {$If not defined(NoVCM)}
 PublishModule(Tmo_TasksPanelMenu, 'Настройка панели задач');
 {$IfEnd} //not NoVCM
 PublishModule(Tmo_ParentAndChild, 'Поддержка работы с родительской и дочерней зонами');
 g_opcode_Common_ShowSplitter :=
  PublishInternalOperation(en_Common,
                    op_ShowSplitter,
                    en_capCommon,
                    op_capShowSplitter);
 g_opcode_Common_CheckChildZone :=
  PublishInternalOperation(en_Common,
                    op_CheckChildZone,
                    en_capCommon,
                    op_capCheckChildZone);
 PublishOperation(en_Common,
                    op_OpenNewWindowByUser,
                    en_capCommon,
                    op_capOpenNewWindowByUser);
 PublishOperation(en_Common,
                    op_GetWindowList,
                    en_capCommon,
                    op_capGetWindowList);
 PublishOperation(en_Common,
                    op_CascadeWindows,
                    en_capCommon,
                    op_capCascadeWindows);
 PublishOperation(en_Common,
                    op_TileWindowsHorizontal,
                    en_capCommon,
                    op_capTileWindowsHorizontal);
 PublishOperation(en_Common,
                    op_TileWindowsVertical,
                    en_capCommon,
                    op_capTileWindowsVertical);
 PublishOperation(en_Common,
                    op_CloseAllWindows,
                    en_capCommon,
                    op_capCloseAllWindows);
 g_module_opcode_TasksPanelMenu_Customize := 
  PublishModuleOperation(Tmo_TasksPanelMenu, 'Customize', 'Настройка...');
 g_opcode_Switcher_BecomeActive :=
  PublishInternalOperation(en_Switcher,
                    op_BecomeActive,
                    en_capSwitcher,
                    op_capBecomeActive);
 g_opcode_Switcher_SetFirstPageActive :=
  PublishInternalOperation(en_Switcher,
                    op_SetFirstPageActive,
                    en_capSwitcher,
                    op_capSetFirstPageActive);
end;

// modules operations

{$If not defined(NoVCM)}
class procedure TF1LikeRes.CustomizePanel(const aPanel: IvcmCustOps);
begin
 TPrimTasksPanelMenuModule.CustomizePanel(aPanel);
end;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
class function TF1LikeRes.TasksPanelPopupMenu: TPopupMenu;
begin
 Result := TPrimTasksPanelMenuModule.TasksPanelPopupMenu;
end;
{$IfEnd} //not NoVCM

class function TF1LikeRes.MakeChild(aMainForm: TvcmMainForm;
  anOwner: TvcmEntityForm): IvcmEntityForm;
begin
 Result := TParentAndChildPrimModule.MakeChild(aMainForm, anOwner);
end;

class function TF1LikeRes.MakeParent(aMainForm: TvcmMainForm): IvcmEntityForm;
begin
 Result := TParentAndChildPrimModule.MakeParent(aMainForm);
end;

// operations codes

class function TF1LikeRes.opcode_Common_ShowSplitter : TvcmOpID;
begin
 Result := g_opcode_Common_ShowSplitter;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TF1LikeRes.opcode_Common_CheckChildZone : TvcmOpID;
begin
 Result := g_opcode_Common_CheckChildZone;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TF1LikeRes.mod_opcode_TasksPanelMenu_Customize : TvcmMOpID;
begin
 Result := g_module_opcode_TasksPanelMenu_Customize;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TF1LikeRes.opcode_Switcher_BecomeActive : TvcmOpID;
begin
 Result := g_opcode_Switcher_BecomeActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TF1LikeRes.opcode_Switcher_SetFirstPageActive : TvcmOpID;
begin
 Result := g_opcode_Switcher_SetFirstPageActive;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

end.