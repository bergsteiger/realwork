unit Folders_Strange_Controls;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Strange_Controls.pas"
// ���������: "VCMControls"
// ������� ������: "Strange" MUID: (4A96A8C10357)

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
  {* ��������� ��� �������� AdditionInfo.Close }
  function Get_ModalResult: Integer;
  property ModalResult: Integer
   read Get_ModalResult;
 end;//IAdditionInfo_Close_Params

 Op_AdditionInfo_Close = {final} class
  {* ����� ��� ������ �������� AdditionInfo.Close }
  public
   class function Call(const aTarget: IvcmEntity;
    aModalResult: Integer = Controls.mrCancel): Boolean; overload;
    {* ����� �������� AdditionInfo.Close � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aModalResult: Integer = Controls.mrCancel): Boolean; overload;
    {* ����� �������� AdditionInfo.Close � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aModalResult: Integer = Controls.mrCancel): Boolean; overload;
    {* ����� �������� AdditionInfo.Close � ����� }
   class function Call(const aTarget: IvcmContainer;
    aModalResult: Integer = Controls.mrCancel): Boolean; overload;
    {* ����� �������� AdditionInfo.Close � ���������� }
 end;//Op_AdditionInfo_Close

 IFolderElement_InternalEditByFoldersNode_Params = interface
  {* ��������� ��� �������� FolderElement.InternalEditByFoldersNode }
  function Get_Node: IFoldersNode;
  function Get_InternalCall: Boolean;
  property Node: IFoldersNode
   read Get_Node;
  property InternalCall: Boolean
   read Get_InternalCall;
 end;//IFolderElement_InternalEditByFoldersNode_Params

 Op_FolderElement_InternalEditByFoldersNode = {final} class
  {* ����� ��� ������ �������� FolderElement.InternalEditByFoldersNode }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* ����� �������� FolderElement.InternalEditByFoldersNode � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* ����� �������� FolderElement.InternalEditByFoldersNode � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* ����� �������� FolderElement.InternalEditByFoldersNode � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* ����� �������� FolderElement.InternalEditByFoldersNode � ���������� }
 end;//Op_FolderElement_InternalEditByFoldersNode

 IFolderElement_InternalDelete_Params = interface
  {* ��������� ��� �������� FolderElement.InternalDelete }
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
  {* ����� ��� ������ �������� FolderElement.InternalDelete }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode;
    aAsk: Boolean = True): TnsDeleteResult; overload;
    {* ����� �������� FolderElement.InternalDelete � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode;
    aAsk: Boolean = True): TnsDeleteResult; overload;
    {* ����� �������� FolderElement.InternalDelete � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode;
    aAsk: Boolean = True): TnsDeleteResult; overload;
    {* ����� �������� FolderElement.InternalDelete � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode;
    aAsk: Boolean = True): TnsDeleteResult; overload;
    {* ����� �������� FolderElement.InternalDelete � ���������� }
 end;//Op_FolderElement_InternalDelete

 IFolderElement_InternalEdit_Params = interface
  {* ��������� ��� �������� FolderElement.InternalEdit }
  function Get_Node: IeeNode;
  function Get_InternalCall: Boolean;
  property Node: IeeNode
   read Get_Node;
  property InternalCall: Boolean
   read Get_InternalCall;
 end;//IFolderElement_InternalEdit_Params

 Op_FolderElement_InternalEdit = {final} class
  {* ����� ��� ������ �������� FolderElement.InternalEdit }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* ����� �������� FolderElement.InternalEdit � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* ����� �������� FolderElement.InternalEdit � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* ����� �������� FolderElement.InternalEdit � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode;
    aInternalCall: Boolean = True): Boolean; overload;
    {* ����� �������� FolderElement.InternalEdit � ���������� }
 end;//Op_FolderElement_InternalEdit

 Op_FolderElement_DisableFilter = {final} class
  {* ����� ��� ������ �������� FolderElement.DisableFilter }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� FolderElement.DisableFilter � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� FolderElement.DisableFilter � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� FolderElement.DisableFilter � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� FolderElement.DisableFilter � ���������� }
 end;//Op_FolderElement_DisableFilter

 IFolderElement_SetState_Params = interface
  {* ��������� ��� �������� FolderElement.SetState }
  function Get_InfoType: TFoldersInfoType;
  property InfoType: TFoldersInfoType
   read Get_InfoType;
 end;//IFolderElement_SetState_Params

 Op_FolderElement_SetState = {final} class
  {* ����� ��� ������ �������� FolderElement.SetState }
  public
   class function Call(const aTarget: IvcmEntity;
    aInfoType: TFoldersInfoType): Boolean; overload;
    {* ����� �������� FolderElement.SetState � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aInfoType: TFoldersInfoType): Boolean; overload;
    {* ����� �������� FolderElement.SetState � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aInfoType: TFoldersInfoType): Boolean; overload;
    {* ����� �������� FolderElement.SetState � ����� }
   class function Call(const aTarget: IvcmContainer;
    aInfoType: TFoldersInfoType): Boolean; overload;
    {* ����� �������� FolderElement.SetState � ���������� }
 end;//Op_FolderElement_SetState

 Op_AdditionInfo_Show = {final} class
  {* ����� ��� ������ �������� AdditionInfo.Show }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� AdditionInfo.Show � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� AdditionInfo.Show � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� AdditionInfo.Show � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� AdditionInfo.Show � ���������� }
 end;//Op_AdditionInfo_Show

 Op_AdditionInfo_Hide = {final} class
  {* ����� ��� ������ �������� AdditionInfo.Hide }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� AdditionInfo.Hide � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� AdditionInfo.Hide � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� AdditionInfo.Hide � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� AdditionInfo.Hide � ���������� }
 end;//Op_AdditionInfo_Hide

 IAdditionInfo_SetCaption_Params = interface
  {* ��������� ��� �������� AdditionInfo.SetCaption }
  function Get_Caption: Il3CString;
  property Caption: Il3CString
   read Get_Caption;
 end;//IAdditionInfo_SetCaption_Params

 Op_AdditionInfo_SetCaption = {final} class
  {* ����� ��� ������ �������� AdditionInfo.SetCaption }
  public
   class function Call(const aTarget: IvcmEntity;
    const aCaption: Il3CString): Boolean; overload;
    {* ����� �������� AdditionInfo.SetCaption � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aCaption: Il3CString): Boolean; overload;
    {* ����� �������� AdditionInfo.SetCaption � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aCaption: Il3CString): Boolean; overload;
    {* ����� �������� AdditionInfo.SetCaption � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aCaption: Il3CString): Boolean; overload;
    {* ����� �������� AdditionInfo.SetCaption � ���������� }
 end;//Op_AdditionInfo_SetCaption

 IFolderElement_GetState_Params = interface
  {* ��������� ��� �������� FolderElement.GetState }
  function Get_ResultValue: TFoldersInfoType;
  procedure Set_ResultValue(aValue: TFoldersInfoType);
  property ResultValue: TFoldersInfoType
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFolderElement_GetState_Params

 Op_FolderElement_GetState = {final} class
  {* ����� ��� ������ �������� FolderElement.GetState }
  public
   class function Call(const aTarget: IvcmEntity): TFoldersInfoType; overload;
    {* ����� �������� FolderElement.GetState � �������� }
   class function Call(const aTarget: IvcmAggregate): TFoldersInfoType; overload;
    {* ����� �������� FolderElement.GetState � ��������� }
   class function Call(const aTarget: IvcmEntityForm): TFoldersInfoType; overload;
    {* ����� �������� FolderElement.GetState � ����� }
   class function Call(const aTarget: IvcmContainer): TFoldersInfoType; overload;
    {* ����� �������� FolderElement.GetState � ���������� }
 end;//Op_FolderElement_GetState

 IFolderElement_SetLoadInfo_Params = interface
  {* ��������� ��� �������� FolderElement.SetLoadInfo }
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
  {* ����� ��� ������ �������� FolderElement.SetLoadInfo }
  public
   class function Call(const aTarget: IvcmEntity;
    const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): Boolean; overload;
    {* ����� �������� FolderElement.SetLoadInfo � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): Boolean; overload;
    {* ����� �������� FolderElement.SetLoadInfo � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): Boolean; overload;
    {* ����� �������� FolderElement.SetLoadInfo � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): Boolean; overload;
    {* ����� �������� FolderElement.SetLoadInfo � ���������� }
 end;//Op_FolderElement_SetLoadInfo

 IFolderElement_SetContent_Params = interface
  {* ��������� ��� �������� FolderElement.SetContent }
  function Get_Node: IeeNode;
  function Get_IsNewFolder: Boolean;
  property Node: IeeNode
   read Get_Node;
  property IsNewFolder: Boolean
   read Get_IsNewFolder;
 end;//IFolderElement_SetContent_Params

 Op_FolderElement_SetContent = {final} class
  {* ����� ��� ������ �������� FolderElement.SetContent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = False): Boolean; overload;
    {* ����� �������� FolderElement.SetContent � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = False): Boolean; overload;
    {* ����� �������� FolderElement.SetContent � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = False): Boolean; overload;
    {* ����� �������� FolderElement.SetContent � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = False): Boolean; overload;
    {* ����� �������� FolderElement.SetContent � ���������� }
 end;//Op_FolderElement_SetContent

 IFolderElement_SetSaveInfo_Params = interface
  {* ��������� ��� �������� FolderElement.SetSaveInfo }
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
  {* ����� ��� ������ �������� FolderElement.SetSaveInfo }
  public
   class function Call(const aTarget: IvcmEntity;
    const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Boolean; overload;
    {* ����� �������� FolderElement.SetSaveInfo � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Boolean; overload;
    {* ����� �������� FolderElement.SetSaveInfo � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Boolean; overload;
    {* ����� �������� FolderElement.SetSaveInfo � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Boolean; overload;
    {* ����� �������� FolderElement.SetSaveInfo � ���������� }
 end;//Op_FolderElement_SetSaveInfo

 IFolderElement_ResetModificationOnDelete_Params = interface
  {* ��������� ��� �������� FolderElement.ResetModificationOnDelete }
  function Get_Node: IeeNode;
  property Node: IeeNode
   read Get_Node;
 end;//IFolderElement_ResetModificationOnDelete_Params

 Op_FolderElement_ResetModificationOnDelete = {final} class
  {* ����� ��� ������ �������� FolderElement.ResetModificationOnDelete }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� FolderElement.ResetModificationOnDelete � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� FolderElement.ResetModificationOnDelete � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� FolderElement.ResetModificationOnDelete � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� FolderElement.ResetModificationOnDelete � ���������� }
 end;//Op_FolderElement_ResetModificationOnDelete

 Op_FolderElement_SetFocus = {final} class
  {* ����� ��� ������ �������� FolderElement.SetFocus }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� FolderElement.SetFocus � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� FolderElement.SetFocus � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� FolderElement.SetFocus � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� FolderElement.SetFocus � ���������� }
 end;//Op_FolderElement_SetFocus

 Op_FolderElement_Redraw = {final} class
  {* ����� ��� ������ �������� FolderElement.Redraw }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� FolderElement.Redraw � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� FolderElement.Redraw � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� FolderElement.Redraw � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� FolderElement.Redraw � ���������� }
 end;//Op_FolderElement_Redraw

 Op_FolderElement_DisableSecurityPage = {final} class
  {* ����� ��� ������ �������� FolderElement.DisableSecurityPage }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� FolderElement.DisableSecurityPage � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� FolderElement.DisableSecurityPage � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� FolderElement.DisableSecurityPage � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� FolderElement.DisableSecurityPage � ���������� }
 end;//Op_FolderElement_DisableSecurityPage

 ISavedQuery_SetFilterState_Params = interface
  {* ��������� ��� �������� SavedQuery.SetFilterState }
  function Get_Node: INode;
  property Node: INode
   read Get_Node;
 end;//ISavedQuery_SetFilterState_Params

 Op_SavedQuery_SetFilterState = {final} class
  {* ����� ��� ������ �������� SavedQuery.SetFilterState }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: INode): Boolean; overload;
    {* ����� �������� SavedQuery.SetFilterState � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: INode): Boolean; overload;
    {* ����� �������� SavedQuery.SetFilterState � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: INode): Boolean; overload;
    {* ����� �������� SavedQuery.SetFilterState � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: INode): Boolean; overload;
    {* ����� �������� SavedQuery.SetFilterState � ���������� }
 end;//Op_SavedQuery_SetFilterState

 IFolders_SetCurrent_Params = interface
  {* ��������� ��� �������� Folders.SetCurrent }
  function Get_Node: IeeNode;
  property Node: IeeNode
   read Get_Node;
 end;//IFolders_SetCurrent_Params

 Op_Folders_SetCurrent = {final} class
  {* ����� ��� ������ �������� Folders.SetCurrent }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� Folders.SetCurrent � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� Folders.SetCurrent � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� Folders.SetCurrent � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� Folders.SetCurrent � ���������� }
 end;//Op_Folders_SetCurrent

 IFolders_FiltrateByFilterInfo_Params = interface
  {* ��������� ��� �������� Folders.FiltrateByFilterInfo }
  function Get_nInfo: InsFolderFilterInfo;
  property nInfo: InsFolderFilterInfo
   read Get_nInfo;
 end;//IFolders_FiltrateByFilterInfo_Params

 Op_Folders_FiltrateByFilterInfo = {final} class
  {* ����� ��� ������ �������� Folders.FiltrateByFilterInfo }
  public
   class function Call(const aTarget: IvcmEntity;
    const anInfo: InsFolderFilterInfo): Boolean; overload;
    {* ����� �������� Folders.FiltrateByFilterInfo � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const anInfo: InsFolderFilterInfo): Boolean; overload;
    {* ����� �������� Folders.FiltrateByFilterInfo � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const anInfo: InsFolderFilterInfo): Boolean; overload;
    {* ����� �������� Folders.FiltrateByFilterInfo � ����� }
   class function Call(const aTarget: IvcmContainer;
    const anInfo: InsFolderFilterInfo): Boolean; overload;
    {* ����� �������� Folders.FiltrateByFilterInfo � ���������� }
 end;//Op_Folders_FiltrateByFilterInfo

 Op_Folders_TryOpenConsultationAnswer = {final} class
  {* ����� ��� ������ �������� Folders.TryOpenConsultationAnswer }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Folders.TryOpenConsultationAnswer � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Folders.TryOpenConsultationAnswer � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Folders.TryOpenConsultationAnswer � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Folders.TryOpenConsultationAnswer � ���������� }
 end;//Op_Folders_TryOpenConsultationAnswer

 Op_Folders_OpenMyConsultations = {final} class
  {* ����� ��� ������ �������� Folders.OpenMyConsultations }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Folders.OpenMyConsultations � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Folders.OpenMyConsultations � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Folders.OpenMyConsultations � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Folders.OpenMyConsultations � ���������� }
 end;//Op_Folders_OpenMyConsultations

 Op_Folders_SetInfoContent = {final} class
  {* ����� ��� ������ �������� Folders.SetInfoContent }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Folders.SetInfoContent � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Folders.SetInfoContent � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Folders.SetInfoContent � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Folders.SetInfoContent � ���������� }
 end;//Op_Folders_SetInfoContent

 IUsersRights_UpdateRights_Params = interface
  {* ��������� ��� �������� UsersRights.UpdateRights }
  function Get_Node: IeeNode;
  property Node: IeeNode
   read Get_Node;
 end;//IUsersRights_UpdateRights_Params

 Op_UsersRights_UpdateRights = {final} class
  {* ����� ��� ������ �������� UsersRights.UpdateRights }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� UsersRights.UpdateRights � �������� }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� UsersRights.UpdateRights � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� UsersRights.UpdateRights � ����� }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode): Boolean; overload;
    {* ����� �������� UsersRights.UpdateRights � ���������� }
 end;//Op_UsersRights_UpdateRights

 Op_UsersRights_FolderShareChanged = {final} class
  {* ����� ��� ������ �������� UsersRights.FolderShareChanged }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� UsersRights.FolderShareChanged � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� UsersRights.FolderShareChanged � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� UsersRights.FolderShareChanged � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� UsersRights.FolderShareChanged � ���������� }
 end;//Op_UsersRights_FolderShareChanged

 Op_Result_ExternalOk = {final} class
  {* ����� ��� ������ �������� Result.ExternalOk }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* ����� �������� Result.ExternalOk � �������� }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* ����� �������� Result.ExternalOk � ��������� }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* ����� �������� Result.ExternalOk � ����� }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* ����� �������� Result.ExternalOk � ���������� }
 end;//Op_Result_ExternalOk

