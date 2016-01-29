unit Folders_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders_Strange_Controls.pas"
// Начат: 27.08.2009 19:40
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Основные прецеденты::Folders::View::Strange
//
// Странное
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaseTypesUnit,
  BaseTreeSupportUnit,
  FoldersUnit,
  FiltersUnit,
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  eeInterfaces,
  FoldersDomainInterfaces,
  l3CProtoObject
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  nsTypes,
  vcmExternalInterfaces {a}
  ;

(* AdditionInfo = operations
   ['{33646698-40ED-4932-9144-05B751479227}']
   query Close(aModalResult: Integer = mrCancel);
 end;//AdditionInfo*)

(* FolderElement = operations
  {* Элемент папок }
   ['{E6A52074-1016-4183-BE84-1976DA408F0A}']
   query InternalEditByFoldersNode(const aNode: IFoldersNode;
    aInternalCall: Boolean = true);
     {* Редактирование элемента }
   query InternalDelete(const aNode: IFoldersNode;
    aAsk: Boolean = true): TnsDeleteResult;
     {* Удаляет элемент папок }
   query InternalEdit(const aNode: IeeNode;
    aInternalCall: Boolean = true);
   query DisableFilter;
 end;//FolderElement*)

(* FolderElement = operations
   ['{976C0721-9399-4038-AC6B-F36DCC84159F}']
   query SetState(aInfoType: TFoldersInfoType);
 end;//FolderElement*)

(* AdditionInfo = operations(AdditionInfo)
   ['{98A59B19-4E4F-4E87-BA17-F940D02D3030}']
   query Show;
   query Hide;
   query SetCaption(const aCaption: Il3CString);
 end;//AdditionInfo*)

(* FolderElement = operations(FolderElement)
  {* Элемент папок }
   ['{F0B67A82-6858-4EE6-B12A-77BE2102352A}']
   query GetState: TFoldersInfoType;
     {* Возвращает статус элемента }
   query SetLoadInfo(const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation);
     {* Устанавливает параметры элемента }
   query SetContent(const aNode: IeeNode;
    aIsNewFolder: Boolean = false);
     {* SetContent }
   query SetSaveInfo(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean);
   query ResetModificationOnDelete(const aNode: IeeNode);
   query SetFocus;
   query Redraw;
   query DisableSecurityPage;
 end;//FolderElement*)

(* SavedQuery = operations
   ['{94F4B677-F984-44B4-A4E9-9C7C50E99877}']
   query SetFilterState(const aNode: INode);
 end;//SavedQuery*)

(* Folders = operations
   ['{B17931EF-CC49-4AB7-9C6B-F43F5D7095C3}']
   query SetCurrent(const aNode: IeeNode);
   query FiltrateByFilterInfo(const anInfo: InsFolderFilterInfo);
   query TryOpenConsultationAnswer;
   query OpenMyConsultations;
   query SetInfoContent;
 end;//Folders*)

(* UsersRights = operations
   ['{A133E415-7934-4456-88CB-8D64C14E0F59}']
   query UpdateRights(const aNode: IeeNode);
   query FolderShareChanged;
 end;//UsersRights*)

(* Result = operations
   ['{5F6854EB-01E4-4E58-8BAF-258D69196EA1}']
   query ExternalOk;
 end;//Result*)

(* Folders = operations
   ['{AEB25031-C5BD-4B9A-9D40-A1AF1298F239}']
   operation Filtrate;
 end;//Folders*)

(* Folder = operations
   ['{4A19002A-2D90-496B-AC12-3A94B7AEC05D}']
   operation New;
   operation AddToControl;
   operation DelFromControl;
   operation SetShare;
   operation ExportToXML;
   operation ImportFromXML;
 end;//Folder*)

(* FolderElement = operations
   ['{07EF4405-D497-441D-96EF-9F8345558F92}']
   operation Edit;
   operation EditExt;
   operation Open;
   operation OpenNewWindow;
   operation ControlStatus;
   operation ExportForIntegration;
 end;//FolderElement*)

(* SavedQuery = operations
   ['{71CDF6D4-A9C0-443F-B635-EFA5E28CF131}']
   operation CreateFilter;
     {* Создать фильтр... }
 end;//SavedQuery*)

(* Consultation = operations
   ['{92BD79F1-1ACC-48AE-B6B4-1D42FB914F07}']
   operation Open;
   operation GiveMark;
   operation ShowConsultationInfo;
   operation ImportConsultation;
 end;//Consultation*)

type
 IAdditionInfo_Close_Params = interface(IUnknown)
  {* Параметры для операции AdditionInfo.Close }
   ['{9226E430-0264-43B5-AC2A-67B7CB33BA48}']
   function Get_ModalResult: Integer;
   property ModalResult: Integer
     read Get_ModalResult;
     {* undefined }
 end;//IAdditionInfo_Close_Params

 Op_AdditionInfo_Close = class
  {* Класс для вызова операции AdditionInfo.Close }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aModalResult: Integer = mrCancel): Boolean; overload; 
     {* Вызов операции AdditionInfo.Close у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aModalResult: Integer = mrCancel): Boolean; overload; 
     {* Вызов операции AdditionInfo.Close у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aModalResult: Integer = mrCancel): Boolean; overload; 
     {* Вызов операции AdditionInfo.Close у формы }
   class function Call(const aTarget: IvcmContainer;
    aModalResult: Integer = mrCancel): Boolean; overload; 
     {* Вызов операции AdditionInfo.Close у контейнера }
 end;//Op_AdditionInfo_Close

 IFolderElement_InternalEditByFoldersNode_Params = interface(IUnknown)
  {* Параметры для операции FolderElement.InternalEditByFoldersNode }
   ['{6144FDBB-9D7F-4688-931E-DF84D15322F0}']
   function Get_Node: IFoldersNode;
   function Get_InternalCall: Boolean;
   property Node: IFoldersNode
     read Get_Node;
     {* undefined }
   property InternalCall: Boolean
     read Get_InternalCall;
     {* undefined }
 end;//IFolderElement_InternalEditByFoldersNode_Params

 Op_FolderElement_InternalEditByFoldersNode = class
  {* Класс для вызова операции FolderElement.InternalEditByFoldersNode }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = true): Boolean; overload; 
     {* Вызов операции FolderElement.InternalEditByFoldersNode у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = true): Boolean; overload; 
     {* Вызов операции FolderElement.InternalEditByFoldersNode у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = true): Boolean; overload; 
     {* Вызов операции FolderElement.InternalEditByFoldersNode у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode;
    aInternalCall: Boolean = true): Boolean; overload; 
     {* Вызов операции FolderElement.InternalEditByFoldersNode у контейнера }
 end;//Op_FolderElement_InternalEditByFoldersNode

 IFolderElement_InternalDelete_Params = interface(IUnknown)
  {* Параметры для операции FolderElement.InternalDelete }
   ['{3C0D7134-4902-43E6-8106-B763BD833E87}']
   function Get_Node: IFoldersNode;
   function Get_Ask: Boolean;
   function Get_ResultValue: TnsDeleteResult;
   procedure Set_ResultValue(aValue: TnsDeleteResult);
   property Node: IFoldersNode
     read Get_Node;
     {* undefined }
   property Ask: Boolean
     read Get_Ask;
     {* undefined }
   property ResultValue: TnsDeleteResult
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IFolderElement_InternalDelete_Params

 Op_FolderElement_InternalDelete = class
  {* Класс для вызова операции FolderElement.InternalDelete }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aNode: IFoldersNode;
    aAsk: Boolean = true): TnsDeleteResult; overload; 
     {* Вызов операции FolderElement.InternalDelete у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IFoldersNode;
    aAsk: Boolean = true): TnsDeleteResult; overload; 
     {* Вызов операции FolderElement.InternalDelete у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IFoldersNode;
    aAsk: Boolean = true): TnsDeleteResult; overload; 
     {* Вызов операции FolderElement.InternalDelete у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IFoldersNode;
    aAsk: Boolean = true): TnsDeleteResult; overload; 
     {* Вызов операции FolderElement.InternalDelete у контейнера }
 end;//Op_FolderElement_InternalDelete

 IFolderElement_InternalEdit_Params = interface(IUnknown)
  {* Параметры для операции FolderElement.InternalEdit }
   ['{72692263-6D12-46A0-8B9A-84724B440086}']
   function Get_Node: IeeNode;
   function Get_InternalCall: Boolean;
   property Node: IeeNode
     read Get_Node;
     {* undefined }
   property InternalCall: Boolean
     read Get_InternalCall;
     {* undefined }
 end;//IFolderElement_InternalEdit_Params

 Op_FolderElement_InternalEdit = class
  {* Класс для вызова операции FolderElement.InternalEdit }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode;
    aInternalCall: Boolean = true): Boolean; overload; 
     {* Вызов операции FolderElement.InternalEdit у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode;
    aInternalCall: Boolean = true): Boolean; overload; 
     {* Вызов операции FolderElement.InternalEdit у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode;
    aInternalCall: Boolean = true): Boolean; overload; 
     {* Вызов операции FolderElement.InternalEdit у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode;
    aInternalCall: Boolean = true): Boolean; overload; 
     {* Вызов операции FolderElement.InternalEdit у контейнера }
 end;//Op_FolderElement_InternalEdit

 Op_FolderElement_DisableFilter = class
  {* Класс для вызова операции FolderElement.DisableFilter }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции FolderElement.DisableFilter у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции FolderElement.DisableFilter у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции FolderElement.DisableFilter у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции FolderElement.DisableFilter у контейнера }
 end;//Op_FolderElement_DisableFilter

 IFolderElement_SetState_Params = interface(IUnknown)
  {* Параметры для операции FolderElement.SetState }
   ['{BB99FD2E-C261-4D39-A1F6-2CBEC10A14EF}']
   function Get_InfoType: TFoldersInfoType;
   property InfoType: TFoldersInfoType
     read Get_InfoType;
     {* undefined }
 end;//IFolderElement_SetState_Params

 Op_FolderElement_SetState = class
  {* Класс для вызова операции FolderElement.SetState }
 public
 // public methods
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

 Op_AdditionInfo_Show = class
  {* Класс для вызова операции AdditionInfo.Show }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции AdditionInfo.Show у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции AdditionInfo.Show у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции AdditionInfo.Show у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции AdditionInfo.Show у контейнера }
 end;//Op_AdditionInfo_Show

 Op_AdditionInfo_Hide = class
  {* Класс для вызова операции AdditionInfo.Hide }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции AdditionInfo.Hide у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции AdditionInfo.Hide у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции AdditionInfo.Hide у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции AdditionInfo.Hide у контейнера }
 end;//Op_AdditionInfo_Hide

 IAdditionInfo_SetCaption_Params = interface(IUnknown)
  {* Параметры для операции AdditionInfo.SetCaption }
   ['{562262E6-D6D7-4895-A2E5-200EC677B72B}']
   function Get_Caption: Il3CString;
   property Caption: Il3CString
     read Get_Caption;
     {* undefined }
 end;//IAdditionInfo_SetCaption_Params

 Op_AdditionInfo_SetCaption = class
  {* Класс для вызова операции AdditionInfo.SetCaption }
 public
 // public methods
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

 IFolderElement_GetState_Params = interface(IUnknown)
  {* Параметры для операции FolderElement.GetState }
   ['{5B0752CC-2818-4C0A-9474-FD2BEF3C8BCC}']
   function Get_ResultValue: TFoldersInfoType;
   procedure Set_ResultValue(aValue: TFoldersInfoType);
   property ResultValue: TFoldersInfoType
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IFolderElement_GetState_Params

 Op_FolderElement_GetState = class
  {* Класс для вызова операции FolderElement.GetState }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): TFoldersInfoType; overload; 
     {* Вызов операции FolderElement.GetState у сущности }
   class function Call(const aTarget: IvcmAggregate): TFoldersInfoType; overload; 
     {* Вызов операции FolderElement.GetState у агрегации }
   class function Call(const aTarget: IvcmEntityForm): TFoldersInfoType; overload; 
     {* Вызов операции FolderElement.GetState у формы }
   class function Call(const aTarget: IvcmContainer): TFoldersInfoType; overload; 
     {* Вызов операции FolderElement.GetState у контейнера }
 end;//Op_FolderElement_GetState

 IFolderElement_SetLoadInfo_Params = interface(IUnknown)
  {* Параметры для операции FolderElement.SetLoadInfo }
   ['{4EB5D256-A884-4CB6-AF26-748E60362EA7}']
   function Get_Form: IvcmEntityForm;
   function Get_FolderFilterInfo: InsFolderFilterInfo;
   function Get_Caption: Il3CString;
   function Get_Data: IUnknown;
   function Get_NOp: TListLogicOperation;
   property Form: IvcmEntityForm
     read Get_Form;
     {* undefined }
   property FolderFilterInfo: InsFolderFilterInfo
     read Get_FolderFilterInfo;
     {* undefined }
   property Caption: Il3CString
     read Get_Caption;
     {* undefined }
   property Data: IUnknown
     read Get_Data;
     {* undefined }
   property nOp: TListLogicOperation
     read Get_NOp;
     {* undefined }
 end;//IFolderElement_SetLoadInfo_Params

 Op_FolderElement_SetLoadInfo = class
  {* Класс для вызова операции FolderElement.SetLoadInfo }
 public
 // public methods
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

 IFolderElement_SetContent_Params = interface(IUnknown)
  {* Параметры для операции FolderElement.SetContent }
   ['{576C40FA-14A7-4273-8161-EC48C48D019C}']
   function Get_Node: IeeNode;
   function Get_IsNewFolder: Boolean;
   property Node: IeeNode
     read Get_Node;
     {* undefined }
   property IsNewFolder: Boolean
     read Get_IsNewFolder;
     {* undefined }
 end;//IFolderElement_SetContent_Params

 Op_FolderElement_SetContent = class
  {* Класс для вызова операции FolderElement.SetContent }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = false): Boolean; overload; 
     {* Вызов операции FolderElement.SetContent у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = false): Boolean; overload; 
     {* Вызов операции FolderElement.SetContent у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = false): Boolean; overload; 
     {* Вызов операции FolderElement.SetContent у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: IeeNode;
    aIsNewFolder: Boolean = false): Boolean; overload; 
     {* Вызов операции FolderElement.SetContent у контейнера }
 end;//Op_FolderElement_SetContent

 IFolderElement_SetSaveInfo_Params = interface(IUnknown)
  {* Параметры для операции FolderElement.SetSaveInfo }
   ['{68083266-8E03-47D6-BA1C-588398BD2B3E}']
   function Get_Form: IvcmEntityForm;
   function Get_FilterInfo: InsFolderFilterInfo;
   function Get_NElementType: TFoldersElementType;
   function Get_NEntity: IEntityBase;
   function Get_SaveAs: Boolean;
   property Form: IvcmEntityForm
     read Get_Form;
     {* undefined }
   property FilterInfo: InsFolderFilterInfo
     read Get_FilterInfo;
     {* undefined }
   property nElementType: TFoldersElementType
     read Get_NElementType;
     {* undefined }
   property nEntity: IEntityBase
     read Get_NEntity;
     {* undefined }
   property SaveAs: Boolean
     read Get_SaveAs;
     {* undefined }
 end;//IFolderElement_SetSaveInfo_Params

 Op_FolderElement_SetSaveInfo = class
  {* Класс для вызова операции FolderElement.SetSaveInfo }
 public
 // public methods
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

 IFolderElement_ResetModificationOnDelete_Params = interface(IUnknown)
  {* Параметры для операции FolderElement.ResetModificationOnDelete }
   ['{4BEF66FF-5C40-49B8-A1CE-7DF6D72FDF30}']
   function Get_Node: IeeNode;
   property Node: IeeNode
     read Get_Node;
     {* undefined }
 end;//IFolderElement_ResetModificationOnDelete_Params

 Op_FolderElement_ResetModificationOnDelete = class
  {* Класс для вызова операции FolderElement.ResetModificationOnDelete }
 public
 // public methods
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

 Op_FolderElement_SetFocus = class
  {* Класс для вызова операции FolderElement.SetFocus }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции FolderElement.SetFocus у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции FolderElement.SetFocus у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции FolderElement.SetFocus у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции FolderElement.SetFocus у контейнера }
 end;//Op_FolderElement_SetFocus

 Op_FolderElement_Redraw = class
  {* Класс для вызова операции FolderElement.Redraw }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции FolderElement.Redraw у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции FolderElement.Redraw у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции FolderElement.Redraw у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции FolderElement.Redraw у контейнера }
 end;//Op_FolderElement_Redraw

 Op_FolderElement_DisableSecurityPage = class
  {* Класс для вызова операции FolderElement.DisableSecurityPage }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции FolderElement.DisableSecurityPage у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции FolderElement.DisableSecurityPage у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции FolderElement.DisableSecurityPage у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции FolderElement.DisableSecurityPage у контейнера }
 end;//Op_FolderElement_DisableSecurityPage

 ISavedQuery_SetFilterState_Params = interface(IUnknown)
  {* Параметры для операции SavedQuery.SetFilterState }
   ['{91AE5E97-316A-4517-9270-5309FEC7089B}']
   function Get_Node: INode;
   property Node: INode
     read Get_Node;
     {* undefined }
 end;//ISavedQuery_SetFilterState_Params

 Op_SavedQuery_SetFilterState = class
  {* Класс для вызова операции SavedQuery.SetFilterState }
 public
 // public methods
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

 IFolders_SetCurrent_Params = interface(IUnknown)
  {* Параметры для операции Folders.SetCurrent }
   ['{578A7FA9-B757-4092-9FCF-34375B8C8127}']
   function Get_Node: IeeNode;
   property Node: IeeNode
     read Get_Node;
     {* undefined }
 end;//IFolders_SetCurrent_Params

 Op_Folders_SetCurrent = class
  {* Класс для вызова операции Folders.SetCurrent }
 public
 // public methods
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

 IFolders_FiltrateByFilterInfo_Params = interface(IUnknown)
  {* Параметры для операции Folders.FiltrateByFilterInfo }
   ['{32257A40-C1F2-41EA-B97F-6A410F4AD198}']
   function Get_NInfo: InsFolderFilterInfo;
   property nInfo: InsFolderFilterInfo
     read Get_NInfo;
     {* undefined }
 end;//IFolders_FiltrateByFilterInfo_Params

 Op_Folders_FiltrateByFilterInfo = class
  {* Класс для вызова операции Folders.FiltrateByFilterInfo }
 public
 // public methods
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

 Op_Folders_TryOpenConsultationAnswer = class
  {* Класс для вызова операции Folders.TryOpenConsultationAnswer }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Folders.TryOpenConsultationAnswer у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Folders.TryOpenConsultationAnswer у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Folders.TryOpenConsultationAnswer у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Folders.TryOpenConsultationAnswer у контейнера }
 end;//Op_Folders_TryOpenConsultationAnswer

 Op_Folders_OpenMyConsultations = class
  {* Класс для вызова операции Folders.OpenMyConsultations }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Folders.OpenMyConsultations у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Folders.OpenMyConsultations у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Folders.OpenMyConsultations у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Folders.OpenMyConsultations у контейнера }
 end;//Op_Folders_OpenMyConsultations

 Op_Folders_SetInfoContent = class
  {* Класс для вызова операции Folders.SetInfoContent }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Folders.SetInfoContent у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Folders.SetInfoContent у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Folders.SetInfoContent у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Folders.SetInfoContent у контейнера }
 end;//Op_Folders_SetInfoContent

 IUsersRights_UpdateRights_Params = interface(IUnknown)
  {* Параметры для операции UsersRights.UpdateRights }
   ['{6B09258D-5632-4473-B4F3-2953E11E33F8}']
   function Get_Node: IeeNode;
   property Node: IeeNode
     read Get_Node;
     {* undefined }
 end;//IUsersRights_UpdateRights_Params

 Op_UsersRights_UpdateRights = class
  {* Класс для вызова операции UsersRights.UpdateRights }
 public
 // public methods
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

 Op_UsersRights_FolderShareChanged = class
  {* Класс для вызова операции UsersRights.FolderShareChanged }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции UsersRights.FolderShareChanged у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции UsersRights.FolderShareChanged у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции UsersRights.FolderShareChanged у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции UsersRights.FolderShareChanged у контейнера }
 end;//Op_UsersRights_FolderShareChanged

 Op_Result_ExternalOk = class
  {* Класс для вызова операции Result.ExternalOk }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Result.ExternalOk у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Result.ExternalOk у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Result.ExternalOk у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Result.ExternalOk у контейнера }
 end;//Op_Result_ExternalOk
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TAdditionInfo_Close_Params = class(Tl3CProtoObject, IAdditionInfo_Close_Params)
  {* Реализация IAdditionInfo_Close_Params }
 private
 // private fields
   f_ModalResult : Integer;
 protected
 // realized methods
   function Get_ModalResult: Integer;
 public
 // public methods
   constructor Create(aModalResult: Integer); reintroduce;
     {* Конструктор TAdditionInfo_Close_Params }
   class function Make(aModalResult: Integer): IAdditionInfo_Close_Params; reintroduce;
     {* Фабрика TAdditionInfo_Close_Params }
 end;//TAdditionInfo_Close_Params

