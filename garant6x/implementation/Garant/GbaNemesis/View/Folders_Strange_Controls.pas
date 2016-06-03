unit Folders_Strange_Controls;
 {* Странное }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4A96A8C10357)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseTypesUnit
 , BaseTreeSupportUnit
 , FoldersUnit
 , FiltersUnit
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , eeInterfaces
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IAdditionInfo_Close_Params = interface
  {* Параметры для операции AdditionInfo.Close }
  function Get_ModalResult: Integer;
  property ModalResult: Integer
   read Get_ModalResult;
 end;//IAdditionInfo_Close_Params

 Op_AdditionInfo_Close = {final} class
  {* Класс для вызова операции AdditionInfo.Close }
  public
   class function Call(const aTarget: IvcmEntity;
    aModalResult: Integer = Controls.mrCancel): Boolean; overload;
    {* Вызов операции AdditionInfo.Close у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aModalResult: Integer = Controls.mrCancel): Boolean; overload;
    {* Вызов операции AdditionInfo.Close у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aModalResult: Integer = Controls.mrCancel): Boolean; overload;
    {* Вызов операции AdditionInfo.Close у формы }
   class function Call(const aTarget: IvcmContainer;
    aModalResult: Integer = Controls.mrCancel): Boolean; overload;
    {* Вызов операции AdditionInfo.Close у контейнера }
 end;//Op_AdditionInfo_Close

 IFolderElement_InternalEditByFoldersNode_Params = interface
  {* Параметры для операции FolderElement.InternalEditByFoldersNode }
  function Get_Node: IFoldersNode;
  function Get_InternalCall: Boolean;
  property Node: IFoldersNode
   read Get_Node;
  property InternalCall: Boolean
   read Get_InternalCall;
 end;//IFolderElement_InternalEditByFoldersNode_Params

 Op_FolderElement_InternalEditByFoldersNode = {final} class
  {* Класс для вызова операции FolderElement.InternalEditByFoldersNode }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* Вызов операции FolderElement.InternalEditByFoldersNode у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* Вызов операции FolderElement.InternalEditByFoldersNode у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* Вызов операции FolderElement.InternalEditByFoldersNode у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* Вызов операции FolderElement.InternalEditByFoldersNode у контейнера }
 end;//Op_FolderElement_InternalEditByFoldersNode

 IFolderElement_InternalDelete_Params = interface
  {* Параметры для операции FolderElement.InternalDelete }
  function Get_Node: IFoldersNode;
  function Get_Ask: Boolean;
  function Get_ResultValue: TnsDeleteResult;
  procedure Set_ResultValue(aValue: TnsDeleteResult);
  property Node: IFoldersNode
   read Get_Node;
  property Ask: Boolean
   read Get_Ask;
  property ResultValue: TnsDeleteResult
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFolderElement_InternalDelete_Params

 Op_FolderElement_InternalDelete = {final} class
  {* Класс для вызова операции FolderElement.InternalDelete }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode;
    aAsk: Boolean = True): TnsDeleteResult; overload;
    {* Вызов операции FolderElement.InternalDelete у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode;
    aAsk: Boolean = True): TnsDeleteResult; overload;
    {* Вызов операции FolderElement.InternalDelete у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode;
    aAsk: Boolean = True): TnsDeleteResult; overload;
    {* Вызов операции FolderElement.InternalDelete у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode;
    aAsk: Boolean = True): TnsDeleteResult; overload;
    {* Вызов операции FolderElement.InternalDelete у контейнера }
 end;//Op_FolderElement_InternalDelete

 IFolderElement_InternalEdit_Params = interface
  {* Параметры для операции FolderElement.InternalEdit }
  function Get_Node: IeeNode;
  function Get_InternalCall: Boolean;
  property Node: IeeNode
   read Get_Node;
  property InternalCall: Boolean
   read Get_InternalCall;
 end;//IFolderElement_InternalEdit_Params

 Op_FolderElement_InternalEdit = {final} class
  {* Класс для вызова операции FolderElement.InternalEdit }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* Вызов операции FolderElement.InternalEdit у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* Вызов операции FolderElement.InternalEdit у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* Вызов операции FolderElement.InternalEdit у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* Вызов операции FolderElement.InternalEdit у контейнера }
 end;//Op_FolderElement_InternalEdit

 Op_FolderElement_DisableFilter = {final} class
  {* Класс для вызова операции FolderElement.DisableFilter }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции FolderElement.DisableFilter у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции FolderElement.DisableFilter у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции FolderElement.DisableFilter у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции FolderElement.DisableFilter у контейнера }
 end;//Op_FolderElement_DisableFilter

 IFolderElement_SetState_Params = interface
  {* Параметры для операции FolderElement.SetState }
  function Get_InfoType: TFoldersInfoType;
  property InfoType: TFoldersInfoType
   read Get_InfoType;
 end;//IFolderElement_SetState_Params

 Op_FolderElement_SetState = {final} class
  {* Класс для вызова операции FolderElement.SetState }
  public
   class function Call(const aTarget: IvcmEntity;
    aInfoType: TFoldersInfoType): Boolean; overload;
    {* Вызов операции FolderElement.SetState у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aInfoType: TFoldersInfoType): Boolean; overload;
    {* Вызов операции FolderElement.SetState у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aInfoType: TFoldersInfoType): Boolean; overload;
    {* Вызов операции FolderElement.SetState у формы }
   class function Call(const aTarget: IvcmContainer;
    aInfoType: TFoldersInfoType): Boolean; overload;
    {* Вызов операции FolderElement.SetState у контейнера }
 end;//Op_FolderElement_SetState

 Op_AdditionInfo_Show = {final} class
  {* Класс для вызова операции AdditionInfo.Show }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции AdditionInfo.Show у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции AdditionInfo.Show у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции AdditionInfo.Show у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции AdditionInfo.Show у контейнера }
 end;//Op_AdditionInfo_Show

 Op_AdditionInfo_Hide = {final} class
  {* Класс для вызова операции AdditionInfo.Hide }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции AdditionInfo.Hide у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции AdditionInfo.Hide у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции AdditionInfo.Hide у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции AdditionInfo.Hide у контейнера }
 end;//Op_AdditionInfo_Hide

 IAdditionInfo_SetCaption_Params = interface
  {* Параметры для операции AdditionInfo.SetCaption }
  function Get_Caption: Il3CString;
  property Caption: Il3CString
   read Get_Caption;
 end;//IAdditionInfo_SetCaption_Params

 Op_AdditionInfo_SetCaption = {final} class
  {* Класс для вызова операции AdditionInfo.SetCaption }
  public
   class function Call(const aTarget: IvcmEntity;
    const aCaption: Il3CString): Boolean; overload;
    {* Вызов операции AdditionInfo.SetCaption у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aCaption: Il3CString): Boolean; overload;
    {* Вызов операции AdditionInfo.SetCaption у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aCaption: Il3CString): Boolean; overload;
    {* Вызов операции AdditionInfo.SetCaption у формы }
   class function Call(const aTarget: IvcmContainer;
    const aCaption: Il3CString): Boolean; overload;
    {* Вызов операции AdditionInfo.SetCaption у контейнера }
 end;//Op_AdditionInfo_SetCaption

 IFolderElement_GetState_Params = interface
  {* Параметры для операции FolderElement.GetState }
  function Get_ResultValue: TFoldersInfoType;
  procedure Set_ResultValue(aValue: TFoldersInfoType);
  property ResultValue: TFoldersInfoType
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFolderElement_GetState_Params

 Op_FolderElement_GetState = {final} class
  {* Класс для вызова операции FolderElement.GetState }
  public
   class function Call(const aTarget: IvcmEntity): TFoldersInfoType; overload;
    {* Вызов операции FolderElement.GetState у сущности }
   class function Call(const aTarget: IvcmAggregate): TFoldersInfoType; overload;
    {* Вызов операции FolderElement.GetState у агрегации }
   class function Call(const aTarget: IvcmEntityForm): TFoldersInfoType; overload;
    {* Вызов операции FolderElement.GetState у формы }
   class function Call(const aTarget: IvcmContainer): TFoldersInfoType; overload;
    {* Вызов операции FolderElement.GetState у контейнера }
 end;//Op_FolderElement_GetState

 IFolderElement_SetLoadInfo_Params = interface
  {* Параметры для операции FolderElement.SetLoadInfo }
  function Get_Form: IvcmEntityForm;
  function Get_FolderFilterInfo: InsFolderFilterInfo;
  function Get_Caption: Il3CString;
  function Get_Data: IUnknown;
  function Get_nOp: TListLogicOperation;
  property Form: IvcmEntityForm
   read Get_Form;
  property FolderFilterInfo: InsFolderFilterInfo
   read Get_FolderFilterInfo;
  property Caption: Il3CString
   read Get_Caption;
  property Data: IUnknown
   read Get_Data;
  property nOp: TListLogicOperation
   read Get_nOp;
 end;//IFolderElement_SetLoadInfo_Params

 Op_FolderElement_SetLoadInfo = {final} class
  {* Класс для вызова операции FolderElement.SetLoadInfo }
  public
   class function Call(const aTarget: IvcmEntity;
    const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): Boolean; overload;
    {* Вызов операции FolderElement.SetLoadInfo у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): Boolean; overload;
    {* Вызов операции FolderElement.SetLoadInfo у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): Boolean; overload;
    {* Вызов операции FolderElement.SetLoadInfo у формы }
   class function Call(const aTarget: IvcmContainer;
    const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): Boolean; overload;
    {* Вызов операции FolderElement.SetLoadInfo у контейнера }
 end;//Op_FolderElement_SetLoadInfo

 IFolderElement_SetContent_Params = interface
  {* Параметры для операции FolderElement.SetContent }
  function Get_Node: IeeNode;
  function Get_IsNewFolder: Boolean;
  property Node: IeeNode
   read Get_Node;
  property IsNewFolder: Boolean
   read Get_IsNewFolder;
 end;//IFolderElement_SetContent_Params

 Op_FolderElement_SetContent = {final} class
  {* Класс для вызова операции FolderElement.SetContent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = False): Boolean; overload;
    {* Вызов операции FolderElement.SetContent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = False): Boolean; overload;
    {* Вызов операции FolderElement.SetContent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = False): Boolean; overload;
    {* Вызов операции FolderElement.SetContent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = False): Boolean; overload;
    {* Вызов операции FolderElement.SetContent у контейнера }
 end;//Op_FolderElement_SetContent

 IFolderElement_SetSaveInfo_Params = interface
  {* Параметры для операции FolderElement.SetSaveInfo }
  function Get_Form: IvcmEntityForm;
  function Get_FilterInfo: InsFolderFilterInfo;
  function Get_nElementType: TFoldersElementType;
  function Get_nEntity: IEntityBase;
  function Get_SaveAs: Boolean;
  property Form: IvcmEntityForm
   read Get_Form;
  property FilterInfo: InsFolderFilterInfo
   read Get_FilterInfo;
  property nElementType: TFoldersElementType
   read Get_nElementType;
  property nEntity: IEntityBase
   read Get_nEntity;
  property SaveAs: Boolean
   read Get_SaveAs;
 end;//IFolderElement_SetSaveInfo_Params

 Op_FolderElement_SetSaveInfo = {final} class
  {* Класс для вызова операции FolderElement.SetSaveInfo }
  public
   class function Call(const aTarget: IvcmEntity;
    const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Boolean; overload;
    {* Вызов операции FolderElement.SetSaveInfo у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Boolean; overload;
    {* Вызов операции FolderElement.SetSaveInfo у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Boolean; overload;
    {* Вызов операции FolderElement.SetSaveInfo у формы }
   class function Call(const aTarget: IvcmContainer;
    const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Boolean; overload;
    {* Вызов операции FolderElement.SetSaveInfo у контейнера }
 end;//Op_FolderElement_SetSaveInfo

 IFolderElement_ResetModificationOnDelete_Params = interface
  {* Параметры для операции FolderElement.ResetModificationOnDelete }
  function Get_Node: IeeNode;
  property Node: IeeNode
   read Get_Node;
 end;//IFolderElement_ResetModificationOnDelete_Params

 Op_FolderElement_ResetModificationOnDelete = {final} class
  {* Класс для вызова операции FolderElement.ResetModificationOnDelete }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции FolderElement.ResetModificationOnDelete у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции FolderElement.ResetModificationOnDelete у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции FolderElement.ResetModificationOnDelete у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции FolderElement.ResetModificationOnDelete у контейнера }
 end;//Op_FolderElement_ResetModificationOnDelete

 Op_FolderElement_SetFocus = {final} class
  {* Класс для вызова операции FolderElement.SetFocus }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции FolderElement.SetFocus у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции FolderElement.SetFocus у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции FolderElement.SetFocus у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции FolderElement.SetFocus у контейнера }
 end;//Op_FolderElement_SetFocus

 Op_FolderElement_Redraw = {final} class
  {* Класс для вызова операции FolderElement.Redraw }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции FolderElement.Redraw у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции FolderElement.Redraw у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции FolderElement.Redraw у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции FolderElement.Redraw у контейнера }
 end;//Op_FolderElement_Redraw

 Op_FolderElement_DisableSecurityPage = {final} class
  {* Класс для вызова операции FolderElement.DisableSecurityPage }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции FolderElement.DisableSecurityPage у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции FolderElement.DisableSecurityPage у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции FolderElement.DisableSecurityPage у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции FolderElement.DisableSecurityPage у контейнера }
 end;//Op_FolderElement_DisableSecurityPage

 ISavedQuery_SetFilterState_Params = interface
  {* Параметры для операции SavedQuery.SetFilterState }
  function Get_Node: INode;
  property Node: INode
   read Get_Node;
 end;//ISavedQuery_SetFilterState_Params

 Op_SavedQuery_SetFilterState = {final} class
  {* Класс для вызова операции SavedQuery.SetFilterState }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: INode): Boolean; overload;
    {* Вызов операции SavedQuery.SetFilterState у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: INode): Boolean; overload;
    {* Вызов операции SavedQuery.SetFilterState у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: INode): Boolean; overload;
    {* Вызов операции SavedQuery.SetFilterState у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: INode): Boolean; overload;
    {* Вызов операции SavedQuery.SetFilterState у контейнера }
 end;//Op_SavedQuery_SetFilterState

 IFolders_SetCurrent_Params = interface
  {* Параметры для операции Folders.SetCurrent }
  function Get_Node: IeeNode;
  property Node: IeeNode
   read Get_Node;
 end;//IFolders_SetCurrent_Params

 Op_Folders_SetCurrent = {final} class
  {* Класс для вызова операции Folders.SetCurrent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции Folders.SetCurrent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции Folders.SetCurrent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции Folders.SetCurrent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции Folders.SetCurrent у контейнера }
 end;//Op_Folders_SetCurrent

 IFolders_FiltrateByFilterInfo_Params = interface
  {* Параметры для операции Folders.FiltrateByFilterInfo }
  function Get_nInfo: InsFolderFilterInfo;
  property nInfo: InsFolderFilterInfo
   read Get_nInfo;
 end;//IFolders_FiltrateByFilterInfo_Params

 Op_Folders_FiltrateByFilterInfo = {final} class
  {* Класс для вызова операции Folders.FiltrateByFilterInfo }
  public
   class function Call(const aTarget: IvcmEntity;
    const anInfo: InsFolderFilterInfo): Boolean; overload;
    {* Вызов операции Folders.FiltrateByFilterInfo у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const anInfo: InsFolderFilterInfo): Boolean; overload;
    {* Вызов операции Folders.FiltrateByFilterInfo у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const anInfo: InsFolderFilterInfo): Boolean; overload;
    {* Вызов операции Folders.FiltrateByFilterInfo у формы }
   class function Call(const aTarget: IvcmContainer;
    const anInfo: InsFolderFilterInfo): Boolean; overload;
    {* Вызов операции Folders.FiltrateByFilterInfo у контейнера }
 end;//Op_Folders_FiltrateByFilterInfo

 Op_Folders_TryOpenConsultationAnswer = {final} class
  {* Класс для вызова операции Folders.TryOpenConsultationAnswer }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Folders.TryOpenConsultationAnswer у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Folders.TryOpenConsultationAnswer у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Folders.TryOpenConsultationAnswer у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Folders.TryOpenConsultationAnswer у контейнера }
 end;//Op_Folders_TryOpenConsultationAnswer

 Op_Folders_OpenMyConsultations = {final} class
  {* Класс для вызова операции Folders.OpenMyConsultations }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Folders.OpenMyConsultations у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Folders.OpenMyConsultations у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Folders.OpenMyConsultations у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Folders.OpenMyConsultations у контейнера }
 end;//Op_Folders_OpenMyConsultations

 Op_Folders_SetInfoContent = {final} class
  {* Класс для вызова операции Folders.SetInfoContent }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Folders.SetInfoContent у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Folders.SetInfoContent у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Folders.SetInfoContent у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Folders.SetInfoContent у контейнера }
 end;//Op_Folders_SetInfoContent

 IUsersRights_UpdateRights_Params = interface
  {* Параметры для операции UsersRights.UpdateRights }
  function Get_Node: IeeNode;
  property Node: IeeNode
   read Get_Node;
 end;//IUsersRights_UpdateRights_Params

 Op_UsersRights_UpdateRights = {final} class
  {* Класс для вызова операции UsersRights.UpdateRights }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции UsersRights.UpdateRights у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции UsersRights.UpdateRights у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции UsersRights.UpdateRights у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode): Boolean; overload;
    {* Вызов операции UsersRights.UpdateRights у контейнера }
 end;//Op_UsersRights_UpdateRights

 Op_UsersRights_FolderShareChanged = {final} class
  {* Класс для вызова операции UsersRights.FolderShareChanged }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции UsersRights.FolderShareChanged у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции UsersRights.FolderShareChanged у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции UsersRights.FolderShareChanged у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции UsersRights.FolderShareChanged у контейнера }
 end;//Op_UsersRights_FolderShareChanged

 Op_Result_ExternalOk = {final} class
  {* Класс для вызова операции Result.ExternalOk }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Result.ExternalOk у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Result.ExternalOk у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Result.ExternalOk у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Result.ExternalOk у контейнера }
 end;//Op_Result_ExternalOk

