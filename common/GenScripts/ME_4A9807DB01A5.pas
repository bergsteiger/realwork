unit Base_Operations_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4A9807DB01A5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsTypes
 , PrimPrimListInterfaces
 , DocumentAndListInterfaces
 , l3Tree_TLB
 , FoldersUnit
 , Base_Operations_Editions_Controls
 , DocumentUnit
 , l3TreeInterfaces
 , l3Variant
 , eeInterfaces
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 // Switcher

 // Document

 // SynchroView

 // List

 // Form

 // ControlCenter

 // ListInfo

 // Filters

 // LocalList

 // TimeMachine

 // Filter

 // Document

 // Document

 // Document

 // FoldersControl

 // SavedQuery

 // Filters

 // Openable

 // HyperLink

 // Document

 Op_Switcher_BecomeActive = class
  {* Класс для вызова операции Switcher.BecomeActive }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у контейнера }
 end;//Op_Switcher_BecomeActive

 IDocument_FindExplanation_Params = interface
  {* Параметры для операции Document.FindExplanation }
  ['{8B8A058F-947B-4C90-BB9F-5B2B796F50AC}']
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_FindExplanation_Params

 Op_Document_FindExplanation = class
  {* Класс для вызова операции Document.FindExplanation }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Document.FindExplanation у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Document.FindExplanation у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Document.FindExplanation у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Document.FindExplanation у контейнера }
 end;//Op_Document_FindExplanation

 ISynchroView_BecomeActive_Params = interface
  {* Параметры для операции SynchroView.BecomeActive }
  ['{3BB24691-729B-4397-B6DE-0BF962098112}']
  function Get_FormType: TnsShowSynchroForm;
  property FormType: TnsShowSynchroForm
   read Get_FormType;
 end;//ISynchroView_BecomeActive_Params

 Op_SynchroView_BecomeActive = class
  {* Класс для вызова операции SynchroView.BecomeActive }
  public
   class function Call(const aTarget: IvcmEntity;
    aFormType: TnsShowSynchroForm): Boolean; overload;
    {* Вызов операции SynchroView.BecomeActive у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aFormType: TnsShowSynchroForm): Boolean; overload;
    {* Вызов операции SynchroView.BecomeActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aFormType: TnsShowSynchroForm): Boolean; overload;
    {* Вызов операции SynchroView.BecomeActive у формы }
   class function Call(const aTarget: IvcmContainer;
    aFormType: TnsShowSynchroForm): Boolean; overload;
    {* Вызов операции SynchroView.BecomeActive у контейнера }
 end;//Op_SynchroView_BecomeActive

 IList_GetDeList_Params = interface
  {* Параметры для операции List.GetDeList }
  ['{594B710D-806D-4665-B11A-5E5B64970040}']
  function Get_ResultValue: IdeList;
  procedure Set_ResultValue(const aValue: IdeList);
  property ResultValue: IdeList
   read Get_ResultValue
   write Set_ResultValue;
 end;//IList_GetDeList_Params

 Op_List_GetDeList = class
  {* Класс для вызова операции List.GetDeList }
  public
   class function Call(const aTarget: IvcmEntity): IdeList; overload;
    {* Вызов операции List.GetDeList у сущности }
   class function Call(const aTarget: IvcmAggregate): IdeList; overload;
    {* Вызов операции List.GetDeList у агрегации }
   class function Call(const aTarget: IvcmEntityForm): IdeList; overload;
    {* Вызов операции List.GetDeList у формы }
   class function Call(const aTarget: IvcmContainer): IdeList; overload;
    {* Вызов операции List.GetDeList у контейнера }
 end;//Op_List_GetDeList

 Op_List_SetCurrentVisible = class
  {* Класс для вызова операции List.SetCurrentVisible }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции List.SetCurrentVisible у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции List.SetCurrentVisible у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции List.SetCurrentVisible у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции List.SetCurrentVisible у контейнера }
 end;//Op_List_SetCurrentVisible

 IList_GetDsList_Params = interface
  {* Параметры для операции List.GetDsList }
  ['{258110DB-5E97-4517-BDA9-A18D4A0D11E4}']
  function Get_ResultValue: IdsList;
  procedure Set_ResultValue(const aValue: IdsList);
  property ResultValue: IdsList
   read Get_ResultValue
   write Set_ResultValue;
 end;//IList_GetDsList_Params

 Op_List_GetDsList = class
  {* Класс для вызова операции List.GetDsList }
  public
   class function Call(const aTarget: IvcmEntity): IdsList; overload;
    {* Вызов операции List.GetDsList у сущности }
   class function Call(const aTarget: IvcmAggregate): IdsList; overload;
    {* Вызов операции List.GetDsList у агрегации }
   class function Call(const aTarget: IvcmEntityForm): IdsList; overload;
    {* Вызов операции List.GetDsList у формы }
   class function Call(const aTarget: IvcmContainer): IdsList; overload;
    {* Вызов операции List.GetDsList у контейнера }
 end;//Op_List_GetDsList

 Op_Form_RequestClose = class
  {* Класс для вызова операции Form.RequestClose }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Form.RequestClose у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Form.RequestClose у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Form.RequestClose у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Form.RequestClose у контейнера }
 end;//Op_Form_RequestClose

 Op_ControlCenter_Refresh = class
  {* Класс для вызова операции ControlCenter.Refresh }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции ControlCenter.Refresh у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции ControlCenter.Refresh у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции ControlCenter.Refresh у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции ControlCenter.Refresh у контейнера }
 end;//Op_ControlCenter_Refresh

 Op_ListInfo_BecomeActive = class
  {* Класс для вызова операции ListInfo.BecomeActive }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции ListInfo.BecomeActive у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции ListInfo.BecomeActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции ListInfo.BecomeActive у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции ListInfo.BecomeActive у контейнера }
 end;//Op_ListInfo_BecomeActive

 Op_Filters_DeselectAll = class
  {* Класс для вызова операции Filters.DeselectAll }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Filters.DeselectAll у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Filters.DeselectAll у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Filters.DeselectAll у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Filters.DeselectAll у контейнера }
 end;//Op_Filters_DeselectAll

 Op_TimeMachine_TimeMachineOnOff = class
  {* Класс для вызова операции TimeMachine.TimeMachineOnOff }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции TimeMachine.TimeMachineOnOff у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции TimeMachine.TimeMachineOnOff у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции TimeMachine.TimeMachineOnOff у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции TimeMachine.TimeMachineOnOff у контейнера }
 end;//Op_TimeMachine_TimeMachineOnOff

 Op_TimeMachine_TimeMachineOffAndReset = class
  {* Класс для вызова операции TimeMachine.TimeMachineOffAndReset }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции TimeMachine.TimeMachineOffAndReset у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции TimeMachine.TimeMachineOffAndReset у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции TimeMachine.TimeMachineOffAndReset у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции TimeMachine.TimeMachineOffAndReset у контейнера }
 end;//Op_TimeMachine_TimeMachineOffAndReset

 IFilter_ActivateNode_Params = interface
  {* Параметры для операции Filter.ActivateNode }
  ['{E3E0E2F3-EF0C-4767-98C0-599417EC94A6}']
  function Get_Node: Il3Node;
  property Node: Il3Node
   read Get_Node;
 end;//IFilter_ActivateNode_Params

 Op_Filter_ActivateNode = class
  {* Класс для вызова операции Filter.ActivateNode }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3Node): Boolean; overload;
    {* Вызов операции Filter.ActivateNode у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3Node): Boolean; overload;
    {* Вызов операции Filter.ActivateNode у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3Node): Boolean; overload;
    {* Вызов операции Filter.ActivateNode у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3Node): Boolean; overload;
    {* Вызов операции Filter.ActivateNode у контейнера }
 end;//Op_Filter_ActivateNode

 IFoldersControl_EditElement_Params = interface
  {* Параметры для операции FoldersControl.EditElement }
  ['{682C1E2B-52F6-4A61-B374-34071EEC36D6}']
  function Get_Node: IFoldersNode;
  property Node: IFoldersNode
   read Get_Node;
 end;//IFoldersControl_EditElement_Params

 Op_FoldersControl_EditElement = class
  {* Класс для вызова операции FoldersControl.EditElement }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode): Boolean; overload;
    {* Вызов операции FoldersControl.EditElement у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode): Boolean; overload;
    {* Вызов операции FoldersControl.EditElement у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode): Boolean; overload;
    {* Вызов операции FoldersControl.EditElement у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode): Boolean; overload;
    {* Вызов операции FoldersControl.EditElement у контейнера }
 end;//Op_FoldersControl_EditElement

 IFoldersControl_DeleteElement_Params = interface
  {* Параметры для операции FoldersControl.DeleteElement }
  ['{313EBF22-91AD-42F6-BB73-D24B8BB42D36}']
  function Get_Node: IFoldersNode;
  function Get_ResultValue: TnsDeleteResult;
  procedure Set_ResultValue(aValue: TnsDeleteResult);
  property Node: IFoldersNode
   read Get_Node;
  property ResultValue: TnsDeleteResult
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFoldersControl_DeleteElement_Params

 Op_FoldersControl_DeleteElement = class
  {* Класс для вызова операции FoldersControl.DeleteElement }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode): TnsDeleteResult; overload;
    {* Вызов операции FoldersControl.DeleteElement у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode): TnsDeleteResult; overload;
    {* Вызов операции FoldersControl.DeleteElement у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode): TnsDeleteResult; overload;
    {* Вызов операции FoldersControl.DeleteElement у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode): TnsDeleteResult; overload;
    {* Вызов операции FoldersControl.DeleteElement у контейнера }
 end;//Op_FoldersControl_DeleteElement

 Op_Filters_InternalClear = class
  {* Класс для вызова операции Filters.InternalClear }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Filters.InternalClear у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Filters.InternalClear у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Filters.InternalClear у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Filters.InternalClear у контейнера }
 end;//Op_Filters_InternalClear

 IDocument_SetActive_Params = interface
  {* Параметры для операции Document.SetActive }
  ['{3581EB51-413B-4637-81C0-F840C8EC364A}']
  function Get_UserType: Integer;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_SetActive_Params

 Op_Document_SetActive = class
  {* Класс для вызова операции Document.SetActive }
  public
   class function Call(const aTarget: IvcmEntity;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.SetActive у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.SetActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.SetActive у формы }
   class function Call(const aTarget: IvcmContainer;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.SetActive у контейнера }
 end;//Op_Document_SetActive

 IDocument_ExportBlock_Params = interface
  {* Параметры для операции Document.ExportBlock }
  ['{9AF9E8FC-873B-47B5-A51E-0FD3D5EEA3B7}']
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  function Get_ToActiveWindow: Boolean;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
  property ToActiveWindow: Boolean
   read Get_ToActiveWindow;
 end;//IDocument_ExportBlock_Params

 Op_Document_ExportBlock = class
  {* Класс для вызова операции Document.ExportBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): Boolean; overload;
    {* Вызов операции Document.ExportBlock у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): Boolean; overload;
    {* Вызов операции Document.ExportBlock у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): Boolean; overload;
    {* Вызов операции Document.ExportBlock у формы }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): Boolean; overload;
    {* Вызов операции Document.ExportBlock у контейнера }
 end;//Op_Document_ExportBlock

 IDocument_GetCurrentPosition_Params = interface
  {* Параметры для операции Document.GetCurrentPosition }
  ['{7D1695A8-37A2-4985-9E18-3E4138FC3C97}']
  function Get_ResultValue: Integer;
  procedure Set_ResultValue(aValue: Integer);
  property ResultValue: Integer
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_GetCurrentPosition_Params

 Op_Document_GetCurrentPosition = class
  {* Класс для вызова операции Document.GetCurrentPosition }
  public
   class function Call(const aTarget: IvcmEntity): Integer; overload;
    {* Вызов операции Document.GetCurrentPosition у сущности }
   class function Call(const aTarget: IvcmAggregate): Integer; overload;
    {* Вызов операции Document.GetCurrentPosition у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Integer; overload;
    {* Вызов операции Document.GetCurrentPosition у формы }
   class function Call(const aTarget: IvcmContainer): Integer; overload;
    {* Вызов операции Document.GetCurrentPosition у контейнера }
 end;//Op_Document_GetCurrentPosition

 IDocument_SelectBlock_Params = interface
  {* Параметры для операции Document.SelectBlock }
  ['{FCF56E5C-2AA5-4757-9196-D3EA3F24C9FF}']
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_SelectBlock_Params

 Op_Document_SelectBlock = class
  {* Класс для вызова операции Document.SelectBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.SelectBlock у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.SelectBlock у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.SelectBlock у формы }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.SelectBlock у контейнера }
 end;//Op_Document_SelectBlock

 IDocument_CopyBlock_Params = interface
  {* Параметры для операции Document.CopyBlock }
  ['{9EA76DAC-BC9D-4F5B-8530-0F9C1154B1AC}']
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_CopyBlock_Params

 Op_Document_CopyBlock = class
  {* Класс для вызова операции Document.CopyBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CopyBlock у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CopyBlock у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CopyBlock у формы }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.CopyBlock у контейнера }
 end;//Op_Document_CopyBlock

 IDocument_PrintBlock_Params = interface
  {* Параметры для операции Document.PrintBlock }
  ['{5E6995F2-F326-463E-BE47-1194545BA317}']
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_PrintBlock_Params

 Op_Document_PrintBlock = class
  {* Класс для вызова операции Document.PrintBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PrintBlock у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PrintBlock у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PrintBlock у формы }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PrintBlock у контейнера }
 end;//Op_Document_PrintBlock

 IDocument_PrintDialogBlock_Params = interface
  {* Параметры для операции Document.PrintDialogBlock }
  ['{B65A341B-4D6B-4B63-A3FE-231558FCCBD9}']
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_PrintDialogBlock_Params

 Op_Document_PrintDialogBlock = class
  {* Класс для вызова операции Document.PrintDialogBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PrintDialogBlock у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PrintDialogBlock у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PrintDialogBlock у формы }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PrintDialogBlock у контейнера }
 end;//Op_Document_PrintDialogBlock

 IDocument_PreviewBlock_Params = interface
  {* Параметры для операции Document.PreviewBlock }
  ['{D59D84E3-3E27-4BB2-9F31-75990AD0A666}']
  function Get_Data: IUnknown;
  function Get_UserType: Integer;
  property Data: IUnknown
   read Get_Data;
  property UserType: Integer
   read Get_UserType;
 end;//IDocument_PreviewBlock_Params

 Op_Document_PreviewBlock = class
  {* Класс для вызова операции Document.PreviewBlock }
  public
   class function Call(const aTarget: IvcmEntity;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PreviewBlock у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PreviewBlock у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PreviewBlock у формы }
   class function Call(const aTarget: IvcmContainer;
    const aData: IUnknown;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.PreviewBlock у контейнера }
 end;//Op_Document_PreviewBlock

 IDocument_ShowRespondentListToPart_Params = interface
  {* Параметры для операции Document.ShowRespondentListToPart }
  ['{B7C75BB4-D502-4444-8B45-CB10A63D188C}']
  function Get_List: IPositionList;
  function Get_Current: Il3SimpleNode;
  property List: IPositionList
   read Get_List;
  property Current: Il3SimpleNode
   read Get_Current;
 end;//IDocument_ShowRespondentListToPart_Params

 Op_Document_ShowRespondentListToPart = class
  {* Класс для вызова операции Document.ShowRespondentListToPart }
  public
   class function Call(const aTarget: IvcmEntity;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* Вызов операции Document.ShowRespondentListToPart у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* Вызов операции Document.ShowRespondentListToPart у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* Вызов операции Document.ShowRespondentListToPart у формы }
   class function Call(const aTarget: IvcmContainer;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* Вызов операции Document.ShowRespondentListToPart у контейнера }
 end;//Op_Document_ShowRespondentListToPart

 IDocument_ShowCorrespondentListToPart_Params = interface
  {* Параметры для операции Document.ShowCorrespondentListToPart }
  ['{7755207C-D538-4CEA-9F44-21805F093FD9}']
  function Get_List: IPositionList;
  function Get_Current: Il3SimpleNode;
  property List: IPositionList
   read Get_List;
  property Current: Il3SimpleNode
   read Get_Current;
 end;//IDocument_ShowCorrespondentListToPart_Params

 Op_Document_ShowCorrespondentListToPart = class
  {* Класс для вызова операции Document.ShowCorrespondentListToPart }
  public
   class function Call(const aTarget: IvcmEntity;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* Вызов операции Document.ShowCorrespondentListToPart у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* Вызов операции Document.ShowCorrespondentListToPart у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* Вызов операции Document.ShowCorrespondentListToPart у формы }
   class function Call(const aTarget: IvcmContainer;
    const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil): Boolean; overload;
    {* Вызов операции Document.ShowCorrespondentListToPart у контейнера }
 end;//Op_Document_ShowCorrespondentListToPart

 IDocument_ModifyBookmarkNotify_Params = interface
  {* Параметры для операции Document.ModifyBookmarkNotify }
  ['{5B6A8FFB-0A43-4A49-9D62-2ECF573D4A86}']
  function Get_nEntity: IUnknown;
  property nEntity: IUnknown
   read Get_nEntity;
 end;//IDocument_ModifyBookmarkNotify_Params

 Op_Document_ModifyBookmarkNotify = class
  {* Класс для вызова операции Document.ModifyBookmarkNotify }
  public
   class function Call(const aTarget: IvcmEntity;
    const anEntity: IUnknown): Boolean; overload;
    {* Вызов операции Document.ModifyBookmarkNotify у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const anEntity: IUnknown): Boolean; overload;
    {* Вызов операции Document.ModifyBookmarkNotify у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const anEntity: IUnknown): Boolean; overload;
    {* Вызов операции Document.ModifyBookmarkNotify у формы }
   class function Call(const aTarget: IvcmContainer;
    const anEntity: IUnknown): Boolean; overload;
    {* Вызов операции Document.ModifyBookmarkNotify у контейнера }
   class procedure Broadcast(const anEntity: IUnknown);
    {* Вызов операции Document.ModifyBookmarkNotify у всех зарегистрированных сущностей }
 end;//Op_Document_ModifyBookmarkNotify

 IDocument_AddBookmarkFromContents_Params = interface
  {* Параметры для операции Document.AddBookmarkFromContents }
  ['{4A7CB4C7-90B2-4C22-82DC-C4A0564E367D}']
  function Get_Tag: Il3TagRef;
  property Tag: Il3TagRef
   read Get_Tag;
 end;//IDocument_AddBookmarkFromContents_Params

 Op_Document_AddBookmarkFromContents = class
  {* Класс для вызова операции Document.AddBookmarkFromContents }
  public
   class function Call(const aTarget: IvcmEntity;
    const aTag: Il3TagRef): Boolean; overload;
    {* Вызов операции Document.AddBookmarkFromContents у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aTag: Il3TagRef): Boolean; overload;
    {* Вызов операции Document.AddBookmarkFromContents у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aTag: Il3TagRef): Boolean; overload;
    {* Вызов операции Document.AddBookmarkFromContents у формы }
   class function Call(const aTarget: IvcmContainer;
    const aTag: Il3TagRef): Boolean; overload;
    {* Вызов операции Document.AddBookmarkFromContents у контейнера }
 end;//Op_Document_AddBookmarkFromContents

 Op_Document_OpenNotSureTopic = class
  {* Класс для вызова операции Document.OpenNotSureTopic }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Document.OpenNotSureTopic у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Document.OpenNotSureTopic у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Document.OpenNotSureTopic у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Document.OpenNotSureTopic у контейнера }
 end;//Op_Document_OpenNotSureTopic

 IDocument_GotoPara_Params = interface
  {* Параметры для операции Document.GotoPara }
  ['{AF708270-4305-4154-A05E-5A3ACA0A0E13}']
  function Get_Para: Il3TagRef;
  function Get_UserType: Integer;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Para: Il3TagRef
   read Get_Para;
  property UserType: Integer
   read Get_UserType;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IDocument_GotoPara_Params

 Op_Document_GotoPara = class
  {* Класс для вызова операции Document.GotoPara }
  public
   class function Call(const aTarget: IvcmEntity;
    const aPara: Il3TagRef;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.GotoPara у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aPara: Il3TagRef;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.GotoPara у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aPara: Il3TagRef;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.GotoPara у формы }
   class function Call(const aTarget: IvcmContainer;
    const aPara: Il3TagRef;
    aUserType: Integer): Boolean; overload;
    {* Вызов операции Document.GotoPara у контейнера }
 end;//Op_Document_GotoPara
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TDocument_FindExplanation_Params = class(Tl3CProtoObject, IDocument_FindExplanation_Params)
  {* Реализация IDocument_FindExplanation_Params }
  private
   f_ResultValue: Boolean;
  protected
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create; reintroduce;
    {* Конструктор TDocument_FindExplanation_Params }
   class function Make: IDocument_FindExplanation_Params; reintroduce;
    {* Фабрика TDocument_FindExplanation_Params }
 end;//TDocument_FindExplanation_Params

 TSynchroView_BecomeActive_Params = class(Tl3CProtoObject, ISynchroView_BecomeActive_Params)
  {* Реализация ISynchroView_BecomeActive_Params }
  private
   f_FormType: TnsShowSynchroForm;
  protected
   function Get_FormType: TnsShowSynchroForm;
  public
   constructor Create(aFormType: TnsShowSynchroForm); reintroduce;
    {* Конструктор TSynchroView_BecomeActive_Params }
   class function Make(aFormType: TnsShowSynchroForm): ISynchroView_BecomeActive_Params; reintroduce;
    {* Фабрика TSynchroView_BecomeActive_Params }
 end;//TSynchroView_BecomeActive_Params

 TList_GetDeList_Params = class(Tl3CProtoObject, IList_GetDeList_Params)
  {* Реализация IList_GetDeList_Params }
  private
   f_ResultValue: IdeList;
  protected
   function Get_ResultValue: IdeList;
   procedure Set_ResultValue(const aValue: IdeList);
   procedure ClearFields; override;
  public
   constructor Create; reintroduce;
    {* Конструктор TList_GetDeList_Params }
   class function Make: IList_GetDeList_Params; reintroduce;
    {* Фабрика TList_GetDeList_Params }
 end;//TList_GetDeList_Params

 TList_GetDsList_Params = class(Tl3CProtoObject, IList_GetDsList_Params)
  {* Реализация IList_GetDsList_Params }
  private
   f_ResultValue: IdsList;
  protected
   function Get_ResultValue: IdsList;
   procedure Set_ResultValue(const aValue: IdsList);
   procedure ClearFields; override;
  public
   constructor Create; reintroduce;
    {* Конструктор TList_GetDsList_Params }
   class function Make: IList_GetDsList_Params; reintroduce;
    {* Фабрика TList_GetDsList_Params }
 end;//TList_GetDsList_Params

 TFilter_ActivateNode_Params = class(Tl3CProtoObject, IFilter_ActivateNode_Params)
  {* Реализация IFilter_ActivateNode_Params }
  private
   f_Node: Il3Node;
  protected
   function Get_Node: Il3Node;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3Node); reintroduce;
    {* Конструктор TFilter_ActivateNode_Params }
   class function Make(const aNode: Il3Node): IFilter_ActivateNode_Params; reintroduce;
    {* Фабрика TFilter_ActivateNode_Params }
 end;//TFilter_ActivateNode_Params

 TFoldersControl_EditElement_Params = class(Tl3CProtoObject, IFoldersControl_EditElement_Params)
  {* Реализация IFoldersControl_EditElement_Params }
  private
   f_Node: IFoldersNode;
  protected
   function Get_Node: IFoldersNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IFoldersNode); reintroduce;
    {* Конструктор TFoldersControl_EditElement_Params }
   class function Make(const aNode: IFoldersNode): IFoldersControl_EditElement_Params; reintroduce;
    {* Фабрика TFoldersControl_EditElement_Params }
 end;//TFoldersControl_EditElement_Params

 TFoldersControl_DeleteElement_Params = class(Tl3CProtoObject, IFoldersControl_DeleteElement_Params)
  {* Реализация IFoldersControl_DeleteElement_Params }
  private
   f_Node: IFoldersNode;
   f_ResultValue: TnsDeleteResult;
  protected
   function Get_ResultValue: TnsDeleteResult;
   procedure Set_ResultValue(aValue: TnsDeleteResult);
   function Get_Node: IFoldersNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IFoldersNode); reintroduce;
    {* Конструктор TFoldersControl_DeleteElement_Params }
   class function Make(const aNode: IFoldersNode): IFoldersControl_DeleteElement_Params; reintroduce;
    {* Фабрика TFoldersControl_DeleteElement_Params }
 end;//TFoldersControl_DeleteElement_Params

 TDocument_SetActive_Params = class(Tl3CProtoObject, IDocument_SetActive_Params)
  {* Реализация IDocument_SetActive_Params }
  private
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
  public
   constructor Create(aUserType: Integer); reintroduce;
    {* Конструктор TDocument_SetActive_Params }
   class function Make(aUserType: Integer): IDocument_SetActive_Params; reintroduce;
    {* Фабрика TDocument_SetActive_Params }
 end;//TDocument_SetActive_Params

 TDocument_ExportBlock_Params = class(Tl3CProtoObject, IDocument_ExportBlock_Params)
  {* Реализация IDocument_ExportBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
   f_ToActiveWindow: Boolean;
  protected
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   function Get_ToActiveWindow: Boolean;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean); reintroduce;
    {* Конструктор TDocument_ExportBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): IDocument_ExportBlock_Params; reintroduce;
    {* Фабрика TDocument_ExportBlock_Params }
 end;//TDocument_ExportBlock_Params

 TDocument_GetCurrentPosition_Params = class(Tl3CProtoObject, IDocument_GetCurrentPosition_Params)
  {* Реализация IDocument_GetCurrentPosition_Params }
  private
   f_ResultValue: Integer;
  protected
   function Get_ResultValue: Integer;
   procedure Set_ResultValue(aValue: Integer);
  public
   constructor Create; reintroduce;
    {* Конструктор TDocument_GetCurrentPosition_Params }
   class function Make: IDocument_GetCurrentPosition_Params; reintroduce;
    {* Фабрика TDocument_GetCurrentPosition_Params }
 end;//TDocument_GetCurrentPosition_Params

 TDocument_SelectBlock_Params = class(Tl3CProtoObject, IDocument_SelectBlock_Params)
  {* Реализация IDocument_SelectBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
   function Get_Data: IUnknown;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
    {* Конструктор TDocument_SelectBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_SelectBlock_Params; reintroduce;
    {* Фабрика TDocument_SelectBlock_Params }
 end;//TDocument_SelectBlock_Params

 TDocument_CopyBlock_Params = class(Tl3CProtoObject, IDocument_CopyBlock_Params)
  {* Реализация IDocument_CopyBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
   function Get_Data: IUnknown;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
    {* Конструктор TDocument_CopyBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_CopyBlock_Params; reintroduce;
    {* Фабрика TDocument_CopyBlock_Params }
 end;//TDocument_CopyBlock_Params

 TDocument_PrintBlock_Params = class(Tl3CProtoObject, IDocument_PrintBlock_Params)
  {* Реализация IDocument_PrintBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
   function Get_Data: IUnknown;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
    {* Конструктор TDocument_PrintBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_PrintBlock_Params; reintroduce;
    {* Фабрика TDocument_PrintBlock_Params }
 end;//TDocument_PrintBlock_Params

 TDocument_PrintDialogBlock_Params = class(Tl3CProtoObject, IDocument_PrintDialogBlock_Params)
  {* Реализация IDocument_PrintDialogBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_UserType: Integer;
   function Get_Data: IUnknown;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
    {* Конструктор TDocument_PrintDialogBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_PrintDialogBlock_Params; reintroduce;
    {* Фабрика TDocument_PrintDialogBlock_Params }
 end;//TDocument_PrintDialogBlock_Params

 TDocument_PreviewBlock_Params = class(Tl3CProtoObject, IDocument_PreviewBlock_Params)
  {* Реализация IDocument_PreviewBlock_Params }
  private
   f_Data: IUnknown;
   f_UserType: Integer;
  protected
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   procedure ClearFields; override;
  public
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
    {* Конструктор TDocument_PreviewBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_PreviewBlock_Params; reintroduce;
    {* Фабрика TDocument_PreviewBlock_Params }
 end;//TDocument_PreviewBlock_Params

 TDocument_ShowRespondentListToPart_Params = class(Tl3CProtoObject, IDocument_ShowRespondentListToPart_Params)
  {* Реализация IDocument_ShowRespondentListToPart_Params }
  private
   f_List: IPositionList;
   f_Current: Il3SimpleNode;
  protected
   function Get_Current: Il3SimpleNode;
   function Get_List: IPositionList;
   procedure ClearFields; override;
  public
   constructor Create(const aList: IPositionList;
    const aCurrent: Il3SimpleNode); reintroduce;
    {* Конструктор TDocument_ShowRespondentListToPart_Params }
   class function Make(const aList: IPositionList;
    const aCurrent: Il3SimpleNode): IDocument_ShowRespondentListToPart_Params; reintroduce;
    {* Фабрика TDocument_ShowRespondentListToPart_Params }
 end;//TDocument_ShowRespondentListToPart_Params

 TDocument_ShowCorrespondentListToPart_Params = class(Tl3CProtoObject, IDocument_ShowCorrespondentListToPart_Params)
  {* Реализация IDocument_ShowCorrespondentListToPart_Params }
  private
   f_List: IPositionList;
   f_Current: Il3SimpleNode;
  protected
   function Get_Current: Il3SimpleNode;
   function Get_List: IPositionList;
   procedure ClearFields; override;
  public
   constructor Create(const aList: IPositionList;
    const aCurrent: Il3SimpleNode); reintroduce;
    {* Конструктор TDocument_ShowCorrespondentListToPart_Params }
   class function Make(const aList: IPositionList;
    const aCurrent: Il3SimpleNode): IDocument_ShowCorrespondentListToPart_Params; reintroduce;
    {* Фабрика TDocument_ShowCorrespondentListToPart_Params }
 end;//TDocument_ShowCorrespondentListToPart_Params

 TDocument_ModifyBookmarkNotify_Params = class(Tl3CProtoObject, IDocument_ModifyBookmarkNotify_Params)
  {* Реализация IDocument_ModifyBookmarkNotify_Params }
  private
   f_nEntity: IUnknown;
  protected
   function Get_nEntity: IUnknown;
   procedure ClearFields; override;
  public
   constructor Create(const anEntity: IUnknown); reintroduce;
    {* Конструктор TDocument_ModifyBookmarkNotify_Params }
   class function Make(const anEntity: IUnknown): IDocument_ModifyBookmarkNotify_Params; reintroduce;
    {* Фабрика TDocument_ModifyBookmarkNotify_Params }
 end;//TDocument_ModifyBookmarkNotify_Params

 TDocument_AddBookmarkFromContents_Params = class(Tl3CProtoObject, IDocument_AddBookmarkFromContents_Params)
  {* Реализация IDocument_AddBookmarkFromContents_Params }
  private
   f_Tag: Il3TagRef;
  protected
   function Get_Tag: Il3TagRef;
   procedure ClearFields; override;
  public
   constructor Create(const aTag: Il3TagRef); reintroduce;
    {* Конструктор TDocument_AddBookmarkFromContents_Params }
   class function Make(const aTag: Il3TagRef): IDocument_AddBookmarkFromContents_Params; reintroduce;
    {* Фабрика TDocument_AddBookmarkFromContents_Params }
 end;//TDocument_AddBookmarkFromContents_Params

 TDocument_GotoPara_Params = class(Tl3CProtoObject, IDocument_GotoPara_Params)
  {* Реализация IDocument_GotoPara_Params }
  private
   f_Para: Il3TagRef;
   f_UserType: Integer;
   f_ResultValue: Boolean;
  protected
   function Get_UserType: Integer;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_Para: Il3TagRef;
   procedure ClearFields; override;
  public
   constructor Create(const aPara: Il3TagRef;
    aUserType: Integer); reintroduce;
    {* Конструктор TDocument_GotoPara_Params }
   class function Make(const aPara: Il3TagRef;
    aUserType: Integer): IDocument_GotoPara_Params; reintroduce;
    {* Фабрика TDocument_GotoPara_Params }
 end;//TDocument_GotoPara_Params

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Switcher.BecomeActive у сущности }
//#UC START# *3D1C0895D8ED_0731A0CB4B79_var*
//#UC END# *3D1C0895D8ED_0731A0CB4B79_var*
begin
//#UC START# *3D1C0895D8ED_0731A0CB4B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *3D1C0895D8ED_0731A0CB4B79_impl*
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Switcher.BecomeActive у агрегации }
//#UC START# *201FC578633E_0731A0CB4B79_var*
//#UC END# *201FC578633E_0731A0CB4B79_var*
begin
//#UC START# *201FC578633E_0731A0CB4B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *201FC578633E_0731A0CB4B79_impl*
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.BecomeActive у формы }
//#UC START# *F8051AA6857E_0731A0CB4B79_var*
//#UC END# *F8051AA6857E_0731A0CB4B79_var*
begin
//#UC START# *F8051AA6857E_0731A0CB4B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8051AA6857E_0731A0CB4B79_impl*
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Switcher.BecomeActive у контейнера }
//#UC START# *5ED06C6EEAA0_0731A0CB4B79_var*
//#UC END# *5ED06C6EEAA0_0731A0CB4B79_var*
begin
//#UC START# *5ED06C6EEAA0_0731A0CB4B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *5ED06C6EEAA0_0731A0CB4B79_impl*
end;//Op_Switcher_BecomeActive.Call

constructor TDocument_FindExplanation_Params.Create;
 {* Конструктор TDocument_FindExplanation_Params }
//#UC START# *26CD32A1CDB1_6B0D81708857_var*
//#UC END# *26CD32A1CDB1_6B0D81708857_var*
begin
//#UC START# *26CD32A1CDB1_6B0D81708857_impl*
 !!! Needs to be implemented !!!
//#UC END# *26CD32A1CDB1_6B0D81708857_impl*
end;//TDocument_FindExplanation_Params.Create

class function TDocument_FindExplanation_Params.Make: IDocument_FindExplanation_Params;
 {* Фабрика TDocument_FindExplanation_Params }
var
 l_Inst : TDocument_FindExplanation_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_FindExplanation_Params.Make

function TDocument_FindExplanation_Params.Get_ResultValue: Boolean;
//#UC START# *9AD93CDEF37D_6B0D81708857get_var*
//#UC END# *9AD93CDEF37D_6B0D81708857get_var*
begin
//#UC START# *9AD93CDEF37D_6B0D81708857get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9AD93CDEF37D_6B0D81708857get_impl*
end;//TDocument_FindExplanation_Params.Get_ResultValue

procedure TDocument_FindExplanation_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *9AD93CDEF37D_6B0D81708857set_var*
//#UC END# *9AD93CDEF37D_6B0D81708857set_var*
begin
//#UC START# *9AD93CDEF37D_6B0D81708857set_impl*
 !!! Needs to be implemented !!!
//#UC END# *9AD93CDEF37D_6B0D81708857set_impl*
end;//TDocument_FindExplanation_Params.Set_ResultValue

class function Op_Document_FindExplanation.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Document.FindExplanation у сущности }
//#UC START# *1A6C2F134B4A_EC66A6B5017D_var*
//#UC END# *1A6C2F134B4A_EC66A6B5017D_var*
begin
//#UC START# *1A6C2F134B4A_EC66A6B5017D_impl*
 !!! Needs to be implemented !!!
//#UC END# *1A6C2F134B4A_EC66A6B5017D_impl*
end;//Op_Document_FindExplanation.Call

class function Op_Document_FindExplanation.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Document.FindExplanation у агрегации }
//#UC START# *4AABEF02D59A_EC66A6B5017D_var*
//#UC END# *4AABEF02D59A_EC66A6B5017D_var*
begin
//#UC START# *4AABEF02D59A_EC66A6B5017D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AABEF02D59A_EC66A6B5017D_impl*
end;//Op_Document_FindExplanation.Call

class function Op_Document_FindExplanation.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Document.FindExplanation у формы }
//#UC START# *7A66CA28A68A_EC66A6B5017D_var*
//#UC END# *7A66CA28A68A_EC66A6B5017D_var*
begin
//#UC START# *7A66CA28A68A_EC66A6B5017D_impl*
 !!! Needs to be implemented !!!
//#UC END# *7A66CA28A68A_EC66A6B5017D_impl*
end;//Op_Document_FindExplanation.Call

class function Op_Document_FindExplanation.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Document.FindExplanation у контейнера }
//#UC START# *7D2058BD98D7_EC66A6B5017D_var*
//#UC END# *7D2058BD98D7_EC66A6B5017D_var*
begin
//#UC START# *7D2058BD98D7_EC66A6B5017D_impl*
 !!! Needs to be implemented !!!
//#UC END# *7D2058BD98D7_EC66A6B5017D_impl*
end;//Op_Document_FindExplanation.Call

constructor TSynchroView_BecomeActive_Params.Create(aFormType: TnsShowSynchroForm);
 {* Конструктор TSynchroView_BecomeActive_Params }
//#UC START# *1AFF38B7362A_441852216B57_var*
//#UC END# *1AFF38B7362A_441852216B57_var*
begin
//#UC START# *1AFF38B7362A_441852216B57_impl*
 !!! Needs to be implemented !!!
//#UC END# *1AFF38B7362A_441852216B57_impl*
end;//TSynchroView_BecomeActive_Params.Create

class function TSynchroView_BecomeActive_Params.Make(aFormType: TnsShowSynchroForm): ISynchroView_BecomeActive_Params;
 {* Фабрика TSynchroView_BecomeActive_Params }
var
 l_Inst : TSynchroView_BecomeActive_Params;
begin
 l_Inst := Create(aFormType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSynchroView_BecomeActive_Params.Make

function TSynchroView_BecomeActive_Params.Get_FormType: TnsShowSynchroForm;
//#UC START# *93C50AEF6AB4_441852216B57get_var*
//#UC END# *93C50AEF6AB4_441852216B57get_var*
begin
//#UC START# *93C50AEF6AB4_441852216B57get_impl*
 !!! Needs to be implemented !!!
//#UC END# *93C50AEF6AB4_441852216B57get_impl*
end;//TSynchroView_BecomeActive_Params.Get_FormType

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmEntity;
 aFormType: TnsShowSynchroForm): Boolean;
 {* Вызов операции SynchroView.BecomeActive у сущности }
//#UC START# *056B8C40B977_CDC370590879_var*
//#UC END# *056B8C40B977_CDC370590879_var*
begin
//#UC START# *056B8C40B977_CDC370590879_impl*
 !!! Needs to be implemented !!!
//#UC END# *056B8C40B977_CDC370590879_impl*
end;//Op_SynchroView_BecomeActive.Call

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmAggregate;
 aFormType: TnsShowSynchroForm): Boolean;
 {* Вызов операции SynchroView.BecomeActive у агрегации }
