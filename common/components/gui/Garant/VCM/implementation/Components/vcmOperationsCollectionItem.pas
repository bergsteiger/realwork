unit vcmOperationsCollectionItem;
{* Элемент коллекции операций. }

{ Библиотека "vcm"        }
{ Автор: Люлин А.В. ©     }
{ Модуль: vcmOperationsCollectionItem - }
{ Начат: 11.03.2003 12:22 }
{ $Id: vcmOperationsCollectionItem.pas,v 1.66 2015/10/19 13:53:55 kostitsin Exp $ }

// $Log: vcmOperationsCollectionItem.pas,v $
// Revision 1.66  2015/10/19 13:53:55  kostitsin
// рисуем TvcmBaseOperationsCollectionItem
//
// Revision 1.65  2015/08/16 16:03:24  kostitsin
// {requestlink: 605157327 }
//
// Revision 1.64  2013/07/11 15:25:19  morozov
// {RequestLink: 329648944}
//
// Revision 1.63  2013/04/25 14:22:38  lulin
// - портируем.
//
// Revision 1.62  2012/08/07 14:37:42  lulin
// {RequestLink:358352265}
//
// Revision 1.61  2011/12/08 16:30:03  lulin
// {RequestLink:273590436}
// - чистка кода.
//
// Revision 1.60  2010/09/15 18:15:01  lulin
// {RequestLink:235047275}.
//
// Revision 1.59  2010/08/31 18:25:46  lulin
// {RequestLink:224134305}.
//
// Revision 1.58  2010/07/16 17:19:46  lulin
// {RequestLink:197496539}.
//
// Revision 1.57  2010/07/15 11:40:33  lulin
// {RequestLink:207389954}.
//
// Revision 1.56  2010/07/05 15:58:31  lulin
// {RequestLink:197496539}.
// - вычищаем vcm_ooShowInMainToolbar из форм.
//
// Revision 1.55  2010/07/05 15:29:17  lulin
// {RequestLink:223609269}.
//
// Revision 1.54  2010/07/05 15:22:00  lulin
// {RequestLink:223609269}.
//
// Revision 1.53  2010/04/30 15:15:44  lulin
// {RequestLink:207389954}.
// - чистка комментариев.
//
// Revision 1.52  2009/10/12 11:27:15  lulin
// - коммитим после падения CVS.
//
// Revision 1.52  2009/10/08 12:46:44  lulin
// - чистка кода.
//
// Revision 1.51  2009/09/01 16:03:50  lulin
// - наследуем признак показа операции в главном тулбаре от хранилища ресурсов.
//
// Revision 1.50  2009/08/07 13:47:31  lulin
// - делаем возможность централизованно запретить показ операций в контекстном меню.
//
// Revision 1.49  2009/08/06 13:27:16  lulin
// {RequestLink:129240934}. №26.
//
// Revision 1.48  2009/02/20 17:29:20  lulin
// - чистка комментариев.
//
// Revision 1.47  2009/02/12 17:09:15  lulin
// - <K>: 135604584. Выделен модуль с внутренними константами.
//
// Revision 1.46  2007/04/26 13:29:43  oman
// - new: Жирность можно задавать в DesignTime - добавилось
//  свойство <Operation>.IsDefault (cq24612)
//
// Revision 1.45  2007/01/26 15:30:26  lulin
// - cleanup.
//
// Revision 1.44  2006/01/20 11:33:06  mmorozov
// 1. Нельзя было на панель инструментов положить неколько операций из разных сущностей с одинаковыми именами;
// 2. Если в панели инструментов встречаются операции с одинаковыми названиями, то им автоматически добавляется суффикс в виде названия сущности;
// 3. Появилась возможность указать, что контекстные операции сущности должны показываться в отдельном пункте меню;
// 3.
//
// Revision 1.43  2005/02/02 12:53:56  am
// change: правки, связанные с переделками TvcmBaseOperationCollectionItem._Handled()
//
// Revision 1.42  2005/02/01 15:04:50  am
// new: function _Handled
//
// Revision 1.41  2004/11/18 16:29:55  lulin
// - отвязываем библиотеки от VCM без использования inc'ов.
//
// Revision 1.40  2004/09/13 08:56:10  lulin
// - new behavior: TvcmPrimCollectionItem теперь может кешироваться и распределяться в пуле объектов.
//
// Revision 1.39  2004/09/13 07:09:59  mmorozov
// new: method TvcmOperationsCollectionItem.UnRegister;
//
// Revision 1.38  2004/09/11 11:55:47  lulin
// - cleanup: избавляемся от прямого использования деструкторов.
//
// Revision 1.37  2004/09/10 16:56:19  mmorozov
// new: property IsRegistred;
//
// Revision 1.36  2004/09/10 16:21:46  lulin
// - оптимизация - кешируем OpDef и передаем ссылку на OperationItem, а не на кучу параметров.
//
// Revision 1.35  2004/09/10 12:47:40  lulin
// - new type: TvcmEffectiveUserType.
// - new behavior: не возвращаем интерфейсы для операции, если у нее нету имени.
//
// Revision 1.34  2004/03/11 11:43:24  nikitin75
// + SecondaryShortCuts support;
//
// Revision 1.33  2004/01/14 17:25:07  law
// - new behavior: мапируем свойство _States на операцию, живущую в StdRes.
//
// Revision 1.32  2004/01/14 16:43:23  law
// - change: проверка f_Rep <> nil заменена на Linked.
// - change: проверка f_Rep = nil заменена на not Linked.
//
// Revision 1.31  2004/01/14 16:24:32  law
// - new method: TvcmBaseOperationsCollectionItem.StatesClass.
//
// Revision 1.30  2003/11/24 17:35:21  law
// - new method: TvcmCustomEntities._RegisterInRep.
//
// Revision 1.29  2003/11/24 11:56:35  law
// - bug fix: Hint'ы тоже теперь берутся из централизованного хранилища.
//
// Revision 1.28  2003/11/19 18:38:39  law
// - new prop: TvcmBaseOperationsCollectionItem.Params - описывает список параметров операции.
// - new prop: TvcmOperationsCollectionItem.Linked - показывает связана операция с централизованным хранилищем или нет.
//
// Revision 1.27  2003/11/19 15:41:24  law
// - change: свойство _ExcludeUserTypes перенес на TvcmOperationsCollectionItem.
//
// Revision 1.26  2003/11/19 15:18:41  law
// - bug fix: неправильно вычислялся _GroupID.
// - new behavior: дерегестрируем описатели операций из MenuManager'а.
//
// Revision 1.25  2003/11/19 13:21:07  law
// - new behavior: отобразил свойство ShortCut операций на формах на централизованное хранилище.
//
// Revision 1.24  2003/11/19 12:56:52  law
// - new behavior: отобразил свойства операций на формах на централизованное хранилище (Caption, ImageIndex, _GroupID, _Category, OperationType).
//
// Revision 1.23  2003/11/19 11:38:25  law
// - new behavior: регистрируем все сущности и операции в MenuManager'е для дальнейшей централизации редактирования. Само редактирование пока не доделано.
//
// Revision 1.22  2003/11/18 19:35:54  law
// - new: начал делать общий репозиторий модулей, сущностей и операций в MenuManager'е. Чтобы все можно было править из одного места.
//
// Revision 1.21  2003/11/04 14:29:57  law
// - bug fix: для основного меню не учитывалось свойство _ExcludeUserTypes.
//
// Revision 1.20  2003/10/28 11:25:46  law
// - new prop: IvcmOperationDef._GroupID.
//
// Revision 1.19  2003/10/24 12:30:52  law
// - bug fix: неправильно вычислялось значение по умолчанию для свойства _Options в Design-Time.
//
// Revision 1.18  2003/10/24 10:45:04  law
// - new behavior: отсекаем ошибочные флаги операций.
//
// Revision 1.17  2003/10/24 09:22:03  law
// - new prop: TvcmOperationsCollectionItem._Category.
//
// Revision 1.16  2003/09/19 17:46:02  law
// - new behavior: не вызываем OnTest, когда объект с обработчиком находится в процессе убивания.
//
// Revision 1.15  2003/08/27 09:18:57  law
// - bug fix: AV при Unlock после вызова операции (симптомы - не отрисовывались Toolbar'ы после перехода на картинку из мультиссылки).
//
// Revision 1.14  2003/08/26 08:46:40  demon
// - new behavior: удалена залочка при обработке операции в режиме OnTest.
//
// Revision 1.13  2003/07/24 14:35:36  law
// - change: у _ExcludeUserTypes выставлено значение по умолчанию.
//
// Revision 1.12  2003/07/24 13:07:15  law
// - new prop: IvcmOperationDef._ExcludeUserTypes.
//
// Revision 1.11  2003/06/26 07:00:06  narry
// - update: продолжение документирования
//
// Revision 1.10  2003/06/13 14:34:51  narry
// - update: продолжение документирования
//
// Revision 1.9  2003/06/02 15:19:12  narry
// - update: продолжение документирования библиотеки
//
// Revision 1.8  2003/04/29 14:49:54  law
// - new prop: TvcmOperationsCollectionItem._AutoLock.
//
// Revision 1.7  2003/04/28 13:02:34  law
// - remove const: vcm_opDone.
// - new prop: _IvcmParams.Done.
//
// Revision 1.6  2003/04/28 09:36:10  law
// - cleanup: переделана логика работы с параметрами операций.
//
// Revision 1.5  2003/04/22 14:03:00  law
// - new behavior: сделана обработка операций, описанных на основной форме.
//
// Revision 1.4  2003/04/08 12:34:46  law
// - new prop: IvcmOperationDef._Options.
// - new prop: TvcmOperationsCollectionItem._Options.
//
// Revision 1.3  2003/04/04 12:56:30  law
// - new prop: IvcmOperationDef.ShortCut.
//
// Revision 1.2  2003/04/02 13:50:31  law
// - new const: vcm_otInternal.
//
// Revision 1.1  2003/04/01 12:54:45  law
// - переименовываем MVC в VCM.
//
// Revision 1.22  2003/03/27 14:36:53  law
// - new prop: операция теперь имеет картинку.
//
// Revision 1.21  2003/03/26 16:10:32  law
// - new prop: сделано свойство _Category для операции.
//
// Revision 1.20  2003/03/26 12:13:41  law
// - cleanup.
//
// Revision 1.19  2003/03/25 10:34:25  law
// - new prop: TvcmOperationsCollectionItem.ShortCut.
//
// Revision 1.18  2003/03/25 09:56:53  law
// - new prop: TvcmOperationsCollectionItem.Hint, TvcmOperationsCollectionItem.LongHint.
//
// Revision 1.17  2003/03/24 15:13:41  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.16  2003/03/24 14:52:12  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.15  2003/03/24 14:04:06  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.14  2003/03/24 13:25:47  law
// - change: продолжаем заковыривать все относящееся к операции в _IvcmParams.
//
// Revision 1.13  2003/03/21 16:53:54  law
// - new prop: TvcmOperationsCollectionItem.OperationType.
//
// Revision 1.12  2003/03/21 12:34:43  law
// - new behavior: операциям добавлен список параметров.
//
// Revision 1.11  2003/03/21 11:32:11  law
// - change: добавлены редакторы свойства Caption.
//
// Revision 1.10  2003/03/21 10:13:35  law
// - cleanup: удалены модули vcm*Repository.
//
// Revision 1.9  2003/03/20 12:30:01  law
// - new behavior: сделана обработка контекстных операций.
//
// Revision 1.8  2003/03/11 16:47:41  law
// - new prop: TvcmOperationsCollectionItem.OnExecuteEx.
//
// Revision 1.7  2003/03/11 16:24:19  law
// - cleanup.
// - new behavior: добавлен редактор компонента TvcmEntities.
//
// Revision 1.6  2003/03/11 15:53:49  law
// - new events: TvcmOperationsCollectionItem.OnGetEnabled, TvcmOperationsCollectionItem.OnExecute.
//
// Revision 1.5  2003/03/11 15:34:30  law
// - new behavior: сделаны обработчики операций.
//
// Revision 1.4  2003/03/11 12:44:42  law
// - new behavior: сделано вытаскивание сущностей и их операций из TvcmCustomEntities, которые лежат на форме для сущностей.
//
// Revision 1.3  2003/03/11 12:04:01  law
// - new units: vcmEntitiesRepository, vcmOperationsRepository.
//
// Revision 1.2  2003/03/11 09:38:16  law
// - new class: TvcmBaseCollectionItem.
//
// Revision 1.1  2003/03/11 09:31:23  law
// - new prop: TvcmEntitiesCollectionItem.Operations.
//

