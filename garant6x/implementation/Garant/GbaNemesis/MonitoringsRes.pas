unit MonitoringsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/MonitoringsRes.pas"
// Начат: 10.09.2009 17:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMApplication::Class>> F1 Утилита Прайм::Monitoring::Monitorings
//
// Мониторинги
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Monitorings) AND not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscNavigator
  {$IfEnd} //Nemesis
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  vtSizeablePanel,
  vtPanel,
  vtProportionalPanel,
  PrimMonitoringsMain_Form,
  ShellAndMonitoringsRes,
  ShellAndMonitoringsMain_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If defined(Nemesis)}
  ,
  nscStatusBar
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  MonitoringsMain_Form
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  
  {$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
  ,
  MonitoringsMainKeywordsPack
  {$IfEnd} //Monitorings AND not Admin AND not NoScripts
  ,
  vcmExternalInterfaces {a},
  SearchUnit,
  Messages,
  PostingOrder_FormDefinitions_Controls,
  eeTreeView,
  vcmMainForm {a}
  ;
{$IfEnd} //Monitorings AND not Admin

{$If defined(Monitorings) AND not defined(Admin)}
var
 { Локализуемые строки MonitoringTitle }
str_MonitoringTitle : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MonitoringTitle'; rValue : 'ГАРАНТ аэро');
 { 'ГАРАНТ аэро' }

type
TMonitoringsRes = {final} class(TShellAndMonitoringsRes)
 {* Мониторинги }
protected
   procedure RegisterFormSetFactories; override;
   class procedure RegisterModules(aMain: TvcmMainForm); override;
   procedure Loaded; override;
protected
// overridden protected methods
   class procedure DoRun(var theSplash: IUnknown); override;
 public
 // modules operations
   class function OpenPostingOrder(const aQuery: IQuery;
     const aContainer: IvcmContainer = nil): IvcmEntityForm;
   class procedure SavePostingList;
   class procedure CheckHistory;
     {* пробуем возвратиться по истории, если активна форма предварительного просмотра }
   class function StartOpen(const aContainer: IvcmContainer;
     aNewTab: Boolean): IvcmEntityForm;
   class procedure SavePostList;
     {* Сохранить индивидуальные ленты в файл }
   class function CanSavePostList: Boolean;
     {* Можно ли сохранить индивидуальные ленты в файл }
 public
 // operations codes
   class function opcode_Tree_ExpandAll : TvcmOpID;
     { Дерево -> Развернуть все }
   class function opcode_Tree_CollapseAll : TvcmOpID;
     { Дерево -> Свернуть все }
   class function opcode_Tree_Wrap : TvcmOpID;
     { Дерево -> Перенос по словам }
   class function opcode_SearchSupport_ActivatePostingsListForm : TvcmOpID;
     {  ->  }
   class function mod_opcode_CommonPost_SavePostList : TvcmMOpID;
     { Новостная лента -> Экспортировать все индивидуальные ленты в файл }
   class function opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_GetQuery : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_IsQuerySaved : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_SetQuery : TvcmOpID;
     { SearchParameters ->  }
   class function opcode_SearchParameters_ClearQuery : TvcmOpID;
     { SearchParameters ->  }
end;//TMonitoringsRes
TvcmApplicationRef = TMonitoringsRes;
 {* Ссылка на приложение для DesignTime редакторов }

{$IfEnd} //Monitorings AND not Admin

implementation

{$If defined(Monitorings) AND not defined(Admin)}
uses
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmSettings
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  moCommonPost
  {$If not defined(NoScripts)}
  ,
  tfwScriptingTypes
  {$IfEnd} //not NoScripts
  ,
  TypInfo,
  SysUtils
  {$If not defined(NoScripts)}
  ,
  tfwTypeRegistrator
  {$IfEnd} //not NoScripts
  ,
  evExtFormat,
  CommonPost_Module
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  PostingOrder_Strange_Controls,
  SearchLite_Strange_Controls
  ;
{$IfEnd} //Monitorings AND not Admin

{$If defined(Monitorings) AND not defined(Admin)}

// start class TMonitoringsRes

class procedure TMonitoringsRes.DoRun(var theSplash: IUnknown);
//#UC START# *4AA7E4DC0047_4AA9038C0387_var*
var
 l_Main : TMonitoringsMainForm;
//#UC END# *4AA7E4DC0047_4AA9038C0387_var*
begin
//#UC START# *4AA7E4DC0047_4AA9038C0387_impl*
 inherited;
 Application.CreateForm(TMonitoringsMainForm, l_Main);
//#UC END# *4AA7E4DC0047_4AA9038C0387_impl*
end;//TMonitoringsRes.DoRun

procedure TMonitoringsRes.RegisterFormSetFactories;
begin
 inherited;
end;

class procedure TMonitoringsRes.RegisterModules(aMain: TvcmMainForm);
begin
 inherited;
 aMain.RegisterModule(Tmo_CommonPost);
end;

var
 g_opcode_Tree_ExpandAll : TvcmOpID;
 g_opcode_Tree_CollapseAll : TvcmOpID;
 g_opcode_Tree_Wrap : TvcmOpID;
 g_opcode_SearchSupport_ActivatePostingsListForm : TvcmOpID;
 g_module_opcode_CommonPost_SavePostList : TvcmMOpID;
 g_opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
 g_opcode_SearchParameters_GetQuery : TvcmOpID;
 g_opcode_SearchParameters_IsQuerySaved : TvcmOpID;
 g_opcode_SearchParameters_SetQuery : TvcmOpID;
 g_opcode_SearchParameters_ClearQuery : TvcmOpID;

procedure TMonitoringsRes.Loaded;
begin
 inherited;
 PublishModule(Tmo_CommonPost, 'Файл');
 g_opcode_Tree_ExpandAll :=
  PublishOperation(en_Tree,
                    op_ExpandAll,
                    en_capTree,
                    op_capExpandAll);
 g_opcode_Tree_CollapseAll :=
  PublishOperation(en_Tree,
                    op_CollapseAll,
                    en_capTree,
                    op_capCollapseAll);
 g_opcode_Tree_Wrap :=
  PublishOperation(en_Tree,
                    op_Wrap,
                    en_capTree,
                    op_capWrap);
 g_opcode_SearchSupport_ActivatePostingsListForm :=
  PublishInternalOperation(en_SearchSupport,
                    op_ActivatePostingsListForm,
                    en_capSearchSupport,
                    op_capActivatePostingsListForm);
 PublishOperation(en_PostingToolBar,
                    op_ptNewTheme,
                    en_capPostingToolBar,
                    op_capptNewTheme, true);
 PublishOperation(en_PostingToolBar,
                    op_ptEditPosting,
                    en_capPostingToolBar,
                    op_capptEditPosting, true);
 PublishOperation(en_PostingToolBar,
                    op_ptDeletePosting,
                    en_capPostingToolBar,
                    op_capptDeletePosting, true);
 PublishOperation(en_PostingToolBar,
                    op_SavePostList,
                    en_capPostingToolBar,
                    op_capSavePostList);
 PublishOperation(en_PostingToolBar,
                    op_ExportSelected,
                    en_capPostingToolBar,
                    op_capExportSelected);
 g_module_opcode_CommonPost_SavePostList := 
  PublishModuleOperation(Tmo_CommonPost, 'SavePostList', 'Экспортировать все индивидуальные ленты в файл');
 g_opcode_SearchParameters_IsQueryEmpty :=
  PublishInternalOperation(en_SearchParameters,
                    op_IsQueryEmpty,
                    en_capSearchParameters,
                    op_capIsQueryEmpty);
 g_opcode_SearchParameters_GetQuery :=
  PublishInternalOperation(en_SearchParameters,
                    op_GetQuery,
                    en_capSearchParameters,
                    op_capGetQuery);
 g_opcode_SearchParameters_IsQuerySaved :=
  PublishInternalOperation(en_SearchParameters,
                    op_IsQuerySaved,
                    en_capSearchParameters,
                    op_capIsQuerySaved);
 g_opcode_SearchParameters_SetQuery :=
  PublishInternalOperation(en_SearchParameters,
                    op_SetQuery,
                    en_capSearchParameters,
                    op_capSetQuery);
 g_opcode_SearchParameters_ClearQuery :=
  PublishInternalOperation(en_SearchParameters,
                    op_ClearQuery,
                    en_capSearchParameters,
                    op_capClearQuery);
end;

// modules operations

class function TMonitoringsRes.OpenPostingOrder(const aQuery: IQuery;
  const aContainer: IvcmContainer = nil): IvcmEntityForm;
begin
 Result := TCommonPostModule.OpenPostingOrder(aQuery, aContainer);
end;

class procedure TMonitoringsRes.SavePostingList;
begin
 TCommonPostModule.SavePostingList;
end;

class procedure TMonitoringsRes.CheckHistory;
begin
 TCommonPostModule.CheckHistory;
end;

class function TMonitoringsRes.StartOpen(const aContainer: IvcmContainer;
  aNewTab: Boolean): IvcmEntityForm;
begin
 Result := TCommonPostModule.StartOpen(aContainer, aNewTab);
end;

class procedure TMonitoringsRes.SavePostList;
begin
 TCommonPostModule.SavePostList;
end;

class function TMonitoringsRes.CanSavePostList: Boolean;
begin
 Result := TCommonPostModule.CanSavePostList;
end;

// operations codes

class function TMonitoringsRes.opcode_Tree_ExpandAll : TvcmOpID;
begin
 Result := g_opcode_Tree_ExpandAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TMonitoringsRes.opcode_Tree_CollapseAll : TvcmOpID;
begin
 Result := g_opcode_Tree_CollapseAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TMonitoringsRes.opcode_Tree_Wrap : TvcmOpID;
begin
 Result := g_opcode_Tree_Wrap;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TMonitoringsRes.opcode_SearchSupport_ActivatePostingsListForm : TvcmOpID;
begin
 Result := g_opcode_SearchSupport_ActivatePostingsListForm;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TMonitoringsRes.mod_opcode_CommonPost_SavePostList : TvcmMOpID;
begin
 Result := g_module_opcode_CommonPost_SavePostList;
 Assert((Result.rMoID > 0) AND (Result.rOpID > 0));
end;

class function TMonitoringsRes.opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_IsQueryEmpty;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TMonitoringsRes.opcode_SearchParameters_GetQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_GetQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TMonitoringsRes.opcode_SearchParameters_IsQuerySaved : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_IsQuerySaved;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TMonitoringsRes.opcode_SearchParameters_SetQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_SetQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TMonitoringsRes.opcode_SearchParameters_ClearQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_ClearQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

{$IfEnd} //Monitorings AND not Admin

initialization
{$If defined(Monitorings) AND not defined(Admin)}
// Инициализация str_MonitoringTitle
 str_MonitoringTitle.Init;
{$IfEnd} //Monitorings AND not Admin

end.