
unit vcmRegister;
{* Модуль для регистрации компонент библиотеки vcm. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmRegister -   }
{ Начат: 11.03.2003 11:16 }
{ $Id: vcmRegister.pas,v 1.87 2016/07/15 13:18:56 lulin Exp $ }

// $Log: vcmRegister.pas,v $
// Revision 1.87  2016/07/15 13:18:56  lulin
// - собираем DesignTime.
//
// Revision 1.86  2014/08/22 09:45:36  kostitsin
// чиню библиотеки компонент
//
// Revision 1.85  2014/07/02 14:45:33  lulin
// - собираем библиотеки.
//
// Revision 1.84  2014/04/22 14:20:14  lulin
// - переходим от интерфейсов к объектам.
//
// Revision 1.83  2013/08/28 14:29:36  lulin
// - чистка кода.
//
// Revision 1.82  2013/08/26 15:31:47  lulin
// - чистим код.
//
// Revision 1.81  2012/10/18 16:51:07  lulin
// {RequestLink:404363289}
//
// Revision 1.80  2012/08/10 18:19:43  lulin
// {RequestLink:382421301}.
//
// Revision 1.79  2012/07/10 12:27:10  lulin
// {RequestLink:237994598}
//
// Revision 1.78  2012/04/13 19:01:02  lulin
// {RequestLink:237994598}
//
// Revision 1.77  2012/04/13 18:23:02  lulin
// {RequestLink:237994598}
//
// Revision 1.76  2012/04/04 08:57:01  lulin
// {RequestLink:237994598}
//
// Revision 1.75  2011/12/08 16:30:07  lulin
// {RequestLink:273590436}
// - чистка кода.
//
// Revision 1.74  2011/06/27 16:50:23  lulin
// {RequestLink:254944102}.
// - чистим мусорок.
//
// Revision 1.73  2010/09/15 18:15:04  lulin
// {RequestLink:235047275}.
//
// Revision 1.72  2010/07/15 11:40:36  lulin
// {RequestLink:207389954}.
//
// Revision 1.71  2010/06/02 09:54:11  lulin
// {RequestLink:215549303}.
// - вычищаем "ненужный" (скорее протухший) код.
//
// Revision 1.70  2010/04/30 15:15:46  lulin
// {RequestLink:207389954}.
// - чистка комментариев.
//
// Revision 1.69  2010/04/23 16:38:15  lulin
// {RequestLink:159352361}.
//
// Revision 1.68  2010/01/15 18:06:35  lulin
// {RequestLink:178323578}. Хитрым раком, но почти удалось затащить модуль с ресурсами на модель.
//
// Revision 1.67  2009/11/05 18:27:19  lulin
// - избавился от переменных списков параметров.
//
// Revision 1.66  2009/10/14 18:39:51  lulin
// {RequestLink:166855347}.
//
// Revision 1.65  2009/10/12 11:27:17  lulin
// - коммитим после падения CVS.
//
// Revision 1.64  2009/09/17 13:17:28  lulin
// - выделяем класс приложения VCM.
//
// Revision 1.63  2009/09/17 12:33:32  lulin
// - отключаем волшебников форм.
//
// Revision 1.62  2009/07/30 16:43:16  lulin
// - думаем о генерации кусков StdRes.
//
// Revision 1.61  2009/02/20 15:19:04  lulin
// - <K>: 136941122.
//
// Revision 1.60  2009/02/05 15:21:13  lulin
// - подготавливаемся к генерации модулей.
//
// Revision 1.59  2008/12/29 13:20:48  lulin
// - добавляем возможность рисовать главную форму приложения.
//
// Revision 1.58  2008/12/19 09:59:15  lulin
// - <K>: 128288713. Хак для того, чтобы наследоваться от сгенерированных форм.
//
// Revision 1.57  2008/05/29 12:48:41  mmorozov
// - bugfix: свойство UseToolbarOfUserTypeName не очищалось.
//
// Revision 1.56  2008/05/29 12:26:58  mmorozov
// - new: возможность определить от какого типа использовать панель инструментов (CQ: OIT5-28281).
//
// Revision 1.55  2008/04/23 06:48:21  oman
// - new: Новое свойство DefaultStatusForm (cq28922)
//
// Revision 1.54  2007/10/05 11:04:12  oman
// - fix: Отъехал редатор шорткатов
//
// Revision 1.53  2007/05/31 13:53:20  oman
// - fix: Вкладка с галкой на повторную активацию теперь закрывается,
//  а не просто переключает навигатор на предыдущую активную
//  - переименовано свойство в соответствии со смыслом (cq25230)
//
// Revision 1.52  2007/04/06 06:15:52  oman
// Не собиралась библиотека
//
// Revision 1.51  2007/03/14 06:48:07  mmorozov
// - new: редактор для TvcmMainForm, '_TasksPanelZone';
//
// Revision 1.50  2007/01/26 15:34:44  lulin
// - выделяем сущности с ТОЛЬКО внутренними операциями.
//
// Revision 1.49  2007/01/18 11:47:45  oman
// - new: Локализация библиотек - vcm (cq24078)
//
// Revision 1.48  2006/12/29 09:15:20  lulin
// - bug fix: не всем элементам можно было редактировать горячие клавиши.
//
// Revision 1.47  2005/10/31 10:51:25  lopatkin
// no message
//
// Revision 1.46  2005/09/23 06:50:57  mmorozov
// change: изменен способ определения активных форм при перезагрузке сборки;
//
// Revision 1.45  2005/09/22 16:28:40  mmorozov
// new: редакторы для определения активной формы в коллекциях сборок;
//
// Revision 1.44  2005/09/20 14:08:34  lulin
// - редактор сборки форм от Алексея Денисова.
//
// Revision 1.43  2005/08/03 12:29:25  mmorozov
// rename: OwnerItem -> OwnerForm;
//
// Revision 1.42  2005/08/02 12:40:50  mmorozov
// new: редактор для свойства TvcmFormSetFactory.OwnerItem;
//
// Revision 1.41  2005/07/28 14:29:06  mmorozov
// new: список форм является сортированным;
//
// Revision 1.40  2005/07/26 14:35:54  mmorozov
// new: редактор _TvcmFormSetItemUserTypeProperty;
//
// Revision 1.39  2005/07/25 12:10:15  mmorozov
// new: TvcmProjectFormNameProperty;
// new: регистрация TvcmFormSetFactory, TvcmFormSetFactoryWizard;
//
// Revision 1.38  2005/06/22 06:32:54  mmorozov
// - format code;
//
// Revision 1.37  2005/03/21 13:14:07  am
// change: регистрируем _TvcmPopupMenuPrim в палитре
//
// Revision 1.36  2005/01/20 15:43:29  lulin
// - new behavior: рисуем * перед сущностями с внутренними операциями и ! перед сущностями без операций.
//
// Revision 1.35  2005/01/17 09:30:35  lulin
// - bug fix: не компилировалось.
//
// Revision 1.34  2004/11/15 10:56:39  lulin
// - new behavior: _ExcludeUserTypes теперь в Design-Time показываются в виде строки.
//
// Revision 1.33  2004/10/05 13:32:46  lulin
// - для редактора сущностей/операций добавлено окно для Help'а - на будущее.
//
// Revision 1.32  2004/10/04 09:12:13  demon
// - fix: не работал Drag'n'drop для первой операции в сущности.
//
// Revision 1.31  2004/09/27 15:24:54  lulin
// - bug fix: при редактировании StdRes очищался список операций.
//
// Revision 1.30  2004/09/23 09:17:55  lulin
// - bug fix.
//
// Revision 1.29  2004/09/22 14:32:47  lulin
// - доделан DblClick в коллекции форм (открывает форму). Для этого пришлось завести свойство TvcmFormsCollectionItem.FormFile, т.к. я не нашел как средствами ToolsAPI найти файл от формы проекта.
//
// Revision 1.28  2004/09/22 13:19:15  lulin
// - DblClick в коллекции форм открывает форму.
//
// Revision 1.27  2004/09/21 09:34:15  lulin
// - bug fix: неправильно регистрировался редактор свойства.
//
// Revision 1.26  2004/09/17 16:06:53  lulin
// - сделана возможность переноса операций между сущностями.
//
// Revision 1.24  2004/09/17 08:50:37  lulin
// - редактор сущностей и опреаций теперь полностью работоспособен.
//
// Revision 1.23  2004/09/17 08:10:46  lulin
// - bug fix: неправильно работали удаление/вставка операций, а также отдельной окно с операциями.
//
// Revision 1.22  2004/09/16 15:00:41  lulin
// - в диалоге редактирования сущностей сразу выводим операции текущей сущности.
//
// Revision 1.21  2004/06/10 14:20:27  mmorozov
// new: property editor TvcmMessageCategoryProperty (class TvcmMessagesCollectionItem, propety '_Category');
//
// Revision 1.20  2004/03/20 15:25:40  mmorozov
// new: редактор TvcmFormActivateTypeProperty;
//
// Revision 1.19  2004/03/20 09:46:49  mmorozov
// - переименованы редакторы для свойств _TvcmFormActivate;
// new: используем атрибут свойства paSortList вместо самостоятельной сортировки;
// new: cEmptyUserType заменена на vcm_utAny;
// new: property editor TvcmFormActivateCaptionProperty;
// new: в редакторах _TvcmFormActivateUserTypeProperty и TvcmFormActivateNameProperty логика работы со свойством _TvcmFormActivate.Caption;
//
// Revision 1.18  2004/03/19 13:24:22  mmorozov
// new: редакторы свойств TvcmLinkFormForActivateBaseProperty, TvcmLinkFormForActivateUserTypeProperty, TvcmLinkFormForActivateFormNameProperty;
//
// Revision 1.17  2004/01/14 16:18:20  law
// - new units: vcmBaseOperationState, vcmBaseOperationStates.
//
// Revision 1.16  2004/01/14 14:27:41  law
// - new property editor.
//
// Revision 1.15  2003/11/19 16:38:21  law
// - new: сделан "человеческий" редактор для свойства _ExcludeUserTypes.
//
// Revision 1.14  2003/11/19 11:38:28  law
// - new behavior: регистрируем все сущности и операции в MenuManager'е для дальнейшей централизации редактирования. Само редактирование пока не доделано.
//
// Revision 1.13  2003/10/28 09:07:37  law
// - new prop: TvcmCustomMenuManager.MainMenuItems.
//
// Revision 1.12  2003/10/24 09:22:05  law
// - new prop: TvcmOperationsCollectionItem._Category.
//
// Revision 1.11  2003/10/09 12:50:16  law
// - new prop: TvcmUserTypesCollectionItem.ImageIndex.
//
// Revision 1.10  2003/07/24 11:35:12  law
// - new prop: TvcmEntityForm._ToolbarPos.
//
// Revision 1.9  2003/06/19 15:12:01  law
// - new method: IvcmDispatcher.UpdateStatus.
// - new prop: TvcmMainForm.OnUpdateStatus.
//
// Revision 1.8  2003/06/06 11:41:20  law
// - new methods: IvcmEntityForm.LoadState, SaveState.
// - new prop: TvcmEntityForm.OnLoadState, OnSaveState.
//
// Revision 1.7  2003/06/06 10:32:44  law
// - change: введена новая категория свойств vcm.
//
// Revision 1.6  2003/04/21 15:51:06  law
// - new: реализуем описание зон докинга в TvcmContainerForm - свойство Zones.
//
// Revision 1.5  2003/04/08 15:00:01  law
// - change: новый редактор свойства ImageIndex - с возможностью выбора из большого списка.
//
// Revision 1.4  2003/04/08 10:33:35  law
// - bug fix: был мусор при отсутствии иконки.
//
// Revision 1.3  2003/04/04 12:44:56  law
// - new behavior: теперь иконки рисуются и в инспекторе объекта.
//
// Revision 1.2  2003/04/04 11:29:47  law
// - new behavior: сделана возможность выбора имени модуля, при подписке на события.
//
// Revision 1.1  2003/04/01 12:54:46  law
// - переименовываем MVC в VCM.
//
// Revision 1.19  2003/03/28 15:45:21  law
// - сделан эксперт создания новой формы сущности.
//
// Revision 1.18  2003/03/28 15:24:17  law
// - сделан эксперт создания нового модуля.
//
// Revision 1.17  2003/03/28 11:27:26  law
// - по идее Вована сделал редактор компонента, позволяющий быстро привязывать компонент к сущностям.
//
// Revision 1.16  2003/03/27 17:50:57  law
// - по идее Вована начал делать редактор компонента, позволяющий быстро привязывать компонент к сущностям.
//
// Revision 1.15  2003/03/27 16:50:06  law
// - новая сборка библиотеки.
//
// Revision 1.14  2003/03/27 16:25:48  law
// - сделано более удобное редактирование сущностей и операций в Design-Time.
//
// Revision 1.13  2003/03/27 16:00:52  law
// - сделано более удобное редактирование сущностей и операций в Design-Time.
//
// Revision 1.12  2003/03/27 14:36:53  law
// - new prop: операция теперь имеет картинку.
//
// Revision 1.11  2003/03/25 10:34:25  law
// - new prop: TvcmOperationsCollectionItem.ShortCut.
//
// Revision 1.10  2003/03/21 11:32:12  law
// - change: добавлены редакторы свойства Caption.
//
// Revision 1.9  2003/03/21 10:13:36  law
// - cleanup: удалены модули vcm*Repository.
//
// Revision 1.8  2003/03/18 16:14:33  law
// - change: добавлены редакторы свойств имен сущности, операции и категории сущности.
//
// Revision 1.7  2003/03/14 14:55:47  law
// - new units: vcmBaseMenuManager, vcmMenuManager.
//
// Revision 1.6  2003/03/14 12:20:53  law
// - change: отвязываем vcm от l3.
//
// Revision 1.5  2003/03/13 16:37:22  law
// - change: попытка портировать на Builder.
//
// Revision 1.4  2003/03/13 09:52:03  law
// - new component: TvcmModuleDef.
//
// Revision 1.3  2003/03/12 15:26:21  law
// - new component: _TvcmOperations.
//
// Revision 1.2  2003/03/11 16:24:27  law
// - cleanup.
// - new behavior: добавлен редактор компонента TvcmEntities.
//
// Revision 1.1  2003/03/11 08:37:34  law
// - new unit: vcmEntities.
//