{$I vcmDefine.inc }

interface

uses
  Classes,

  ImgList,
  ActnList,

  vcmInterfaces,
  vcmExternalInterfaces,
  vcmUserControls,
  
  vcmBaseOperationsCollectionItem,
  vcmBaseOperationStates
  ;

type
  TvcmOperationsCollectionItem = class(TvcmBaseOperationsCollectionItem)
   {* Элемент коллекции операций. }
    private
    // internal fields
      f_Rep              : TvcmBaseOperationsCollectionItem;
      f_ExcludeUserTypes : TvcmEffectiveUserTypes;
      f_IsRegistred      : Boolean;
    protected
    // property methods
      function  GetDefaultOptions: TvcmOperationOptions;
        override;
        {-}
      function  pm_GetOptions: TvcmOperationOptions;
        override;
        {-}
      function  pm_GetCaption: AnsiString;
        override;
        {-}
      function GetCaptionStored: Boolean;
        override;
        {-}
      procedure CaptionChanged;
        override;
        {-}
      function  pm_GetImageIndex: TImageIndex;
        override;
        {-}
      procedure pm_SetImageIndex(aValue: TImageIndex);
        override;
        {-}
      function  ImageIndexStored: Boolean;
        override;
        {-}
      function  pm_GetGroupID: Integer;
        override;
        {-}
      procedure pm_SetGroupID(aValue: Integer);
        override;
        {-}
      function  GetGroupIDStored: Boolean;
        override;
        {-}
      {$IfNDef DesignTimeLibrary}
      function  pm_GetCategory: AnsiString;
        override;
        {-}
      {$EndIf DesignTimeLibrary}  
      function  pm_GetOperationType: TvcmOperationType;
        override;
        {-}
      procedure pm_SetOperationType(aValue: TvcmOperationType);
        override;
        {-}
      function  GetOperationTypeStored: Boolean;
        override;
        {-}
      function  pm_GetShortCut: TShortCut;
        override;
        {-}
      procedure pm_SetShortCut(aValue: TShortCut);
        override;
        {-}
      function  ShortCutStored: Boolean;
        override;
        {-}
      function  pm_GetSecondaryShortCuts: TShortCutList;
        override;
        {-}
      procedure pm_SetSecondaryShortCuts(aValue: TShortCutList);
        override;
        {-}
      function  SecondaryShortCutsStored: Boolean;
        override;
        {-}
      function  pm_GetHint: AnsiString;
        override;
        {-}
      procedure pm_SetHint(const aValue: AnsiString);
        override;
        {-}
      function  HintStored: Boolean;
        override;
        {-}
      function  pm_GetLongHint: AnsiString;
        override;
        {-}
      procedure pm_SetLongHint(const aValue: AnsiString);
        override;
        {-}
      function  LongHintStored: Boolean;
        override;
        {-}
      function  pm_GetExcludeUserTypes: TvcmEffectiveUserTypes;
        override;
      procedure pm_SetExcludeUserTypes(aValue: TvcmEffectiveUserTypes);
        override;
        {-}
      function  pm_GetLinked: Boolean;
        override;
        {-}
      procedure pm_SetLinked(aValue: Boolean);
        override;
        {-}
      function  pm_GetStates: TvcmBaseOperationStates;
        override;
        {-}
      function pm_GetIsDefault: Boolean;
        override;
        {-}
      procedure pm_SetIsDefault(aValue: Boolean);
        override;
        {-}
      function  GetIsDefaultStored: Boolean;
        override;
        {-}
    protected
    // internal methods
      class function StatesClass: RvcmBaseOperationStates;
        override;
        {-}
      procedure NameChanged;
        override;
        {-}
      procedure ReRegister;
        {-}
      procedure Cleanup;
        override;
        {-}
      procedure BeforeAddToCache;
        override;
        {-}
    public
    // public methods
      constructor Create(Collection: TCollection);
        override;
        {-}
      procedure SetRep(aRep : TvcmBaseOperationsCollectionItem);
        {-}
      procedure Register;
        {-}
      procedure UnRegister;
        {-}
      function  Handled(aTypes: TvcmHandleTypes): Boolean;
        override;
        {-}
    public
    // public property
      property IsRegistred : Boolean
        read f_IsRegistred
        write f_IsRegistred;
        {-}
    published
    // published properties
      property Linked;
        {-}  
  end;{ Описатель операции }