// start class TAdditionInfo_Close_Params

constructor TAdditionInfo_Close_Params.Create(aModalResult: Integer);
 {-}
begin
 inherited Create;
 f_ModalResult := aModalResult;
end;//TAdditionInfo_Close_Params.Create

class function TAdditionInfo_Close_Params.Make(aModalResult: Integer): IAdditionInfo_Close_Params;
var
 l_Inst : TAdditionInfo_Close_Params;
begin
 l_Inst := Create(aModalResult);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TAdditionInfo_Close_Params.Get_ModalResult: Integer;
 {-}
begin
 Result := f_ModalResult;
end;//TAdditionInfo_Close_Params.Get_ModalResult
// start class Op_AdditionInfo_Close

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmEntity;
  aModalResult: Integer = mrCancel): Boolean;
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
  aModalResult: Integer = mrCancel): Boolean;
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
  aModalResult: Integer = mrCancel): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aModalResult);
end;//Op_AdditionInfo_Close.Call

class function Op_AdditionInfo_Close.Call(const aTarget: IvcmContainer;
  aModalResult: Integer = mrCancel): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aModalResult);
end;//Op_AdditionInfo_Close.Call

type
 TFolderElement_InternalEditByFoldersNode_Params = class(Tl3CProtoObject, IFolderElement_InternalEditByFoldersNode_Params)
  {* Реализация IFolderElement_InternalEditByFoldersNode_Params }
 private
 // private fields
   f_Node : IFoldersNode;
   f_InternalCall : Boolean;
 protected
 // realized methods
   function Get_InternalCall: Boolean;
   function Get_Node: IFoldersNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IFoldersNode;
    aInternalCall: Boolean); reintroduce;
     {* Конструктор TFolderElement_InternalEditByFoldersNode_Params }
   class function Make(const aNode: IFoldersNode;
    aInternalCall: Boolean): IFolderElement_InternalEditByFoldersNode_Params; reintroduce;
     {* Фабрика TFolderElement_InternalEditByFoldersNode_Params }
 end;//TFolderElement_InternalEditByFoldersNode_Params

