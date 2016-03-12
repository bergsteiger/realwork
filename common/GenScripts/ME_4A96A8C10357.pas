unit Folders_Strange_Controls;
 {* �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders_Strange_Controls.pas"
// ���������: "VCMControls"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nsTypes
 , FoldersUnit
 , eeInterfaces
 , FoldersDomainInterfaces
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseTypesUnit
 , BaseTreeSupportUnit
;

type
 // AdditionInfo

 // FolderElement

 // FolderElement

 // AdditionInfo

 // FolderElement

 // SavedQuery

 // Folders

 // UsersRights

 // Result

 // Folders

 // Folder

 // FolderElement

 // SavedQuery

 // Consultation

 IAdditionInfo_Close_Params = interface
  {* ��������� ��� �������� AdditionInfo.Close }
  ['{9226E430-0264-43B5-AC2A-67B7CB33BA48}']
  function Get_ModalResult: Integer;
  property ModalResult: Integer
   read Get_ModalResult;
 end;//IAdditionInfo_Close_Params

 Op_AdditionInfo_Close = class
  {* ����� ��� ������ �������� AdditionInfo.Close }
  public
   class function Call(const aTarget: IvcmEntity;
    aModalResult: Integer = mrCancel): Boolean; overload;
    {* ����� �������� AdditionInfo.Close � �������� }
   class function Call(const aTarget: IvcmAggregate;
    aModalResult: Integer = mrCancel): Boolean; overload;
    {* ����� �������� AdditionInfo.Close � ��������� }
   class function Call(const aTarget: IvcmEntityForm;
    aModalResult: Integer = mrCancel): Boolean; overload;
    {* ����� �������� AdditionInfo.Close � ����� }
   class function Call(const aTarget: IvcmContainer;
    aModalResult: Integer = mrCancel): Boolean; overload;
    {* ����� �������� AdditionInfo.Close � ���������� }
 end;//Op_AdditionInfo_Close

 IFolderElement_InternalEditByFoldersNode_Params = interface
  {* ��������� ��� �������� FolderElement.InternalEditByFoldersNode }
  ['{6144FDBB-9D7F-4688-931E-DF84D15322F0}']
  function Get_Node: IFoldersNode;
  function Get_InternalCall: Boolean;
  property Node: IFoldersNode
   read Get_Node;
  property InternalCall: Boolean
   read Get_InternalCall;
 end;//IFolderElement_InternalEditByFoldersNode_Params

 Op_FolderElement_InternalEditByFoldersNode = class
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
  ['{3C0D7134-4902-43E6-8106-B763BD833E87}']
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

 Op_FolderElement_InternalDelete = class
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
  ['{72692263-6D12-46A0-8B9A-84724B440086}']
  function Get_Node: IeeNode;
  function Get_InternalCall: Boolean;
  property Node: IeeNode
   read Get_Node;
  property InternalCall: Boolean
   read Get_InternalCall;
 end;//IFolderElement_InternalEdit_Params

 Op_FolderElement_InternalEdit = class
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

 Op_FolderElement_DisableFilter = class
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
  ['{BB99FD2E-C261-4D39-A1F6-2CBEC10A14EF}']
  function Get_InfoType: TFoldersInfoType;
  property InfoType: TFoldersInfoType
   read Get_InfoType;
 end;//IFolderElement_SetState_Params

 Op_FolderElement_SetState = class
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

 Op_AdditionInfo_Show = class
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

 Op_AdditionInfo_Hide = class
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
  ['{562262E6-D6D7-4895-A2E5-200EC677B72B}']
  function Get_Caption: Il3CString;
  property Caption: Il3CString
   read Get_Caption;
 end;//IAdditionInfo_SetCaption_Params

 Op_AdditionInfo_SetCaption = class
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
  ['{5B0752CC-2818-4C0A-9474-FD2BEF3C8BCC}']
  function Get_ResultValue: TFoldersInfoType;
  procedure Set_ResultValue(aValue: TFoldersInfoType);
  property ResultValue: TFoldersInfoType
   read Get_ResultValue
   write Set_ResultValue;
 end;//IFolderElement_GetState_Params

 Op_FolderElement_GetState = class
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
  ['{4EB5D256-A884-4CB6-AF26-748E60362EA7}']
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

 Op_FolderElement_SetLoadInfo = class
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
  ['{576C40FA-14A7-4273-8161-EC48C48D019C}']
  function Get_Node: IeeNode;
  function Get_IsNewFolder: Boolean;
  property Node: IeeNode
   read Get_Node;
  property IsNewFolder: Boolean
   read Get_IsNewFolder;
 end;//IFolderElement_SetContent_Params

 Op_FolderElement_SetContent = class
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
  ['{68083266-8E03-47D6-BA1C-588398BD2B3E}']
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

 Op_FolderElement_SetSaveInfo = class
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
  ['{4BEF66FF-5C40-49B8-A1CE-7DF6D72FDF30}']
  function Get_Node: IeeNode;
  property Node: IeeNode
   read Get_Node;
 end;//IFolderElement_ResetModificationOnDelete_Params

 Op_FolderElement_ResetModificationOnDelete = class
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

 Op_FolderElement_SetFocus = class
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

 Op_FolderElement_Redraw = class
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

 Op_FolderElement_DisableSecurityPage = class
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
  ['{91AE5E97-316A-4517-9270-5309FEC7089B}']
  function Get_Node: INode;
  property Node: INode
   read Get_Node;
 end;//ISavedQuery_SetFilterState_Params

 Op_SavedQuery_SetFilterState = class
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
  ['{578A7FA9-B757-4092-9FCF-34375B8C8127}']
  function Get_Node: IeeNode;
  property Node: IeeNode
   read Get_Node;
 end;//IFolders_SetCurrent_Params

 Op_Folders_SetCurrent = class
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
  ['{32257A40-C1F2-41EA-B97F-6A410F4AD198}']
  function Get_nInfo: InsFolderFilterInfo;
  property nInfo: InsFolderFilterInfo
   read Get_nInfo;
 end;//IFolders_FiltrateByFilterInfo_Params

 Op_Folders_FiltrateByFilterInfo = class
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

 Op_Folders_TryOpenConsultationAnswer = class
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

 Op_Folders_OpenMyConsultations = class
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

 Op_Folders_SetInfoContent = class
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
  ['{6B09258D-5632-4473-B4F3-2953E11E33F8}']
  function Get_Node: IeeNode;
  property Node: IeeNode
   read Get_Node;
 end;//IUsersRights_UpdateRights_Params

 Op_UsersRights_UpdateRights = class
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

 Op_UsersRights_FolderShareChanged = class
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

 Op_Result_ExternalOk = class
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TAdditionInfo_Close_Params = class(Tl3CProtoObject, IAdditionInfo_Close_Params)
  {* ���������� IAdditionInfo_Close_Params }
  private
   f_ModalResult: Integer;
  protected
   function Get_ModalResult: Integer;
  public
   constructor Create(aModalResult: Integer); reintroduce;
    {* ����������� TAdditionInfo_Close_Params }
   class function Make(aModalResult: Integer): IAdditionInfo_Close_Params; reintroduce;
    {* ������� TAdditionInfo_Close_Params }
 end;//TAdditionInfo_Close_Params

 TFolderElement_InternalEditByFoldersNode_Params = class(Tl3CProtoObject, IFolderElement_InternalEditByFoldersNode_Params)
  {* ���������� IFolderElement_InternalEditByFoldersNode_Params }
  private
   f_Node: IFoldersNode;
   f_InternalCall: Boolean;
  protected
   function Get_InternalCall: Boolean;
   function Get_Node: IFoldersNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IFoldersNode;
    aInternalCall: Boolean); reintroduce;
    {* ����������� TFolderElement_InternalEditByFoldersNode_Params }
   class function Make(const aNode: IFoldersNode;
    aInternalCall: Boolean): IFolderElement_InternalEditByFoldersNode_Params; reintroduce;
    {* ������� TFolderElement_InternalEditByFoldersNode_Params }
 end;//TFolderElement_InternalEditByFoldersNode_Params

 TFolderElement_InternalDelete_Params = class(Tl3CProtoObject, IFolderElement_InternalDelete_Params)
  {* ���������� IFolderElement_InternalDelete_Params }
  private
   f_Node: IFoldersNode;
   f_Ask: Boolean;
   f_ResultValue: TnsDeleteResult;
  protected
   function Get_Ask: Boolean;
   function Get_Node: IFoldersNode;
   function Get_ResultValue: TnsDeleteResult;
   procedure Set_ResultValue(aValue: TnsDeleteResult);
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IFoldersNode;
    aAsk: Boolean); reintroduce;
    {* ����������� TFolderElement_InternalDelete_Params }
   class function Make(const aNode: IFoldersNode;
    aAsk: Boolean): IFolderElement_InternalDelete_Params; reintroduce;
    {* ������� TFolderElement_InternalDelete_Params }
 end;//TFolderElement_InternalDelete_Params

 TFolderElement_InternalEdit_Params = class(Tl3CProtoObject, IFolderElement_InternalEdit_Params)
  {* ���������� IFolderElement_InternalEdit_Params }
  private
   f_Node: IeeNode;
   f_InternalCall: Boolean;
  protected
   function Get_InternalCall: Boolean;
   function Get_Node: IeeNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode;
    aInternalCall: Boolean); reintroduce;
    {* ����������� TFolderElement_InternalEdit_Params }
   class function Make(const aNode: IeeNode;
    aInternalCall: Boolean): IFolderElement_InternalEdit_Params; reintroduce;
    {* ������� TFolderElement_InternalEdit_Params }
 end;//TFolderElement_InternalEdit_Params

 TFolderElement_SetState_Params = class(Tl3CProtoObject, IFolderElement_SetState_Params)
  {* ���������� IFolderElement_SetState_Params }
  private
   f_InfoType: TFoldersInfoType;
  protected
   function Get_InfoType: TFoldersInfoType;
  public
   constructor Create(aInfoType: TFoldersInfoType); reintroduce;
    {* ����������� TFolderElement_SetState_Params }
   class function Make(aInfoType: TFoldersInfoType): IFolderElement_SetState_Params; reintroduce;
    {* ������� TFolderElement_SetState_Params }
 end;//TFolderElement_SetState_Params

 TAdditionInfo_SetCaption_Params = class(Tl3CProtoObject, IAdditionInfo_SetCaption_Params)
  {* ���������� IAdditionInfo_SetCaption_Params }
  private
   f_Caption: Il3CString;
  protected
   function Get_Caption: Il3CString;
   procedure ClearFields; override;
  public
   constructor Create(const aCaption: Il3CString); reintroduce;
    {* ����������� TAdditionInfo_SetCaption_Params }
   class function Make(const aCaption: Il3CString): IAdditionInfo_SetCaption_Params; reintroduce;
    {* ������� TAdditionInfo_SetCaption_Params }
 end;//TAdditionInfo_SetCaption_Params

 TFolderElement_GetState_Params = class(Tl3CProtoObject, IFolderElement_GetState_Params)
  {* ���������� IFolderElement_GetState_Params }
  private
   f_ResultValue: TFoldersInfoType;
  protected
   function Get_ResultValue: TFoldersInfoType;
   procedure Set_ResultValue(aValue: TFoldersInfoType);
  public
   constructor Create; reintroduce;
    {* ����������� TFolderElement_GetState_Params }
   class function Make: IFolderElement_GetState_Params; reintroduce;
    {* ������� TFolderElement_GetState_Params }
 end;//TFolderElement_GetState_Params

 TFolderElement_SetLoadInfo_Params = class(Tl3CProtoObject, IFolderElement_SetLoadInfo_Params)
  {* ���������� IFolderElement_SetLoadInfo_Params }
  private
   f_Form: IvcmEntityForm;
   f_FolderFilterInfo: InsFolderFilterInfo;
   f_Caption: Il3CString;
   f_Data: IUnknown;
   f_nOp: TListLogicOperation;
  protected
   function Get_Data: IUnknown;
   function Get_nOp: TListLogicOperation;
   function Get_Form: IvcmEntityForm;
   function Get_Caption: Il3CString;
   function Get_FolderFilterInfo: InsFolderFilterInfo;
   procedure ClearFields; override;
  public
   constructor Create(const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation); reintroduce;
    {* ����������� TFolderElement_SetLoadInfo_Params }
   class function Make(const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): IFolderElement_SetLoadInfo_Params; reintroduce;
    {* ������� TFolderElement_SetLoadInfo_Params }
 end;//TFolderElement_SetLoadInfo_Params

 TFolderElement_SetContent_Params = class(Tl3CProtoObject, IFolderElement_SetContent_Params)
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
    aIsNewFolder: Boolean); reintroduce;
    {* ����������� TFolderElement_SetContent_Params }
   class function Make(const aNode: IeeNode;
    aIsNewFolder: Boolean): IFolderElement_SetContent_Params; reintroduce;
    {* ������� TFolderElement_SetContent_Params }
 end;//TFolderElement_SetContent_Params

 TFolderElement_SetSaveInfo_Params = class(Tl3CProtoObject, IFolderElement_SetSaveInfo_Params)
  {* ���������� IFolderElement_SetSaveInfo_Params }
  private
   f_Form: IvcmEntityForm;
   f_FilterInfo: InsFolderFilterInfo;
   f_nElementType: TFoldersElementType;
   f_nEntity: IEntityBase;
   f_SaveAs: Boolean;
  protected
   function Get_SaveAs: Boolean;
   function Get_nEntity: IEntityBase;
   function Get_nElementType: TFoldersElementType;
   function Get_FilterInfo: InsFolderFilterInfo;
   function Get_Form: IvcmEntityForm;
   procedure ClearFields; override;
  public
   constructor Create(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean); reintroduce;
    {* ����������� TFolderElement_SetSaveInfo_Params }
   class function Make(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): IFolderElement_SetSaveInfo_Params; reintroduce;
    {* ������� TFolderElement_SetSaveInfo_Params }
 end;//TFolderElement_SetSaveInfo_Params

 TFolderElement_ResetModificationOnDelete_Params = class(Tl3CProtoObject, IFolderElement_ResetModificationOnDelete_Params)
  {* ���������� IFolderElement_ResetModificationOnDelete_Params }
  private
   f_Node: IeeNode;
  protected
   function Get_Node: IeeNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode); reintroduce;
    {* ����������� TFolderElement_ResetModificationOnDelete_Params }
   class function Make(const aNode: IeeNode): IFolderElement_ResetModificationOnDelete_Params; reintroduce;
    {* ������� TFolderElement_ResetModificationOnDelete_Params }
 end;//TFolderElement_ResetModificationOnDelete_Params

 TSavedQuery_SetFilterState_Params = class(Tl3CProtoObject, ISavedQuery_SetFilterState_Params)
  {* ���������� ISavedQuery_SetFilterState_Params }
  private
   f_Node: INode;
  protected
   function Get_Node: INode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: INode); reintroduce;
    {* ����������� TSavedQuery_SetFilterState_Params }
   class function Make(const aNode: INode): ISavedQuery_SetFilterState_Params; reintroduce;
    {* ������� TSavedQuery_SetFilterState_Params }
 end;//TSavedQuery_SetFilterState_Params

 TFolders_SetCurrent_Params = class(Tl3CProtoObject, IFolders_SetCurrent_Params)
  {* ���������� IFolders_SetCurrent_Params }
  private
   f_Node: IeeNode;
  protected
   function Get_Node: IeeNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode); reintroduce;
    {* ����������� TFolders_SetCurrent_Params }
   class function Make(const aNode: IeeNode): IFolders_SetCurrent_Params; reintroduce;
    {* ������� TFolders_SetCurrent_Params }
 end;//TFolders_SetCurrent_Params

 TFolders_FiltrateByFilterInfo_Params = class(Tl3CProtoObject, IFolders_FiltrateByFilterInfo_Params)
  {* ���������� IFolders_FiltrateByFilterInfo_Params }
  private
   f_nInfo: InsFolderFilterInfo;
  protected
   function Get_nInfo: InsFolderFilterInfo;
   procedure ClearFields; override;
  public
   constructor Create(const anInfo: InsFolderFilterInfo); reintroduce;
    {* ����������� TFolders_FiltrateByFilterInfo_Params }
   class function Make(const anInfo: InsFolderFilterInfo): IFolders_FiltrateByFilterInfo_Params; reintroduce;
    {* ������� TFolders_FiltrateByFilterInfo_Params }
 end;//TFolders_FiltrateByFilterInfo_Params

 TUsersRights_UpdateRights_Params = class(Tl3CProtoObject, IUsersRights_UpdateRights_Params)
  {* ���������� IUsersRights_UpdateRights_Params }
  private
   f_Node: IeeNode;
  protected
   function Get_Node: IeeNode;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: IeeNode); reintroduce;
    {* ����������� TUsersRights_UpdateRights_Params }
   class function Make(const aNode: IeeNode): IUsersRights_UpdateRights_Params; reintroduce;
    {* ������� TUsersRights_UpdateRights_Params }
 end;//TUsersRights_UpdateRights_Params