implementation

uses
  vcmRepOperationsCollectionItem,
  vcmBaseEntitiesCollection,
  vcmBaseEntitiesCollectionItem,
  vcmOperationsCollection,
  vcmBaseCollectionItem,
  vcmBaseOperationState,
  vcmOperationStates,
  vcmInternalConst
  ;

// start class TvcmOperationsCollectionItem

constructor TvcmOperationsCollectionItem.Create(Collection: TCollection);
//override;
begin
 inherited;
 f_IsRegistred := False;
end;

procedure TvcmOperationsCollectionItem.BeforeAddToCache;
  //override;
  {-}
begin
 inherited;
 f_Rep := nil;
 f_ExcludeUserTypes := [];
end;

procedure TvcmOperationsCollectionItem.Cleanup;
  //override;
  {-}
begin
 UnRegister;
 inherited;
end;

procedure TvcmOperationsCollectionItem.SetRep(aRep : TvcmBaseOperationsCollectionItem);
  {-}
var
 l_States    : TvcmBaseOperationStates;
 l_NewStates : TvcmBaseOperationStates;
 l_State     : TvcmBaseOperationState;
 l_Index     : Integer;

 procedure lp_DefineUniqueCaption;
 {* Определим является ли имя уникальным в пределах всех операций сущностей. }
 begin
  {$IfNDef DesignTimeLibrary}
  if (OperationType in vcmToolbarOpTypes) and
   (Collection.Owner is TvcmBaseEntitiesCollectionItem) then
   with TvcmBaseEntitiesCollectionItem(Collection.Owner) do
    IsCaptionUnique := TvcmBaseEntitiesCollection(Collection).
     IsItemCaptionUnique(Self);
  {$EndIf DesignTimeLibrary}
 end;//lp_DefineUniqueCaptionProperty