const
 en_AdditionInfo = 'AdditionInfo';
 en_capAdditionInfo = '';
 op_Close = 'Close';
 op_capClose = '';
 en_FolderElement = 'FolderElement';
 en_capFolderElement = '������� �����';
 op_InternalEditByFoldersNode = 'InternalEditByFoldersNode';
 op_capInternalEditByFoldersNode = '�������������� ��������';
 op_InternalDelete = 'InternalDelete';
 op_capInternalDelete = '������� ������� �����';
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
 op_capGetState = '���������� ������ ��������';
 op_SetLoadInfo = 'SetLoadInfo';
 op_capSetLoadInfo = '������������� ��������� ��������';
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
 op_capCreateFilter = '������� ������...';
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
  {* ���������� IAdditionInfo_Close_Params }
  private
   f_ModalResult: Integer;
  protected
   function Get_ModalResult: Integer;
  public
   constructor Create(aModalResult: Integer = Controls.mrCancel); reintroduce;
   class function Make(aModalResult: Integer = Controls.mrCancel): IAdditionInfo_Close_Params; reintroduce;
 end;//TAdditionInfo_Close_Params

 TFolderElement_InternalEditByFoldersNode_Params = {final} class(Tl3CProtoObject, IFolderElement_InternalEditByFoldersNode_Params)
  {* ���������� IFolderElement_InternalEditByFoldersNode_Params }
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
  {* ���������� IFolderElement_InternalDelete_Params }
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
  {* ���������� IFolderElement_InternalEdit_Params }
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
  {* ���������� IFolderElement_SetState_Params }
  private
   f_InfoType: TFoldersInfoType;
  protected
   function Get_InfoType: TFoldersInfoType;
  public
   constructor Create(aInfoType: TFoldersInfoType); reintroduce;
   class function Make(aInfoType: TFoldersInfoType): IFolderElement_SetState_Params; reintroduce;
 end;//TFolderElement_SetState_Params

 TAdditionInfo_SetCaption_Params = {final} class(Tl3CProtoObject, IAdditionInfo_SetCaption_Params)
  {* ���������� IAdditionInfo_SetCaption_Params }
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
  {* ���������� IFolderElement_GetState_Params }
  private
   f_ResultValue: TFoldersInfoType;
  protected
   function Get_ResultValue: TFoldersInfoType;
   procedure Set_ResultValue(aValue: TFoldersInfoType);
  public
   class function Make: IFolderElement_GetState_Params; reintroduce;
 end;//TFolderElement_GetState_Params

 TFolderElement_SetLoadInfo_Params = {final} class(Tl3CProtoObject, IFolderElement_SetLoadInfo_Params)
  {* ���������� IFolderElement_SetLoadInfo_Params }
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
  {* ���������� IFolderElement_SetContent_Params }
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
  {* ���������� IFolderElement_SetSaveInfo_Params }
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
  {* ���������� IFolderElement_ResetModificationOnDelete_Params }
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
  {* ���������� ISavedQuery_SetFilterState_Params }
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
  {* ���������� IFolders_SetCurrent_Params }
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
  {* ���������� IFolders_FiltrateByFilterInfo_Params }
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
  {* ���������� IUsersRights_UpdateRights_Params }
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
 {* ����� �������� AdditionInfo.Close � �������� }
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
 {* ����� �������� AdditionInfo.Close � ��������� }
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
 {* ����� �������� AdditionInfo.Close � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aModalResult);