constructor TAdditionInfo_Close_Params.Create(aModalResult: Integer);
 {* ����������� TAdditionInfo_Close_Params }
//#UC START# *419614473353_15D8390455AB_var*
//#UC END# *419614473353_15D8390455AB_var*
begin
//#UC START# *419614473353_15D8390455AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *419614473353_15D8390455AB_impl*
end;//TAdditionInfo_Close_Params.Create

class function TAdditionInfo_Close_Params.Make(aModalResult: Integer): IAdditionInfo_Close_Params;
 {* ������� TAdditionInfo_Close_Params }
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
//#UC START# *A57548EBE485_15D8390455ABget_var*
//#UC END# *A57548EBE485_15D8390455ABget_var*
begin
//#UC START# *A57548EBE485_15D8390455ABget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A57548EBE485_15D8390455ABget_impl*
end;//TAdditionInfo_Close_Params.Get_ModalResult

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmEntity;
 aModalResult: Integer = mrCancel): Boolean;
 {* ����� �������� AdditionInfo.Close � �������� }
//#UC START# *D61D52DD1903_632AB0324FC3_var*
//#UC END# *D61D52DD1903_632AB0324FC3_var*
begin
//#UC START# *D61D52DD1903_632AB0324FC3_impl*
 !!! Needs to be implemented !!!
//#UC END# *D61D52DD1903_632AB0324FC3_impl*
end;//Op_AdditionInfo_Close.Call

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmAggregate;
 aModalResult: Integer = mrCancel): Boolean;
 {* ����� �������� AdditionInfo.Close � ��������� }
//#UC START# *B9210FC0A354_632AB0324FC3_var*
//#UC END# *B9210FC0A354_632AB0324FC3_var*
begin
//#UC START# *B9210FC0A354_632AB0324FC3_impl*
 !!! Needs to be implemented !!!
//#UC END# *B9210FC0A354_632AB0324FC3_impl*
end;//Op_AdditionInfo_Close.Call

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmEntityForm;
 aModalResult: Integer = mrCancel): Boolean;
 {* ����� �������� AdditionInfo.Close � ����� }
//#UC START# *F880CCE88FFF_632AB0324FC3_var*
//#UC END# *F880CCE88FFF_632AB0324FC3_var*
begin
//#UC START# *F880CCE88FFF_632AB0324FC3_impl*
 !!! Needs to be implemented !!!
//#UC END# *F880CCE88FFF_632AB0324FC3_impl*
end;//Op_AdditionInfo_Close.Call

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmContainer;
 aModalResult: Integer = mrCancel): Boolean;
 {* ����� �������� AdditionInfo.Close � ���������� }
//#UC START# *7C2B93BC35BA_632AB0324FC3_var*
//#UC END# *7C2B93BC35BA_632AB0324FC3_var*
begin
//#UC START# *7C2B93BC35BA_632AB0324FC3_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C2B93BC35BA_632AB0324FC3_impl*
end;//Op_AdditionInfo_Close.Call

constructor TFolderElement_InternalEditByFoldersNode_Params.Create(const aNode: IFoldersNode;
 aInternalCall: Boolean);
 {* ����������� TFolderElement_InternalEditByFoldersNode_Params }
//#UC START# *6E2689A13DE5_C611FEAA3B32_var*
//#UC END# *6E2689A13DE5_C611FEAA3B32_var*
begin
//#UC START# *6E2689A13DE5_C611FEAA3B32_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E2689A13DE5_C611FEAA3B32_impl*
end;//TFolderElement_InternalEditByFoldersNode_Params.Create

class function TFolderElement_InternalEditByFoldersNode_Params.Make(const aNode: IFoldersNode;
 aInternalCall: Boolean): IFolderElement_InternalEditByFoldersNode_Params;
 {* ������� TFolderElement_InternalEditByFoldersNode_Params }
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

function TFolderElement_InternalEditByFoldersNode_Params.Get_InternalCall: Boolean;
//#UC START# *1F6A779BEF5E_C611FEAA3B32get_var*
//#UC END# *1F6A779BEF5E_C611FEAA3B32get_var*
begin
//#UC START# *1F6A779BEF5E_C611FEAA3B32get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1F6A779BEF5E_C611FEAA3B32get_impl*
end;//TFolderElement_InternalEditByFoldersNode_Params.Get_InternalCall

function TFolderElement_InternalEditByFoldersNode_Params.Get_Node: IFoldersNode;
//#UC START# *28F3BAD2A36D_C611FEAA3B32get_var*
//#UC END# *28F3BAD2A36D_C611FEAA3B32get_var*
begin
//#UC START# *28F3BAD2A36D_C611FEAA3B32get_impl*
 !!! Needs to be implemented !!!
//#UC END# *28F3BAD2A36D_C611FEAA3B32get_impl*
end;//TFolderElement_InternalEditByFoldersNode_Params.Get_Node