{$Include vcmDefine.inc }

interface

{$IfNDef NoVCM}

procedure Register;

{$EndIf  NoVCM}

implementation

{$IfNDef NoVCM}

uses
  Types,
  Classes,
  SysUtils,
  StrUtils,
  Graphics,
  ImgList,
  Math,
  Controls,
  ExtCtrls,
  Forms, 

  TypInfo,
  DesignIntf,
  DesignEditors,
  DesignMenus,
  VCLEditors,
  ToolsAPI,

  ColnEdit,
  ToolWin,
  ToolWnds,
  ComCtrls,
  ActnList,
  Menus,

  afwFacade,

  vcmUserControls,
  vcmBase,
  vcmAction,
  vcmBaseCollection,
  vcmBaseCollectionItem,
  vcmBaseEntities,
  vcmBaseEntitiesCollection,
  vcmBaseEntitiesCollectionItem,
  vcmBaseUserTypesCollectionItem,
  vcmBaseMenuManager,
  vcmBaseOperationsCollection,
  vcmOperationParams,
  vcmBaseOperationsCollectionItem,
  vcmBaseOperationState,
  vcmBaseOperationStates,
  vcmContainerForm,
  vcmEntities,
  vcmEntitiesCollection,
  vcmEntitiesCollectionItem,
  vcmEntityForm,
  //vcmEntityParamsForm,
  //vcmEntityWizard,
  vcmForm,
  vcmFormsCollection,
  vcmFormsCollectionItem,
  vcmImageListForm,
  vcmInterfaces,
  vcmMainForm,
  vcmMenuItemsCollectionItem,
  vcmMenuManager,
  vcmMenus,
  vcmMessagesCollectionItem,
  vcmModule,
  vcmApplication,
  vcmModuleDef,
  //vcmModuleWizard,
  //vcmOperationParamsForm,
  vcmOperations,
  vcmOperationsCollection,
  vcmOperationsCollectionItem,
  vcmOperationState,
  vcmOperationStates,
  vcmRepOperationsCollectionItem,
  vcmRepositoryEx,
  vcmUserTypesCollection,
  vcmUserTypesCollectionItem,
  vcmFormSetFactory,
  //vcmFormSetFactoryWizard,
  vcmFormsetFormsCollection,
  vcmFormSetFormsCollectionItem,
  vcmEntityFormRef,
  vcmContainerFormRef,
  vcmMainFormRef
  ;

const
  vcmRepeatedActivationBehaviourName: Array [TvcmRepeatedActivationBehaviour] of String =
   ('Ничего', 'Закрывать', 'Переключать на предыдущую', 'Выполнить если активна');

(*// start class TvcmEntitiesEditor

type
  TvcmEntitiesEditor = class(TDefaultEditor)
  protected
    procedure RunPropertyEditor(const Prop: IProperty);
    procedure RunEntityEditor(const Prop: IProperty);
  public
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer): string; override;
    function GetVerbCount : Integer; override;
    procedure Edit; override;
  end;//TvcmEntitiesEditor

procedure TvcmEntitiesEditor.Edit;
var
 Components: IDesignerSelections;
begin
 Components := CreateSelectionList;
 Components.Add(Component);
 GetComponentProperties(Components, [tkClass], Designer, RunPropertyEditor);
end;

procedure TvcmEntitiesEditor.RunPropertyEditor(const Prop: IProperty);
begin
 if SameText(Prop.GetName, 'ENTITIES') then
  Prop.Edit;
end;

procedure TvcmEntitiesEditor.RunEntityEditor(const Prop: IProperty);
begin
 if SameText(Prop.GetName, 'OPERATIONS') then
  Prop.Edit;
end;

procedure TvcmEntitiesEditor.ExecuteVerb(Index: Integer);
var
 Components: IDesignerSelections;
begin
 if (Index = 0) then
  Edit
 else if (Index = 1) then
  TvcmEntityParams.Execute(GetComponent As TvcmBaseEntities)
 else begin
  Components := CreateSelectionList;
  Components.Add((GetComponent As TvcmBaseEntities).Entities.Items[Index - 2]);
  GetComponentProperties(Components, [tkClass], Designer, RunEntityEditor);
 end;
end;

function TvcmEntitiesEditor.GetVerb(Index: Integer): string;
begin
 if (Index = 0) then
  Result := 'Сущности...'
 else if (Index = 1) then
  Result := 'Добавить сущность...'
 else
  Result := ((GetComponent As TvcmBaseEntities).Entities.Items[Index - 2] As TvcmBaseEntitiesCollectionItem).Caption;
end;

function TvcmEntitiesEditor.GetVerbCount: Integer;
begin
 Result := 2;
 Inc(Result, (GetComponent As TvcmBaseEntities).Entities.Count);
end;*)

