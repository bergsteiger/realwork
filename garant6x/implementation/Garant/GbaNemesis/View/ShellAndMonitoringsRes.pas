unit ShellAndMonitoringsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ShellAndMonitoringsRes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMApplication::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::ShellAndMonitorings
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  PrimF1Res,
  PrimMainOptions_Form,
  ShellAndMonitoringsMain_Form,
  Classes {a},
  vcmInterfaces {a},
  vcmExternalInterfaces {a},
  Search_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  afwInterfaces,
  ConfigInterfaces,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtPanel,
  vtLabel
  {$If not defined(NoScripts)}
  ,
  tfwScriptingInterfaces
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  tfwControlString
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  tfwPropertyLike
  {$IfEnd} //not NoScripts
  ,
  evTextSource,
  evQueryCardEditor
  {$If defined(Nemesis)}
  ,
  nscPreviewPanel
  {$IfEnd} //Nemesis
  ,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscPageControl
  {$IfEnd} //Nemesis
  ,
  vtComboBoxQS
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtSpinEdit,
  vtCheckBox,
  vtRadioButton,
  vcmMainForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
TShellAndMonitoringsRes = {abstract} class(TPrimF1Res)
protected
   procedure RegisterFormSetFactories; override;
   class procedure RegisterModules(aMain: TvcmMainForm); override;
   procedure Loaded; override;
 public
 // modules operations
   class function MakeSaveLoadForm(const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean;
     aUserType: TvcmUserType): IvcmEntityForm;
   class function MakeQueryCardForm(aFilter: Boolean;
     const aParams: IvcmMakeParams;
     aZoneType: TvcmZoneType;
     aRecursive: Boolean;
     aUserType: TvcmUserType): IvcmEntityForm;
   class function MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
   class function MakePageSetup(const aData: InsPageSettingsInfo): Integer;
   class function MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
 public
 // operations codes
   class function opcode_Loadable_Load : TvcmOpID;
     { Это первый кандидат на превращение в Facet. Который нужно вызвать вот тут:
f_RequestingForm.Entity.Operation(op_Loadable_Load, l_Params).Done -> Коллеги, кто может описать этот метод? }
   class function opcode_Result_OkExt : TvcmOpID;
     { Результат диалога -> OK }
   class function opcode_Result_Cancel : TvcmOpID;
     { Результат диалога -> Отмена }
   class function opcode_Query_ClearAll : TvcmOpID;
     {  ->  }
   class function opcode_Query_SetList : TvcmOpID;
     {  ->  }
   class function opcode_Query_GetList : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_Add : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_Delete : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_ClearAll : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_Refresh : TvcmOpID;
     {  ->  }
   class function opcode_Filterable_GetListType : TvcmOpID;
     {  ->  }
   class function opcode_Filters_FiltersListOpen : TvcmOpID;
     {  -> Фильтры (вкладка) }
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
   class function opcode_SearchParameter_QueryNotSaved : TvcmOpID;
     {  ->  }
   class function opcode_SearchParameter_ClearMistakes : TvcmOpID;
     {  ->  }
   class function opcode_SearchParameter_QuerySaved : TvcmOpID;
     {  ->  }
   class function opcode_List_SetNewContent : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_DefaultAction : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicOr : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicAnd : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicNot : TvcmOpID;
     {  ->  }
   class function opcode_Attribute_LogicOrShortcut : TvcmOpID;
     {  ->  }
   class function opcode_File_Print : TvcmOpID;
     { Файл -> Печать }
   class function opcode_File_PrintDialog : TvcmOpID;
     { Файл -> Печать... }
   class function opcode_File_PrintPreview : TvcmOpID;
     { Файл -> Предварительный просмотр }
   class function opcode_File_Save : TvcmOpID;
     { Файл -> Сохранить }
   class function opcode_Result_Ok : TvcmOpID;
     { Результат диалога -> OK }
   class function opcode_Scalable_ChangeScale : TvcmOpID;
     { Масштабируемый объект -> Изменить масштаб }
   class function opcode_Scalable_CanChangeScale : TvcmOpID;
     { Масштабируемый объект -> Масштабирование запрещено }
   class function opcode_PrintParams_UpdatePrinter : TvcmOpID;
     {  ->  }