// start class TFolderElement_InternalEditByFoldersNode_Params

constructor TFolderElement_InternalEditByFoldersNode_Params.Create(const aNode: IFoldersNode;
  aInternalCall: Boolean);
 {-}
begin
 inherited Create;
 f_Node := aNode;
 f_InternalCall := aInternalCall;
end;//TFolderElement_InternalEditByFoldersNode_Params.Create

class function TFolderElement_InternalEditByFoldersNode_Params.Make(const aNode: IFoldersNode;
  aInternalCall: Boolean): IFolderElement_InternalEditByFoldersNode_Params;
var
 l_Inst : TFolderElement_InternalEditByFoldersNode_Params;
begin
 l_Inst := Create(aNode, aInternalCall);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFolderElement_InternalEditByFoldersNode_Params.Get_InternalCall: Boolean;
 {-}
begin
 Result := f_InternalCall;
end;//TFolderElement_InternalEditByFoldersNode_Params.Get_InternalCall

function TFolderElement_InternalEditByFoldersNode_Params.Get_Node: IFoldersNode;
 {-}
begin
 Result := f_Node;
end;//TFolderElement_InternalEditByFoldersNode_Params.Get_Node

procedure TFolderElement_InternalEditByFoldersNode_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFolderElement_InternalEditByFoldersNode_Params.ClearFields
// start class Op_FolderElement_InternalEditByFoldersNode

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmEntity;
  const aNode: IFoldersNode;
  aInternalCall: Boolean = true): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalEditByFoldersNode_Params.Make(aNode,aInternalCall));
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
  aInternalCall: Boolean = true): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalEditByFoldersNode_Params.Make(aNode,aInternalCall));
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
  aInternalCall: Boolean = true): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aInternalCall);