begin
 if (f_Rep <> aRep) then
 begin
  if Linked then
  begin
   ClearOp;
   l_States := nil;
  end
  else
   l_States := States;
  f_Rep := aRep;
  if Linked AND (l_States <> nil) then
  begin
   l_NewStates := States;
   if (l_NewStates <> nil) AND (l_NewStates <> l_States) then
    for l_Index := 0 to Pred(l_States.Count) do
    begin
     l_State := TvcmBaseOperationState(l_States.Items[l_Index]);
     if (l_NewStates.FindItemByName(l_State.Name) = nil) then
      l_NewStates.Add.Assign(l_State);
    end;//for l_Index
   lp_DefineUniqueCaption;
  end;//Linked
 end;//f_Rep <> aRep
end;

procedure TvcmOperationsCollectionItem.ReRegister;
  {-}
begin
 if (Collection <> nil) then
  (Collection As TvcmOperationsCollection).ReRegisterItem(Self);
end;

procedure TvcmOperationsCollectionItem.UnRegister;
begin
 if Assigned(f_Rep) then
  TvcmRepOperationsCollectionItem(f_Rep).RemoveHolder(Self);
end;

procedure TvcmOperationsCollectionItem.Register;
  {-}
begin
 if (Collection <> nil) then
  (Collection As TvcmOperationsCollection).RegisterItem(Self);