procedure TFolderElement_InternalEditByFoldersNode_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolderElement_InternalEditByFoldersNode_Params.ClearFields

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmEntity;
 const aNode: IFoldersNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEditByFoldersNode � �������� }
//#UC START# *8ED2BC7A8F80_9893974F32C9_var*
//#UC END# *8ED2BC7A8F80_9893974F32C9_var*
begin
//#UC START# *8ED2BC7A8F80_9893974F32C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *8ED2BC7A8F80_9893974F32C9_impl*
end;//Op_FolderElement_InternalEditByFoldersNode.Call

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmAggregate;
 const aNode: IFoldersNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEditByFoldersNode � ��������� }
//#UC START# *BF127C6A19D0_9893974F32C9_var*
//#UC END# *BF127C6A19D0_9893974F32C9_var*
begin
//#UC START# *BF127C6A19D0_9893974F32C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *BF127C6A19D0_9893974F32C9_impl*
end;//Op_FolderElement_InternalEditByFoldersNode.Call

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmEntityForm;
 const aNode: IFoldersNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEditByFoldersNode � ����� }
//#UC START# *734DBF0E24E2_9893974F32C9_var*
//#UC END# *734DBF0E24E2_9893974F32C9_var*
begin
//#UC START# *734DBF0E24E2_9893974F32C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *734DBF0E24E2_9893974F32C9_impl*
end;//Op_FolderElement_InternalEditByFoldersNode.Call

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEditByFoldersNode � ���������� }
//#UC START# *2A24DFFD2F5D_9893974F32C9_var*
//#UC END# *2A24DFFD2F5D_9893974F32C9_var*
begin
//#UC START# *2A24DFFD2F5D_9893974F32C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *2A24DFFD2F5D_9893974F32C9_impl*
end;//Op_FolderElement_InternalEditByFoldersNode.Call

constructor TFolderElement_InternalDelete_Params.Create(const aNode: IFoldersNode;
 aAsk: Boolean);
 {* ����������� TFolderElement_InternalDelete_Params }
//#UC START# *B91977434D14_049472591E6B_var*
//#UC END# *B91977434D14_049472591E6B_var*
begin
//#UC START# *B91977434D14_049472591E6B_impl*
 !!! Needs to be implemented !!!
//#UC END# *B91977434D14_049472591E6B_impl*
end;//TFolderElement_InternalDelete_Params.Create

class function TFolderElement_InternalDelete_Params.Make(const aNode: IFoldersNode;
 aAsk: Boolean): IFolderElement_InternalDelete_Params;
 {* ������� TFolderElement_InternalDelete_Params }
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

function TFolderElement_InternalDelete_Params.Get_Ask: Boolean;
//#UC START# *89DC27D195D1_049472591E6Bget_var*
//#UC END# *89DC27D195D1_049472591E6Bget_var*
begin
//#UC START# *89DC27D195D1_049472591E6Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *89DC27D195D1_049472591E6Bget_impl*
end;//TFolderElement_InternalDelete_Params.Get_Ask

function TFolderElement_InternalDelete_Params.Get_Node: IFoldersNode;
//#UC START# *EA2057A4EC4D_049472591E6Bget_var*
//#UC END# *EA2057A4EC4D_049472591E6Bget_var*
begin
//#UC START# *EA2057A4EC4D_049472591E6Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *EA2057A4EC4D_049472591E6Bget_impl*
end;//TFolderElement_InternalDelete_Params.Get_Node

function TFolderElement_InternalDelete_Params.Get_ResultValue: TnsDeleteResult;
//#UC START# *FAB63DD9E9CD_049472591E6Bget_var*
//#UC END# *FAB63DD9E9CD_049472591E6Bget_var*
begin
//#UC START# *FAB63DD9E9CD_049472591E6Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *FAB63DD9E9CD_049472591E6Bget_impl*
end;//TFolderElement_InternalDelete_Params.Get_ResultValue

procedure TFolderElement_InternalDelete_Params.Set_ResultValue(aValue: TnsDeleteResult);
//#UC START# *FAB63DD9E9CD_049472591E6Bset_var*
//#UC END# *FAB63DD9E9CD_049472591E6Bset_var*
begin
//#UC START# *FAB63DD9E9CD_049472591E6Bset_impl*
 !!! Needs to be implemented !!!
//#UC END# *FAB63DD9E9CD_049472591E6Bset_impl*
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
//#UC START# *D0978B425229_24752B31D82E_var*
//#UC END# *D0978B425229_24752B31D82E_var*
begin
//#UC START# *D0978B425229_24752B31D82E_impl*
 !!! Needs to be implemented !!!
//#UC END# *D0978B425229_24752B31D82E_impl*
end;//Op_FolderElement_InternalDelete.Call

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmAggregate;
 const aNode: IFoldersNode;
 aAsk: Boolean = True): TnsDeleteResult;
 {* ����� �������� FolderElement.InternalDelete � ��������� }
//#UC START# *00D74B30DC7A_24752B31D82E_var*
//#UC END# *00D74B30DC7A_24752B31D82E_var*
begin
//#UC START# *00D74B30DC7A_24752B31D82E_impl*
 !!! Needs to be implemented !!!
//#UC END# *00D74B30DC7A_24752B31D82E_impl*
end;//Op_FolderElement_InternalDelete.Call

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmEntityForm;
 const aNode: IFoldersNode;
 aAsk: Boolean = True): TnsDeleteResult;
 {* ����� �������� FolderElement.InternalDelete � ����� }
//#UC START# *20978A8CA999_24752B31D82E_var*
//#UC END# *20978A8CA999_24752B31D82E_var*
begin
//#UC START# *20978A8CA999_24752B31D82E_impl*
 !!! Needs to be implemented !!!
//#UC END# *20978A8CA999_24752B31D82E_impl*
end;//Op_FolderElement_InternalDelete.Call

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmContainer;
 const aNode: IFoldersNode;
 aAsk: Boolean = True): TnsDeleteResult;
 {* ����� �������� FolderElement.InternalDelete � ���������� }
//#UC START# *B850FE156F8E_24752B31D82E_var*
//#UC END# *B850FE156F8E_24752B31D82E_var*
begin
//#UC START# *B850FE156F8E_24752B31D82E_impl*
 !!! Needs to be implemented !!!
//#UC END# *B850FE156F8E_24752B31D82E_impl*
end;//Op_FolderElement_InternalDelete.Call

constructor TFolderElement_InternalEdit_Params.Create(const aNode: IeeNode;
 aInternalCall: Boolean);
 {* ����������� TFolderElement_InternalEdit_Params }
//#UC START# *7CF6C26315BB_12504A934291_var*
//#UC END# *7CF6C26315BB_12504A934291_var*
begin
//#UC START# *7CF6C26315BB_12504A934291_impl*
 !!! Needs to be implemented !!!
//#UC END# *7CF6C26315BB_12504A934291_impl*
end;//TFolderElement_InternalEdit_Params.Create

class function TFolderElement_InternalEdit_Params.Make(const aNode: IeeNode;
 aInternalCall: Boolean): IFolderElement_InternalEdit_Params;
 {* ������� TFolderElement_InternalEdit_Params }
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

function TFolderElement_InternalEdit_Params.Get_InternalCall: Boolean;
//#UC START# *C19EAE4E43A4_12504A934291get_var*
//#UC END# *C19EAE4E43A4_12504A934291get_var*
begin
//#UC START# *C19EAE4E43A4_12504A934291get_impl*
 !!! Needs to be implemented !!!
//#UC END# *C19EAE4E43A4_12504A934291get_impl*
end;//TFolderElement_InternalEdit_Params.Get_InternalCall

function TFolderElement_InternalEdit_Params.Get_Node: IeeNode;
//#UC START# *D97B6080110F_12504A934291get_var*
//#UC END# *D97B6080110F_12504A934291get_var*
begin
//#UC START# *D97B6080110F_12504A934291get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D97B6080110F_12504A934291get_impl*
end;//TFolderElement_InternalEdit_Params.Get_Node

procedure TFolderElement_InternalEdit_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolderElement_InternalEdit_Params.ClearFields

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEdit � �������� }
//#UC START# *2BFA7567210F_96EC1F87461E_var*
//#UC END# *2BFA7567210F_96EC1F87461E_var*
begin
//#UC START# *2BFA7567210F_96EC1F87461E_impl*
 !!! Needs to be implemented !!!
//#UC END# *2BFA7567210F_96EC1F87461E_impl*
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEdit � ��������� }
//#UC START# *5C3A3555AB5F_96EC1F87461E_var*
//#UC END# *5C3A3555AB5F_96EC1F87461E_var*
begin
//#UC START# *5C3A3555AB5F_96EC1F87461E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C3A3555AB5F_96EC1F87461E_impl*
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEdit � ����� }
//#UC START# *109D5C1F344F_96EC1F87461E_var*
//#UC END# *109D5C1F344F_96EC1F87461E_var*
begin
//#UC START# *109D5C1F344F_96EC1F87461E_impl*
 !!! Needs to be implemented !!!
//#UC END# *109D5C1F344F_96EC1F87461E_impl*
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode;
 aInternalCall: Boolean = True): Boolean;
 {* ����� �������� FolderElement.InternalEdit � ���������� }
//#UC START# *611AA4F9DCDB_96EC1F87461E_var*
//#UC END# *611AA4F9DCDB_96EC1F87461E_var*
begin
//#UC START# *611AA4F9DCDB_96EC1F87461E_impl*
 !!! Needs to be implemented !!!
//#UC END# *611AA4F9DCDB_96EC1F87461E_impl*
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� FolderElement.DisableFilter � �������� }
//#UC START# *5640C49B8E0F_B2C9E26DCC5A_var*
//#UC END# *5640C49B8E0F_B2C9E26DCC5A_var*
begin
//#UC START# *5640C49B8E0F_B2C9E26DCC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5640C49B8E0F_B2C9E26DCC5A_impl*
end;//Op_FolderElement_DisableFilter.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� FolderElement.DisableFilter � ��������� }
//#UC START# *8680848B185F_B2C9E26DCC5A_var*
//#UC END# *8680848B185F_B2C9E26DCC5A_var*
begin
//#UC START# *8680848B185F_B2C9E26DCC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *8680848B185F_B2C9E26DCC5A_impl*
end;//Op_FolderElement_DisableFilter.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� FolderElement.DisableFilter � ����� }
//#UC START# *C8FC6BF96DD5_B2C9E26DCC5A_var*
//#UC END# *C8FC6BF96DD5_B2C9E26DCC5A_var*
begin
//#UC START# *C8FC6BF96DD5_B2C9E26DCC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *C8FC6BF96DD5_B2C9E26DCC5A_impl*
end;//Op_FolderElement_DisableFilter.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� FolderElement.DisableFilter � ���������� }
//#UC START# *C3D16983C3D1_B2C9E26DCC5A_var*
//#UC END# *C3D16983C3D1_B2C9E26DCC5A_var*
begin
//#UC START# *C3D16983C3D1_B2C9E26DCC5A_impl*
 !!! Needs to be implemented !!!