const
 en_AdditionInfo = 'AdditionInfo';
 en_capAdditionInfo = '';
 op_Close = 'Close';
 op_capClose = '';
 en_FolderElement = 'FolderElement';
 en_capFolderElement = 'Элемент папок';
 op_InternalEditByFoldersNode = 'InternalEditByFoldersNode';
 op_capInternalEditByFoldersNode = 'Редактирование элемента';
 op_InternalDelete = 'InternalDelete';
 op_capInternalDelete = 'Удаляет элемент папок';
 op_InternalEdit = 'InternalEdit';
 op_capInternalEdit = '';
 op_DisableFilter = 'DisableFilter';
 op_capDisableFilter = '';
 op_SetState = 'SetState';
 op_capSetState = '';
 op_Show = 'Show';
 op_capShow = '';
 op_Hide = 'Hide';
 op_capHide = '';
 op_SetCaption = 'SetCaption';
 op_capSetCaption = '';
 op_GetState = 'GetState';
 op_capGetState = 'Возвращает статус элемента';
 op_SetLoadInfo = 'SetLoadInfo';
 op_capSetLoadInfo = 'Устанавливает параметры элемента';
 op_SetContent = 'SetContent';
 op_capSetContent = 'SetContent';
 op_SetSaveInfo = 'SetSaveInfo';
 op_capSetSaveInfo = '';
 op_ResetModificationOnDelete = 'ResetModificationOnDelete';
 op_capResetModificationOnDelete = '';
 op_SetFocus = 'SetFocus';
 op_capSetFocus = '';
 op_Redraw = 'Redraw';
 op_capRedraw = '';
 op_DisableSecurityPage = 'DisableSecurityPage';
 op_capDisableSecurityPage = '';
 en_SavedQuery = 'SavedQuery';
 en_capSavedQuery = '';
 op_SetFilterState = 'SetFilterState';
 op_capSetFilterState = '';
 en_Folders = 'Folders';
 en_capFolders = '';
 op_SetCurrent = 'SetCurrent';
 op_capSetCurrent = '';
 op_FiltrateByFilterInfo = 'FiltrateByFilterInfo';
 op_capFiltrateByFilterInfo = '';
 op_TryOpenConsultationAnswer = 'TryOpenConsultationAnswer';
 op_capTryOpenConsultationAnswer = '';
 op_OpenMyConsultations = 'OpenMyConsultations';
 op_capOpenMyConsultations = '';
 op_SetInfoContent = 'SetInfoContent';
 op_capSetInfoContent = '';
 en_UsersRights = 'UsersRights';
 en_capUsersRights = '';
 op_UpdateRights = 'UpdateRights';
 op_capUpdateRights = '';
 op_FolderShareChanged = 'FolderShareChanged';
 op_capFolderShareChanged = '';
 en_Result = 'Result';
 en_capResult = '';
 op_ExternalOk = 'ExternalOk';
 op_capExternalOk = '';
 op_Filtrate = 'Filtrate';
 op_capFiltrate = '';
 en_Folder = 'Folder';
 en_capFolder = '';
 op_New = 'New';
 op_capNew = '';
 op_AddToControl = 'AddToControl';
 op_capAddToControl = '';
 op_DelFromControl = 'DelFromControl';
 op_capDelFromControl = '';
 op_SetShare = 'SetShare';
 op_capSetShare = '';
 op_ExportToXML = 'ExportToXML';
 op_capExportToXML = '';
 op_ImportFromXML = 'ImportFromXML';
 op_capImportFromXML = '';
 op_Edit = 'Edit';
 op_capEdit = '';
 op_EditExt = 'EditExt';
 op_capEditExt = '';
 op_Open = 'Open';
 op_capOpen = '';
 op_OpenNewWindow = 'OpenNewWindow';
 op_capOpenNewWindow = '';
 op_ControlStatus = 'ControlStatus';
 op_capControlStatus = '';
 op_ExportForIntegration = 'ExportForIntegration';
 op_capExportForIntegration = '';
 op_CreateFilter = 'CreateFilter';
 op_capCreateFilter = 'Создать фильтр...';
 en_Consultation = 'Consultation';
 en_capConsultation = '';
 op_GiveMark = 'GiveMark';
 op_capGiveMark = '';
 op_ShowConsultationInfo = 'ShowConsultationInfo';
 op_capShowConsultationInfo = '';
 op_ImportConsultation = 'ImportConsultation';
 op_capImportConsultation = '';
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TAdditionInfo_Close_Params = {final} class(Tl3CProtoObject, IAdditionInfo_Close_Params)
  {* Реализация IAdditionInfo_Close_Params }
  private
   f_ModalResult: Integer;
  protected
   function Get_ModalResult: Integer;
  public
   constructor Create(aModalResult: Integer = Controls.mrCancel); reintroduce;
   class function Make(aModalResult: Integer = Controls.mrCancel): IAdditionInfo_Close_Params; reintroduce;
 end;//TAdditionInfo_Close_Params

 TFolderElement_InternalEditByFoldersNode_Params = {final} class(Tl3CProtoObject, IFolderElement_InternalEditByFoldersNode_Params)
  {* Реализация IFolderElement_InternalEditByFoldersNode_Params }
  private
   f_Node: IFoldersNode;
   f_InternalCall: Boolean;
  protected
   function Get_Node: IFoldersNode;
   function Get_InternalCall: Boolean;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IFoldersNode;
    aInternalCall: Boolean = True); reintroduce;
   class function Make(const aNode: IFoldersNode;
    aInternalCall: Boolean = True): IFolderElement_InternalEditByFoldersNode_Params; reintroduce;
 end;//TFolderElement_InternalEditByFoldersNode_Params

 TFolderElement_InternalDelete_Params = {final} class(Tl3CProtoObject, IFolderElement_InternalDelete_Params)
  {* Реализация IFolderElement_InternalDelete_Params }
  private
   f_Node: IFoldersNode;
   f_Ask: Boolean;
   f_ResultValue: TnsDeleteResult;
  protected
   function Get_Node: IFoldersNode;
   function Get_Ask: Boolean;
   function Get_ResultValue: TnsDeleteResult;
   procedure Set_ResultValue(aValue: TnsDeleteResult);
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IFoldersNode;
    aAsk: Boolean = True); reintroduce;
   class function Make(const aNode: IFoldersNode;
    aAsk: Boolean = True): IFolderElement_InternalDelete_Params; reintroduce;
 end;//TFolderElement_InternalDelete_Params

 TFolderElement_InternalEdit_Params = {final} class(Tl3CProtoObject, IFolderElement_InternalEdit_Params)
  {* Реализация IFolderElement_InternalEdit_Params }
  private
   f_Node: IeeNode;
   f_InternalCall: Boolean;
  protected
   function Get_Node: IeeNode;
   function Get_InternalCall: Boolean;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode;
    aInternalCall: Boolean = True); reintroduce;
   class function Make(const aNode: IeeNode;
    aInternalCall: Boolean = True): IFolderElement_InternalEdit_Params; reintroduce;
 end;//TFolderElement_InternalEdit_Params

 TFolderElement_SetState_Params = {final} class(Tl3CProtoObject, IFolderElement_SetState_Params)
  {* Реализация IFolderElement_SetState_Params }
  private
   f_InfoType: TFoldersInfoType;
  protected
   function Get_InfoType: TFoldersInfoType;
  public
   constructor Create(aInfoType: TFoldersInfoType); reintroduce;
   class function Make(aInfoType: TFoldersInfoType): IFolderElement_SetState_Params; reintroduce;
 end;//TFolderElement_SetState_Params

 TAdditionInfo_SetCaption_Params = {final} class(Tl3CProtoObject, IAdditionInfo_SetCaption_Params)
  {* Реализация IAdditionInfo_SetCaption_Params }
  private
   f_Caption: Il3CString;
  protected
   function Get_Caption: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aCaption: Il3CString); reintroduce;
   class function Make(const aCaption: Il3CString): IAdditionInfo_SetCaption_Params; reintroduce;
 end;//TAdditionInfo_SetCaption_Params

 TFolderElement_GetState_Params = {final} class(Tl3CProtoObject, IFolderElement_GetState_Params)
  {* Реализация IFolderElement_GetState_Params }
  private
   f_ResultValue: TFoldersInfoType;
  protected
   function Get_ResultValue: TFoldersInfoType;
   procedure Set_ResultValue(aValue: TFoldersInfoType);
  public
   class function Make: IFolderElement_GetState_Params; reintroduce;
 end;//TFolderElement_GetState_Params

 TFolderElement_SetLoadInfo_Params = {final} class(Tl3CProtoObject, IFolderElement_SetLoadInfo_Params)
  {* Реализация IFolderElement_SetLoadInfo_Params }
  private
   f_Form: IvcmEntityForm;
   f_FolderFilterInfo: InsFolderFilterInfo;
   f_Caption: Il3CString;
   f_Data: IUnknown;
   f_nOp: TListLogicOperation;
  protected
   function Get_Form: IvcmEntityForm;
   function Get_FolderFilterInfo: InsFolderFilterInfo;
   function Get_Caption: Il3CString;
   function Get_Data: IUnknown;
   function Get_nOp: TListLogicOperation;
   procedure ClearFields; override;
  public
   constructor Create(const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation); reintroduce;
   class function Make(const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): IFolderElement_SetLoadInfo_Params; reintroduce;
 end;//TFolderElement_SetLoadInfo_Params

 TFolderElement_SetContent_Params = {final} class(Tl3CProtoObject, IFolderElement_SetContent_Params)
  {* Реализация IFolderElement_SetContent_Params }
  private
   f_Node: IeeNode;
   f_IsNewFolder: Boolean;
  protected
   function Get_Node: IeeNode;
   function Get_IsNewFolder: Boolean;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode;
    aIsNewFolder: Boolean = False); reintroduce;
   class function Make(const aNode: IeeNode;
    aIsNewFolder: Boolean = False): IFolderElement_SetContent_Params; reintroduce;
 end;//TFolderElement_SetContent_Params

 TFolderElement_SetSaveInfo_Params = {final} class(Tl3CProtoObject, IFolderElement_SetSaveInfo_Params)
  {* Реализация IFolderElement_SetSaveInfo_Params }
  private
   f_Form: IvcmEntityForm;
   f_FilterInfo: InsFolderFilterInfo;
   f_nElementType: TFoldersElementType;
   f_nEntity: IEntityBase;
   f_SaveAs: Boolean;
  protected
   function Get_Form: IvcmEntityForm;
   function Get_FilterInfo: InsFolderFilterInfo;
   function Get_nElementType: TFoldersElementType;
   function Get_nEntity: IEntityBase;
   function Get_SaveAs: Boolean;
   procedure ClearFields; override;
  public
   constructor Create(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean); reintroduce;
   class function Make(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): IFolderElement_SetSaveInfo_Params; reintroduce;
 end;//TFolderElement_SetSaveInfo_Params

 TFolderElement_ResetModificationOnDelete_Params = {final} class(Tl3CProtoObject, IFolderElement_ResetModificationOnDelete_Params)
  {* Реализация IFolderElement_ResetModificationOnDelete_Params }
  private
   f_Node: IeeNode;
  protected
   function Get_Node: IeeNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode); reintroduce;
   class function Make(const aNode: IeeNode): IFolderElement_ResetModificationOnDelete_Params; reintroduce;
 end;//TFolderElement_ResetModificationOnDelete_Params

 TSavedQuery_SetFilterState_Params = {final} class(Tl3CProtoObject, ISavedQuery_SetFilterState_Params)
  {* Реализация ISavedQuery_SetFilterState_Params }
  private
   f_Node: INode;
  protected
   function Get_Node: INode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: INode); reintroduce;
   class function Make(const aNode: INode): ISavedQuery_SetFilterState_Params; reintroduce;
 end;//TSavedQuery_SetFilterState_Params

 TFolders_SetCurrent_Params = {final} class(Tl3CProtoObject, IFolders_SetCurrent_Params)
  {* Реализация IFolders_SetCurrent_Params }
  private
   f_Node: IeeNode;
  protected
   function Get_Node: IeeNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode); reintroduce;
   class function Make(const aNode: IeeNode): IFolders_SetCurrent_Params; reintroduce;
 end;//TFolders_SetCurrent_Params

 TFolders_FiltrateByFilterInfo_Params = {final} class(Tl3CProtoObject, IFolders_FiltrateByFilterInfo_Params)
  {* Реализация IFolders_FiltrateByFilterInfo_Params }
  private
   f_nInfo: InsFolderFilterInfo;
  protected
   function Get_nInfo: InsFolderFilterInfo;
   procedure ClearFields; override;
  public
   constructor Create(const anInfo: InsFolderFilterInfo); reintroduce;
   class function Make(const anInfo: InsFolderFilterInfo): IFolders_FiltrateByFilterInfo_Params; reintroduce;
 end;//TFolders_FiltrateByFilterInfo_Params

 TUsersRights_UpdateRights_Params = {final} class(Tl3CProtoObject, IUsersRights_UpdateRights_Params)
  {* Реализация IUsersRights_UpdateRights_Params }
  private
   f_Node: IeeNode;
  protected
   function Get_Node: IeeNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode); reintroduce;
   class function Make(const aNode: IeeNode): IUsersRights_UpdateRights_Params; reintroduce;
 end;//TUsersRights_UpdateRights_Params