end;//Op_FolderElement_InternalEditByFoldersNode.Call

class function Op_FolderElement_InternalEditByFoldersNode.Call(const aTarget: IvcmContainer;
  const aNode: IFoldersNode;
  aInternalCall: Boolean = true): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aInternalCall);
end;//Op_FolderElement_InternalEditByFoldersNode.Call

type
 TFolderElement_InternalDelete_Params = class(Tl3CProtoObject, IFolderElement_InternalDelete_Params)
  {* Реализация IFolderElement_InternalDelete_Params }
 private
 // private fields
   f_Node : IFoldersNode;
   f_Ask : Boolean;
   f_ResultValue : TnsDeleteResult;
 protected
 // realized methods
   function Get_Ask: Boolean;
   function Get_Node: IFoldersNode;
   function Get_ResultValue: TnsDeleteResult;
   procedure Set_ResultValue(aValue: TnsDeleteResult);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IFoldersNode;
    aAsk: Boolean); reintroduce;
     {* Конструктор TFolderElement_InternalDelete_Params }
   class function Make(const aNode: IFoldersNode;
    aAsk: Boolean): IFolderElement_InternalDelete_Params; reintroduce;
     {* Фабрика TFolderElement_InternalDelete_Params }
 end;//TFolderElement_InternalDelete_Params

// start class TFolderElement_InternalDelete_Params

constructor TFolderElement_InternalDelete_Params.Create(const aNode: IFoldersNode;
  aAsk: Boolean);
 {-}
begin
 inherited Create;
 f_Node := aNode;
 f_Ask := aAsk;
end;//TFolderElement_InternalDelete_Params.Create

class function TFolderElement_InternalDelete_Params.Make(const aNode: IFoldersNode;
  aAsk: Boolean): IFolderElement_InternalDelete_Params;
var
 l_Inst : TFolderElement_InternalDelete_Params;
