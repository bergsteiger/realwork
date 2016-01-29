unit CustomizeTasksPanel_Form;
{* Форма настройки "Панели задач". }

{ Библиотека : "vcm"                    }
{ Автор      : Морозов М.А.             }
{ Модуль     : vcmCustomizeTasksPanel - }
{ Начат      : 26.02.2007               }
{ $Id: CustomizeTasksPanel_Form.pas,v 1.18 2015/10/09 14:48:32 kostitsin Exp $ }

// $Log: CustomizeTasksPanel_Form.pas,v $
// Revision 1.18  2015/10/09 14:48:32  kostitsin
// {requestlink: 604917289 } - инициализируем неинициализированное
//
// Revision 1.17  2015/07/10 10:09:47  kostitsin
// {requestlink: 127042272 } - грохнул ещё один _TvcmInterfaceList.
//
// Revision 1.16  2015/04/23 10:10:45  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=596627087&focusedCommentId=597929314#comment-597929314
//
// Revision 1.15  2015/04/06 17:20:47  lulin
// - возвращаем назад.
//
// Revision 1.14  2015/04/06 17:12:55  lulin
// - возвращаем назад.
//
// Revision 1.13  2015/04/06 17:11:23  lulin
// - возвращаем назад.
//
// Revision 1.12  2015/04/06 15:03:51  lulin
// - правим за коллегой.
//
// Revision 1.11  2013/11/13 07:36:45  morozov
// {RequestLink: 499509792}
//
// Revision 1.10  2013/11/11 15:21:11  lulin
// - вычищаем устаревший код.
//
// Revision 1.9  2013/08/05 12:21:56  morozov
// {RequestLink:471774446}
//
// Revision 1.8  2013/07/26 10:32:27  morozov
// {RequestLink: 471774401}
//
// Revision 1.7  2013/01/22 15:51:51  kostitsin
// [$424399029]
//
// Revision 1.6  2012/10/30 11:25:50  kostitsin
// В Tl3CustomTreeView вынес реализацию CompareChild в DoCompareChild
//
// Revision 1.5  2012/03/02 09:42:03  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=342336964
//
// Revision 1.4  2011/06/28 19:18:19  lulin
// {RequestLink:254944102}.
//
// Revision 1.3  2011/06/28 17:51:58  lulin
// {RequestLink:254944102}.
//
// Revision 1.2  2011/06/23 17:01:23  lulin
// {RequestLink:254944102}.
//
// Revision 1.1  2010/09/13 17:40:12  lulin
// {RequestLink:235047275}.
//
// Revision 1.41  2009/02/12 13:33:58  lulin
// - <K>: 135604584. Выделен новый интерфейсный модуль.
//
// Revision 1.40  2008/12/12 19:19:25  lulin
// - <K>: 129762414.
//
// Revision 1.39  2008/08/05 12:46:40  mmorozov
// - bugfix: при удалении группы, операции не удалялись (в рамках работы над K<105250942>);
//
// Revision 1.38  2008/07/25 08:02:27  mmorozov
// - new: при сохранении доступных для выбора на панель инструментов  операций, сохраняем во все конфигурации (K<104432072>);
//
// Revision 1.37  2008/06/25 12:34:04  mmorozov
// - new: Оптимизация панелей инструментов ... Сортируем операции  (CQ: OIT5-28281);
//
// Revision 1.36  2008/06/25 11:23:44  mmorozov
// - new: Оптимизация панелей инструментов ... Список форм при настройке доступных операций  (CQ: OIT5-28281);
//
// Revision 1.35  2008/06/25 09:24:06  mmorozov
// - new: Оптимизация панелей инструментов ---|> в списке доступных форм показываем только объединенные панели инструментов + рефакторинг + список форм проекта при редактировании доступных для выбора операций (CQ: OIT5-28281);
//
// Revision 1.34  2008/06/05 13:05:19  mmorozov
// Оптимизация панелей инструментов (CQ: OIT5-28281):
// - одинаковая настройка для объединенных панелей инструментов.
// - доступность операций в контекстном меню панели инструментов.
// - идентфикатор для формы включает не только имя типа но и имя формы.
//
// Revision 1.33  2008/06/04 10:51:15  mmorozov
// - new: возможность найстройки доступных для редактирования панели инструментов операций (CQ: OIT5-28281);
//
// Revision 1.32  2007/07/18 09:35:29  oman
// Warning fix
//
// Revision 1.31  2007/06/26 10:13:46  mmorozov
// - new behaviour: в списке доступных операций отображаем названия по умолчанию для операций, при переносе доступной операции в панель задач ей присваивается пользовательское название, если установлено (CQ: OIT5-25764);
//
// Revision 1.30  2007/06/26 09:41:41  mmorozov
// - new behaviour: управление состоянием операции представления панели задач (CQ: OIT5-25474);
//
// Revision 1.29  2007/06/18 11:15:06  mmorozov
// - new behaviour: в репозитории показываеются уже измененные пользовательские названия операций + к имени операции добавляется название сущности (CQ: OIT5-25697);
//
// Revision 1.28  2007/06/13 09:01:25  mmorozov
// - new behaviour: сортируем операции/группы, в панели задач они теперь хранятья в несортированном виде (в рамках задачи CQ: OIT5-25626);
//
// Revision 1.27  2007/06/08 07:43:10  mmorozov
// - new behaviour: удаляем группы без операций при сохранении;
// - new behaviour: не удаляем группу при редактировании в случае если удаляется последняя операция группы;
//
// Revision 1.26  2007/06/08 06:30:43  mmorozov
// - opt: там где это необходимо итерируем только первый уровень узлов;
// - bugfix: при удалении группы из панели задач, обновляем позиции групп;
//
// Revision 1.25  2007/06/07 14:03:23  mmorozov
// - bugfix: при добавлении/удалении операции не обновляли позиции операций группы (CQ: OIT5-25626);
//
// Revision 1.24  2007/06/05 14:22:20  mmorozov
// - change: названиям классов добавлен префикc библиотеки;
//
// Revision 1.23  2007/06/05 14:10:11  mmorozov
// - bugfix: не инициализировалась позиция группы (в рамках работы над CQ: OIT5-25344);
//
// Revision 1.22  2007/06/05 10:05:53  mmorozov
// - change: свойства и методы переименованы в соответствии с назначением;
//
// Revision 1.21  2007/04/04 07:32:53  mmorozov
// - bugfix; при добавлении новой группы не обновляли позиции существующих;
//
// Revision 1.20  2007/03/29 13:54:10  mmorozov
// - new: устанавливаем элемент текущим при переносе в деревья;
// - new: очищаем поле имя при переносе группы из репозитория;
//
// Revision 1.19  2007/03/29 13:40:16  mmorozov
// - new behaviour: используем всегда маленькие иконки;
//
// Revision 1.18  2007/03/28 14:30:30  mmorozov
// - bugfix: при создании группы не устанавливалась позиция;
//
// Revision 1.17  2007/03/27 07:41:58  mmorozov
// - удален checkbox "панель задач по умолчанию";
//
// Revision 1.16  2007/03/23 12:56:15  mmorozov
// - в рамках работы над представлением панели задач, представление обновляет своё содержимое при изменении данных;
//
// Revision 1.15  2007/03/22 12:12:11  mmorozov
// - new: флажок панель задач по умолчанию;
//
// Revision 1.14  2007/03/21 15:56:54  mmorozov
// - new: выделены общие интерфейсы\классы для элементов панели задач в редакторе и компоненте;
// - new: определение позиции группы в панели задач;
//
// Revision 1.13  2007/03/21 12:22:01  mmorozov
// - new: работа с признаком операции "Для всех панелей задач";
//
// Revision 1.12  2007/03/21 11:30:08  mmorozov
// - bugfix: при удалении новой операции не помещаем в список удаленных; не устанавливаем при перемещении признак группа изменена для новой операции; не сортируем элементы дерева панели задач, там позиции;
//
// Revision 1.11  2007/03/20 15:27:06  mmorozov
// - new: изменение позиций операций\групп;
//
// Revision 1.10  2007/03/20 09:30:27  mmorozov
// - new: используем Caption операции панели задач, а не операции репозитория;
// - new: редактирование названий групп\операций панели задач;
//
// Revision 1.9  2007/03/19 13:46:50  mmorozov
// - new: данные репозитория показываем в сортированном виде;
//
// Revision 1.8  2007/03/19 13:15:03  mmorozov
// - new: удаление операций (групп) из панели задач;
//
// Revision 1.7  2007/03/19 06:36:22  mmorozov
// - обновление состава операций панели задач при смене форм;
//
// Revision 1.6  2007/03/15 07:08:55  mmorozov
// - в рамках работы над панелью задач;
//
// Revision 1.5  2007/03/14 06:53:29  mmorozov
// - new: у каждой главной формы свой компонент панели задач;
//
// Revision 1.4  2007/03/07 14:04:01  mmorozov
// - new: работа с деревом операций панели задач, управление состоянием контролов;
//
// Revision 1.3  2007/03/07 12:03:49  mmorozov
// - new: сохранение, загрузка, редактирования групп репозитория;
//
// Revision 1.2  2007/03/06 14:27:20  mmorozov
// - change: вместо Tl3PCharLen используем Il3CString;
//
// Revision 1.1  2007/03/06 13:35:54  mmorozov
// - new: панель задач;
//

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Buttons,
  ImgList,

  afwInputControl,
  afwControl,

  l3TreeInterfaces,
  l3Tree_TLB,
  l3IID,

  vtPanel,
  vtGroupBox,
  vtCtrls,
  vtLister,
  vtOutliner,
  vtOutlinerWithQuickSearch,
  vtOutlinerWithDragDrop,
  vtLabel,

  OvcBase,

  eeTreeViewExport,
  eeTreeView,
  eeCheckBox,
  eeButton,

  vcmInterfaces,
  vcmBase,
  vcmEntityForm,
  vcmEntities,
  vcmComponent,
  vcmBaseEntities, afwControlPrim, afwBaseControl, afwTextControlPrim,
  afwTextControl,

  vcmTaskPanelInterfaces,
  l3InterfacedComponent,

  PrimCustomizeTasksPanel_Form,

  vcmUserTypeDescr,
  
  vtButton,
  vtComboBoxQS,

  vcmCustOpsRepGroupList,
  l3NodeList
  ;