constructor TAdditionInfo_Close_Params.Create(aModalResult: Integer = Controls.mrCancel);
begin
 inherited Create;
 f_ModalResult := aModalResult;
end;//TAdditionInfo_Close_Params.Create

class function TAdditionInfo_Close_Params.Make(aModalResult: Integer = Controls.mrCancel): IAdditionInfo_Close_Params;
var
 l_Inst : TAdditionInfo_Close_Params;
begin
 l_Inst := Create(aModalResult);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAdditionInfo_Close_Params.Make

function TAdditionInfo_Close_Params.Get_ModalResult: Integer;
begin
 Result := f_ModalResult;
end;//TAdditionInfo_Close_Params.Get_ModalResult

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmEntity;
 aModalResult: Integer = Controls.mrCancel): Boolean;
 {* Вызов операции AdditionInfo.Close у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAdditionInfo_Close_Params.Make(aModalResult));
  aTarget.Operation(TdmStdRes.opcode_AdditionInfo_Close, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AdditionInfo_Close.Call

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmAggregate;
 aModalResult: Integer = Controls.mrCancel): Boolean;
 {* Вызов операции AdditionInfo.Close у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAdditionInfo_Close_Params.Make(aModalResult));
  aTarget.Operation(TdmStdRes.opcode_AdditionInfo_Close, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AdditionInfo_Close.Call

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmEntityForm;
 aModalResult: Integer = Controls.mrCancel): Boolean;
 {* Вызов операции AdditionInfo.Close у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aModalResult);