(*// start class TvcmOperationsEditor

type
  TvcmOperationsEditor = class(TDefaultEditor)
    protected
      procedure RunPropertyEditor(const Prop: IProperty);
      procedure RunOperationEditor(const Prop: IProperty);
    public
      procedure ExecuteVerb(Index : Integer); override;
      function GetVerb(Index : Integer): string; override;
      function GetVerbCount : Integer; override;
      procedure Edit; override;
  end;//TvcmOperationsEditor

procedure TvcmOperationsEditor.Edit;
var
 Components: IDesignerSelections;
begin
 Components := CreateSelectionList;
 Components.Add(Component);
 GetComponentProperties(Components, [tkClass], Designer, RunPropertyEditor);
end;

procedure TvcmOperationsEditor.RunPropertyEditor(const Prop: IProperty);
begin
 if SameText(Prop.GetName, 'OPERATIONS') then
  Prop.Edit;
end;

procedure TvcmOperationsEditor.RunOperationEditor(const Prop: IProperty);
begin
 if SameText(Prop.GetName, 'ONEXECUTE') then
  Prop.Edit;
end;

procedure TvcmOperationsEditor.ExecuteVerb(Index: Integer);
var
 Components: IDesignerSelections;
begin
 if (Index = 0) then
  Edit
 else if (Index = 1) then begin
  if (TvcmOperationParams.Execute(GetComponent As TvcmCustomOperations) <> nil) then
   ExecuteVerb((GetComponent As TvcmCustomOperations).Operations.Count + 1);
 end else begin
  Components := CreateSelectionList;
  Components.Add((GetComponent As TvcmCustomOperations).Operations.Items[Index - 2]);
  GetComponentProperties(Components, tkMethods, Designer, RunOperationEditor);
 end;
end;

function TvcmOperationsEditor.GetVerb(Index: Integer): string;
begin
 if (Index = 0) then
  Result := 'Операции...'  { Menu item caption for context menu }
 else if (Index = 1) then
  Result := 'Добавить операцию...' 
 else
  Result := ((GetComponent As TvcmCustomOperations).Operations.Items[Index - 2] As TvcmBaseOperationsCollectionItem).Caption;
end;

function TvcmOperationsEditor.GetVerbCount: Integer;
begin
  Result := 2;
  Inc(Result, (GetComponent As TvcmCustomOperations).Operations.Count);
end;*)

type
  TvcmListedProperty = class(TStringProperty)
    public
    //public methods
      function GetAttributes: TPropertyAttributes;
        override;
        {-}
  end;//TvcmListedProperty

function TvcmListedProperty.GetAttributes: TPropertyAttributes;
begin
 Result := inherited GetAttributes + [paValueList];
end;

{ TvcmUseToolbarOfUserTypeNameProperty }

type
  TvcmUseToolbarOfUserTypeNameProperty = class(TvcmListedProperty)
  public
    procedure SetValue(const Value: String);
      override;
      {-}
    procedure GetValues(Proc : TGetStrProc);
      override;
      {-}
    function GetValue : String;
      override;
      {-}
  end;

function TvcmUseToolbarOfUserTypeNameProperty.GetValue: String;
var
 l_UT      : TvcmBaseUserTypesCollectionItem;
 l_FoundUT : TvcmBaseUserTypesCollectionItem;
begin
 l_UT := GetComponent(0) as TvcmBaseUserTypesCollectionItem;
 if l_UT.UseToolbarOfUserTypeName = '' then
  Result := l_UT.Caption
 else
 begin
  l_FoundUT := TvcmBaseUserTypesCollectionItem(TvcmBaseCollection(
   l_UT.Collection).FindItemByName(l_UT.UseToolbarOfUserTypeName));
  if l_FoundUT = nil then
   Result := l_UT.Caption
  else
   Result := l_FoundUT.Caption;
 end;
end;

procedure TvcmUseToolbarOfUserTypeNameProperty.GetValues(Proc: TGetStrProc);
var
 l_Index  : Integer;
 l_UTList : TvcmBaseCollection;
 l_UT     : TvcmBaseUserTypesCollectionItem;
begin
 l_UT := GetComponent(0) as TvcmBaseUserTypesCollectionItem;
 l_UTList := l_UT.Collection as TvcmBaseCollection;
 for l_Index := 0 to Pred(l_UTList.Count) do
  with TvcmBaseUserTypesCollectionItem(l_UTList.Items[l_Index]) do
   if Name <> l_UT.Name then
    // - не добавляем в список редактируемый тип формы;
    Proc(Caption);
end;

procedure TvcmUseToolbarOfUserTypeNameProperty.SetValue(const Value: String);
var
 l_FoundUT: TvcmBaseUserTypesCollectionItem;
begin
 with GetComponent(0) as TvcmBaseUserTypesCollectionItem do
 begin
  if Value <> '' then
  begin
   l_FoundUT := TvcmBaseUserTypesCollectionItem(
    TvcmBaseCollection(Collection).FindItemByCaption(Value));
   if l_FoundUT <> nil then
   begin
    SetStrValue(l_FoundUT.Name);
    Exit;
   end;//if l_FoundUT <> nil then
  end;//if Value <> '' then
  SetStrValue('');
 end;//with GetComponent(0) as TvcmBaseUserTypesCollectionItem do
end;//SetValue

{ TvcmProjectFormBaseProperty }

type
  TvcmProjectFormBaseProperty = class(TvcmListedProperty)
  protected
  //protected methods
    function GetFormCollectionItem(aName : String) : TvcmFormsCollectionItem;
     {-}
  end;

function TvcmProjectFormBaseProperty.GetFormCollectionItem(aName : String) : TvcmFormsCollectionItem;
var
 lIndex : Integer;
begin
 Result := nil;
 if Assigned(g_MenuManager) then
 begin
  for lIndex := 0 to Pred(g_MenuManager.AppForms.Count) do
  begin
   Result := TvcmFormsCollectionItem(g_MenuManager.AppForms.Items[lIndex]);
   if Result.Name = aName then
    Break;
   Result := nil;
  end;
 end;
end;

type
  TvcmRepeatedActivationBehaviourProperty = class(TvcmProjectFormBaseProperty)
  public
    function GetValue: String;
      override;
    procedure SetValue(const Value: String);
      override;
    procedure GetValues(Proc: TGetStrProc);
      override;
  end;

{ TvcmRepeatedActivationBehaviorProperty }

function TvcmRepeatedActivationBehaviourProperty.GetValue: String;
begin
 with GetComponent(0) As TvcmFormActivate do
  Result := vcmRepeatedActivationBehaviourName[RepeatedActivationBehaviour];
end;

procedure TvcmRepeatedActivationBehaviourProperty.GetValues(
  Proc: TGetStrProc);
var
 l_Behaviour : TvcmRepeatedActivationBehaviour;
begin
 for l_Behaviour := Low(TvcmRepeatedActivationBehaviour) to High(TvcmRepeatedActivationBehaviour) do
  Proc(vcmRepeatedActivationBehaviourName[l_Behaviour]);
end;

procedure TvcmRepeatedActivationBehaviourProperty.SetValue(
  const Value: String);
var
 l_Behaviour : TvcmRepeatedActivationBehaviour;
begin
 with GetComponent(0) As TvcmFormActivate do
 begin
  for l_Behaviour := Low(TvcmRepeatedActivationBehaviour) to High(TvcmRepeatedActivationBehaviour) do
   if vcmRepeatedActivationBehaviourName[l_Behaviour] = Value then
   begin
    RepeatedActivationBehaviour := l_Behaviour;
    Break;
   end;
 end;
end;

(*type
  TvcmFormActivateUserTypeProperty = class(TvcmProjectFormBaseProperty)
  public
  //public methods
    function GetValue: String;
      override;
      {-}
    procedure SetValue(const Value: String);
      override;
      {-}
    procedure GetValues(Proc: TGetStrProc);
      override;
      {-}
    function GetAttributes: TPropertyAttributes;
      override;
      {-}
  end;

function TvcmFormActivateUserTypeProperty.GetAttributes: TPropertyAttributes;
  //override;
begin
 Result := inherited GetAttributes + [paValueList];
end;

function TvcmFormActivateUserTypeProperty.GetValue: String;
  //override;
var
 lForm : TvcmFormsCollectionItem;
begin
 with GetComponent(0) As TvcmFormActivate do
 begin
  { Установим UserType на случай если Name = '', или UserTypes.Count = 0,
    или UserType = cEmptyUserType }
  Result := IntToStr(UserType);
  { Имя формы установлено }
  if (Name <> '') and (UserType <> vcm_utAny) then
  begin
   { Получим TvcmFormsCollectionItem }
   lForm := GetFormCollectionItem(Name);
   { Имя пользовательского типа }
   if Assigned(lForm) then
    Result := lForm.UserTypes[UserType].Caption;
  end
 end;
end;

procedure TvcmFormActivateUserTypeProperty.SetValue(const Value: String);
  //override;
var
 lIndex : Integer;
 lForm  : TvcmFormsCollectionItem;
begin
 with GetComponent(0) As TvcmFormActivate do
 begin
  UserType := vcm_utAny;
  Caption := '';
  if (Name <> '') then
  begin
   { Получим TvcmFormsCollectionItem }
   lForm := GetFormCollectionItem(Name);
   if Assigned(lForm) then
   begin
    { Найдем в пользовательских типах значение }
    for lIndex := 0 to Pred(lForm.UserTypes.Count) do
     { Запишем значение }
     if lForm.UserTypes.Items[lIndex].Caption = Value then
     begin
      UserType := lIndex;
      Caption := lForm.UserTypes.Items[lIndex].Caption;
      Break;
     end;
    { Пользовательский тип не найден установим имя формы }
    if UserType = vcm_utAny then
     Caption := lForm.Caption;
   end;
  end
 end;
end;

procedure TvcmFormActivateUserTypeProperty.GetValues(Proc: TGetStrProc);
  //override;
var
 lIndex : Integer;
 lForm  : TvcmFormsCollectionItem;
begin
 with GetComponent(0) As TvcmFormActivate do
  if (Name <> '') then
  begin
   lForm := GetFormCollectionItem(Name);
   if Assigned(lForm) then
    for lIndex := 0 to Pred(lForm.UserTypes.Count) do
     Proc(lForm.UserTypes.Items[lIndex].Caption);
  end;
end;*)

