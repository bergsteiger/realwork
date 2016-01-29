unit Base_Operations_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Base_Operations_Strange_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Base Operations::View::Strange
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
  FoldersUnit,
  DocumentUnit,
  l3Interfaces,
  nevBase,
  l3TreeInterfaces,
  l3Tree_TLB,
  eeInterfaces,
  DocumentAndListInterfaces,
  Base_Operations_Editions_Controls,
  l3CProtoObject,
  PrimPrimListInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  nsTypes,
  l3Variant,
  vcmExternalInterfaces {a}
  ;

(* Switcher = operations
   ['{5DFC9F33-AE17-4278-9DAD-4F3EE6598B65}']
   query BecomeActive;
 end;//Switcher*)

(* Document = operations
  {* Документ }
   ['{4778E8B7-DEDE-42B2-906E-6A02A54CF15F}']
   query FindExplanation: Boolean;
     {* Найти толкование }
 end;//Document*)

(* SynchroView = operations
   ['{3BB26C76-F1DA-4A3B-B08A-9E3BA4A34D65}']
   query BecomeActive(aFormType: TnsShowSynchroForm);
 end;//SynchroView*)

(* List = operations
   ['{28D04E7D-ABE0-467A-9226-EB5FBDC6254E}']
   query GetDeList: IdeList;
   query SetCurrentVisible;
   operation SwitchToFullList;
     {* Построить полный список }
   query GetDsList: IdsList;
 end;//List*)

(* Form = operations
   ['{6ADBC79F-4103-4D38-A8C0-C786ADC5EAD4}']
   query RequestClose;
 end;//Form*)

(* ControlCenter = operations
   ['{CCDA7C71-97DF-4DA1-B950-54D1256CBA67}']
   query Refresh;
 end;//ControlCenter*)

(* ListInfo = operations
   ['{876478E7-7AB0-49A2-92CE-D6D5F2C24CDC}']
   query BecomeActive;
 end;//ListInfo*)

(* Filters = operations
   ['{3DF7B8EE-2A16-41DA-A645-7108E6C1C1E8}']
   query DeselectAll;
 end;//Filters*)

(* LocalList = operations
  {* Список (контекстные операции) }
   ['{65F64517-9262-45FA-B4C3-756BD4D3A503}']
   operation SearchInList;
     {* Искать по реквизитам в текущем списке }
   operation PublishSourceSearchInList;
     {* Искать по источнику опубликования в текущем списке }
   operation Open;
   operation SearchDrugInList;
   query OpenNewWindow;
     {* Открыть текущий список в новом окне }
 end;//LocalList*)

(* TimeMachine = operations
   ['{B8F35528-A268-4784-AF0A-1A8EB75B482A}']
   operation TimeMachineOnOffNew; has states;
     {* Включить Машину времени }
      MachineOn = state
      end;//MachineOn
      MachineOff = state
       { Выключить Машину времени/Изменить дату }
      end;//MachineOff
   operation TimeMachineOnOff;
   operation TimeMachineOffAndReset;
   operation TimeMachineOnOffNew; has states;
     {* Включить Машину времени }
 end;//TimeMachine*)

(* Filter = operations
   ['{E57745E2-E106-4D78-A83C-26526867CCC2}']
   operation Activate; has states;
     {* Применить фильтр }
      Deactivate = state
       { Отменить фильтр }
      end;//Deactivate
   query ActivateNode(const aNode: Il3Node);
 end;//Filter*)

(* Document = operations
   ['{E618B59B-6055-4AC7-B531-C9B40B4A6CD5}']
   operation GetAnnotationDocFrmAct;
   operation SimilarDocuments;
 end;//Document*)

(* Document = operations
  {* Документ }
   ['{64F8E672-5ABC-4C86-8516-F349F71D36EC}']
   operation DocumentIsUseful; has states;
     {* Нравится }
   operation DocumentIsUseless; has states;
     {* Не нравится }
   operation PrevDocumentInList;
     {* Предыдущий документ в списке }
   operation NextDocumentInList;
     {* Следующий документ в списке }
   operation ReturnToList;
     {* Вернуться в списк }
 end;//Document*)

(* Document = operations(Document)
  {* Документ }
   ['{C235FCD8-E77E-4BDF-8560-A9DC5273ADC8}']
   operation AddToControl; has states;
     {* Поставить на контроль }
      RemoveFromControl = state
       { Снять с контроля }
      end;//RemoveFromControl
   operation UserCR1; has states;
     {* Пользовательские ссылки на документ (ссылки из документа) 1 }
      Corr = state
      end;//Corr
   operation UserCR2; has states;
     {* Пользовательские ссылки на документ (ссылки из документа) 2 }
      Corr = state
      end;//Corr
   operation AddToControl; has states;
     {* Поставить на контроль }
   FormActivate UserCR1; has states;
     {* Коллеги, это что? }
   FormActivate UserCR2; has states;
     {* Коллеги, это что? }
   operation AddBookmark;
     {* Добавить закладку }
   operation GetGraphicImage;
 end;//Document*)

(* FoldersControl = operations
  {* Управление папками }
   ['{B24F67D3-992F-473C-AA50-7F643CC64C46}']
   query EditElement(const aNode: IFoldersNode);
     {* Начать редактирование элемента }
   query DeleteElement(const aNode: IFoldersNode): TnsDeleteResult;
     {* Удалить элемент }
 end;//FoldersControl*)

(* SavedQuery = operations
   ['{39DAE91B-4CEC-4BE8-A614-8536F5AFB0F5}']
   operation OpenQuery;
   operation ExecuteQuery;
 end;//SavedQuery*)

(* Filters = operations
   ['{5528217B-0C22-4FB1-BED5-5244023F978D}']
   operation FiltersList;
   query Clear;
   query InternalClear;
 end;//Filters*)

(* Openable = operations
   ['{A484DC11-13C2-4CCB-8438-FE7DB25CA176}']
   operation OpenInNewWindow;
 end;//Openable*)

(* HyperLink = operations({, Должна быть навигация по ссылкам с клавиатуры})
  {* Гиперссылка }
   ['{D10A9F00-93A9-461F-B794-C22C1DF344D8}']
   operation Open;
   operation OpenNewWindow;
   query NextHyperLink;
   query PrevHyperLink;
   operation OpenInNewTab;
   operation OpenScriptHyperLink;
   operation NavigateInternetHyperlink;
     {* Перейти по гиперссылке }
   operation Delete;
 end;//HyperLink*)

(* Document = operations(Document)
   ['{CE683FDA-9FF8-4D24-AA59-C4A57969A4A6}']
   query SetActive(aUserType: Integer);
   query ExportBlock(const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean);
   operation GetCurrentPosition: Integer;
   query SelectBlock(const aData: IUnknown;
    aUserType: Integer);
   query CopyBlock(const aData: IUnknown;
    aUserType: Integer);
   query PrintBlock(const aData: IUnknown;
    aUserType: Integer);
   query PrintDialogBlock(const aData: IUnknown;
    aUserType: Integer);
   query PreviewBlock(const aData: IUnknown;
    aUserType: Integer);
   query ShowRespondentListToPart(const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil);
   query ShowCorrespondentListToPart(const aList: IPositionList;
    const aCurrent: Il3SimpleNode = nil);
   query ModifyBookmarkNotify(const anEntity: IUnknown);
   query AddBookmarkFromContents(const aTag: Il3TagRef);
   query OpenNotSureTopic;
   query GotoPara(const aPara: Il3TagRef;
    aUserType: Integer): Boolean;
 end;//Document*)

type
 Op_Switcher_BecomeActive = class
  {* Класс для вызова операции Switcher.BecomeActive }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Switcher.BecomeActive у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Switcher.BecomeActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Switcher.BecomeActive у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Switcher.BecomeActive у контейнера }
 end;//Op_Switcher_BecomeActive

 IDocument_FindExplanation_Params = interface(IUnknown)
  {* Параметры для операции Document.FindExplanation }
   ['{8B8A058F-947B-4C90-BB9F-5B2B796F50AC}']
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IDocument_FindExplanation_Params

 Op_Document_FindExplanation = class
  {* Класс для вызова операции Document.FindExplanation }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Document.FindExplanation у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Document.FindExplanation у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Document.FindExplanation у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Document.FindExplanation у контейнера }
 end;//Op_Document_FindExplanation

 ISynchroView_BecomeActive_Params = interface(IUnknown)
  {* Параметры для операции SynchroView.BecomeActive }
   ['{3BB24691-729B-4397-B6DE-0BF962098112}']
   function Get_FormType: TnsShowSynchroForm;
   property FormType: TnsShowSynchroForm
     read Get_FormType;
     {* undefined }
 end;//ISynchroView_BecomeActive_Params

 Op_SynchroView_BecomeActive = class
  {* Класс для вызова операции SynchroView.BecomeActive }
 public
 // public methods
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

 IList_GetDeList_Params = interface(IUnknown)
  {* Параметры для операции List.GetDeList }
   ['{594B710D-806D-4665-B11A-5E5B64970040}']
   function Get_ResultValue: IdeList;
   procedure Set_ResultValue(const aValue: IdeList);
   property ResultValue: IdeList
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IList_GetDeList_Params

 Op_List_GetDeList = class
  {* Класс для вызова операции List.GetDeList }
 public
 // public methods
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
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции List.SetCurrentVisible у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции List.SetCurrentVisible у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции List.SetCurrentVisible у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции List.SetCurrentVisible у контейнера }
 end;//Op_List_SetCurrentVisible

 IList_GetDsList_Params = interface(IUnknown)
  {* Параметры для операции List.GetDsList }
   ['{258110DB-5E97-4517-BDA9-A18D4A0D11E4}']
   function Get_ResultValue: IdsList;
   procedure Set_ResultValue(const aValue: IdsList);
   property ResultValue: IdsList
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IList_GetDsList_Params

 Op_List_GetDsList = class
  {* Класс для вызова операции List.GetDsList }
 public
 // public methods
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
 // public methods
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
 // public methods
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
 // public methods
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
 // public methods
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
 // public methods
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
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции TimeMachine.TimeMachineOffAndReset у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции TimeMachine.TimeMachineOffAndReset у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции TimeMachine.TimeMachineOffAndReset у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции TimeMachine.TimeMachineOffAndReset у контейнера }
 end;//Op_TimeMachine_TimeMachineOffAndReset

 IFilter_ActivateNode_Params = interface(IUnknown)
  {* Параметры для операции Filter.ActivateNode }
   ['{E3E0E2F3-EF0C-4767-98C0-599417EC94A6}']
   function Get_Node: Il3Node;
   property Node: Il3Node
     read Get_Node;
     {* undefined }
 end;//IFilter_ActivateNode_Params

 Op_Filter_ActivateNode = class
  {* Класс для вызова операции Filter.ActivateNode }
 public
 // public methods
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

 IFoldersControl_EditElement_Params = interface(IUnknown)
  {* Параметры для операции FoldersControl.EditElement }
   ['{682C1E2B-52F6-4A61-B374-34071EEC36D6}']
   function Get_Node: IFoldersNode;
   property Node: IFoldersNode
     read Get_Node;
     {* undefined }
 end;//IFoldersControl_EditElement_Params

 Op_FoldersControl_EditElement = class
  {* Класс для вызова операции FoldersControl.EditElement }
 public
 // public methods
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

 IFoldersControl_DeleteElement_Params = interface(IUnknown)
  {* Параметры для операции FoldersControl.DeleteElement }
   ['{313EBF22-91AD-42F6-BB73-D24B8BB42D36}']
   function Get_Node: IFoldersNode;
   function Get_ResultValue: TnsDeleteResult;
   procedure Set_ResultValue(aValue: TnsDeleteResult);
   property Node: IFoldersNode
     read Get_Node;
     {* undefined }
   property ResultValue: TnsDeleteResult
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IFoldersControl_DeleteElement_Params

 Op_FoldersControl_DeleteElement = class
  {* Класс для вызова операции FoldersControl.DeleteElement }
 public
 // public methods
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
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Filters.InternalClear у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Filters.InternalClear у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Filters.InternalClear у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Filters.InternalClear у контейнера }
 end;//Op_Filters_InternalClear

 IDocument_SetActive_Params = interface(IUnknown)
  {* Параметры для операции Document.SetActive }
   ['{3581EB51-413B-4637-81C0-F840C8EC364A}']
   function Get_UserType: Integer;
   property UserType: Integer
     read Get_UserType;
     {* undefined }
 end;//IDocument_SetActive_Params

 Op_Document_SetActive = class
  {* Класс для вызова операции Document.SetActive }
 public
 // public methods
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

 IDocument_ExportBlock_Params = interface(IUnknown)
  {* Параметры для операции Document.ExportBlock }
   ['{9AF9E8FC-873B-47B5-A51E-0FD3D5EEA3B7}']
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   function Get_ToActiveWindow: Boolean;
   property Data: IUnknown
     read Get_Data;
     {* undefined }
   property UserType: Integer
     read Get_UserType;
     {* undefined }
   property ToActiveWindow: Boolean
     read Get_ToActiveWindow;
     {* undefined }
 end;//IDocument_ExportBlock_Params

 Op_Document_ExportBlock = class
  {* Класс для вызова операции Document.ExportBlock }
 public
 // public methods
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

 IDocument_GetCurrentPosition_Params = interface(IUnknown)
  {* Параметры для операции Document.GetCurrentPosition }
   ['{7D1695A8-37A2-4985-9E18-3E4138FC3C97}']
   function Get_ResultValue: Integer;
   procedure Set_ResultValue(aValue: Integer);
   property ResultValue: Integer
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IDocument_GetCurrentPosition_Params

 Op_Document_GetCurrentPosition = class
  {* Класс для вызова операции Document.GetCurrentPosition }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Integer; overload; 
     {* Вызов операции Document.GetCurrentPosition у сущности }
   class function Call(const aTarget: IvcmAggregate): Integer; overload; 
     {* Вызов операции Document.GetCurrentPosition у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Integer; overload; 
     {* Вызов операции Document.GetCurrentPosition у формы }
   class function Call(const aTarget: IvcmContainer): Integer; overload; 
     {* Вызов операции Document.GetCurrentPosition у контейнера }
 end;//Op_Document_GetCurrentPosition

 IDocument_SelectBlock_Params = interface(IUnknown)
  {* Параметры для операции Document.SelectBlock }
   ['{FCF56E5C-2AA5-4757-9196-D3EA3F24C9FF}']
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   property Data: IUnknown
     read Get_Data;
     {* undefined }
   property UserType: Integer
     read Get_UserType;
     {* undefined }
 end;//IDocument_SelectBlock_Params

 Op_Document_SelectBlock = class
  {* Класс для вызова операции Document.SelectBlock }
 public
 // public methods
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

 IDocument_CopyBlock_Params = interface(IUnknown)
  {* Параметры для операции Document.CopyBlock }
   ['{9EA76DAC-BC9D-4F5B-8530-0F9C1154B1AC}']
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   property Data: IUnknown
     read Get_Data;
     {* undefined }
   property UserType: Integer
     read Get_UserType;
     {* undefined }
 end;//IDocument_CopyBlock_Params

 Op_Document_CopyBlock = class
  {* Класс для вызова операции Document.CopyBlock }
 public
 // public methods
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

 IDocument_PrintBlock_Params = interface(IUnknown)
  {* Параметры для операции Document.PrintBlock }
   ['{5E6995F2-F326-463E-BE47-1194545BA317}']
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   property Data: IUnknown
     read Get_Data;
     {* undefined }
   property UserType: Integer
     read Get_UserType;
     {* undefined }
 end;//IDocument_PrintBlock_Params

 Op_Document_PrintBlock = class
  {* Класс для вызова операции Document.PrintBlock }
 public
 // public methods
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

 IDocument_PrintDialogBlock_Params = interface(IUnknown)
  {* Параметры для операции Document.PrintDialogBlock }
   ['{B65A341B-4D6B-4B63-A3FE-231558FCCBD9}']
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   property Data: IUnknown
     read Get_Data;
     {* undefined }
   property UserType: Integer
     read Get_UserType;
     {* undefined }
 end;//IDocument_PrintDialogBlock_Params

 Op_Document_PrintDialogBlock = class
  {* Класс для вызова операции Document.PrintDialogBlock }
 public
 // public methods
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

 IDocument_PreviewBlock_Params = interface(IUnknown)
  {* Параметры для операции Document.PreviewBlock }
   ['{D59D84E3-3E27-4BB2-9F31-75990AD0A666}']
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   property Data: IUnknown
     read Get_Data;
     {* undefined }
   property UserType: Integer
     read Get_UserType;
     {* undefined }
 end;//IDocument_PreviewBlock_Params

 Op_Document_PreviewBlock = class
  {* Класс для вызова операции Document.PreviewBlock }
 public
 // public methods
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

 IDocument_ShowRespondentListToPart_Params = interface(IUnknown)
  {* Параметры для операции Document.ShowRespondentListToPart }
   ['{B7C75BB4-D502-4444-8B45-CB10A63D188C}']
   function Get_List: IPositionList;
   function Get_Current: Il3SimpleNode;
   property List: IPositionList
     read Get_List;
     {* undefined }
   property Current: Il3SimpleNode
     read Get_Current;
     {* undefined }
 end;//IDocument_ShowRespondentListToPart_Params

 Op_Document_ShowRespondentListToPart = class
  {* Класс для вызова операции Document.ShowRespondentListToPart }
 public
 // public methods
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

 IDocument_ShowCorrespondentListToPart_Params = interface(IUnknown)
  {* Параметры для операции Document.ShowCorrespondentListToPart }
   ['{7755207C-D538-4CEA-9F44-21805F093FD9}']
   function Get_List: IPositionList;
   function Get_Current: Il3SimpleNode;
   property List: IPositionList
     read Get_List;
     {* undefined }
   property Current: Il3SimpleNode
     read Get_Current;
     {* undefined }
 end;//IDocument_ShowCorrespondentListToPart_Params

 Op_Document_ShowCorrespondentListToPart = class
  {* Класс для вызова операции Document.ShowCorrespondentListToPart }
 public
 // public methods
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

 IDocument_ModifyBookmarkNotify_Params = interface(IUnknown)
  {* Параметры для операции Document.ModifyBookmarkNotify }
   ['{5B6A8FFB-0A43-4A49-9D62-2ECF573D4A86}']
   function Get_NEntity: IUnknown;
   property nEntity: IUnknown
     read Get_NEntity;
     {* undefined }
 end;//IDocument_ModifyBookmarkNotify_Params

 Op_Document_ModifyBookmarkNotify = class
  {* Класс для вызова операции Document.ModifyBookmarkNotify }
 public
 // public methods
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

 IDocument_AddBookmarkFromContents_Params = interface(IUnknown)
  {* Параметры для операции Document.AddBookmarkFromContents }
   ['{4A7CB4C7-90B2-4C22-82DC-C4A0564E367D}']
   function Get_Tag: Il3TagRef;
   property Tag: Il3TagRef
     read Get_Tag;
     {* undefined }
 end;//IDocument_AddBookmarkFromContents_Params

 Op_Document_AddBookmarkFromContents = class
  {* Класс для вызова операции Document.AddBookmarkFromContents }
 public
 // public methods
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
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Document.OpenNotSureTopic у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Document.OpenNotSureTopic у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Document.OpenNotSureTopic у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Document.OpenNotSureTopic у контейнера }
 end;//Op_Document_OpenNotSureTopic

 IDocument_GotoPara_Params = interface(IUnknown)
  {* Параметры для операции Document.GotoPara }
   ['{AF708270-4305-4154-A05E-5A3ACA0A0E13}']
   function Get_Para: Il3TagRef;
   function Get_UserType: Integer;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property Para: Il3TagRef
     read Get_Para;
     {* undefined }
   property UserType: Integer
     read Get_UserType;
     {* undefined }
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IDocument_GotoPara_Params

 Op_Document_GotoPara = class
  {* Класс для вызова операции Document.GotoPara }
 public
 // public methods
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
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Switcher = 'Switcher';
 en_capSwitcher = '';
 op_BecomeActive = 'BecomeActive';
 op_capBecomeActive = '';
 en_Document = 'Document';
 en_capDocument = 'Документ';
 op_FindExplanation = 'FindExplanation';
 op_capFindExplanation = 'Найти толкование';
 en_SynchroView = 'SynchroView';
 en_capSynchroView = '';
 en_List = 'List';
 en_capList = '';
 op_GetDeList = 'GetDeList';
 op_capGetDeList = '';
 op_SetCurrentVisible = 'SetCurrentVisible';
 op_capSetCurrentVisible = '';
 op_SwitchToFullList = 'SwitchToFullList';
 op_capSwitchToFullList = 'Построить полный список';
 op_GetDsList = 'GetDsList';
 op_capGetDsList = '';
 en_Form = 'Form';
 en_capForm = '';
 op_RequestClose = 'RequestClose';
 op_capRequestClose = '';
 en_ControlCenter = 'ControlCenter';
 en_capControlCenter = '';
 op_Refresh = 'Refresh';
 op_capRefresh = '';
 en_ListInfo = 'ListInfo';
 en_capListInfo = '';
 en_Filters = 'Filters';
 en_capFilters = '';
 op_DeselectAll = 'DeselectAll';
 op_capDeselectAll = '';
 en_LocalList = 'LocalList';
 en_capLocalList = 'Список (контекстные операции)';
 op_SearchInList = 'SearchInList';
 op_capSearchInList = 'Искать по реквизитам в текущем списке';
 op_PublishSourceSearchInList = 'PublishSourceSearchInList';
 op_capPublishSourceSearchInList = 'Искать по источнику опубликования в текущем списке';
 op_Open = 'Open';
 op_capOpen = '';
 op_SearchDrugInList = 'SearchDrugInList';
 op_capSearchDrugInList = '';
 op_OpenNewWindow = 'OpenNewWindow';
 op_capOpenNewWindow = 'Открыть текущий список в новом окне';
 en_TimeMachine = 'TimeMachine';
 en_capTimeMachine = '';
 op_TimeMachineOnOffNew = 'TimeMachineOnOffNew';
 op_capTimeMachineOnOffNew = 'Включить Машину времени';
 op_TimeMachineOnOff = 'TimeMachineOnOff';
 op_capTimeMachineOnOff = '';
 op_TimeMachineOffAndReset = 'TimeMachineOffAndReset';
 op_capTimeMachineOffAndReset = '';
 en_Filter = 'Filter';
 en_capFilter = '';
 op_Activate = 'Activate';
 op_capActivate = 'Применить фильтр';
 op_ActivateNode = 'ActivateNode';
 op_capActivateNode = '';
 op_GetAnnotationDocFrmAct = 'GetAnnotationDocFrmAct';
 op_capGetAnnotationDocFrmAct = '';
 op_SimilarDocuments = 'SimilarDocuments';
 op_capSimilarDocuments = '';
 op_DocumentIsUseful = 'DocumentIsUseful';
 op_capDocumentIsUseful = 'Нравится';
 op_DocumentIsUseless = 'DocumentIsUseless';
 op_capDocumentIsUseless = 'Не нравится';
 op_PrevDocumentInList = 'PrevDocumentInList';
 op_capPrevDocumentInList = 'Предыдущий документ в списке';
 op_NextDocumentInList = 'NextDocumentInList';
 op_capNextDocumentInList = 'Следующий документ в списке';
 op_ReturnToList = 'ReturnToList';
 op_capReturnToList = 'Вернуться в списк';
 op_AddToControl = 'AddToControl';
 op_capAddToControl = 'Поставить на контроль';
 op_UserCR1 = 'UserCR1';
 op_capUserCR1 = 'Пользовательские ссылки на документ (ссылки из документа) 1';
 op_UserCR2 = 'UserCR2';
 op_capUserCR2 = 'Пользовательские ссылки на документ (ссылки из документа) 2';
 op_AddBookmark = 'AddBookmark';
 op_capAddBookmark = 'Добавить закладку';
 op_GetGraphicImage = 'GetGraphicImage';
 op_capGetGraphicImage = '';
 en_FoldersControl = 'FoldersControl';
 en_capFoldersControl = 'Управление папками';
 op_EditElement = 'EditElement';
 op_capEditElement = 'Начать редактирование элемента';
 op_DeleteElement = 'DeleteElement';
 op_capDeleteElement = 'Удалить элемент';
 en_SavedQuery = 'SavedQuery';
 en_capSavedQuery = '';
 op_OpenQuery = 'OpenQuery';
 op_capOpenQuery = '';
 op_ExecuteQuery = 'ExecuteQuery';
 op_capExecuteQuery = '';
 op_FiltersList = 'FiltersList';
 op_capFiltersList = '';
 op_Clear = 'Clear';
 op_capClear = '';
 op_InternalClear = 'InternalClear';
 op_capInternalClear = '';
 en_Openable = 'Openable';
 en_capOpenable = '';
 op_OpenInNewWindow = 'OpenInNewWindow';
 op_capOpenInNewWindow = '';
 en_HyperLink = 'HyperLink';
 en_capHyperLink = 'Гиперссылка';
 op_NextHyperLink = 'NextHyperLink';
 op_capNextHyperLink = '';
 op_PrevHyperLink = 'PrevHyperLink';
 op_capPrevHyperLink = '';
 op_OpenInNewTab = 'OpenInNewTab';
 op_capOpenInNewTab = '';
 op_OpenScriptHyperLink = 'OpenScriptHyperLink';
 op_capOpenScriptHyperLink = '';
 op_NavigateInternetHyperlink = 'NavigateInternetHyperlink';
 op_capNavigateInternetHyperlink = 'Перейти по гиперссылке';
 op_Delete = 'Delete';
 op_capDelete = '';
 op_SetActive = 'SetActive';
 op_capSetActive = '';
 op_ExportBlock = 'ExportBlock';
 op_capExportBlock = '';
 op_GetCurrentPosition = 'GetCurrentPosition';
 op_capGetCurrentPosition = '';
 op_SelectBlock = 'SelectBlock';
 op_capSelectBlock = '';
 op_CopyBlock = 'CopyBlock';
 op_capCopyBlock = '';
 op_PrintBlock = 'PrintBlock';
 op_capPrintBlock = '';
 op_PrintDialogBlock = 'PrintDialogBlock';
 op_capPrintDialogBlock = '';
 op_PreviewBlock = 'PreviewBlock';
 op_capPreviewBlock = '';
 op_ShowRespondentListToPart = 'ShowRespondentListToPart';
 op_capShowRespondentListToPart = '';
 op_ShowCorrespondentListToPart = 'ShowCorrespondentListToPart';
 op_capShowCorrespondentListToPart = '';
 op_ModifyBookmarkNotify = 'ModifyBookmarkNotify';
 op_capModifyBookmarkNotify = '';
 op_AddBookmarkFromContents = 'AddBookmarkFromContents';
 op_capAddBookmarkFromContents = '';
 op_OpenNotSureTopic = 'OpenNotSureTopic';
 op_capOpenNotSureTopic = '';
 op_GotoPara = 'GotoPara';
 op_capGotoPara = '';

// Состояния операций:
var st_user_TimeMachine_TimeMachineOnOffNew_MachineOn : TvcmOperationStateIndex = (rID : -1);
  // TimeMachine -> Включить Машину времени <-> MachineOn
var st_user_TimeMachine_TimeMachineOnOffNew_MachineOff : TvcmOperationStateIndex = (rID : -1);
  // TimeMachine -> Включить Машину времени <-> Выключить Машину времени/Изменить дату
var st_user_Filter_Activate_Deactivate : TvcmOperationStateIndex = (rID : -1);
  // Filter -> Применить фильтр <-> Отменить фильтр
var st_user_Document_AddToControl_RemoveFromControl : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Поставить на контроль <-> Снять с контроля
var st_user_Document_UserCR1_Corr : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Пользовательские ссылки на документ (ссылки из документа) 1 <-> Corr
var st_user_Document_UserCR2_Corr : TvcmOperationStateIndex = (rID : -1);
  // Документ -> Пользовательские ссылки на документ (ссылки из документа) 2 <-> Corr
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

// start class Op_Switcher_BecomeActive

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Switcher_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Switcher_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Switcher_BecomeActive.Call

type
 TDocument_FindExplanation_Params = class(Tl3CProtoObject, IDocument_FindExplanation_Params)
  {* Реализация IDocument_FindExplanation_Params }
 private
 // private fields
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TDocument_FindExplanation_Params }
   class function Make: IDocument_FindExplanation_Params; reintroduce;
     {* Фабрика TDocument_FindExplanation_Params }
 end;//TDocument_FindExplanation_Params

// start class TDocument_FindExplanation_Params

constructor TDocument_FindExplanation_Params.Create;
 {-}
begin
 inherited Create;
end;//TDocument_FindExplanation_Params.Create

class function TDocument_FindExplanation_Params.Make: IDocument_FindExplanation_Params;
var
 l_Inst : TDocument_FindExplanation_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_FindExplanation_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TDocument_FindExplanation_Params.Get_ResultValue

procedure TDocument_FindExplanation_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TDocument_FindExplanation_Params.Set_ResultValue
// start class Op_Document_FindExplanation

class function Op_Document_FindExplanation.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_FindExplanation_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Document_FindExplanation, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_FindExplanation_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_FindExplanation.Call

class function Op_Document_FindExplanation.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_FindExplanation_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Document_FindExplanation, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_FindExplanation_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_FindExplanation.Call

class function Op_Document_FindExplanation.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_FindExplanation.Call

class function Op_Document_FindExplanation.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_FindExplanation.Call

type
 TSynchroView_BecomeActive_Params = class(Tl3CProtoObject, ISynchroView_BecomeActive_Params)
  {* Реализация ISynchroView_BecomeActive_Params }
 private
 // private fields
   f_FormType : TnsShowSynchroForm;
 protected
 // realized methods
   function Get_FormType: TnsShowSynchroForm;
 public
 // public methods
   constructor Create(aFormType: TnsShowSynchroForm); reintroduce;
     {* Конструктор TSynchroView_BecomeActive_Params }
   class function Make(aFormType: TnsShowSynchroForm): ISynchroView_BecomeActive_Params; reintroduce;
     {* Фабрика TSynchroView_BecomeActive_Params }
 end;//TSynchroView_BecomeActive_Params

// start class TSynchroView_BecomeActive_Params

constructor TSynchroView_BecomeActive_Params.Create(aFormType: TnsShowSynchroForm);
 {-}
begin
 inherited Create;
 f_FormType := aFormType;
end;//TSynchroView_BecomeActive_Params.Create

class function TSynchroView_BecomeActive_Params.Make(aFormType: TnsShowSynchroForm): ISynchroView_BecomeActive_Params;
var
 l_Inst : TSynchroView_BecomeActive_Params;
begin
 l_Inst := Create(aFormType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TSynchroView_BecomeActive_Params.Get_FormType: TnsShowSynchroForm;
 {-}
begin
 Result := f_FormType;
end;//TSynchroView_BecomeActive_Params.Get_FormType
// start class Op_SynchroView_BecomeActive

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmEntity;
  aFormType: TnsShowSynchroForm): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSynchroView_BecomeActive_Params.Make(aFormType));
  aTarget.Operation(TdmStdRes.opcode_SynchroView_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SynchroView_BecomeActive.Call

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmAggregate;
  aFormType: TnsShowSynchroForm): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSynchroView_BecomeActive_Params.Make(aFormType));
  aTarget.Operation(TdmStdRes.opcode_SynchroView_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_SynchroView_BecomeActive.Call

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmEntityForm;
  aFormType: TnsShowSynchroForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aFormType);
end;//Op_SynchroView_BecomeActive.Call

class function Op_SynchroView_BecomeActive.Call(const aTarget: IvcmContainer;
  aFormType: TnsShowSynchroForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aFormType);
end;//Op_SynchroView_BecomeActive.Call

type
 TList_GetDeList_Params = class(Tl3CProtoObject, IList_GetDeList_Params)
  {* Реализация IList_GetDeList_Params }
 private
 // private fields
   f_ResultValue : IdeList;
 protected
 // realized methods
   function Get_ResultValue: IdeList;
   procedure Set_ResultValue(const aValue: IdeList);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TList_GetDeList_Params }
   class function Make: IList_GetDeList_Params; reintroduce;
     {* Фабрика TList_GetDeList_Params }
 end;//TList_GetDeList_Params

// start class TList_GetDeList_Params

constructor TList_GetDeList_Params.Create;
 {-}
begin
 inherited Create;
end;//TList_GetDeList_Params.Create

class function TList_GetDeList_Params.Make: IList_GetDeList_Params;
var
 l_Inst : TList_GetDeList_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TList_GetDeList_Params.Get_ResultValue: IdeList;
 {-}
begin
 Result := f_ResultValue;
end;//TList_GetDeList_Params.Get_ResultValue

procedure TList_GetDeList_Params.Set_ResultValue(const aValue: IdeList);
 {-}
begin
 f_ResultValue := aValue;
end;//TList_GetDeList_Params.Set_ResultValue

procedure TList_GetDeList_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ResultValue := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TList_GetDeList_Params.ClearFields
// start class Op_List_GetDeList

class function Op_List_GetDeList.Call(const aTarget: IvcmEntity): IdeList;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TList_GetDeList_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_List_GetDeList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IList_GetDeList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_GetDeList.Call

class function Op_List_GetDeList.Call(const aTarget: IvcmAggregate): IdeList;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TList_GetDeList_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_List_GetDeList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IList_GetDeList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_GetDeList.Call

class function Op_List_GetDeList.Call(const aTarget: IvcmEntityForm): IdeList;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_List_GetDeList.Call

class function Op_List_GetDeList.Call(const aTarget: IvcmContainer): IdeList;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_List_GetDeList.Call
// start class Op_List_SetCurrentVisible

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_List_SetCurrentVisible, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_SetCurrentVisible.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_List_SetCurrentVisible, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_SetCurrentVisible.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_List_SetCurrentVisible.Call

class function Op_List_SetCurrentVisible.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_List_SetCurrentVisible.Call

type
 TList_GetDsList_Params = class(Tl3CProtoObject, IList_GetDsList_Params)
  {* Реализация IList_GetDsList_Params }
 private
 // private fields
   f_ResultValue : IdsList;
 protected
 // realized methods
   function Get_ResultValue: IdsList;
   procedure Set_ResultValue(const aValue: IdsList);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TList_GetDsList_Params }
   class function Make: IList_GetDsList_Params; reintroduce;
     {* Фабрика TList_GetDsList_Params }
 end;//TList_GetDsList_Params

// start class TList_GetDsList_Params

constructor TList_GetDsList_Params.Create;
 {-}
begin
 inherited Create;
end;//TList_GetDsList_Params.Create

class function TList_GetDsList_Params.Make: IList_GetDsList_Params;
var
 l_Inst : TList_GetDsList_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TList_GetDsList_Params.Get_ResultValue: IdsList;
 {-}
begin
 Result := f_ResultValue;
end;//TList_GetDsList_Params.Get_ResultValue

procedure TList_GetDsList_Params.Set_ResultValue(const aValue: IdsList);
 {-}
begin
 f_ResultValue := aValue;
end;//TList_GetDsList_Params.Set_ResultValue

procedure TList_GetDsList_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ResultValue := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TList_GetDsList_Params.ClearFields
// start class Op_List_GetDsList

class function Op_List_GetDsList.Call(const aTarget: IvcmEntity): IdsList;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TList_GetDsList_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_List_GetDsList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IList_GetDsList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_GetDsList.Call

class function Op_List_GetDsList.Call(const aTarget: IvcmAggregate): IdsList;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TList_GetDsList_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_List_GetDsList, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IList_GetDsList_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_List_GetDsList.Call

class function Op_List_GetDsList.Call(const aTarget: IvcmEntityForm): IdsList;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_List_GetDsList.Call

class function Op_List_GetDsList.Call(const aTarget: IvcmContainer): IdsList;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_List_GetDsList.Call
// start class Op_Form_RequestClose

class function Op_Form_RequestClose.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Form_RequestClose, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Form_RequestClose.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Form_RequestClose, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Form_RequestClose.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Form_RequestClose.Call

class function Op_Form_RequestClose.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Form_RequestClose.Call
// start class Op_ControlCenter_Refresh

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_ControlCenter_Refresh, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ControlCenter_Refresh.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_ControlCenter_Refresh, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ControlCenter_Refresh.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_ControlCenter_Refresh.Call

class function Op_ControlCenter_Refresh.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_ControlCenter_Refresh.Call
// start class Op_ListInfo_BecomeActive

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_ListInfo_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ListInfo_BecomeActive.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_ListInfo_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_ListInfo_BecomeActive.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_ListInfo_BecomeActive.Call

class function Op_ListInfo_BecomeActive.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_ListInfo_BecomeActive.Call
// start class Op_Filters_DeselectAll

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Filters_DeselectAll, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_DeselectAll.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Filters_DeselectAll, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_DeselectAll.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filters_DeselectAll.Call

class function Op_Filters_DeselectAll.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filters_DeselectAll.Call
// start class Op_TimeMachine_TimeMachineOnOff

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_TimeMachine_TimeMachineOnOff, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_TimeMachine_TimeMachineOnOff, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_TimeMachine_TimeMachineOnOff.Call

class function Op_TimeMachine_TimeMachineOnOff.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_TimeMachine_TimeMachineOnOff.Call
// start class Op_TimeMachine_TimeMachineOffAndReset

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_TimeMachine_TimeMachineOffAndReset, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_TimeMachine_TimeMachineOffAndReset, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

class function Op_TimeMachine_TimeMachineOffAndReset.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_TimeMachine_TimeMachineOffAndReset.Call

type
 TFilter_ActivateNode_Params = class(Tl3CProtoObject, IFilter_ActivateNode_Params)
  {* Реализация IFilter_ActivateNode_Params }
 private
 // private fields
   f_Node : Il3Node;
 protected
 // realized methods
   function Get_Node: Il3Node;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: Il3Node); reintroduce;
     {* Конструктор TFilter_ActivateNode_Params }
   class function Make(const aNode: Il3Node): IFilter_ActivateNode_Params; reintroduce;
     {* Фабрика TFilter_ActivateNode_Params }
 end;//TFilter_ActivateNode_Params

// start class TFilter_ActivateNode_Params

constructor TFilter_ActivateNode_Params.Create(const aNode: Il3Node);
 {-}
begin
 inherited Create;
 f_Node := aNode;
end;//TFilter_ActivateNode_Params.Create

class function TFilter_ActivateNode_Params.Make(const aNode: Il3Node): IFilter_ActivateNode_Params;
var
 l_Inst : TFilter_ActivateNode_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFilter_ActivateNode_Params.Get_Node: Il3Node;
 {-}
begin
 Result := f_Node;
end;//TFilter_ActivateNode_Params.Get_Node

procedure TFilter_ActivateNode_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFilter_ActivateNode_Params.ClearFields
// start class Op_Filter_ActivateNode

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmEntity;
  const aNode: Il3Node): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilter_ActivateNode_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_Filter_ActivateNode, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filter_ActivateNode.Call

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmAggregate;
  const aNode: Il3Node): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFilter_ActivateNode_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_Filter_ActivateNode, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filter_ActivateNode.Call

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmEntityForm;
  const aNode: Il3Node): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_Filter_ActivateNode.Call

class function Op_Filter_ActivateNode.Call(const aTarget: IvcmContainer;
  const aNode: Il3Node): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_Filter_ActivateNode.Call

type
 TFoldersControl_EditElement_Params = class(Tl3CProtoObject, IFoldersControl_EditElement_Params)
  {* Реализация IFoldersControl_EditElement_Params }
 private
 // private fields
   f_Node : IFoldersNode;
 protected
 // realized methods
   function Get_Node: IFoldersNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IFoldersNode); reintroduce;
     {* Конструктор TFoldersControl_EditElement_Params }
   class function Make(const aNode: IFoldersNode): IFoldersControl_EditElement_Params; reintroduce;
     {* Фабрика TFoldersControl_EditElement_Params }
 end;//TFoldersControl_EditElement_Params

// start class TFoldersControl_EditElement_Params

constructor TFoldersControl_EditElement_Params.Create(const aNode: IFoldersNode);
 {-}
begin
 inherited Create;
 f_Node := aNode;
end;//TFoldersControl_EditElement_Params.Create

class function TFoldersControl_EditElement_Params.Make(const aNode: IFoldersNode): IFoldersControl_EditElement_Params;
var
 l_Inst : TFoldersControl_EditElement_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFoldersControl_EditElement_Params.Get_Node: IFoldersNode;
 {-}
begin
 Result := f_Node;
end;//TFoldersControl_EditElement_Params.Get_Node

procedure TFoldersControl_EditElement_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFoldersControl_EditElement_Params.ClearFields
// start class Op_FoldersControl_EditElement

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmEntity;
  const aNode: IFoldersNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFoldersControl_EditElement_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_FoldersControl_EditElement, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FoldersControl_EditElement.Call

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmAggregate;
  const aNode: IFoldersNode): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFoldersControl_EditElement_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_FoldersControl_EditElement, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FoldersControl_EditElement.Call

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmEntityForm;
  const aNode: IFoldersNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_FoldersControl_EditElement.Call

class function Op_FoldersControl_EditElement.Call(const aTarget: IvcmContainer;
  const aNode: IFoldersNode): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_FoldersControl_EditElement.Call

type
 TFoldersControl_DeleteElement_Params = class(Tl3CProtoObject, IFoldersControl_DeleteElement_Params)
  {* Реализация IFoldersControl_DeleteElement_Params }
 private
 // private fields
   f_Node : IFoldersNode;
   f_ResultValue : TnsDeleteResult;
 protected
 // realized methods
   function Get_ResultValue: TnsDeleteResult;
   procedure Set_ResultValue(aValue: TnsDeleteResult);
   function Get_Node: IFoldersNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: IFoldersNode); reintroduce;
     {* Конструктор TFoldersControl_DeleteElement_Params }
   class function Make(const aNode: IFoldersNode): IFoldersControl_DeleteElement_Params; reintroduce;
     {* Фабрика TFoldersControl_DeleteElement_Params }
 end;//TFoldersControl_DeleteElement_Params

// start class TFoldersControl_DeleteElement_Params

constructor TFoldersControl_DeleteElement_Params.Create(const aNode: IFoldersNode);
 {-}
begin
 inherited Create;
 f_Node := aNode;
end;//TFoldersControl_DeleteElement_Params.Create

class function TFoldersControl_DeleteElement_Params.Make(const aNode: IFoldersNode): IFoldersControl_DeleteElement_Params;
var
 l_Inst : TFoldersControl_DeleteElement_Params;
begin
 l_Inst := Create(aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TFoldersControl_DeleteElement_Params.Get_ResultValue: TnsDeleteResult;
 {-}
begin
 Result := f_ResultValue;
end;//TFoldersControl_DeleteElement_Params.Get_ResultValue

procedure TFoldersControl_DeleteElement_Params.Set_ResultValue(aValue: TnsDeleteResult);
 {-}
begin
 f_ResultValue := aValue;
end;//TFoldersControl_DeleteElement_Params.Set_ResultValue

function TFoldersControl_DeleteElement_Params.Get_Node: IFoldersNode;
 {-}
begin
 Result := f_Node;
end;//TFoldersControl_DeleteElement_Params.Get_Node

procedure TFoldersControl_DeleteElement_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TFoldersControl_DeleteElement_Params.ClearFields
// start class Op_FoldersControl_DeleteElement

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmEntity;
  const aNode: IFoldersNode): TnsDeleteResult;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFoldersControl_DeleteElement_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_FoldersControl_DeleteElement, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFoldersControl_DeleteElement_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FoldersControl_DeleteElement.Call

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmAggregate;
  const aNode: IFoldersNode): TnsDeleteResult;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TFoldersControl_DeleteElement_Params.Make(aNode));
  aTarget.Operation(TdmStdRes.opcode_FoldersControl_DeleteElement, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IFoldersControl_DeleteElement_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_FoldersControl_DeleteElement.Call

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmEntityForm;
  const aNode: IFoldersNode): TnsDeleteResult;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode);