end;//Op_AdditionInfo_Close.Call

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmContainer;
 aModalResult: Integer = Controls.mrCancel): Boolean;
 {* Вызов операции AdditionInfo.Close у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aModalResult);
end;//Op_AdditionInfo_Close.Call

constructor TFolderElement_InternalEditByFoldersNode_Params.Create(const aNode: IFoldersNode;
 aInternalCall: Boolean = True);
begin
 inherited Create;
 f_Node := aNode;
 f_InternalCall := aInternalCall;
end;//TFolderElement_InternalEditByFoldersNode_Params.Create

class function TFolderElement_InternalEditByFoldersNode_Params.Make(const aNode: IFoldersNode;
 aInternalCall: Boolean = True): IFolderElement_InternalEditByFoldersNode_Params;
var
 l_Inst : TFolderElement_InternalEditByFoldersNode_Params;
begin
 l_Inst := Create(aNode, aInternalCall);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolderElement_InternalEditByFoldersNode_Params.Make

function TFolderElement_InternalEditByFoldersNode_Params.Get_Node: IFoldersNode;
begin
 Result := f_Node;
end;//TFolderElement_InternalEditByFoldersNode_Params.Get_Node

function TFolderElement_InternalEditByFoldersNode_Params.Get_InternalCall: Boolean;
begin
 Result := f_InternalCall;