//#UC END# *C3D16983C3D1_B2C9E26DCC5A_impl*
end;//Op_FolderElement_DisableFilter.Call

constructor TFolderElement_SetState_Params.Create(aInfoType: TFoldersInfoType);
 {* ����������� TFolderElement_SetState_Params }
//#UC START# *43D57B82AD31_B364B386236B_var*
//#UC END# *43D57B82AD31_B364B386236B_var*
begin
//#UC START# *43D57B82AD31_B364B386236B_impl*
 !!! Needs to be implemented !!!
//#UC END# *43D57B82AD31_B364B386236B_impl*
end;//TFolderElement_SetState_Params.Create

class function TFolderElement_SetState_Params.Make(aInfoType: TFoldersInfoType): IFolderElement_SetState_Params;
 {* ������� TFolderElement_SetState_Params }
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
//#UC START# *C1B5C844C068_B364B386236Bget_var*
//#UC END# *C1B5C844C068_B364B386236Bget_var*
begin
//#UC START# *C1B5C844C068_B364B386236Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *C1B5C844C068_B364B386236Bget_impl*
end;//TFolderElement_SetState_Params.Get_InfoType

class function Op_FolderElement_SetState.Call(const aTarget: IvcmEntity;
 aInfoType: TFoldersInfoType): Boolean;
 {* ����� �������� FolderElement.SetState � �������� }
//#UC START# *E9F439C389F4_8460A7DA08F4_var*
//#UC END# *E9F439C389F4_8460A7DA08F4_var*
begin
//#UC START# *E9F439C389F4_8460A7DA08F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *E9F439C389F4_8460A7DA08F4_impl*
end;//Op_FolderElement_SetState.Call

class function Op_FolderElement_SetState.Call(const aTarget: IvcmAggregate;
 aInfoType: TFoldersInfoType): Boolean;
 {* ����� �������� FolderElement.SetState � ��������� }
//#UC START# *1A33F9B21445_8460A7DA08F4_var*
//#UC END# *1A33F9B21445_8460A7DA08F4_var*
begin
//#UC START# *1A33F9B21445_8460A7DA08F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *1A33F9B21445_8460A7DA08F4_impl*
end;//Op_FolderElement_SetState.Call

class function Op_FolderElement_SetState.Call(const aTarget: IvcmEntityForm;
 aInfoType: TFoldersInfoType): Boolean;
 {* ����� �������� FolderElement.SetState � ����� }
//#UC START# *3A2B7F14E228_8460A7DA08F4_var*
//#UC END# *3A2B7F14E228_8460A7DA08F4_var*
begin
//#UC START# *3A2B7F14E228_8460A7DA08F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A2B7F14E228_8460A7DA08F4_impl*
end;//Op_FolderElement_SetState.Call

class function Op_FolderElement_SetState.Call(const aTarget: IvcmContainer;
 aInfoType: TFoldersInfoType): Boolean;
 {* ����� �������� FolderElement.SetState � ���������� }
//#UC START# *56C87CF25D1A_8460A7DA08F4_var*
//#UC END# *56C87CF25D1A_8460A7DA08F4_var*
begin
//#UC START# *56C87CF25D1A_8460A7DA08F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *56C87CF25D1A_8460A7DA08F4_impl*
end;//Op_FolderElement_SetState.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� AdditionInfo.Show � �������� }
//#UC START# *55F7E176BD8E_4DE9C7A37B72_var*
//#UC END# *55F7E176BD8E_4DE9C7A37B72_var*
begin
//#UC START# *55F7E176BD8E_4DE9C7A37B72_impl*
 !!! Needs to be implemented !!!
//#UC END# *55F7E176BD8E_4DE9C7A37B72_impl*
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� AdditionInfo.Show � ��������� }
//#UC START# *38FB9E5A47DF_4DE9C7A37B72_var*
//#UC END# *38FB9E5A47DF_4DE9C7A37B72_var*
begin
//#UC START# *38FB9E5A47DF_4DE9C7A37B72_impl*
 !!! Needs to be implemented !!!
//#UC END# *38FB9E5A47DF_4DE9C7A37B72_impl*
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� AdditionInfo.Show � ����� }
//#UC START# *DB5CA047C5AF_4DE9C7A37B72_var*
//#UC END# *DB5CA047C5AF_4DE9C7A37B72_var*
begin
//#UC START# *DB5CA047C5AF_4DE9C7A37B72_impl*
 !!! Needs to be implemented !!!
//#UC END# *DB5CA047C5AF_4DE9C7A37B72_impl*
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� AdditionInfo.Show � ���������� }
//#UC START# *D686D955D0E6_4DE9C7A37B72_var*
//#UC END# *D686D955D0E6_4DE9C7A37B72_var*
begin
//#UC START# *D686D955D0E6_4DE9C7A37B72_impl*
 !!! Needs to be implemented !!!
//#UC END# *D686D955D0E6_4DE9C7A37B72_impl*
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� AdditionInfo.Hide � �������� }
//#UC START# *2DA5D1C6549A_4AD57DDE2597_var*
//#UC END# *2DA5D1C6549A_4AD57DDE2597_var*
begin
//#UC START# *2DA5D1C6549A_4AD57DDE2597_impl*
 !!! Needs to be implemented !!!
//#UC END# *2DA5D1C6549A_4AD57DDE2597_impl*
end;//Op_AdditionInfo_Hide.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� AdditionInfo.Hide � ��������� }
//#UC START# *10A98EA9DEEB_4AD57DDE2597_var*
//#UC END# *10A98EA9DEEB_4AD57DDE2597_var*
begin
//#UC START# *10A98EA9DEEB_4AD57DDE2597_impl*
 !!! Needs to be implemented !!!
//#UC END# *10A98EA9DEEB_4AD57DDE2597_impl*
end;//Op_AdditionInfo_Hide.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� AdditionInfo.Hide � ����� }
//#UC START# *F6191137D714_4AD57DDE2597_var*
//#UC END# *F6191137D714_4AD57DDE2597_var*
begin
//#UC START# *F6191137D714_4AD57DDE2597_impl*
 !!! Needs to be implemented !!!
//#UC END# *F6191137D714_4AD57DDE2597_impl*
end;//Op_AdditionInfo_Hide.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� AdditionInfo.Hide � ���������� }
//#UC START# *D24ECC86F34C_4AD57DDE2597_var*
//#UC END# *D24ECC86F34C_4AD57DDE2597_var*
begin
//#UC START# *D24ECC86F34C_4AD57DDE2597_impl*
 !!! Needs to be implemented !!!
//#UC END# *D24ECC86F34C_4AD57DDE2597_impl*
end;//Op_AdditionInfo_Hide.Call

constructor TAdditionInfo_SetCaption_Params.Create(const aCaption: Il3CString);
 {* ����������� TAdditionInfo_SetCaption_Params }
//#UC START# *59CBE764C96F_0587E1EB587C_var*
//#UC END# *59CBE764C96F_0587E1EB587C_var*
begin
//#UC START# *59CBE764C96F_0587E1EB587C_impl*
 !!! Needs to be implemented !!!
//#UC END# *59CBE764C96F_0587E1EB587C_impl*
end;//TAdditionInfo_SetCaption_Params.Create

class function TAdditionInfo_SetCaption_Params.Make(const aCaption: Il3CString): IAdditionInfo_SetCaption_Params;
 {* ������� TAdditionInfo_SetCaption_Params }
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
//#UC START# *D7EE603D5A8E_0587E1EB587Cget_var*
//#UC END# *D7EE603D5A8E_0587E1EB587Cget_var*
begin
//#UC START# *D7EE603D5A8E_0587E1EB587Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D7EE603D5A8E_0587E1EB587Cget_impl*
end;//TAdditionInfo_SetCaption_Params.Get_Caption

procedure TAdditionInfo_SetCaption_Params.ClearFields;
begin
 f_Caption := nil;
 inherited;
end;//TAdditionInfo_SetCaption_Params.ClearFields

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmEntity;
 const aCaption: Il3CString): Boolean;
 {* ����� �������� AdditionInfo.SetCaption � �������� }
//#UC START# *B2D756DC3ABC_03C0D5403D03_var*
//#UC END# *B2D756DC3ABC_03C0D5403D03_var*
begin
//#UC START# *B2D756DC3ABC_03C0D5403D03_impl*
 !!! Needs to be implemented !!!
//#UC END# *B2D756DC3ABC_03C0D5403D03_impl*
end;//Op_AdditionInfo_SetCaption.Call

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmAggregate;
 const aCaption: Il3CString): Boolean;
 {* ����� �������� AdditionInfo.SetCaption � ��������� }
//#UC START# *E31716CAC50C_03C0D5403D03_var*
//#UC END# *E31716CAC50C_03C0D5403D03_var*
begin
//#UC START# *E31716CAC50C_03C0D5403D03_impl*
 !!! Needs to be implemented !!!
//#UC END# *E31716CAC50C_03C0D5403D03_impl*
end;//Op_AdditionInfo_SetCaption.Call

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmEntityForm;
 const aCaption: Il3CString): Boolean;
 {* ����� �������� AdditionInfo.SetCaption � ����� }
//#UC START# *9B48AA40EBFB_03C0D5403D03_var*
//#UC END# *9B48AA40EBFB_03C0D5403D03_var*
begin
//#UC START# *9B48AA40EBFB_03C0D5403D03_impl*
 !!! Needs to be implemented !!!
//#UC END# *9B48AA40EBFB_03C0D5403D03_impl*
end;//Op_AdditionInfo_SetCaption.Call

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmContainer;
 const aCaption: Il3CString): Boolean;
 {* ����� �������� AdditionInfo.SetCaption � ���������� }
//#UC START# *B88CC9B7AD37_03C0D5403D03_var*
//#UC END# *B88CC9B7AD37_03C0D5403D03_var*
begin
//#UC START# *B88CC9B7AD37_03C0D5403D03_impl*
 !!! Needs to be implemented !!!
//#UC END# *B88CC9B7AD37_03C0D5403D03_impl*
end;//Op_AdditionInfo_SetCaption.Call

constructor TFolderElement_GetState_Params.Create;
 {* ����������� TFolderElement_GetState_Params }
//#UC START# *38BF9D8840E7_C440C0292A55_var*
//#UC END# *38BF9D8840E7_C440C0292A55_var*
begin
//#UC START# *38BF9D8840E7_C440C0292A55_impl*
 !!! Needs to be implemented !!!
//#UC END# *38BF9D8840E7_C440C0292A55_impl*
end;//TFolderElement_GetState_Params.Create

class function TFolderElement_GetState_Params.Make: IFolderElement_GetState_Params;
 {* ������� TFolderElement_GetState_Params }
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
//#UC START# *7439B1C82743_C440C0292A55get_var*
//#UC END# *7439B1C82743_C440C0292A55get_var*
begin
//#UC START# *7439B1C82743_C440C0292A55get_impl*
 !!! Needs to be implemented !!!