type
  TCustomizeTasksPanelForm = class(TvcmEntityFormRef)
    Entities : TvcmEntities;
    pnlBottom: TvtPanel;
    btOk: TvtButton;
    btCancel: TvtButton;
    btApply: TvtButton;
    pnlLeft: TvtPanel;
    btnMoveOpToPanel: TBitBtn;
    btnMoveOpToRep: TBitBtn;
    pnlTasksPanel: TvtPanel;
    gbTasksPanel: TvtGroupBox;
    tvTasksPanel: TeeTreeView;
    pnlOperationPos: TvtPanel;
    UpBitBtn: TBitBtn;
    DownBitBtn: TBitBtn;
    spRight: TvtSplitter;
    pnlRep: TvtPanel;
    gbAvailableOperations: TvtGroupBox;
    tvRepOps: TeeTreeView;
    gbAvailableGroups: TvtGroupBox;
    tvRepGroups: TeeTreeView;
    vtPanel1: TvtPanel;
    cbGroupName: TvtComboBox;
    btnAddGroup: TeeButton;
    btnMoveGroupToPanel: TBitBtn;
    btnMoveGroupToRep: TBitBtn;
    vtGroupBox3: TvtGroupBox;
    lblCaption: TvtLabel;
    edChange: TvtComboBox;
    cbForAllUseCases: TeeCheckBox;
    splRep: TvtSplitter;
    btnChangeGroup: TeeButton;
    btnChangeItem: TeeButton;
    btnDeleteGroup: TeeButton;
    pnlForms: TvtPanel;
    cbForms: TComboBox;
    lblForms: TvtLabel;
    lblConfirmSave: TvtLabel;
    lblAvailableOpsCaption: TvtLabel;
    pnlMain: TvtPanel;
    function tvRepOpsGetItemImage(Sender: TObject; Index: Integer;
      var aImages: TCustomImageList): Integer;
    procedure cbGroupNameChange(Sender: TObject);
    procedure btnAddGroupClick(Sender: TObject);
    procedure tvRepGroupsMakeTreeSource(out theTree: Il3SimpleTree);
    procedure btnChangeGroupClick(Sender: TObject);
    procedure tvRepGroupsCurrentChanged(Sender: TObject; aNewCurrent,
      aOldCurrent: Integer);
    procedure btnDeleteGroupClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btApplyClick(Sender: TObject);
    procedure btnMoveGroupToPanelClick(Sender: TObject);
    procedure tvRepOpsCurrentChanged(Sender: TObject; aNewCurrent,
      aOldCurrent: Integer);
    procedure tvTasksPanelCurrentChanged(Sender: TObject; aNewCurrent,
      aOldCurrent: Integer);
    procedure btnMoveOpToPanelClick(Sender: TObject);
    function tvTasksPanelGetItemImage(Sender: TObject; Index: Integer;
      var aImages: TCustomImageList): Integer;
    procedure btnChangeItemClick(Sender: TObject);
    procedure btnMoveGroupToRepClick(Sender: TObject);
    procedure btnMoveOpToRepClick(Sender: TObject);
    procedure cbForAllUseCasesClick(Sender: TObject);
    procedure UpBitBtnClick(Sender: TObject);
    procedure DownBitBtnClick(Sender: TObject);
    procedure cbFormsChange(Sender: TObject);
    procedure vcmEntityFormInit;
  private
  // fields
    f_DeleteGroups     : TvcmCustOpsRepGroupList;
    f_DeleteOperations : Tl3NodeList;
    f_TasksPanel       : IvcmCustOps;
    f_IsChanged        : Boolean;
    f_UserTypeDescrList: TvcmUserTypeDescrList;
  private
  // property methods
    function pm_GetDeleteGroups: TvcmCustOpsRepGroupList;
      {-}
    function pm_GetDeleteOperations: Tl3NodeList;
      {-}
    function pm_GetTasksPanel: IvcmCustOps; override;
    procedure pm_SetTasksPanel(const Value: IvcmCustOps); override;
      {-}
    procedure pm_SetIsChanged(const Value: Boolean);
      {-}
  private
  // properties
    property DeleteGroups: TvcmCustOpsRepGroupList
      read pm_GetDeleteGroups;
      {-}
    property DeleteOperations: Tl3NodeList
      read pm_GetDeleteOperations;
      {-}
    property IsChanged: Boolean
      read f_IsChanged
      write pm_SetIsChanged;
      {-}
  private
  // methods
    procedure UpdateState;
      {-}
    procedure Save;
      {-}
    function FindRepGroupOps(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
      {-}
    procedure UpdateControls;
      {-}
    procedure MoveTasksPanelItem(const aUp        : Boolean;
                                 const aNewParent : Il3Node);
      {-}
    procedure UpdatePositions(const aParent: Il3Node);
      {-}
    procedure RemoveGroup(const aGroup: Il3Node);
      {* - удалить группу панели задач. }
    procedure RemoveNode(const aNode: Il3Node);
      {* - удалить узел панели задач, без относительно операция это или
           группа. }
    procedure DeleteOp(const aNode: Il3Node);
      {* - удалить операцию панели задач. }
    procedure ReturnRepOp(const aRepOp: IvcmCustOpsRepOperation);
      {* - вернуть операцию в репозиторий. }
    function GetSelectedUserType: IvcmUserTypeDef;
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  end;//TCustomizeTasksPanelForm

implementation

{$R *.DFM}

uses
  ActnList,

  l3Interfaces,
  l3Nodes,
  l3Tree,
  l3String,
  l3Types,
  l3Base,

  afwFacade,
  afwInterfaces,

  vcmBaseMenuManager,
  vcmMenuManager,
  vcmCustomizeUtils,
  vcmCustomizeAvailableToolbarOps,
  vcmSettings,
  vcmForm,
  vcmMessagesSupport,
  vcmContainerForm,
  vcmStringList,

  l3MessageID
  ;

var
 g_TasksPanel: IvcmCustOps;
  // - устанавливается на время открытия формы, для использования в классах
  //   модуля;

type
  TtpState = (sNone, sNew, sChange, sDelete);
   {* Состояние узла. }

  ItpRepGroupNode = interface;

  ItpBaseNode = interface(Il3Node)
  {* Базовый узел дерева. }
   ['{8AE82614-6377-4D06-A3DF-CC512F43101F}']
   // property methods
     function pm_GetState: TtpState;
     procedure pm_SetState(const aValue: TtpState);
       {-}
   // methods
     procedure Save;
       {* - сохранить изменения. }
   // properties
     property State: TtpState
       read pm_GetState
       write pm_SetState;
       {-}
  end;//ItpBaseNode

  ItpTasksPanelNode = interface(ItpBaseNode)
   {* Узел панели задач. }
    ['{227F9C35-48C9-448A-B845-5E069F5EFB17}']
    // property methods
      function pm_GetPosition: Integer;
      procedure pm_SetPosition(const aValue: Integer);
        {* - позиция операции. }
    // properties
      property Position: Integer
        read pm_GetPosition
        write pm_SetPosition;
        {* - позиция операции. }
  end;//ItpTasksPanelNode

  ItpGroup = interface(ItpTasksPanelNode)
   {* Группа панели задач. }
    ['{AECA450E-4304-4A20-8AB7-5A1773D9677E}']
    // property methods
      function pm_GetRepGroup: IvcmCustOpsRepGroup;
        {-}
      function pm_GetGroup: IvcmCustOpsGroup;
        {-}
    // properties
      property RepGroup: IvcmCustOpsRepGroup
        read pm_GetRepGroup;
        {-}
      property Group: IvcmCustOpsGroup
        read pm_GetGroup;
        {-}
  end;//ItpGroup

  ItpGroupOperation = interface(ItpTasksPanelNode)
   {* Операция панели задач. }
    ['{0835A76B-6C3A-466A-8166-55E3AB8AAA27}']
    // property methods
      function pm_GetOp: IvcmCustOpsGroupOperation;
        {-}
      function pm_GetRepOp: IvcmCustOpsRepOperation;
        {-}
      function pm_GetForAllUseCases: Boolean;
      procedure pm_SetForAllUseCases(const aValue: Boolean);
        {* - всегда показывать в панели при наличии операции. }
      function pm_GetGroupChanged: Boolean;
      procedure pm_SetGroupChanged(const aValue: Boolean);
        {-}
    // properties
      property Op: IvcmCustOpsGroupOperation
        read pm_GetOp;
        {-}
      property RepOp: IvcmCustOpsRepOperation
        read pm_GetRepOp;
        {-}
      property ForAllUseCases: Boolean
        read pm_GetForAllUseCases
        write pm_SetForAllUseCases;
        {* - всегда показывать в панели при наличии операции. }
      property GroupChanged: Boolean
        read pm_GetGroupChanged
        write pm_SetGroupChanged;
        {-}
  end;//ItpGroupOperation

  ItpRepGroupOperationsNode = interface(ItpBaseNode)
   {* Группа репозитария. }
    ['{82EBEA0C-41E1-4125-A590-3F41BB430B75}']
    // property methods
      function pm_GetGroup: IvcmCustOpsRepGroupOperations;
        {-}
    // properties
      property Group: IvcmCustOpsRepGroupOperations
        read pm_GetGroup;
        {-}
  end;//TtpRepNode

  ItpRepOperationNode = interface(ItpBaseNode)
   {* Операция репозитария. }
    ['{802AF5C0-9C01-483C-BAC6-50A2C5DCE354}']
    // property methods
      function pm_GetOp: IvcmCustOpsRepOperation;
        {-}
    // properties
      property Op: IvcmCustOpsRepOperation
        read pm_GetOp;
        {-}
  end;//ItpRepOperationNode

  ItpRepGroupNode = interface(ItpBaseNode)
   {* Узел репозитария групп. }
    ['{BADC7098-8583-40BD-99EC-1EFAA773DEBA}']
    // property methods
      function pm_GetRepGroup: IvcmCustOpsRepGroup;
        {-}
    // properties
      property RepGroup: IvcmCustOpsRepGroup
        read pm_GetRepGroup;
        {-}
  end;//ItpRepGroupNode

  ItpTree = interface(Il3SimpleTree)
   {* Интерефейс дерева групп. }
    ['{F6A31847-6EC3-456A-A3B5-A92A6F9F6FAC}']
    // methods
      procedure Save;
        {* - сохранить данные древа. }
  end;//ItpRepGropusTree

  TvcmBaseNode = class(Tl3UsualNode, ItpBaseNode)
  private
  // fields
    f_State: TtpState;
  protected
  // ItpBaseNode
    function pm_GetState: TtpState;
    procedure pm_SetState(const aValue: TtpState);
      {-}
    procedure Save;
      virtual;
      {* - сохранить изменения. }
  protected
  // properties
    property State: TtpState
      read pm_GetState
      write pm_SetState;
      {-}
  protected
  // methods
    constructor Create;
      reintroduce;
      {-}
  end;//TvcmBaseNode

  TvcmCustOpsRootNode = class(Tl3RootNode)
  protected
  // methods
    function DoCompareChild(const aChildrenNode1: Il3Node;
                          const aChildrenNode2: Il3Node): Integer;
      override;
        {* - сравнивает aChildrenNode1 и aChildrenNode2 (обычно Text),  возвращает
             <0 если aChildrenNode1 < aChildrenNode2
              0 если aChildrenNode1 = aChildrenNode2
             >0 если aChildrenNode1 > aChildrenNode2
             используется при сортировке ветки дерева. }
  end;//TvcmCustOpsRootNode

  TvcmCustOpsNode = class(TvcmBaseNode, ItpTasksPanelNode)
  protected
  // methods
    f_Position: Integer;
  protected
  // ItpTasksPanelNode
    function pm_GetPosition: Integer;
    procedure pm_SetPosition(const aValue: Integer);
      virtual;
      abstract;
      {* - позиция операции. }
  protected
  // properties
    property Position: Integer
      read pm_GetPosition
      write pm_SetPosition;
      {-}
  end;//TvcmCustOpsNode

  TvcmGroup = class(TvcmCustOpsNode, ItpGroup)
  {* Группа панели задач. }
  private
  // fields
    f_Group    : IvcmCustOpsGroup;
    f_RepGroup : IvcmCustOpsRepGroup;
  private
  // ItpGroup
    function pm_GetRepGroup: IvcmCustOpsRepGroup;
      {-}
    function pm_GetGroup: IvcmCustOpsGroup;
      {-}
    procedure pm_SetPosition(const aValue: Integer);
      override;
      {* - позиция операции. }
  private
  // methods
    procedure LoadOps;
      {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
    procedure Save;
      override;
      {* - сохранить изменения. }
    procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
      override;
      {-}
    function DoCompareChild(const aChildrenNode1: Il3Node;
                          const aChildrenNode2: Il3Node): Integer;
     override;
       {* - сравнивает aChildrenNode1 и aChildrenNode2 (обычно Text),  возвращает
            <0 если aChildrenNode1 < aChildrenNode2
             0 если aChildrenNode1 = aChildrenNode2
            >0 если aChildrenNode1 > aChildrenNode2
            используется при сортировке ветки дерева. }
  protected
  // property
    property Group: IvcmCustOpsGroup
      read f_Group;
      {-}
    property RepGroup: IvcmCustOpsRepGroup
      read f_RepGroup;
      {-}
  public
  // methods
    constructor Create(const aGroup: IvcmCustOpsGroup);
      reintroduce;
      overload;
      {-}
    class function Make(const aGroup: IvcmCustOpsGroup): Il3Node;
      overload;
      {-}
    constructor Create(const aText     : Tl3PCharLenPrim;
                       const aRepGroup : IvcmCustOpsRepGroup);
      reintroduce;
      overload;
      {-}
    class function Make(const aText     : Tl3PCharLenPrim;
                        const aRepGroup : IvcmCustOpsRepGroup): Il3Node;
      overload;
      {-}
  end;//TvcmGroup

  TvcmGroupOperation = class(TvcmCustOpsNode, ItpGroupOperation)
  private
  // fields
    f_RepOp        : IvcmCustOpsRepOperation;
    f_Op           : IvcmCustOpsGroupOperation;
    f_ForAllUseCases   : Boolean;
    f_GroupChanged : Boolean;
  private
  // property methods
    function pm_GetGroup: ItpGroup;
      {* - группа операции. }
  private
  // ItpGroupOperation
     function pm_GetOp: IvcmCustOpsGroupOperation;
       {-}
     function pm_GetRepOp: IvcmCustOpsRepOperation;
       {-}
     function pm_GetForAllUseCases: Boolean;
     procedure pm_SetForAllUseCases(const aValue: Boolean);
       {* - всегда показывать в панели при наличии операции. }
     function pm_GetGroupChanged: Boolean;
     procedure pm_SetGroupChanged(const aValue: Boolean);
       {-}
     procedure pm_SetPosition(const aValue: Integer);
       override;
       {* - позиция операции. }
  protected
  // methods
    procedure InitFields;
      override;
      {-}
    procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
      override;
      {-}
    procedure Save;
      override;
      {-}
  protected
  // properties
    property RepOp: IvcmCustOpsRepOperation
      read f_RepOp
      write f_RepOp;
      {-}
    property Op: IvcmCustOpsGroupOperation
      read f_Op
      write f_Op;
      {-}
    property ForAllUseCases: Boolean
      read pm_GetForAllUseCases
      write pm_SetForAllUseCases;
      {-}
    property Group: ItpGroup
      read pm_GetGroup;
      {* - группа операции. }
    property GroupChanged: Boolean
      read pm_GetGroupChanged
      write pm_SetGroupChanged;
      {-}
  public
  // methods
    constructor Create(const aOp: IvcmCustOpsGroupOperation);
      reintroduce;
      overload;
      {-}
    class function Make(const aOp: IvcmCustOpsGroupOperation): Il3Node;
      overload;
      {-}
    constructor Create(const aRepOp: IvcmCustOpsRepOperation);
      reintroduce;
      overload;
      {-}
    class function Make(const aRepOp: IvcmCustOpsRepOperation): Il3Node;
      overload;
      {-}
    function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
      override;
      {-}
  end;//TvcmGroupOperation

  TvcmRepGroupOperationsNode = class(TvcmBaseNode, ItpRepGroupOperationsNode)
  private
  // fields
    f_Group: IvcmCustOpsRepGroupOperations;
  private
  // ItpRepGroupOperationsNode
     function pm_GetGroup: IvcmCustOpsRepGroupOperations;
       {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    constructor Create(const aGroup: IvcmCustOpsRepGroupOperations);
      reintroduce;
      {-}
    class function Make(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
      {-}
  end;//TvcmRepGroupOperationsNode

  TvcmRepOperationNode = class(TvcmBaseNode, ItpRepOperationNode)
  private
  // fields
    f_Op: IvcmCustOpsRepOperation;
  private
  // ItpRepOperationNode
     function pm_GetOp: IvcmCustOpsRepOperation;
       {-}
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    constructor Create(const aOp: IvcmCustOpsRepOperation);
      reintroduce;
      {-}
    class function Make(const aOp: IvcmCustOpsRepOperation): Il3Node;
      {-}
  end;//TvcmRepOperationNode

  TvcmTree = class(Tl3Tree, ItpTree)
  {* Дерево умеющее сохранять свои данные. }
  private
  // ItpTree
    procedure Save;
      {* - сохранить данные древа. }
  end;//TvcmTree

  TvcmCustOpsTree = class(TvcmTree)
  private
  // methods
    procedure LoadGroups;
      {-}
  protected
  // methods
    procedure InitFields;
      override;
      {-}
  end;//TvcmCustOpsTree

  TvcmRepTree = class(TvcmTree)
  private
  // methods
    procedure ReadRepGroup(const aGroup     : IvcmCustOpsRepGroupOperations;
                           const aGroupNode : Il3Node);
      {-}
    procedure ReadRepGroups;
      {* - прочитаем данные репозитория. }
  protected
  // methods
    procedure InitFields;
      override;
      {-}
  end;//TvcmRepTree

  TvcmRepGroupsTree = class(TvcmTree)
  protected
  // methods
    procedure InitFields;
      override;
      {-}
  end;//TvcmRepGroupsTree

  TvcmRepGroupNode = class(TvcmBaseNode, ItpRepGroupNode)
  private
  // fields
    f_RepGroup : IvcmCustOpsRepGroup;
  private
  // ItpRepGroupNode
    function pm_GetRepGroup: IvcmCustOpsRepGroup;
      {-}
     procedure Save;
       override;
       {* - сохранить изменения. }
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
    procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
      override;
      {-}
  protected
  // properties
    property RepGroup: IvcmCustOpsRepGroup
      read f_RepGroup
      write f_RepGroup;
      {-}
  public
  // methods
    constructor Create(const aCaption  : Tl3PCharLenPrim;
                       const aRepGroup : IvcmCustOpsRepGroup = nil);
      reintroduce;
      {-}
    class function Make(const aCaption  : Tl3PCharLenPrim;
                        const aRepGroup : IvcmCustOpsRepGroup = nil): Il3Node;
      {-}
  end;//TvcmRepGroupNode

function vcmComparePostions(const aNode1: Il3Node;
                            const aNode2: Il3Node): Integer;
 {* - сравнивает позиции aNode1 и aNode2,  возвращает
      <0 если aNode1 < aNode2
       0 если aNode1 = aNode2
      >0 если aNode1 > aNode2
      используется при сортировке групп/операций по позиции. }
var
 l_Node1 : ItpTasksPanelNode;
 l_Node2 : ItpTasksPanelNode;
begin
 Result := 0;
 if Supports(aNode1, ItpTasksPanelNode, l_Node1) and
    Supports(aNode2, ItpTasksPanelNode, l_Node2) then
  Result := l_Node1.Position - l_Node2.Position
 else
  Result := 0;
end;//vcmComparePostions

{ TvcmRepOperationNode }

procedure TvcmRepOperationNode.Cleanup;
begin
 f_Op := nil;
 inherited;
end;//Cleanup

constructor TvcmRepOperationNode.Create(const aOp: IvcmCustOpsRepOperation);
begin
 inherited Create;
 f_Op := aOp;
 Text := l3PCharLen(f_Op.Caption);
end;//Create

class function TvcmRepOperationNode.Make(
 const aOp: IvcmCustOpsRepOperation): Il3Node;
var
 l_Class: TvcmRepOperationNode;
begin
 l_Class := Create(aOp);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;//try..finally
end;//Make

function TvcmRepOperationNode.pm_GetOp: IvcmCustOpsRepOperation;
begin
 Result := f_Op;
end;//pm_GetOp

{ TvcmRepGroupOperationsNode }

constructor TvcmRepGroupOperationsNode.Create(const aGroup: IvcmCustOpsRepGroupOperations);
begin
 inherited Create;
 f_Group := aGroup;
 Text := f_Group.Caption.AsWStr;
end;//Create

class function TvcmRepGroupOperationsNode.Make(
 const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
var
 l_Class: TvcmRepGroupOperationsNode;
begin
 l_Class := Create(aGroup);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;//try..finally
end;//Make

procedure TvcmRepGroupOperationsNode.Cleanup;
begin
 f_Group := nil;
 inherited;
end;//Cleanup

function TvcmRepGroupOperationsNode.pm_GetGroup: IvcmCustOpsRepGroupOperations;
begin
 Result := f_Group;
end;//pm_GetGroup

{ TvcmRepTree }

procedure TvcmRepTree.InitFields;
begin
 inherited;
 ReadRepGroups;
end;//InitFields

procedure TvcmRepTree.ReadRepGroup(const aGroup     : IvcmCustOpsRepGroupOperations;
                                  const aGroupNode : Il3Node);
var
 l_Iterator : IvcmCustOpsRepOperationsIterator;
 l_Op       : IvcmCustOpsRepOperation; 
begin
 l_Iterator := aGroup.Operations;
 try
  l_Op := l_Iterator.Next;
  while l_Op <> nil do
  begin
   aGroupNode.InsertChild(TvcmRepOperationNode.Make(l_Op));
   l_Op := l_Iterator.Next;
  end;//while l_Op <> nil do
  aGroupNode.SortChilds;
 finally
  l_Iterator := nil;
 end;//try..finally
end;//ReadRepGroup

procedure TvcmRepTree.ReadRepGroups;
var
 l_Iterator  : IvcmCustOpsRepGroupsOperationsIterator;
 l_Group     : IvcmCustOpsRepGroupOperations;
 l_GroupNode : Il3Node;
begin
 l_Iterator := g_TasksPanel.RepGroupsOperations;
 try
  l_Group := l_Iterator.Next;
  while l_Group <> nil do
  begin
   l_GroupNode := TvcmRepGroupOperationsNode.Make(l_Group);
   try
    RootNode.InsertChild(l_GroupNode);
    ReadRepGroup(l_Group, l_GroupNode);
   finally
    l_GroupNode := nil;
   end;//try..finally
   l_Group := l_Iterator.Next;
  end;//while l_Group <> nil do
  RootNode.SortChilds;
 finally
  l_Iterator := nil;
 end;//try..finally
end;//ReadRepGroups

function TCustomizeTasksPanelForm.tvRepOpsGetItemImage(Sender: TObject;
  Index: Integer; var aImages: TCustomImageList): Integer;
var
 l_Node: ItpRepOperationNode;
begin
 if Supports(tvRepOps.GetNode(Index), ItpRepOperationNode, l_Node) then
 try
  Result := l_Node.Op.Action.ImageIndex;
  if Result = -1 then
   Result := vtItemWithoutImage;
 finally
  l_Node := nil;
 end//try..finally
 else
  Result := vtItemWithoutImage;
end;//tvRepGetItemImage

procedure TCustomizeTasksPanelForm.cbGroupNameChange(Sender: TObject);
begin
 UpdateState;
end;//cbGroupNameChange

procedure TCustomizeTasksPanelForm.btnAddGroupClick(Sender: TObject);
var
 l_Root : Il3Node;
 l_Node : Il3Node;
begin
 if not l3IsNil(cbGroupName.Text) and (tvRepGroups.TreeStruct <> nil) and
  Supports(tvRepGroups.TreeStruct.RootNode, Il3Node, l_Root) then
 try
  l_Node := TvcmRepGroupNode.Make(l3PCharLen(cbGroupName.Text));
  try
   l_Root.InsertChild(l_Node);
   tvRepGroups.GotoOnNode(l_Node);
  finally
   l_Node := nil;
  end;//try..finally
  IsChanged := True;
 finally
  l_Root := nil;
 end;//try..finally
end;//btnAddGroupClick

{ TvcmRepGroupsTree }

procedure TvcmRepGroupsTree.InitFields;
var
 l_Iterator : IvcmCustOpsRepGroupsIterator;
 l_Group    : IvcmCustOpsRepGroup;
begin
 inherited;
 l_Iterator := g_TasksPanel.RepGroups;
 try
  l_Group := l_Iterator.Next;
  while l_Group <> nil do
  begin
   RootNode.InsertChild(TvcmRepGroupNode.Make(l_Group.Caption.AsWStr, l_Group));
   l_Group := l_Iterator.Next;
  end;//while l_Group <> nil do
  RootNode.SortChilds;
 finally
  l_Iterator := nil;
 end;//try..finally
end;//InitFields

procedure TCustomizeTasksPanelForm.tvRepGroupsMakeTreeSource(
  out theTree: Il3SimpleTree);
begin
end;

{ TvcmRepGroupNode }

procedure TvcmRepGroupNode.Cleanup;
begin
 f_RepGroup := nil;
 inherited;
end;//Cleanup

class function TvcmRepGroupNode.Make(const aCaption  : Tl3PCharLenPrim;
                                     const aRepGroup : IvcmCustOpsRepGroup): Il3Node;
var
 l_Class: TvcmRepGroupNode;
begin
 l_Class := Create(aCaption, aRepGroup);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;//try..finally
end;//Make

function TvcmRepGroupNode.pm_GetRepGroup: IvcmCustOpsRepGroup;
begin
 Result := f_RepGroup;
end;//pm_GetRepGroup

constructor TvcmRepGroupNode.Create(const aCaption  : Tl3PCharLenPrim;
                                    const aRepGroup : IvcmCustOpsRepGroup);
begin
 inherited Create;
 f_RepGroup := aRepGroup;
 Text := aCaption;
 if aRepGroup <> nil then
 begin
  if l3Compare(aCaption, aRepGroup.Caption.AsWStr) <> 0 then
   State := sChange
  else
   State := sNone;
 end
 else
  State := sNew;
end;//Create

procedure TvcmRepGroupNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
  //override;
  {-}
begin
 if l3Compare(GetAsPCharLen, Value) <> 0 then
 begin
  if State <> sNew then
   State := sChange;
  inherited;
 end;//if l3Compare
end;//DoSetAsPCharLen

procedure TvcmRepGroupNode.Save;
begin
 inherited;
 case State of
  sNew:
   RepGroup := g_TasksPanel.AddRepGroup(TvcmWString.MakeI(GetAsPCharLen));
  sChange:
   RepGroup.Caption := TvcmWString.MakeI(GetAsPCharLen);
 end;//case State of
 State := sNone;
end;//Save

{ TvcmBaseNode }

constructor TvcmBaseNode.Create;
begin
 inherited Create;
 f_State := sNone;
end;//Create

procedure TvcmBaseNode.Save;
begin

end;//Save

function TvcmBaseNode.pm_GetState: TtpState;
begin
 Result := f_State;
end;//pm_GetState

procedure TvcmBaseNode.pm_SetState(const aValue: TtpState);
begin
 f_State := aValue;
end;//pm_SetState

procedure TCustomizeTasksPanelForm.btnChangeGroupClick(Sender: TObject);
begin
 with tvRepGroups do
 begin
  if (CurrentCNode <> nil) and
   not l3Same(CurrentCNode.Text, cbGroupName.Text) then
  begin
   CurrentCNode.Text := l3PCharLen(cbGroupName.Text);
   Self.IsChanged := True;
  end;
  Invalidate;
 end;//with tvRepGroups do
end;//btnChangeClick

procedure TCustomizeTasksPanelForm.UpdateState;
begin
 with cbGroupName do
 begin
  btnAddGroup.Enabled := not l3IsNil(Text);
  btnChangeGroup.Enabled := (tvRepGroups.CurrentCNode <> nil) and not l3IsNil(Text);
 end;
 btnDeleteGroup.Enabled := (tvRepGroups.Current <> -1);
 btnMoveGroupToPanel.Enabled := (tvRepGroups.Current <> -1);
 btnMoveGroupToRep.Enabled := Supports(tvTasksPanel.CurrentCNode, ItpGroup);
 btnMoveOpToPanel.Enabled := Supports(tvRepOps.CurrentCNode,
  ItpRepOperationNode) and (tvTasksPanel.Current <> -1);
 btnMoveGroupToRep.Enabled := Supports(tvTasksPanel.CurrentCNode, ItpGroup);
 btnMoveOpToRep.Enabled := tvTasksPanel.CurrentCNode <> nil;
 cbForAllUseCases.Enabled := Supports(tvTasksPanel.CurrentCNode, ItpGroupOperation);
 btnChangeItem.Enabled := tvTasksPanel.CurrentCNode <> nil;
 UpBitBtn.Enabled := tvTasksPanel.CurrentCNode <> nil;
 DownBitBtn.Enabled := tvTasksPanel.CurrentCNode <> nil;
end;//UpdateState

procedure TCustomizeTasksPanelForm.tvRepGroupsCurrentChanged(
  Sender: TObject; aNewCurrent, aOldCurrent: Integer);
begin
 UpdateState;
 with tvRepGroups do
  if CurrentCNode <> nil then
   cbGroupName.Text := l3Str(CurrentCNode.Text);
end;//tvRepGroupsCurrentChanged

procedure TCustomizeTasksPanelForm.btnDeleteGroupClick(Sender: TObject);
var
 l_RepGroup: ItpRepGroupNode;
begin
 with tvRepGroups do
 begin
  if Supports(CurrentCNode, ItpRepGroupNode, l_RepGroup) then
  try
   DeleteGroups.Add(l_RepGroup.RepGroup);
   tvRepGroups.CurrentCNode.Remove;
   Self.IsChanged := True;
  finally
   l_RepGroup := nil;
  end;//try..finally
  Invalidate;
 end;//with tvRepGroups do
end;//btnDeleteGroupClick

function TCustomizeTasksPanelForm.pm_GetDeleteOperations: Tl3NodeList;
  {-}
begin
 if f_DeleteOperations = nil then
  f_DeleteOperations := Tl3NodeList.Create;
 Result := f_DeleteOperations;
end;//pm_GetDeleteOperations

function TCustomizeTasksPanelForm.pm_GetDeleteGroups: TvcmCustOpsRepGroupList;
begin
 if f_DeleteGroups = nil then
  f_DeleteGroups := TvcmCustOpsRepGroupList.Create;
 Result := f_DeleteGroups;
end;//pm_GetDeleteGroups

procedure TCustomizeTasksPanelForm.Cleanup;
begin
 f_IsChanged := false;
 g_TasksPanel := nil;
 FreeAndNil(f_DeleteOperations);
 FreeAndNil(f_DeleteGroups);
 vcmFree(f_UserTypeDescrList);
 inherited;
end;//Cleanup

procedure TCustomizeTasksPanelForm.btOkClick(Sender: TObject);
begin
 Save;
end;//btOkClick

procedure TCustomizeTasksPanelForm.btApplyClick(Sender: TObject);
begin
 Save;
end;//btApplyClick

function TCustomizeTasksPanelForm.FindRepGroupOps(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
  {-}

 function lp_IteratorFunc(const aNode: Il3Node): Boolean;
 var
  l_RepGroup: ItpRepGroupOperationsNode;
 begin
  if Supports(aNode, ItpRepGroupOperationsNode, l_RepGroup) then
  try
   Result := l_RepGroup.Group = aGroup;
  finally
   l_RepGroup := nil;
  end//try..finally
  else
   Result := False;
 end;//lp_IteratorFunc
 
var
 l_Root: Il3Node;
begin
 with tvRepOps do
  if Supports(TreeStruct.RootNode, Il3Node, l_Root) then
  try
   Result := l_Root.IterateF(l3L2NA(@lp_IteratorFunc),
    imCheckResult or imOneLevel);
  finally
   l_Root := nil;
  end//try..finally
  else
   Result := nil;
end;//FindRepGroupOps

procedure TCustomizeTasksPanelForm.Save;

 procedure lp_DeleteEmptyGroups;
  {* - удалим группы в которых нет операций. }

  function lp_Group(const aNode: Il3Node): Boolean;
  var
   l_Group: ItpGroup;
  begin
   Result := False;
   if Supports(aNode, ItpGroup, l_Group) then
   try
    if not l_Group.HasChild then
     RemoveGroup(l_Group);
   finally
    l_Group := nil;
   end;//try..finally
  end;//lp_Iterator

 var
  l_Root: Il3Node;
 begin
  if Supports(tvTasksPanel.TreeStruct.RootNode, Il3Node, l_Root) then
  try
   l_Root.IterateF(l3L2NA(@lp_Group), imOneLevel);
  finally
   l_Root := nil;
  end;//try..finally
 end;//lp_DeleteEmptyGroups

 procedure lp_SaveTree(const aTreeView: TeeTreeView);
 var
  l_Tree: ItpTree;
 begin
  if Supports(aTreeView.TreeStruct, ItpTree, l_Tree) then
  try
   l_Tree.Save;
  finally
   l_Tree := nil;
  end;//try..finally
 end;//lp_SaveTree

 procedure lp_DeleteRepGroups;
 var
  l_Index : Integer;
  l_Group : IvcmCustOpsRepGroup;
 begin
  for l_Index := 0 to Pred(DeleteGroups.Count) do
   g_TasksPanel.DeleteRepGroup(DeleteGroups[l_Index]);
  DeleteGroups.Clear;
 end;//lp_DeleteRepGroups

 procedure lp_DeleteOperations;
 var
  l_Index: Integer;
 begin
  if DeleteOperations.Count = 0 then
   Exit;
  for l_Index := 0 to Pred(DeleteOperations.Count) do
   DeleteOperations[l_Index].Delete;
  DeleteOperations.Clear;
 end;//lp_DeleteOperations;

var
 l_SaveInAllSettings : Boolean;
 l_SaveState         : TafwSettingsState;
begin
 // Если редактируются доступные для выбора на панель инструментов операции,
 // то сохранение происходит во все конфигурации, т.к. список операций одинаков:
 l_SaveState := afw_ssNone;
 l_SaveInAllSettings := Supports(TasksPanel, IvcmCustAvailableToolbarOps);
 if l_SaveInAllSettings then
  with afw.Settings do
  begin
   l_SaveState := State;
   State := afw_ssSaveInAllSettings;
  end;//with afw.Settings do
 // Сохраним:
 TasksPanel.EnableSaveToSettings := true;
 try
  lp_DeleteEmptyGroups;
  lp_DeleteOperations;
  lp_DeleteRepGroups;
  lp_SaveTree(tvRepGroups);
  lp_SaveTree(tvTasksPanel);
 // Восстановим состояние компонента настроек:
 finally
  TasksPanel.EnableSaveToSettings := false;
  if l_SaveInAllSettings then
   afw.Settings.State := l_SaveState;
 end;
end;//Save

{ TvcmTree }

procedure TvcmTree.Save;

 function lp_IteratorFunc(const aNode: Il3Node): Boolean;
 var
  l_Node: ItpBaseNode;
 begin//lp_IteratorFunc
  Result := False;
  if Supports(aNode, ItpBaseNode, l_Node) then
  try
   l_Node.Save;
  finally
   l_Node := nil;
  end;//try..finally
 end;//lp_IteratorFunc

begin
 IterateF(l3L2NA(@lp_IteratorFunc));
end;//Save

procedure TCustomizeTasksPanelForm.btnMoveGroupToPanelClick(Sender: TObject);
var
 l_Dest     : Il3Node;
 l_RepGroup : ItpRepGroupNode;
 l_Node     : Il3Node;
begin
 if (tvRepGroups.CurrentCNode <> nil) and
  Supports(tvTasksPanel.TreeStruct.RootNode, Il3Node, l_Dest) then
 try
  if Supports(tvRepGroups.CurrentCNode, ItpRepGroupNode, l_RepGroup) then
  try
   cbGroupName.Text := '';
   l_RepGroup.Remove;
   l_Node := TvcmGroup.Make(l_RepGroup.Text, l_RepGroup.RepGroup);
   try
    l_Dest.InsertChild(l_Node);
    tvTasksPanel.GotoOnNode(l_Node);
    UpdatePositions(l_Node.ParentNode);
    IsChanged := True;
   finally
    l_Node := nil;
   end;//try..finally
  finally
   l_RepGroup := nil;
  end;//try..finally
 finally
  l_Dest := nil;
 end;//try..finally
 tvTasksPanel.Invalidate;
 tvRepGroups.Invalidate;
end;//btnMoveGroupToPanelClick

{ TvcmCustOpsNode }

function TvcmCustOpsNode.pm_GetPosition: Integer;
begin
 Result := f_Position;
end;//pm_GetPosition

{ TvcmGroup }

procedure TvcmGroup.Cleanup;
begin
 f_RepGroup := nil;
 inherited;
end;//Cleanup

constructor TvcmGroup.Create(const aText     : Tl3PCharLenPrim;
                            const aRepGroup : IvcmCustOpsRepGroup);
  //reintroduce;
  //overload;
  {-}
begin
 inherited Create;
 Text := aText;
 f_RepGroup := aRepGroup;
 State := sNew;
end;//Create

class function TvcmGroup.Make(const aText     : Tl3PCharLenPrim;
                             const aRepGroup : IvcmCustOpsRepGroup): Il3Node;
  //overload;
  {-}
var
 l_Class: TvcmGroup;
begin
 l_Class := Create(aText, aRepGroup);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;//try..finally
end;//Make

constructor TvcmGroup.Create(const aGroup: IvcmCustOpsGroup);
  // reintroduce;
  // overload;
  {-}
begin
 inherited Create;
 Text := aGroup.RepGroup.Caption.AsWStr;
 f_Group := aGroup;
 f_RepGroup := aGroup.RepGroup;
 f_Position := aGroup.Position;
 LoadOps;
end;//Create

class function TvcmGroup.Make(const aGroup: IvcmCustOpsGroup): Il3Node;
  // overload;
  {-}
var
 l_Class: TvcmGroup;
begin
 l_Class := Create(aGroup);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;//try..finally
end;//Make

procedure TvcmGroup.LoadOps;
  {-}
var
 l_Ops : IvcmCustOpsGroupOperationsIterator;
 l_Op  : IvcmCustOpsGroupOperation;
begin
 l_Ops := Group.Operations;
 try
  l_Op := l_Ops.Next;
  while l_Op <> nil do
  begin
   InsertChild(TvcmGroupOperation.Make(l_Op));
   l_Op := l_Ops.Next;
  end;//while l_Op <> nil do
 finally
  l_Ops := nil;
 end;//try..finally
 SortChilds;
end;//LoadOps

procedure TvcmGroup.DoSetAsPCharLen(const Value: Tl3PCharLen);
begin
 if l3Compare(GetAsPCharLen, Value) <> 0 then
 begin
  if Group <> nil then
   State := sChange;
  inherited;
 end;//if l3Compare
end;//DoSetAsPCharLen

procedure TvcmGroup.Save;
begin
 inherited;
 case State of
  sNew:
  begin
   if f_RepGroup = nil then
    f_RepGroup := g_TasksPanel.AddRepGroup(TvcmWString.MakeI(GetAsPCharLen));
   f_Group := g_TasksPanel.AddGroup(f_RepGroup, GetNumInParent(True));
  end;//sNew
  sChange:
  begin
   Group.Position := Position;
   RepGroup.Caption := TvcmWString.MakeI(GetAsPCharLen);
  end;//sChange
 end;//case State of
 State := sNone;
end;//Save

procedure TCustomizeTasksPanelForm.tvRepOpsCurrentChanged(
  Sender: TObject; aNewCurrent, aOldCurrent: Integer);
begin
 UpdateState;
end;//tvRepOpsCurrentChanged

procedure TCustomizeTasksPanelForm.UpdateControls;
var
 l_Op: ItpGroupOperation;
begin
 with tvTasksPanel do
 begin
  if CurrentCNode <> nil then
   edChange.Text := l3Str(CurrentCNode.Text)
  else
   edChange.Text := '';
  if Supports(CurrentCNode, ItpGroupOperation, l_Op) then
  try
   cbForAllUseCases.Checked := l_Op.ForAllUseCases;
  finally
   l_Op := nil;
  end;//try..finally
 end;//with tvTasksPanel do
end;//UpdateControls

procedure TCustomizeTasksPanelForm.tvTasksPanelCurrentChanged(
  Sender: TObject; aNewCurrent, aOldCurrent: Integer);
begin
 UpdateControls;
 UpdateState;
end;//tvTasksPanelCurrentChanged

procedure TCustomizeTasksPanelForm.btnMoveOpToPanelClick(
  Sender: TObject);
var
 l_Current   : Il3Node;
 l_DestGroup : Il3Node;
 l_RepOp     : ItpRepOperationNode;
 l_Node      : Il3Node;
begin
 l_Current := tvTasksPanel.CurrentCNode;
 if (l_Current <> nil) and
  Supports(tvRepOps.CurrentCNode, ItpRepOperationNode, l_RepOp) then
 begin
  tvRepOps.CurrentCNode.Remove;
  if not Supports(l_Current, ItpGroup) then
   l_DestGroup := l_Current.ParentNode
  else
  begin
   l_DestGroup := l_Current;
   l_Current := nil;
  end;//if not Supports
  l_Node := TvcmGroupOperation.Make(l_RepOp.Op);
  try
   l_DestGroup.InsertChildBefore(l_Current, l_Node);
   tvTasksPanel.GotoOnNode(l_Node);
   UpdatePositions(l_DestGroup);
   IsChanged := True;
  finally
   l_Node := nil;
  end;//try..finally
  tvTasksPanel.ExpandNode(l_DestGroup, True);
 end;//if (l_Current <> nil) and
end;//btnMoveOpToPanelClick

function TvcmGroup.pm_GetGroup: IvcmCustOpsGroup;
  {-}
begin
 Result := f_Group;
end;//pm_GetGroup

function TvcmGroup.pm_GetRepGroup: IvcmCustOpsRepGroup;
begin
 if f_Group <> nil then
  Result := f_Group.RepGroup
 else
  Result := f_RepGroup;
end;//pm_GetRepGroup

procedure TvcmGroup.pm_SetPosition(const aValue: Integer);
begin
 if f_Position <> aValue then
 begin
  f_Position := aValue;
  if State <> sNew then
   State := sChange;
 end;//if f_Position <> aValue then
end;//pm_SetPosition

function TvcmGroup.DoCompareChild(const aChildrenNode1: Il3Node;
                                const aChildrenNode2: Il3Node): Integer;
begin
 Result := vcmComparePostions(aChildrenNode1, aChildrenNode2);
end;//CompareChild

{ TvcmGroupOperation }

constructor TvcmGroupOperation.Create(
  const aOp: IvcmCustOpsGroupOperation);
begin
 inherited Create;
 f_Op := aOp;
end;//Create

constructor TvcmGroupOperation.Create(
  const aRepOp: IvcmCustOpsRepOperation);
begin
 inherited Create;
 f_RepOp := aRepOp;
 State := sNew;
end;//Create

procedure TvcmGroupOperation.Save;
begin
 inherited;
 case State of
  sNew:
   Op := Group.Group.AddOperation(f_RepOp, ForAllUseCases, Position, l3CStr(Text));
  sChange:
  begin
   Op.ForAllUseCases := f_ForAllUseCases;
   Op.Position := f_Position;
   Op.Caption := l3CStr(Text);
   if GroupChanged then
   begin
    Op.GroupId := Group.Group.RepGroup.Id;
    GroupChanged := False;
   end;//if GroupChanged then
  end;//sChange
 end;//case State of
 State := sNone;
end;//Save

procedure TvcmGroupOperation.DoSetAsPCharLen(const Value: Tl3PCharLen);
begin
 if l3Compare(Text, Value) <> 0 then
 begin
  if f_Op <> nil then
   State := sChange;
  inherited;
 end;//if l3Compare(Text, Value) <> 0 then
end;//DoSetAsPCharLen

procedure TvcmGroupOperation.InitFields;
begin
 inherited;
 if Op <> nil then
 begin
  Text := l3PCharLen(Op.Caption);
  f_ForAllUseCases := Op.ForAllUseCases;
  f_Position := Op.Position;
 end//if Op <> nil then
 else
 begin
  Text := l3PCharLen(RepOp.UserCaption);
  f_ForAllUseCases := Supports(g_TasksPanel, IvcmCustAvailableToolbarOps);
 end;
end;//InitFields

function TvcmGroupOperation.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  //override;
  {-}
begin
 Result.SetOk;
 if IID.EQ(IvcmCustOpsGroupOperation) then
  IvcmCustOpsGroupOperation(Obj) := Op
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

class function TvcmGroupOperation.Make(
  const aRepOp: IvcmCustOpsRepOperation): Il3Node;
var
 l_Class: TvcmGroupOperation;
begin
 l_Class := Create(aRepOp);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;//try..finally
end;//Make

class function TvcmGroupOperation.Make(
  const aOp: IvcmCustOpsGroupOperation): Il3Node;
var
 l_Class: TvcmGroupOperation;
begin
 l_Class := Create(aOp);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;//try..finally
end;//Make

function TvcmGroupOperation.pm_GetGroupChanged: Boolean;
begin
 Result := f_GroupChanged;
end;//pm_GetGroupChanged

procedure TvcmGroupOperation.pm_SetGroupChanged(const aValue: Boolean);
  {-}
begin
 if f_GroupChanged <> aValue then
 begin
  f_GroupChanged := aValue;
  if f_GroupChanged and (State <> sNew) then
   State := sChange;
 end;//if f_GroupChanged <> aValue then
end;//TvcmGroupOperation

function TvcmGroupOperation.pm_GetGroup: ItpGroup;
  {* - группа операции. }
begin
 Supports(ParentNode, ItpGroup, Result);
end;//pm_GetGroup

function TvcmGroupOperation.pm_GetOp: IvcmCustOpsGroupOperation;
begin
 Result := Op;
end;//pm_GetOp

procedure TvcmGroupOperation.pm_SetPosition(const aValue: Integer);
  {* - позиция операции. }
begin
 if f_Position <> aValue then
 begin
  f_Position := aValue;
  if State <> sNew then
   State := sChange;
 end;//if f_Position <> aValue then
end;//pm_SetPosition

function TvcmGroupOperation.pm_GetForAllUseCases: Boolean;
begin
 Result := f_ForAllUseCases;
end;//pm_GetForAllUseCases

procedure TvcmGroupOperation.pm_SetForAllUseCases(const aValue: Boolean);
  {* - всегда показывать в панели при наличии операции. }
begin
 if aValue <> f_ForAllUseCases then
 begin
  f_ForAllUseCases := aValue;
  if State <> sNew then
   State := sChange;
 end;//if aValue <> f_ForAllUseCases then
end;//pm_SetForAllUseCases

function TvcmGroupOperation.pm_GetRepOp: IvcmCustOpsRepOperation;
begin
 if Op <> nil then
  Result := Op.RepOp
 else
  Result := RepOp;
end;//pm_GetRepOp

function TCustomizeTasksPanelForm.tvTasksPanelGetItemImage(
  Sender: TObject; Index: Integer; var aImages: TCustomImageList): Integer;
var
 l_Op: ItpGroupOperation;
begin
 if Supports(tvTasksPanel.GetNode(Index), ItpGroupOperation, l_Op) and
  (l_Op.RepOp.Action.ImageIndex <> -1) then
  Result := l_Op.RepOp.Action.ImageIndex
 else
  Result := vtItemWithoutImage;
end;//tvTasksPanelGetItemImage

procedure TCustomizeTasksPanelForm.btnChangeItemClick(Sender: TObject);
begin
 with tvTasksPanel do
 begin
  if CurrentCNode <> nil then
   CurrentCNode.Text := l3PCharLen(edChange.Text);
  Invalidate;
 end;//with tvTasksPanel do
 IsChanged := True;
end;//btnChangeItemClick

procedure TCustomizeTasksPanelForm.btnMoveGroupToRepClick(
  Sender: TObject);
begin
 RemoveGroup(tvTasksPanel.CurrentCNode);
end;//btnMoveGroupToRepClick

{ TvcmCustOpsTree }

procedure TvcmCustOpsTree.InitFields;
var
 l_Root: Il3RootNode;
begin
 inherited;
 if Supports(TvcmCustOpsRootNode.Make, Il3RootNode, l_Root) then
  RootNode := l_Root
 else
  Assert(False);
 LoadGroups;
end;//InitFields

procedure TvcmCustOpsTree.LoadGroups;
var
 l_Groups    : IvcmCustOpsGroupsIterator;
 l_Group     : IvcmCustOpsGroup;
begin
 l_Groups := g_TasksPanel.Groups;
 try
  l_Group := l_Groups.Next;
  while l_Group <> nil do
  begin
   RootNode.InsertChild(TvcmGroup.Make(l_Group));
   l_Group := l_Groups.Next;
  end;//while l_Group <> nil do
 finally
  l_Groups := nil;
 end;//try..finally
 RootNode.SortChilds;
end;//LoadGroups

procedure TCustomizeTasksPanelForm.RemoveNode(const aNode: Il3Node);
var
 l_Parent: Il3Node;
begin
 l_Parent := aNode.ParentNode;
 try
  aNode.Remove;
  UpdatePositions(l_Parent);
 finally
  l_Parent := nil;
 end;//try..finally
end;//RemoveNode

procedure TCustomizeTasksPanelForm.ReturnRepOp(const aRepOp: IvcmCustOpsRepOperation);
var
 l_Group: Il3Node;
begin
 l_Group := FindRepGroupOps(aRepOp.Group);
 if l_Group <> nil then
 try
  with l_Group do
  begin
   InsertChild(TvcmRepOperationNode.Make(aRepOp));
   SortChilds;
  end;//with l_Group do
 finally
  l_Group := nil;
 end;//try..finally
end;//ReturnRepOp

procedure TCustomizeTasksPanelForm.DeleteOp(const aNode: Il3Node);
var
 l_Op: ItpGroupOperation;
begin
 if Supports(aNode, ItpGroupOperation, l_Op) then
 try
  ReturnRepOp(l_Op.RepOp);
  if l_Op.State <> sNew then
   DeleteOperations.Add(aNode);
 finally
  l_Op := nil;
 end;//try..finally
 RemoveNode(aNode);
end;//DeleteOp

procedure TCustomizeTasksPanelForm.RemoveGroup(const aGroup: Il3Node);

 function lp_IteratorFunc(const aNode: Il3Node): Boolean;
 begin//lp_IteratorFunc
  Result := False;
  DeleteOp(aNode);
 end;//lp_IteratorFunc

var
 l_Group : ItpGroup;
 l_Root  : Il3Node;
 l_Node  : Il3Node;
begin
 // Удалим операции:
 aGroup.IterateF(l3L2NA(@lp_IteratorFunc), imOneLevel);
 // Поместим группу в репозиторий:
 if Supports(tvRepGroups.TreeStruct.RootNode, Il3Node, l_Root) and
  Supports(aGroup, ItpGroup, l_Group) then
 try
  l_Node := TvcmRepGroupNode.Make(aGroup.Text, l_Group.RepGroup);
  try
   l_Root.InsertChild(l_Node);
   tvRepGroups.GotoOnNode(l_Node);
  finally
   l_Node := nil;
  end;//try..finally
 finally
  l_Root := nil;
 end;//try..finally
 RemoveNode(aGroup);
end;//lp_RemoveGroup

function TCustomizeTasksPanelForm.GetSelectedUserType: IvcmUserTypeDef;
// http://mdp.garant.ru/pages/viewpage.action?pageId=471774401
var
 l_UTDescr: TvcmUserTypeDescr;
begin
 l_UTDescr := f_UserTypeDescrList.Items[Integer(cbForms.Items.Objects[cbForms.ItemIndex])];
 Result := vcmFormCustomize.FindUserTypeByCaption(l_UTDescr.SettingsCaption,
  l_UTDescr.FormClass);
end;

procedure TCustomizeTasksPanelForm.btnMoveOpToRepClick(Sender: TObject);
begin
 with tvTasksPanel do
 begin
  // Удалить группу:
  if Supports(CurrentCNode, ItpGroup) then
   RemoveGroup(CurrentCNode)
  else
   // Удалить операцию:
   if Supports(CurrentCNode, ItpGroupOperation) then
    DeleteOp(CurrentCNode);
 end;//with tvTasksPanel do
 IsChanged := True;
end;//btnMoveOpToRepClick

procedure TCustomizeTasksPanelForm.cbForAllUseCasesClick(
  Sender: TObject);
var
 l_Op: ItpGroupOperation;
begin
 with tvTasksPanel do
  if Supports(CurrentCNode, ItpGroupOperation, l_Op) then
  try
   l_Op.ForAllUseCases := cbForAllUseCases.Checked;
  finally
   l_Op := nil;
  end;//try..finally
end;//cbShowInAllPanelsClick

procedure TCustomizeTasksPanelForm.UpdatePositions(const aParent: Il3Node);

 function lp_Iterator(const aNode: Il3Node): Boolean;
 var
  l_Node: ItpTasksPanelNode;
 begin
  Result := False;
  if Supports(aNode, ItpTasksPanelNode, l_Node) then
  try
   l_Node.Position := aNode.IndexInParent;
  finally
   l_Node := nil;
  end;//try..finally
 end;//lp_Iterator

begin
 aParent.IterateF(l3L2NA(@lp_Iterator), imOneLevel);
end;//UpdatePositions

procedure TCustomizeTasksPanelForm.MoveTasksPanelItem(const aUp        : Boolean;
                                                         const aNewParent : Il3Node);
const
 c_Direction: array [Boolean] of Tl3Direction = (dDown, dUp);
var
 l_Node      : Il3Node;
 l_OldParent : Il3Node;
 l_Op        : ItpGroupOperation;
begin
 l_Node := tvTasksPanel.CurrentCNode;
 try
  if l_Node <> nil then
   // Перемещаем в пределах группы:
   if (aUp and not l_Node.IsFirst) or (not aUp and not l_Node.IsLast) then
   begin
    l_Node.Move(c_Direction[aUp]);
    UpdatePositions(l_Node.ParentNode);
   end//if (aUp and not CurrentCNode.IsFirst) or
   // Перемещаем операцию в другую группу:
   else
    if Supports(l_Node, ItpGroupOperation, l_Op) and (aNewParent <> nil)
     and (aNewParent <> l_Node.ParentNode) then
    begin
     l_OldParent := l_Node.ParentNode;
     try
      l_Node.Remove;
      if aUp then
       aNewParent.InsertChild(l_Node)
      else
       aNewParent.InsertChildBefore(aNewParent.ChildNode, l_Node);
      tvTasksPanel.GotoOnNode(l_Node);
      UpdatePositions(aNewParent);
      UpdatePositions(l_OldParent);
      l_Op.GroupChanged := True;
     finally
      l_OldParent := nil;
     end;//try..finally
    end;//if Supports(CurrentCNode, ...
 finally
  l_Node := nil;
 end;//try..finally
end;//MoveTasksPanelItem

procedure TCustomizeTasksPanelForm.UpBitBtnClick(Sender: TObject);
begin
 MoveTasksPanelItem(True, tvTasksPanel.CurrentCNode.ParentNode.PrevNode);
 IsChanged := True;
end;//UpBitBtnClick

procedure TCustomizeTasksPanelForm.DownBitBtnClick(Sender: TObject);
begin
 MoveTasksPanelItem(False, tvTasksPanel.CurrentCNode.ParentNode.NextNode);
 IsChanged := True;
end;//DownBitBtnClick

{ TvcmCustOpsRootNode }

function TvcmCustOpsRootNode.DoCompareChild(const aChildrenNode1: Il3Node;
                                             const aChildrenNode2: Il3Node): Integer;
begin
 Result := vcmComparePostions(aChildrenNode1, aChildrenNode2);
end;//CompareChild

function TCustomizeTasksPanelForm.pm_GetTasksPanel: IvcmCustOps;
begin
 Result := f_TasksPanel;
end;

procedure TCustomizeTasksPanelForm.pm_SetTasksPanel(
  const Value: IvcmCustOps);

  procedure lp_ForSingleForm;
  // Настройки для редактирования формы:
  var
   l_AvOps: IvcmCustAvailableToolbarOps;

    procedure lp_MakeFormList;
    // http://mdp.garant.ru/pages/viewpage.action?pageId=471774401    
    var
     l_FormList: TStringList;
     l_ItemIndex: Integer;
     l_AddedItemIndex: Integer;
     l_Index: Integer;
     l_UserTypeCaption: String;
     l_UTDescr: TvcmUserTypeDescr;
    begin
     f_UserTypeDescrList := vcmFormCustomize.GetUserTypeDescrList(l_AvOps.Form.CurUseToolbarOfUserType,
      l_ItemIndex);
     l_FormList := TStringList.Create;
     l_FormList.Duplicates := dupAccept;
     l_FormList.Sorted := True;
     try
      for l_Index := 0 to f_UserTypeDescrList.Count - 1 do
      begin
       l_UTDescr := f_UserTypeDescrList.Items[l_Index];
       l_UserTypeCaption := vcmFormCustomize.MakeUserTypeCaption(l_UTDescr.SettingsCaption,
        l_UTDescr.FormClass, nil, l_UTDescr.IsCustomizationInternal);
       l_FormList.AddObject(l_UserTypeCaption, TObject(l_Index));
      end;
      for l_Index := 0 to l_FormList.Count - 1 do
      begin
       l_AddedItemIndex := cbForms.Items.AddObject(l_FormList.Strings[l_Index],
        l_FormList.Objects[l_Index]);
       if (Integer(l_FormList.Objects[l_Index]) = l_ItemIndex) then
        cbForms.ItemIndex := l_AddedItemIndex;
      end;
     finally
     FreeAndNil(l_FormList);
    end;
   end;

  begin
   Supports(f_TasksPanel, IvcmCustAvailableToolbarOps, l_AvOps);
   cbForAllUseCases.Visible := l_AvOps = nil;
   pnlForms.Visible := l_AvOps <> nil;
   if l_AvOps <> nil then
   begin
    if (cbForms.Items.Count = 0) then
      lp_MakeFormList;
    Caption := lblAvailableOpsCaption.Caption;
   end;
  end;

begin
 if f_TasksPanel <> Value then
 begin
  f_TasksPanel := Value;
  g_TasksPanel := f_TasksPanel;
  lp_ForSingleForm;
  if g_MenuManager is TvcmCustomMenuManager then
   with TvcmCustomMenuManager(g_MenuManager) do
   begin
    tvRepOps.Images := SmallImages;
    tvTasksPanel.Images := SmallImages;
   end;//if g_MenuManager is TvcmCustomMenuManager then
  tvTasksPanel.TreeStruct := TvcmCustOpsTree.Make;
  tvTasksPanel.TreeView.ExpandAll;
  tvRepOps.TreeStruct := TvcmRepTree.Make;
  tvRepGroups.TreeStruct := TvcmRepGroupsTree.Make;
  UpdateControls;
  UpdateState;
 end;
end;

procedure TCustomizeTasksPanelForm.cbFormsChange(Sender: TObject);
var
 l_NeedFree : Boolean;
 l_FormVCL  : TvcmEntityForm;
 l_Form     : IvcmEntityForm;
begin
 if IsChanged then
 begin
  if (vcmShowMessageDlg(Tl3Message_C(l3CStr(lblConfirmSave.Caption),
                                     'TCustomizeTasksPanelForm.cbFormsChange',
                                     mtInformation,
                                     [mbYes, mbNo])) = mrYes) then
   Save;
  IsChanged := False;
 end;
 with vcmFormCustomize do
  l_FormVCL := MakeVirtualForm((*FindUserTypeByCaption(cbForms.Text)*) GetSelectedUserType, l_NeedFree);
 try
  if Supports(l_FormVCL, IvcmEntityForm, l_Form) then
   TasksPanel := TvcmCustAvailableToolbarOps.Make(l_Form);
 finally
  if l_NeedFree then
   l_FormVCL.SafeClose;
 end;
end;

procedure TCustomizeTasksPanelForm.vcmEntityFormInit;
begin
 IsChanged := False;
end;

procedure TCustomizeTasksPanelForm.pm_SetIsChanged(
  const Value: Boolean);
begin
 f_IsChanged := Value;
end;

end.