begin
 l_Inst := Create(aNode, aAsk);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFolderElement_InternalDelete_Params.Get_Ask: Boolean;
 {-}
begin
 Result := f_Ask;
end;//TFolderElement_InternalDelete_Params.Get_Ask

function TFolderElement_InternalDelete_Params.Get_Node: IFoldersNode;
 {-}
begin
 Result := f_Node;
end;//TFolderElement_InternalDelete_Params.Get_Node

function TFolderElement_InternalDelete_Params.Get_ResultValue: TnsDeleteResult;
 {-}
begin
 Result := f_ResultValue;
end;//TFolderElement_InternalDelete_Params.Get_ResultValue

procedure TFolderElement_InternalDelete_Params.Set_ResultValue(aValue: TnsDeleteResult);
 {-}
begin
 f_ResultValue := aValue;
end;//TFolderElement_InternalDelete_Params.Set_ResultValue

procedure TFolderElement_InternalDelete_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFolderElement_InternalDelete_Params.ClearFields
// start class Op_FolderElement_InternalDelete

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmEntity;
  const aNode: IFoldersNode;
  aAsk: Boolean = true): TnsDeleteResult;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalDelete_Params.Make(aNode,aAsk));
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
  aAsk: Boolean = true): TnsDeleteResult;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalDelete_Params.Make(aNode,aAsk));
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
  aAsk: Boolean = true): TnsDeleteResult;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aAsk);
end;//Op_FolderElement_InternalDelete.Call

class function Op_FolderElement_InternalDelete.Call(const aTarget: IvcmContainer;
  const aNode: IFoldersNode;
  aAsk: Boolean = true): TnsDeleteResult;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aAsk);
end;//Op_FolderElement_InternalDelete.Call

type
 TFolderElement_InternalEdit_Params = class(Tl3CProtoObject, IFolderElement_InternalEdit_Params)
  {* Реализация IFolderElement_InternalEdit_Params }
 private
 // private fields
   f_Node : IeeNode;
   f_InternalCall : Boolean;
 protected
 // realized methods
   function Get_InternalCall: Boolean;
   function Get_Node: IeeNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IeeNode;
    aInternalCall: Boolean); reintroduce;
     {* Конструктор TFolderElement_InternalEdit_Params }
   class function Make(const aNode: IeeNode;
    aInternalCall: Boolean): IFolderElement_InternalEdit_Params; reintroduce;
     {* Фабрика TFolderElement_InternalEdit_Params }
 end;//TFolderElement_InternalEdit_Params

// start class TFolderElement_InternalEdit_Params

constructor TFolderElement_InternalEdit_Params.Create(const aNode: IeeNode;
  aInternalCall: Boolean);
 {-}
begin
 inherited Create;
 f_Node := aNode;
 f_InternalCall := aInternalCall;
end;//TFolderElement_InternalEdit_Params.Create

class function TFolderElement_InternalEdit_Params.Make(const aNode: IeeNode;
  aInternalCall: Boolean): IFolderElement_InternalEdit_Params;
var
 l_Inst : TFolderElement_InternalEdit_Params;
begin
 l_Inst := Create(aNode, aInternalCall);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFolderElement_InternalEdit_Params.Get_InternalCall: Boolean;
 {-}
begin
 Result := f_InternalCall;
end;//TFolderElement_InternalEdit_Params.Get_InternalCall

function TFolderElement_InternalEdit_Params.Get_Node: IeeNode;
 {-}
begin
 Result := f_Node;
end;//TFolderElement_InternalEdit_Params.Get_Node

procedure TFolderElement_InternalEdit_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFolderElement_InternalEdit_Params.ClearFields
// start class Op_FolderElement_InternalEdit

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmEntity;
  const aNode: IeeNode;
  aInternalCall: Boolean = true): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalEdit_Params.Make(aNode,aInternalCall));
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
  aInternalCall: Boolean = true): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_InternalEdit_Params.Make(aNode,aInternalCall));
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
  aInternalCall: Boolean = true): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aInternalCall);
end;//Op_FolderElement_InternalEdit.Call

class function Op_FolderElement_InternalEdit.Call(const aTarget: IvcmContainer;
  const aNode: IeeNode;
  aInternalCall: Boolean = true): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aInternalCall);
end;//Op_FolderElement_InternalEdit.Call
// start class Op_FolderElement_DisableFilter

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_DisableFilter.Call

class function Op_FolderElement_DisableFilter.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_DisableFilter.Call

type
 TFolderElement_SetState_Params = class(Tl3CProtoObject, IFolderElement_SetState_Params)
  {* Реализация IFolderElement_SetState_Params }
 private
 // private fields
   f_InfoType : TFoldersInfoType;
 protected
 // realized methods
   function Get_InfoType: TFoldersInfoType;
 public
 // public methods
   constructor Create(aInfoType: TFoldersInfoType); reintroduce;
     {* Конструктор TFolderElement_SetState_Params }
   class function Make(aInfoType: TFoldersInfoType): IFolderElement_SetState_Params; reintroduce;
     {* Фабрика TFolderElement_SetState_Params }
 end;//TFolderElement_SetState_Params

// start class TFolderElement_SetState_Params

constructor TFolderElement_SetState_Params.Create(aInfoType: TFoldersInfoType);
 {-}
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
end;

function TFolderElement_SetState_Params.Get_InfoType: TFoldersInfoType;
 {-}
begin
 Result := f_InfoType;
end;//TFolderElement_SetState_Params.Get_InfoType
// start class Op_FolderElement_SetState

class function Op_FolderElement_SetState.Call(const aTarget: IvcmEntity;
  aInfoType: TFoldersInfoType): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aInfoType);
end;//Op_FolderElement_SetState.Call

class function Op_FolderElement_SetState.Call(const aTarget: IvcmContainer;
  aInfoType: TFoldersInfoType): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aInfoType);
end;//Op_FolderElement_SetState.Call
// start class Op_AdditionInfo_Show

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_AdditionInfo_Show.Call

class function Op_AdditionInfo_Show.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_AdditionInfo_Show.Call
// start class Op_AdditionInfo_Hide

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_AdditionInfo_Hide.Call

class function Op_AdditionInfo_Hide.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_AdditionInfo_Hide.Call

type
 TAdditionInfo_SetCaption_Params = class(Tl3CProtoObject, IAdditionInfo_SetCaption_Params)
  {* Реализация IAdditionInfo_SetCaption_Params }
 private
 // private fields
   f_Caption : Il3CString;
 protected
 // realized methods
   function Get_Caption: Il3CString;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aCaption: Il3CString); reintroduce;
     {* Конструктор TAdditionInfo_SetCaption_Params }
   class function Make(const aCaption: Il3CString): IAdditionInfo_SetCaption_Params; reintroduce;
     {* Фабрика TAdditionInfo_SetCaption_Params }
 end;//TAdditionInfo_SetCaption_Params