//#UC START# *35AB4C3043C7_CDC370590879_var*
//#UC END# *35AB4C3043C7_CDC370590879_var*
begin
//#UC START# *35AB4C3043C7_CDC370590879_impl*
 !!! Needs to be implemented !!!
//#UC END# *35AB4C3043C7_CDC370590879_impl*
end;//Op_SynchroView_BecomeActive.Call

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmEntityForm;
 aFormType: TnsShowSynchroForm): Boolean;
 {* Вызов операции SynchroView.BecomeActive у формы }
//#UC START# *203FFA0169DA_CDC370590879_var*
//#UC END# *203FFA0169DA_CDC370590879_var*
begin
//#UC START# *203FFA0169DA_CDC370590879_impl*
 !!! Needs to be implemented !!!
//#UC END# *203FFA0169DA_CDC370590879_impl*
end;//Op_SynchroView_BecomeActive.Call

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmContainer;
 aFormType: TnsShowSynchroForm): Boolean;
 {* Вызов операции SynchroView.BecomeActive у контейнера }
//#UC START# *5B63A9F5B9A2_CDC370590879_var*
//#UC END# *5B63A9F5B9A2_CDC370590879_var*
begin
//#UC START# *5B63A9F5B9A2_CDC370590879_impl*
 !!! Needs to be implemented !!!