end;

class function TvcmOperationsCollectionItem.StatesClass: RvcmBaseOperationStates;
  //override;
  {-}
begin
 Result := TvcmOperationStates;
end;
  
procedure TvcmOperationsCollectionItem.NameChanged;
  //override;
  {-}
begin
 inherited;
 ReRegister;
end;

function TvcmOperationsCollectionItem.GetDefaultOptions: TvcmOperationOptions;
  //override;
  {-}
begin
 Result := inherited GetDefaultOptions;
 Exclude(Result, vcm_ooShowInMainToolbar);
 Exclude(Result, vcm_ooShowInMainMenu);
end;

function TvcmOperationsCollectionItem.pm_GetOptions: TvcmOperationOptions;
  //override;
  {-}
begin
 Result := inherited pm_GetOptions;
 //http://mdp.garant.ru/pages/viewpage.action?pageId=329648944
 (*{$IfDef DesignTimeLibrary}
 Exclude(Result, vcm_ooShowInMainMenu);
 Exclude(Result, vcm_ooShowInMainToolbar);
 {$EndIf DesignTimeLibrary}*)
 {$IfNDef DesignTimeLibrary}
 if (Result <> []) then
 begin
  if not Handled([vcm_htGlobal, vcm_htContext, vcm_htControl]) then
  begin
   Result := [];
   f_Options := Result;
  end;//not Assigned(f_OnExecute)
 end;//Result <> []
 {$EndIf  DesignTimeLibrary}
 {$IfNDef DesignTimeLibrary}
 if Linked then
 begin
  // Перемещено сюда в связи с http://mdp.garant.ru/pages/viewpage.action?pageId=329648944
  Exclude(Result, vcm_ooShowInMainMenu);
  Exclude(Result, vcm_ooShowInMainToolbar);
  if (vcm_ooShowInMainMenu in f_Rep.Options) then
   if not (f_Rep.OperationType in vcm_HiddenOperations) then
    Include(Result, vcm_ooShowInMainMenu);
  if (vcm_ooShowInMainToolbar in f_Rep.Options) then
   if not (f_Rep.OperationType in vcm_HiddenOperations) then
    Include(Result, vcm_ooShowInMainToolbar);
  if (vcm_ooShowInContextMenu in TvcmRepOperationsCollectionItem(f_Rep).RestrictOptions) then
   //if not (f_Rep.OperationType in vcm_HiddenOperations) then
    Exclude(Result, vcm_ooShowInContextMenu);
 end;//Linked
 {$EndIf  DesignTimeLibrary}