end;//Op_FoldersControl_DeleteElement.Call

class function Op_FoldersControl_DeleteElement.Call(const aTarget: IvcmContainer;
  const aNode: IFoldersNode): TnsDeleteResult;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode);
end;//Op_FoldersControl_DeleteElement.Call
// start class Op_Filters_InternalClear

class function Op_Filters_InternalClear.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Filters_InternalClear, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_InternalClear.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Filters_InternalClear, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Filters_InternalClear.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Filters_InternalClear.Call

class function Op_Filters_InternalClear.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Filters_InternalClear.Call

type
 TDocument_SetActive_Params = class(Tl3CProtoObject, IDocument_SetActive_Params)
  {* Реализация IDocument_SetActive_Params }
 private
 // private fields
   f_UserType : Integer;
 protected
 // realized methods
   function Get_UserType: Integer;
 public
 // public methods
   constructor Create(aUserType: Integer); reintroduce;
     {* Конструктор TDocument_SetActive_Params }
   class function Make(aUserType: Integer): IDocument_SetActive_Params; reintroduce;
     {* Фабрика TDocument_SetActive_Params }
 end;//TDocument_SetActive_Params

// start class TDocument_SetActive_Params

constructor TDocument_SetActive_Params.Create(aUserType: Integer);
 {-}