end;//Op_AdditionInfo_Close.Call

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmContainer;
 aModalResult: Integer = Controls.mrCancel): Boolean;
 {* ����� �������� AdditionInfo.Close � ���������� }
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
 {* ����� �������� FolderElement.InternalEditByFoldersNode � �������� }
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
 {* ����� �������� FolderElement.InternalEditByFoldersNode � ��������� }
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
 {* ����� �������� FolderElement.InternalEditByFoldersNode � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aInternalCall);
end;//Op_FolderElement_InternalEditByFoldersNode.Call

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEditByFoldersNode � ���������� }
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
 {* ����� �������� FolderElement.InternalDelete � �������� }
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
 {* ����� �������� FolderElement.InternalDelete � ��������� }
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
 {* ����� �������� FolderElement.InternalDelete � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aAsk);
end;//Op_FolderElement_InternalDelete.Call

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode;
 aAsk: Boolean = True): TnsDeleteResult;
 {* ����� �������� FolderElement.InternalDelete � ���������� }
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
 {* ����� �������� FolderElement.InternalEdit � �������� }
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
 {* ����� �������� FolderElement.InternalEdit � ��������� }
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
 {* ����� �������� FolderElement.InternalEdit � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aInternalCall);
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEdit � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aInternalCall);
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� FolderElement.DisableFilter � �������� }
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
 {* ����� �������� FolderElement.DisableFilter � ��������� }
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
 {* ����� �������� FolderElement.DisableFilter � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_DisableFilter.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� FolderElement.DisableFilter � ���������� }
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
 {* ����� �������� FolderElement.SetState � �������� }
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
 {* ����� �������� FolderElement.SetState � ��������� }
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
 {* ����� �������� FolderElement.SetState � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aInfoType);