{ TvcmFormSetItemUserTypeProperty }
(*type
  TvcmFormSetItemUserTypeProperty = class(TvcmProjectFormBaseProperty)
    {* - редактирование элемента коллекции сборки. }
    procedure SetValue(const Value: String);
      override;
      {-}
    procedure GetValues(Proc : TGetStrProc);
      override;
      {-}
    function GetValue : String;
      override;
      {-}
  end;

procedure TvcmFormSetItemUserTypeProperty.SetValue(const Value: String);
  // override;
  {-}
var
 lIndex : Integer;
 lForm  : TvcmFormsCollectionItem;
begin
 with GetComponent(0) As TvcmFormSetFormsCollectionItem do
 begin
  UserType := vcm_utAny;
  if (_FormName <> '') then
  begin
   { Получим TvcmFormsCollectionItem }
   lForm := GetFormCollectionItem(_FormName);
   if Assigned(lForm) then
   begin
    { Найдем в пользовательских типах значение }
    for lIndex := 0 to Pred(lForm.UserTypes.Count) do
     { Запишем значение }
     if lForm.UserTypes.Items[lIndex].Caption = Value then
     begin
      UserType := lIndex;
      Break;
     end;
   end;
  end
 end;
end;

procedure TvcmFormSetItemUserTypeProperty.GetValues(Proc : TGetStrProc);
  // override;
  {-}
var
 lIndex : Integer;
 lForm  : TvcmFormsCollectionItem;
begin
 with GetComponent(0) As TvcmFormSetFormsCollectionItem do
  if (_FormName <> '') then
  begin
   lForm := GetFormCollectionItem(_FormName);
   if Assigned(lForm) then
    for lIndex := 0 to Pred(lForm.UserTypes.Count) do
     Proc(lForm.UserTypes.Items[lIndex].Caption);
  end;
end;

function TvcmFormSetItemUserTypeProperty.GetValue : String;
  // override;
 {-}
var
 lForm : TvcmFormsCollectionItem;
begin
 with GetComponent(0) As TvcmFormSetFormsCollectionItem do
 begin
  { Установим UserType на случай если Name = '', или UserTypes.Count = 0,
    или UserType = cEmptyUserType }
  Result := IntToStr(UserType);
  { Имя формы установлено }
  if (_FormName <> '') and (UserType <> vcm_utAny) then
  begin
   { Получим TvcmFormsCollectionItem }
   lForm := GetFormCollectionItem(_FormName);
   { Имя пользовательского типа }
   if Assigned(lForm) then
    Result := lForm.UserTypes[UserType].Caption;
  end
 end;
end;*)

type
  TvcmProjectFormNameProperty = class(TvcmListedProperty)
  {* - возможность выбора формы проекта. }
  // public methods
    procedure GetValues(Proc : TGetStrProc);
      override;
      {-}
    function GetAttributes: TPropertyAttributes;
      override;
      {-}
  end;

function TvcmProjectFormNameProperty.GetAttributes: TPropertyAttributes;
  // override;
  {-}
begin
 Result := inherited GetAttributes;
 Include(Result, paSortList);
end;

procedure TvcmProjectFormNameProperty.GetValues(Proc : TGetStrProc);
  //override;
  {-}
var
 lIndex   : Integer;
begin
 if Assigned(g_MenuManager) then
  { Список форм проекта }
  for lIndex := 0 to Pred(g_MenuManager.AppForms.Count) do
   Proc(g_MenuManager.AppForms.Items[lIndex].Name);
end;

type
  TvcmFormActivateNameProperty = class(TvcmProjectFormBaseProperty)
  public
  //public methods
    procedure GetValues(Proc: TGetStrProc);
      override;
      {-}
    procedure SetValue(const Value: String);
      override;
      {-}
    function GetAttributes : TPropertyAttributes;
      override;
      {-}
  end;//TvcmFormActivateName

function TvcmFormActivateNameProperty.GetAttributes : TPropertyAttributes;
  //override;
begin
 Result := inherited GetAttributes + [paSortList];
end;

procedure TvcmFormActivateNameProperty.SetValue(const Value: String);
  //override;
var
 lForm : TvcmFormsCollectionItem;
begin
 with GetComponent(0) As TvcmFormActivate do
 begin
  lForm := GetFormCollectionItem(Value);
  if Assigned(lForm) then
  begin
   Name := lForm.Name;
   if UserType = vcm_utAny then
    Caption := lForm.Caption;
  end
  else
   Name := '';
 end;
end;

procedure TvcmFormActivateNameProperty.GetValues(Proc: TGetStrProc);
  //override;
var
 lIndex   : Integer;
begin
 if Assigned(g_MenuManager) then
  { Создадим список форм }
  for lIndex := 0 to Pred(g_MenuManager.AppForms.Count) do
   Proc(TvcmFormsCollectionItem(g_MenuManager.AppForms.Items[lIndex]).
    Name);
end;

type
  TvcmFormActivateCaptionProperty = class(TStringProperty)
  public
  //public methods
    function GetAttributes: TPropertyAttributes;
      override;
      {-}
  end;

function TvcmFormActivateCaptionProperty.GetAttributes: TPropertyAttributes;
  //override;
begin
 Result := inherited GetAttributes + [paReadOnly];
end;

(*type
  TvcmEntityCategoryProperty = class(TvcmListedProperty)
    public
    //public methods
      procedure GetValues(Proc: TGetStrProc);
        override;
        {-}
  end;//TvcmEntityCategoryProperty

procedure TvcmEntityCategoryProperty.GetValues(Proc: TGetStrProc);
  //override;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 0 to Pred(vcmGetCount(vcm_repEntityCategory)) do
  Proc(vcmGetName(vcm_repEntityCategory, l_Index));
 for l_Index := 0 to Pred(vcmGetCount(vcm_repEntityCaption)) do
  Proc(vcmGetName(vcm_repEntityCaption, l_Index));
end;*)

(*type
  TvcmMenuItemsCaptionProperty = class(TvcmListedProperty)
    public
    //public methods
      procedure GetValues(Proc: TGetStrProc);
        override;
        {-}
  end;//TvcmMenuItemsCaptionProperty

procedure TvcmMenuItemsCaptionProperty.GetValues(Proc: TGetStrProc);
  //override;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 0 to Pred(vcmGetCount(vcm_repEntityCategory)) do
  Proc(vcmGetName(vcm_repEntityCategory, l_Index));
 for l_Index := 0 to Pred(vcmGetCount(vcm_repEntityCaption)) do
  Proc(vcmGetName(vcm_repEntityCaption, l_Index));
end;*)

type
  TvcmEntityNameProperty = class(TvcmListedProperty)
    public
    //public methods
      procedure GetValues(Proc: TGetStrProc);
        override;
        {-}
  end;//TvcmEntityNameProperty

procedure TvcmEntityNameProperty.GetValues(Proc: TGetStrProc);
  //override;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 0 to Pred(vcmGetCount(vcm_repEntity)) do
  Proc(vcmGetName(vcm_repEntity, l_Index));
end;

type
  TvcmOperationNameProperty = class(TvcmListedProperty)
    public
    //public methods
      procedure GetValues(Proc: TGetStrProc);
        override;
        {-}
  end;//TvcmOperationNameProperty

procedure TvcmOperationNameProperty.GetValues(Proc: TGetStrProc);
  //override;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 0 to Pred(vcmGetCount(vcm_repOperation)) do
  Proc(vcmGetName(vcm_repOperation, l_Index));
end;

type
  TvcmModuleNameProperty = class(TvcmListedProperty)
    public
    //public methods
      procedure GetValues(Proc: TGetStrProc);
        override;
        {-}
  end;//TvcmModuleNameProperty

procedure TvcmModuleNameProperty.GetValues(Proc: TGetStrProc);
  //override;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 0 to Pred(vcmGetCount(vcm_repModule)) do
  Proc(vcmGetName(vcm_repModule, l_Index));
end;

type
  TvcmOperationCaptionProperty = class(TvcmListedProperty)
    public
    //public methods
      procedure GetValues(Proc: TGetStrProc);
        override;
        {-}
  end;//TvcmOperationCaptionProperty

procedure TvcmOperationCaptionProperty.GetValues(Proc: TGetStrProc);
  //override;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 0 to Pred(vcmGetCount(vcm_repOperationCaption)) do
  Proc(vcmGetName(vcm_repOperationCaption, l_Index));
end;

type
  TvcmEntityCaptionProperty = class(TvcmListedProperty)
    public
    //public methods
      procedure GetValues(Proc: TGetStrProc);
        override;
        {-}
  end;//TvcmEntityCaptionProperty

procedure TvcmEntityCaptionProperty.GetValues(Proc: TGetStrProc);
  //override;
  {-}
var
 l_Index : Integer;
begin
 for l_Index := 0 to Pred(vcmGetCount(vcm_repEntityCaption)) do
  Proc(vcmGetName(vcm_repEntityCaption, l_Index));
end;

type
  TvcmImageIndexProperty = class(TIntegerProperty, ICustomPropertyDrawing, ICustomPropertyListDrawing)
    public
    // public methods
      procedure Edit;
        override;
        {-}
      function GetAttributes: TPropertyAttributes;
        override;
        {-}
      procedure GetValues(Proc: TGetStrProc);
        override;
        {-}
      { ICustomPropertyListDrawing }
      procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
        var AHeight: Integer);
        {-}
      procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
        var AWidth: Integer);
        {-}
      procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
        const ARect: TRect; ASelected: Boolean);
        {-}
      { CustomPropertyDrawing }
      procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect;
        ASelected: Boolean);
      procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
        ASelected: Boolean);
  end;//TvcmImageIndexProperty

procedure TvcmImageIndexProperty.Edit;
  //override;
  {-}
begin
 TvcmImageList.Execute(Self, vcmGetActionList.Images);
end;
  
function TvcmImageIndexProperty.GetAttributes: TPropertyAttributes;
  //override;
  {-}