// start class TAdditionInfo_SetCaption_Params

constructor TAdditionInfo_SetCaption_Params.Create(const aCaption: Il3CString);
 {-}
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
end;

function TAdditionInfo_SetCaption_Params.Get_Caption: Il3CString;
 {-}
begin
 Result := f_Caption;
end;//TAdditionInfo_SetCaption_Params.Get_Caption

procedure TAdditionInfo_SetCaption_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Caption := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TAdditionInfo_SetCaption_Params.ClearFields
// start class Op_AdditionInfo_SetCaption

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmEntity;
  const aCaption: Il3CString): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aCaption);
end;//Op_AdditionInfo_SetCaption.Call

class function Op_AdditionInfo_SetCaption.Call(const aTarget: IvcmContainer;
  const aCaption: Il3CString): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aCaption);
end;//Op_AdditionInfo_SetCaption.Call

type
 TFolderElement_GetState_Params = class(Tl3CProtoObject, IFolderElement_GetState_Params)
  {* Реализация IFolderElement_GetState_Params }
 private
 // private fields
   f_ResultValue : TFoldersInfoType;
 protected
 // realized methods
   function Get_ResultValue: TFoldersInfoType;
   procedure Set_ResultValue(aValue: TFoldersInfoType);
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TFolderElement_GetState_Params }
   class function Make: IFolderElement_GetState_Params; reintroduce;
     {* Фабрика TFolderElement_GetState_Params }
 end;//TFolderElement_GetState_Params

// start class TFolderElement_GetState_Params

constructor TFolderElement_GetState_Params.Create;
 {-}
begin
 inherited Create;
end;//TFolderElement_GetState_Params.Create

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
end;

function TFolderElement_GetState_Params.Get_ResultValue: TFoldersInfoType;
 {-}
begin
 Result := f_ResultValue;
end;//TFolderElement_GetState_Params.Get_ResultValue

procedure TFolderElement_GetState_Params.Set_ResultValue(aValue: TFoldersInfoType);
 {-}
begin
 f_ResultValue := aValue;
end;//TFolderElement_GetState_Params.Set_ResultValue
// start class Op_FolderElement_GetState

class function Op_FolderElement_GetState.Call(const aTarget: IvcmEntity): TFoldersInfoType;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_GetState.Call

class function Op_FolderElement_GetState.Call(const aTarget: IvcmContainer): TFoldersInfoType;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_GetState.Call

type
 TFolderElement_SetLoadInfo_Params = class(Tl3CProtoObject, IFolderElement_SetLoadInfo_Params)
  {* Реализация IFolderElement_SetLoadInfo_Params }
 private
 // private fields
   f_Form : IvcmEntityForm;
   f_FolderFilterInfo : InsFolderFilterInfo;
   f_Caption : Il3CString;
   f_Data : IUnknown;
   f_nOp : TListLogicOperation;
 protected
 // realized methods
   function Get_Data: IUnknown;
   function Get_NOp: TListLogicOperation;
   function Get_Form: IvcmEntityForm;
   function Get_Caption: Il3CString;
   function Get_FolderFilterInfo: InsFolderFilterInfo;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation); reintroduce;
     {* Конструктор TFolderElement_SetLoadInfo_Params }
   class function Make(const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation): IFolderElement_SetLoadInfo_Params; reintroduce;
     {* Фабрика TFolderElement_SetLoadInfo_Params }
 end;//TFolderElement_SetLoadInfo_Params

// start class TFolderElement_SetLoadInfo_Params

constructor TFolderElement_SetLoadInfo_Params.Create(const aForm: IvcmEntityForm;
  const aFolderFilterInfo: InsFolderFilterInfo;
  const aCaption: Il3CString;
  const aData: IUnknown;
  anOp: TListLogicOperation);
 {-}
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
end;

function TFolderElement_SetLoadInfo_Params.Get_Data: IUnknown;
 {-}
begin
 Result := f_Data;
end;//TFolderElement_SetLoadInfo_Params.Get_Data

function TFolderElement_SetLoadInfo_Params.Get_NOp: TListLogicOperation;
 {-}
begin
 Result := f_nOp;
end;//TFolderElement_SetLoadInfo_Params.Get_NOp

function TFolderElement_SetLoadInfo_Params.Get_Form: IvcmEntityForm;
 {-}
begin
 Result := f_Form;
end;//TFolderElement_SetLoadInfo_Params.Get_Form

function TFolderElement_SetLoadInfo_Params.Get_Caption: Il3CString;
 {-}
begin
 Result := f_Caption;
end;//TFolderElement_SetLoadInfo_Params.Get_Caption

function TFolderElement_SetLoadInfo_Params.Get_FolderFilterInfo: InsFolderFilterInfo;
 {-}
begin
 Result := f_FolderFilterInfo;
end;//TFolderElement_SetLoadInfo_Params.Get_FolderFilterInfo

procedure TFolderElement_SetLoadInfo_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Form := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_FolderFilterInfo := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Caption := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFolderElement_SetLoadInfo_Params.ClearFields
// start class Op_FolderElement_SetLoadInfo

class function Op_FolderElement_SetLoadInfo.Call(const aTarget: IvcmEntity;
  const aForm: IvcmEntityForm;
  const aFolderFilterInfo: InsFolderFilterInfo;
  const aCaption: Il3CString;
  const aData: IUnknown;
  anOp: TListLogicOperation): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetLoadInfo_Params.Make(aForm,aFolderFilterInfo,aCaption,aData,anOp));
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetLoadInfo_Params.Make(aForm,aFolderFilterInfo,aCaption,aData,anOp));
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
 {-}
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aForm, aFolderFilterInfo, aCaption, aData, anOp);
end;//Op_FolderElement_SetLoadInfo.Call

type
 TFolderElement_SetContent_Params = class(Tl3CProtoObject, IFolderElement_SetContent_Params)
  {* Реализация IFolderElement_SetContent_Params }
 private
 // private fields
   f_Node : IeeNode;
   f_IsNewFolder : Boolean;
 protected
 // realized methods
   function Get_Node: IeeNode;
   function Get_IsNewFolder: Boolean;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IeeNode;
    aIsNewFolder: Boolean); reintroduce;
     {* Конструктор TFolderElement_SetContent_Params }
   class function Make(const aNode: IeeNode;
    aIsNewFolder: Boolean): IFolderElement_SetContent_Params; reintroduce;
     {* Фабрика TFolderElement_SetContent_Params }
 end;//TFolderElement_SetContent_Params

// start class TFolderElement_SetContent_Params

constructor TFolderElement_SetContent_Params.Create(const aNode: IeeNode;
  aIsNewFolder: Boolean);
 {-}
begin
 inherited Create;
 f_Node := aNode;
 f_IsNewFolder := aIsNewFolder;
end;//TFolderElement_SetContent_Params.Create