end;//Op_FolderElement_SetState.Call

class function Op_FolderElement_SetState.Call(const aTarget: IvcmContainer;
 aInfoType: TFoldersInfoType): Boolean;
 {* ����� �������� FolderElement.SetState � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aInfoType);
end;//Op_FolderElement_SetState.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� AdditionInfo.Show � �������� }
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
 {* ����� �������� AdditionInfo.Show � ��������� }
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
 {* ����� �������� AdditionInfo.Show � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� AdditionInfo.Show � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� AdditionInfo.Hide � �������� }
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
 {* ����� �������� AdditionInfo.Hide � ��������� }
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
 {* ����� �������� AdditionInfo.Hide � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_AdditionInfo_Hide.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� AdditionInfo.Hide � ���������� }
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
 {* ����� �������� AdditionInfo.SetCaption � �������� }
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
 {* ����� �������� AdditionInfo.SetCaption � ��������� }
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
 {* ����� �������� AdditionInfo.SetCaption � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aCaption);
end;//Op_AdditionInfo_SetCaption.Call

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmContainer;
 const aCaption: Il3CString): Boolean;
 {* ����� �������� AdditionInfo.SetCaption � ���������� }
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
 {* ����� �������� FolderElement.GetState � �������� }
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
 {* ����� �������� FolderElement.GetState � ��������� }
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
 {* ����� �������� FolderElement.GetState � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_GetState.Call

class function Op_FolderElement_GetState.Call(const aTarget: IvcmContainer): TFoldersInfoType;
 {* ����� �������� FolderElement.GetState � ���������� }
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
 {* ����� �������� FolderElement.SetLoadInfo � �������� }
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
 {* ����� �������� FolderElement.SetLoadInfo � ��������� }
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
 {* ����� �������� FolderElement.SetLoadInfo � ����� }
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
 {* ����� �������� FolderElement.SetLoadInfo � ���������� }
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
 {* ����� �������� FolderElement.SetContent � �������� }
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
 {* ����� �������� FolderElement.SetContent � ��������� }
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
 {* ����� �������� FolderElement.SetContent � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aIsNewFolder);
end;//Op_FolderElement_SetContent.Call

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode;
 aIsNewFolder: Boolean = False): Boolean;
 {* ����� �������� FolderElement.SetContent � ���������� }
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
 {* ����� �������� FolderElement.SetSaveInfo � �������� }
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
 {* ����� �������� FolderElement.SetSaveInfo � ��������� }
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
 {* ����� �������� FolderElement.SetSaveInfo � ����� }
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
 {* ����� �������� FolderElement.SetSaveInfo � ���������� }
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
 {* ����� �������� FolderElement.ResetModificationOnDelete � �������� }
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
 {* ����� �������� FolderElement.ResetModificationOnDelete � ��������� }
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
 {* ����� �������� FolderElement.ResetModificationOnDelete � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode): Boolean;
 {* ����� �������� FolderElement.ResetModificationOnDelete � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� FolderElement.SetFocus � �������� }
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
 {* ����� �������� FolderElement.SetFocus � ��������� }
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
 {* ����� �������� FolderElement.SetFocus � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� FolderElement.SetFocus � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� FolderElement.Redraw � �������� }
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
 {* ����� �������� FolderElement.Redraw � ��������� }
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
 {* ����� �������� FolderElement.Redraw � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� FolderElement.Redraw � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� FolderElement.DisableSecurityPage � �������� }
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
 {* ����� �������� FolderElement.DisableSecurityPage � ��������� }
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
 {* ����� �������� FolderElement.DisableSecurityPage � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_DisableSecurityPage.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� FolderElement.DisableSecurityPage � ���������� }
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
 {* ����� �������� SavedQuery.SetFilterState � �������� }
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
 {* ����� �������� SavedQuery.SetFilterState � ��������� }
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
 {* ����� �������� SavedQuery.SetFilterState � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_SavedQuery_SetFilterState.Call

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmContainer;
 const aNode: INode): Boolean;
 {* ����� �������� SavedQuery.SetFilterState � ���������� }
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
 {* ����� �������� Folders.SetCurrent � �������� }
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
 {* ����� �������� Folders.SetCurrent � ��������� }
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
 {* ����� �������� Folders.SetCurrent � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_Folders_SetCurrent.Call

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode): Boolean;
 {* ����� �������� Folders.SetCurrent � ���������� }
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
 {* ����� �������� Folders.FiltrateByFilterInfo � �������� }
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
 {* ����� �������� Folders.FiltrateByFilterInfo � ��������� }
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
 {* ����� �������� Folders.FiltrateByFilterInfo � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, anInfo);
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmContainer;
 const anInfo: InsFolderFilterInfo): Boolean;
 {* ����� �������� Folders.FiltrateByFilterInfo � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, anInfo);
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Folders.TryOpenConsultationAnswer � �������� }
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
 {* ����� �������� Folders.TryOpenConsultationAnswer � ��������� }
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
 {* ����� �������� Folders.TryOpenConsultationAnswer � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Folders.TryOpenConsultationAnswer � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Folders.OpenMyConsultations � �������� }
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
 {* ����� �������� Folders.OpenMyConsultations � ��������� }
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
 {* ����� �������� Folders.OpenMyConsultations � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Folders.OpenMyConsultations � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Folders.SetInfoContent � �������� }
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
 {* ����� �������� Folders.SetInfoContent � ��������� }
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
 {* ����� �������� Folders.SetInfoContent � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Folders_SetInfoContent.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Folders.SetInfoContent � ���������� }
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
 {* ����� �������� UsersRights.UpdateRights � �������� }
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
 {* ����� �������� UsersRights.UpdateRights � ��������� }
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
 {* ����� �������� UsersRights.UpdateRights � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode): Boolean;
 {* ����� �������� UsersRights.UpdateRights � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� UsersRights.FolderShareChanged � �������� }
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
 {* ����� �������� UsersRights.FolderShareChanged � ��������� }
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
 {* ����� �������� UsersRights.FolderShareChanged � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� UsersRights.FolderShareChanged � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Result.ExternalOk � �������� }
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
 {* ����� �������� Result.ExternalOk � ��������� }
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
 {* ����� �������� Result.ExternalOk � ����� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Result_ExternalOk.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Result.ExternalOk � ���������� }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Result_ExternalOk.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