begin
 inherited Create;
 f_UserType := aUserType;
end;//TDocument_SetActive_Params.Create

class function TDocument_SetActive_Params.Make(aUserType: Integer): IDocument_SetActive_Params;
var
 l_Inst : TDocument_SetActive_Params;
begin
 l_Inst := Create(aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_SetActive_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_SetActive_Params.Get_UserType
// start class Op_Document_SetActive

class function Op_Document_SetActive.Call(const aTarget: IvcmEntity;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SetActive_Params.Make(aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_SetActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SetActive.Call

class function Op_Document_SetActive.Call(const aTarget: IvcmAggregate;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SetActive_Params.Make(aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_SetActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SetActive.Call

class function Op_Document_SetActive.Call(const aTarget: IvcmEntityForm;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aUserType);
end;//Op_Document_SetActive.Call

class function Op_Document_SetActive.Call(const aTarget: IvcmContainer;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aUserType);
end;//Op_Document_SetActive.Call

type
 TDocument_ExportBlock_Params = class(Tl3CProtoObject, IDocument_ExportBlock_Params)
  {* Реализация IDocument_ExportBlock_Params }
 private
 // private fields
   f_Data : IUnknown;
   f_UserType : Integer;
   f_ToActiveWindow : Boolean;
 protected
 // realized methods
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
   function Get_ToActiveWindow: Boolean;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean); reintroduce;
     {* Конструктор TDocument_ExportBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer;
    aToActiveWindow: Boolean): IDocument_ExportBlock_Params; reintroduce;
     {* Фабрика TDocument_ExportBlock_Params }
 end;//TDocument_ExportBlock_Params

// start class TDocument_ExportBlock_Params

constructor TDocument_ExportBlock_Params.Create(const aData: IUnknown;
  aUserType: Integer;
  aToActiveWindow: Boolean);
 {-}
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
 f_ToActiveWindow := aToActiveWindow;
end;//TDocument_ExportBlock_Params.Create

class function TDocument_ExportBlock_Params.Make(const aData: IUnknown;
  aUserType: Integer;
  aToActiveWindow: Boolean): IDocument_ExportBlock_Params;
var
 l_Inst : TDocument_ExportBlock_Params;
begin
 l_Inst := Create(aData, aUserType, aToActiveWindow);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_ExportBlock_Params.Get_Data: IUnknown;
 {-}
begin
 Result := f_Data;
end;//TDocument_ExportBlock_Params.Get_Data

function TDocument_ExportBlock_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_ExportBlock_Params.Get_UserType

function TDocument_ExportBlock_Params.Get_ToActiveWindow: Boolean;
 {-}
begin
 Result := f_ToActiveWindow;
end;//TDocument_ExportBlock_Params.Get_ToActiveWindow

procedure TDocument_ExportBlock_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_ExportBlock_Params.ClearFields
// start class Op_Document_ExportBlock

class function Op_Document_ExportBlock.Call(const aTarget: IvcmEntity;
  const aData: IUnknown;
  aUserType: Integer;
  aToActiveWindow: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ExportBlock_Params.Make(aData,aUserType,aToActiveWindow));
  aTarget.Operation(TdmStdRes.opcode_Document_ExportBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ExportBlock.Call

class function Op_Document_ExportBlock.Call(const aTarget: IvcmAggregate;
  const aData: IUnknown;
  aUserType: Integer;
  aToActiveWindow: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ExportBlock_Params.Make(aData,aUserType,aToActiveWindow));
  aTarget.Operation(TdmStdRes.opcode_Document_ExportBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ExportBlock.Call

class function Op_Document_ExportBlock.Call(const aTarget: IvcmEntityForm;
  const aData: IUnknown;
  aUserType: Integer;
  aToActiveWindow: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType, aToActiveWindow);
end;//Op_Document_ExportBlock.Call

class function Op_Document_ExportBlock.Call(const aTarget: IvcmContainer;
  const aData: IUnknown;
  aUserType: Integer;
  aToActiveWindow: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType, aToActiveWindow);
end;//Op_Document_ExportBlock.Call

type
 TDocument_GetCurrentPosition_Params = class(Tl3CProtoObject, IDocument_GetCurrentPosition_Params)
  {* Реализация IDocument_GetCurrentPosition_Params }
 private
 // private fields
   f_ResultValue : Integer;
 protected
 // realized methods
   function Get_ResultValue: Integer;
   procedure Set_ResultValue(aValue: Integer);
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TDocument_GetCurrentPosition_Params }
   class function Make: IDocument_GetCurrentPosition_Params; reintroduce;
     {* Фабрика TDocument_GetCurrentPosition_Params }
 end;//TDocument_GetCurrentPosition_Params

// start class TDocument_GetCurrentPosition_Params

constructor TDocument_GetCurrentPosition_Params.Create;
 {-}
begin
 inherited Create;
end;//TDocument_GetCurrentPosition_Params.Create

class function TDocument_GetCurrentPosition_Params.Make: IDocument_GetCurrentPosition_Params;
var
 l_Inst : TDocument_GetCurrentPosition_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_GetCurrentPosition_Params.Get_ResultValue: Integer;
 {-}
begin
 Result := f_ResultValue;
end;//TDocument_GetCurrentPosition_Params.Get_ResultValue

procedure TDocument_GetCurrentPosition_Params.Set_ResultValue(aValue: Integer);
 {-}
begin
 f_ResultValue := aValue;
end;//TDocument_GetCurrentPosition_Params.Set_ResultValue
// start class Op_Document_GetCurrentPosition

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmEntity): Integer;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GetCurrentPosition_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Document_GetCurrentPosition, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GetCurrentPosition_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GetCurrentPosition.Call

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmAggregate): Integer;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GetCurrentPosition_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Document_GetCurrentPosition, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GetCurrentPosition_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GetCurrentPosition.Call

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmEntityForm): Integer;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_GetCurrentPosition.Call

class function Op_Document_GetCurrentPosition.Call(const aTarget: IvcmContainer): Integer;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_GetCurrentPosition.Call

type
 TDocument_SelectBlock_Params = class(Tl3CProtoObject, IDocument_SelectBlock_Params)
  {* Реализация IDocument_SelectBlock_Params }
 private
 // private fields
   f_Data : IUnknown;
   f_UserType : Integer;
 protected
 // realized methods
   function Get_UserType: Integer;
   function Get_Data: IUnknown;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
     {* Конструктор TDocument_SelectBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_SelectBlock_Params; reintroduce;
     {* Фабрика TDocument_SelectBlock_Params }
 end;//TDocument_SelectBlock_Params

// start class TDocument_SelectBlock_Params

constructor TDocument_SelectBlock_Params.Create(const aData: IUnknown;
  aUserType: Integer);
 {-}
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_SelectBlock_Params.Create

class function TDocument_SelectBlock_Params.Make(const aData: IUnknown;
  aUserType: Integer): IDocument_SelectBlock_Params;
var
 l_Inst : TDocument_SelectBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_SelectBlock_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_SelectBlock_Params.Get_UserType

function TDocument_SelectBlock_Params.Get_Data: IUnknown;
 {-}
begin
 Result := f_Data;
end;//TDocument_SelectBlock_Params.Get_Data

procedure TDocument_SelectBlock_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_SelectBlock_Params.ClearFields
// start class Op_Document_SelectBlock

class function Op_Document_SelectBlock.Call(const aTarget: IvcmEntity;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SelectBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_SelectBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SelectBlock.Call

class function Op_Document_SelectBlock.Call(const aTarget: IvcmAggregate;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_SelectBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_SelectBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_SelectBlock.Call

class function Op_Document_SelectBlock.Call(const aTarget: IvcmEntityForm;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_SelectBlock.Call

class function Op_Document_SelectBlock.Call(const aTarget: IvcmContainer;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_SelectBlock.Call

type
 TDocument_CopyBlock_Params = class(Tl3CProtoObject, IDocument_CopyBlock_Params)
  {* Реализация IDocument_CopyBlock_Params }
 private
 // private fields
   f_Data : IUnknown;
   f_UserType : Integer;
 protected
 // realized methods
   function Get_UserType: Integer;
   function Get_Data: IUnknown;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
     {* Конструктор TDocument_CopyBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_CopyBlock_Params; reintroduce;
     {* Фабрика TDocument_CopyBlock_Params }
 end;//TDocument_CopyBlock_Params

// start class TDocument_CopyBlock_Params

constructor TDocument_CopyBlock_Params.Create(const aData: IUnknown;
  aUserType: Integer);
 {-}
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_CopyBlock_Params.Create

class function TDocument_CopyBlock_Params.Make(const aData: IUnknown;
  aUserType: Integer): IDocument_CopyBlock_Params;
var
 l_Inst : TDocument_CopyBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_CopyBlock_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_CopyBlock_Params.Get_UserType

function TDocument_CopyBlock_Params.Get_Data: IUnknown;
 {-}
begin
 Result := f_Data;
end;//TDocument_CopyBlock_Params.Get_Data

procedure TDocument_CopyBlock_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_CopyBlock_Params.ClearFields
// start class Op_Document_CopyBlock

class function Op_Document_CopyBlock.Call(const aTarget: IvcmEntity;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CopyBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_CopyBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_CopyBlock.Call

class function Op_Document_CopyBlock.Call(const aTarget: IvcmAggregate;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_CopyBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_CopyBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_CopyBlock.Call

class function Op_Document_CopyBlock.Call(const aTarget: IvcmEntityForm;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_CopyBlock.Call

class function Op_Document_CopyBlock.Call(const aTarget: IvcmContainer;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_CopyBlock.Call

type
 TDocument_PrintBlock_Params = class(Tl3CProtoObject, IDocument_PrintBlock_Params)
  {* Реализация IDocument_PrintBlock_Params }
 private
 // private fields
   f_Data : IUnknown;
   f_UserType : Integer;
 protected
 // realized methods
   function Get_UserType: Integer;
   function Get_Data: IUnknown;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
     {* Конструктор TDocument_PrintBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_PrintBlock_Params; reintroduce;
     {* Фабрика TDocument_PrintBlock_Params }
 end;//TDocument_PrintBlock_Params

// start class TDocument_PrintBlock_Params

constructor TDocument_PrintBlock_Params.Create(const aData: IUnknown;
  aUserType: Integer);
 {-}
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_PrintBlock_Params.Create

class function TDocument_PrintBlock_Params.Make(const aData: IUnknown;
  aUserType: Integer): IDocument_PrintBlock_Params;
var
 l_Inst : TDocument_PrintBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_PrintBlock_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_PrintBlock_Params.Get_UserType

function TDocument_PrintBlock_Params.Get_Data: IUnknown;
 {-}
begin
 Result := f_Data;
end;//TDocument_PrintBlock_Params.Get_Data

procedure TDocument_PrintBlock_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_PrintBlock_Params.ClearFields
// start class Op_Document_PrintBlock

class function Op_Document_PrintBlock.Call(const aTarget: IvcmEntity;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PrintBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_PrintBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PrintBlock.Call

class function Op_Document_PrintBlock.Call(const aTarget: IvcmAggregate;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PrintBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_PrintBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PrintBlock.Call

class function Op_Document_PrintBlock.Call(const aTarget: IvcmEntityForm;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_PrintBlock.Call

class function Op_Document_PrintBlock.Call(const aTarget: IvcmContainer;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_PrintBlock.Call

type
 TDocument_PrintDialogBlock_Params = class(Tl3CProtoObject, IDocument_PrintDialogBlock_Params)
  {* Реализация IDocument_PrintDialogBlock_Params }
 private
 // private fields
   f_Data : IUnknown;
   f_UserType : Integer;
 protected
 // realized methods
   function Get_UserType: Integer;
   function Get_Data: IUnknown;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
     {* Конструктор TDocument_PrintDialogBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_PrintDialogBlock_Params; reintroduce;
     {* Фабрика TDocument_PrintDialogBlock_Params }
 end;//TDocument_PrintDialogBlock_Params

// start class TDocument_PrintDialogBlock_Params

constructor TDocument_PrintDialogBlock_Params.Create(const aData: IUnknown;
  aUserType: Integer);
 {-}
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_PrintDialogBlock_Params.Create

class function TDocument_PrintDialogBlock_Params.Make(const aData: IUnknown;
  aUserType: Integer): IDocument_PrintDialogBlock_Params;
var
 l_Inst : TDocument_PrintDialogBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_PrintDialogBlock_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_PrintDialogBlock_Params.Get_UserType

function TDocument_PrintDialogBlock_Params.Get_Data: IUnknown;
 {-}
begin
 Result := f_Data;
end;//TDocument_PrintDialogBlock_Params.Get_Data

procedure TDocument_PrintDialogBlock_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_PrintDialogBlock_Params.ClearFields
// start class Op_Document_PrintDialogBlock

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmEntity;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PrintDialogBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_PrintDialogBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PrintDialogBlock.Call

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmAggregate;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PrintDialogBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_PrintDialogBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PrintDialogBlock.Call

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmEntityForm;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_PrintDialogBlock.Call

class function Op_Document_PrintDialogBlock.Call(const aTarget: IvcmContainer;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_PrintDialogBlock.Call

type
 TDocument_PreviewBlock_Params = class(Tl3CProtoObject, IDocument_PreviewBlock_Params)
  {* Реализация IDocument_PreviewBlock_Params }
 private
 // private fields
   f_Data : IUnknown;
   f_UserType : Integer;
 protected
 // realized methods
   function Get_Data: IUnknown;
   function Get_UserType: Integer;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aData: IUnknown;
    aUserType: Integer); reintroduce;
     {* Конструктор TDocument_PreviewBlock_Params }
   class function Make(const aData: IUnknown;
    aUserType: Integer): IDocument_PreviewBlock_Params; reintroduce;
     {* Фабрика TDocument_PreviewBlock_Params }
 end;//TDocument_PreviewBlock_Params

// start class TDocument_PreviewBlock_Params

constructor TDocument_PreviewBlock_Params.Create(const aData: IUnknown;
  aUserType: Integer);
 {-}
begin
 inherited Create;
 f_Data := aData;
 f_UserType := aUserType;
end;//TDocument_PreviewBlock_Params.Create

class function TDocument_PreviewBlock_Params.Make(const aData: IUnknown;
  aUserType: Integer): IDocument_PreviewBlock_Params;
var
 l_Inst : TDocument_PreviewBlock_Params;
begin
 l_Inst := Create(aData, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_PreviewBlock_Params.Get_Data: IUnknown;
 {-}
begin
 Result := f_Data;
end;//TDocument_PreviewBlock_Params.Get_Data

function TDocument_PreviewBlock_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_PreviewBlock_Params.Get_UserType

procedure TDocument_PreviewBlock_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Data := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_PreviewBlock_Params.ClearFields
// start class Op_Document_PreviewBlock

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmEntity;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PreviewBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_PreviewBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PreviewBlock.Call

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmAggregate;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_PreviewBlock_Params.Make(aData,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_PreviewBlock, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_PreviewBlock.Call

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmEntityForm;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aData, aUserType);
end;//Op_Document_PreviewBlock.Call

class function Op_Document_PreviewBlock.Call(const aTarget: IvcmContainer;
  const aData: IUnknown;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aData, aUserType);
end;//Op_Document_PreviewBlock.Call

type
 TDocument_ShowRespondentListToPart_Params = class(Tl3CProtoObject, IDocument_ShowRespondentListToPart_Params)
  {* Реализация IDocument_ShowRespondentListToPart_Params }
 private
 // private fields
   f_List : IPositionList;
   f_Current : Il3SimpleNode;
 protected
 // realized methods
   function Get_Current: Il3SimpleNode;
   function Get_List: IPositionList;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aList: IPositionList;
    const aCurrent: Il3SimpleNode); reintroduce;
     {* Конструктор TDocument_ShowRespondentListToPart_Params }
   class function Make(const aList: IPositionList;
    const aCurrent: Il3SimpleNode): IDocument_ShowRespondentListToPart_Params; reintroduce;
     {* Фабрика TDocument_ShowRespondentListToPart_Params }
 end;//TDocument_ShowRespondentListToPart_Params

// start class TDocument_ShowRespondentListToPart_Params

constructor TDocument_ShowRespondentListToPart_Params.Create(const aList: IPositionList;
  const aCurrent: Il3SimpleNode);
 {-}
begin
 inherited Create;
 f_List := aList;
 f_Current := aCurrent;
end;//TDocument_ShowRespondentListToPart_Params.Create

class function TDocument_ShowRespondentListToPart_Params.Make(const aList: IPositionList;
  const aCurrent: Il3SimpleNode): IDocument_ShowRespondentListToPart_Params;
var
 l_Inst : TDocument_ShowRespondentListToPart_Params;
begin
 l_Inst := Create(aList, aCurrent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_ShowRespondentListToPart_Params.Get_Current: Il3SimpleNode;
 {-}
begin
 Result := f_Current;
end;//TDocument_ShowRespondentListToPart_Params.Get_Current

function TDocument_ShowRespondentListToPart_Params.Get_List: IPositionList;
 {-}
begin
 Result := f_List;
end;//TDocument_ShowRespondentListToPart_Params.Get_List

procedure TDocument_ShowRespondentListToPart_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_List := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Current := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_ShowRespondentListToPart_Params.ClearFields
// start class Op_Document_ShowRespondentListToPart

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmEntity;
  const aList: IPositionList;
  const aCurrent: Il3SimpleNode = nil): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ShowRespondentListToPart_Params.Make(aList,aCurrent));
  aTarget.Operation(TdmStdRes.opcode_Document_ShowRespondentListToPart, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ShowRespondentListToPart.Call

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmAggregate;
  const aList: IPositionList;
  const aCurrent: Il3SimpleNode = nil): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ShowRespondentListToPart_Params.Make(aList,aCurrent));
  aTarget.Operation(TdmStdRes.opcode_Document_ShowRespondentListToPart, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ShowRespondentListToPart.Call

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmEntityForm;
  const aList: IPositionList;
  const aCurrent: Il3SimpleNode = nil): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aList, aCurrent);
end;//Op_Document_ShowRespondentListToPart.Call

class function Op_Document_ShowRespondentListToPart.Call(const aTarget: IvcmContainer;
  const aList: IPositionList;
  const aCurrent: Il3SimpleNode = nil): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aList, aCurrent);
end;//Op_Document_ShowRespondentListToPart.Call

type
 TDocument_ShowCorrespondentListToPart_Params = class(Tl3CProtoObject, IDocument_ShowCorrespondentListToPart_Params)
  {* Реализация IDocument_ShowCorrespondentListToPart_Params }
 private
 // private fields
   f_List : IPositionList;
   f_Current : Il3SimpleNode;
 protected
 // realized methods
   function Get_Current: Il3SimpleNode;
   function Get_List: IPositionList;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aList: IPositionList;
    const aCurrent: Il3SimpleNode); reintroduce;
     {* Конструктор TDocument_ShowCorrespondentListToPart_Params }
   class function Make(const aList: IPositionList;
    const aCurrent: Il3SimpleNode): IDocument_ShowCorrespondentListToPart_Params; reintroduce;
     {* Фабрика TDocument_ShowCorrespondentListToPart_Params }
 end;//TDocument_ShowCorrespondentListToPart_Params

// start class TDocument_ShowCorrespondentListToPart_Params

constructor TDocument_ShowCorrespondentListToPart_Params.Create(const aList: IPositionList;
  const aCurrent: Il3SimpleNode);
 {-}
begin
 inherited Create;
 f_List := aList;
 f_Current := aCurrent;
end;//TDocument_ShowCorrespondentListToPart_Params.Create

class function TDocument_ShowCorrespondentListToPart_Params.Make(const aList: IPositionList;
  const aCurrent: Il3SimpleNode): IDocument_ShowCorrespondentListToPart_Params;
var
 l_Inst : TDocument_ShowCorrespondentListToPart_Params;
begin
 l_Inst := Create(aList, aCurrent);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_ShowCorrespondentListToPart_Params.Get_Current: Il3SimpleNode;
 {-}
begin
 Result := f_Current;
end;//TDocument_ShowCorrespondentListToPart_Params.Get_Current

function TDocument_ShowCorrespondentListToPart_Params.Get_List: IPositionList;
 {-}
begin
 Result := f_List;
end;//TDocument_ShowCorrespondentListToPart_Params.Get_List

procedure TDocument_ShowCorrespondentListToPart_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_List := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Current := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_ShowCorrespondentListToPart_Params.ClearFields
// start class Op_Document_ShowCorrespondentListToPart

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmEntity;
  const aList: IPositionList;
  const aCurrent: Il3SimpleNode = nil): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ShowCorrespondentListToPart_Params.Make(aList,aCurrent));
  aTarget.Operation(TdmStdRes.opcode_Document_ShowCorrespondentListToPart, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ShowCorrespondentListToPart.Call

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmAggregate;
  const aList: IPositionList;
  const aCurrent: Il3SimpleNode = nil): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ShowCorrespondentListToPart_Params.Make(aList,aCurrent));
  aTarget.Operation(TdmStdRes.opcode_Document_ShowCorrespondentListToPart, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ShowCorrespondentListToPart.Call

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmEntityForm;
  const aList: IPositionList;
  const aCurrent: Il3SimpleNode = nil): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aList, aCurrent);
end;//Op_Document_ShowCorrespondentListToPart.Call

class function Op_Document_ShowCorrespondentListToPart.Call(const aTarget: IvcmContainer;
  const aList: IPositionList;
  const aCurrent: Il3SimpleNode = nil): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aList, aCurrent);
end;//Op_Document_ShowCorrespondentListToPart.Call

type
 TDocument_ModifyBookmarkNotify_Params = class(Tl3CProtoObject, IDocument_ModifyBookmarkNotify_Params)
  {* Реализация IDocument_ModifyBookmarkNotify_Params }
 private
 // private fields
   f_nEntity : IUnknown;
 protected
 // realized methods
   function Get_NEntity: IUnknown;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const anEntity: IUnknown); reintroduce;
     {* Конструктор TDocument_ModifyBookmarkNotify_Params }
   class function Make(const anEntity: IUnknown): IDocument_ModifyBookmarkNotify_Params; reintroduce;
     {* Фабрика TDocument_ModifyBookmarkNotify_Params }
 end;//TDocument_ModifyBookmarkNotify_Params

// start class TDocument_ModifyBookmarkNotify_Params

constructor TDocument_ModifyBookmarkNotify_Params.Create(const anEntity: IUnknown);
 {-}
begin
 inherited Create;
 f_nEntity := anEntity;
end;//TDocument_ModifyBookmarkNotify_Params.Create

class function TDocument_ModifyBookmarkNotify_Params.Make(const anEntity: IUnknown): IDocument_ModifyBookmarkNotify_Params;
var
 l_Inst : TDocument_ModifyBookmarkNotify_Params;
begin
 l_Inst := Create(anEntity);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_ModifyBookmarkNotify_Params.Get_NEntity: IUnknown;
 {-}
begin
 Result := f_nEntity;
end;//TDocument_ModifyBookmarkNotify_Params.Get_NEntity

procedure TDocument_ModifyBookmarkNotify_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_nEntity := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_ModifyBookmarkNotify_Params.ClearFields
// start class Op_Document_ModifyBookmarkNotify

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmEntity;
  const anEntity: IUnknown): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ModifyBookmarkNotify_Params.Make(anEntity));
  aTarget.Operation(TdmStdRes.opcode_Document_ModifyBookmarkNotify, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ModifyBookmarkNotify.Call

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmAggregate;
  const anEntity: IUnknown): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ModifyBookmarkNotify_Params.Make(anEntity));
  aTarget.Operation(TdmStdRes.opcode_Document_ModifyBookmarkNotify, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_ModifyBookmarkNotify.Call

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmEntityForm;
  const anEntity: IUnknown): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, anEntity);
end;//Op_Document_ModifyBookmarkNotify.Call

class function Op_Document_ModifyBookmarkNotify.Call(const aTarget: IvcmContainer;
  const anEntity: IUnknown): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, anEntity);
end;//Op_Document_ModifyBookmarkNotify.Call

class procedure Op_Document_ModifyBookmarkNotify.Broadcast(const anEntity: IUnknown);
var
 l_Params : IvcmExecuteParams;
begin
 if (vcmDispatcher <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_ModifyBookmarkNotify_Params.Make(anEntity));
  vcmDispatcher.EntityOperationBroadcast(TdmStdRes.opcode_Document_ModifyBookmarkNotify, l_Params);
 end;//vcmDispatcher <> nil
end;//Op_Document_ModifyBookmarkNotify.Broadcast

type
 TDocument_AddBookmarkFromContents_Params = class(Tl3CProtoObject, IDocument_AddBookmarkFromContents_Params)
  {* Реализация IDocument_AddBookmarkFromContents_Params }
 private
 // private fields
   f_Tag : Il3TagRef;
 protected
 // realized methods
   function Get_Tag: Il3TagRef;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aTag: Il3TagRef); reintroduce;
     {* Конструктор TDocument_AddBookmarkFromContents_Params }
   class function Make(const aTag: Il3TagRef): IDocument_AddBookmarkFromContents_Params; reintroduce;
     {* Фабрика TDocument_AddBookmarkFromContents_Params }
 end;//TDocument_AddBookmarkFromContents_Params

// start class TDocument_AddBookmarkFromContents_Params

constructor TDocument_AddBookmarkFromContents_Params.Create(const aTag: Il3TagRef);
 {-}
begin
 inherited Create;
 f_Tag := aTag;
end;//TDocument_AddBookmarkFromContents_Params.Create

class function TDocument_AddBookmarkFromContents_Params.Make(const aTag: Il3TagRef): IDocument_AddBookmarkFromContents_Params;
var
 l_Inst : TDocument_AddBookmarkFromContents_Params;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_AddBookmarkFromContents_Params.Get_Tag: Il3TagRef;
 {-}
begin
 Result := f_Tag;
end;//TDocument_AddBookmarkFromContents_Params.Get_Tag

procedure TDocument_AddBookmarkFromContents_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Tag := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_AddBookmarkFromContents_Params.ClearFields
// start class Op_Document_AddBookmarkFromContents

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmEntity;
  const aTag: Il3TagRef): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_AddBookmarkFromContents_Params.Make(aTag));
  aTarget.Operation(TdmStdRes.opcode_Document_AddBookmarkFromContents, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmAggregate;
  const aTag: Il3TagRef): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_AddBookmarkFromContents_Params.Make(aTag));
  aTarget.Operation(TdmStdRes.opcode_Document_AddBookmarkFromContents, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmEntityForm;
  const aTag: Il3TagRef): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aTag);
