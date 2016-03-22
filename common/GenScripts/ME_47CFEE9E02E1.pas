unit evControlContainer;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evControlContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevControlContainer" MUID: (47CFEE9E02E1)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomControlTool
 , nevTools
 , evQueryCardInt
 , evQueryGroupList
 , nevBase
 , l3Variant
 , Messages
 , l3Interfaces
;

type
 TevControlContainer = class(TevCustomControlTool, InevControlListener, IevQueryCard)
  private
   f_InsertRowMode: Boolean;
    {* Флаг режима вставки новой строки реквизита. }
   f_PasteOperation: Boolean;
    {* Была начата операция вставки. }
   f_LimitErrorControl: IevEditorControl;
    {* Была ошибка о превышении количества символов. }
   f_GroupList: TevQueryGroupList;
    {* Список групп, входящих в КЗ (IevQueryGroup). }
   f_QueryContainer: InevQueryDocumentContainer;
    {* Указатель на контейнер. }
   f_AdapterModel: Pointer;
    {* //IevAdapterModel
Ссылка на внешнюю модель. }
   f_UpperButtons: IevCustomEditorControl;
    {* Кнопки с состоянием Flat. }
   f_StartFocusControl: IevEditorControl;
    {* Виджет для получения курсора после его создания. }
  protected
   f_CurrPara: InevPara;
    {* Параграф виджета, который имеет фокус.
         f_CurrPara используется исключительно для "истории" переходов. }
   f_StateControl: IevCustomEditorControl;
    {* Виджет, по которому определяем состояния меню. }
  protected
   procedure DoHideDroppedControl(CanSetFocus: Boolean); virtual; abstract;
   function DoMouseWheel(aDown: Boolean): Boolean; virtual; abstract;
   function GetFirstVisible(const aGroup: IevQueryGroup;
    anOnlyFields: Boolean;
    anExpanedeOnly: Boolean): IevCustomEditorControl;
   function GetLastVisible(const aGroup: IevQueryGroup;
    anOnlyFields: Boolean;
    anExpanedeOnly: Boolean): IevCustomEditorControl;
   function GetFirstControl(const aReq: IevReq;
    anOnlyFields: Boolean): IevCustomEditorControl;
   function GetLastControl(const aReq: IevReq;
    anOnlyFields: Boolean): IevCustomEditorControl;
   function GetNextReq(const aReq: IevReq;
    anExpandedOnly: Boolean;
    out aFirstReq: Boolean): IevReq;
    {* Возвращает следующий реквизит или nil, если такого нет. }
   function GetPrevReq(const aReq: IevReq;
    anExpandedOnly: Boolean;
    out aLastReq: Boolean): IevReq;
    {* Возвращает предыдущий реквизит. }
   function DoGetNode(anIndex: Integer): InevSimpleNode; virtual;
   procedure DoDeleteOnUndo(aTag: Tl3Tag); virtual;
   procedure DoChangePara(const aCurPara: InevPara); virtual;
   function DoKeyDown(const aView: InevView;
    var Msg: TWMKeyDown;
    aCurPara: Tl3Tag): Boolean; virtual;
    {* Посылка сообщений о нажатии клавиш. }
   function CanInsertPara: Boolean;
    {* Разрешено ли вставлять параграф. }
   procedure InsertOnUndo(aPrev: Tl3Variant;
    aChild: Tl3Variant;
    anAdd: Boolean);
    {* Реакция на вставку при откатке. }
   procedure DeleteOnUndo(aTag: Tl3Variant);
    {* Реакция удаления при откатке. }
   procedure HideDroppedControl(CanSetFocus: Boolean);
    {* Обработчик изменения события состояния редактора (нужно для выпадающего контрола). }
   function MouseWheel(aDown: Boolean): Boolean;
    {* Событие прокрутки мыши. }
   function KeyDown(const aView: InevView;
    var Msg: TWMKeyDown;
    aCurPara: Tl3Variant): Boolean;
    {* Посылка сообщений о нажатии клавиш. }
   procedure ChangePara(const aCurPara: InevPara);
    {* Событие смена текуего параграфа. }
   procedure BeforeRMouseClick;
    {* Событие, вызываемое перед обработкой мыши. }
   procedure ClearUpper;
   function NeedKey(aPara: Tl3Variant;
    var aKeyCode: Word): Boolean;
    {* Контрол/Поле перехватывает курсор. }
   procedure CursorCreate;
    {* Обновить курсор после создания. }
   procedure UpdateState;
   function IsLastField(aPara: Tl3Variant): Boolean;
    {* Проверяет является ли параграф последним для передачи фокуса. }
   function IsFirstField(aPara: Tl3Variant): Boolean;
    {* Проверяет является ли параграф первым для передачи фокуса. }
   procedure StartPaste;
    {* Скобки для операции вставки. }
   procedure FinishPaste;
    {* Скобки для операции вставки. }
   function IsPasting: Boolean;
    {* Внутри скобок для операции вставки. }
   function GetFirstPara(OnlyFields: Boolean): InevPara;
    {* Получить первый параграф, в который может получить фокус. }
   function GetLastPara(OnlyFields: Boolean): InevPara;
    {* Получить последний параграф, в который может получить фокус. }
   procedure SetCurrPara(const aCurPara: InevPara);
   function GetDocumentContainer: InevQueryDocumentContainer;
    {* Получить контейнер документа. }
   procedure RememberFocusControl(const aValue: IevEditorControl);
    {* Запомнить контрол для установки фокуса. }
   procedure BeforeDelete;
    {* Вызывается перед удалением поля. }
   procedure UpperChange(const aButton: IevCustomEditorControl);
    {* Вызывается после установки Upper у кнопки в True. }
   function GetNode(anIndex: Integer): InevSimpleNode;
    {* Возвращает узел по номеру. }
   procedure CardClear;
    {* Обработчик очистки КЗ. }
   procedure StartLongOperation;
    {* Скобки для блокировки перерисовок в редакторе. }
   procedure EndLongOperation;
    {* Скобки для блокировки перерисовок в редакторе. }
   procedure ChangeStateAll(anExpand: Boolean);
    {* Выставляет признак развернутости/свернутости всем группам. }
   procedure AfterCollapsed(const aGroup: IevQueryGroup);
   procedure LimitCharsReached(const aControl: IevEditorControl);
    {* Обработчик достижения максимального числа символов в параграфе. }
   procedure RememberState(const aControl: IevCustomEditorControl);
    {* Запомнить состояние для контекстного меню. }
   function GetStateControl: IevCustomEditorControl;
    {* Возвращает контрол, который был активным при вызове контекстного меню. }
   function GetFocusedControl(aCurPara: Tl3Variant): IevEditorControl;
    {* Возвращает контрол, имеющий фокус ввода. }
   procedure LinkView(const aQueryContainer: InevQueryDocumentContainer);
    {* Инициализации модели. }
   procedure LinkListener(const aListener: IevAdapterModel);
    {* Подключить объект из внешней модели. }
   function AdapterModel: IevAdapterModel;
   procedure ReleaseListeners;
    {* Отключить объект из внешней модели. }
   function FindDescriptionReq(const aReqName: Tl3WString): IevDescriptionReq;
    {* Получение реквизита по имени. }
   procedure StartSetFocus;
    {* Возвращает первое доступное для редактирования поле в контроле. }
   function Get_QueryGroup(anIndex: Integer): IevQueryGroup;
   function Get_GroupCount: Integer;
   function pm_GetEditor: InevControl;
   function Get_InsertRowMode: Boolean;
   procedure Set_InsertRowMode(aValue: Boolean);
   function pm_GetCardType: TevQueryType;
   function GetControlIterator(const aCurrentControl: IevCustomEditorControl): IevControlIterator;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make: IevQueryCard; reintroduce;
   constructor Create; reintroduce; virtual;
 end;//TevControlContainer