//#UC END# *5B63A9F5B9A2_CDC370590879_impl*
end;//Op_SynchroView_BecomeActive.Call

constructor TList_GetDeList_Params.Create;
 {* Конструктор TList_GetDeList_Params }
//#UC START# *6517298C8745_F85FF597AA26_var*
//#UC END# *6517298C8745_F85FF597AA26_var*
begin
//#UC START# *6517298C8745_F85FF597AA26_impl*
 !!! Needs to be implemented !!!
//#UC END# *6517298C8745_F85FF597AA26_impl*
end;//TList_GetDeList_Params.Create

class function TList_GetDeList_Params.Make: IList_GetDeList_Params;
 {* Фабрика TList_GetDeList_Params }
var
 l_Inst : TList_GetDeList_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TList_GetDeList_Params.Make

function TList_GetDeList_Params.Get_ResultValue: IdeList;
//#UC START# *D928100E2146_F85FF597AA26get_var*
//#UC END# *D928100E2146_F85FF597AA26get_var*
begin
//#UC START# *D928100E2146_F85FF597AA26get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D928100E2146_F85FF597AA26get_impl*
end;//TList_GetDeList_Params.Get_ResultValue

procedure TList_GetDeList_Params.Set_ResultValue(const aValue: IdeList);
//#UC START# *D928100E2146_F85FF597AA26set_var*
//#UC END# *D928100E2146_F85FF597AA26set_var*
begin
//#UC START# *D928100E2146_F85FF597AA26set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D928100E2146_F85FF597AA26set_impl*
end;//TList_GetDeList_Params.Set_ResultValue

procedure TList_GetDeList_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TList_GetDeList_Params.ClearFields

class function Op_List_GetDeList.Call(const aTarget: IvcmEntity): IdeList;
 {* Вызов операции List.GetDeList у сущности }
//#UC START# *297B821512ED_6577E52558CD_var*
//#UC END# *297B821512ED_6577E52558CD_var*
begin
//#UC START# *297B821512ED_6577E52558CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *297B821512ED_6577E52558CD_impl*
end;//Op_List_GetDeList.Call

class function Op_List_GetDeList.Call(const aTarget: IvcmAggregate): IdeList;
 {* Вызов операции List.GetDeList у агрегации }
//#UC START# *59BB42039D3D_6577E52558CD_var*
//#UC END# *59BB42039D3D_6577E52558CD_var*
begin
//#UC START# *59BB42039D3D_6577E52558CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *59BB42039D3D_6577E52558CD_impl*
end;//Op_List_GetDeList.Call

class function Op_List_GetDeList.Call(const aTarget: IvcmEntityForm): IdeList;
 {* Вызов операции List.GetDeList у формы }
//#UC START# *04EDDF2A98DA_6577E52558CD_var*
//#UC END# *04EDDF2A98DA_6577E52558CD_var*
begin
//#UC START# *04EDDF2A98DA_6577E52558CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *04EDDF2A98DA_6577E52558CD_impl*
end;//Op_List_GetDeList.Call

class function Op_List_GetDeList.Call(const aTarget: IvcmContainer): IdeList;
 {* Вызов операции List.GetDeList у контейнера }
//#UC START# *2BB63A4639D1_6577E52558CD_var*
//#UC END# *2BB63A4639D1_6577E52558CD_var*
begin
//#UC START# *2BB63A4639D1_6577E52558CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *2BB63A4639D1_6577E52558CD_impl*
end;//Op_List_GetDeList.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции List.SetCurrentVisible у сущности }
//#UC START# *94BF804FD168_2083DA534419_var*
//#UC END# *94BF804FD168_2083DA534419_var*
begin
//#UC START# *94BF804FD168_2083DA534419_impl*
 !!! Needs to be implemented !!!
//#UC END# *94BF804FD168_2083DA534419_impl*
end;//Op_List_SetCurrentVisible.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции List.SetCurrentVisible у агрегации }
//#UC START# *C4FF403E5BB8_2083DA534419_var*
//#UC END# *C4FF403E5BB8_2083DA534419_var*
begin
//#UC START# *C4FF403E5BB8_2083DA534419_impl*
 !!! Needs to be implemented !!!
//#UC END# *C4FF403E5BB8_2083DA534419_impl*
end;//Op_List_SetCurrentVisible.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции List.SetCurrentVisible у формы }
//#UC START# *3D7185B34D03_2083DA534419_var*
//#UC END# *3D7185B34D03_2083DA534419_var*
begin
//#UC START# *3D7185B34D03_2083DA534419_impl*
 !!! Needs to be implemented !!!