class function TFolderElement_SetContent_Params.Make(const aNode: IeeNode;
  aIsNewFolder: Boolean): IFolderElement_SetContent_Params;
var
 l_Inst : TFolderElement_SetContent_Params;
begin
 l_Inst := Create(aNode, aIsNewFolder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFolderElement_SetContent_Params.Get_Node: IeeNode;
 {-}
begin
 Result := f_Node;
end;//TFolderElement_SetContent_Params.Get_Node

function TFolderElement_SetContent_Params.Get_IsNewFolder: Boolean;
 {-}
begin
 Result := f_IsNewFolder;
end;//TFolderElement_SetContent_Params.Get_IsNewFolder

procedure TFolderElement_SetContent_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFolderElement_SetContent_Params.ClearFields
// start class Op_FolderElement_SetContent

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmEntity;
  const aNode: IeeNode;
  aIsNewFolder: Boolean = false): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetContent_Params.Make(aNode,aIsNewFolder));
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
  aIsNewFolder: Boolean = false): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetContent_Params.Make(aNode,aIsNewFolder));
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
  aIsNewFolder: Boolean = false): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aIsNewFolder);
end;//Op_FolderElement_SetContent.Call

class function Op_FolderElement_SetContent.Call(const aTarget: IvcmContainer;
  const aNode: IeeNode;
  aIsNewFolder: Boolean = false): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aIsNewFolder);
end;//Op_FolderElement_SetContent.Call

type
 TFolderElement_SetSaveInfo_Params = class(Tl3CProtoObject, IFolderElement_SetSaveInfo_Params)
  {* Реализация IFolderElement_SetSaveInfo_Params }
 private
 // private fields
   f_Form : IvcmEntityForm;
   f_FilterInfo : InsFolderFilterInfo;
   f_nElementType : TFoldersElementType;
   f_nEntity : IEntityBase;
   f_SaveAs : Boolean;
 protected
 // realized methods
   function Get_SaveAs: Boolean;
   function Get_NEntity: IEntityBase;
   function Get_NElementType: TFoldersElementType;
   function Get_FilterInfo: InsFolderFilterInfo;
   function Get_Form: IvcmEntityForm;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean); reintroduce;
     {* Конструктор TFolderElement_SetSaveInfo_Params }
   class function Make(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): IFolderElement_SetSaveInfo_Params; reintroduce;
     {* Фабрика TFolderElement_SetSaveInfo_Params }
 end;//TFolderElement_SetSaveInfo_Params

// start class TFolderElement_SetSaveInfo_Params

constructor TFolderElement_SetSaveInfo_Params.Create(const aForm: IvcmEntityForm;
  const aFilterInfo: InsFolderFilterInfo;
  anElementType: TFoldersElementType;
  const anEntity: IEntityBase;
  aSaveAs: Boolean);
 {-}
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
end;

function TFolderElement_SetSaveInfo_Params.Get_SaveAs: Boolean;
 {-}
begin
 Result := f_SaveAs;
end;//TFolderElement_SetSaveInfo_Params.Get_SaveAs

function TFolderElement_SetSaveInfo_Params.Get_NEntity: IEntityBase;
 {-}
begin
 Result := f_nEntity;
end;//TFolderElement_SetSaveInfo_Params.Get_NEntity

function TFolderElement_SetSaveInfo_Params.Get_NElementType: TFoldersElementType;
 {-}
begin
 Result := f_nElementType;
end;//TFolderElement_SetSaveInfo_Params.Get_NElementType

function TFolderElement_SetSaveInfo_Params.Get_FilterInfo: InsFolderFilterInfo;
 {-}
begin
 Result := f_FilterInfo;
end;//TFolderElement_SetSaveInfo_Params.Get_FilterInfo

function TFolderElement_SetSaveInfo_Params.Get_Form: IvcmEntityForm;
 {-}
begin
 Result := f_Form;
end;//TFolderElement_SetSaveInfo_Params.Get_Form

procedure TFolderElement_SetSaveInfo_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Form := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_FilterInfo := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_nEntity := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFolderElement_SetSaveInfo_Params.ClearFields
// start class Op_FolderElement_SetSaveInfo

class function Op_FolderElement_SetSaveInfo.Call(const aTarget: IvcmEntity;
  const aForm: IvcmEntityForm;
  const aFilterInfo: InsFolderFilterInfo;
  anElementType: TFoldersElementType;
  const anEntity: IEntityBase;
  aSaveAs: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetSaveInfo_Params.Make(aForm,aFilterInfo,anElementType,anEntity,aSaveAs));
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFolderElement_SetSaveInfo_Params.Make(aForm,aFilterInfo,anElementType,anEntity,aSaveAs));
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
 {-}
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aForm, aFilterInfo, anElementType, anEntity, aSaveAs);
end;//Op_FolderElement_SetSaveInfo.Call

type
 TFolderElement_ResetModificationOnDelete_Params = class(Tl3CProtoObject, IFolderElement_ResetModificationOnDelete_Params)
  {* Реализация IFolderElement_ResetModificationOnDelete_Params }
 private
 // private fields
   f_Node : IeeNode;
 protected
 // realized methods
   function Get_Node: IeeNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IeeNode); reintroduce;
     {* Конструктор TFolderElement_ResetModificationOnDelete_Params }
   class function Make(const aNode: IeeNode): IFolderElement_ResetModificationOnDelete_Params; reintroduce;
     {* Фабрика TFolderElement_ResetModificationOnDelete_Params }
 end;//TFolderElement_ResetModificationOnDelete_Params

// start class TFolderElement_ResetModificationOnDelete_Params

constructor TFolderElement_ResetModificationOnDelete_Params.Create(const aNode: IeeNode);
 {-}
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
end;

function TFolderElement_ResetModificationOnDelete_Params.Get_Node: IeeNode;
 {-}
begin
 Result := f_Node;
end;//TFolderElement_ResetModificationOnDelete_Params.Get_Node

procedure TFolderElement_ResetModificationOnDelete_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFolderElement_ResetModificationOnDelete_Params.ClearFields
// start class Op_FolderElement_ResetModificationOnDelete

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmEntity;
  const aNode: IeeNode): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_FolderElement_ResetModificationOnDelete.Call

class function Op_FolderElement_ResetModificationOnDelete.Call(const aTarget: IvcmContainer;
  const aNode: IeeNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_FolderElement_ResetModificationOnDelete.Call
// start class Op_FolderElement_SetFocus

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_SetFocus.Call

class function Op_FolderElement_SetFocus.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_SetFocus.Call
// start class Op_FolderElement_Redraw

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_Redraw.Call

class function Op_FolderElement_Redraw.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_Redraw.Call
// start class Op_FolderElement_DisableSecurityPage

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_FolderElement_DisableSecurityPage.Call

class function Op_FolderElement_DisableSecurityPage.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_FolderElement_DisableSecurityPage.Call

type
 TSavedQuery_SetFilterState_Params = class(Tl3CProtoObject, ISavedQuery_SetFilterState_Params)
  {* Реализация ISavedQuery_SetFilterState_Params }
 private
 // private fields
   f_Node : INode;
 protected
 // realized methods
   function Get_Node: INode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: INode); reintroduce;
     {* Конструктор TSavedQuery_SetFilterState_Params }
   class function Make(const aNode: INode): ISavedQuery_SetFilterState_Params; reintroduce;
     {* Фабрика TSavedQuery_SetFilterState_Params }
 end;//TSavedQuery_SetFilterState_Params