end;//Op_Document_AddBookmarkFromContents.Call

class function Op_Document_AddBookmarkFromContents.Call(const aTarget: IvcmContainer;
  const aTag: Il3TagRef): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aTag);
end;//Op_Document_AddBookmarkFromContents.Call
// start class Op_Document_OpenNotSureTopic

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmEntity): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Document_OpenNotSureTopic, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenNotSureTopic.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmAggregate): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Document_OpenNotSureTopic, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_OpenNotSureTopic.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Document_OpenNotSureTopic.Call

class function Op_Document_OpenNotSureTopic.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Document_OpenNotSureTopic.Call

type
 TDocument_GotoPara_Params = class(Tl3CProtoObject, IDocument_GotoPara_Params)
  {* Реализация IDocument_GotoPara_Params }
 private
 // private fields
   f_Para : Il3TagRef;
   f_UserType : Integer;
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_UserType: Integer;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   function Get_Para: Il3TagRef;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aPara: Il3TagRef;
    aUserType: Integer); reintroduce;
     {* Конструктор TDocument_GotoPara_Params }
   class function Make(const aPara: Il3TagRef;
    aUserType: Integer): IDocument_GotoPara_Params; reintroduce;
     {* Фабрика TDocument_GotoPara_Params }
 end;//TDocument_GotoPara_Params