//#UC END# *7439B1C82743_C440C0292A55get_impl*
end;//TFolderElement_GetState_Params.Get_ResultValue

procedure TFolderElement_GetState_Params.Set_ResultValue(aValue: TFoldersInfoType);
//#UC START# *7439B1C82743_C440C0292A55set_var*
//#UC END# *7439B1C82743_C440C0292A55set_var*
begin
//#UC START# *7439B1C82743_C440C0292A55set_impl*
 !!! Needs to be implemented !!!
//#UC END# *7439B1C82743_C440C0292A55set_impl*
end;//TFolderElement_GetState_Params.Set_ResultValue

class function Op_FolderElement_GetState.Call(const aTarget: IvcmEntity): TFoldersInfoType;
 {* ����� �������� FolderElement.GetState � �������� }
//#UC START# *6A3DFC70FCFF_2D15A5093B2A_var*
//#UC END# *6A3DFC70FCFF_2D15A5093B2A_var*
begin
//#UC START# *6A3DFC70FCFF_2D15A5093B2A_impl*
 !!! Needs to be implemented !!!
//#UC END# *6A3DFC70FCFF_2D15A5093B2A_impl*
end;//Op_FolderElement_GetState.Call

class function Op_FolderElement_GetState.Call(const aTarget: IvcmAggregate): TFoldersInfoType;
 {* ����� �������� FolderElement.GetState � ��������� }
//#UC START# *9A7DBC5F874F_2D15A5093B2A_var*
//#UC END# *9A7DBC5F874F_2D15A5093B2A_var*
begin
//#UC START# *9A7DBC5F874F_2D15A5093B2A_impl*
 !!! Needs to be implemented !!!
//#UC END# *9A7DBC5F874F_2D15A5093B2A_impl*
end;//Op_FolderElement_GetState.Call

class function Op_FolderElement_GetState.Call(const aTarget: IvcmEntityForm): TFoldersInfoType;
 {* ����� �������� FolderElement.GetState � ����� }
//#UC START# *6ABC997D86E8_2D15A5093B2A_var*
//#UC END# *6ABC997D86E8_2D15A5093B2A_var*
begin
//#UC START# *6ABC997D86E8_2D15A5093B2A_impl*
 !!! Needs to be implemented !!!
//#UC END# *6ABC997D86E8_2D15A5093B2A_impl*
end;//Op_FolderElement_GetState.Call

class function Op_FolderElement_GetState.Call(const aTarget: IvcmContainer): TFoldersInfoType;
 {* ����� �������� FolderElement.GetState � ���������� }
//#UC START# *3AD99AEA331B_2D15A5093B2A_var*
//#UC END# *3AD99AEA331B_2D15A5093B2A_var*
begin
//#UC START# *3AD99AEA331B_2D15A5093B2A_impl*
 !!! Needs to be implemented !!!
//#UC END# *3AD99AEA331B_2D15A5093B2A_impl*
end;//Op_FolderElement_GetState.Call

constructor TFolderElement_SetLoadInfo_Params.Create(const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation);
 {* ����������� TFolderElement_SetLoadInfo_Params }
//#UC START# *30E2E356BCC6_12B85D12C6E3_var*
//#UC END# *30E2E356BCC6_12B85D12C6E3_var*
begin
//#UC START# *30E2E356BCC6_12B85D12C6E3_impl*
 !!! Needs to be implemented !!!
//#UC END# *30E2E356BCC6_12B85D12C6E3_impl*
end;//TFolderElement_SetLoadInfo_Params.Create

class function TFolderElement_SetLoadInfo_Params.Make(const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation): IFolderElement_SetLoadInfo_Params;
 {* ������� TFolderElement_SetLoadInfo_Params }
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

function TFolderElement_SetLoadInfo_Params.Get_Data: IUnknown;
//#UC START# *1B0F6AA8BCAB_12B85D12C6E3get_var*
//#UC END# *1B0F6AA8BCAB_12B85D12C6E3get_var*
begin
//#UC START# *1B0F6AA8BCAB_12B85D12C6E3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1B0F6AA8BCAB_12B85D12C6E3get_impl*
end;//TFolderElement_SetLoadInfo_Params.Get_Data

function TFolderElement_SetLoadInfo_Params.Get_nOp: TListLogicOperation;
//#UC START# *2089997ADD8A_12B85D12C6E3get_var*
//#UC END# *2089997ADD8A_12B85D12C6E3get_var*
begin
//#UC START# *2089997ADD8A_12B85D12C6E3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2089997ADD8A_12B85D12C6E3get_impl*
end;//TFolderElement_SetLoadInfo_Params.Get_nOp

function TFolderElement_SetLoadInfo_Params.Get_Form: IvcmEntityForm;
//#UC START# *3BE367CD1558_12B85D12C6E3get_var*
//#UC END# *3BE367CD1558_12B85D12C6E3get_var*
begin
//#UC START# *3BE367CD1558_12B85D12C6E3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3BE367CD1558_12B85D12C6E3get_impl*
end;//TFolderElement_SetLoadInfo_Params.Get_Form

function TFolderElement_SetLoadInfo_Params.Get_Caption: Il3CString;
//#UC START# *AD7D3EF8E3B5_12B85D12C6E3get_var*
//#UC END# *AD7D3EF8E3B5_12B85D12C6E3get_var*
begin
//#UC START# *AD7D3EF8E3B5_12B85D12C6E3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *AD7D3EF8E3B5_12B85D12C6E3get_impl*
end;//TFolderElement_SetLoadInfo_Params.Get_Caption

function TFolderElement_SetLoadInfo_Params.Get_FolderFilterInfo: InsFolderFilterInfo;
//#UC START# *F8D0B846DF51_12B85D12C6E3get_var*
//#UC END# *F8D0B846DF51_12B85D12C6E3get_var*
begin
//#UC START# *F8D0B846DF51_12B85D12C6E3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F8D0B846DF51_12B85D12C6E3get_impl*
end;//TFolderElement_SetLoadInfo_Params.Get_FolderFilterInfo

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
//#UC START# *1B718AD2B4E3_768FA8409CBE_var*
//#UC END# *1B718AD2B4E3_768FA8409CBE_var*
begin
//#UC START# *1B718AD2B4E3_768FA8409CBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *1B718AD2B4E3_768FA8409CBE_impl*
end;//Op_FolderElement_SetLoadInfo.Call

class function Op_FolderElement_SetLoadInfo.Call(const aTarget: IvcmAggregate;
 const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation): Boolean;
 {* ����� �������� FolderElement.SetLoadInfo � ��������� }
//#UC START# *FE7547B63F33_768FA8409CBE_var*
//#UC END# *FE7547B63F33_768FA8409CBE_var*
begin
//#UC START# *FE7547B63F33_768FA8409CBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *FE7547B63F33_768FA8409CBE_impl*
end;//Op_FolderElement_SetLoadInfo.Call

class function Op_FolderElement_SetLoadInfo.Call(const aTarget: IvcmEntityForm;
 const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation): Boolean;
 {* ����� �������� FolderElement.SetLoadInfo � ����� }
//#UC START# *D3E6EBED80C1_768FA8409CBE_var*
//#UC END# *D3E6EBED80C1_768FA8409CBE_var*
begin
//#UC START# *D3E6EBED80C1_768FA8409CBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *D3E6EBED80C1_768FA8409CBE_impl*
end;//Op_FolderElement_SetLoadInfo.Call

class function Op_FolderElement_SetLoadInfo.Call(const aTarget: IvcmContainer;
 const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation): Boolean;
 {* ����� �������� FolderElement.SetLoadInfo � ���������� }
//#UC START# *1A58649DDA59_768FA8409CBE_var*
//#UC END# *1A58649DDA59_768FA8409CBE_var*
begin
//#UC START# *1A58649DDA59_768FA8409CBE_impl*
 !!! Needs to be implemented !!!
//#UC END# *1A58649DDA59_768FA8409CBE_impl*
end;//Op_FolderElement_SetLoadInfo.Call

constructor TFolderElement_SetContent_Params.Create(const aNode: IeeNode;
 aIsNewFolder: Boolean);
 {* ����������� TFolderElement_SetContent_Params }
//#UC START# *3C36BD566F88_16A13C1764B3_var*
//#UC END# *3C36BD566F88_16A13C1764B3_var*
begin
//#UC START# *3C36BD566F88_16A13C1764B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *3C36BD566F88_16A13C1764B3_impl*
end;//TFolderElement_SetContent_Params.Create

class function TFolderElement_SetContent_Params.Make(const aNode: IeeNode;
 aIsNewFolder: Boolean): IFolderElement_SetContent_Params;
 {* ������� TFolderElement_SetContent_Params }
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
//#UC START# *52167F51555A_16A13C1764B3get_var*
//#UC END# *52167F51555A_16A13C1764B3get_var*
begin
//#UC START# *52167F51555A_16A13C1764B3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *52167F51555A_16A13C1764B3get_impl*
end;//TFolderElement_SetContent_Params.Get_Node

function TFolderElement_SetContent_Params.Get_IsNewFolder: Boolean;
//#UC START# *852E52E0330E_16A13C1764B3get_var*
//#UC END# *852E52E0330E_16A13C1764B3get_var*
begin
//#UC START# *852E52E0330E_16A13C1764B3get_impl*
 !!! Needs to be implemented !!!
//#UC END# *852E52E0330E_16A13C1764B3get_impl*
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
//#UC START# *720B08CED59B_66DD0395E5B5_var*
//#UC END# *720B08CED59B_66DD0395E5B5_var*
begin
//#UC START# *720B08CED59B_66DD0395E5B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *720B08CED59B_66DD0395E5B5_impl*
end;//Op_FolderElement_SetContent.Call

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode;
 aIsNewFolder: Boolean = False): Boolean;
 {* ����� �������� FolderElement.SetContent � ��������� }
//#UC START# *A24AC8BE5FEB_66DD0395E5B5_var*
//#UC END# *A24AC8BE5FEB_66DD0395E5B5_var*
begin
//#UC START# *A24AC8BE5FEB_66DD0395E5B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *A24AC8BE5FEB_66DD0395E5B5_impl*
end;//Op_FolderElement_SetContent.Call

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode;
 aIsNewFolder: Boolean = False): Boolean;
 {* ����� �������� FolderElement.SetContent � ����� }
//#UC START# *81FB6D206C2D_66DD0395E5B5_var*
//#UC END# *81FB6D206C2D_66DD0395E5B5_var*
begin
//#UC START# *81FB6D206C2D_66DD0395E5B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *81FB6D206C2D_66DD0395E5B5_impl*
end;//Op_FolderElement_SetContent.Call

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode;
 aIsNewFolder: Boolean = False): Boolean;
 {* ����� �������� FolderElement.SetContent � ���������� }