end;

function TvcmOperationsCollectionItem.pm_GetCaption: AnsiString;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited pm_GetCaption
 else
  Result := f_Rep.Caption;
end;

function TvcmOperationsCollectionItem.GetCaptionStored: Boolean;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited GetCaptionStored
 else
  Result := false;
end;

procedure TvcmOperationsCollectionItem.CaptionChanged;
  //override;
  {-}
begin
 if Linked then
  f_Rep.Caption := inherited pm_GetCaption;
 inherited;
end;

function TvcmOperationsCollectionItem.pm_GetImageIndex: TImageIndex;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited pm_GetImageIndex
 else
  Result := f_Rep.ImageIndex;
end;

procedure TvcmOperationsCollectionItem.pm_SetImageIndex(aValue: TImageIndex);
  //override;
  {-}
begin
 inherited;
 if Linked then
  f_Rep.ImageIndex := aValue;
end;

function TvcmOperationsCollectionItem.ImageIndexStored: Boolean;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited ImageIndexStored
 else
  Result := false;
end;

function TvcmOperationsCollectionItem.pm_GetGroupID: Integer;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited pm_GetGroupID
 else
  Result := f_Rep.GroupID;
end;

procedure TvcmOperationsCollectionItem.pm_SetGroupID(aValue: Integer);
  //override;
  {-}
begin
 inherited;
 if Linked then
  f_Rep.GroupID := aValue;
end;

function TvcmOperationsCollectionItem.GetGroupIDStored: Boolean;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited GetGroupIDStored
 else
  Result := false;
end;

{$IfNDef DesignTimeLibrary}
function TvcmOperationsCollectionItem.pm_GetCategory: AnsiString;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited pm_GetCategory
 else
  Result := f_Rep.Category;
end;
{$EndIf DesignTimeLibrary}

function TvcmOperationsCollectionItem.pm_GetOperationType: TvcmOperationType;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited pm_GetOperationType
 else
  Result := f_Rep.OperationType;
end;

procedure TvcmOperationsCollectionItem.pm_SetOperationType(aValue: TvcmOperationType);
  //override;
  {-}