implementation

uses
 l3ImplUses
 , l3CProtoObject
 , k2Tags
 , evControlParaTools
 , evControlParaConst
 , SysUtils
 , evdTypes
 , l3Base
 , Windows
 , evQueryCardConst
 , nevFacade
 , ControlPara_Const
 , ControlsBlock_Const
 , evControlGroup
;

type
 TevControlIterator = class(Tl3CProtoObject, IevControlIterator)
  private
   f_CurrentControl: IevCustomEditorControl;
    {* Текущий контрол. Используется при итерации по контролам. }
   f_QueryCard: TevControlContainer;
  protected
   function GetNextVisible(OnlyFields: Boolean): IevCustomEditorControl;
    {* Возвращает следующий видимый контрол или nil, если такого нет. }
   function GetPrevVisible(OnlyFields: Boolean): IevCustomEditorControl;
    {* Возвращает предыдущий видимый контрол или nil, если такого нет. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   class function Make(const aControl: IevCustomEditorControl;
    aQueryCard: TevControlContainer): IevControlIterator; reintroduce;
   constructor Create(const aControl: IevCustomEditorControl;
    aQueryCard: TevControlContainer); reintroduce;
 end;//TevControlIterator

class function TevControlIterator.Make(const aControl: IevCustomEditorControl;
 aQueryCard: TevControlContainer): IevControlIterator;
var
 l_Inst : TevControlIterator;
begin
 l_Inst := Create(aControl, aQueryCard);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevControlIterator.Make

constructor TevControlIterator.Create(const aControl: IevCustomEditorControl;
 aQueryCard: TevControlContainer);
//#UC START# *48B7FB0A0266_48B7FA9403B1_var*
//#UC END# *48B7FB0A0266_48B7FA9403B1_var*
begin
//#UC START# *48B7FB0A0266_48B7FA9403B1_impl*
 inherited Create;
 f_CurrentControl := aControl;
 l3Set(f_QueryCard, aQueryCard);
//#UC END# *48B7FB0A0266_48B7FA9403B1_impl*
end;//TevControlIterator.Create

function TevControlIterator.GetNextVisible(OnlyFields: Boolean): IevCustomEditorControl;
 {* Возвращает следующий видимый контрол или nil, если такого нет. }
//#UC START# *47CD77A200FE_48B7FA9403B1_var*
var
 l_EditorControl : IevEditorControl;
 l_Group         : IevQueryGroup;
 l_IsLast        : Boolean;
//#UC END# *47CD77A200FE_48B7FA9403B1_var*
begin
//#UC START# *47CD77A200FE_48B7FA9403B1_impl*
 Result := nil;
 if (f_CurrentControl <> nil) then
  if Supports(f_CurrentControl, IevEditorControl, l_EditorControl) then
  begin
   Result := l_EditorControl.Req.GetNextVisible(l_EditorControl, OnlyFields,
     l_IsLast); //Пытаемся получить следующий доступный для перехода контрол
   if l_IsLast then //В реквизите нет больше контролов, на которые можно перейти
    Result := f_QueryCard.GetFirstControl(l_EditorControl.Req, OnlyFields);
  end
  else
   if Supports(f_CurrentControl, IevQueryGroup, l_Group) then
    Result := f_QueryCard.GetFirstVisible(l_Group, OnlyFields, False);
//#UC END# *47CD77A200FE_48B7FA9403B1_impl*
end;//TevControlIterator.GetNextVisible

function TevControlIterator.GetPrevVisible(OnlyFields: Boolean): IevCustomEditorControl;
 {* Возвращает предыдущий видимый контрол или nil, если такого нет. }
//#UC START# *47CD77B1038D_48B7FA9403B1_var*
var
 l_EditorControl : IevEditorControl;
 l_Group         : IevQueryGroup;
 l_IsFirst       : Boolean;
//#UC END# *47CD77B1038D_48B7FA9403B1_var*
begin
//#UC START# *47CD77B1038D_48B7FA9403B1_impl*
 Result := nil;
 if (f_CurrentControl <> nil) then
  if Supports(f_CurrentControl, IevEditorControl, l_EditorControl) then
  begin
   Result := l_EditorControl.Req.GetPrevVisible(l_EditorControl, OnlyFields,
     l_IsFirst);
   if l_IsFirst then
    Result := f_QueryCard.GetLastControl(l_EditorControl.Req, OnlyFields);
  end
  else
   if Supports(f_CurrentControl, IevQueryGroup, l_Group) then
    Result := f_QueryCard.GetLastVisible(l_Group, OnlyFields, False);
//#UC END# *47CD77B1038D_48B7FA9403B1_impl*
end;//TevControlIterator.GetPrevVisible

procedure TevControlIterator.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48B7FA9403B1_var*
//#UC END# *479731C50290_48B7FA9403B1_var*
begin
//#UC START# *479731C50290_48B7FA9403B1_impl*
 f_CurrentControl := nil;
 l3Free(f_QueryCard);
 inherited;
//#UC END# *479731C50290_48B7FA9403B1_impl*
end;//TevControlIterator.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function TevControlIterator.IsCacheable: Boolean;
 {* функция класса, определяющая могут ли объекты данного класса попадать в кэш повторного использования. }
//#UC START# *47A6FEE600FC_48B7FA9403B1_var*
//#UC END# *47A6FEE600FC_48B7FA9403B1_var*
begin
//#UC START# *47A6FEE600FC_48B7FA9403B1_impl*
 Result := true;
//#UC END# *47A6FEE600FC_48B7FA9403B1_impl*
end;//TevControlIterator.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

class function TevControlContainer.Make: IevQueryCard;
var
 l_Inst : TevControlContainer;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevControlContainer.Make

constructor TevControlContainer.Create;
//#UC START# *47CFF63F02B6_47CFEE9E02E1_var*
//#UC END# *47CFF63F02B6_47CFEE9E02E1_var*
begin
//#UC START# *47CFF63F02B6_47CFEE9E02E1_impl*
 inherited Create(nil);
 f_GroupList := TevQueryGroupList.Make;
 f_InsertRowMode := False;
//#UC END# *47CFF63F02B6_47CFEE9E02E1_impl*
end;//TevControlContainer.Create

function TevControlContainer.GetFirstVisible(const aGroup: IevQueryGroup;
 anOnlyFields: Boolean;
 anExpanedeOnly: Boolean): IevCustomEditorControl;
//#UC START# *47D0045001C3_47CFEE9E02E1_var*
var
 i, k       : Integer;
 l_Index    : Integer;
 l_Group    : IevQueryGroup;
 l_ReqCount : Integer;
//#UC END# *47D0045001C3_47CFEE9E02E1_var*
begin
//#UC START# *47D0045001C3_47CFEE9E02E1_impl*
 Result := nil;
 l_Index := f_GroupList.IndexOf(aGroup);
 if not aGroup.Expanded then //Если группа развернута, то можно просто получить первый контрол
  if not anExpanedeOnly then
   Inc(l_Index);
 if l_Index < f_GroupList.Count then
  for i := l_Index to f_GroupList.Count - 1 do
  begin
   l_Group := f_GroupList[i];
   if not anOnlyFields and not aGroup.Expanded then
   begin
    Result := l_Group;
    Break;
   end;
   l_ReqCount := l_Group.ReqCount - 1;
   for k := 0 to l_ReqCount do
   begin
    Result := l_Group.Req[k].GetFirstVisible(anOnlyFields);
    if Result <> nil then Break;
   end;
   if Result <> nil then Break;
  end;
//#UC END# *47D0045001C3_47CFEE9E02E1_impl*
end;//TevControlContainer.GetFirstVisible

function TevControlContainer.GetLastVisible(const aGroup: IevQueryGroup;
 anOnlyFields: Boolean;
 anExpanedeOnly: Boolean): IevCustomEditorControl;
//#UC START# *47D0048E01F2_47CFEE9E02E1_var*
var
 i, k       : Integer;
 l_Index    : Integer;
 l_Group    : IevQueryGroup;
 l_ReqCount : Integer;
//#UC END# *47D0048E01F2_47CFEE9E02E1_var*
begin
//#UC START# *47D0048E01F2_47CFEE9E02E1_impl*
 Result := nil;
 l_Index := f_GroupList.IndexOf(aGroup);
 if not anExpanedeOnly then
  Dec(l_Index);
 if l_Index >= 0 then
  for i := l_Index downto 0 do
  begin
   l_Group := f_GroupList[i];
   if not anOnlyFields and not l_Group.Expanded then
   begin
    Result := l_Group;
    Break;
   end;
   l_ReqCount := l_Group.ReqCount - 1;
   for k := l_ReqCount downto 0 do
   begin
    Result := l_Group.Req[k].GetLastVisible(anOnlyFields);
    if Result <> nil then Break;
   end;
   if Result <> nil then Break;
  end;
//#UC END# *47D0048E01F2_47CFEE9E02E1_impl*
end;//TevControlContainer.GetLastVisible

function TevControlContainer.GetFirstControl(const aReq: IevReq;
 anOnlyFields: Boolean): IevCustomEditorControl;
//#UC START# *47D0074B0107_47CFEE9E02E1_var*
var
 l_Req  : IevReq;
 l_Last : Boolean;
//#UC END# *47D0074B0107_47CFEE9E02E1_var*
begin
//#UC START# *47D0074B0107_47CFEE9E02E1_impl*
 Result := nil;
 l_Req := aReq;
 while l_Req <> nil do
 begin
  l_Req := GetNextReq(l_Req, anOnlyFields, l_Last);
  if (l_Req <> nil) and not anOnlyFields and l_Last then //Переход по всем контролам
  begin
   Result := l_Req.Group;
   Break;
  end
  else //Только по полям - группы игнорируются!
   if (l_Req <> nil) and l_Req.Group.Expanded then
   begin
    Result := l_Req.GetFirstVisible(anOnlyFields);
    if Result <> nil then
     Break;
   end
   else
    Result := nil;
 end;
//#UC END# *47D0074B0107_47CFEE9E02E1_impl*
end;//TevControlContainer.GetFirstControl

function TevControlContainer.GetLastControl(const aReq: IevReq;
 anOnlyFields: Boolean): IevCustomEditorControl;
//#UC START# *47D0075D03DF_47CFEE9E02E1_var*
var
 l_Req   : IevReq;
 l_First : Boolean;
//#UC END# *47D0075D03DF_47CFEE9E02E1_var*
begin
//#UC START# *47D0075D03DF_47CFEE9E02E1_impl*
 Result := nil;
 l_Req := aReq;
 while l_Req <> nil do
 begin
  l_Req := GetPrevReq(l_Req, anOnlyFields, l_First);
  if not anOnlyFields and l_First then //Переход по всем контролам
  begin
   Result := aReq.Group;
   Break;
  end
  else
   if l_Req <> nil then
   begin
    Result := l_Req.GetLastVisible(anOnlyFields);
    if anOnlyFields and (Result = nil) then
     Continue
    else
     Break;
   end
   else
    Result := nil;
 end;
//#UC END# *47D0075D03DF_47CFEE9E02E1_impl*
end;//TevControlContainer.GetLastControl

function TevControlContainer.GetNextReq(const aReq: IevReq;
 anExpandedOnly: Boolean;
 out aFirstReq: Boolean): IevReq;
 {* Возвращает следующий реквизит или nil, если такого нет. }
//#UC START# *47D009D1009A_47CFEE9E02E1_var*
//Функция возращает указатель на следующий реквизит. Если он является последним 
//в группе, то возвращается первый в следующей группе (aFirstReq выставляется 
//в True). Если группа последняя, то возвращается nil. Если выставлен 
//anExpandedOnly = True, то проверяются только развернутые группы и игнорируются 
//свернутые.                                     
var
 l_Req   : IevReq;
 l_Group : IevQueryGroup;
 l_Index : Integer;
//#UC END# *47D009D1009A_47CFEE9E02E1_var*
begin
//#UC START# *47D009D1009A_47CFEE9E02E1_impl*
 aFirstReq := False;
 l_Group := aReq.Group;
 l_Req := l_Group.GetNextReq(aReq);
 try
  if l_Req <> nil then
   Result := l_Req
  else
   if (f_GroupList.Last <> l_Group) then
   begin
    aFirstReq := True;
    l_Index := f_GroupList.IndexOf(l_Group);
    while l_Index < (f_GroupList.Count - 1) do        
    begin
     Inc(l_Index);
     l_Group := f_GroupList[l_Index];         
     if anExpandedOnly then 
      if l_Group.Expanded then 
       Break
      else 
       l_Group := nil
     else
      Break;  
    end; 
    if l_Group <> nil then
     Result := l_Group.Req[0]
    else 
     Result := nil;    
   end 
   else 
    Result := nil;
 finally
  l_Group := nil;
  l_Req := nil;
 end; 
//#UC END# *47D009D1009A_47CFEE9E02E1_impl*
end;//TevControlContainer.GetNextReq

function TevControlContainer.GetPrevReq(const aReq: IevReq;
 anExpandedOnly: Boolean;
 out aLastReq: Boolean): IevReq;
 {* Возвращает предыдущий реквизит. }
//#UC START# *47D00A370286_47CFEE9E02E1_var*
var
 l_Req   : IevReq;
 l_Group : IevQueryGroup;
 l_Index : Integer;
//#UC END# *47D00A370286_47CFEE9E02E1_var*
begin
//#UC START# *47D00A370286_47CFEE9E02E1_impl*
 aLastReq := False;
 l_Group := aReq.Group;
 l_Req := l_Group.GetPrevReq(aReq);
 try
  if l_Req <> nil then
   Result := l_Req
  else 
   if (f_GroupList.First <> l_Group) then
   begin
    aLastReq := True;
    l_Index := f_GroupList.IndexOf(l_Group);
    while l_Index > 0 do        
    begin
     Dec(l_Index);
     l_Group := f_GroupList[l_Index];         
     if anExpandedOnly then 
      if l_Group.Expanded then 
       Break
      else 
       l_Group := nil
     else
      Break;  
    end; 
    if l_Group <> nil then
     Result := l_Group.LastReq
    else 
     Result := nil;    
   end 
   else 
   begin
    aLastReq := l_Group.FirstReq = aReq;
    Result := nil;
   end; 
 finally
  l_Group := nil;
  l_Req := nil;
 end; 
//#UC END# *47D00A370286_47CFEE9E02E1_impl*
end;//TevControlContainer.GetPrevReq

function TevControlContainer.DoGetNode(anIndex: Integer): InevSimpleNode;
//#UC START# *47D010D10193_47CFEE9E02E1_var*
//#UC END# *47D010D10193_47CFEE9E02E1_var*
begin
//#UC START# *47D010D10193_47CFEE9E02E1_impl*
 Result := nil;
//#UC END# *47D010D10193_47CFEE9E02E1_impl*
end;//TevControlContainer.DoGetNode

procedure TevControlContainer.DoDeleteOnUndo(aTag: Tl3Tag);
//#UC START# *47D0111400DC_47CFEE9E02E1_var*
var
 l_Control : IevEditorControl;
 l_Req     : IevReq;
//#UC END# *47D0111400DC_47CFEE9E02E1_var*
begin
//#UC START# *47D0111400DC_47CFEE9E02E1_impl*
 l_Control := evGetEditorControl(aTag.Child[0].Child[0]);
 l_Req := l_Control.Req;
 if (l_Req <> nil) then
  l_Req.DeleteFromModel(nil, l_Control, True);
 f_CurrPara := nil;
//#UC END# *47D0111400DC_47CFEE9E02E1_impl*
end;//TevControlContainer.DoDeleteOnUndo

procedure TevControlContainer.DoChangePara(const aCurPara: InevPara);
//#UC START# *47D011870105_47CFEE9E02E1_var*
var
 l_Control: IevEditorControl;
//#UC END# *47D011870105_47CFEE9E02E1_var*
begin
//#UC START# *47D011870105_47CFEE9E02E1_impl*
 if (aCurPara <> nil) {and aCurPara.IsKindOf(k2_typLeafPara)} then
   f_CurrPara := aCurPara
 else
  f_CurrPara := nil;
 if f_CurrPara <> nil then
 begin
  if f_CurrPara.AsObject.IsKindOf(k2_typControlPara) then
  begin
   l_Control := evGetEditorControl(f_CurrPara.AsObject);
   if (l_Control <> nil) and (l_Control.ControlType in evEditControls) then
   begin
    RememberFocusControl(l_Control);
    RememberState(l_Control);
   end;
  end;
 end;
//#UC END# *47D011870105_47CFEE9E02E1_impl*
end;//TevControlContainer.DoChangePara

function TevControlContainer.DoKeyDown(const aView: InevView;
 var Msg: TWMKeyDown;
 aCurPara: Tl3Tag): Boolean;
 {* Посылка сообщений о нажатии клавиш. }
//#UC START# *47D0135901AC_47CFEE9E02E1_var*
//#UC END# *47D0135901AC_47CFEE9E02E1_var*
begin
//#UC START# *47D0135901AC_47CFEE9E02E1_impl*
 Result := False; //Мы не забираем обработку на себя, а только обрабатываем событие
 if (Msg.CharCode = VK_APPS) then
  f_StateControl := GetFocusedControl(aCurPara);
//#UC END# *47D0135901AC_47CFEE9E02E1_impl*
end;//TevControlContainer.DoKeyDown

function TevControlContainer.CanInsertPara: Boolean;
 {* Разрешено ли вставлять параграф. }
//#UC START# *47C6BE3B027A_47CFEE9E02E1_var*
//#UC END# *47C6BE3B027A_47CFEE9E02E1_var*
begin
//#UC START# *47C6BE3B027A_47CFEE9E02E1_impl*
 Result := f_InsertRowMode;
//#UC END# *47C6BE3B027A_47CFEE9E02E1_impl*
end;//TevControlContainer.CanInsertPara

procedure TevControlContainer.InsertOnUndo(aPrev: Tl3Variant;
 aChild: Tl3Variant;
 anAdd: Boolean);
 {* Реакция на вставку при откатке. }
//#UC START# *47C7C8EE0193_47CFEE9E02E1_var*
var
 l_Control : IevEditorControl;
 l_Req     : IevReq;
//#UC END# *47C7C8EE0193_47CFEE9E02E1_var*
begin
//#UC START# *47C7C8EE0193_47CFEE9E02E1_impl*
 l_Control := evGetEditorControl(aPrev.Child[0].Child[0]);
 l_Req := l_Control.Req;
 l_Req.InsertToModel(nil, l_Control, aChild, True, anAdd);
//#UC END# *47C7C8EE0193_47CFEE9E02E1_impl*
end;//TevControlContainer.InsertOnUndo

procedure TevControlContainer.DeleteOnUndo(aTag: Tl3Variant);
 {* Реакция удаления при откатке. }
//#UC START# *47C7C9070379_47CFEE9E02E1_var*
//#UC END# *47C7C9070379_47CFEE9E02E1_var*
begin
//#UC START# *47C7C9070379_47CFEE9E02E1_impl*
 DoDeleteOnUndo(aTag);
//#UC END# *47C7C9070379_47CFEE9E02E1_impl*
end;//TevControlContainer.DeleteOnUndo

procedure TevControlContainer.HideDroppedControl(CanSetFocus: Boolean);
 {* Обработчик изменения события состояния редактора (нужно для выпадающего контрола). }
//#UC START# *47C7C91E0277_47CFEE9E02E1_var*
//#UC END# *47C7C91E0277_47CFEE9E02E1_var*
begin
//#UC START# *47C7C91E0277_47CFEE9E02E1_impl*
 DoHideDroppedControl(CanSetFocus)
//#UC END# *47C7C91E0277_47CFEE9E02E1_impl*
end;//TevControlContainer.HideDroppedControl

function TevControlContainer.MouseWheel(aDown: Boolean): Boolean;
 {* Событие прокрутки мыши. }
//#UC START# *47C7C9A4014C_47CFEE9E02E1_var*
//#UC END# *47C7C9A4014C_47CFEE9E02E1_var*
begin
//#UC START# *47C7C9A4014C_47CFEE9E02E1_impl*
 Result := DoMouseWheel(aDown);
//#UC END# *47C7C9A4014C_47CFEE9E02E1_impl*
end;//TevControlContainer.MouseWheel

function TevControlContainer.KeyDown(const aView: InevView;
 var Msg: TWMKeyDown;
 aCurPara: Tl3Variant): Boolean;
 {* Посылка сообщений о нажатии клавиш. }
//#UC START# *47C7CA230160_47CFEE9E02E1_var*
//#UC END# *47C7CA230160_47CFEE9E02E1_var*
begin
//#UC START# *47C7CA230160_47CFEE9E02E1_impl*
 Result := DoKeyDown(aView, Msg, aCurPara);
//#UC END# *47C7CA230160_47CFEE9E02E1_impl*
end;//TevControlContainer.KeyDown

procedure TevControlContainer.ChangePara(const aCurPara: InevPara);
 {* Событие смена текуего параграфа. }
//#UC START# *47C7CA350361_47CFEE9E02E1_var*
//#UC END# *47C7CA350361_47CFEE9E02E1_var*
begin
//#UC START# *47C7CA350361_47CFEE9E02E1_impl*
 DoChangePara(aCurPara);
//#UC END# *47C7CA350361_47CFEE9E02E1_impl*
end;//TevControlContainer.ChangePara

procedure TevControlContainer.BeforeRMouseClick;
 {* Событие, вызываемое перед обработкой мыши. }
//#UC START# *47C7CA4500E7_47CFEE9E02E1_var*
//#UC END# *47C7CA4500E7_47CFEE9E02E1_var*
begin
//#UC START# *47C7CA4500E7_47CFEE9E02E1_impl*
 f_StateControl := nil;
//#UC END# *47C7CA4500E7_47CFEE9E02E1_impl*
end;//TevControlContainer.BeforeRMouseClick

procedure TevControlContainer.ClearUpper;
//#UC START# *47C7CA5402D0_47CFEE9E02E1_var*
//#UC END# *47C7CA5402D0_47CFEE9E02E1_var*
begin
//#UC START# *47C7CA5402D0_47CFEE9E02E1_impl*
 if f_UpperButtons <> nil then
 begin
  f_UpperButtons.Upper := False;
  f_UpperButtons := nil;
 end;
//#UC END# *47C7CA5402D0_47CFEE9E02E1_impl*
end;//TevControlContainer.ClearUpper

function TevControlContainer.NeedKey(aPara: Tl3Variant;
 var aKeyCode: Word): Boolean;
 {* Контрол/Поле перехватывает курсор. }
//#UC START# *47C7CA670121_47CFEE9E02E1_var*
var
 l_Field    : IevEditorControlField;
 l_FieldWithTree: IevEditorFieldWithTree;
//#UC END# *47C7CA670121_47CFEE9E02E1_var*
begin
//#UC START# *47C7CA670121_47CFEE9E02E1_impl*
 Result := False;                                 
 l_Field := evGetField(aPara);
 if (l_Field <> nil) and (aKeyCode in [VK_SUBTRACT, VK_ADD]) then
 begin
  Supports(l_Field, IevEditorFieldWithTree, l_FieldWithTree);
  if (l_FieldWithTree = nil) or l_FieldWithTree.IsList or (l_FieldWithTree.ComboStyle <> ev_cbFilterable) then
  begin
   if aKeyCode = VK_SUBTRACT then
    aKeyCode := cMinusKeyCode
   else
    aKeyCode := cPlusKeyCode;
   Result := True;
  end;
 end;
//#UC END# *47C7CA670121_47CFEE9E02E1_impl*
end;//TevControlContainer.NeedKey

procedure TevControlContainer.CursorCreate;
 {* Обновить курсор после создания. }
//#UC START# *47C7CB490100_47CFEE9E02E1_var*
//#UC END# *47C7CB490100_47CFEE9E02E1_var*
begin
//#UC START# *47C7CB490100_47CFEE9E02E1_impl*
 if f_StartFocusControl <> nil then
 begin
  with pm_GetEditor do
   if (Selection <> nil) and not Selection.Point.MostInner.Obj.AsObject.IsSame(f_StartFocusControl.Para.MakePoint.MostInner.Obj^.AsObject) then
    Selection.SelectPoint(f_StartFocusControl.Para.MakePoint, False);
  f_StartFocusControl := nil;
 end;
//#UC END# *47C7CB490100_47CFEE9E02E1_impl*
end;//TevControlContainer.CursorCreate

procedure TevControlContainer.UpdateState;
//#UC START# *47C7CB5403D4_47CFEE9E02E1_var*
var
 l_Field: IevEditorControlField;
 l_GroupIdx: Integer;
 l_ReqIdx: Integer;
 l_FieldIdx: Integer;
 l_FieldWithTree: IevEditorFieldWithTree;
 l_op: InevOp;
//#UC END# *47C7CB5403D4_47CFEE9E02E1_var*
begin
//#UC START# *47C7CB5403D4_47CFEE9E02E1_impl*
 l_op := f_QueryContainer.Processor.StartOp(0,True);
 try
  if (f_StateControl <> nil) and
   Supports(f_StateControl, IevEditorControlField, l_Field) then
  begin
   l_Field.Req.Group.Para.OwnerPara.Invalidate([]);
   l_Field.Req.SetFocus(l_Field);
  end;
  l_op.SaveUndo := False;
  for l_GroupIdx := 0 to Get_GroupCount-1 do
   with Get_QueryGroup(l_GroupIdx) do
    for l_ReqIdx := 0 to ReqCount-1 do
     with Req[l_ReqIdx] do
      for l_FieldIdx := 0 to FieldsCount-1 do
      begin
       if Supports(Fields[l_FieldIdx], IevEditorFieldWithTree, l_FieldWithTree) then
        l_FieldWithTree.CheckTextVersusValue;
       UpdateState(Fields[l_FieldIdx], l_op);
      end;
 finally
  l_op := nil;
 end;
//#UC END# *47C7CB5403D4_47CFEE9E02E1_impl*
end;//TevControlContainer.UpdateState

function TevControlContainer.IsLastField(aPara: Tl3Variant): Boolean;
 {* Проверяет является ли параграф последним для передачи фокуса. }
//#UC START# *47C7CB5D0311_47CFEE9E02E1_var*
var
 l_Control : IevCustomEditorControl;
 l_Group   : IevQueryGroup;
//#UC END# *47C7CB5D0311_47CFEE9E02E1_var*
begin
//#UC START# *47C7CB5D0311_47CFEE9E02E1_impl*
 if aPara.TagType.IsSame(k2_typControlPara) then
 begin
  l_Control := evGetCustomControl(aPara);
  if l_Control <> nil then
  begin
   l_Control := GetControlIterator(l_Control).GetNextVisible(False);
  end;
  Result := l_Control = nil;
 end
 else
 begin
  l_Group := evGetQueryGroup(aPara);
  Result := f_GroupList.IndexOf(l_Group) = f_GroupList.Count - 1;
 end;
//#UC END# *47C7CB5D0311_47CFEE9E02E1_impl*
end;//TevControlContainer.IsLastField

function TevControlContainer.IsFirstField(aPara: Tl3Variant): Boolean;
 {* Проверяет является ли параграф первым для передачи фокуса. }
//#UC START# *47C7CBC903AE_47CFEE9E02E1_var*
var
 l_Control : IevCustomEditorControl;
 l_Group   : IevQueryGroup;
//#UC END# *47C7CBC903AE_47CFEE9E02E1_var*
begin
//#UC START# *47C7CBC903AE_47CFEE9E02E1_impl*
 if aPara.TagType.IsSame(k2_typControlPara) then
 begin
  l_Control := evGetCustomControl(aPara);
  if l_Control <> nil then
  begin
   l_Control := GetControlIterator(l_Control).GetPrevVisible(False);
  end;
  Result := l_Control = nil;
 end
 else
 begin
  l_Group := evGetQueryGroup(aPara);
  Result := f_GroupList.IndexOf(l_Group) = 0;
 end;
//#UC END# *47C7CBC903AE_47CFEE9E02E1_impl*
end;//TevControlContainer.IsFirstField

procedure TevControlContainer.StartPaste;
 {* Скобки для операции вставки. }
//#UC START# *47C7CBDE0030_47CFEE9E02E1_var*
//#UC END# *47C7CBDE0030_47CFEE9E02E1_var*
begin
//#UC START# *47C7CBDE0030_47CFEE9E02E1_impl*
 f_PasteOperation := True;
//#UC END# *47C7CBDE0030_47CFEE9E02E1_impl*
end;//TevControlContainer.StartPaste

procedure TevControlContainer.FinishPaste;
 {* Скобки для операции вставки. }
//#UC START# *47C7CBEA02E3_47CFEE9E02E1_var*
//#UC END# *47C7CBEA02E3_47CFEE9E02E1_var*
begin
//#UC START# *47C7CBEA02E3_47CFEE9E02E1_impl*
 f_PasteOperation := False;
 if Assigned(f_LimitErrorControl) then
  IevAdapterModel(f_AdapterModel).LimitCharsReached(f_LimitErrorControl);
 f_LimitErrorControl := nil;
//#UC END# *47C7CBEA02E3_47CFEE9E02E1_impl*
end;//TevControlContainer.FinishPaste

function TevControlContainer.IsPasting: Boolean;
 {* Внутри скобок для операции вставки. }
//#UC START# *47C7CBF803D7_47CFEE9E02E1_var*
//#UC END# *47C7CBF803D7_47CFEE9E02E1_var*
begin
//#UC START# *47C7CBF803D7_47CFEE9E02E1_impl*
 Result := f_PasteOperation;
//#UC END# *47C7CBF803D7_47CFEE9E02E1_impl*
end;//TevControlContainer.IsPasting

function TevControlContainer.GetFirstPara(OnlyFields: Boolean): InevPara;
 {* Получить первый параграф, в который может получить фокус. }
//#UC START# *47C7CC09021A_47CFEE9E02E1_var*
var
 i         : Integer;
 l_Count   : Integer;
 l_Control : IevCustomEditorControl;
//#UC END# *47C7CC09021A_47CFEE9E02E1_var*
begin
//#UC START# *47C7CC09021A_47CFEE9E02E1_impl*
 l_Count := f_GroupList.Count - 1;
 for i := 0 to l_Count do
 begin
  l_Control := GetFirstVisible(f_GroupList[i], False, True);
  if l_Control <> nil then Break;
 end;
 if l_Control <> nil then
  Result := l_Control.Para
 else
  Result := nil;
//#UC END# *47C7CC09021A_47CFEE9E02E1_impl*
end;//TevControlContainer.GetFirstPara

function TevControlContainer.GetLastPara(OnlyFields: Boolean): InevPara;
 {* Получить последний параграф, в который может получить фокус. }
//#UC START# *47C7CC480009_47CFEE9E02E1_var*
var
 i         : Integer;
 l_Count   : Integer;
 l_Control : IevCustomEditorControl;
//#UC END# *47C7CC480009_47CFEE9E02E1_var*
begin
//#UC START# *47C7CC480009_47CFEE9E02E1_impl*
 l_Count := f_GroupList.Count - 1;
 for i := l_Count downto 0 do
 begin
  l_Control := GetLastVisible(f_GroupList[i], False, True);
  if l_Control <> nil then Break;
 end;
 if l_Control <> nil then
  Result := l_Control.Para
 else
  Result := nil;
//#UC END# *47C7CC480009_47CFEE9E02E1_impl*
end;//TevControlContainer.GetLastPara

procedure TevControlContainer.SetCurrPara(const aCurPara: InevPara);
//#UC START# *47CD829A0262_47CFEE9E02E1_var*
//#UC END# *47CD829A0262_47CFEE9E02E1_var*
begin
//#UC START# *47CD829A0262_47CFEE9E02E1_impl*
 f_CurrPara := aCurPara;
//#UC END# *47CD829A0262_47CFEE9E02E1_impl*
end;//TevControlContainer.SetCurrPara

function TevControlContainer.GetDocumentContainer: InevQueryDocumentContainer;
 {* Получить контейнер документа. }
//#UC START# *47CD82A70217_47CFEE9E02E1_var*
//#UC END# *47CD82A70217_47CFEE9E02E1_var*
begin
//#UC START# *47CD82A70217_47CFEE9E02E1_impl*
 Result := f_QueryContainer;
//#UC END# *47CD82A70217_47CFEE9E02E1_impl*
end;//TevControlContainer.GetDocumentContainer

procedure TevControlContainer.RememberFocusControl(const aValue: IevEditorControl);
 {* Запомнить контрол для установки фокуса. }
//#UC START# *47CD82BA01D2_47CFEE9E02E1_var*
//#UC END# *47CD82BA01D2_47CFEE9E02E1_var*
begin
//#UC START# *47CD82BA01D2_47CFEE9E02E1_impl*
 f_StartFocusControl := aValue;
 RememberState(aValue);
//#UC END# *47CD82BA01D2_47CFEE9E02E1_impl*
end;//TevControlContainer.RememberFocusControl

procedure TevControlContainer.BeforeDelete;
 {* Вызывается перед удалением поля. }
//#UC START# *47CD82C800FB_47CFEE9E02E1_var*
//#UC END# *47CD82C800FB_47CFEE9E02E1_var*
begin
//#UC START# *47CD82C800FB_47CFEE9E02E1_impl*
 ClearUpper;
 f_StateControl := nil;
 f_CurrPara := nil;
//#UC END# *47CD82C800FB_47CFEE9E02E1_impl*
end;//TevControlContainer.BeforeDelete

procedure TevControlContainer.UpperChange(const aButton: IevCustomEditorControl);
 {* Вызывается после установки Upper у кнопки в True. }
//#UC START# *47CD82DD0015_47CFEE9E02E1_var*
//#UC END# *47CD82DD0015_47CFEE9E02E1_var*
begin
//#UC START# *47CD82DD0015_47CFEE9E02E1_impl*
 if (f_UpperButtons <> aButton) then
 begin
  if (f_UpperButtons <> nil) then
   f_UpperButtons.Upper := False;
  if aButton <> nil then
   f_UpperButtons := aButton
  else
   f_UpperButtons := nil;
 end;
//#UC END# *47CD82DD0015_47CFEE9E02E1_impl*
end;//TevControlContainer.UpperChange

function TevControlContainer.GetNode(anIndex: Integer): InevSimpleNode;
 {* Возвращает узел по номеру. }
//#UC START# *47CD82ED006B_47CFEE9E02E1_var*
//#UC END# *47CD82ED006B_47CFEE9E02E1_var*
begin
//#UC START# *47CD82ED006B_47CFEE9E02E1_impl*
 Result := DoGetNode(anIndex);
//#UC END# *47CD82ED006B_47CFEE9E02E1_impl*
end;//TevControlContainer.GetNode

procedure TevControlContainer.CardClear;
 {* Обработчик очистки КЗ. }
//#UC START# *47CD82FE0071_47CFEE9E02E1_var*
//#UC END# *47CD82FE0071_47CFEE9E02E1_var*
begin
//#UC START# *47CD82FE0071_47CFEE9E02E1_impl*
 f_QueryContainer.ClearCard;
//#UC END# *47CD82FE0071_47CFEE9E02E1_impl*
end;//TevControlContainer.CardClear

procedure TevControlContainer.StartLongOperation;
 {* Скобки для блокировки перерисовок в редакторе. }
//#UC START# *47CD830E0357_47CFEE9E02E1_var*
//#UC END# *47CD830E0357_47CFEE9E02E1_var*
begin
//#UC START# *47CD830E0357_47CFEE9E02E1_impl*
 f_QueryContainer.Lock.Lock(Self);
//#UC END# *47CD830E0357_47CFEE9E02E1_impl*
end;//TevControlContainer.StartLongOperation

procedure TevControlContainer.EndLongOperation;
 {* Скобки для блокировки перерисовок в редакторе. }
//#UC START# *47CD831A0092_47CFEE9E02E1_var*
//#UC END# *47CD831A0092_47CFEE9E02E1_var*
begin
//#UC START# *47CD831A0092_47CFEE9E02E1_impl*
 f_QueryContainer.Lock.Unlock(Self);
//#UC END# *47CD831A0092_47CFEE9E02E1_impl*
end;//TevControlContainer.EndLongOperation

procedure TevControlContainer.ChangeStateAll(anExpand: Boolean);
 {* Выставляет признак развернутости/свернутости всем группам. }
//#UC START# *47CD83410138_47CFEE9E02E1_var*
var
 i       : Integer;
 l_Count : Integer;
//#UC END# *47CD83410138_47CFEE9E02E1_var*
begin
//#UC START# *47CD83410138_47CFEE9E02E1_impl*
 l_Count := f_GroupList.Count - 1;
 for i := 0 to l_Count do
  f_GroupList[i].Expanded := anExpand;
//#UC END# *47CD83410138_47CFEE9E02E1_impl*
end;//TevControlContainer.ChangeStateAll

procedure TevControlContainer.AfterCollapsed(const aGroup: IevQueryGroup);
//#UC START# *47CD835002FB_47CFEE9E02E1_var*
//#UC END# *47CD835002FB_47CFEE9E02E1_var*
begin
//#UC START# *47CD835002FB_47CFEE9E02E1_impl*
 if not aGroup.Expanded then
  f_CurrPara := aGroup.Para;
 f_QueryContainer.AfterCollapsed;
//#UC END# *47CD835002FB_47CFEE9E02E1_impl*
end;//TevControlContainer.AfterCollapsed

procedure TevControlContainer.LimitCharsReached(const aControl: IevEditorControl);
 {* Обработчик достижения максимального числа символов в параграфе. }
//#UC START# *47CD83830353_47CFEE9E02E1_var*
//#UC END# *47CD83830353_47CFEE9E02E1_var*
begin
//#UC START# *47CD83830353_47CFEE9E02E1_impl*
 if f_PasteOperation then
  f_LimitErrorControl := aControl
 else
  IevAdapterModel(f_AdapterModel).LimitCharsReached(aControl);
//#UC END# *47CD83830353_47CFEE9E02E1_impl*
end;//TevControlContainer.LimitCharsReached

procedure TevControlContainer.RememberState(const aControl: IevCustomEditorControl);
 {* Запомнить состояние для контекстного меню. }
//#UC START# *47CD839201D4_47CFEE9E02E1_var*
//#UC END# *47CD839201D4_47CFEE9E02E1_var*
begin
//#UC START# *47CD839201D4_47CFEE9E02E1_impl*
 f_StateControl := aControl;
//#UC END# *47CD839201D4_47CFEE9E02E1_impl*
end;//TevControlContainer.RememberState

function TevControlContainer.GetStateControl: IevCustomEditorControl;
 {* Возвращает контрол, который был активным при вызове контекстного меню. }
//#UC START# *47CD83A1034C_47CFEE9E02E1_var*
//#UC END# *47CD83A1034C_47CFEE9E02E1_var*
begin
//#UC START# *47CD83A1034C_47CFEE9E02E1_impl*
 Result := f_StateControl;
//#UC END# *47CD83A1034C_47CFEE9E02E1_impl*
end;//TevControlContainer.GetStateControl

function TevControlContainer.GetFocusedControl(aCurPara: Tl3Variant): IevEditorControl;
 {* Возвращает контрол, имеющий фокус ввода. }
//#UC START# *47CD83B10329_47CFEE9E02E1_var*
var
 l_Group: IevQueryGroup;
//#UC END# *47CD83B10329_47CFEE9E02E1_var*
begin
//#UC START# *47CD83B10329_47CFEE9E02E1_impl*
 aCurPara.QT(InevPara, f_CurrPara);
 if f_CurrPara <> nil then
 begin
  Result := evGetEditorControl(f_CurrPara.AsObject);
  if Result <> nil then
   if Result.ControlType = ev_ctCollapsedPanel then
    if Supports(Result, IevQueryGroup, l_Group) then
     Result := l_Group.FirstReq.FirstField;
 end
 else
  Result := nil;
//#UC END# *47CD83B10329_47CFEE9E02E1_impl*
end;//TevControlContainer.GetFocusedControl

procedure TevControlContainer.LinkView(const aQueryContainer: InevQueryDocumentContainer);
 {* Инициализации модели. }
//#UC START# *47CD83C8037F_47CFEE9E02E1_var*
   
 function GetChildBlock(const aChild : InevPara; 
                        anIndex      : Integer): Boolean; 
 var
  l_CG  : IevQueryGroup;
  l_Tbl : InevPara;
  l_Index : Integer;
  l_List  : InevParaList;
 begin
  Result := True;
  with aChild do
   if AsObject.IsKindOf(k2_typControlsBlock) then
   begin
    l_List := aChild.AsList;
//    for l_Index := 0 to l_List.ChildrenCount - 1 do
    begin
     l_CG := TevControlGroup.Make(aChild, Self);
     try
      for l_Index := 0 to l_List.AsObject.ChildrenCount - 1 do
      // - ведь таблиц внутри группы может быть сколько угодно
      begin
       l_Tbl := l_List.Para[l_Index];
       try
        l_CG.InitModel(l_Tbl);
       finally
        l_Tbl := nil;
       end;//try..finally
      end;//for l_Index
      f_GroupList.Add(l_CG);
     finally
      l_CG := nil;
     end; //try..finally
    end;//for l_Index
   end;//if IsKindOf(k2_typControlBlock)
 end;//GetChildBlock

//#UC END# *47CD83C8037F_47CFEE9E02E1_var*
begin
//#UC START# *47CD83C8037F_47CFEE9E02E1_impl*
 if (f_GroupList <> nil) then
  f_GroupList.Clear;
 f_QueryContainer := aQueryContainer;
 with aQueryContainer do
 begin
  LinkListener(Self);
  Assert(Obj.AsPara.AsObject.ChildrenCount <> 0, 'Нет дочерних параграфов!!!');
  with Obj do
   if AsObject.IsValid then
   begin
    with AsPara.AsList do
     IterateParaF(nevL2PIA(@GetChildBlock));
    Set_Para(AsPara);
   end;//if IsValid
 end;//with aQueryContainer
 StartSetFocus;
//#UC END# *47CD83C8037F_47CFEE9E02E1_impl*
end;//TevControlContainer.LinkView

procedure TevControlContainer.LinkListener(const aListener: IevAdapterModel);
 {* Подключить объект из внешней модели. }
//#UC START# *47CD83DC0133_47CFEE9E02E1_var*
//#UC END# *47CD83DC0133_47CFEE9E02E1_var*
begin
//#UC START# *47CD83DC0133_47CFEE9E02E1_impl*
 f_AdapterModel := Pointer(aListener);
//#UC END# *47CD83DC0133_47CFEE9E02E1_impl*
end;//TevControlContainer.LinkListener

function TevControlContainer.AdapterModel: IevAdapterModel;
//#UC START# *47CD83EE0268_47CFEE9E02E1_var*
//#UC END# *47CD83EE0268_47CFEE9E02E1_var*
begin
//#UC START# *47CD83EE0268_47CFEE9E02E1_impl*
 Result := IevAdapterModel(f_AdapterModel);
//#UC END# *47CD83EE0268_47CFEE9E02E1_impl*
end;//TevControlContainer.AdapterModel

procedure TevControlContainer.ReleaseListeners;
 {* Отключить объект из внешней модели. }
//#UC START# *47CD840002F7_47CFEE9E02E1_var*
//#UC END# *47CD840002F7_47CFEE9E02E1_var*
begin
//#UC START# *47CD840002F7_47CFEE9E02E1_impl*
 f_AdapterModel := nil;
//#UC END# *47CD840002F7_47CFEE9E02E1_impl*
end;//TevControlContainer.ReleaseListeners

function TevControlContainer.FindDescriptionReq(const aReqName: Tl3WString): IevDescriptionReq;
 {* Получение реквизита по имени. }
//#UC START# *47CD842102B4_47CFEE9E02E1_var*
var
 i       : Integer;
 l_Count : Integer;
 l_Group : IevQueryGroup;
//#UC END# *47CD842102B4_47CFEE9E02E1_var*
begin
//#UC START# *47CD842102B4_47CFEE9E02E1_impl*
 l_Count := f_GroupList.Count - 1;
 for i := 0 to l_Count do
 begin
  l_Group := f_GroupList[i];
  try
   Result := l_Group.FindDescriptionReq(aReqName);
   if Result <> nil then
    Break;
  finally
   l_Group := nil;
  end;
 end;
//#UC END# *47CD842102B4_47CFEE9E02E1_impl*
end;//TevControlContainer.FindDescriptionReq

procedure TevControlContainer.StartSetFocus;
 {* Возвращает первое доступное для редактирования поле в контроле. }
//#UC START# *47CD843F005D_47CFEE9E02E1_var*
var
 l_Control: IevEditorControl;
//#UC END# *47CD843F005D_47CFEE9E02E1_var*
begin
//#UC START# *47CD843F005D_47CFEE9E02E1_impl*
 l_Control := evGetEditorControl(GetDocumentContainer.GetCurrPara);
 if Assigned(l_Control) and (l_Control.ControlType in evEditControls) then
  RememberFocusControl(l_Control)
 else
  if f_AdapterModel <> nil then
   IevAdapterModel(f_AdapterModel).FocusStartField
  else
   if f_GroupList.Count > 0 then
    f_GroupList.First.FirstReq.FirstField.SetFocus
//#UC END# *47CD843F005D_47CFEE9E02E1_impl*
end;//TevControlContainer.StartSetFocus

function TevControlContainer.Get_QueryGroup(anIndex: Integer): IevQueryGroup;
//#UC START# *47CD84520292_47CFEE9E02E1get_var*
//#UC END# *47CD84520292_47CFEE9E02E1get_var*
begin
//#UC START# *47CD84520292_47CFEE9E02E1get_impl*
 Result := f_GroupList[anIndex];
//#UC END# *47CD84520292_47CFEE9E02E1get_impl*
end;//TevControlContainer.Get_QueryGroup

function TevControlContainer.Get_GroupCount: Integer;
//#UC START# *47CD8478024F_47CFEE9E02E1get_var*
//#UC END# *47CD8478024F_47CFEE9E02E1get_var*
begin
//#UC START# *47CD8478024F_47CFEE9E02E1get_impl*
 Result := f_GroupList.Count;
//#UC END# *47CD8478024F_47CFEE9E02E1get_impl*
end;//TevControlContainer.Get_GroupCount

function TevControlContainer.pm_GetEditor: InevControl;
//#UC START# *47CD84A1019A_47CFEE9E02E1get_var*
var
 l_Containter : InevDocumentContainer;
//#UC END# *47CD84A1019A_47CFEE9E02E1get_var*
begin
//#UC START# *47CD84A1019A_47CFEE9E02E1get_impl*
 //!!!Stub: Если нужно будет отображать документ в нескольких окнах, то это место нужно переделать! 
 if (f_QueryContainer <> nil) and
   Supports(f_QueryContainer, InevDocumentContainer, l_Containter) then
  l_Containter.TextSource.CastAnyEditorTo(InevControl, Result)
 else 
  Result := nil;   
//#UC END# *47CD84A1019A_47CFEE9E02E1get_impl*
end;//TevControlContainer.pm_GetEditor

function TevControlContainer.Get_InsertRowMode: Boolean;
//#UC START# *47CD84BB0044_47CFEE9E02E1get_var*
//#UC END# *47CD84BB0044_47CFEE9E02E1get_var*
begin
//#UC START# *47CD84BB0044_47CFEE9E02E1get_impl*
 Result := f_InsertRowMode;
//#UC END# *47CD84BB0044_47CFEE9E02E1get_impl*
end;//TevControlContainer.Get_InsertRowMode

procedure TevControlContainer.Set_InsertRowMode(aValue: Boolean);
//#UC START# *47CD84BB0044_47CFEE9E02E1set_var*
//#UC END# *47CD84BB0044_47CFEE9E02E1set_var*
begin
//#UC START# *47CD84BB0044_47CFEE9E02E1set_impl*
 f_InsertRowMode := aValue;
//#UC END# *47CD84BB0044_47CFEE9E02E1set_impl*
end;//TevControlContainer.Set_InsertRowMode

function TevControlContainer.pm_GetCardType: TevQueryType;
//#UC START# *47CD84CC027E_47CFEE9E02E1get_var*
//#UC END# *47CD84CC027E_47CFEE9E02E1get_var*
begin
//#UC START# *47CD84CC027E_47CFEE9E02E1get_impl*
 Result := TevQueryType(Para.AsObject.IntA[k2_tiCardType]);
//#UC END# *47CD84CC027E_47CFEE9E02E1get_impl*
end;//TevControlContainer.pm_GetCardType

function TevControlContainer.GetControlIterator(const aCurrentControl: IevCustomEditorControl): IevControlIterator;
//#UC START# *48B7F005003D_47CFEE9E02E1_var*
//#UC END# *48B7F005003D_47CFEE9E02E1_var*
begin
//#UC START# *48B7F005003D_47CFEE9E02E1_impl*
 Result := TevControlIterator.Make(aCurrentControl, Self);
//#UC END# *48B7F005003D_47CFEE9E02E1_impl*
end;//TevControlContainer.GetControlIterator

procedure TevControlContainer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47CFEE9E02E1_var*
//#UC END# *479731C50290_47CFEE9E02E1_var*
begin
//#UC START# *479731C50290_47CFEE9E02E1_impl*
 f_LimitErrorControl := nil;
 f_UpperButtons := nil;
 f_StateControl := nil;
 f_StartFocusControl := nil;
 f_CurrPara := nil;
 if (f_QueryContainer <> nil) then
  f_QueryContainer.UnlinkListener(Self);
 f_QueryContainer := nil;
 f_AdapterModel := nil;
 l3Free(f_GroupList);
 inherited;
//#UC END# *479731C50290_47CFEE9E02E1_impl*
end;//TevControlContainer.Cleanup

end.