//#UC START# *70AEA620E741_66DD0395E5B5_var*
//#UC END# *70AEA620E741_66DD0395E5B5_var*
begin
//#UC START# *70AEA620E741_66DD0395E5B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *70AEA620E741_66DD0395E5B5_impl*
end;//Op_FolderElement_SetContent.Call

constructor TFolderElement_SetSaveInfo_Params.Create(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean);
 {* ����������� TFolderElement_SetSaveInfo_Params }
//#UC START# *61E6AEE90741_EE026059D10B_var*
//#UC END# *61E6AEE90741_EE026059D10B_var*
begin
//#UC START# *61E6AEE90741_EE026059D10B_impl*
 !!! Needs to be implemented !!!
//#UC END# *61E6AEE90741_EE026059D10B_impl*
end;//TFolderElement_SetSaveInfo_Params.Create

class function TFolderElement_SetSaveInfo_Params.Make(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): IFolderElement_SetSaveInfo_Params;
 {* ������� TFolderElement_SetSaveInfo_Params }
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

function TFolderElement_SetSaveInfo_Params.Get_SaveAs: Boolean;
//#UC START# *1593A63A4BAD_EE026059D10Bget_var*
//#UC END# *1593A63A4BAD_EE026059D10Bget_var*
begin
//#UC START# *1593A63A4BAD_EE026059D10Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *1593A63A4BAD_EE026059D10Bget_impl*
end;//TFolderElement_SetSaveInfo_Params.Get_SaveAs

function TFolderElement_SetSaveInfo_Params.Get_nEntity: IEntityBase;
//#UC START# *2CF46858F9F4_EE026059D10Bget_var*
//#UC END# *2CF46858F9F4_EE026059D10Bget_var*
begin
//#UC START# *2CF46858F9F4_EE026059D10Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *2CF46858F9F4_EE026059D10Bget_impl*
end;//TFolderElement_SetSaveInfo_Params.Get_nEntity

function TFolderElement_SetSaveInfo_Params.Get_nElementType: TFoldersElementType;
//#UC START# *6E1DFF28CCED_EE026059D10Bget_var*
//#UC END# *6E1DFF28CCED_EE026059D10Bget_var*
begin
//#UC START# *6E1DFF28CCED_EE026059D10Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *6E1DFF28CCED_EE026059D10Bget_impl*
end;//TFolderElement_SetSaveInfo_Params.Get_nElementType

function TFolderElement_SetSaveInfo_Params.Get_FilterInfo: InsFolderFilterInfo;
//#UC START# *D18838DA24D6_EE026059D10Bget_var*
//#UC END# *D18838DA24D6_EE026059D10Bget_var*
begin
//#UC START# *D18838DA24D6_EE026059D10Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D18838DA24D6_EE026059D10Bget_impl*
end;//TFolderElement_SetSaveInfo_Params.Get_FilterInfo

function TFolderElement_SetSaveInfo_Params.Get_Form: IvcmEntityForm;
//#UC START# *E95AF46C81BB_EE026059D10Bget_var*
//#UC END# *E95AF46C81BB_EE026059D10Bget_var*
begin
//#UC START# *E95AF46C81BB_EE026059D10Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *E95AF46C81BB_EE026059D10Bget_impl*
end;//TFolderElement_SetSaveInfo_Params.Get_Form

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
//#UC START# *34D241FD5E77_56FEC4092498_var*
//#UC END# *34D241FD5E77_56FEC4092498_var*
begin
//#UC START# *34D241FD5E77_56FEC4092498_impl*
 !!! Needs to be implemented !!!
//#UC END# *34D241FD5E77_56FEC4092498_impl*
end;//Op_FolderElement_SetSaveInfo.Call

class function Op_FolderElement_SetSaveInfo.Call(const aTarget: IvcmAggregate;
 const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Boolean;
 {* ����� �������� FolderElement.SetSaveInfo � ��������� }
//#UC START# *651201ECE8C7_56FEC4092498_var*
//#UC END# *651201ECE8C7_56FEC4092498_var*
begin
//#UC START# *651201ECE8C7_56FEC4092498_impl*
 !!! Needs to be implemented !!!
//#UC END# *651201ECE8C7_56FEC4092498_impl*
end;//Op_FolderElement_SetSaveInfo.Call

class function Op_FolderElement_SetSaveInfo.Call(const aTarget: IvcmEntityForm;
 const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Boolean;
 {* ����� �������� FolderElement.SetSaveInfo � ����� }
//#UC START# *3A470DA2E3C1_56FEC4092498_var*
//#UC END# *3A470DA2E3C1_56FEC4092498_var*
begin
//#UC START# *3A470DA2E3C1_56FEC4092498_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A470DA2E3C1_56FEC4092498_impl*
end;//Op_FolderElement_SetSaveInfo.Call

class function Op_FolderElement_SetSaveInfo.Call(const aTarget: IvcmContainer;
 const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Boolean;
 {* ����� �������� FolderElement.SetSaveInfo � ���������� }
//#UC START# *05DB14592C55_56FEC4092498_var*
//#UC END# *05DB14592C55_56FEC4092498_var*
begin
//#UC START# *05DB14592C55_56FEC4092498_impl*
 !!! Needs to be implemented !!!
//#UC END# *05DB14592C55_56FEC4092498_impl*
end;//Op_FolderElement_SetSaveInfo.Call

constructor TFolderElement_ResetModificationOnDelete_Params.Create(const aNode: IeeNode);
 {* ����������� TFolderElement_ResetModificationOnDelete_Params }
//#UC START# *DC08B54562D3_EB13D143DD1D_var*
//#UC END# *DC08B54562D3_EB13D143DD1D_var*
begin
//#UC START# *DC08B54562D3_EB13D143DD1D_impl*
 !!! Needs to be implemented !!!
//#UC END# *DC08B54562D3_EB13D143DD1D_impl*
end;//TFolderElement_ResetModificationOnDelete_Params.Create

class function TFolderElement_ResetModificationOnDelete_Params.Make(const aNode: IeeNode): IFolderElement_ResetModificationOnDelete_Params;
 {* ������� TFolderElement_ResetModificationOnDelete_Params }
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
//#UC START# *B1F58683F046_EB13D143DD1Dget_var*
//#UC END# *B1F58683F046_EB13D143DD1Dget_var*
begin
//#UC START# *B1F58683F046_EB13D143DD1Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *B1F58683F046_EB13D143DD1Dget_impl*
end;//TFolderElement_ResetModificationOnDelete_Params.Get_Node

procedure TFolderElement_ResetModificationOnDelete_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolderElement_ResetModificationOnDelete_Params.ClearFields

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode): Boolean;
 {* ����� �������� FolderElement.ResetModificationOnDelete � �������� }
//#UC START# *D8FECE6B63FB_61989DBD0CD5_var*
//#UC END# *D8FECE6B63FB_61989DBD0CD5_var*
begin
//#UC START# *D8FECE6B63FB_61989DBD0CD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *D8FECE6B63FB_61989DBD0CD5_impl*
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode): Boolean;
 {* ����� �������� FolderElement.ResetModificationOnDelete � ��������� }
//#UC START# *093E8E59EE4C_61989DBD0CD5_var*
//#UC END# *093E8E59EE4C_61989DBD0CD5_var*
begin
//#UC START# *093E8E59EE4C_61989DBD0CD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *093E8E59EE4C_61989DBD0CD5_impl*
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode): Boolean;
 {* ����� �������� FolderElement.ResetModificationOnDelete � ����� }
//#UC START# *4FE1F6E73769_61989DBD0CD5_var*
//#UC END# *4FE1F6E73769_61989DBD0CD5_var*
begin
//#UC START# *4FE1F6E73769_61989DBD0CD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE1F6E73769_61989DBD0CD5_impl*
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode): Boolean;
 {* ����� �������� FolderElement.ResetModificationOnDelete � ���������� }
//#UC START# *73F773479367_61989DBD0CD5_var*
//#UC END# *73F773479367_61989DBD0CD5_var*
begin
//#UC START# *73F773479367_61989DBD0CD5_impl*
 !!! Needs to be implemented !!!
//#UC END# *73F773479367_61989DBD0CD5_impl*
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� FolderElement.SetFocus � �������� }
//#UC START# *D50D076F7E62_C71DF5FBC980_var*
//#UC END# *D50D076F7E62_C71DF5FBC980_var*
begin
//#UC START# *D50D076F7E62_C71DF5FBC980_impl*
 !!! Needs to be implemented !!!
//#UC END# *D50D076F7E62_C71DF5FBC980_impl*
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� FolderElement.SetFocus � ��������� }
//#UC START# *054CC75E08B3_C71DF5FBC980_var*
//#UC END# *054CC75E08B3_C71DF5FBC980_var*
begin
//#UC START# *054CC75E08B3_C71DF5FBC980_impl*
 !!! Needs to be implemented !!!
//#UC END# *054CC75E08B3_C71DF5FBC980_impl*
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� FolderElement.SetFocus � ����� }
//#UC START# *4CDAC53F0896_C71DF5FBC980_var*
//#UC END# *4CDAC53F0896_C71DF5FBC980_var*
begin
//#UC START# *4CDAC53F0896_C71DF5FBC980_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CDAC53F0896_C71DF5FBC980_impl*
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� FolderElement.SetFocus � ���������� }
//#UC START# *82CC40025D68_C71DF5FBC980_var*
//#UC END# *82CC40025D68_C71DF5FBC980_var*
begin
//#UC START# *82CC40025D68_C71DF5FBC980_impl*
 !!! Needs to be implemented !!!
//#UC END# *82CC40025D68_C71DF5FBC980_impl*
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� FolderElement.Redraw � �������� }
//#UC START# *7F938E6FD753_081609356CC7_var*
//#UC END# *7F938E6FD753_081609356CC7_var*
begin
//#UC START# *7F938E6FD753_081609356CC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *7F938E6FD753_081609356CC7_impl*
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� FolderElement.Redraw � ��������� }
//#UC START# *62974B5361A4_081609356CC7_var*
//#UC END# *62974B5361A4_081609356CC7_var*
begin
//#UC START# *62974B5361A4_081609356CC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *62974B5361A4_081609356CC7_impl*
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� FolderElement.Redraw � ����� }
//#UC START# *FB6EC45E3784_081609356CC7_var*
//#UC END# *FB6EC45E3784_081609356CC7_var*
begin
//#UC START# *FB6EC45E3784_081609356CC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *FB6EC45E3784_081609356CC7_impl*
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� FolderElement.Redraw � ���������� }
//#UC START# *F5D642CFD404_081609356CC7_var*
//#UC END# *F5D642CFD404_081609356CC7_var*
begin
//#UC START# *F5D642CFD404_081609356CC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *F5D642CFD404_081609356CC7_impl*
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� FolderElement.DisableSecurityPage � �������� }
//#UC START# *122D3E94FF39_2A72F80A1E64_var*
//#UC END# *122D3E94FF39_2A72F80A1E64_var*
begin
//#UC START# *122D3E94FF39_2A72F80A1E64_impl*
 !!! Needs to be implemented !!!