end;//TShellAndMonitoringsRes
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  moCommonSearch,
  tasSaveLoadRealization,
  CommonSearch_Module,
  Search_Strange_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_ResultEx_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  SearchLite_Strange_Controls
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Text_Controls
  {$IfEnd} //not NoVCM
  ,
  Search_ScalingSupport_Controls
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}

// start class TShellAndMonitoringsRes

procedure TShellAndMonitoringsRes.RegisterFormSetFactories;
begin
 inherited;
end;

class procedure TShellAndMonitoringsRes.RegisterModules(aMain: TvcmMainForm);
begin
 inherited;
 aMain.RegisterModule(Tmo_CommonSearch);
end;

var
 g_opcode_Loadable_Load : TvcmOpID;
 g_opcode_Result_OkExt : TvcmOpID;
 g_opcode_Result_Cancel : TvcmOpID;
 g_opcode_Query_ClearAll : TvcmOpID;
 g_opcode_Query_SetList : TvcmOpID;
 g_opcode_Query_GetList : TvcmOpID;
 g_opcode_Filterable_Add : TvcmOpID;
 g_opcode_Filterable_Delete : TvcmOpID;
 g_opcode_Filterable_ClearAll : TvcmOpID;
 g_opcode_Filterable_Refresh : TvcmOpID;
 g_opcode_Filterable_GetListType : TvcmOpID;
 g_opcode_Filters_FiltersListOpen : TvcmOpID;
 g_opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
 g_opcode_SearchParameters_GetQuery : TvcmOpID;
 g_opcode_SearchParameters_IsQuerySaved : TvcmOpID;
 g_opcode_SearchParameters_SetQuery : TvcmOpID;
 g_opcode_SearchParameters_ClearQuery : TvcmOpID;
 g_opcode_SearchParameter_QueryNotSaved : TvcmOpID;
 g_opcode_SearchParameter_ClearMistakes : TvcmOpID;
 g_opcode_SearchParameter_QuerySaved : TvcmOpID;
 g_opcode_List_SetNewContent : TvcmOpID;
 g_opcode_Attribute_DefaultAction : TvcmOpID;
 g_opcode_Attribute_LogicOr : TvcmOpID;
 g_opcode_Attribute_LogicAnd : TvcmOpID;
 g_opcode_Attribute_LogicNot : TvcmOpID;
 g_opcode_Attribute_LogicOrShortcut : TvcmOpID;
 g_opcode_File_Print : TvcmOpID;
 g_opcode_File_PrintDialog : TvcmOpID;
 g_opcode_File_PrintPreview : TvcmOpID;
 g_opcode_File_Save : TvcmOpID;
 g_opcode_Result_Ok : TvcmOpID;
 g_opcode_Scalable_ChangeScale : TvcmOpID;
 g_opcode_Scalable_CanChangeScale : TvcmOpID;
 g_opcode_PrintParams_UpdatePrinter : TvcmOpID;