// start class TDocument_GotoPara_Params

constructor TDocument_GotoPara_Params.Create(const aPara: Il3TagRef;
  aUserType: Integer);
 {-}
begin
 inherited Create;
 f_Para := aPara;
 f_UserType := aUserType;
end;//TDocument_GotoPara_Params.Create

class function TDocument_GotoPara_Params.Make(const aPara: Il3TagRef;
  aUserType: Integer): IDocument_GotoPara_Params;
var
 l_Inst : TDocument_GotoPara_Params;
begin
 l_Inst := Create(aPara, aUserType);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TDocument_GotoPara_Params.Get_UserType: Integer;
 {-}
begin
 Result := f_UserType;
end;//TDocument_GotoPara_Params.Get_UserType

function TDocument_GotoPara_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TDocument_GotoPara_Params.Get_ResultValue

procedure TDocument_GotoPara_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TDocument_GotoPara_Params.Set_ResultValue

function TDocument_GotoPara_Params.Get_Para: Il3TagRef;
 {-}
begin
 Result := f_Para;
end;//TDocument_GotoPara_Params.Get_Para

procedure TDocument_GotoPara_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Para := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TDocument_GotoPara_Params.ClearFields
// start class Op_Document_GotoPara

class function Op_Document_GotoPara.Call(const aTarget: IvcmEntity;
  const aPara: Il3TagRef;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GotoPara_Params.Make(aPara,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_GotoPara, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GotoPara_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GotoPara.Call

class function Op_Document_GotoPara.Call(const aTarget: IvcmAggregate;
  const aPara: Il3TagRef;
  aUserType: Integer): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TDocument_GotoPara_Params.Make(aPara,aUserType));
  aTarget.Operation(TdmStdRes.opcode_Document_GotoPara, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IDocument_GotoPara_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Document_GotoPara.Call

class function Op_Document_GotoPara.Call(const aTarget: IvcmEntityForm;
  const aPara: Il3TagRef;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aPara, aUserType);
end;//Op_Document_GotoPara.Call

class function Op_Document_GotoPara.Call(const aTarget: IvcmContainer;
  const aPara: Il3TagRef;
  aUserType: Integer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aPara, aUserType);
end;//Op_Document_GotoPara.Call
{$IfEnd} //not Admin AND not Monitorings


end.