//#UC END# *122D3E94FF39_2A72F80A1E64_impl*
end;//Op_FolderElement_DisableSecurityPage.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� FolderElement.DisableSecurityPage � ��������� }
//#UC START# *426CFE838989_2A72F80A1E64_var*
//#UC END# *426CFE838989_2A72F80A1E64_var*
begin
//#UC START# *426CFE838989_2A72F80A1E64_impl*
 !!! Needs to be implemented !!!
//#UC END# *426CFE838989_2A72F80A1E64_impl*
end;//Op_FolderElement_DisableSecurityPage.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� FolderElement.DisableSecurityPage � ����� }
//#UC START# *7151F71EF7B9_2A72F80A1E64_var*
//#UC END# *7151F71EF7B9_2A72F80A1E64_var*
begin
//#UC START# *7151F71EF7B9_2A72F80A1E64_impl*
 !!! Needs to be implemented !!!
//#UC END# *7151F71EF7B9_2A72F80A1E64_impl*
end;//Op_FolderElement_DisableSecurityPage.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� FolderElement.DisableSecurityPage � ���������� }
//#UC START# *C9A0B29076BD_2A72F80A1E64_var*
//#UC END# *C9A0B29076BD_2A72F80A1E64_var*
begin
//#UC START# *C9A0B29076BD_2A72F80A1E64_impl*
 !!! Needs to be implemented !!!
//#UC END# *C9A0B29076BD_2A72F80A1E64_impl*
end;//Op_FolderElement_DisableSecurityPage.Call

constructor TSavedQuery_SetFilterState_Params.Create(const aNode: INode);
 {* ����������� TSavedQuery_SetFilterState_Params }
//#UC START# *2D937296DC7C_FA8955006735_var*
//#UC END# *2D937296DC7C_FA8955006735_var*
begin
//#UC START# *2D937296DC7C_FA8955006735_impl*
 !!! Needs to be implemented !!!
//#UC END# *2D937296DC7C_FA8955006735_impl*
end;//TSavedQuery_SetFilterState_Params.Create

class function TSavedQuery_SetFilterState_Params.Make(const aNode: INode): ISavedQuery_SetFilterState_Params;
 {* ������� TSavedQuery_SetFilterState_Params }
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
//#UC START# *A0BB51AA5F6F_FA8955006735get_var*
//#UC END# *A0BB51AA5F6F_FA8955006735get_var*
begin
//#UC START# *A0BB51AA5F6F_FA8955006735get_impl*
 !!! Needs to be implemented !!!
//#UC END# *A0BB51AA5F6F_FA8955006735get_impl*
end;//TSavedQuery_SetFilterState_Params.Get_Node

procedure TSavedQuery_SetFilterState_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TSavedQuery_SetFilterState_Params.ClearFields

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmEntity;
 const aNode: INode): Boolean;
 {* ����� �������� SavedQuery.SetFilterState � �������� }
//#UC START# *47CB04838A9D_0A61C1E19991_var*
//#UC END# *47CB04838A9D_0A61C1E19991_var*
begin
//#UC START# *47CB04838A9D_0A61C1E19991_impl*
 !!! Needs to be implemented !!!
//#UC END# *47CB04838A9D_0A61C1E19991_impl*
end;//Op_SavedQuery_SetFilterState.Call

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmAggregate;
 const aNode: INode): Boolean;
 {* ����� �������� SavedQuery.SetFilterState � ��������� }
//#UC START# *780AC47314ED_0A61C1E19991_var*
//#UC END# *780AC47314ED_0A61C1E19991_var*
begin
//#UC START# *780AC47314ED_0A61C1E19991_impl*
 !!! Needs to be implemented !!!
//#UC END# *780AC47314ED_0A61C1E19991_impl*
end;//Op_SavedQuery_SetFilterState.Call

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmEntityForm;
 const aNode: INode): Boolean;
 {* ����� �������� SavedQuery.SetFilterState � ����� }
//#UC START# *964708CC7EDE_0A61C1E19991_var*
//#UC END# *964708CC7EDE_0A61C1E19991_var*
begin
//#UC START# *964708CC7EDE_0A61C1E19991_impl*
 !!! Needs to be implemented !!!
//#UC END# *964708CC7EDE_0A61C1E19991_impl*
end;//Op_SavedQuery_SetFilterState.Call

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmContainer;
 const aNode: INode): Boolean;
 {* ����� �������� SavedQuery.SetFilterState � ���������� }
//#UC START# *F638A70E5AA5_0A61C1E19991_var*
//#UC END# *F638A70E5AA5_0A61C1E19991_var*
begin
//#UC START# *F638A70E5AA5_0A61C1E19991_impl*
 !!! Needs to be implemented !!!
//#UC END# *F638A70E5AA5_0A61C1E19991_impl*
end;//Op_SavedQuery_SetFilterState.Call

constructor TFolders_SetCurrent_Params.Create(const aNode: IeeNode);
 {* ����������� TFolders_SetCurrent_Params }
//#UC START# *2FB5782E964F_99BC45980A57_var*
//#UC END# *2FB5782E964F_99BC45980A57_var*
begin
//#UC START# *2FB5782E964F_99BC45980A57_impl*
 !!! Needs to be implemented !!!
//#UC END# *2FB5782E964F_99BC45980A57_impl*
end;//TFolders_SetCurrent_Params.Create

class function TFolders_SetCurrent_Params.Make(const aNode: IeeNode): IFolders_SetCurrent_Params;
 {* ������� TFolders_SetCurrent_Params }
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
//#UC START# *D7D4D4529242_99BC45980A57get_var*
//#UC END# *D7D4D4529242_99BC45980A57get_var*
begin
//#UC START# *D7D4D4529242_99BC45980A57get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D7D4D4529242_99BC45980A57get_impl*
end;//TFolders_SetCurrent_Params.Get_Node

procedure TFolders_SetCurrent_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TFolders_SetCurrent_Params.ClearFields

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode): Boolean;
 {* ����� �������� Folders.SetCurrent � �������� }
//#UC START# *B4202D76DC5C_D95B4A1E47C0_var*
//#UC END# *B4202D76DC5C_D95B4A1E47C0_var*
begin
//#UC START# *B4202D76DC5C_D95B4A1E47C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *B4202D76DC5C_D95B4A1E47C0_impl*
end;//Op_Folders_SetCurrent.Call

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode): Boolean;
 {* ����� �������� Folders.SetCurrent � ��������� }
//#UC START# *E45FED6566AC_D95B4A1E47C0_var*
//#UC END# *E45FED6566AC_D95B4A1E47C0_var*
begin
//#UC START# *E45FED6566AC_D95B4A1E47C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *E45FED6566AC_D95B4A1E47C0_impl*
end;//Op_Folders_SetCurrent.Call

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode): Boolean;
 {* ����� �������� Folders.SetCurrent � ����� }
//#UC START# *C8574973D158_D95B4A1E47C0_var*
//#UC END# *C8574973D158_D95B4A1E47C0_var*
begin
//#UC START# *C8574973D158_D95B4A1E47C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *C8574973D158_D95B4A1E47C0_impl*
end;//Op_Folders_SetCurrent.Call

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode): Boolean;
 {* ����� �������� Folders.SetCurrent � ���������� }
//#UC START# *D1C14F6C3065_D95B4A1E47C0_var*
//#UC END# *D1C14F6C3065_D95B4A1E47C0_var*
begin
//#UC START# *D1C14F6C3065_D95B4A1E47C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *D1C14F6C3065_D95B4A1E47C0_impl*
end;//Op_Folders_SetCurrent.Call

constructor TFolders_FiltrateByFilterInfo_Params.Create(const anInfo: InsFolderFilterInfo);
 {* ����������� TFolders_FiltrateByFilterInfo_Params }
//#UC START# *DCC0F0C6F2B1_D4F1649A8901_var*
//#UC END# *DCC0F0C6F2B1_D4F1649A8901_var*
begin
//#UC START# *DCC0F0C6F2B1_D4F1649A8901_impl*
 !!! Needs to be implemented !!!
//#UC END# *DCC0F0C6F2B1_D4F1649A8901_impl*
end;//TFolders_FiltrateByFilterInfo_Params.Create

class function TFolders_FiltrateByFilterInfo_Params.Make(const anInfo: InsFolderFilterInfo): IFolders_FiltrateByFilterInfo_Params;
 {* ������� TFolders_FiltrateByFilterInfo_Params }
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
//#UC START# *833EF2E6CBC4_D4F1649A8901get_var*
//#UC END# *833EF2E6CBC4_D4F1649A8901get_var*
begin
//#UC START# *833EF2E6CBC4_D4F1649A8901get_impl*
 !!! Needs to be implemented !!!
//#UC END# *833EF2E6CBC4_D4F1649A8901get_impl*
end;//TFolders_FiltrateByFilterInfo_Params.Get_nInfo

procedure TFolders_FiltrateByFilterInfo_Params.ClearFields;
begin
 f_nInfo := nil;
 inherited;
end;//TFolders_FiltrateByFilterInfo_Params.ClearFields

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmEntity;
 const anInfo: InsFolderFilterInfo): Boolean;
 {* ����� �������� Folders.FiltrateByFilterInfo � �������� }
//#UC START# *D31CA55E3DC3_9D05FC0FA787_var*
//#UC END# *D31CA55E3DC3_9D05FC0FA787_var*
begin
//#UC START# *D31CA55E3DC3_9D05FC0FA787_impl*
 !!! Needs to be implemented !!!
//#UC END# *D31CA55E3DC3_9D05FC0FA787_impl*
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmAggregate;
 const anInfo: InsFolderFilterInfo): Boolean;
 {* ����� �������� Folders.FiltrateByFilterInfo � ��������� }
//#UC START# *035C654CC814_9D05FC0FA787_var*
//#UC END# *035C654CC814_9D05FC0FA787_var*
begin
//#UC START# *035C654CC814_9D05FC0FA787_impl*
 !!! Needs to be implemented !!!
//#UC END# *035C654CC814_9D05FC0FA787_impl*
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmEntityForm;
 const anInfo: InsFolderFilterInfo): Boolean;
 {* ����� �������� Folders.FiltrateByFilterInfo � ����� }
//#UC START# *4F46C048248D_9D05FC0FA787_var*
//#UC END# *4F46C048248D_9D05FC0FA787_var*
begin
//#UC START# *4F46C048248D_9D05FC0FA787_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F46C048248D_9D05FC0FA787_impl*
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmContainer;
 const anInfo: InsFolderFilterInfo): Boolean;
 {* ����� �������� Folders.FiltrateByFilterInfo � ���������� }
//#UC START# *7B52ECFA828D_9D05FC0FA787_var*
//#UC END# *7B52ECFA828D_9D05FC0FA787_var*
begin
//#UC START# *7B52ECFA828D_9D05FC0FA787_impl*
 !!! Needs to be implemented !!!