end;//TFolderElement_InternalEditByFoldersNode_Params.Get_InternalCall

procedure TFolderElement_InternalEditByFoldersNode_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolderElement_InternalEditByFoldersNode_Params.ClearFields

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmEntity;
 const aNode: IFoldersNode;
 aInternalCall: Boolean = True): Boolean;
 {* Вызов операции FolderElement.InternalEditByFoldersNode у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalEditByFoldersNode_Params.Make(aNode, aInternalCall));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_InternalEditByFoldersNode, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_InternalEditByFoldersNode.Call

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmAggregate;
 const aNode: IFoldersNode;
 aInternalCall: Boolean = True): Boolean;
 {* Вызов операции FolderElement.InternalEditByFoldersNode у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalEditByFoldersNode_Params.Make(aNode, aInternalCall));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_InternalEditByFoldersNode, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_InternalEditByFoldersNode.Call

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmEntityForm;
 const aNode: IFoldersNode;
 aInternalCall: Boolean = True): Boolean;
 {* Вызов операции FolderElement.InternalEditByFoldersNode у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aInternalCall);
end;//Op_FolderElement_InternalEditByFoldersNode.Call

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode;
 aInternalCall: Boolean = True): Boolean;
 {* Вызов операции FolderElement.InternalEditByFoldersNode у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aInternalCall);
end;//Op_FolderElement_InternalEditByFoldersNode.Call

constructor TFolderElement_InternalDelete_Params.Create(const aNode: IFoldersNode;
 aAsk: Boolean = True);
begin
 inherited Create;
 f_Node := aNode;
 f_Ask := aAsk;
end;//TFolderElement_InternalDelete_Params.Create

class function TFolderElement_InternalDelete_Params.Make(const aNode: IFoldersNode;
 aAsk: Boolean = True): IFolderElement_InternalDelete_Params;
var
 l_Inst : TFolderElement_InternalDelete_Params;
begin
 l_Inst := Create(aNode, aAsk);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolderElement_InternalDelete_Params.Make

function TFolderElement_InternalDelete_Params.Get_Node: IFoldersNode;
begin
 Result := f_Node;
end;//TFolderElement_InternalDelete_Params.Get_Node

function TFolderElement_InternalDelete_Params.Get_Ask: Boolean;
begin
 Result := f_Ask;
end;//TFolderElement_InternalDelete_Params.Get_Ask

function TFolderElement_InternalDelete_Params.Get_ResultValue: TnsDeleteResult;
begin
 Result := f_ResultValue;
end;//TFolderElement_InternalDelete_Params.Get_ResultValue

procedure TFolderElement_InternalDelete_Params.Set_ResultValue(aValue: TnsDeleteResult);
begin
 f_ResultValue := aValue;
end;//TFolderElement_InternalDelete_Params.Set_ResultValue

procedure TFolderElement_InternalDelete_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolderElement_InternalDelete_Params.ClearFields

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmEntity;
 const aNode: IFoldersNode;
 aAsk: Boolean = True): TnsDeleteResult;
 {* Вызов операции FolderElement.InternalDelete у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalDelete_Params.Make(aNode, aAsk));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_InternalDelete, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFolderElement_InternalDelete_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_InternalDelete.Call

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmAggregate;
 const aNode: IFoldersNode;
 aAsk: Boolean = True): TnsDeleteResult;
 {* Вызов операции FolderElement.InternalDelete у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalDelete_Params.Make(aNode, aAsk));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_InternalDelete, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFolderElement_InternalDelete_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_InternalDelete.Call

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmEntityForm;
 const aNode: IFoldersNode;
 aAsk: Boolean = True): TnsDeleteResult;
 {* Вызов операции FolderElement.InternalDelete у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aAsk);
end;//Op_FolderElement_InternalDelete.Call

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode;
 aAsk: Boolean = True): TnsDeleteResult;
 {* Вызов операции FolderElement.InternalDelete у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aAsk);
end;//Op_FolderElement_InternalDelete.Call

constructor TFolderElement_InternalEdit_Params.Create(const aNode: IeeNode;
 aInternalCall: Boolean = True);
begin
 inherited Create;
 f_Node := aNode;
 f_InternalCall := aInternalCall;
end;//TFolderElement_InternalEdit_Params.Create

class function TFolderElement_InternalEdit_Params.Make(const aNode: IeeNode;
 aInternalCall: Boolean = True): IFolderElement_InternalEdit_Params;
var
 l_Inst : TFolderElement_InternalEdit_Params;
begin
 l_Inst := Create(aNode, aInternalCall);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolderElement_InternalEdit_Params.Make

function TFolderElement_InternalEdit_Params.Get_Node: IeeNode;
begin
 Result := f_Node;
end;//TFolderElement_InternalEdit_Params.Get_Node

function TFolderElement_InternalEdit_Params.Get_InternalCall: Boolean;
begin
 Result := f_InternalCall;
end;//TFolderElement_InternalEdit_Params.Get_InternalCall