begin
 Result := inherited GetAttributes + [paValueList, paDialog];
end;

procedure TvcmImageIndexProperty.GetValues(Proc: TGetStrProc);
  //override;
  {-}
var
 l_Index  : Integer;
 l_Images : TCustomImageList;
begin
 l_Images := vcmGetActionList.Images;
 if (l_Images <> nil) then
  for l_Index := -1 to Pred(l_Images.Count) do
   Proc(IntToStr(l_Index));
end;

procedure TvcmImageIndexProperty.ListMeasureHeight(const Value: string; ACanvas: TCanvas;
  var AHeight: Integer);
var
 l_Images : TCustomImageList;
begin
 l_Images := vcmGetActionList.Images;
 if (l_Images <> nil) then
  aHeight := Max(aHeight, l_Images.Height);
end;

procedure TvcmImageIndexProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
var
 l_Images : TCustomImageList;
begin
 l_Images := vcmGetActionList.Images;
 if (l_Images <> nil) then
  aWidth := aWidth + l_Images.Width;
end;

procedure TvcmImageIndexProperty.ListDrawValue(const Value: string; ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
var
 l_Right  : Integer;
 l_Index  : Integer;
 l_Images : TCustomImageList;
begin
 l_Right := aRect.Left;
 l_Images := vcmGetActionList.Images;
 if (l_Images <> nil) then begin
  Inc(l_Right, l_Images.Width);
  try
   l_Index := StrToInt(Value);
  except
   l_Index := -1;
  end;//try..except
  aCanvas.FillRect(Rect(ARect.Left, ARect.Top, l_Right, aRect.Bottom));
  if (l_Index >= 0) then begin
   l_Images.Draw(aCanvas, aRect.Left, aRect.Top, l_Index);
  end;//l_Index >= 0
 end;//l_Images <> nil
 DefaultPropertyListDrawValue(Value, ACanvas, Rect(l_Right, ARect.Top,
   ARect.Right, ARect.Bottom), ASelected);
end;

procedure TvcmImageIndexProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

procedure TvcmImageIndexProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  if GetVisualValue <> '' then
    ListDrawValue(GetVisualValue, ACanvas, ARect, True{ASelected})
  else
    DefaultPropertyDrawValue(Self, ACanvas, ARect);
end;

type
  TvcmExcludeUserTypeProperty = class(TSetElementProperty)
    private
    // internal fields
      f_Name : String;
    public
    // public methods
      constructor Create(Parent      : TPropertyEditor;
                         AElement    : Integer;
                         const aName : String);
        reintroduce;
        {-}
      function GetName: string;
        override;
        {-}
  end;//TvcmExcludeUserTypeProperty

constructor TvcmExcludeUserTypeProperty.Create(Parent      : TPropertyEditor;
                                               AElement    : Integer;
                                               const aName : String);
  //reintroduce;
  {-}
begin
 inherited Create(Parent, aElement);
 f_Name := aName;
end;

function TvcmExcludeUserTypeProperty.GetName: string;
  //override;
  {-}
begin
 Result := f_Name;
end;

type
  TvcmOperationsCollectionEditor = class(TCollectionEditor)
    protected
    // internal methods
      procedure DoShow;
        override;
        {-}
      procedure MakeImages;
        {-}
      procedure ListView1DoubleClick(Sender: TObject);
        {-}
      procedure RunPropertyEditor(const Prop: IProperty);
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
      procedure ItemsModified(const ADesigner: IDesigner);
        override;
        {-}
  end;//TvcmOperationsCollectionEditor

constructor TvcmOperationsCollectionEditor.Create(anOwner: TComponent);
  //override;
  {-}
begin
 inherited;
 ListView1.SmallImages := vcmGetActionList.Images;
 ListView1.OnDblClick := ListView1DoubleClick;
end;

procedure TvcmOperationsCollectionEditor.DoShow;
  {-}
begin
 inherited;
 MakeImages;
end;

procedure TvcmOperationsCollectionEditor.MakeImages;
  {-}
var
 l_Index : Integer;
begin
 if (Collection <> nil) then
  for l_Index := 0 to Pred(Collection.Count) do
   ListView1.Items.Item[l_Index].ImageIndex :=
    TvcmBaseOperationsCollectionItem(Collection.Items[l_Index]).ImageIndex;
end;

procedure TvcmOperationsCollectionEditor.ListView1DoubleClick(Sender: TObject);
  {-}
var
 Components: IDesignerSelections;
begin
 if (Collection <> nil) then begin
  Components := CreateSelectionList;
  Designer.GetSelections(Components);
  GetComponentProperties(Components, tkMethods, Designer, RunPropertyEditor);
 end;//Collection <> nil
end;

procedure TvcmOperationsCollectionEditor.RunPropertyEditor(const Prop: IProperty);
begin
 if SameText(Prop.GetName, 'ONEXECUTE') then
  Prop.Edit;
end;

procedure TvcmOperationsCollectionEditor.ItemsModified(const ADesigner: IDesigner);
  //override;
  {-}
begin
 inherited;
 MakeImages;
end;

type
  TvcmOperationsCollectionProperty = class(TCollectionProperty)
    public
    // public methods
      function GetEditorClass: TCollectionEditorClass;
        override;
        {-}
  end;//TvcmOperationsCollectionProperty

function TvcmOperationsCollectionProperty.GetEditorClass: TCollectionEditorClass;
  //override;
  {-}
begin
 Result := TvcmOperationsCollectionEditor;
end;

type
  THackCollectionEditor = class(TToolbarDesignWindow)
  private
    Panel3: TPanel;
    ListView1: TListView;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    AddCmd: TAction;
    DeleteCmd: TAction;
    MoveUpCmd: TAction;
    MoveDownCmd: TAction;
    SelectAllCmd: TAction;
    N2: TMenuItem;
    FClosing: Boolean;
    FCollectionPropertyName: string;
    FStateLock: Integer;
    FItemIDList: TList;
    FAddedItemIDList: TList;
    FCollectionClassName: string;
  end;//THackCollectionEditor

  TvcmEntitiesCollectionEditor = class;

  TvcmOperationsCollectionEditorEx = class(TvcmOperationsCollectionEditor)
    private
    // internal fields
      f_Entities        : TvcmEntitiesCollectionEditor;
    protected
    // internal methods
      procedure DoCreate;
        override;
        {-}
      procedure FormCreate(Sender: TObject);
        {-}
      procedure AddClick(Sender: TObject);
        {-}
      procedure DeleteClick(Sender: TObject);
        {-}
      procedure MoveUpClick(Sender: TObject);
        {-}
      procedure MoveDownClick(Sender: TObject);
        {-}
      procedure StartDrag(Sender: TObject; var DragObject: TDragObject);
        {-}
      procedure EndDrag(Sender, Target: TObject; X, Y: Integer);
        {-}
    public
    // public methods
      constructor Create(anOwner    : TComponent;
                         anEntities : TvcmEntitiesCollectionEditor);
        reintroduce;
        {-}
  end;//TvcmOperationsCollectionEditorEx

  TvcmEntitiesCollectionEditor = class(TCollectionEditor)
    private
    // internal fields
      f_Lock            : Integer;
      f_MainPanel       : TPanel;
      f_OperationsPanel : TPanel;
      f_HelpPanel       : TPanel;
      f_Splitter        : TSplitter;
      f_HelpSplitter    : TSplitter;
      f_Operations      : TvcmOperationsCollectionEditorEx;
    protected
    // internal methods
      procedure ListView1DragOver(Sender, Source : TObject;
                                  X, Y           : Integer;
                                  State          : TDragState;
                                  var Accept     : Boolean);
        {-}
      procedure ListView1DragDrop(Sender, Source : TObject;
                                  X, Y           : Integer);
        {-}
      procedure ListView1DoubleClick(Sender: TObject);
        {-}
      procedure RunPropertyEditor(const Prop: IProperty);
        {-}
      procedure Activated;
        override;
        {-}
      procedure UpdateOperations;
        {-}
      procedure EntityChanged(Sender: TObject; Item: TListItem; Selected: Boolean);
        {-}
      procedure FormResize(Sender: TObject);
        {-}
      procedure DeleteClick(Sender: TObject);
        {-}
      procedure MakeOperations;
        {-}
      procedure DestroyOperations;
        {-}
      procedure TuneOperations;
        {-}
      procedure DoShow;
        override;
        {-}
      procedure InitListView;
        {-}
      procedure DrawEntityItem(Sender : TCustomListView;
                               Item   : TListItem;
                               Rect   : TRect;
                               State  : TOwnerDrawState);
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
  end;//TvcmEntitiesCollectionEditor

// start class TvcmOperationsCollectionEditorEx

constructor TvcmOperationsCollectionEditorEx.Create(anOwner    : TComponent;
                                                    anEntities : TvcmEntitiesCollectionEditor);
  //reintroduce;
  {-}
begin
 inherited Create(anOwner);
 f_Entities := anEntities;
 DeleteCmd.OnExecute := DeleteClick;
 AddCmd.OnExecute := AddClick;
 MoveUpCmd.OnExecute := MoveUpClick;
 MoveDownCmd.OnExecute := MoveDownClick;
 ListView1.OnStartDrag := StartDrag;
 ListView1.OnEndDrag := EndDrag;
end;

procedure TvcmOperationsCollectionEditorEx.DoCreate;
  //override;
  {-}
begin
 OnCreate := FormCreate;
 inherited;
end;

procedure TvcmOperationsCollectionEditorEx.FormCreate(Sender: TObject);
  {-}
begin
 THackCollectionEditor(Self).FItemIdList := TList.Create;
end;

procedure TvcmOperationsCollectionEditorEx.AddClick(Sender: TObject);
  {-}
begin
 Inc(f_Entities.f_Lock);
 try
  inherited;
 finally
  Dec(f_Entities.f_Lock);
 end;//try..finally
end;

procedure TvcmOperationsCollectionEditorEx.DeleteClick(Sender: TObject);
  {-}
begin
 Inc(f_Entities.f_Lock);
 try
  inherited;
 finally
  Dec(f_Entities.f_Lock);
 end;//try..finally
end;

procedure TvcmOperationsCollectionEditorEx.MoveUpClick(Sender: TObject);
  {-}
begin
 Inc(f_Entities.f_Lock);
 try
  inherited;
 finally
  Dec(f_Entities.f_Lock);
 end;//try..finally
end;

procedure TvcmOperationsCollectionEditorEx.MoveDownClick(Sender: TObject);
  {-}
begin
 Inc(f_Entities.f_Lock);
 try
  inherited;
 finally
  Dec(f_Entities.f_Lock);
 end;//try..finally
end;

procedure TvcmOperationsCollectionEditorEx.StartDrag(Sender: TObject; var DragObject: TDragObject);
  {-}
begin
 Inc(f_Entities.f_Lock);
end;

procedure TvcmOperationsCollectionEditorEx.EndDrag(Sender, Target: TObject; X, Y: Integer);
  {-}
begin
 Dec(f_Entities.f_Lock);
end;

// start class TvcmEntitiesCollectionEditor

constructor TvcmEntitiesCollectionEditor.Create(anOwner: TComponent);
  //override;
  {-}
begin
 inherited;
 DeleteCmd.OnExecute := DeleteClick;
 ListView1.OnDblClick := ListView1DoubleClick;
 ListView1.Align := alNone;
 ListView1.Width := 10;
 ListView1.Height := 10;
 ListView1.OnSelectItem := EntityChanged;
 ListView1.OnDragOver := ListView1DragOver;
 ListView1.OnDragDrop := ListView1DragDrop;
 OnResize := FormResize;
 PopupMenu := nil;
 ListView1.PopupMenu := PopupMenu1;

 f_MainPanel := TPanel.Create(Self);
 f_MainPanel.Align := alClient;
 f_MainPanel.Parent := Self;

 ListView1.Parent := f_MainPanel;

 f_OperationsPanel := TPanel.Create(Self);
 f_OperationsPanel.Align := alRight;
 f_OperationsPanel.Width := Width div 2;
 f_OperationsPanel.Parent := f_MainPanel;

 f_Splitter := TSplitter.Create(Self);
 f_Splitter.Align := alRight;
 f_Splitter.Parent := f_MainPanel;
 f_Splitter.Left := f_MainPanel.Width - f_OperationsPanel.Width;

 f_HelpPanel := TPanel.Create(Self);
 f_HelpPanel.Align := alBottom;
 f_HelpPanel.Width := Height div 4;
 f_HelpPanel.Parent := Self;
 f_HelpPanel.Caption := 'Это панель на будующее - для документирования элементов.';

 f_HelpSplitter := TSplitter.Create(Self);
 f_HelpSplitter.Align := alBottom;
 f_HelpSplitter.Parent := Self;
 f_Splitter.Top := Height - f_HelpPanel.Height;

 ListView1.Align := alClient;
 ListView1.OnDrawItem := DrawEntityItem;

 MakeOperations;

end;

procedure TvcmEntitiesCollectionEditor.EntityChanged(Sender: TObject; Item: TListItem; Selected: Boolean);
  {-}
begin
 if (f_Lock = 0) then
  UpdateOperations;
end;

procedure TvcmEntitiesCollectionEditor.FormResize(Sender: TObject);
  {-}
begin
 if (f_OperationsPanel <> nil) then
  f_OperationsPanel.Width := Width div 2;
end;
  
procedure TvcmEntitiesCollectionEditor.DeleteClick(Sender: TObject);
  {-}
begin
 DestroyOperations;
 inherited;
 MakeOperations;
 TuneOperations;
end;

procedure TvcmEntitiesCollectionEditor.MakeOperations;
  {-}
begin
 if (f_Operations = nil) then
  f_Operations := TvcmOperationsCollectionEditorEx.Create(Self, Self);
end;
  
procedure TvcmEntitiesCollectionEditor.DestroyOperations;
  {-}
begin
 FreeAndNil(f_Operations);
end;

procedure TvcmEntitiesCollectionEditor.TuneOperations;
  {-}
begin
 if (f_Operations <> nil) then
 begin
  if (Collection <> nil) AND (Collection.Count > 0) then
  begin
   f_OperationsPanel.Width := Width div 2;
   f_Operations.Options := [coAdd, coDelete, coMove];
   f_Operations.Designer := Designer;
   UpdateOperations;
   f_Operations.ListView1.PopupMenu := f_Operations.PopupMenu1;
   f_Operations.ListView1.Parent := f_OperationsPanel;
   f_Operations.ToolBar1.Parent := f_OperationsPanel;
   //f_OperationsPanel.ManualDock(f_Operations)
  end//Collection.Count > 0
  else
  begin
   f_Operations.Collection := nil;
   f_Operations.ListView1.Clear;
  end;//Collection <> nil..
 end;//f_Operations <> nil
end;

procedure TvcmEntitiesCollectionEditor.DoShow;
  //override;
  {-}
begin
 inherited;
 //InitListView;
end;

procedure TvcmEntitiesCollectionEditor.InitListView;
  {-}
var
 l_Index : Integer;
begin
 if (Collection <> nil) then
  for l_Index := 0 to Pred(Collection.Count) do
  begin
   with TvcmEntitiesCollectionItem(Collection.Items[l_Index]) do
   begin
    if HasInternalOperations then
    begin
     if HasOnlyInternalOperations then
      ListView1.Items.Item[l_Index].Caption := '#' + Caption
     else
      ListView1.Items.Item[l_Index].Caption := '*' + Caption
    end//HasInternalOperations
    else
    if (Operations = nil) OR (Operations.Count = 0) then
     ListView1.Items.Item[l_Index].Caption := '!' + Caption
    else
     ListView1.Items.Item[l_Index].Caption := Caption;
   end;//with TvcmEntitiesCollectionItem(Collection.Items[l_Index])
  end;//for l_Index..
end;

procedure TvcmEntitiesCollectionEditor.DrawEntityItem(Sender : TCustomListView;
                                                      Item   : TListItem;
                                                      Rect   : TRect;
                                                      State  : TOwnerDrawState);
  {-}
begin
 Sender.Canvas.FillRect(Rect);
 //Sender.Canvas.Font.Color := clRed;
 Sender.Canvas.TextOut(Rect.Left + 2, Rect.Top, Item.Caption);
end;

procedure TvcmEntitiesCollectionEditor.UpdateOperations;
  {-}
begin
 if (f_Operations = nil) then
  Exit;
 if (ListView1.ItemIndex < 0) then
  Exit;
 if (Collection = nil) then
 begin
  f_Operations.Collection := nil;
  f_Operations.ListView1.Clear;
  Exit;
 end;//Collection = nil
 f_Operations.Collection := TvcmBaseEntitiesCollectionItem(Collection.Items[ListView1.ItemIndex]).Operations;
 f_Operations.Component := Component;
 f_Operations.CollectionPropertyName := 'Operations';
 THackCollectionEditor(f_Operations).FCollectionClassName := TvcmBaseEntitiesCollectionItem(Collection.Items[0]).Operations.ClassName;
 f_Operations.UpdateListBox;
 f_Operations.MakeImages;
end;

procedure TvcmEntitiesCollectionEditor.Activated;
  //override;
  {-}
begin
 InitListView;
 TuneOperations;
 inherited;
end;

procedure TvcmEntitiesCollectionEditor.ListView1DragOver(Sender, Source : TObject;
                                                         X, Y           : Integer;
                                                         State          : TDragState;
                                                         var Accept     : Boolean);
  {-}
var
 Item: TListItem;
begin
 inherited;
 if not Accept AND (f_Operations <> nil) then
 begin
  // - проверим - уж не операция ли это
  Item := ListView1.GetItemAt(X, Y);
  Accept := (Item <> nil) and (Source = f_Operations.ListView1) and
    (not Item.Selected);
 end;//not Accept
end;

procedure TvcmEntitiesCollectionEditor.ListView1DragDrop(Sender, Source : TObject;
                                                         X, Y           : Integer);
  {-}
var
 l_OpIndex : Integer;
 l_OpItem  : TCollectionItem;
 l_EnItem  : TvcmBaseEntitiesCollectionItem;
 l_Item    : TListItem;
begin
 if (f_Operations <> nil) AND (Source = f_Operations.ListView1) AND
    (f_Operations.ListView1.ItemIndex >= 0) then
 begin
  l_OpIndex := f_Operations.ListView1.ItemIndex;
  if (l_OpIndex >= 0) then
  begin
   Inc(f_Lock);
   try
    l_OpItem := f_Operations.Collection.Items[l_OpIndex];
    if (l_OpItem <> nil) then
    begin
     l_Item := ListView1.GetItemAt(X, Y);
     if (l_Item <> nil) then
     begin
      l_EnItem := TvcmBaseEntitiesCollectionItem(Collection.Items[l_Item.Index]);
      if (l_EnItem <> nil) then
      begin
       l_EnItem.Operations.Add.Assign(l_OpItem);
       f_Operations.Collection.Delete(l_OpIndex);
      end;//l_EnItem <> nil
     end;//l_Item <> nil
    end;//l_OpItem <> nil
   finally
    Dec(f_Lock);
   end;//try..finally
   UpdateOperations;
  end;//f_Operations.ListView1.ItemIndex > 0
 end//f_Operations <> nil
 else
  inherited;
end;

procedure TvcmEntitiesCollectionEditor.ListView1DoubleClick(Sender: TObject);
  {-}
var
 Components: IDesignerSelections;
begin
 if (Collection <> nil) then begin
  Components := CreateSelectionList;
  Designer.GetSelections(Components);
  GetComponentProperties(Components, [tkClass], Designer, RunPropertyEditor);
 end;//Collection <> nil
end;

procedure TvcmEntitiesCollectionEditor.RunPropertyEditor(const Prop: IProperty);
begin
 if SameText(Prop.GetName, 'OPERATIONS') then
  Prop.Edit;
end;

type
  TvcmEntitiesCollectionProperty = class(TCollectionProperty)
    public
    // public methods
      function GetEditorClass: TCollectionEditorClass;
        override;
        {-}
  end;//TvcmEntitiesCollectionProperty

function TvcmEntitiesCollectionProperty.GetEditorClass: TCollectionEditorClass;
  //override;
  {-}
begin
 Result := TvcmEntitiesCollectionEditor;
end;

type
  TvcmFormsCollectionEditor = class(TCollectionEditor)
    protected
    // internal methods
      procedure DoShow;
        override;
        {-}
      procedure ListView1DoubleClick(Sender: TObject);
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
  end;//TvcmFormsCollectionEditor

constructor TvcmFormsCollectionEditor.Create(anOwner: TComponent);
  //override;
  {-}
begin
 inherited;
 ListView1.SmallImages := vcmGetActionList.Images;
 ListView1.OnDblClick := ListView1DoubleClick;
end;

procedure TvcmFormsCollectionEditor.DoShow;
  {-}
begin
 inherited;
end;

procedure TvcmFormsCollectionEditor.ListView1DoubleClick(Sender: TObject);
  {-}
var
 l_Name : String;
 l_M    : IOTAModule;
 l_E    : IOTAEditor;
 //l_A    : IOTAActionServices;
begin
 if (ListView1.ItemIndex >= 0) then
 begin
  l_Name := TvcmFormsCollectionItem
  (Collection.Items[ListView1.ItemIndex]).Name;
  l_M := vcmGetTAModules.FindFormModule(l_Name);
  if (l_M <> nil) then
  begin
   if (l_M.ModuleFileCount > 0) then
   begin
    l_E := l_M.ModuleFileEditors[0];
    if (l_E <> nil) then
    begin
     l_E.Show;
     Exit;
    end;//l_E <> nil
   end;//l_M.ModuleFileCount > 0
  end;//l_M <> nil
(*  if Supports(vcmGetTAModules, IOTAActionServices, l_A) then
  begin
   l_Name := g_MenuManager.UnitPath;
   if not ANSIEndsText('\', l_Name) then
    l_Name := l_Name + '\';
   l_Name := l_Name + TvcmFormsCollectionItem(Collection.Items[ListView1.ItemIndex]).FormFile;
   l_A.OpenFile(l_Name);
  end;//Supports(vcmGetTAModules, IOTAActionServices, l_A)*)
 end;//ListView1.ItemIndex > 0
end;

type
  TvcmFormsCollectionProperty = class(TCollectionProperty)
    public
    // public methods
      function GetEditorClass: TCollectionEditorClass;
        override;
        {-}
  end;//TvcmFormsCollectionProperty

function TvcmFormsCollectionProperty.GetEditorClass: TCollectionEditorClass;
  //override;
  {-}
begin
 Result := TvcmFormsCollectionEditor;
end;

type
  TvcmOperationStatesEditor = class(TCollectionEditor)
    protected
    // internal methods
      procedure DoShow;
        override;
        {-}
      procedure MakeImages;
        {-}
      procedure ListView1DoubleClick(Sender: TObject);
        {-}
      procedure RunPropertyEditor(const Prop: IProperty);
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
      procedure ItemsModified(const ADesigner: IDesigner);
        override;
        {-}
  end;//TvcmOperationStatesEditor

constructor TvcmOperationStatesEditor.Create(anOwner: TComponent);
  //override;
  {-}
begin
 inherited;
 ListView1.SmallImages := vcmGetActionList.Images;
 ListView1.OnDblClick := ListView1DoubleClick;
end;

procedure TvcmOperationStatesEditor.DoShow;
  {-}
begin
 inherited;
 MakeImages;
end;

procedure TvcmOperationStatesEditor.MakeImages;
  {-}
var
 l_Index : Integer;
begin
 if (Collection <> nil) then
  for l_Index := 0 to Pred(Collection.Count) do
   ListView1.Items.Item[l_Index].ImageIndex :=
    TvcmBaseOperationState(Collection.Items[l_Index]).ImageIndex;
end;

procedure TvcmOperationStatesEditor.ListView1DoubleClick(Sender: TObject);
  {-}
var
 Components: IDesignerSelections;
begin
 if (Collection <> nil) then begin
  Components := CreateSelectionList;
  Designer.GetSelections(Components);
  GetComponentProperties(Components, tkProperties, Designer, RunPropertyEditor);
 end;//Collection <> nil
end;

procedure TvcmOperationStatesEditor.RunPropertyEditor(const Prop: IProperty);
begin
 if SameText(Prop.GetName, 'IMAGEINDEX') then
  Prop.Edit;
end;

procedure TvcmOperationStatesEditor.ItemsModified(const ADesigner: IDesigner);
  //override;
  {-}
begin
 inherited;
 MakeImages;
end;

type
  TvcmOperationStatesProperty = class(TCollectionProperty)
    public
    // public methods
      function GetEditorClass: TCollectionEditorClass;
        override;
        {-}
  end;//TvcmOperationStatesProperty

function TvcmOperationStatesProperty.GetEditorClass: TCollectionEditorClass;
  //override;
  {-}
begin
 Result := TvcmOperationStatesEditor;
end;

type
  TvcmUserTypesCollectionEditor = class(TCollectionEditor)
    protected
    // internal methods
      procedure DoShow;
        override;
        {-}
      procedure MakeImages;
        {-}
      procedure ListView1DoubleClick(Sender: TObject);
        {-}
      procedure RunPropertyEditor(const Prop: IProperty);
        {-}
    public
    // public methods
      constructor Create(anOwner: TComponent);
        override;
        {-}
      procedure ItemsModified(const ADesigner: IDesigner);
        override;
        {-}
  end;//TvcmUserTypesCollectionEditor

constructor TvcmUserTypesCollectionEditor.Create(anOwner: TComponent);
  //override;
  {-}
begin
 inherited;
 ListView1.SmallImages := vcmGetActionList.Images;
 ListView1.OnDblClick := ListView1DoubleClick;
end;

procedure TvcmUserTypesCollectionEditor.DoShow;
  {-}
begin
 inherited;
 MakeImages;
end;

procedure TvcmUserTypesCollectionEditor.MakeImages;
  {-}
var
 l_Index : Integer;
begin
 if (Collection <> nil) then
  for l_Index := 0 to Pred(Collection.Count) do
   ListView1.Items.Item[l_Index].ImageIndex :=
    TvcmUserTypesCollectionItem(Collection.Items[l_Index]).ImageIndex;
end;

procedure TvcmUserTypesCollectionEditor.ListView1DoubleClick(Sender: TObject);
  {-}
var
 Components: IDesignerSelections;
begin
 if (Collection <> nil) then begin
  Components := CreateSelectionList;
  Designer.GetSelections(Components);
  GetComponentProperties(Components, tkProperties, Designer, RunPropertyEditor);
 end;//Collection <> nil
end;

procedure TvcmUserTypesCollectionEditor.RunPropertyEditor(const Prop: IProperty);
begin
 if SameText(Prop.GetName, 'IMAGEINDEX') then
  Prop.Edit;
end;

procedure TvcmUserTypesCollectionEditor.ItemsModified(const ADesigner: IDesigner);
  //override;
  {-}
begin
 inherited;
 MakeImages;
end;

type
  TvcmUserTypesCollectionProperty = class(TCollectionProperty)
    public
    // public methods
      function GetEditorClass: TCollectionEditorClass;
        override;
        {-}
  end;//TvcmUserTypesCollectionProperty

function TvcmUserTypesCollectionProperty.GetEditorClass: TCollectionEditorClass;
  //override;
  {-}
begin
 Result := TvcmUserTypesCollectionEditor;
end;

(*type
  TvcmControlEditor = class(TDefaultEditor)
    private
    // internal fields
      f_Form     : TCustomForm;
      f_Entities : TvcmBaseEntities;
    public
    // public methods
      procedure PrepareItem(Index: Integer; const AItem: IMenuItem);
        override;
        {-}
      procedure ExecuteVerb(Index : Integer);
        override;
        {-}
      function GetVerb(Index : Integer): string;
        override;
        {-}
      function GetVerbCount : Integer;
        override;
        {-}
  end;//TvcmControlEditor

procedure TvcmControlEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
  //override;
  {-}
begin
 inherited;
 if (f_Form <> nil) then begin
  if (Index = 0) then begin
  end else if (f_Entities <> nil) then
   aItem.Checked := TvcmBaseEntitiesCollectionItem(f_Entities.Entities.Items[Pred(Index)]).SupportedBy[GetComponent];
 end;//f_Form <> nil
end;

procedure TvcmControlEditor.ExecuteVerb(Index : Integer);
  //override;
  {-}
begin
 if (f_Form <> nil) then begin
  if (Index = 0) then begin
   if (f_Entities = nil) then begin
    f_Entities := TvcmEntities.Create(f_Form);
    f_Entities.Name := 'Entities';
   end;//f_Entities = nil
   TvcmEntityParams.Execute(f_Entities, GetComponent);
  end else if (f_Entities <> nil) then
   with TvcmBaseEntitiesCollectionItem(f_Entities.Entities.Items[Pred(Index)]) do
    SupportedBy[GetComponent] := not SupportedBy[GetComponent];
 end;//f_Form <> nil
end;

function TvcmControlEditor.GetVerb(Index : Integer): string;
  //override;
  {-}
begin
 if (f_Form <> nil) then begin
  if (Index = 0) then
   Result := 'Добавить сущность...'
  else if (f_Entities = nil) then
   Result := ''
  else
   Result := TvcmBaseEntitiesCollectionItem(f_Entities.Entities.Items[Pred(Index)]).Caption;
 end;//f_Form <> nil
end;

function TvcmControlEditor.GetVerbCount : Integer;
  //override;
  {-}
var
 l_Index : Integer;
begin
 f_Entities := nil;
 Result := 0;
 f_Form := afw.GetParentForm(GetComponent);
 if (f_Form <> nil) then begin
  Result := 1;
  with f_Form do
   for l_Index := 0 to Pred(ComponentCount) do
    if (Components[l_Index] Is TvcmBaseEntities) then begin
     f_Entities := TvcmBaseEntities(Components[l_Index]);
     break;
    end;//Components[l_Index] Is TvcmBaseEntities
  if (f_Entities <> nil) then
   Inc(Result, f_Entities.Entities.Count);
 end;//l_Form <> nil
end;

type
  TvcmFormSetFormProperty = class(TvcmListedProperty)
  {* Редактирует свойство TvcmFormSetFactory.OwnerForm. }
  public
  // public methods
    function GetValue: String;
      override;
      {-}
    procedure GetValues(Proc: TGetStrProc);
      override;
      {-}
    procedure SetValue(const aValue: String);
      override;
      {-}
  end;

function TvcmFormSetFormProperty.GetValue : String;
  // override;
  {-}
var
 l_ID: LongInt;
begin
 Result := '';
 l_ID := GetOrdProp(GetComponent(0), GetPropInfo);
 if l_ID <> -1 then
  Result := TvcmFormSetFormsCollectionItem(TvcmFormSetFactory(GetComponent(0)).Forms.Items[l_ID]).Name;
end;

procedure TvcmFormSetFormProperty.SetValue(const aValue : String);
  // override;
  {-}
var
 lIndex : Integer;
begin
 if aValue = '' then
  SetOrdProp(GetComponent(0), GetPropInfo, -1)
 else
  for lIndex := 0 to Pred(TvcmFormSetFactory(GetComponent(0)).Forms.Count) do
   if TvcmFormSetFormsCollectionItem(TvcmFormSetFactory(GetComponent(0)).Forms.Items[lIndex]).Name = aValue then
   begin
    if GetOrdProp(GetComponent(0), GetPropInfo) <> lIndex then
    begin
     SetOrdProp(GetComponent(0), GetPropInfo, lIndex);
     Modified;
    end;
    Break;
   end;
end;

procedure TvcmFormSetFormProperty.GetValues(Proc: TGetStrProc);
  // override;
  {-}
var
 lIndex : Integer;
begin
 with TvcmFormSetFactory(GetComponent(0)) do
  for lIndex := 0 to Pred(Forms.Count) do
   Proc(TvcmFormSetFormsCollectionItem(Forms.Items[lIndex]).Name);
end;*)

const
  vcmPage = 'vcm';
  vcmCategory = 'vcm';

type
  TvcmDataModuleRef = class(TDataModule)
  end;//TvcmDataModuleRef

procedure Register;
begin
 RegisterComponents(vcmPage, [TvcmEntities,
                              TvcmMenuManager]);
(* RegisterComponentEditor(TvcmBaseEntities,
                         TvcmEntitiesEditor);*)
(* RegisterComponentEditor(TvcmCustomOperations,
                         TvcmOperationsEditor);*)
 { TvcmBaseUserTypesCollectionItem, "UseToolbarOfUserTypeName" }
 RegisterPropertyEditor(TypeInfo(String),
                        TvcmBaseUserTypesCollectionItem,
                        'UseToolbarOfUserTypeName',
                        TvcmUseToolbarOfUserTypeNameProperty);
 { TvcmFormSetFactory, "OwnerForm"}
(* RegisterPropertyEditor(TypeInfo(Integer),
                        TvcmFormSetFactory,
                        'OwnerForm',
                        TvcmFormSetFormProperty);*)
 { TvcmFormSetFactory, "DefaultStatusForm"}
(* RegisterPropertyEditor(TypeInfo(Integer),
                        TvcmFormSetFactory,
                        'DefaultStatusForm',
                        TvcmFormSetFormProperty);*)
 { TvcmFormSetFormsCollectonItem, "UserType"}
(* RegisterPropertyEditor(TypeInfo(TvcmUserType),
                        TvcmFormSetFormsCollectionItem,
                        'UserType',
                        TvcmFormSetItemUserTypeProperty);*)
 { TvcmProjectFormName }
 RegisterPropertyEditor(TypeInfo(TvcmProjectFormName),
                        nil,
                        '',
                        TvcmProjectFormNameProperty);
 { TvcmFormActivate, 'UserType' }
(* RegisterPropertyEditor(TypeInfo(Integer),
                        TvcmFormActivate,
                        'UserType',
                        TvcmFormActivateUserTypeProperty);*)
 { TvcmFormActivate, 'Name' }
 RegisterPropertyEditor(TypeInfo(String),
                        TvcmFormActivate,
                        'Name',
                        TvcmFormActivateNameProperty);
 { TvcmFormActivate, 'Caption' }
 RegisterPropertyEditor(TypeInfo(String),
                        TvcmFormActivate,
                        'Caption',
                        TvcmFormActivateCaptionProperty);
 { TvcmRepeatedActivationBehaviourProperty, 'RepeatedActivationBehaviour' }
 RegisterPropertyEditor(TypeInfo(TvcmRepeatedActivationBehaviour),
                        TvcmFormActivate,
                        'RepeatedActivationBehaviour',
                        TvcmRepeatedActivationBehaviourProperty);
 { TvcmMessagesCollectionItem, 'Category' }
(* RegisterPropertyEditor(TypeInfo(TvcmMessageCategory),
                        TvcmMessagesCollectionItem,
                        'Category',
                        TvcmMessageCategoryProperty);*)

(* RegisterPropertyEditor(TypeInfo(String),
                        TvcmBaseEntitiesCollectionItem,
                        'Category',
                        TvcmEntityCategoryProperty);*)

(* RegisterPropertyEditor(TypeInfo(String),
                        TvcmBaseOperationsCollectionItem,
                        '_Category',
                        TvcmEntityCategoryProperty);*)

 RegisterPropertyEditor(TypeInfo(String),
                        TvcmBaseEntitiesCollectionItem,
                        'Name',
                        TvcmEntityNameProperty);

 RegisterPropertyEditor(TypeInfo(String),
                        TvcmBaseOperationsCollectionItem,
                        'Name',
                        TvcmOperationNameProperty);

 RegisterPropertyEditor(TypeInfo(String),
                        TvcmBaseEntitiesCollectionItem,
                        'Caption',
                        TvcmEntityCaptionProperty);

 RegisterPropertyEditor(TypeInfo(String),
                        TvcmBaseOperationsCollectionItem,
                        'Caption',
                        TvcmOperationCaptionProperty);

 RegisterPropertyEditor(TypeInfo(TShortCut),
                        nil,
                        'ShortCut',
                        TShortCutProperty);

 RegisterPropertyEditor(TypeInfo(TImageIndex),
                        TvcmBaseCollectionItem,
                        'ImageIndex',
                        TvcmImageIndexProperty);

(* RegisterPropertyEditor(TypeInfo(String),
                        TvcmMenuItemsCollectionItem,
                        'Caption',
                        TvcmMenuItemsCaptionProperty);*)

 RegisterPropertyEditor(TypeInfo(TvcmBaseOperationsCollection),
                        nil,
                        '',
                        TvcmOperationsCollectionProperty);
 RegisterPropertyEditor(TypeInfo(TvcmUserTypesCollection),
                        nil,
                        '',
                        TvcmUserTypesCollectionProperty);
 RegisterPropertyEditor(TypeInfo(TvcmBaseOperationStates),
                        nil,
                        '',
                        TvcmOperationStatesProperty);

 RegisterPropertyEditor(TypeInfo(TvcmBaseEntitiesCollection),
                        nil,
                        '',
                        TvcmEntitiesCollectionProperty);
 RegisterPropertyEditor(TypeInfo(TvcmFormsCollection),
                        nil,
                        '',
                        TvcmFormsCollectionProperty);
 //RegisterComponentEditor(TControl, TvcmControlEditor);
 //RegisterCustomModule(TvcmFormSetFactory, TCustomModule);
 //RegisterPackageWizard(TvcmFormSetFactoryWizard.Create);
 //RegisterCustomModule(TvcmApplication, TCustomModule);
 //RegisterCustomModule(TvcmApplicationRef, TCustomModule);
 RegisterCustomModule(TvcmDataModuleRef, TCustomModule);
 //RegisterCustomModule(TvcmStdResRef, TCustomModule);
 //RegisterPackageWizard(TvcmModuleWizard.Create);
 RegisterCustomModule(TvcmForm, TCustomModule);
 RegisterCustomModule(TvcmEntityFormRef, TCustomModule);
 RegisterCustomModule(TvcmEntityForm, TCustomModule);
 //RegisterPackageWizard(TvcmEntityWizard.Create);
 RegisterCustomModule(TvcmContainerForm, TCustomModule);
 RegisterCustomModule(TvcmContainerFormRef, TCustomModule);
 RegisterCustomModule(TvcmMainForm, TCustomModule);
 RegisterCustomModule(TvcmMainFormRef, TCustomModule);
 RegisterPropertiesInCategory(vcmCategory, TvcmEntityForm,
                              ['OnInit', 'ZoneType',
                               'OnLoadState', 'OnSaveState', 'ToolbarPos']);
 RegisterPropertiesInCategory(vcmCategory, TvcmContainerForm,
                              ['Zones', 'OnInsertForm', 'OnAfterInsertForm']);
 RegisterPropertiesInCategory(vcmCategory, TvcmMainForm,
                              ['SDI', 'MenuManager', 'OnUpdateStatus']);
end;

{$EndIf NoVCM}

end.