procedure TShellAndMonitoringsRes.Loaded;
begin
 inherited;
 PublishModule(Tmo_CommonSearch, '');
 PublishOperation(en_File,
                    op_SaveToFolder,
                    en_capFile,
                    op_capSaveToFolder);
 PublishOperation(en_File,
                    op_LoadFromFolder,
                    en_capFile,
                    op_capLoadFromFolder);
 g_opcode_Loadable_Load :=
  PublishInternalOperation(en_Loadable,
                    op_Load,
                    en_capLoadable,
                    op_capLoad);
 g_opcode_Result_OkExt :=
  PublishOperation(en_Result,
                    op_OkExt,
                    en_capResult,
                    op_capOkExt);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Search') do
  begin
   st_user_Result_OkExt_Search := StateIndex;
   Caption := 'Искать';
   Hint := 'Провести поиск по выбранным параметрам';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Search')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Save') do
  begin
   st_user_Result_OkExt_Save := StateIndex;
   Caption := 'Сохранить';
   Hint := 'Сохранить';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Save')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'AttributesSelect') do
  begin
   st_user_Result_OkExt_AttributesSelect := StateIndex;
  end;//with PublishOperationState(en_Result, op_OkExt, 'AttributesSelect')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Consult') do
  begin
   st_user_Result_OkExt_Consult := StateIndex;
   Caption := 'Отправить запрос';
   ImageIndex := 154;
  end;//with PublishOperationState(en_Result, op_OkExt, 'Consult')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'Chat') do
  begin
   st_user_Result_OkExt_Chat := StateIndex;
   Caption := 'Отправить (Ctrl+Enter)';
  end;//with PublishOperationState(en_Result, op_OkExt, 'Chat')
 {$IfEnd} //not NoVCM
 {$If not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Result, op_OkExt, 'SaveAndSend') do
  begin
   st_user_Result_OkExt_SaveAndSend := StateIndex;
   Caption := 'Сохранить и отправить';
   Hint := 'Сохранить и отправить';
  end;//with PublishOperationState(en_Result, op_OkExt, 'SaveAndSend')
 {$IfEnd} //not Monitorings AND not NoVCM
 g_opcode_Result_Cancel :=
  PublishOperation(en_Result,
                    op_Cancel,
                    en_capResult,
                    op_capCancel);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Cancel, 'Close') do
  begin
   st_user_Result_Cancel_Close := StateIndex;
   Caption := 'Закрыть';
  end;//with PublishOperationState(en_Result, op_Cancel, 'Close')
 {$IfEnd} //not NoVCM
 g_opcode_Query_ClearAll :=
  PublishInternalOperation(en_Query,
                    op_ClearAll,
                    en_capQuery,
                    op_capClearAll);
 g_opcode_Query_SetList :=
  PublishInternalOperation(en_Query,
                    op_SetList,
                    en_capQuery,
                    op_capSetList);
 g_opcode_Query_GetList :=
  PublishInternalOperation(en_Query,
                    op_GetList,
                    en_capQuery,
                    op_capGetList);
 g_opcode_Filterable_Add :=
  PublishInternalOperation(en_Filterable,
                    op_Add,
                    en_capFilterable,
                    op_capAdd);
 g_opcode_Filterable_Delete :=
  PublishInternalOperation(en_Filterable,
                    op_Delete,
                    en_capFilterable,
                    op_capDelete);
 g_opcode_Filterable_ClearAll :=
  PublishInternalOperation(en_Filterable,
                    op_ClearAll,
                    en_capFilterable,
                    op_capClearAll);
 g_opcode_Filterable_Refresh :=
  PublishInternalOperation(en_Filterable,
                    op_Refresh,
                    en_capFilterable,
                    op_capRefresh);
 g_opcode_Filterable_GetListType :=
  PublishInternalOperation(en_Filterable,
                    op_GetListType,
                    en_capFilterable,
                    op_capGetListType);
 g_opcode_Filters_FiltersListOpen :=
  PublishOperation(en_Filters,
                    op_FiltersListOpen,
                    en_capFilters,
                    op_capFiltersListOpen);
 PublishOperation(en_Result,
                    op_ClearAll,
                    en_capResult,
                    op_capClearAll);
 PublishOperation(en_Query,
                    op_GetOldQuery,
                    en_capQuery,
                    op_capGetOldQuery);
 PublishOperation(en_Query,
                    op_SearchType,
                    en_capQuery,
                    op_capSearchType);
 PublishOperation(en_LogicOperation,
                    op_LogicOr,
                    en_capLogicOperation,
                    op_capLogicOr);
 PublishOperation(en_LogicOperation,
                    op_LogicAnd,
                    en_capLogicOperation,
                    op_capLogicAnd);
 PublishOperation(en_LogicOperation,
                    op_LogicNot,
                    en_capLogicOperation,
                    op_capLogicNot);
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
 g_opcode_SearchParameter_QueryNotSaved :=
  PublishInternalOperation(en_SearchParameter,
                    op_QueryNotSaved,
                    en_capSearchParameter,
                    op_capQueryNotSaved);
 g_opcode_SearchParameter_ClearMistakes :=
  PublishInternalOperation(en_SearchParameter,
                    op_ClearMistakes,
                    en_capSearchParameter,
                    op_capClearMistakes);
 g_opcode_SearchParameter_QuerySaved :=
  PublishInternalOperation(en_SearchParameter,
                    op_QuerySaved,
                    en_capSearchParameter,
                    op_capQuerySaved);
 g_opcode_List_SetNewContent :=
  PublishInternalOperation(en_List,
                    op_SetNewContent,
                    en_capList,
                    op_capSetNewContent);
 g_opcode_Attribute_DefaultAction :=
  PublishInternalOperation(en_Attribute,
                    op_DefaultAction,
                    en_capAttribute,
                    op_capDefaultAction);
 g_opcode_Attribute_LogicOr :=
  PublishOperation(en_Attribute,
                    op_LogicOr,
                    en_capAttribute,
                    op_capLogicOr);
 g_opcode_Attribute_LogicAnd :=
  PublishOperation(en_Attribute,
                    op_LogicAnd,
                    en_capAttribute,
                    op_capLogicAnd);
 g_opcode_Attribute_LogicNot :=
  PublishOperation(en_Attribute,
                    op_LogicNot,
                    en_capAttribute,
                    op_capLogicNot);
 g_opcode_Attribute_LogicOrShortcut :=
  PublishOperation(en_Attribute,
                    op_LogicOrShortcut,
                    en_capAttribute,
                    op_capLogicOrShortcut);
 PublishOperation(en_Edit,
                    op_Delete,
                    en_capEdit,
                    op_capDelete);
 {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Controlled') do
  begin
   st_user_Edit_Delete_Controlled := StateIndex;
   Caption := 'Снять с контроля';
  end;//with PublishOperationState(en_Edit, op_Delete, 'Controlled')
 {$IfEnd} //not Admin AND not Monitorings AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'User') do
  begin
   st_user_Edit_Delete_User := StateIndex;
   Caption := 'Удалить пользователя';
   ImageIndex := 149;
  end;//with PublishOperationState(en_Edit, op_Delete, 'User')
 {$IfEnd} //Admin AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'MultiUsers') do
  begin
   st_user_Edit_Delete_MultiUsers := StateIndex;
   Caption := 'Удалить выделенных пользователей';
   ImageIndex := 149;
  end;//with PublishOperationState(en_Edit, op_Delete, 'MultiUsers')
 {$IfEnd} //Admin AND not NoVCM
 {$If defined(Admin) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Group') do
  begin
   st_user_Edit_Delete_Group := StateIndex;
   Caption := 'Удалить группу';
   ImageIndex := 193;
  end;//with PublishOperationState(en_Edit, op_Delete, 'Group')
 {$IfEnd} //Admin AND not NoVCM
 {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Delete, 'Contact') do
  begin
   st_user_Edit_Delete_Contact := StateIndex;
   Caption := 'Удалить пользователя';
  end;//with PublishOperationState(en_Edit, op_Delete, 'Contact')
 {$IfEnd} //not Admin AND not Monitorings AND not NoVCM
 PublishOperation(en_Edit,
                    op_Copy,
                    en_capEdit,
                    op_capCopy);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Edit, op_Copy, 'AttributesCopy') do
  begin
   st_user_Edit_Copy_AttributesCopy := StateIndex;
   Caption := 'Копировать все атрибуты документа в буфер обмена';
  end;//with PublishOperationState(en_Edit, op_Copy, 'AttributesCopy')
 {$IfEnd} //not NoVCM
 PublishOperation(en_Edit,
                    op_Cut,
                    en_capEdit,
                    op_capCut);
 PublishOperation(en_Edit,
                    op_FindContext,
                    en_capEdit,
                    op_capFindContext);
 PublishOperation(en_Edit,
                    op_FindNext,
                    en_capEdit,
                    op_capFindNext);
 PublishOperation(en_Edit,
                    op_Paste,
                    en_capEdit,
                    op_capPaste);
 PublishOperation(en_Edit,
                    op_Undo,
                    en_capEdit,
                    op_capUndo);
 PublishOperation(en_Edit,
                    op_Redo,
                    en_capEdit,
                    op_capRedo);
 PublishOperation(en_Edit,
                    op_SelectAll,
                    en_capEdit,
                    op_capSelectAll);
 PublishOperation(en_Edit,
                    op_Deselect,
                    en_capEdit,
                    op_capDeselect);
 PublishOperation(en_Edit,
                    op_FindPrev,
                    en_capEdit,
                    op_capFindPrev);
 PublishOperation(en_SubPanelSettings,
                    op_ShowSpecial,
                    en_capSubPanelSettings,
                    op_capShowSpecial);
 PublishOperation(en_SubPanelSettings,
                    op_ShowInfo,
                    en_capSubPanelSettings,
                    op_capShowInfo);
 g_opcode_File_Print :=
  PublishOperation(en_File,
                    op_Print,
                    en_capFile,
                    op_capPrint);
 g_opcode_File_PrintDialog :=
  PublishOperation(en_File,
                    op_PrintDialog,
                    en_capFile,
                    op_capPrintDialog);
 g_opcode_File_PrintPreview :=
  PublishOperation(en_File,
                    op_PrintPreview,
                    en_capFile,
                    op_capPrintPreview);
 g_opcode_File_Save :=
  PublishOperation(en_File,
                    op_Save,
                    en_capFile,
                    op_capSave);
 PublishOperation(en_CardOperation,
                    op_ExpandCollapse,
                    en_capCardOperation,
                    op_capExpandCollapse);
 PublishOperation(en_CardOperation,
                    op_DeleteAll,
                    en_capCardOperation,
                    op_capDeleteAll);
 PublishOperation(en_CardOperation,
                    op_CreateAttr,
                    en_capCardOperation,
                    op_capCreateAttr);
 PublishOperation(en_CardOperation,
                    op_OpenTreeSelection,
                    en_capCardOperation,
                    op_capOpenTreeSelection);
 g_opcode_Result_Ok :=
  PublishOperation(en_Result,
                    op_Ok,
                    en_capResult,
                    op_capOk);
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Search') do
  begin
   st_user_Result_Ok_Search := StateIndex;
   Caption := 'Искать';
   Hint := 'Провести поиск по выбранным параметрам';
  end;//with PublishOperationState(en_Result, op_Ok, 'Search')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Print') do
  begin
   st_user_Result_Ok_Print := StateIndex;
   Caption := 'Печать';
   ImageIndex := 3;
  end;//with PublishOperationState(en_Result, op_Ok, 'Print')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'AttributesSelect') do
  begin
   st_user_Result_Ok_AttributesSelect := StateIndex;
   Caption := 'Подтвердить выбор элементов';
  end;//with PublishOperationState(en_Result, op_Ok, 'AttributesSelect')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'ConsultationMark') do
  begin
   st_user_Result_Ok_ConsultationMark := StateIndex;
   Caption := 'Оценить';
  end;//with PublishOperationState(en_Result, op_Ok, 'ConsultationMark')
 {$IfEnd} //not NoVCM
 {$If not defined(NoVCM)}
  with PublishOperationState(en_Result, op_Ok, 'Analize') do
  begin
   st_user_Result_Ok_Analize := StateIndex;
   Caption := 'Построить';
  end;//with PublishOperationState(en_Result, op_Ok, 'Analize')
 {$IfEnd} //not NoVCM
 g_opcode_Scalable_ChangeScale :=
  PublishInternalOperation(en_Scalable,
                    op_ChangeScale,
                    en_capScalable,
                    op_capChangeScale);
 g_opcode_Scalable_CanChangeScale :=
  PublishInternalOperation(en_Scalable,
                    op_CanChangeScale,
                    en_capScalable,
                    op_capCanChangeScale);
 PublishOperation(en_Preview,
                    op_ZoomIn,
                    en_capPreview,
                    op_capZoomIn);
 PublishOperation(en_Preview,
                    op_ZoomOut,
                    en_capPreview,
                    op_capZoomOut);
 PublishOperation(en_Preview,
                    op_ZoomWidth,
                    en_capPreview,
                    op_capZoomWidth);
 PublishOperation(en_Preview,
                    op_ZoomPage,
                    en_capPreview,
                    op_capZoomPage);
 PublishOperation(en_Document,
                    op_FullSelectedSwitch,
                    en_capDocument,
                    op_capFullSelectedSwitch);
 PublishOperation(en_Document,
                    op_RGBGrayscaleSwitch,
                    en_capDocument,
                    op_capRGBGrayscaleSwitch);
 PublishOperation(en_Document,
                    op_PrintInfoSwitch,
                    en_capDocument,
                    op_capPrintInfoSwitch);
 PublishOperation(en_Result,
                    op_Restore,
                    en_capResult,
                    op_capRestore);
 PublishOperation(en_Result,
                    op_SaveAsDefault,
                    en_capResult,
                    op_capSaveAsDefault);
 PublishOperation(en_ColontitulMacro,
                    op_AppTitle,
                    en_capColontitulMacro,
                    op_capAppTitle);
 PublishOperation(en_ColontitulMacro,
                    op_DocName,
                    en_capColontitulMacro,
                    op_capDocName);
 PublishOperation(en_ColontitulMacro,
                    op_DocFullName,
                    en_capColontitulMacro,
                    op_capDocFullName);
 PublishOperation(en_ColontitulMacro,
                    op_DocRedactionDate,
                    en_capColontitulMacro,
                    op_capDocRedactionDate);
 PublishOperation(en_ColontitulMacro,
                    op_DocCurrentPage,
                    en_capColontitulMacro,
                    op_capDocCurrentPage);
 PublishOperation(en_ColontitulMacro,
                    op_DocPagesCount,
                    en_capColontitulMacro,
                    op_capDocPagesCount);
 PublishOperation(en_ColontitulMacro,
                    op_CurrentDate,
                    en_capColontitulMacro,
                    op_capCurrentDate);
 PublishOperation(en_ColontitulMacro,
                    op_CurrentTime,
                    en_capColontitulMacro,
                    op_capCurrentTime);
 PublishOperation(en_ColontitulMacro,
                    op_InternalDocNumber,
                    en_capColontitulMacro,
                    op_capInternalDocNumber);
 PublishOperation(en_ColontitulMacro,
                    op_DocumentSIze,
                    en_capColontitulMacro,
                    op_capDocumentSIze);
 PublishOperation(en_ColontitulMacro,
                    op_FilePosition,
                    en_capColontitulMacro,
                    op_capFilePosition);
 g_opcode_PrintParams_UpdatePrinter :=
  PublishInternalOperation(en_PrintParams,
                    op_UpdatePrinter,
                    en_capPrintParams,
                    op_capUpdatePrinter);
end;

// modules operations

class function TShellAndMonitoringsRes.MakeSaveLoadForm(const aParams: IvcmMakeParams;
  aZoneType: TvcmZoneType;
  aRecursive: Boolean;
  aUserType: TvcmUserType): IvcmEntityForm;
begin
 Result := TCommonSearchModule.MakeSaveLoadForm(aParams, aZoneType, aRecursive, aUserType);
end;

class function TShellAndMonitoringsRes.MakeQueryCardForm(aFilter: Boolean;
  const aParams: IvcmMakeParams;
  aZoneType: TvcmZoneType;
  aRecursive: Boolean;
  aUserType: TvcmUserType): IvcmEntityForm;
begin
 Result := TCommonSearchModule.MakeQueryCardForm(aFilter, aParams, aZoneType, aRecursive, aUserType);
end;

class function TShellAndMonitoringsRes.MakePreview(const aPreview: IafwDocumentPreview): IvcmEntityForm;
begin
 Result := TCommonSearchModule.MakePreview(aPreview);
end;

class function TShellAndMonitoringsRes.MakePageSetup(const aData: InsPageSettingsInfo): Integer;
begin
 Result := TCommonSearchModule.MakePageSetup(aData);
end;

class function TShellAndMonitoringsRes.MakePrintDialog(const aPreview: IafwDocumentPreview): IvcmEntityForm;
begin
 Result := TCommonSearchModule.MakePrintDialog(aPreview);
end;

// operations codes

class function TShellAndMonitoringsRes.opcode_Loadable_Load : TvcmOpID;
begin
 Result := g_opcode_Loadable_Load;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Result_OkExt : TvcmOpID;
begin
 Result := g_opcode_Result_OkExt;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Result_Cancel : TvcmOpID;
begin
 Result := g_opcode_Result_Cancel;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Query_ClearAll : TvcmOpID;
begin
 Result := g_opcode_Query_ClearAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Query_SetList : TvcmOpID;
begin
 Result := g_opcode_Query_SetList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Query_GetList : TvcmOpID;
begin
 Result := g_opcode_Query_GetList;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Filterable_Add : TvcmOpID;
begin
 Result := g_opcode_Filterable_Add;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Filterable_Delete : TvcmOpID;
begin
 Result := g_opcode_Filterable_Delete;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Filterable_ClearAll : TvcmOpID;
begin
 Result := g_opcode_Filterable_ClearAll;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Filterable_Refresh : TvcmOpID;
begin
 Result := g_opcode_Filterable_Refresh;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Filterable_GetListType : TvcmOpID;
begin
 Result := g_opcode_Filterable_GetListType;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Filters_FiltersListOpen : TvcmOpID;
begin
 Result := g_opcode_Filters_FiltersListOpen;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_SearchParameters_IsQueryEmpty : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_IsQueryEmpty;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_SearchParameters_GetQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_GetQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_SearchParameters_IsQuerySaved : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_IsQuerySaved;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_SearchParameters_SetQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_SetQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_SearchParameters_ClearQuery : TvcmOpID;
begin
 Result := g_opcode_SearchParameters_ClearQuery;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_SearchParameter_QueryNotSaved : TvcmOpID;
begin
 Result := g_opcode_SearchParameter_QueryNotSaved;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_SearchParameter_ClearMistakes : TvcmOpID;
begin
 Result := g_opcode_SearchParameter_ClearMistakes;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_SearchParameter_QuerySaved : TvcmOpID;
begin
 Result := g_opcode_SearchParameter_QuerySaved;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_List_SetNewContent : TvcmOpID;
begin
 Result := g_opcode_List_SetNewContent;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Attribute_DefaultAction : TvcmOpID;
begin
 Result := g_opcode_Attribute_DefaultAction;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Attribute_LogicOr : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicOr;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Attribute_LogicAnd : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicAnd;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Attribute_LogicNot : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicNot;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Attribute_LogicOrShortcut : TvcmOpID;
begin
 Result := g_opcode_Attribute_LogicOrShortcut;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_File_Print : TvcmOpID;
begin
 Result := g_opcode_File_Print;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_File_PrintDialog : TvcmOpID;
begin
 Result := g_opcode_File_PrintDialog;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_File_PrintPreview : TvcmOpID;
begin
 Result := g_opcode_File_PrintPreview;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_File_Save : TvcmOpID;
begin
 Result := g_opcode_File_Save;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Result_Ok : TvcmOpID;
begin
 Result := g_opcode_Result_Ok;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Scalable_ChangeScale : TvcmOpID;
begin
 Result := g_opcode_Scalable_ChangeScale;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_Scalable_CanChangeScale : TvcmOpID;
begin
 Result := g_opcode_Scalable_CanChangeScale;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

class function TShellAndMonitoringsRes.opcode_PrintParams_UpdatePrinter : TvcmOpID;
begin
 Result := g_opcode_PrintParams_UpdatePrinter;
 Assert((Result.rEnID > 0) AND (Result.rOpID > 0));
end;

{$IfEnd} //not Admin

end.