//#UC END# *7B52ECFA828D_9D05FC0FA787_impl*
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Folders.TryOpenConsultationAnswer � �������� }
//#UC START# *29FE088D18FF_1C2C3E3EFE9C_var*
//#UC END# *29FE088D18FF_1C2C3E3EFE9C_var*
begin
//#UC START# *29FE088D18FF_1C2C3E3EFE9C_impl*
 !!! Needs to be implemented !!!
//#UC END# *29FE088D18FF_1C2C3E3EFE9C_impl*
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Folders.TryOpenConsultationAnswer � ��������� }
//#UC START# *5A3DC87BA34F_1C2C3E3EFE9C_var*
//#UC END# *5A3DC87BA34F_1C2C3E3EFE9C_var*
begin
//#UC START# *5A3DC87BA34F_1C2C3E3EFE9C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5A3DC87BA34F_1C2C3E3EFE9C_impl*
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Folders.TryOpenConsultationAnswer � ����� }
//#UC START# *A7877FE3725D_1C2C3E3EFE9C_var*
//#UC END# *A7877FE3725D_1C2C3E3EFE9C_var*
begin
//#UC START# *A7877FE3725D_1C2C3E3EFE9C_impl*
 !!! Needs to be implemented !!!
//#UC END# *A7877FE3725D_1C2C3E3EFE9C_impl*
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Folders.TryOpenConsultationAnswer � ���������� }
//#UC START# *6B5EF1ACDD9C_1C2C3E3EFE9C_var*
//#UC END# *6B5EF1ACDD9C_1C2C3E3EFE9C_var*
begin
//#UC START# *6B5EF1ACDD9C_1C2C3E3EFE9C_impl*
 !!! Needs to be implemented !!!
//#UC END# *6B5EF1ACDD9C_1C2C3E3EFE9C_impl*
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Folders.OpenMyConsultations � �������� }
//#UC START# *F80620EB07C2_11609ACA92B8_var*
//#UC END# *F80620EB07C2_11609ACA92B8_var*
begin
//#UC START# *F80620EB07C2_11609ACA92B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *F80620EB07C2_11609ACA92B8_impl*
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Folders.OpenMyConsultations � ��������� }
//#UC START# *DB09DDCE9213_11609ACA92B8_var*
//#UC END# *DB09DDCE9213_11609ACA92B8_var*
begin
//#UC START# *DB09DDCE9213_11609ACA92B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *DB09DDCE9213_11609ACA92B8_impl*
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Folders.OpenMyConsultations � ����� }
//#UC START# *D952635AEAE2_11609ACA92B8_var*
//#UC END# *D952635AEAE2_11609ACA92B8_var*
begin
//#UC START# *D952635AEAE2_11609ACA92B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *D952635AEAE2_11609ACA92B8_impl*
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Folders.OpenMyConsultations � ���������� }
//#UC START# *FBC5D631EA32_11609ACA92B8_var*
//#UC END# *FBC5D631EA32_11609ACA92B8_var*
begin
//#UC START# *FBC5D631EA32_11609ACA92B8_impl*
 !!! Needs to be implemented !!!
//#UC END# *FBC5D631EA32_11609ACA92B8_impl*
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Folders.SetInfoContent � �������� }
//#UC START# *BF391CD23435_64827983780D_var*
//#UC END# *BF391CD23435_64827983780D_var*
begin
//#UC START# *BF391CD23435_64827983780D_impl*
 !!! Needs to be implemented !!!
//#UC END# *BF391CD23435_64827983780D_impl*
end;//Op_Folders_SetInfoContent.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Folders.SetInfoContent � ��������� }
//#UC START# *EF78DCC1BE85_64827983780D_var*
//#UC END# *EF78DCC1BE85_64827983780D_var*
begin
//#UC START# *EF78DCC1BE85_64827983780D_impl*
 !!! Needs to be implemented !!!
//#UC END# *EF78DCC1BE85_64827983780D_impl*
end;//Op_Folders_SetInfoContent.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Folders.SetInfoContent � ����� }
//#UC START# *91149E1592A4_64827983780D_var*
//#UC END# *91149E1592A4_64827983780D_var*
begin
//#UC START# *91149E1592A4_64827983780D_impl*
 !!! Needs to be implemented !!!
//#UC END# *91149E1592A4_64827983780D_impl*
end;//Op_Folders_SetInfoContent.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Folders.SetInfoContent � ���������� }
//#UC START# *48BC10597BA0_64827983780D_var*
//#UC END# *48BC10597BA0_64827983780D_var*
begin
//#UC START# *48BC10597BA0_64827983780D_impl*
 !!! Needs to be implemented !!!
//#UC END# *48BC10597BA0_64827983780D_impl*
end;//Op_Folders_SetInfoContent.Call

constructor TUsersRights_UpdateRights_Params.Create(const aNode: IeeNode);
 {* ����������� TUsersRights_UpdateRights_Params }
//#UC START# *E7A8F6F74416_0C6412AD73B4_var*
//#UC END# *E7A8F6F74416_0C6412AD73B4_var*
begin
//#UC START# *E7A8F6F74416_0C6412AD73B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *E7A8F6F74416_0C6412AD73B4_impl*
end;//TUsersRights_UpdateRights_Params.Create

class function TUsersRights_UpdateRights_Params.Make(const aNode: IeeNode): IUsersRights_UpdateRights_Params;
 {* ������� TUsersRights_UpdateRights_Params }
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
//#UC START# *E1A5363D3696_0C6412AD73B4get_var*
//#UC END# *E1A5363D3696_0C6412AD73B4get_var*
begin
//#UC START# *E1A5363D3696_0C6412AD73B4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *E1A5363D3696_0C6412AD73B4get_impl*
end;//TUsersRights_UpdateRights_Params.Get_Node

procedure TUsersRights_UpdateRights_Params.ClearFields;
begin
 f_Node := nil;
 inherited;
end;//TUsersRights_UpdateRights_Params.ClearFields

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmEntity;
 const aNode: IeeNode): Boolean;
 {* ����� �������� UsersRights.UpdateRights � �������� }
//#UC START# *12280FA4D109_25ED52D30754_var*
//#UC END# *12280FA4D109_25ED52D30754_var*
begin
//#UC START# *12280FA4D109_25ED52D30754_impl*
 !!! Needs to be implemented !!!
//#UC END# *12280FA4D109_25ED52D30754_impl*
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmAggregate;
 const aNode: IeeNode): Boolean;
 {* ����� �������� UsersRights.UpdateRights � ��������� }
//#UC START# *4267CF935B59_25ED52D30754_var*
//#UC END# *4267CF935B59_25ED52D30754_var*
begin
//#UC START# *4267CF935B59_25ED52D30754_impl*
 !!! Needs to be implemented !!!
//#UC END# *4267CF935B59_25ED52D30754_impl*
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmEntityForm;
 const aNode: IeeNode): Boolean;
 {* ����� �������� UsersRights.UpdateRights � ����� }
//#UC START# *745F73ABA204_25ED52D30754_var*
//#UC END# *745F73ABA204_25ED52D30754_var*
begin
//#UC START# *745F73ABA204_25ED52D30754_impl*
 !!! Needs to be implemented !!!
//#UC END# *745F73ABA204_25ED52D30754_impl*
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmContainer;
 const aNode: IeeNode): Boolean;
 {* ����� �������� UsersRights.UpdateRights � ���������� }
//#UC START# *D8B71898CB82_25ED52D30754_var*
//#UC END# *D8B71898CB82_25ED52D30754_var*
begin
//#UC START# *D8B71898CB82_25ED52D30754_impl*
 !!! Needs to be implemented !!!
//#UC END# *D8B71898CB82_25ED52D30754_impl*
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� UsersRights.FolderShareChanged � �������� }
//#UC START# *4281D1BFBC2D_D11286D9235A_var*
//#UC END# *4281D1BFBC2D_D11286D9235A_var*
begin
//#UC START# *4281D1BFBC2D_D11286D9235A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4281D1BFBC2D_D11286D9235A_impl*
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� UsersRights.FolderShareChanged � ��������� }
//#UC START# *72C191AE467D_D11286D9235A_var*
//#UC END# *72C191AE467D_D11286D9235A_var*
begin
//#UC START# *72C191AE467D_D11286D9235A_impl*
 !!! Needs to be implemented !!!
//#UC END# *72C191AE467D_D11286D9235A_impl*
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� UsersRights.FolderShareChanged � ����� }
//#UC START# *19419355DE78_D11286D9235A_var*
//#UC END# *19419355DE78_D11286D9235A_var*
begin
//#UC START# *19419355DE78_D11286D9235A_impl*
 !!! Needs to be implemented !!!
//#UC END# *19419355DE78_D11286D9235A_impl*
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� UsersRights.FolderShareChanged � ���������� }
//#UC START# *6D426F53A3DC_D11286D9235A_var*
//#UC END# *6D426F53A3DC_D11286D9235A_var*
begin
//#UC START# *6D426F53A3DC_D11286D9235A_impl*
 !!! Needs to be implemented !!!
//#UC END# *6D426F53A3DC_D11286D9235A_impl*
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmEntity): Boolean;
 {* ����� �������� Result.ExternalOk � �������� }
//#UC START# *1B1DC6F5B6CB_1CD1E2637C47_var*
//#UC END# *1B1DC6F5B6CB_1CD1E2637C47_var*
begin
//#UC START# *1B1DC6F5B6CB_1CD1E2637C47_impl*
 !!! Needs to be implemented !!!
//#UC END# *1B1DC6F5B6CB_1CD1E2637C47_impl*
end;//Op_Result_ExternalOk.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmAggregate): Boolean;
 {* ����� �������� Result.ExternalOk � ��������� }
//#UC START# *4B5D86E5411B_1CD1E2637C47_var*
//#UC END# *4B5D86E5411B_1CD1E2637C47_var*
begin
//#UC START# *4B5D86E5411B_1CD1E2637C47_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B5D86E5411B_1CD1E2637C47_impl*
end;//Op_Result_ExternalOk.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmEntityForm): Boolean;
 {* ����� �������� Result.ExternalOk � ����� }
//#UC START# *1161384C54AA_1CD1E2637C47_var*
//#UC END# *1161384C54AA_1CD1E2637C47_var*
begin
//#UC START# *1161384C54AA_1CD1E2637C47_impl*
 !!! Needs to be implemented !!!
//#UC END# *1161384C54AA_1CD1E2637C47_impl*
end;//Op_Result_ExternalOk.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmContainer): Boolean;
 {* ����� �������� Result.ExternalOk � ���������� }
//#UC START# *A5A14576FE89_1CD1E2637C47_var*
//#UC END# *A5A14576FE89_1CD1E2637C47_var*
begin
//#UC START# *A5A14576FE89_1CD1E2637C47_impl*
 !!! Needs to be implemented !!!
//#UC END# *A5A14576FE89_1CD1E2637C47_impl*
end;//Op_Result_ExternalOk.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