// start class TSavedQuery_SetFilterState_Params

constructor TSavedQuery_SetFilterState_Params.Create(const aNode: INode);
 {-}
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
end;

function TSavedQuery_SetFilterState_Params.Get_Node: INode;
 {-}
begin
 Result := f_Node;
end;//TSavedQuery_SetFilterState_Params.Get_Node

procedure TSavedQuery_SetFilterState_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TSavedQuery_SetFilterState_Params.ClearFields
// start class Op_SavedQuery_SetFilterState

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmEntity;
  const aNode: INode): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_SavedQuery_SetFilterState.Call

class function Op_SavedQuery_SetFilterState.Call(const aTarget: IvcmContainer;
  const aNode: INode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_SavedQuery_SetFilterState.Call

type
 TFolders_SetCurrent_Params = class(Tl3CProtoObject, IFolders_SetCurrent_Params)
  {* Реализация IFolders_SetCurrent_Params }
 private
 // private fields
   f_Node : IeeNode;
 protected
 // realized methods
   function Get_Node: IeeNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IeeNode); reintroduce;
     {* Конструктор TFolders_SetCurrent_Params }
   class function Make(const aNode: IeeNode): IFolders_SetCurrent_Params; reintroduce;
     {* Фабрика TFolders_SetCurrent_Params }
 end;//TFolders_SetCurrent_Params

// start class TFolders_SetCurrent_Params

constructor TFolders_SetCurrent_Params.Create(const aNode: IeeNode);
 {-}
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
end;

function TFolders_SetCurrent_Params.Get_Node: IeeNode;
 {-}
begin
 Result := f_Node;
end;//TFolders_SetCurrent_Params.Get_Node

procedure TFolders_SetCurrent_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFolders_SetCurrent_Params.ClearFields
// start class Op_Folders_SetCurrent

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmEntity;
  const aNode: IeeNode): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_Folders_SetCurrent.Call

class function Op_Folders_SetCurrent.Call(const aTarget: IvcmContainer;
  const aNode: IeeNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_Folders_SetCurrent.Call

type
 TFolders_FiltrateByFilterInfo_Params = class(Tl3CProtoObject, IFolders_FiltrateByFilterInfo_Params)
  {* Реализация IFolders_FiltrateByFilterInfo_Params }
 private
 // private fields
   f_nInfo : InsFolderFilterInfo;
 protected
 // realized methods
   function Get_NInfo: InsFolderFilterInfo;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const anInfo: InsFolderFilterInfo); reintroduce;
     {* Конструктор TFolders_FiltrateByFilterInfo_Params }
   class function Make(const anInfo: InsFolderFilterInfo): IFolders_FiltrateByFilterInfo_Params; reintroduce;
     {* Фабрика TFolders_FiltrateByFilterInfo_Params }
 end;//TFolders_FiltrateByFilterInfo_Params

// start class TFolders_FiltrateByFilterInfo_Params

constructor TFolders_FiltrateByFilterInfo_Params.Create(const anInfo: InsFolderFilterInfo);
 {-}
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
end;

function TFolders_FiltrateByFilterInfo_Params.Get_NInfo: InsFolderFilterInfo;
 {-}
begin
 Result := f_nInfo;
end;//TFolders_FiltrateByFilterInfo_Params.Get_NInfo

procedure TFolders_FiltrateByFilterInfo_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_nInfo := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFolders_FiltrateByFilterInfo_Params.ClearFields
// start class Op_Folders_FiltrateByFilterInfo

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmEntity;
  const anInfo: InsFolderFilterInfo): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, anInfo);
end;//Op_Folders_FiltrateByFilterInfo.Call

class function Op_Folders_FiltrateByFilterInfo.Call(const aTarget: IvcmContainer;
  const anInfo: InsFolderFilterInfo): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, anInfo);
end;//Op_Folders_FiltrateByFilterInfo.Call
// start class Op_Folders_TryOpenConsultationAnswer

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Folders_TryOpenConsultationAnswer.Call

class function Op_Folders_TryOpenConsultationAnswer.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Folders_TryOpenConsultationAnswer.Call
// start class Op_Folders_OpenMyConsultations

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Folders_OpenMyConsultations.Call

class function Op_Folders_OpenMyConsultations.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Folders_OpenMyConsultations.Call
// start class Op_Folders_SetInfoContent

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Folders_SetInfoContent.Call

class function Op_Folders_SetInfoContent.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Folders_SetInfoContent.Call

type
 TUsersRights_UpdateRights_Params = class(Tl3CProtoObject, IUsersRights_UpdateRights_Params)
  {* Реализация IUsersRights_UpdateRights_Params }
 private
 // private fields
   f_Node : IeeNode;
 protected
 // realized methods
   function Get_Node: IeeNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IeeNode); reintroduce;
     {* Конструктор TUsersRights_UpdateRights_Params }
   class function Make(const aNode: IeeNode): IUsersRights_UpdateRights_Params; reintroduce;
     {* Фабрика TUsersRights_UpdateRights_Params }
 end;//TUsersRights_UpdateRights_Params

// start class TUsersRights_UpdateRights_Params

constructor TUsersRights_UpdateRights_Params.Create(const aNode: IeeNode);
 {-}
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
end;

function TUsersRights_UpdateRights_Params.Get_Node: IeeNode;
 {-}
begin
 Result := f_Node;
end;//TUsersRights_UpdateRights_Params.Get_Node

procedure TUsersRights_UpdateRights_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TUsersRights_UpdateRights_Params.ClearFields
// start class Op_UsersRights_UpdateRights

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmEntity;
  const aNode: IeeNode): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_UsersRights_UpdateRights.Call

class function Op_UsersRights_UpdateRights.Call(const aTarget: IvcmContainer;
  const aNode: IeeNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_UsersRights_UpdateRights.Call
// start class Op_UsersRights_FolderShareChanged

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_UsersRights_FolderShareChanged.Call

class function Op_UsersRights_FolderShareChanged.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_UsersRights_FolderShareChanged.Call
// start class Op_Result_ExternalOk

class function Op_Result_ExternalOk.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Result_ExternalOk.Call

class function Op_Result_ExternalOk.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Result_ExternalOk.Call
{$IfEnd} //not Admin AND not Monitorings


end.