//#UC END# *3D7185B34D03_2083DA534419_impl*
end;//Op_List_SetCurrentVisible.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции List.SetCurrentVisible у контейнера }
//#UC START# *EA6C427B1F85_2083DA534419_var*
//#UC END# *EA6C427B1F85_2083DA534419_var*
begin
//#UC START# *EA6C427B1F85_2083DA534419_impl*
 !!! Needs to be implemented !!!
//#UC END# *EA6C427B1F85_2083DA534419_impl*
end;//Op_List_SetCurrentVisible.Call

constructor TList_GetDsList_Params.Create;
 {* Конструктор TList_GetDsList_Params }
//#UC START# *3A57D383447C_870411EDAF7A_var*
//#UC END# *3A57D383447C_870411EDAF7A_var*
begin
//#UC START# *3A57D383447C_870411EDAF7A_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A57D383447C_870411EDAF7A_impl*
end;//TList_GetDsList_Params.Create

class function TList_GetDsList_Params.Make: IList_GetDsList_Params;
 {* Фабрика TList_GetDsList_Params }
var
 l_Inst : TList_GetDsList_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TList_GetDsList_Params.Make

function TList_GetDsList_Params.Get_ResultValue: IdsList;
//#UC START# *3A20182556C4_870411EDAF7Aget_var*
//#UC END# *3A20182556C4_870411EDAF7Aget_var*
begin
//#UC START# *3A20182556C4_870411EDAF7Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A20182556C4_870411EDAF7Aget_impl*
end;//TList_GetDsList_Params.Get_ResultValue

procedure TList_GetDsList_Params.Set_ResultValue(const aValue: IdsList);
//#UC START# *3A20182556C4_870411EDAF7Aset_var*
//#UC END# *3A20182556C4_870411EDAF7Aset_var*
begin
//#UC START# *3A20182556C4_870411EDAF7Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A20182556C4_870411EDAF7Aset_impl*
end;//TList_GetDsList_Params.Set_ResultValue

procedure TList_GetDsList_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TList_GetDsList_Params.ClearFields

class function Op_List_GetDsList.Call(const aTarget: IvcmEntity): IdsList;
 {* Вызов операции List.GetDsList у сущности }
//#UC START# *8D8DEE45FCFE_430867329961_var*
//#UC END# *8D8DEE45FCFE_430867329961_var*
begin
//#UC START# *8D8DEE45FCFE_430867329961_impl*
 !!! Needs to be implemented !!!
//#UC END# *8D8DEE45FCFE_430867329961_impl*
end;//Op_List_GetDsList.Call

class function Op_List_GetDsList.Call(const aTarget: IvcmAggregate): IdsList;
 {* Вызов операции List.GetDsList у агрегации }
//#UC START# *BDCDAE34874E_430867329961_var*
//#UC END# *BDCDAE34874E_430867329961_var*
begin
//#UC START# *BDCDAE34874E_430867329961_impl*
 !!! Needs to be implemented !!!
//#UC END# *BDCDAE34874E_430867329961_impl*
end;//Op_List_GetDsList.Call

class function Op_List_GetDsList.Call(const aTarget: IvcmEntityForm): IdsList;
 {* Вызов операции List.GetDsList у формы }
//#UC START# *A66151DA2D01_430867329961_var*
//#UC END# *A66151DA2D01_430867329961_var*
begin
//#UC START# *A66151DA2D01_430867329961_impl*
 !!! Needs to be implemented !!!
//#UC END# *A66151DA2D01_430867329961_impl*
end;//Op_List_GetDsList.Call

class function Op_List_GetDsList.Call(const aTarget: IvcmContainer): IdsList;
 {* Вызов операции List.GetDsList у контейнера }
//#UC START# *146FEF6C7095_430867329961_var*
//#UC END# *146FEF6C7095_430867329961_var*
begin
//#UC START# *146FEF6C7095_430867329961_impl*
 !!! Needs to be implemented !!!
//#UC END# *146FEF6C7095_430867329961_impl*
end;//Op_List_GetDsList.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Form.RequestClose у сущности }
//#UC START# *9ADA6BC8E7D6_0BD7283BCCA9_var*
//#UC END# *9ADA6BC8E7D6_0BD7283BCCA9_var*
begin
//#UC START# *9ADA6BC8E7D6_0BD7283BCCA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *9ADA6BC8E7D6_0BD7283BCCA9_impl*
end;//Op_Form_RequestClose.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Form.RequestClose у агрегации }
//#UC START# *CB1A2BB77226_0BD7283BCCA9_var*
//#UC END# *CB1A2BB77226_0BD7283BCCA9_var*
begin
//#UC START# *CB1A2BB77226_0BD7283BCCA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *CB1A2BB77226_0BD7283BCCA9_impl*
end;//Op_Form_RequestClose.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Form.RequestClose у формы }
//#UC START# *524C4A50E772_0BD7283BCCA9_var*
//#UC END# *524C4A50E772_0BD7283BCCA9_var*
begin
//#UC START# *524C4A50E772_0BD7283BCCA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *524C4A50E772_0BD7283BCCA9_impl*
end;//Op_Form_RequestClose.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Form.RequestClose у контейнера }
//#UC START# *C39678BA95DE_0BD7283BCCA9_var*
//#UC END# *C39678BA95DE_0BD7283BCCA9_var*
begin
//#UC START# *C39678BA95DE_0BD7283BCCA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *C39678BA95DE_0BD7283BCCA9_impl*
end;//Op_Form_RequestClose.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции ControlCenter.Refresh у сущности }
//#UC START# *0D4A0E4528D3_E28F8F33EA89_var*
//#UC END# *0D4A0E4528D3_E28F8F33EA89_var*
begin
//#UC START# *0D4A0E4528D3_E28F8F33EA89_impl*
 !!! Needs to be implemented !!!
//#UC END# *0D4A0E4528D3_E28F8F33EA89_impl*
end;//Op_ControlCenter_Refresh.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции ControlCenter.Refresh у агрегации }
//#UC START# *F04DCB28B323_E28F8F33EA89_var*
//#UC END# *F04DCB28B323_E28F8F33EA89_var*
begin
//#UC START# *F04DCB28B323_E28F8F33EA89_impl*
 !!! Needs to be implemented !!!
//#UC END# *F04DCB28B323_E28F8F33EA89_impl*
end;//Op_ControlCenter_Refresh.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции ControlCenter.Refresh у формы }
//#UC START# *E9E549B46606_E28F8F33EA89_var*
//#UC END# *E9E549B46606_E28F8F33EA89_var*
begin
//#UC START# *E9E549B46606_E28F8F33EA89_impl*
 !!! Needs to be implemented !!!
//#UC END# *E9E549B46606_E28F8F33EA89_impl*
end;//Op_ControlCenter_Refresh.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции ControlCenter.Refresh у контейнера }
//#UC START# *F5202D86F241_E28F8F33EA89_var*
//#UC END# *F5202D86F241_E28F8F33EA89_var*
begin
//#UC START# *F5202D86F241_E28F8F33EA89_impl*
 !!! Needs to be implemented !!!
//#UC END# *F5202D86F241_E28F8F33EA89_impl*
end;//Op_ControlCenter_Refresh.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции ListInfo.BecomeActive у сущности }
//#UC START# *33645738C58E_F30C956E1A46_var*
//#UC END# *33645738C58E_F30C956E1A46_var*
begin
//#UC START# *33645738C58E_F30C956E1A46_impl*
 !!! Needs to be implemented !!!
//#UC END# *33645738C58E_F30C956E1A46_impl*
end;//Op_ListInfo_BecomeActive.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции ListInfo.BecomeActive у агрегации }
//#UC START# *63A417274FDE_F30C956E1A46_var*
//#UC END# *63A417274FDE_F30C956E1A46_var*
begin
//#UC START# *63A417274FDE_F30C956E1A46_impl*
 !!! Needs to be implemented !!!
//#UC END# *63A417274FDE_F30C956E1A46_impl*
end;//Op_ListInfo_BecomeActive.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции ListInfo.BecomeActive у формы }
//#UC START# *8C25F1D7CF4E_F30C956E1A46_var*
//#UC END# *8C25F1D7CF4E_F30C956E1A46_var*
begin
//#UC START# *8C25F1D7CF4E_F30C956E1A46_impl*
 !!! Needs to be implemented !!!
//#UC END# *8C25F1D7CF4E_F30C956E1A46_impl*
end;//Op_ListInfo_BecomeActive.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции ListInfo.BecomeActive у контейнера }
//#UC START# *9AAF62F9ECE7_F30C956E1A46_var*
//#UC END# *9AAF62F9ECE7_F30C956E1A46_var*
begin
//#UC START# *9AAF62F9ECE7_F30C956E1A46_impl*
 !!! Needs to be implemented !!!
//#UC END# *9AAF62F9ECE7_F30C956E1A46_impl*
end;//Op_ListInfo_BecomeActive.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Filters.DeselectAll у сущности }
//#UC START# *1DA8E83BD660_27A11DF86E33_var*
//#UC END# *1DA8E83BD660_27A11DF86E33_var*
begin
//#UC START# *1DA8E83BD660_27A11DF86E33_impl*
 !!! Needs to be implemented !!!
//#UC END# *1DA8E83BD660_27A11DF86E33_impl*
end;//Op_Filters_DeselectAll.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Filters.DeselectAll у агрегации }
//#UC START# *4DE8A82B60B0_27A11DF86E33_var*
//#UC END# *4DE8A82B60B0_27A11DF86E33_var*
begin
//#UC START# *4DE8A82B60B0_27A11DF86E33_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DE8A82B60B0_27A11DF86E33_impl*
end;//Op_Filters_DeselectAll.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Filters.DeselectAll у формы }
//#UC START# *240B3C885ECE_27A11DF86E33_var*
//#UC END# *240B3C885ECE_27A11DF86E33_var*
begin
//#UC START# *240B3C885ECE_27A11DF86E33_impl*
 !!! Needs to be implemented !!!
//#UC END# *240B3C885ECE_27A11DF86E33_impl*
end;//Op_Filters_DeselectAll.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Filters.DeselectAll у контейнера }
//#UC START# *FA77835A0186_27A11DF86E33_var*
//#UC END# *FA77835A0186_27A11DF86E33_var*
begin
//#UC START# *FA77835A0186_27A11DF86E33_impl*
 !!! Needs to be implemented !!!
//#UC END# *FA77835A0186_27A11DF86E33_impl*
end;//Op_Filters_DeselectAll.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции TimeMachine.TimeMachineOnOff у сущности }
//#UC START# *A4CDDE77D173_433C21F06266_var*
//#UC END# *A4CDDE77D173_433C21F06266_var*
begin
//#UC START# *A4CDDE77D173_433C21F06266_impl*
 !!! Needs to be implemented !!!
//#UC END# *A4CDDE77D173_433C21F06266_impl*
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции TimeMachine.TimeMachineOnOff у агрегации }
//#UC START# *D50D9E665BC3_433C21F06266_var*
//#UC END# *D50D9E665BC3_433C21F06266_var*
begin
//#UC START# *D50D9E665BC3_433C21F06266_impl*
 !!! Needs to be implemented !!!
//#UC END# *D50D9E665BC3_433C21F06266_impl*
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции TimeMachine.TimeMachineOnOff у формы }
//#UC START# *618958178EA5_433C21F06266_var*
//#UC END# *618958178EA5_433C21F06266_var*
begin
//#UC START# *618958178EA5_433C21F06266_impl*
 !!! Needs to be implemented !!!
//#UC END# *618958178EA5_433C21F06266_impl*
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции TimeMachine.TimeMachineOnOff у контейнера }
//#UC START# *EC42C2988828_433C21F06266_var*
//#UC END# *EC42C2988828_433C21F06266_var*
begin
//#UC START# *EC42C2988828_433C21F06266_impl*
 !!! Needs to be implemented !!!
//#UC END# *EC42C2988828_433C21F06266_impl*
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции TimeMachine.TimeMachineOffAndReset у сущности }
//#UC START# *5F9A32DEC255_FB60AC48140A_var*
//#UC END# *5F9A32DEC255_FB60AC48140A_var*
begin
//#UC START# *5F9A32DEC255_FB60AC48140A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5F9A32DEC255_FB60AC48140A_impl*
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции TimeMachine.TimeMachineOffAndReset у агрегации }
//#UC START# *8FD9F2CD4CA5_FB60AC48140A_var*
//#UC END# *8FD9F2CD4CA5_FB60AC48140A_var*
begin
//#UC START# *8FD9F2CD4CA5_FB60AC48140A_impl*
 !!! Needs to be implemented !!!
//#UC END# *8FD9F2CD4CA5_FB60AC48140A_impl*
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции TimeMachine.TimeMachineOffAndReset у формы }
//#UC START# *2E4D0ED25E0B_FB60AC48140A_var*
//#UC END# *2E4D0ED25E0B_FB60AC48140A_var*
begin
//#UC START# *2E4D0ED25E0B_FB60AC48140A_impl*
 !!! Needs to be implemented !!!
//#UC END# *2E4D0ED25E0B_FB60AC48140A_impl*
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции TimeMachine.TimeMachineOffAndReset у контейнера }
//#UC START# *55F8DF906F83_FB60AC48140A_var*
//#UC END# *55F8DF906F83_FB60AC48140A_var*
begin
//#UC START# *55F8DF906F83_FB60AC48140A_impl*
 !!! Needs to be implemented !!!
//#UC END# *55F8DF906F83_FB60AC48140A_impl*
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

constructor TFilter_ActivateNode_Params.Create(const aNode: Il3Node);
 {* Конструктор TFilter_ActivateNode_Params }
//#UC START# *A8F6B384CC91_9DD1CFB9AA1B_var*
//#UC END# *A8F6B384CC91_9DD1CFB9AA1B_var*
begin
//#UC START# *A8F6B384CC91_9DD1CFB9AA1B_impl*
 !!! Needs to be implemented !!!
//#UC END# *A8F6B384CC91_9DD1CFB9AA1B_impl*
end;//TFilter_ActivateNode_Params.Create

class function TFilter_ActivateNode_Params.Make(const aNode: Il3Node): IFilter_ActivateNode_Params;
 {* Фабрика TFilter_ActivateNode_Params }
var
 l_Inst : TFilter_ActivateNode_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFilter_ActivateNode_Params.Make

function TFilter_ActivateNode_Params.Get_Node: Il3Node;
//#UC START# *A3BFAD9E2ECC_9DD1CFB9AA1Bget_var*
//#UC END# *A3BFAD9E2ECC_9DD1CFB9AA1Bget_var*
begin
//#UC START# *A3BFAD9E2ECC_9DD1CFB9AA1Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A3BFAD9E2ECC_9DD1CFB9AA1Bget_impl*
end;//TFilter_ActivateNode_Params.Get_Node