begin
 inherited;
 if Linked then
  f_Rep.OperationType := aValue;
end;

function TvcmOperationsCollectionItem.GetOperationTypeStored: Boolean;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited GetOperationTypeStored
 else
  Result := false;
end;

function TvcmOperationsCollectionItem.pm_GetShortCut: TShortCut;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited pm_GetShortCut
 else
  Result := f_Rep.ShortCut;
end;

procedure TvcmOperationsCollectionItem.pm_SetShortCut(aValue: TShortCut);
  //override;
  {-}
begin
 inherited;
 if Linked then
  f_Rep.ShortCut := aValue;
end;

function TvcmOperationsCollectionItem.ShortCutStored: Boolean;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited ShortCutStored
 else
  Result := false;
end;

function TvcmOperationsCollectionItem.pm_GetSecondaryShortCuts: TShortCutList;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited pm_GetSecondaryShortCuts
 else
  Result := f_Rep.SecondaryShortCuts;
end;

procedure TvcmOperationsCollectionItem.pm_SetSecondaryShortCuts(aValue: TShortCutList);
  //override;
  {-}
begin
 inherited;
 if Linked then
  f_Rep.SecondaryShortCuts := aValue;
end;

function TvcmOperationsCollectionItem.SecondaryShortCutsStored: Boolean;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited SecondaryShortCutsStored
 else
  Result := false;
end;

function TvcmOperationsCollectionItem.pm_GetHint: AnsiString;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited pm_GetHint
 else
  Result := f_Rep.Hint;
end;

procedure TvcmOperationsCollectionItem.pm_SetHint(const aValue: AnsiString);
  //override;
  {-}
begin
 inherited;
 if Linked then
  f_Rep.Hint := aValue;
end;

function TvcmOperationsCollectionItem.HintStored: Boolean;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited HintStored
 else
  Result := false;
end;

function TvcmOperationsCollectionItem.pm_GetLongHint: AnsiString;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited pm_GetLongHint
 else
  Result := f_Rep.LongHint;
end;

procedure TvcmOperationsCollectionItem.pm_SetLongHint(const aValue: AnsiString);
  //override;
  {-}
begin
 inherited;
 if Linked then
  f_Rep.LongHint := aValue;
end;

function TvcmOperationsCollectionItem.LongHintStored: Boolean;
  //override;
  {-}
begin
 if not Linked then
  Result := inherited LongHintStored
 else
  Result := false;
end;

function TvcmOperationsCollectionItem.pm_GetExcludeUserTypes: TvcmEffectiveUserTypes;
  //override;
  {-}
begin
 Result := f_ExcludeUserTypes
end;

procedure TvcmOperationsCollectionItem.pm_SetExcludeUserTypes(aValue: TvcmEffectiveUserTypes);
  //override;
  {-}
begin
 f_ExcludeUserTypes := aValue;
end;

function TvcmOperationsCollectionItem.pm_GetLinked: Boolean;
  {-}
begin
 Result := (f_Rep <> nil);
end;

procedure TvcmOperationsCollectionItem.pm_SetLinked(aValue: Boolean);
  {-}
begin
end;

function TvcmOperationsCollectionItem.pm_GetStates: TvcmBaseOperationStates;
  //override;
  {-}
begin
 if Linked then
  Result := f_Rep.States
 else
  Result := inherited pm_GetStates; 
end;

function TvcmOperationsCollectionItem.Handled(
  aTypes: TvcmHandleTypes): Boolean;
begin
 Result := inherited Handled(aTypes);
 if Linked and not Result then
  Result := f_Rep.Handled(aTypes);
end;

function TvcmOperationsCollectionItem.GetIsDefaultStored: Boolean;
begin
 if not Linked then
  Result := inherited GetIsDefaultStored
 else
  Result := false;
end;

function TvcmOperationsCollectionItem.pm_GetIsDefault: Boolean;
begin
 if not Linked then
  Result := inherited pm_GetIsDefault
 else
  Result := f_Rep.IsDefault;
end;

procedure TvcmOperationsCollectionItem.pm_SetIsDefault(aValue: Boolean);
begin
 inherited;
 if Linked then
  f_Rep.IsDefault := aValue;
end;

end.