procedure TFolderElement_InternalEdit_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolderElement_InternalEdit_Params.ClearFields

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode;
 aInternalCall: Boolean = True): Boolean;
 {* Вызов операции FolderElement.InternalEdit у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalEdit_Params.Make(aNode, aInternalCall));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_InternalEdit, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode;
 aInternalCall: Boolean = True): Boolean;
 {* Вызов операции FolderElement.InternalEdit у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalEdit_Params.Make(aNode, aInternalCall));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_InternalEdit, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode;
 aInternalCall: Boolean = True): Boolean;
 {* Вызов операции FolderElement.InternalEdit у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aInternalCall);
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode;
 aInternalCall: Boolean = True): Boolean;
 {* Вызов операции FolderElement.InternalEdit у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aInternalCall);
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции FolderElement.DisableFilter у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_FolderElement_DisableFilter, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_DisableFilter.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции FolderElement.DisableFilter у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_FolderElement_DisableFilter, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_DisableFilter.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции FolderElement.DisableFilter у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_DisableFilter.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции FolderElement.DisableFilter у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_DisableFilter.Call

constructor TFolderElement_SetState_Params.Create(aInfoType: TFoldersInfoType);
begin
 inherited Create;
 f_InfoType := aInfoType;
end;//TFolderElement_SetState_Params.Create

class function TFolderElement_SetState_Params.Make(aInfoType: TFoldersInfoType): IFolderElement_SetState_Params;
var
 l_Inst : TFolderElement_SetState_Params;
begin
 l_Inst := Create(aInfoType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolderElement_SetState_Params.Make

function TFolderElement_SetState_Params.Get_InfoType: TFoldersInfoType;
begin
 Result := f_InfoType;
end;//TFolderElement_SetState_Params.Get_InfoType

class function Op_FolderElement_SetState.Call(const aTarget: IvcmEntity;
 aInfoType: TFoldersInfoType): Boolean;
 {* Вызов операции FolderElement.SetState у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetState_Params.Make(aInfoType));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetState, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetState.Call

class function Op_FolderElement_SetState.Call(const aTarget: IvcmAggregate;
 aInfoType: TFoldersInfoType): Boolean;
 {* Вызов операции FolderElement.SetState у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetState_Params.Make(aInfoType));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetState, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetState.Call

class function Op_FolderElement_SetState.Call(const aTarget: IvcmEntityForm;
 aInfoType: TFoldersInfoType): Boolean;
 {* Вызов операции FolderElement.SetState у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aInfoType);
end;//Op_FolderElement_SetState.Call

class function Op_FolderElement_SetState.Call(const aTarget: IvcmContainer;
 aInfoType: TFoldersInfoType): Boolean;
 {* Вызов операции FolderElement.SetState у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aInfoType);
end;//Op_FolderElement_SetState.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции AdditionInfo.Show у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_AdditionInfo_Show, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции AdditionInfo.Show у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_AdditionInfo_Show, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции AdditionInfo.Show у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции AdditionInfo.Show у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции AdditionInfo.Hide у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_AdditionInfo_Hide, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AdditionInfo_Hide.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции AdditionInfo.Hide у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_AdditionInfo_Hide, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AdditionInfo_Hide.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции AdditionInfo.Hide у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_AdditionInfo_Hide.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции AdditionInfo.Hide у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_AdditionInfo_Hide.Call

constructor TAdditionInfo_SetCaption_Params.Create(const aCaption: Il3CString);
begin
 inherited Create;
 f_Caption := aCaption;
end;//TAdditionInfo_SetCaption_Params.Create

class function TAdditionInfo_SetCaption_Params.Make(const aCaption: Il3CString): IAdditionInfo_SetCaption_Params;
var
 l_Inst : TAdditionInfo_SetCaption_Params;
begin
 l_Inst := Create(aCaption);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TAdditionInfo_SetCaption_Params.Make

function TAdditionInfo_SetCaption_Params.Get_Caption: Il3CString;
begin
 Result := f_Caption;
end;//TAdditionInfo_SetCaption_Params.Get_Caption

procedure TAdditionInfo_SetCaption_Params.ClearFields;
begin
 f_Caption := nil;
 inherited;
end;//TAdditionInfo_SetCaption_Params.ClearFields

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmEntity;
 const aCaption: Il3CString): Boolean;
 {* Вызов операции AdditionInfo.SetCaption у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAdditionInfo_SetCaption_Params.Make(aCaption));
  aTarget.Operation(TdmStdRes.opcode_AdditionInfo_SetCaption, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AdditionInfo_SetCaption.Call

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmAggregate;
 const aCaption: Il3CString): Boolean;
 {* Вызов операции AdditionInfo.SetCaption у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAdditionInfo_SetCaption_Params.Make(aCaption));
  aTarget.Operation(TdmStdRes.opcode_AdditionInfo_SetCaption, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AdditionInfo_SetCaption.Call

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmEntityForm;
 const aCaption: Il3CString): Boolean;
 {* Вызов операции AdditionInfo.SetCaption у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aCaption);
end;//Op_AdditionInfo_SetCaption.Call

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmContainer;
 const aCaption: Il3CString): Boolean;
 {* Вызов операции AdditionInfo.SetCaption у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aCaption);
end;//Op_AdditionInfo_SetCaption.Call

class function TFolderElement_GetState_Params.Make: IFolderElement_GetState_Params;
var
 l_Inst : TFolderElement_GetState_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolderElement_GetState_Params.Make

function TFolderElement_GetState_Params.Get_ResultValue: TFoldersInfoType;
begin
 Result := f_ResultValue;
end;//TFolderElement_GetState_Params.Get_ResultValue

procedure TFolderElement_GetState_Params.Set_ResultValue(aValue: TFoldersInfoType);
begin
 f_ResultValue := aValue;
end;//TFolderElement_GetState_Params.Set_ResultValue