procedure TFilter_ActivateNode_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFilter_ActivateNode_Params.ClearFields

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmEntity;
 const aNode: Il3Node): Boolean;
 {* Вызов операции Filter.ActivateNode у сущности }
//#UC START# *98FC3F4BB005_A45059805405_var*
//#UC END# *98FC3F4BB005_A45059805405_var*
begin
//#UC START# *98FC3F4BB005_A45059805405_impl*
 !!! Needs to be implemented !!!
//#UC END# *98FC3F4BB005_A45059805405_impl*
end;//Op_Filter_ActivateNode.Call

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmAggregate;
 const aNode: Il3Node): Boolean;
 {* Вызов операции Filter.ActivateNode у агрегации }
//#UC START# *C93BFF3B3A55_A45059805405_var*
//#UC END# *C93BFF3B3A55_A45059805405_var*
begin
//#UC START# *C93BFF3B3A55_A45059805405_impl*
 !!! Needs to be implemented !!!
//#UC END# *C93BFF3B3A55_A45059805405_impl*
end;//Op_Filter_ActivateNode.Call

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3Node): Boolean;
 {* Вызов операции Filter.ActivateNode у формы }
//#UC START# *69E961B3D509_A45059805405_var*
//#UC END# *69E961B3D509_A45059805405_var*
begin
//#UC START# *69E961B3D509_A45059805405_impl*
 !!! Needs to be implemented !!!
//#UC END# *69E961B3D509_A45059805405_impl*
end;//Op_Filter_ActivateNode.Call

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmContainer;
 const aNode: Il3Node): Boolean;
 {* Вызов операции Filter.ActivateNode у контейнера }
//#UC START# *4BC630174F0F_A45059805405_var*
//#UC END# *4BC630174F0F_A45059805405_var*
begin
//#UC START# *4BC630174F0F_A45059805405_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BC630174F0F_A45059805405_impl*
end;//Op_Filter_ActivateNode.Call

constructor TFoldersControl_EditElement_Params.Create(const aNode: IFoldersNode);
 {* Конструктор TFoldersControl_EditElement_Params }
//#UC START# *A0FCD87D8291_9856F21414C5_var*
//#UC END# *A0FCD87D8291_9856F21414C5_var*
begin
//#UC START# *A0FCD87D8291_9856F21414C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *A0FCD87D8291_9856F21414C5_impl*
end;//TFoldersControl_EditElement_Params.Create

class function TFoldersControl_EditElement_Params.Make(const aNode: IFoldersNode): IFoldersControl_EditElement_Params;
 {* Фабрика TFoldersControl_EditElement_Params }
var
 l_Inst : TFoldersControl_EditElement_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFoldersControl_EditElement_Params.Make

function TFoldersControl_EditElement_Params.Get_Node: IFoldersNode;
//#UC START# *EFA6DC0AF264_9856F21414C5get_var*
//#UC END# *EFA6DC0AF264_9856F21414C5get_var*
begin
//#UC START# *EFA6DC0AF264_9856F21414C5get_impl*
 !!! Needs to be implemented !!!
//#UC END# *EFA6DC0AF264_9856F21414C5get_impl*
end;//TFoldersControl_EditElement_Params.Get_Node

procedure TFoldersControl_EditElement_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFoldersControl_EditElement_Params.ClearFields

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmEntity;
 const aNode: IFoldersNode): Boolean;
 {* Вызов операции FoldersControl.EditElement у сущности }
//#UC START# *A055C2D0DA05_0F69BD4B96B5_var*
//#UC END# *A055C2D0DA05_0F69BD4B96B5_var*
begin
//#UC START# *A055C2D0DA05_0F69BD4B96B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *A055C2D0DA05_0F69BD4B96B5_impl*
end;//Op_FoldersControl_EditElement.Call

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmAggregate;
 const aNode: IFoldersNode): Boolean;
 {* Вызов операции FoldersControl.EditElement у агрегации }
//#UC START# *D09582BF6455_0F69BD4B96B5_var*
//#UC END# *D09582BF6455_0F69BD4B96B5_var*
begin
//#UC START# *D09582BF6455_0F69BD4B96B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *D09582BF6455_0F69BD4B96B5_impl*
end;//Op_FoldersControl_EditElement.Call

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmEntityForm;
 const aNode: IFoldersNode): Boolean;
 {* Вызов операции FoldersControl.EditElement у формы }
//#UC START# *7CB815DE8F56_0F69BD4B96B5_var*
//#UC END# *7CB815DE8F56_0F69BD4B96B5_var*
begin
//#UC START# *7CB815DE8F56_0F69BD4B96B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *7CB815DE8F56_0F69BD4B96B5_impl*
end;//Op_FoldersControl_EditElement.Call

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode): Boolean;
 {* Вызов операции FoldersControl.EditElement у контейнера }
//#UC START# *FA68274957FA_0F69BD4B96B5_var*
//#UC END# *FA68274957FA_0F69BD4B96B5_var*
begin
//#UC START# *FA68274957FA_0F69BD4B96B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *FA68274957FA_0F69BD4B96B5_impl*
end;//Op_FoldersControl_EditElement.Call

constructor TFoldersControl_DeleteElement_Params.Create(const aNode: IFoldersNode);
 {* Конструктор TFoldersControl_DeleteElement_Params }
//#UC START# *F7CF0C09AFEA_FBEDA30BFEED_var*
//#UC END# *F7CF0C09AFEA_FBEDA30BFEED_var*
begin
//#UC START# *F7CF0C09AFEA_FBEDA30BFEED_impl*
 !!! Needs to be implemented !!!
//#UC END# *F7CF0C09AFEA_FBEDA30BFEED_impl*
end;//TFoldersControl_DeleteElement_Params.Create

class function TFoldersControl_DeleteElement_Params.Make(const aNode: IFoldersNode): IFoldersControl_DeleteElement_Params;
 {* Фабрика TFoldersControl_DeleteElement_Params }
var
 l_Inst : TFoldersControl_DeleteElement_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFoldersControl_DeleteElement_Params.Make

function TFoldersControl_DeleteElement_Params.Get_ResultValue: TnsDeleteResult;
//#UC START# *5B9A35BFB619_FBEDA30BFEEDget_var*
//#UC END# *5B9A35BFB619_FBEDA30BFEEDget_var*
begin
//#UC START# *5B9A35BFB619_FBEDA30BFEEDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5B9A35BFB619_FBEDA30BFEEDget_impl*
end;//TFoldersControl_DeleteElement_Params.Get_ResultValue

procedure TFoldersControl_DeleteElement_Params.Set_ResultValue(aValue: TnsDeleteResult);
//#UC START# *5B9A35BFB619_FBEDA30BFEEDset_var*
//#UC END# *5B9A35BFB619_FBEDA30BFEEDset_var*
begin
//#UC START# *5B9A35BFB619_FBEDA30BFEEDset_impl*
 !!! Needs to be implemented !!!
//#UC END# *5B9A35BFB619_FBEDA30BFEEDset_impl*
end;//TFoldersControl_DeleteElement_Params.Set_ResultValue

function TFoldersControl_DeleteElement_Params.Get_Node: IFoldersNode;
//#UC START# *D30F412AEBE6_FBEDA30BFEEDget_var*
//#UC END# *D30F412AEBE6_FBEDA30BFEEDget_var*
begin
//#UC START# *D30F412AEBE6_FBEDA30BFEEDget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D30F412AEBE6_FBEDA30BFEEDget_impl*
end;//TFoldersControl_DeleteElement_Params.Get_Node

procedure TFoldersControl_DeleteElement_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFoldersControl_DeleteElement_Params.ClearFields

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmEntity;
 const aNode: IFoldersNode): TnsDeleteResult;
 {* Вызов операции FoldersControl.DeleteElement у сущности }
//#UC START# *DB05D836F1E5_284BCC850D75_var*
//#UC END# *DB05D836F1E5_284BCC850D75_var*
begin
//#UC START# *DB05D836F1E5_284BCC850D75_impl*
 !!! Needs to be implemented !!!
//#UC END# *DB05D836F1E5_284BCC850D75_impl*
end;//Op_FoldersControl_DeleteElement.Call

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmAggregate;
 const aNode: IFoldersNode): TnsDeleteResult;
 {* Вызов операции FoldersControl.DeleteElement у агрегации }
//#UC START# *0B4598257C36_284BCC850D75_var*
//#UC END# *0B4598257C36_284BCC850D75_var*
begin
//#UC START# *0B4598257C36_284BCC850D75_impl*
 !!! Needs to be implemented !!!
//#UC END# *0B4598257C36_284BCC850D75_impl*
end;//Op_FoldersControl_DeleteElement.Call

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmEntityForm;
 const aNode: IFoldersNode): TnsDeleteResult;
 {* Вызов операции FoldersControl.DeleteElement у формы }
//#UC START# *488648398990_284BCC850D75_var*
//#UC END# *488648398990_284BCC850D75_var*
begin
//#UC START# *488648398990_284BCC850D75_impl*
 !!! Needs to be implemented !!!
//#UC END# *488648398990_284BCC850D75_impl*
end;//Op_FoldersControl_DeleteElement.Call

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode): TnsDeleteResult;
 {* Вызов операции FoldersControl.DeleteElement у контейнера }
//#UC START# *E6ACA6D67C06_284BCC850D75_var*
//#UC END# *E6ACA6D67C06_284BCC850D75_var*
begin
//#UC START# *E6ACA6D67C06_284BCC850D75_impl*
 !!! Needs to be implemented !!!
//#UC END# *E6ACA6D67C06_284BCC850D75_impl*
end;//Op_FoldersControl_DeleteElement.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Filters.InternalClear у сущности }
//#UC START# *3C6D50B0602F_7DEDDDB75733_var*
//#UC END# *3C6D50B0602F_7DEDDDB75733_var*
begin
//#UC START# *3C6D50B0602F_7DEDDDB75733_impl*
 !!! Needs to be implemented !!!
//#UC END# *3C6D50B0602F_7DEDDDB75733_impl*
end;//Op_Filters_InternalClear.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Filters.InternalClear у агрегации }
//#UC START# *6CAD109EEA7F_7DEDDDB75733_var*
//#UC END# *6CAD109EEA7F_7DEDDDB75733_var*
begin
//#UC START# *6CAD109EEA7F_7DEDDDB75733_impl*
 !!! Needs to be implemented !!!
//#UC END# *6CAD109EEA7F_7DEDDDB75733_impl*
end;//Op_Filters_InternalClear.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Filters.InternalClear у формы }
//#UC START# *96E137CB62B6_7DEDDDB75733_var*
//#UC END# *96E137CB62B6_7DEDDDB75733_var*
begin
//#UC START# *96E137CB62B6_7DEDDDB75733_impl*
 !!! Needs to be implemented !!!
//#UC END# *96E137CB62B6_7DEDDDB75733_impl*
end;//Op_Filters_InternalClear.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Filters.InternalClear у контейнера }
//#UC START# *C5D279B162B8_7DEDDDB75733_var*
//#UC END# *C5D279B162B8_7DEDDDB75733_var*
begin
//#UC START# *C5D279B162B8_7DEDDDB75733_impl*
 !!! Needs to be implemented !!!
//#UC END# *C5D279B162B8_7DEDDDB75733_impl*
end;//Op_Filters_InternalClear.Call

constructor TDocument_SetActive_Params.Create(aUserType: Integer);
 {* Конструктор TDocument_SetActive_Params }
//#UC START# *0B54325998F3_E8B08CF444BA_var*
//#UC END# *0B54325998F3_E8B08CF444BA_var*
begin
//#UC START# *0B54325998F3_E8B08CF444BA_impl*
 !!! Needs to be implemented !!!
//#UC END# *0B54325998F3_E8B08CF444BA_impl*
end;//TDocument_SetActive_Params.Create

class function TDocument_SetActive_Params.Make(aUserType: Integer): IDocument_SetActive_Params;
 {* Фабрика TDocument_SetActive_Params }
var
 l_Inst : TDocument_SetActive_Params;
begin
 l_Inst := Create(aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_SetActive_Params.Make

function TDocument_SetActive_Params.Get_UserType: Integer;
//#UC START# *E0202A75E630_E8B08CF444BAget_var*
//#UC END# *E0202A75E630_E8B08CF444BAget_var*
begin
//#UC START# *E0202A75E630_E8B08CF444BAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *E0202A75E630_E8B08CF444BAget_impl*
end;//TDocument_SetActive_Params.Get_UserType

class function Op_Document_SetActive.Call(const aTarget: IvcmEntity;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.SetActive у сущности }
//#UC START# *391438BF201C_5624A22C9B1E_var*
//#UC END# *391438BF201C_5624A22C9B1E_var*
begin
//#UC START# *391438BF201C_5624A22C9B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *391438BF201C_5624A22C9B1E_impl*
end;//Op_Document_SetActive.Call

class function Op_Document_SetActive.Call(const aTarget: IvcmAggregate;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.SetActive у агрегации }
//#UC START# *6953F8AEAA6C_5624A22C9B1E_var*
//#UC END# *6953F8AEAA6C_5624A22C9B1E_var*
begin
//#UC START# *6953F8AEAA6C_5624A22C9B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *6953F8AEAA6C_5624A22C9B1E_impl*
end;//Op_Document_SetActive.Call

class function Op_Document_SetActive.Call(const aTarget: IvcmEntityForm;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.SetActive у формы }
//#UC START# *25CA6DA5FE80_5624A22C9B1E_var*
//#UC END# *25CA6DA5FE80_5624A22C9B1E_var*
begin
//#UC START# *25CA6DA5FE80_5624A22C9B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *25CA6DA5FE80_5624A22C9B1E_impl*
end;//Op_Document_SetActive.Call

class function Op_Document_SetActive.Call(const aTarget: IvcmContainer;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.SetActive у контейнера }
//#UC START# *86A156405865_5624A22C9B1E_var*
//#UC END# *86A156405865_5624A22C9B1E_var*
begin
//#UC START# *86A156405865_5624A22C9B1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *86A156405865_5624A22C9B1E_impl*
end;//Op_Document_SetActive.Call

constructor TDocument_ExportBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean);
 {* Конструктор TDocument_ExportBlock_Params }
//#UC START# *A087A19E15CD_7041CA58192B_var*
//#UC END# *A087A19E15CD_7041CA58192B_var*
begin
//#UC START# *A087A19E15CD_7041CA58192B_impl*
 !!! Needs to be implemented !!!
//#UC END# *A087A19E15CD_7041CA58192B_impl*
end;//TDocument_ExportBlock_Params.Create

class function TDocument_ExportBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): IDocument_ExportBlock_Params;
 {* Фабрика TDocument_ExportBlock_Params }
var
 l_Inst : TDocument_ExportBlock_Params;
begin
 l_Inst := Create(aData, aUserType, aToActiveWindow);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_ExportBlock_Params.Make

function TDocument_ExportBlock_Params.Get_Data: IUnknown;
//#UC START# *1A2316AD2D80_7041CA58192Bget_var*
//#UC END# *1A2316AD2D80_7041CA58192Bget_var*
begin
//#UC START# *1A2316AD2D80_7041CA58192Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *1A2316AD2D80_7041CA58192Bget_impl*
end;//TDocument_ExportBlock_Params.Get_Data

function TDocument_ExportBlock_Params.Get_UserType: Integer;
//#UC START# *294806A50B4C_7041CA58192Bget_var*
//#UC END# *294806A50B4C_7041CA58192Bget_var*
begin
//#UC START# *294806A50B4C_7041CA58192Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *294806A50B4C_7041CA58192Bget_impl*
end;//TDocument_ExportBlock_Params.Get_UserType

function TDocument_ExportBlock_Params.Get_ToActiveWindow: Boolean;
//#UC START# *A54985D521E7_7041CA58192Bget_var*
//#UC END# *A54985D521E7_7041CA58192Bget_var*
begin
//#UC START# *A54985D521E7_7041CA58192Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A54985D521E7_7041CA58192Bget_impl*
end;//TDocument_ExportBlock_Params.Get_ToActiveWindow

procedure TDocument_ExportBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_ExportBlock_Params.ClearFields

class function Op_Document_ExportBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): Boolean;
 {* Вызов операции Document.ExportBlock у сущности }
//#UC START# *D27AD2DF930C_8A2108CD72B1_var*
//#UC END# *D27AD2DF930C_8A2108CD72B1_var*
begin
//#UC START# *D27AD2DF930C_8A2108CD72B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *D27AD2DF930C_8A2108CD72B1_impl*
end;//Op_Document_ExportBlock.Call

class function Op_Document_ExportBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): Boolean;
 {* Вызов операции Document.ExportBlock у агрегации }
//#UC START# *02BA92CE1D5D_8A2108CD72B1_var*
//#UC END# *02BA92CE1D5D_8A2108CD72B1_var*
begin
//#UC START# *02BA92CE1D5D_8A2108CD72B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *02BA92CE1D5D_8A2108CD72B1_impl*
end;//Op_Document_ExportBlock.Call

class function Op_Document_ExportBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): Boolean;
 {* Вызов операции Document.ExportBlock у формы }
//#UC START# *6780200DCF37_8A2108CD72B1_var*
//#UC END# *6780200DCF37_8A2108CD72B1_var*
begin
//#UC START# *6780200DCF37_8A2108CD72B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *6780200DCF37_8A2108CD72B1_impl*
end;//Op_Document_ExportBlock.Call

class function Op_Document_ExportBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer;
 aToActiveWindow: Boolean): Boolean;
 {* Вызов операции Document.ExportBlock у контейнера }
//#UC START# *A785E437609A_8A2108CD72B1_var*
//#UC END# *A785E437609A_8A2108CD72B1_var*
begin
//#UC START# *A785E437609A_8A2108CD72B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *A785E437609A_8A2108CD72B1_impl*
end;//Op_Document_ExportBlock.Call

constructor TDocument_GetCurrentPosition_Params.Create;
 {* Конструктор TDocument_GetCurrentPosition_Params }
//#UC START# *FB048A3574A7_F2AA464A2C34_var*
//#UC END# *FB048A3574A7_F2AA464A2C34_var*
begin
//#UC START# *FB048A3574A7_F2AA464A2C34_impl*
 !!! Needs to be implemented !!!
//#UC END# *FB048A3574A7_F2AA464A2C34_impl*
end;//TDocument_GetCurrentPosition_Params.Create

class function TDocument_GetCurrentPosition_Params.Make: IDocument_GetCurrentPosition_Params;
 {* Фабрика TDocument_GetCurrentPosition_Params }
var
 l_Inst : TDocument_GetCurrentPosition_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_GetCurrentPosition_Params.Make

function TDocument_GetCurrentPosition_Params.Get_ResultValue: Integer;
//#UC START# *5B239AB69A88_F2AA464A2C34get_var*
//#UC END# *5B239AB69A88_F2AA464A2C34get_var*
begin
//#UC START# *5B239AB69A88_F2AA464A2C34get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5B239AB69A88_F2AA464A2C34get_impl*
end;//TDocument_GetCurrentPosition_Params.Get_ResultValue

procedure TDocument_GetCurrentPosition_Params.Set_ResultValue(aValue: Integer);
//#UC START# *5B239AB69A88_F2AA464A2C34set_var*
//#UC END# *5B239AB69A88_F2AA464A2C34set_var*
begin
//#UC START# *5B239AB69A88_F2AA464A2C34set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5B239AB69A88_F2AA464A2C34set_impl*
end;//TDocument_GetCurrentPosition_Params.Set_ResultValue

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmEntity): Integer;
 {* Вызов операции Document.GetCurrentPosition у сущности }
//#UC START# *A167B72CBBD0_9617921DE7F3_var*
//#UC END# *A167B72CBBD0_9617921DE7F3_var*
begin
//#UC START# *A167B72CBBD0_9617921DE7F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *A167B72CBBD0_9617921DE7F3_impl*
end;//Op_Document_GetCurrentPosition.Call

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmAggregate): Integer;
 {* Вызов операции Document.GetCurrentPosition у агрегации }
//#UC START# *D1A7771B4620_9617921DE7F3_var*
//#UC END# *D1A7771B4620_9617921DE7F3_var*
begin
//#UC START# *D1A7771B4620_9617921DE7F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *D1A7771B4620_9617921DE7F3_impl*
end;//Op_Document_GetCurrentPosition.Call

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmEntityForm): Integer;
 {* Вызов операции Document.GetCurrentPosition у формы }
//#UC START# *8E8DFCB5BEA8_9617921DE7F3_var*
//#UC END# *8E8DFCB5BEA8_9617921DE7F3_var*
begin
//#UC START# *8E8DFCB5BEA8_9617921DE7F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *8E8DFCB5BEA8_9617921DE7F3_impl*
end;//Op_Document_GetCurrentPosition.Call

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmContainer): Integer;
 {* Вызов операции Document.GetCurrentPosition у контейнера }
//#UC START# *F91D61E81D40_9617921DE7F3_var*
//#UC END# *F91D61E81D40_9617921DE7F3_var*
begin
//#UC START# *F91D61E81D40_9617921DE7F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *F91D61E81D40_9617921DE7F3_impl*
end;//Op_Document_GetCurrentPosition.Call

constructor TDocument_SelectBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
 {* Конструктор TDocument_SelectBlock_Params }
//#UC START# *6CA58DFB515A_4AE2C745A552_var*
//#UC END# *6CA58DFB515A_4AE2C745A552_var*
begin
//#UC START# *6CA58DFB515A_4AE2C745A552_impl*
 !!! Needs to be implemented !!!
//#UC END# *6CA58DFB515A_4AE2C745A552_impl*
end;//TDocument_SelectBlock_Params.Create

class function TDocument_SelectBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_SelectBlock_Params;
 {* Фабрика TDocument_SelectBlock_Params }
var
 l_Inst : TDocument_SelectBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_SelectBlock_Params.Make

function TDocument_SelectBlock_Params.Get_UserType: Integer;
//#UC START# *47C37AD2569F_4AE2C745A552get_var*
//#UC END# *47C37AD2569F_4AE2C745A552get_var*
begin
//#UC START# *47C37AD2569F_4AE2C745A552get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C37AD2569F_4AE2C745A552get_impl*
end;//TDocument_SelectBlock_Params.Get_UserType

function TDocument_SelectBlock_Params.Get_Data: IUnknown;
//#UC START# *50214A251F76_4AE2C745A552get_var*
//#UC END# *50214A251F76_4AE2C745A552get_var*
begin
//#UC START# *50214A251F76_4AE2C745A552get_impl*
 !!! Needs to be implemented !!!
//#UC END# *50214A251F76_4AE2C745A552get_impl*
end;//TDocument_SelectBlock_Params.Get_Data

procedure TDocument_SelectBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_SelectBlock_Params.ClearFields

class function Op_Document_SelectBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.SelectBlock у сущности }
//#UC START# *EFB63439AA4D_D9A77A401B79_var*
//#UC END# *EFB63439AA4D_D9A77A401B79_var*
begin
//#UC START# *EFB63439AA4D_D9A77A401B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *EFB63439AA4D_D9A77A401B79_impl*
end;//Op_Document_SelectBlock.Call

class function Op_Document_SelectBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.SelectBlock у агрегации }
//#UC START# *1FF5F428349E_D9A77A401B79_var*
//#UC END# *1FF5F428349E_D9A77A401B79_var*
begin
//#UC START# *1FF5F428349E_D9A77A401B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *1FF5F428349E_D9A77A401B79_impl*
end;//Op_Document_SelectBlock.Call

class function Op_Document_SelectBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.SelectBlock у формы }
//#UC START# *7DF929F68387_D9A77A401B79_var*
//#UC END# *7DF929F68387_D9A77A401B79_var*
begin
//#UC START# *7DF929F68387_D9A77A401B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *7DF929F68387_D9A77A401B79_impl*
end;//Op_Document_SelectBlock.Call

class function Op_Document_SelectBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.SelectBlock у контейнера }
//#UC START# *26FF74052B01_D9A77A401B79_var*
//#UC END# *26FF74052B01_D9A77A401B79_var*
begin
//#UC START# *26FF74052B01_D9A77A401B79_impl*
 !!! Needs to be implemented !!!
//#UC END# *26FF74052B01_D9A77A401B79_impl*
end;//Op_Document_SelectBlock.Call

constructor TDocument_CopyBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
 {* Конструктор TDocument_CopyBlock_Params }
//#UC START# *392E4CEBBE3F_A781AE4C071D_var*
//#UC END# *392E4CEBBE3F_A781AE4C071D_var*
begin
//#UC START# *392E4CEBBE3F_A781AE4C071D_impl*
 !!! Needs to be implemented !!!
//#UC END# *392E4CEBBE3F_A781AE4C071D_impl*
end;//TDocument_CopyBlock_Params.Create

class function TDocument_CopyBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_CopyBlock_Params;
 {* Фабрика TDocument_CopyBlock_Params }
var
 l_Inst : TDocument_CopyBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_CopyBlock_Params.Make

function TDocument_CopyBlock_Params.Get_UserType: Integer;
//#UC START# *A6EC3ADC5788_A781AE4C071Dget_var*
//#UC END# *A6EC3ADC5788_A781AE4C071Dget_var*
begin
//#UC START# *A6EC3ADC5788_A781AE4C071Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A6EC3ADC5788_A781AE4C071Dget_impl*
end;//TDocument_CopyBlock_Params.Get_UserType

function TDocument_CopyBlock_Params.Get_Data: IUnknown;
//#UC START# *C81B57108B26_A781AE4C071Dget_var*
//#UC END# *C81B57108B26_A781AE4C071Dget_var*
begin
//#UC START# *C81B57108B26_A781AE4C071Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *C81B57108B26_A781AE4C071Dget_impl*
end;//TDocument_CopyBlock_Params.Get_Data

procedure TDocument_CopyBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_CopyBlock_Params.ClearFields

class function Op_Document_CopyBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CopyBlock у сущности }
//#UC START# *014BD31DD6D9_C7755104ECB3_var*
//#UC END# *014BD31DD6D9_C7755104ECB3_var*
begin
//#UC START# *014BD31DD6D9_C7755104ECB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *014BD31DD6D9_C7755104ECB3_impl*
end;//Op_Document_CopyBlock.Call

class function Op_Document_CopyBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CopyBlock у агрегации }
//#UC START# *318B930D6129_C7755104ECB3_var*
//#UC END# *318B930D6129_C7755104ECB3_var*
begin
//#UC START# *318B930D6129_C7755104ECB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *318B930D6129_C7755104ECB3_impl*
end;//Op_Document_CopyBlock.Call

class function Op_Document_CopyBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CopyBlock у формы }
//#UC START# *676A61C27D5E_C7755104ECB3_var*
//#UC END# *676A61C27D5E_C7755104ECB3_var*
begin
//#UC START# *676A61C27D5E_C7755104ECB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *676A61C27D5E_C7755104ECB3_impl*
end;//Op_Document_CopyBlock.Call

class function Op_Document_CopyBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.CopyBlock у контейнера }
//#UC START# *5044EE3A4C12_C7755104ECB3_var*
//#UC END# *5044EE3A4C12_C7755104ECB3_var*
begin
//#UC START# *5044EE3A4C12_C7755104ECB3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5044EE3A4C12_C7755104ECB3_impl*
end;//Op_Document_CopyBlock.Call

constructor TDocument_PrintBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
 {* Конструктор TDocument_PrintBlock_Params }
//#UC START# *891778DA2273_89FEE1552152_var*
//#UC END# *891778DA2273_89FEE1552152_var*
begin
//#UC START# *891778DA2273_89FEE1552152_impl*
 !!! Needs to be implemented !!!
//#UC END# *891778DA2273_89FEE1552152_impl*
end;//TDocument_PrintBlock_Params.Create

class function TDocument_PrintBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_PrintBlock_Params;
 {* Фабрика TDocument_PrintBlock_Params }
var
 l_Inst : TDocument_PrintBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_PrintBlock_Params.Make

function TDocument_PrintBlock_Params.Get_UserType: Integer;
//#UC START# *BDE45048DB2B_89FEE1552152get_var*
//#UC END# *BDE45048DB2B_89FEE1552152get_var*
begin
//#UC START# *BDE45048DB2B_89FEE1552152get_impl*
 !!! Needs to be implemented !!!
//#UC END# *BDE45048DB2B_89FEE1552152get_impl*
end;//TDocument_PrintBlock_Params.Get_UserType

function TDocument_PrintBlock_Params.Get_Data: IUnknown;
//#UC START# *DCE3C2C4FBA1_89FEE1552152get_var*
//#UC END# *DCE3C2C4FBA1_89FEE1552152get_var*
begin
//#UC START# *DCE3C2C4FBA1_89FEE1552152get_impl*
 !!! Needs to be implemented !!!
//#UC END# *DCE3C2C4FBA1_89FEE1552152get_impl*
end;//TDocument_PrintBlock_Params.Get_Data

procedure TDocument_PrintBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_PrintBlock_Params.ClearFields

class function Op_Document_PrintBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PrintBlock у сущности }
//#UC START# *CA5637256D13_95519D349674_var*
//#UC END# *CA5637256D13_95519D349674_var*
begin
//#UC START# *CA5637256D13_95519D349674_impl*
 !!! Needs to be implemented !!!
//#UC END# *CA5637256D13_95519D349674_impl*
end;//Op_Document_PrintBlock.Call

class function Op_Document_PrintBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PrintBlock у агрегации }
//#UC START# *FA95F714F763_95519D349674_var*
//#UC END# *FA95F714F763_95519D349674_var*
begin
//#UC START# *FA95F714F763_95519D349674_impl*
 !!! Needs to be implemented !!!
//#UC END# *FA95F714F763_95519D349674_impl*
end;//Op_Document_PrintBlock.Call