class function Op_FolderElement_GetState.Call(const aTarget: IvcmEntity): TFoldersInfoType;
 {* Вызов операции FolderElement.GetState у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_GetState_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_FolderElement_GetState, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFolderElement_GetState_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_GetState.Call

class function Op_FolderElement_GetState.Call(const aTarget: IvcmAggregate): TFoldersInfoType;
 {* Вызов операции FolderElement.GetState у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_GetState_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_FolderElement_GetState, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFolderElement_GetState_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_GetState.Call

class function Op_FolderElement_GetState.Call(const aTarget: IvcmEntityForm): TFoldersInfoType;
 {* Вызов операции FolderElement.GetState у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_GetState.Call

class function Op_FolderElement_GetState.Call(const aTarget: IvcmContainer): TFoldersInfoType;
 {* Вызов операции FolderElement.GetState у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_GetState.Call

constructor TFolderElement_SetLoadInfo_Params.Create(const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation);
begin
 inherited Create;
 f_Form := aForm;
 f_FolderFilterInfo := aFolderFilterInfo;
 f_Caption := aCaption;
 f_Data := aData;
 f_nOp := anOp;
end;//TFolderElement_SetLoadInfo_Params.Create

class function TFolderElement_SetLoadInfo_Params.Make(const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation): IFolderElement_SetLoadInfo_Params;
var
 l_Inst : TFolderElement_SetLoadInfo_Params;
begin
 l_Inst := Create(aForm, aFolderFilterInfo, aCaption, aData, anOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolderElement_SetLoadInfo_Params.Make

function TFolderElement_SetLoadInfo_Params.Get_Form: IvcmEntityForm;
begin
 Result := f_Form;
end;//TFolderElement_SetLoadInfo_Params.Get_Form

function TFolderElement_SetLoadInfo_Params.Get_FolderFilterInfo: InsFolderFilterInfo;
begin
 Result := f_FolderFilterInfo;
end;//TFolderElement_SetLoadInfo_Params.Get_FolderFilterInfo

function TFolderElement_SetLoadInfo_Params.Get_Caption: Il3CString;
begin
 Result := f_Caption;
end;//TFolderElement_SetLoadInfo_Params.Get_Caption

function TFolderElement_SetLoadInfo_Params.Get_Data: IUnknown;
begin
 Result := f_Data;
end;//TFolderElement_SetLoadInfo_Params.Get_Data

function TFolderElement_SetLoadInfo_Params.Get_nOp: TListLogicOperation;
begin
 Result := f_nOp;
end;//TFolderElement_SetLoadInfo_Params.Get_nOp

procedure TFolderElement_SetLoadInfo_Params.ClearFields;
begin
 f_Form := nil;
 f_FolderFilterInfo := nil;
 f_Caption := nil;
 f_Data := nil;
 inherited;
end;//TFolderElement_SetLoadInfo_Params.ClearFields

class function Op_FolderElement_SetLoadInfo.Call(const aTarget: IvcmEntity;
 const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation): Boolean;
 {* Вызов операции FolderElement.SetLoadInfo у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetLoadInfo_Params.Make(aForm, aFolderFilterInfo, aCaption, aData, anOp));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetLoadInfo, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetLoadInfo.Call

class function Op_FolderElement_SetLoadInfo.Call(const aTarget: IvcmAggregate;
 const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation): Boolean;
 {* Вызов операции FolderElement.SetLoadInfo у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetLoadInfo_Params.Make(aForm, aFolderFilterInfo, aCaption, aData, anOp));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetLoadInfo, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetLoadInfo.Call

class function Op_FolderElement_SetLoadInfo.Call(const aTarget: IvcmEntityForm;
 const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation): Boolean;
 {* Вызов операции FolderElement.SetLoadInfo у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aForm, aFolderFilterInfo, aCaption, aData, anOp);
end;//Op_FolderElement_SetLoadInfo.Call

class function Op_FolderElement_SetLoadInfo.Call(const aTarget: IvcmContainer;
 const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation): Boolean;
 {* Вызов операции FolderElement.SetLoadInfo у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aForm, aFolderFilterInfo, aCaption, aData, anOp);
end;//Op_FolderElement_SetLoadInfo.Call

constructor TFolderElement_SetContent_Params.Create(const aNode: IeeNode;
 aIsNewFolder: Boolean = False);
begin
 inherited Create;
 f_Node := aNode;
 f_IsNewFolder := aIsNewFolder;
end;//TFolderElement_SetContent_Params.Create

class function TFolderElement_SetContent_Params.Make(const aNode: IeeNode;
 aIsNewFolder: Boolean = False): IFolderElement_SetContent_Params;
var
 l_Inst : TFolderElement_SetContent_Params;
begin
 l_Inst := Create(aNode, aIsNewFolder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolderElement_SetContent_Params.Make

function TFolderElement_SetContent_Params.Get_Node: IeeNode;
begin
 Result := f_Node;
end;//TFolderElement_SetContent_Params.Get_Node

function TFolderElement_SetContent_Params.Get_IsNewFolder: Boolean;
begin
 Result := f_IsNewFolder;
end;//TFolderElement_SetContent_Params.Get_IsNewFolder

procedure TFolderElement_SetContent_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolderElement_SetContent_Params.ClearFields

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode;
 aIsNewFolder: Boolean = False): Boolean;
 {* Вызов операции FolderElement.SetContent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetContent_Params.Make(aNode, aIsNewFolder));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetContent.Call

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode;
 aIsNewFolder: Boolean = False): Boolean;
 {* Вызов операции FolderElement.SetContent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetContent_Params.Make(aNode, aIsNewFolder));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetContent.Call

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode;
 aIsNewFolder: Boolean = False): Boolean;
 {* Вызов операции FolderElement.SetContent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aIsNewFolder);
end;//Op_FolderElement_SetContent.Call

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode;
 aIsNewFolder: Boolean = False): Boolean;
 {* Вызов операции FolderElement.SetContent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aIsNewFolder);
end;//Op_FolderElement_SetContent.Call

constructor TFolderElement_SetSaveInfo_Params.Create(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean);
begin
 inherited Create;
 f_Form := aForm;
 f_FilterInfo := aFilterInfo;
 f_nElementType := anElementType;
 f_nEntity := anEntity;
 f_SaveAs := aSaveAs;
end;//TFolderElement_SetSaveInfo_Params.Create

class function TFolderElement_SetSaveInfo_Params.Make(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): IFolderElement_SetSaveInfo_Params;
var
 l_Inst : TFolderElement_SetSaveInfo_Params;
begin
 l_Inst := Create(aForm, aFilterInfo, anElementType, anEntity, aSaveAs);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolderElement_SetSaveInfo_Params.Make

function TFolderElement_SetSaveInfo_Params.Get_Form: IvcmEntityForm;
begin
 Result := f_Form;
end;//TFolderElement_SetSaveInfo_Params.Get_Form

function TFolderElement_SetSaveInfo_Params.Get_FilterInfo: InsFolderFilterInfo;
begin
 Result := f_FilterInfo;
end;//TFolderElement_SetSaveInfo_Params.Get_FilterInfo

function TFolderElement_SetSaveInfo_Params.Get_nElementType: TFoldersElementType;
begin
 Result := f_nElementType;
end;//TFolderElement_SetSaveInfo_Params.Get_nElementType

function TFolderElement_SetSaveInfo_Params.Get_nEntity: IEntityBase;
begin
 Result := f_nEntity;
end;//TFolderElement_SetSaveInfo_Params.Get_nEntity

function TFolderElement_SetSaveInfo_Params.Get_SaveAs: Boolean;
begin
 Result := f_SaveAs;
end;//TFolderElement_SetSaveInfo_Params.Get_SaveAs

procedure TFolderElement_SetSaveInfo_Params.ClearFields;
begin
 f_Form := nil;
 f_FilterInfo := nil;
 f_nEntity := nil;
 inherited;
end;//TFolderElement_SetSaveInfo_Params.ClearFields

class function Op_FolderElement_SetSaveInfo.Call(const aTarget: IvcmEntity;
 const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Boolean;
 {* Вызов операции FolderElement.SetSaveInfo у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetSaveInfo_Params.Make(aForm, aFilterInfo, anElementType, anEntity, aSaveAs));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetSaveInfo, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetSaveInfo.Call

class function Op_FolderElement_SetSaveInfo.Call(const aTarget: IvcmAggregate;
 const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Boolean;
 {* Вызов операции FolderElement.SetSaveInfo у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetSaveInfo_Params.Make(aForm, aFilterInfo, anElementType, anEntity, aSaveAs));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetSaveInfo, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetSaveInfo.Call

class function Op_FolderElement_SetSaveInfo.Call(const aTarget: IvcmEntityForm;
 const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Boolean;
 {* Вызов операции FolderElement.SetSaveInfo у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aForm, aFilterInfo, anElementType, anEntity, aSaveAs);
end;//Op_FolderElement_SetSaveInfo.Call

class function Op_FolderElement_SetSaveInfo.Call(const aTarget: IvcmContainer;
 const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Boolean;
 {* Вызов операции FolderElement.SetSaveInfo у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aForm, aFilterInfo, anElementType, anEntity, aSaveAs);
end;//Op_FolderElement_SetSaveInfo.Call

constructor TFolderElement_ResetModificationOnDelete_Params.Create(const aNode: IeeNode);
begin
 inherited Create;
 f_Node := aNode;
end;//TFolderElement_ResetModificationOnDelete_Params.Create

class function TFolderElement_ResetModificationOnDelete_Params.Make(const aNode: IeeNode): IFolderElement_ResetModificationOnDelete_Params;
var
 l_Inst : TFolderElement_ResetModificationOnDelete_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolderElement_ResetModificationOnDelete_Params.Make

function TFolderElement_ResetModificationOnDelete_Params.Get_Node: IeeNode;
begin
 Result := f_Node;
end;//TFolderElement_ResetModificationOnDelete_Params.Get_Node

procedure TFolderElement_ResetModificationOnDelete_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolderElement_ResetModificationOnDelete_Params.ClearFields

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode): Boolean;
 {* Вызов операции FolderElement.ResetModificationOnDelete у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_ResetModificationOnDelete_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_ResetModificationOnDelete, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode): Boolean;
 {* Вызов операции FolderElement.ResetModificationOnDelete у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_ResetModificationOnDelete_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_FolderElement_ResetModificationOnDelete, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode): Boolean;
 {* Вызов операции FolderElement.ResetModificationOnDelete у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode): Boolean;
 {* Вызов операции FolderElement.ResetModificationOnDelete у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции FolderElement.SetFocus у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetFocus, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции FolderElement.SetFocus у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_FolderElement_SetFocus, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции FolderElement.SetFocus у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции FolderElement.SetFocus у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции FolderElement.Redraw у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_FolderElement_Redraw, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции FolderElement.Redraw у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_FolderElement_Redraw, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции FolderElement.Redraw у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции FolderElement.Redraw у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции FolderElement.DisableSecurityPage у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_FolderElement_DisableSecurityPage, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_DisableSecurityPage.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции FolderElement.DisableSecurityPage у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_FolderElement_DisableSecurityPage, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FolderElement_DisableSecurityPage.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции FolderElement.DisableSecurityPage у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_DisableSecurityPage.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции FolderElement.DisableSecurityPage у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_DisableSecurityPage.Call

constructor TSavedQuery_SetFilterState_Params.Create(const aNode: INode);
begin
 inherited Create;
 f_Node := aNode;
end;//TSavedQuery_SetFilterState_Params.Create

class function TSavedQuery_SetFilterState_Params.Make(const aNode: INode): ISavedQuery_SetFilterState_Params;
var
 l_Inst : TSavedQuery_SetFilterState_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSavedQuery_SetFilterState_Params.Make

function TSavedQuery_SetFilterState_Params.Get_Node: INode;
begin
 Result := f_Node;
end;//TSavedQuery_SetFilterState_Params.Get_Node

procedure TSavedQuery_SetFilterState_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TSavedQuery_SetFilterState_Params.ClearFields

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmEntity;
 const aNode: INode): Boolean;
 {* Вызов операции SavedQuery.SetFilterState у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSavedQuery_SetFilterState_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_SavedQuery_SetFilterState, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SavedQuery_SetFilterState.Call

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmAggregate;
 const aNode: INode): Boolean;
 {* Вызов операции SavedQuery.SetFilterState у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSavedQuery_SetFilterState_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_SavedQuery_SetFilterState, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SavedQuery_SetFilterState.Call

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmEntityForm;
 const aNode: INode): Boolean;
 {* Вызов операции SavedQuery.SetFilterState у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_SavedQuery_SetFilterState.Call

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmContainer;
 const aNode: INode): Boolean;
 {* Вызов операции SavedQuery.SetFilterState у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_SavedQuery_SetFilterState.Call

constructor TFolders_SetCurrent_Params.Create(const aNode: IeeNode);
begin
 inherited Create;
 f_Node := aNode;
end;//TFolders_SetCurrent_Params.Create

class function TFolders_SetCurrent_Params.Make(const aNode: IeeNode): IFolders_SetCurrent_Params;
var
 l_Inst : TFolders_SetCurrent_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolders_SetCurrent_Params.Make

function TFolders_SetCurrent_Params.Get_Node: IeeNode;
begin
 Result := f_Node;
end;//TFolders_SetCurrent_Params.Get_Node

procedure TFolders_SetCurrent_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolders_SetCurrent_Params.ClearFields

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode): Boolean;
 {* Вызов операции Folders.SetCurrent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolders_SetCurrent_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_Folders_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_SetCurrent.Call

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode): Boolean;
 {* Вызов операции Folders.SetCurrent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolders_SetCurrent_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_Folders_SetCurrent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_SetCurrent.Call

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode): Boolean;
 {* Вызов операции Folders.SetCurrent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_Folders_SetCurrent.Call

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode): Boolean;
 {* Вызов операции Folders.SetCurrent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_Folders_SetCurrent.Call

constructor TFolders_FiltrateByFilterInfo_Params.Create(const anInfo: InsFolderFilterInfo);
begin
 inherited Create;
 f_nInfo := anInfo;
end;//TFolders_FiltrateByFilterInfo_Params.Create

class function TFolders_FiltrateByFilterInfo_Params.Make(const anInfo: InsFolderFilterInfo): IFolders_FiltrateByFilterInfo_Params;
var
 l_Inst : TFolders_FiltrateByFilterInfo_Params;
begin
 l_Inst := Create(anInfo);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TFolders_FiltrateByFilterInfo_Params.Make

function TFolders_FiltrateByFilterInfo_Params.Get_nInfo: InsFolderFilterInfo;
begin
 Result := f_nInfo;
end;//TFolders_FiltrateByFilterInfo_Params.Get_nInfo

procedure TFolders_FiltrateByFilterInfo_Params.ClearFields;
begin
 f_nInfo := nil;
 inherited;
end;//TFolders_FiltrateByFilterInfo_Params.ClearFields

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmEntity;
 const anInfo: InsFolderFilterInfo): Boolean;
 {* Вызов операции Folders.FiltrateByFilterInfo у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolders_FiltrateByFilterInfo_Params.Make(anInfo));
  aTarget.Operation(TdmStdRes.opcode_Folders_FiltrateByFilterInfo, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmAggregate;
 const anInfo: InsFolderFilterInfo): Boolean;
 {* Вызов операции Folders.FiltrateByFilterInfo у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolders_FiltrateByFilterInfo_Params.Make(anInfo));
  aTarget.Operation(TdmStdRes.opcode_Folders_FiltrateByFilterInfo, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmEntityForm;
 const anInfo: InsFolderFilterInfo): Boolean;
 {* Вызов операции Folders.FiltrateByFilterInfo у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, anInfo);
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmContainer;
 const anInfo: InsFolderFilterInfo): Boolean;
 {* Вызов операции Folders.FiltrateByFilterInfo у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, anInfo);
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Folders.TryOpenConsultationAnswer у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Folders_TryOpenConsultationAnswer, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Folders.TryOpenConsultationAnswer у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Folders_TryOpenConsultationAnswer, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Folders.TryOpenConsultationAnswer у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Folders.TryOpenConsultationAnswer у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Folders.OpenMyConsultations у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Folders_OpenMyConsultations, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Folders.OpenMyConsultations у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Folders_OpenMyConsultations, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Folders.OpenMyConsultations у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Folders.OpenMyConsultations у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Folders.SetInfoContent у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Folders_SetInfoContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_SetInfoContent.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Folders.SetInfoContent у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Folders_SetInfoContent, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Folders_SetInfoContent.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Folders.SetInfoContent у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Folders_SetInfoContent.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Folders.SetInfoContent у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Folders_SetInfoContent.Call

constructor TUsersRights_UpdateRights_Params.Create(const aNode: IeeNode);
begin
 inherited Create;
 f_Node := aNode;
end;//TUsersRights_UpdateRights_Params.Create

class function TUsersRights_UpdateRights_Params.Make(const aNode: IeeNode): IUsersRights_UpdateRights_Params;
var
 l_Inst : TUsersRights_UpdateRights_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TUsersRights_UpdateRights_Params.Make

function TUsersRights_UpdateRights_Params.Get_Node: IeeNode;
begin
 Result := f_Node;
end;//TUsersRights_UpdateRights_Params.Get_Node

procedure TUsersRights_UpdateRights_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TUsersRights_UpdateRights_Params.ClearFields

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode): Boolean;
 {* Вызов операции UsersRights.UpdateRights у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TUsersRights_UpdateRights_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_UsersRights_UpdateRights, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode): Boolean;
 {* Вызов операции UsersRights.UpdateRights у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TUsersRights_UpdateRights_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_UsersRights_UpdateRights, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode): Boolean;
 {* Вызов операции UsersRights.UpdateRights у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode): Boolean;
 {* Вызов операции UsersRights.UpdateRights у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции UsersRights.FolderShareChanged у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_UsersRights_FolderShareChanged, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции UsersRights.FolderShareChanged у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_UsersRights_FolderShareChanged, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции UsersRights.FolderShareChanged у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции UsersRights.FolderShareChanged у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Result.ExternalOk у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Result_ExternalOk, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Result_ExternalOk.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Result.ExternalOk у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Result_ExternalOk, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Result_ExternalOk.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Result.ExternalOk у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Result_ExternalOk.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Result.ExternalOk у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Result_ExternalOk.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