class function Op_Document_PrintBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PrintBlock у формы }
//#UC START# *4E0117B1BF67_95519D349674_var*
//#UC END# *4E0117B1BF67_95519D349674_var*
begin
//#UC START# *4E0117B1BF67_95519D349674_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0117B1BF67_95519D349674_impl*
end;//Op_Document_PrintBlock.Call

class function Op_Document_PrintBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PrintBlock у контейнера }
//#UC START# *FA1F624F7461_95519D349674_var*
//#UC END# *FA1F624F7461_95519D349674_var*
begin
//#UC START# *FA1F624F7461_95519D349674_impl*
 !!! Needs to be implemented !!!
//#UC END# *FA1F624F7461_95519D349674_impl*
end;//Op_Document_PrintBlock.Call

constructor TDocument_PrintDialogBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
 {* Конструктор TDocument_PrintDialogBlock_Params }
//#UC START# *C0B724EB14E7_DE4463327F90_var*
//#UC END# *C0B724EB14E7_DE4463327F90_var*
begin
//#UC START# *C0B724EB14E7_DE4463327F90_impl*
 !!! Needs to be implemented !!!
//#UC END# *C0B724EB14E7_DE4463327F90_impl*
end;//TDocument_PrintDialogBlock_Params.Create

class function TDocument_PrintDialogBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_PrintDialogBlock_Params;
 {* Фабрика TDocument_PrintDialogBlock_Params }
var
 l_Inst : TDocument_PrintDialogBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_PrintDialogBlock_Params.Make

function TDocument_PrintDialogBlock_Params.Get_UserType: Integer;
//#UC START# *07740B4D4672_DE4463327F90get_var*
//#UC END# *07740B4D4672_DE4463327F90get_var*
begin
//#UC START# *07740B4D4672_DE4463327F90get_impl*
 !!! Needs to be implemented !!!
//#UC END# *07740B4D4672_DE4463327F90get_impl*
end;//TDocument_PrintDialogBlock_Params.Get_UserType

function TDocument_PrintDialogBlock_Params.Get_Data: IUnknown;
//#UC START# *89F6B4730A57_DE4463327F90get_var*
//#UC END# *89F6B4730A57_DE4463327F90get_var*
begin
//#UC START# *89F6B4730A57_DE4463327F90get_impl*
 !!! Needs to be implemented !!!
//#UC END# *89F6B4730A57_DE4463327F90get_impl*
end;//TDocument_PrintDialogBlock_Params.Get_Data

procedure TDocument_PrintDialogBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_PrintDialogBlock_Params.ClearFields

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PrintDialogBlock у сущности }
//#UC START# *18C9FA7F2175_8CBF76A0924B_var*
//#UC END# *18C9FA7F2175_8CBF76A0924B_var*
begin
//#UC START# *18C9FA7F2175_8CBF76A0924B_impl*
 !!! Needs to be implemented !!!
//#UC END# *18C9FA7F2175_8CBF76A0924B_impl*
end;//Op_Document_PrintDialogBlock.Call

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PrintDialogBlock у агрегации }
//#UC START# *4909BA6DABC5_8CBF76A0924B_var*
//#UC END# *4909BA6DABC5_8CBF76A0924B_var*
begin
//#UC START# *4909BA6DABC5_8CBF76A0924B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4909BA6DABC5_8CBF76A0924B_impl*
end;//Op_Document_PrintDialogBlock.Call

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PrintDialogBlock у формы }
//#UC START# *3A54497BE770_8CBF76A0924B_var*
//#UC END# *3A54497BE770_8CBF76A0924B_var*
begin
//#UC START# *3A54497BE770_8CBF76A0924B_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A54497BE770_8CBF76A0924B_impl*
end;//Op_Document_PrintDialogBlock.Call

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PrintDialogBlock у контейнера }
//#UC START# *CF95238E3E60_8CBF76A0924B_var*
//#UC END# *CF95238E3E60_8CBF76A0924B_var*
begin
//#UC START# *CF95238E3E60_8CBF76A0924B_impl*
 !!! Needs to be implemented !!!
//#UC END# *CF95238E3E60_8CBF76A0924B_impl*
end;//Op_Document_PrintDialogBlock.Call

constructor TDocument_PreviewBlock_Params.Create(const aData: IUnknown;
 aUserType: Integer);
 {* Конструктор TDocument_PreviewBlock_Params }
//#UC START# *91BE1AAAD2DF_2BF18BD87BA8_var*
//#UC END# *91BE1AAAD2DF_2BF18BD87BA8_var*
begin
//#UC START# *91BE1AAAD2DF_2BF18BD87BA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *91BE1AAAD2DF_2BF18BD87BA8_impl*
end;//TDocument_PreviewBlock_Params.Create

class function TDocument_PreviewBlock_Params.Make(const aData: IUnknown;
 aUserType: Integer): IDocument_PreviewBlock_Params;
 {* Фабрика TDocument_PreviewBlock_Params }
var
 l_Inst : TDocument_PreviewBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_PreviewBlock_Params.Make

function TDocument_PreviewBlock_Params.Get_Data: IUnknown;
//#UC START# *39384E7F050F_2BF18BD87BA8get_var*
//#UC END# *39384E7F050F_2BF18BD87BA8get_var*
begin
//#UC START# *39384E7F050F_2BF18BD87BA8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *39384E7F050F_2BF18BD87BA8get_impl*
end;//TDocument_PreviewBlock_Params.Get_Data

function TDocument_PreviewBlock_Params.Get_UserType: Integer;
//#UC START# *F9A96D6C34A4_2BF18BD87BA8get_var*
//#UC END# *F9A96D6C34A4_2BF18BD87BA8get_var*
begin
//#UC START# *F9A96D6C34A4_2BF18BD87BA8get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F9A96D6C34A4_2BF18BD87BA8get_impl*
end;//TDocument_PreviewBlock_Params.Get_UserType

procedure TDocument_PreviewBlock_Params.ClearFields;
begin
 f_Data := nil;
 inherited;
end;//TDocument_PreviewBlock_Params.ClearFields

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmEntity;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PreviewBlock у сущности }
//#UC START# *5F8149F03A97_FAE8DF879782_var*
//#UC END# *5F8149F03A97_FAE8DF879782_var*
begin
//#UC START# *5F8149F03A97_FAE8DF879782_impl*
 !!! Needs to be implemented !!!
//#UC END# *5F8149F03A97_FAE8DF879782_impl*
end;//Op_Document_PreviewBlock.Call

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmAggregate;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PreviewBlock у агрегации }
//#UC START# *8FC109DFC4E7_FAE8DF879782_var*
//#UC END# *8FC109DFC4E7_FAE8DF879782_var*
begin
//#UC START# *8FC109DFC4E7_FAE8DF879782_impl*
 !!! Needs to be implemented !!!
//#UC END# *8FC109DFC4E7_FAE8DF879782_impl*
end;//Op_Document_PreviewBlock.Call

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmEntityForm;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PreviewBlock у формы }
//#UC START# *35A8173F3224_FAE8DF879782_var*
//#UC END# *35A8173F3224_FAE8DF879782_var*
begin
//#UC START# *35A8173F3224_FAE8DF879782_impl*
 !!! Needs to be implemented !!!
//#UC END# *35A8173F3224_FAE8DF879782_impl*
end;//Op_Document_PreviewBlock.Call

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmContainer;
 const aData: IUnknown;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.PreviewBlock у контейнера }
//#UC START# *27C435BFE686_FAE8DF879782_var*
//#UC END# *27C435BFE686_FAE8DF879782_var*
begin
//#UC START# *27C435BFE686_FAE8DF879782_impl*
 !!! Needs to be implemented !!!
//#UC END# *27C435BFE686_FAE8DF879782_impl*
end;//Op_Document_PreviewBlock.Call

constructor TDocument_ShowRespondentListToPart_Params.Create(const aList: IPositionList;
 const aCurrent: Il3SimpleNode);
 {* Конструктор TDocument_ShowRespondentListToPart_Params }
//#UC START# *B1996D506120_1D017EA41521_var*
//#UC END# *B1996D506120_1D017EA41521_var*
begin
//#UC START# *B1996D506120_1D017EA41521_impl*
 !!! Needs to be implemented !!!
//#UC END# *B1996D506120_1D017EA41521_impl*
end;//TDocument_ShowRespondentListToPart_Params.Create

class function TDocument_ShowRespondentListToPart_Params.Make(const aList: IPositionList;
 const aCurrent: Il3SimpleNode): IDocument_ShowRespondentListToPart_Params;
 {* Фабрика TDocument_ShowRespondentListToPart_Params }
var
 l_Inst : TDocument_ShowRespondentListToPart_Params;
begin
 l_Inst := Create(aList, aCurrent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_ShowRespondentListToPart_Params.Make

function TDocument_ShowRespondentListToPart_Params.Get_Current: Il3SimpleNode;
//#UC START# *0391C15D5BF2_1D017EA41521get_var*
//#UC END# *0391C15D5BF2_1D017EA41521get_var*
begin
//#UC START# *0391C15D5BF2_1D017EA41521get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0391C15D5BF2_1D017EA41521get_impl*
end;//TDocument_ShowRespondentListToPart_Params.Get_Current

function TDocument_ShowRespondentListToPart_Params.Get_List: IPositionList;
//#UC START# *76A60762905A_1D017EA41521get_var*
//#UC END# *76A60762905A_1D017EA41521get_var*
begin
//#UC START# *76A60762905A_1D017EA41521get_impl*
 !!! Needs to be implemented !!!
//#UC END# *76A60762905A_1D017EA41521get_impl*
end;//TDocument_ShowRespondentListToPart_Params.Get_List

procedure TDocument_ShowRespondentListToPart_Params.ClearFields;
begin
 Finalize(f_List);
 f_Current := nil;
 inherited;
end;//TDocument_ShowRespondentListToPart_Params.ClearFields

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmEntity;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* Вызов операции Document.ShowRespondentListToPart у сущности }
//#UC START# *6C107C4A9CB5_720EF60C0BA8_var*
//#UC END# *6C107C4A9CB5_720EF60C0BA8_var*
begin
//#UC START# *6C107C4A9CB5_720EF60C0BA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *6C107C4A9CB5_720EF60C0BA8_impl*
end;//Op_Document_ShowRespondentListToPart.Call

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmAggregate;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* Вызов операции Document.ShowRespondentListToPart у агрегации }
//#UC START# *9C503C392705_720EF60C0BA8_var*
//#UC END# *9C503C392705_720EF60C0BA8_var*
begin
//#UC START# *9C503C392705_720EF60C0BA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *9C503C392705_720EF60C0BA8_impl*
end;//Op_Document_ShowRespondentListToPart.Call

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmEntityForm;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* Вызов операции Document.ShowRespondentListToPart у формы }
//#UC START# *160DC96B0DA5_720EF60C0BA8_var*
//#UC END# *160DC96B0DA5_720EF60C0BA8_var*
begin
//#UC START# *160DC96B0DA5_720EF60C0BA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *160DC96B0DA5_720EF60C0BA8_impl*
end;//Op_Document_ShowRespondentListToPart.Call

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmContainer;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* Вызов операции Document.ShowRespondentListToPart у контейнера }
//#UC START# *64C120A226A9_720EF60C0BA8_var*
//#UC END# *64C120A226A9_720EF60C0BA8_var*
begin
//#UC START# *64C120A226A9_720EF60C0BA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *64C120A226A9_720EF60C0BA8_impl*
end;//Op_Document_ShowRespondentListToPart.Call

constructor TDocument_ShowCorrespondentListToPart_Params.Create(const aList: IPositionList;
 const aCurrent: Il3SimpleNode);
 {* Конструктор TDocument_ShowCorrespondentListToPart_Params }
//#UC START# *FA21C0D620AF_0F9FB6EFDC40_var*
//#UC END# *FA21C0D620AF_0F9FB6EFDC40_var*
begin
//#UC START# *FA21C0D620AF_0F9FB6EFDC40_impl*
 !!! Needs to be implemented !!!
//#UC END# *FA21C0D620AF_0F9FB6EFDC40_impl*
end;//TDocument_ShowCorrespondentListToPart_Params.Create

class function TDocument_ShowCorrespondentListToPart_Params.Make(const aList: IPositionList;
 const aCurrent: Il3SimpleNode): IDocument_ShowCorrespondentListToPart_Params;
 {* Фабрика TDocument_ShowCorrespondentListToPart_Params }
var
 l_Inst : TDocument_ShowCorrespondentListToPart_Params;
begin
 l_Inst := Create(aList, aCurrent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_ShowCorrespondentListToPart_Params.Make

function TDocument_ShowCorrespondentListToPart_Params.Get_Current: Il3SimpleNode;
//#UC START# *38B44EED5467_0F9FB6EFDC40get_var*
//#UC END# *38B44EED5467_0F9FB6EFDC40get_var*
begin
//#UC START# *38B44EED5467_0F9FB6EFDC40get_impl*
 !!! Needs to be implemented !!!
//#UC END# *38B44EED5467_0F9FB6EFDC40get_impl*
end;//TDocument_ShowCorrespondentListToPart_Params.Get_Current

function TDocument_ShowCorrespondentListToPart_Params.Get_List: IPositionList;
//#UC START# *7B9182FE27B4_0F9FB6EFDC40get_var*
//#UC END# *7B9182FE27B4_0F9FB6EFDC40get_var*
begin
//#UC START# *7B9182FE27B4_0F9FB6EFDC40get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7B9182FE27B4_0F9FB6EFDC40get_impl*
end;//TDocument_ShowCorrespondentListToPart_Params.Get_List

procedure TDocument_ShowCorrespondentListToPart_Params.ClearFields;
begin
 Finalize(f_List);
 f_Current := nil;
 inherited;
end;//TDocument_ShowCorrespondentListToPart_Params.ClearFields

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmEntity;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* Вызов операции Document.ShowCorrespondentListToPart у сущности }
//#UC START# *DBF74623B789_8CB18BCB7C94_var*
//#UC END# *DBF74623B789_8CB18BCB7C94_var*
begin
//#UC START# *DBF74623B789_8CB18BCB7C94_impl*
 !!! Needs to be implemented !!!
//#UC END# *DBF74623B789_8CB18BCB7C94_impl*
end;//Op_Document_ShowCorrespondentListToPart.Call

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmAggregate;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* Вызов операции Document.ShowCorrespondentListToPart у агрегации }
//#UC START# *BEFB030741DA_8CB18BCB7C94_var*
//#UC END# *BEFB030741DA_8CB18BCB7C94_var*
begin
//#UC START# *BEFB030741DA_8CB18BCB7C94_impl*
 !!! Needs to be implemented !!!
//#UC END# *BEFB030741DA_8CB18BCB7C94_impl*
end;//Op_Document_ShowCorrespondentListToPart.Call

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmEntityForm;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* Вызов операции Document.ShowCorrespondentListToPart у формы }
//#UC START# *FDC6BE6AB1C2_8CB18BCB7C94_var*
//#UC END# *FDC6BE6AB1C2_8CB18BCB7C94_var*
begin
//#UC START# *FDC6BE6AB1C2_8CB18BCB7C94_impl*
 !!! Needs to be implemented !!!
//#UC END# *FDC6BE6AB1C2_8CB18BCB7C94_impl*
end;//Op_Document_ShowCorrespondentListToPart.Call

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmContainer;
 const aList: IPositionList;
 const aCurrent: Il3SimpleNode = nil): Boolean;
 {* Вызов операции Document.ShowCorrespondentListToPart у контейнера }
//#UC START# *378B8592E3C9_8CB18BCB7C94_var*
//#UC END# *378B8592E3C9_8CB18BCB7C94_var*
begin
//#UC START# *378B8592E3C9_8CB18BCB7C94_impl*
 !!! Needs to be implemented !!!
//#UC END# *378B8592E3C9_8CB18BCB7C94_impl*
end;//Op_Document_ShowCorrespondentListToPart.Call

constructor TDocument_ModifyBookmarkNotify_Params.Create(const anEntity: IUnknown);
 {* Конструктор TDocument_ModifyBookmarkNotify_Params }
//#UC START# *4B6BA3830FC2_548EAA742ABF_var*
//#UC END# *4B6BA3830FC2_548EAA742ABF_var*
begin
//#UC START# *4B6BA3830FC2_548EAA742ABF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B6BA3830FC2_548EAA742ABF_impl*
end;//TDocument_ModifyBookmarkNotify_Params.Create

class function TDocument_ModifyBookmarkNotify_Params.Make(const anEntity: IUnknown): IDocument_ModifyBookmarkNotify_Params;
 {* Фабрика TDocument_ModifyBookmarkNotify_Params }
var
 l_Inst : TDocument_ModifyBookmarkNotify_Params;
begin
 l_Inst := Create(anEntity);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_ModifyBookmarkNotify_Params.Make

function TDocument_ModifyBookmarkNotify_Params.Get_nEntity: IUnknown;
//#UC START# *58C341EDC86C_548EAA742ABFget_var*
//#UC END# *58C341EDC86C_548EAA742ABFget_var*
begin
//#UC START# *58C341EDC86C_548EAA742ABFget_impl*
 !!! Needs to be implemented !!!
//#UC END# *58C341EDC86C_548EAA742ABFget_impl*
end;//TDocument_ModifyBookmarkNotify_Params.Get_nEntity

procedure TDocument_ModifyBookmarkNotify_Params.ClearFields;
begin
 f_nEntity := nil;
 inherited;
end;//TDocument_ModifyBookmarkNotify_Params.ClearFields

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmEntity;
 const anEntity: IUnknown): Boolean;
 {* Вызов операции Document.ModifyBookmarkNotify у сущности }
//#UC START# *0253DD5C22D0_1BAFA5E0E927_var*
//#UC END# *0253DD5C22D0_1BAFA5E0E927_var*
begin
//#UC START# *0253DD5C22D0_1BAFA5E0E927_impl*
 !!! Needs to be implemented !!!
//#UC END# *0253DD5C22D0_1BAFA5E0E927_impl*
end;//Op_Document_ModifyBookmarkNotify.Call

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmAggregate;
 const anEntity: IUnknown): Boolean;
 {* Вызов операции Document.ModifyBookmarkNotify у агрегации }
//#UC START# *32939D4AAD20_1BAFA5E0E927_var*
//#UC END# *32939D4AAD20_1BAFA5E0E927_var*
begin
//#UC START# *32939D4AAD20_1BAFA5E0E927_impl*
 !!! Needs to be implemented !!!
//#UC END# *32939D4AAD20_1BAFA5E0E927_impl*
end;//Op_Document_ModifyBookmarkNotify.Call

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmEntityForm;
 const anEntity: IUnknown): Boolean;
 {* Вызов операции Document.ModifyBookmarkNotify у формы }
//#UC START# *A89EEBDBD3AF_1BAFA5E0E927_var*
//#UC END# *A89EEBDBD3AF_1BAFA5E0E927_var*
begin
//#UC START# *A89EEBDBD3AF_1BAFA5E0E927_impl*
 !!! Needs to be implemented !!!
//#UC END# *A89EEBDBD3AF_1BAFA5E0E927_impl*
end;//Op_Document_ModifyBookmarkNotify.Call

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmContainer;
 const anEntity: IUnknown): Boolean;
 {* Вызов операции Document.ModifyBookmarkNotify у контейнера }
//#UC START# *4EF2E723D26F_1BAFA5E0E927_var*
//#UC END# *4EF2E723D26F_1BAFA5E0E927_var*
begin
//#UC START# *4EF2E723D26F_1BAFA5E0E927_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EF2E723D26F_1BAFA5E0E927_impl*
end;//Op_Document_ModifyBookmarkNotify.Call

class procedure Op_Document_ModifyBookmarkNotify.Broadcast(const anEntity: IUnknown);
 {* Вызов операции Document.ModifyBookmarkNotify у всех зарегистрированных сущностей }
//#UC START# *97CCF3B36468_1BAFA5E0E927_var*
//#UC END# *97CCF3B36468_1BAFA5E0E927_var*
begin
//#UC START# *97CCF3B36468_1BAFA5E0E927_impl*
 !!! Needs to be implemented !!!
//#UC END# *97CCF3B36468_1BAFA5E0E927_impl*
end;//Op_Document_ModifyBookmarkNotify.Broadcast

constructor TDocument_AddBookmarkFromContents_Params.Create(const aTag: Il3TagRef);
 {* Конструктор TDocument_AddBookmarkFromContents_Params }
//#UC START# *FE400DD37CC3_61FB0F0FBC39_var*
//#UC END# *FE400DD37CC3_61FB0F0FBC39_var*
begin
//#UC START# *FE400DD37CC3_61FB0F0FBC39_impl*
 !!! Needs to be implemented !!!
//#UC END# *FE400DD37CC3_61FB0F0FBC39_impl*
end;//TDocument_AddBookmarkFromContents_Params.Create

class function TDocument_AddBookmarkFromContents_Params.Make(const aTag: Il3TagRef): IDocument_AddBookmarkFromContents_Params;
 {* Фабрика TDocument_AddBookmarkFromContents_Params }
var
 l_Inst : TDocument_AddBookmarkFromContents_Params;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_AddBookmarkFromContents_Params.Make

function TDocument_AddBookmarkFromContents_Params.Get_Tag: Il3TagRef;
//#UC START# *A560335491E1_61FB0F0FBC39get_var*
//#UC END# *A560335491E1_61FB0F0FBC39get_var*
begin
//#UC START# *A560335491E1_61FB0F0FBC39get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A560335491E1_61FB0F0FBC39get_impl*
end;//TDocument_AddBookmarkFromContents_Params.Get_Tag

procedure TDocument_AddBookmarkFromContents_Params.ClearFields;
begin
 f_Tag := nil;
 inherited;
end;//TDocument_AddBookmarkFromContents_Params.ClearFields

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmEntity;
 const aTag: Il3TagRef): Boolean;
 {* Вызов операции Document.AddBookmarkFromContents у сущности }
//#UC START# *8D29E3EFCEE5_6D64DC5038F6_var*
//#UC END# *8D29E3EFCEE5_6D64DC5038F6_var*
begin
//#UC START# *8D29E3EFCEE5_6D64DC5038F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *8D29E3EFCEE5_6D64DC5038F6_impl*
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmAggregate;
 const aTag: Il3TagRef): Boolean;
 {* Вызов операции Document.AddBookmarkFromContents у агрегации }
//#UC START# *702DA0D35936_6D64DC5038F6_var*
//#UC END# *702DA0D35936_6D64DC5038F6_var*
begin
//#UC START# *702DA0D35936_6D64DC5038F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *702DA0D35936_6D64DC5038F6_impl*
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmEntityForm;
 const aTag: Il3TagRef): Boolean;
 {* Вызов операции Document.AddBookmarkFromContents у формы }
//#UC START# *E6EC0DDACCBA_6D64DC5038F6_var*
//#UC END# *E6EC0DDACCBA_6D64DC5038F6_var*
begin
//#UC START# *E6EC0DDACCBA_6D64DC5038F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *E6EC0DDACCBA_6D64DC5038F6_impl*
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmContainer;
 const aTag: Il3TagRef): Boolean;
 {* Вызов операции Document.AddBookmarkFromContents у контейнера }
//#UC START# *0D85596FF3B9_6D64DC5038F6_var*
//#UC END# *0D85596FF3B9_6D64DC5038F6_var*
begin
//#UC START# *0D85596FF3B9_6D64DC5038F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *0D85596FF3B9_6D64DC5038F6_impl*
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Document.OpenNotSureTopic у сущности }
//#UC START# *C7FB3B42C189_DB288CB1D344_var*
//#UC END# *C7FB3B42C189_DB288CB1D344_var*
begin
//#UC START# *C7FB3B42C189_DB288CB1D344_impl*
 !!! Needs to be implemented !!!
//#UC END# *C7FB3B42C189_DB288CB1D344_impl*
end;//Op_Document_OpenNotSureTopic.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Document.OpenNotSureTopic у агрегации }
//#UC START# *F83AFB314BD9_DB288CB1D344_var*
//#UC END# *F83AFB314BD9_DB288CB1D344_var*
begin
//#UC START# *F83AFB314BD9_DB288CB1D344_impl*
 !!! Needs to be implemented !!!
//#UC END# *F83AFB314BD9_DB288CB1D344_impl*
end;//Op_Document_OpenNotSureTopic.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Document.OpenNotSureTopic у формы }
//#UC START# *6D2096503464_DB288CB1D344_var*
//#UC END# *6D2096503464_DB288CB1D344_var*
begin
//#UC START# *6D2096503464_DB288CB1D344_impl*
 !!! Needs to be implemented !!!
//#UC END# *6D2096503464_DB288CB1D344_impl*
end;//Op_Document_OpenNotSureTopic.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Document.OpenNotSureTopic у контейнера }
//#UC START# *330C350AF2EC_DB288CB1D344_var*
//#UC END# *330C350AF2EC_DB288CB1D344_var*
begin
//#UC START# *330C350AF2EC_DB288CB1D344_impl*
 !!! Needs to be implemented !!!
//#UC END# *330C350AF2EC_DB288CB1D344_impl*
end;//Op_Document_OpenNotSureTopic.Call

constructor TDocument_GotoPara_Params.Create(const aPara: Il3TagRef;
 aUserType: Integer);
 {* Конструктор TDocument_GotoPara_Params }
//#UC START# *F0D4BA58CB25_DD22BE3427C2_var*
//#UC END# *F0D4BA58CB25_DD22BE3427C2_var*
begin
//#UC START# *F0D4BA58CB25_DD22BE3427C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *F0D4BA58CB25_DD22BE3427C2_impl*
end;//TDocument_GotoPara_Params.Create

class function TDocument_GotoPara_Params.Make(const aPara: Il3TagRef;
 aUserType: Integer): IDocument_GotoPara_Params;
 {* Фабрика TDocument_GotoPara_Params }
var
 l_Inst : TDocument_GotoPara_Params;
begin
 l_Inst := Create(aPara, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TDocument_GotoPara_Params.Make

function TDocument_GotoPara_Params.Get_UserType: Integer;
//#UC START# *25C5AB788E08_DD22BE3427C2get_var*
//#UC END# *25C5AB788E08_DD22BE3427C2get_var*
begin
//#UC START# *25C5AB788E08_DD22BE3427C2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *25C5AB788E08_DD22BE3427C2get_impl*
end;//TDocument_GotoPara_Params.Get_UserType

function TDocument_GotoPara_Params.Get_ResultValue: Boolean;
//#UC START# *8431719058A5_DD22BE3427C2get_var*
//#UC END# *8431719058A5_DD22BE3427C2get_var*
begin
//#UC START# *8431719058A5_DD22BE3427C2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8431719058A5_DD22BE3427C2get_impl*
end;//TDocument_GotoPara_Params.Get_ResultValue

procedure TDocument_GotoPara_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *8431719058A5_DD22BE3427C2set_var*
//#UC END# *8431719058A5_DD22BE3427C2set_var*
begin
//#UC START# *8431719058A5_DD22BE3427C2set_impl*
 !!! Needs to be implemented !!!
//#UC END# *8431719058A5_DD22BE3427C2set_impl*
end;//TDocument_GotoPara_Params.Set_ResultValue

function TDocument_GotoPara_Params.Get_Para: Il3TagRef;
//#UC START# *B9ED751A0655_DD22BE3427C2get_var*
//#UC END# *B9ED751A0655_DD22BE3427C2get_var*
begin
//#UC START# *B9ED751A0655_DD22BE3427C2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B9ED751A0655_DD22BE3427C2get_impl*
end;//TDocument_GotoPara_Params.Get_Para

procedure TDocument_GotoPara_Params.ClearFields;
begin
 f_Para := nil;
 inherited;
end;//TDocument_GotoPara_Params.ClearFields

class function Op_Document_GotoPara.Call(const aTarget: IvcmEntity;
 const aPara: Il3TagRef;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.GotoPara у сущности }
//#UC START# *7B7EDCE754B3_B980EDF4F392_var*
//#UC END# *7B7EDCE754B3_B980EDF4F392_var*
begin
//#UC START# *7B7EDCE754B3_B980EDF4F392_impl*
 !!! Needs to be implemented !!!
//#UC END# *7B7EDCE754B3_B980EDF4F392_impl*
end;//Op_Document_GotoPara.Call

class function Op_Document_GotoPara.Call(const aTarget: IvcmAggregate;
 const aPara: Il3TagRef;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.GotoPara у агрегации }
//#UC START# *ABBE9CD6DF03_B980EDF4F392_var*
//#UC END# *ABBE9CD6DF03_B980EDF4F392_var*
begin
//#UC START# *ABBE9CD6DF03_B980EDF4F392_impl*
 !!! Needs to be implemented !!!
//#UC END# *ABBE9CD6DF03_B980EDF4F392_impl*
end;//Op_Document_GotoPara.Call

class function Op_Document_GotoPara.Call(const aTarget: IvcmEntityForm;
 const aPara: Il3TagRef;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.GotoPara у формы }
//#UC START# *65D9AECCE4D4_B980EDF4F392_var*
//#UC END# *65D9AECCE4D4_B980EDF4F392_var*
begin
//#UC START# *65D9AECCE4D4_B980EDF4F392_impl*
 !!! Needs to be implemented !!!
//#UC END# *65D9AECCE4D4_B980EDF4F392_impl*
end;//Op_Document_GotoPara.Call

class function Op_Document_GotoPara.Call(const aTarget: IvcmContainer;
 const aPara: Il3TagRef;
 aUserType: Integer): Boolean;
 {* Вызов операции Document.GotoPara у контейнера }
//#UC START# *D2BF38C7A6AD_B980EDF4F392_var*
//#UC END# *D2BF38C7A6AD_B980EDF4F392_var*
begin
//#UC START# *D2BF38C7A6AD_B980EDF4F392_impl*
 !!! Needs to be implemented !!!
//#UC END# *D2BF38C7A6AD_B980EDF4F392_impl*
end;//Op_Document_GotoPara.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
