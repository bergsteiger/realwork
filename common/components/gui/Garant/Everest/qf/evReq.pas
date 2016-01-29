unit evReq;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Инишев Д.А.
// Модуль: "w:/common/components/gui/Garant/Everest/qf/evReq.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::qf::TevReq
//
// Класс реквизита (одельная строка в таблице)
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  evdTypes,
  l3Base,
  nevTools,
  evQueryCardInt,
  evEditorControlList,
  evEditorControlFieldList,
  evCustomControlTool,
  evControl,
  l3Variant,
  nevBase,
  l3Interfaces
  ;

type
 RevControlClass = class of evControl.TevControl;

 TevReq = class(TevCustomControlTool, IevReq, IevComboReq, IevDatesReq, IevPhoneReq)
  {* Класс реквизита (одельная строка в таблице) }
 private
 // private fields
   f_FieldsList : TevEditorControlFieldList;
    {* Список полей для каждого реквизита группы (IevEditorControlField)}
   f_ControlsList : TevEditorControlList;
    {* Список виджетов для каждого реквизита (IevEditorControl)}
   f_ReqCaption : Tl3String;
    {* Текст метки реквизита}
   f_Group : Tl3Variant;
 private
 // private methods
   function AddValue(const aView: InevView;
    const aControl: IevEditorControl;
    const aPara: InevPara = nil;
    ToModel: Boolean = False;
    anAdd: Boolean = False): Boolean;
     {* Добавление нового поля в реквизит. aControl - виджет (поле или любой
         виджет возле поля), ToModel: только добавляем в модель aPara }
   function DeleteValue(const aView: InevView;
    const aControl: IevEditorControl = nil;
    ToModel: Boolean = False): Integer;
     {* Удаление поля из реквизита. Возвращает индекс поля вставшего вместо удаленного }
   function GetControlClass(aControlType: TevControlType): RevControlClass;
   function CanVisibleLogicBtn: Boolean;
   function LogicBtnEnabled: Boolean;
 protected
 // realized methods
   procedure KeyAction(aCmd: Word);
     {* "Внешняя" обработка команды. }
   function AnalyzeString(const aValue: Il3CString;
    out aRslt: Il3CString): Boolean;
   procedure TextChange(const aView: InevView);
     {* Обработчик события изменения текста. }
   procedure RememberState(const aControl: IevCustomEditorControl);
     {* Запомнить состояние контрола для всплывающего меню. }
   function GetNextVisible(const aControl: IevEditorControl;
    OnlyFields: Boolean;
    out anIsLastField: Boolean): IevEditorControl;
     {* Возвращает следующий видимый контрол. }
   function GetFirstVisible(OnlyFields: Boolean): IevEditorControl;
     {* Возвращает первый видимый контрол для реквизита. }
   function GetPrevVisible(const aControl: IevEditorControl;
    OnlyFields: Boolean;
    out anIsFirstField: Boolean): IevEditorControl;
     {* Возвращает следующий видимый контрол. }
   function GetLastVisible(OnlyFields: Boolean): IevEditorControl;
     {* Возвращает последний видимый контрол. }
   function GetHint(var aValue: Il3CString;
    const aControl: IevEditorControl): Boolean;
     {* Получить хинт для контрола. }
   function IsRequired: Boolean;
     {* Обязательное поле (должно обязательно содержать значение). }
   function IsEmpty: Boolean;
     {* Проверяет, является ли реквизит пустым. }
   function FieldsCount: Integer;
     {* Количество контролов (полей редактора) в реквизите. }
   procedure ButtonPressed(const aView: InevView;
    const aControl: IevEditorControl;
    aBtnType: TevButtonType);
     {* Обработка реакции на нажатие кнопки по её типу. }
   procedure AfterSetText(const aField: IevEditorControlField);
   function AddField(const aView: InevView;
    NeedSetFocus: Boolean = False): IevEditorControlField;
     {* Добавление реквизита. }
   function GetItemImage(Index: Integer;
    var aImages: InevImageList): Integer;
     {* Ручка для получения картинки для выпадающего дерева. }
   procedure DeleteField(const aView: InevView;
    const aControl: IevEditorControlField = nil;
    NeedFocus: Boolean = False);
     {* Удаление реквизита. }
   procedure InsertToModel(const aView: InevView;
    const aControl: IevEditorControl;
    aChild: Tl3Variant;
    NeedFocus: Boolean = False;
    anAdd: Boolean = False);
     {* Добавление реквизита только в модель. }
   procedure DeleteFromModel(const aView: InevView;
    const aControl: IevEditorControl;
    NeedFocus: Boolean = False);
     {* Удаление реквизита только из модели. }
   procedure InitModel(const aTag: InevPara;
    AddValues: Boolean;
    anIndexField: Integer;
    anIndexCtrl: Integer);
     {* Инициализация дочерних компонентов. }
   function CheckEdit(const aField: IevEditorControlField): Boolean;
     {* Проверка значения поля. }
   procedure UpdateState(const aField: IevEditorControlField;
    const anOp: InevOp);
     {* Обновить состояния поля и кнопок, вокруг контрола. }
   function Get_ModelListener: IevModelListener;
   function Get_Fields(Index: Integer): IevEditorControlField;
   function Get_ReqName: Il3CString;
   function Get_ReqCaption: Il3CString;
   procedure SetFocus(const aField: IevEditorControlField;
    aAtEnd: Boolean = False);
     {* Установить фокус. }
   function FirstField: IevEditorControlField;
     {* Возвращает первый контрол в списке. }
   function LastField: IevEditorControlField;
     {* Возвращает последний контрол в списке. }
   function Get_Group: IevQueryGroup;
   function Get_QueryCard: IevQueryCard;
   procedure ClearLogicValue;
   procedure EscPressed(const aField: IevEditorFieldWithTree);
   function NeedAsterisk: Boolean;
     {* Нужно ли проверять значение '*' в тексте. }
   function GetTreeFromAdapter: InevSimpleTree;
     {* Получает дерево с адаптера. }
   function IsMulti: Boolean;
     {* Признак реквизита с несколькими значениями. }
   procedure HyperLinkClick;
     {* Щелчок по гиперссылке. }
   function Get_DefStateIndex: Integer;
   procedure Set_DefStateIndex(aValue: Integer);
   function IsContext: Boolean;
     {* Признак того, что реквизит является конекстом. }
   function GetNode(anIndex: Integer): InevSimpleNode;
     {* Получить узел выпадающего дерева по номеру поля. }
   function Get_HistoryList: Il3StringsEx;
   function Get_StartDate: TDateTime;
   procedure Set_StartDate(aValue: TDateTime);
   function Get_EndDate: TDateTime;
   procedure Set_EndDate(aValue: TDateTime);
   function Get_Code: Il3CString;
   procedure Set_Code(const aValue: Il3CString);
   function Get_Number: Il3CString;
   procedure Set_Number(const aValue: Il3CString);
   function GetPromptTreeFromAdapter: InevSimpleTree;
   procedure NotifyContextWrong;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create(const aPara: InevPara); override;
 public
 // public methods
   class function Make(const aValue: InevPara): IevReq; reintroduce;
 end;//TevReq

implementation

uses
  OvcConst,
  evControlParaConst,
  l3String,
  k2Tags,
  evButtonControl,
  evDropCalendarControl,
  evDropCombo,
  evLabel,
  evSimpleEdit,
  evMemoEdit,
  evEmailEdit,
  evPhoneEdit,
  SysUtils,
  nevFacade,
  evControlParaTools
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  l3InterfacesMisc,
  l3Date,
  l3Bits,
  Table_Const,
  ReqRow_Const,
  ControlPara_Const,
  ControlsBlock_Const
  {$If defined(k2ForEditor)}
  ,
  evReqRowImplementation
  {$IfEnd} //k2ForEditor
  
  ;

// start class TevReq

class function TevReq.Make(const aValue: InevPara): IevReq;
var
 l_Inst : TevReq;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TevReq.AddValue(const aView: InevView;
  const aControl: IevEditorControl;
  const aPara: InevPara = nil;
  ToModel: Boolean = False;
  anAdd: Boolean = False): Boolean;
//#UC START# *48D3CD560338_48D3BD0A02D7_var*
var
 i           : Integer;
 l_Count     : Integer;
 l_Empty     : Boolean;
 l_HasEmpty  : Boolean;
 l_Para      : InevPara;
 l_Field     : IevEditorControlField;
 l_Button    : IevEditorControlButton;
 l_StateBtn  : IevEditorStateButton;
 l_TreeCont  : IevEditorFieldWithTree;  
 l_NodeIndex : Integer;
 l_NewField  : IevEditorControlField;
 l_OldField  : IevEditorControlField;
//#UC END# *48D3CD560338_48D3BD0A02D7_var*
begin
//#UC START# *48D3CD560338_48D3BD0A02D7_impl*
 l_Count := f_FieldsList.Count - 1;
 l_NodeIndex := -1;
 l_HasEmpty := False;
 Result := False; 
 if not ToModel then//если просто добавляем в модель, то никаких действий не производим
 begin
  i := l_Count;
  while i >= 0 do
  begin  
   l_Field := f_FieldsList[i];
   l_Empty := l_Field.IsFieldEmpty;
   if l_Empty and (l_Count > 0) and (i <> l_Count) then 
   begin
    DeleteValue(aView, l_Field);
    Dec(l_Count);
    l_Empty := False;
   end;//if l_Empty and ...
   if l_Empty then
    l_HasEmpty := True;
   Dec(i);
  end;//while i >= 0 do...
 end;//if ToModel then... 
 if (not l_HasEmpty and (aControl <> nil)) or ToModel then
 begin
  if not ToModel then 
  begin
   l_Para := aControl.Para;
   Get_QueryCard.InsertRowMode := True; //Может сработать TextChange при очистке полей
   try
    TevReqRowImplementation.Make(aView, l_Para.MakePoint.PointToTypedParent(k2_typTable), l_Para.DocumentContainer.Processor).InsertRows(1, True);
   finally
    Get_QueryCard.InsertRowMode := False;
   end;
   l_Para := l_Para.MakePoint.PointToTypedParent(k2_typReqRow).Obj.AsPara;
   // - смещаемся к строке таблицы
   InitModel(l_Para.Next, True, -1, -1);
   l_NewField := LastField;
   l_OldField := f_FieldsList[f_FieldsList.Count - 2];
  end//if not ToModel then
  else 
  begin
   for i := 0 to aPara.AsObject.ChildrenCount - 1 do
    if TevControlType(aPara.AsObject.Child[i].Child[0].IntA[k2_tiType]) = ev_ctCombo then
    begin
     with aPara.AsObject.Child[i].Child[0] do
      if IsValid and (IntA[k2_tiNodeVisibleIndex] <> -1) then
       l_NodeIndex := IntA[k2_tiNodeVisibleIndex];
     Break;
    end;  
   l_OldField := aControl.Field;            
   if anAdd then
    InitModel(aPara, True, -1, -1)
   else
    InitModel(aPara, True, f_FieldsList.IndexOf(l_OldField), f_ControlsList.IndexOf(aControl));
   if not aPara.AsObject.Child[i].Child[0].QT(IevEditorControlField, l_NewField) then
    Assert(false);
  end;// else if not ToModel then 
  l_Button := l_NewField.FindButton(ev_btLogical);
  if Supports(l_Button, IevEditorStateButton, l_StateBtn) then
   l_StateBtn.CurrentIndex := l_StateBtn.ImageIndex + Self.Get_DefStateIndex;
  if ToModel and Supports(l_NewField, IevEditorFieldWithTree, l_TreeCont) then    
   if l_NodeIndex > -1 then
    l_TreeCont.SetNodeByIndex(l_NodeIndex);
  UpdateState(l_OldField, nil);
  UpdateState(l_NewField, nil);
  Result := True;
 end;//if (not l_HasEmpty and (aControl <> nil)) or ToModel then...
//#UC END# *48D3CD560338_48D3BD0A02D7_impl*
end;//TevReq.AddValue

function TevReq.DeleteValue(const aView: InevView;
  const aControl: IevEditorControl = nil;
  ToModel: Boolean = False): Integer;
//#UC START# *48D3CD950327_48D3BD0A02D7_var*
var
 i          : Integer;
 l_Count    : Integer;
 l_FirstIdx : Integer;
 l_LastIdx  : Integer;
 l_Field    : IevEditorControlField;
 l_NewField : IevEditorControlField;
 l_TreeCont : IevEditorFieldWithTree;
 l_ML       : IevModelListener;
//#UC END# *48D3CD950327_48D3BD0A02D7_var*
begin
//#UC START# *48D3CD950327_48D3BD0A02D7_impl*
 Get_QueryCard.ClearUpper;
 l_Count := f_FieldsList.Count;
 if (l_Count = 1) or ((l_Count = 2) and f_FieldsList[0].HasOtherField) then //Для единичного атрибута только чистим текст
 begin
  l_Field := f_FieldsList[0];
  try
   l_Field.ClearText;
   UpdateState(l_Field, nil);
  finally
   l_Field := nil;
  end;
  Result := 0;
 end//if l_Count = 1 then...
 else
 begin
  try
   Get_QueryCard.BeforeDelete;
   if aControl <> nil then //Если что-то передали, то используем...
   begin
    if Supports(aControl, IevEditorControlField, l_Field) then
     //Виджет, который передали - поле редактора
     //l_Field.ClearText закомментировал в связи с [$274843876]
    else
     l_Field := aControl.Field;
   end
   else//Если - нет, то удалим последнее поле
    l_Field := LastField;
   Assert(l_Field <> nil, 'Не нашли связанное с кнопкой поле! ');

   //Удалим строку на экране (поле и кнопки).
   if Supports(l_Field, IevEditorFieldWithTree, l_TreeCont) then
    if l_TreeCont.Value <> nil then
     l_Field.Para.AsObject.IntA[k2_tiNodeVisibleIndex] := l_TreeCont.GetNodeIndex(l_TreeCont.Value)
    else
     l_Field.Para.AsObject.IntA[k2_tiNodeVisibleIndex] := -1
   else
    l_Field.Para.AsObject.IntA[k2_tiNodeVisibleIndex] := -1;
   if not ToModel then
    TevReqRowImplementation.Make(aView, l_Field.Para.MakePoint.PointToTypedParent(k2_typTable), l_Field.Para.DocumentContainer.Processor).DeleteRow;
   //Теперь удалим все связи с дочерними объектами
   Result := f_FieldsList.Remove(l_Field);
   l_FirstIdx := f_ControlsList.IndexOf(l_Field.ChildList.First);
   l_LastIdx := f_ControlsList.IndexOf(l_Field.ChildList.Last);
   for i := l_LastIdx downto l_FirstIdx do
    f_ControlsList.Delete(i);
   if Result = f_FieldsList.Count then
    Dec(Result);
   l_NewField := f_FieldsList[Result];
   try
    UpdateState(l_NewField, nil);
   finally
    l_NewField := nil;
   end;
  finally
   l_Field := nil;
  end;
 end;//else if l_Count = 1 then...
 {$IFDEF Monitorings}
 // http://mdp.garant.ru/pages/viewpage.action?pageId=493858212
 l_ML := Get_ModelListener;
 if (l_ML <> nil) then
  l_ML.TextChange;
 {$ENDIF Monitorings}
//#UC END# *48D3CD950327_48D3BD0A02D7_impl*
end;//TevReq.DeleteValue

function TevReq.GetControlClass(aControlType: TevControlType): RevControlClass;
//#UC START# *48D3CEA103E3_48D3BD0A02D7_var*
//#UC END# *48D3CEA103E3_48D3BD0A02D7_var*
begin
//#UC START# *48D3CEA103E3_48D3BD0A02D7_impl*
 case aControlType of
  ev_ctButton, ev_ctStateButton : 
    Result := TevButtonControl;
  ev_ctCalEdit :   
    Result := TevDropCalendarControl;
  ev_ctCombo : 
    Result := TevDropCombo;
  ev_ctLabel :  
   Result := TevLabel;  
  ev_ctEdit :
   Result := TevSimpleEdit;
  ev_ctMemoEdit :
   Result := TevMemoEdit;
  ev_ctEmailEdit :
   Result := TevEmailEdit;
  ev_ctPhoneEdit :
   Result := TevPhoneEdit
  else 
   Result := TevControl; 
 end;//case aControlType
//#UC END# *48D3CEA103E3_48D3BD0A02D7_impl*
end;//TevReq.GetControlClass

function TevReq.CanVisibleLogicBtn: Boolean;
//#UC START# *48D3D1C10394_48D3BD0A02D7_var*
//#UC END# *48D3D1C10394_48D3BD0A02D7_var*
begin
//#UC START# *48D3D1C10394_48D3BD0A02D7_impl*
 Result := Para.AsObject.HasSubAtom(k2_tiOperations);
//#UC END# *48D3D1C10394_48D3BD0A02D7_impl*
end;//TevReq.CanVisibleLogicBtn

function TevReq.LogicBtnEnabled: Boolean;
//#UC START# *48D3D1E8007E_48D3BD0A02D7_var*
//#UC END# *48D3D1E8007E_48D3BD0A02D7_var*
begin
//#UC START# *48D3D1E8007E_48D3BD0A02D7_impl*
 Result := (l3BitCountF(Para.AsObject.IntA[k2_tiOperations]) > 1);
//#UC END# *48D3D1E8007E_48D3BD0A02D7_impl*
end;//TevReq.LogicBtnEnabled

procedure TevReq.KeyAction(aCmd: Word);
//#UC START# *47CD666202DD_48D3BD0A02D7_var*
var
 ML : IevModelListener;
//#UC END# *47CD666202DD_48D3BD0A02D7_var*
begin
//#UC START# *47CD666202DD_48D3BD0A02D7_impl*
 if (aCmd = ccActionItem) then
 begin
  ML := Get_ModelListener;
  if (ML <> nil) then
   ML.EnterPressed;
 end;
//#UC END# *47CD666202DD_48D3BD0A02D7_impl*
end;//TevReq.KeyAction

function TevReq.AnalyzeString(const aValue: Il3CString;
  out aRslt: Il3CString): Boolean;
//#UC START# *47CD666F01DC_48D3BD0A02D7_var*
var
 ML : IevModelListener;
//#UC END# *47CD666F01DC_48D3BD0A02D7_var*
begin
//#UC START# *47CD666F01DC_48D3BD0A02D7_impl*
 ML := Get_ModelListener;
 if (ML <> nil) then
  Result := ML.AnalyzeString(aValue, aRslt)
 else
  Result := False;
//#UC END# *47CD666F01DC_48D3BD0A02D7_impl*
end;//TevReq.AnalyzeString

procedure TevReq.TextChange(const aView: InevView);
//#UC START# *47CD668303E2_48D3BD0A02D7_var*
var
 ML : IevModelListener;
//#UC END# *47CD668303E2_48D3BD0A02D7_var*
begin
//#UC START# *47CD668303E2_48D3BD0A02D7_impl*
 ML := Get_ModelListener;
 if ML <> nil then
  ML.TextChange;
//#UC END# *47CD668303E2_48D3BD0A02D7_impl*
end;//TevReq.TextChange

procedure TevReq.RememberState(const aControl: IevCustomEditorControl);
//#UC START# *47CD669103DE_48D3BD0A02D7_var*
//#UC END# *47CD669103DE_48D3BD0A02D7_var*
begin
//#UC START# *47CD669103DE_48D3BD0A02D7_impl*
 Get_QueryCard.RememberState(aControl);
//#UC END# *47CD669103DE_48D3BD0A02D7_impl*
end;//TevReq.RememberState

function TevReq.GetNextVisible(const aControl: IevEditorControl;
  OnlyFields: Boolean;
  out anIsLastField: Boolean): IevEditorControl;
//#UC START# *47CD66A6009A_48D3BD0A02D7_var*
var
 l_Index   : Integer; 
 l_Control : IevEditorControl; 
//#UC END# *47CD66A6009A_48D3BD0A02D7_var*
begin
//#UC START# *47CD66A6009A_48D3BD0A02D7_impl*
 Result := nil;
 anIsLastField := (f_ControlsList.Last = aControl);
 if not anIsLastField then
 begin
  l_Index := f_ControlsList.IndexOf(aControl);
  Inc(l_Index);
  while (l_Index < f_ControlsList.Count) do 
  begin
   l_Control := f_ControlsList[l_Index];
   try
    if l_Control.Visible and l_Control.Enabled then
     if not OnlyFields or (l_Control.ControlType in evEditControls) then
     begin
      Result := l_Control;
      Break;
     end; 
   finally
    l_Control := nil;
   end; 
   Inc(l_Index);
  end;
  if Result = nil then
   anIsLastField := True;
 end;  
//#UC END# *47CD66A6009A_48D3BD0A02D7_impl*
end;//TevReq.GetNextVisible

function TevReq.GetFirstVisible(OnlyFields: Boolean): IevEditorControl;
//#UC START# *47CD66C1034C_48D3BD0A02D7_var*
var
 i       : Integer;
 l_Count : Integer;
 l_Field : IevEditorControl;
//#UC END# *47CD66C1034C_48D3BD0A02D7_var*
begin
//#UC START# *47CD66C1034C_48D3BD0A02D7_impl*
 l_Count := f_ControlsList.Count - 1;
 for i := 0 to l_Count do 
 begin
  l_Field := f_ControlsList[i];  
  try
   if l_Field.Visible and l_Field.Enabled then     
    if not OnlyFields or (l_Field.ControlType in evEditControls) then
    begin    
     Result := l_Field;
     Break;
    end;
  finally
   l_Field := nil;
  end;
 end; 
//#UC END# *47CD66C1034C_48D3BD0A02D7_impl*
end;//TevReq.GetFirstVisible

function TevReq.GetPrevVisible(const aControl: IevEditorControl;
  OnlyFields: Boolean;
  out anIsFirstField: Boolean): IevEditorControl;
//#UC START# *47CD66D00085_48D3BD0A02D7_var*
var
 l_Index   : Integer; 
 l_Control : IevEditorControl;
//#UC END# *47CD66D00085_48D3BD0A02D7_var*
begin
//#UC START# *47CD66D00085_48D3BD0A02D7_impl*
 Result := nil;
 anIsFirstField := (f_ControlsList.First = aControl);
 if not anIsFirstField then
 begin
  l_Index := f_ControlsList.IndexOf(aControl);
  Dec(l_Index);
  while (l_Index >= 0) do 
  begin
   l_Control := f_ControlsList[l_Index];
   try
    if l_Control.Visible and l_Control.Enabled then
     if not OnlyFields or (l_Control.ControlType in evEditControls) then
     begin
      Result := l_Control;
      Break;
     end; 
   finally
    l_Control := nil;
   end; 
   Dec(l_Index);
  end;
  if Result = nil then
   anIsFirstField := True;
 end; 
//#UC END# *47CD66D00085_48D3BD0A02D7_impl*
end;//TevReq.GetPrevVisible

function TevReq.GetLastVisible(OnlyFields: Boolean): IevEditorControl;
//#UC START# *47CD66E90124_48D3BD0A02D7_var*
var
 i       : Integer;
 l_Count : Integer;
 l_Field : IevEditorControl;
//#UC END# *47CD66E90124_48D3BD0A02D7_var*
begin
//#UC START# *47CD66E90124_48D3BD0A02D7_impl*
 l_Count := f_ControlsList.Count - 1;
 for i := l_Count downto 0 do 
 begin
  l_Field := f_ControlsList[i];
  try
   if l_Field.Visible and l_Field.Enabled then 
    if not OnlyFields or (l_Field.ControlType in evEditControls) then
    begin
     Result := l_Field;
     Break;
    end;
  finally
   l_Field := nil;
  end;
 end; 
//#UC END# *47CD66E90124_48D3BD0A02D7_impl*
end;//TevReq.GetLastVisible

function TevReq.GetHint(var aValue: Il3CString;
  const aControl: IevEditorControl): Boolean;
//#UC START# *47CD66F50173_48D3BD0A02D7_var*
var
 ML : IevModelListener;
//#UC END# *47CD66F50173_48D3BD0A02D7_var*
begin
//#UC START# *47CD66F50173_48D3BD0A02D7_impl*
{$IFDEF TEST_MODEL}
 if aControl.ControlType in evEditControls then
 begin
  aValue := Get_ReqName;
  Result := True;
 end
 else
  Result := False;
{$ELSE}
 if (aControl.ControlType = ev_ctCalEdit) then
 begin
  aValue := nil;
  Result := True;
 end//aControl.ControlType = ev_ctCalEdit
 else
 begin
  ML := Get_ModelListener;
  if ML <> nil then
  begin
   aValue := ML.GetHint(aControl);
   Result := not l3IsNil(aValue);
  end
  else
   Result := False;
 end;
{$ENDIF}  
//#UC END# *47CD66F50173_48D3BD0A02D7_impl*
end;//TevReq.GetHint

function TevReq.IsRequired: Boolean;
//#UC START# *47CD670E02FC_48D3BD0A02D7_var*
//#UC END# *47CD670E02FC_48D3BD0A02D7_var*
begin
//#UC START# *47CD670E02FC_48D3BD0A02D7_impl*
 Result := Para.AsObject.BoolA[k2_tiRequired]; 
//#UC END# *47CD670E02FC_48D3BD0A02D7_impl*
end;//TevReq.IsRequired

function TevReq.IsEmpty: Boolean;
//#UC START# *47CD671F01FE_48D3BD0A02D7_var*
var
 ML : IevModelListener;
//#UC END# *47CD671F01FE_48D3BD0A02D7_var*
begin
//#UC START# *47CD671F01FE_48D3BD0A02D7_impl*
 ML := Get_ModelListener;
 if (ML <> nil) then
  Result := ML.IsEditEmpty
 else 
  Result := True;
//#UC END# *47CD671F01FE_48D3BD0A02D7_impl*
end;//TevReq.IsEmpty

function TevReq.FieldsCount: Integer;
//#UC START# *47CD672E02A0_48D3BD0A02D7_var*
//#UC END# *47CD672E02A0_48D3BD0A02D7_var*
begin
//#UC START# *47CD672E02A0_48D3BD0A02D7_impl*
 Result := f_FieldsList.Count;
//#UC END# *47CD672E02A0_48D3BD0A02D7_impl*
end;//TevReq.FieldsCount

procedure TevReq.ButtonPressed(const aView: InevView;
  const aControl: IevEditorControl;
  aBtnType: TevButtonType);
//#UC START# *47CD674100FC_48D3BD0A02D7_var*
//#UC END# *47CD674100FC_48D3BD0A02D7_var*
begin
//#UC START# *47CD674100FC_48D3BD0A02D7_impl*
 case aBtnType of
  ev_btAdd   : begin 
             AddValue(aView, aControl);
             SetFocus(LastField);               
            end;  
  ev_btDelete: begin 
             SetFocus(Get_Fields(DeleteValue(aView, aControl)));
            end; 
 end;  
//#UC END# *47CD674100FC_48D3BD0A02D7_impl*
end;//TevReq.ButtonPressed

procedure TevReq.AfterSetText(const aField: IevEditorControlField);
//#UC START# *47CD675402F3_48D3BD0A02D7_var*
var
 ML : IevModelListener;
//#UC END# *47CD675402F3_48D3BD0A02D7_var*
begin
//#UC START# *47CD675402F3_48D3BD0A02D7_impl*
 ML := Get_ModelListener;
 if ML <> nil then
  ML.AfterSetText(aField);
//#UC END# *47CD675402F3_48D3BD0A02D7_impl*
end;//TevReq.AfterSetText

function TevReq.AddField(const aView: InevView;
  NeedSetFocus: Boolean = False): IevEditorControlField;
//#UC START# *47CD677302C2_48D3BD0A02D7_var*
//#UC END# *47CD677302C2_48D3BD0A02D7_var*
begin
//#UC START# *47CD677302C2_48D3BD0A02D7_impl*
 if IsMulti and AddValue(aView, LastField) then 
 begin
  Result := LastField;
  if NeedSetFocus then
   SetFocus(LastField); 
 end 
 else 
  Result := nil;
//#UC END# *47CD677302C2_48D3BD0A02D7_impl*
end;//TevReq.AddField

function TevReq.GetItemImage(Index: Integer;
  var aImages: InevImageList): Integer;
//#UC START# *47CD67820275_48D3BD0A02D7_var*
var
 ML : IevModelListener;
//#UC END# *47CD67820275_48D3BD0A02D7_var*
begin
//#UC START# *47CD67820275_48D3BD0A02D7_impl*
 ML := Get_ModelListener;
 if ML <> nil then
  Result := ML.GetImage(Index, aImages)
 else
 begin
  aImages := nil; 
  Result := -1;
 end; 
//#UC END# *47CD67820275_48D3BD0A02D7_impl*
end;//TevReq.GetItemImage

procedure TevReq.DeleteField(const aView: InevView;
  const aControl: IevEditorControlField = nil;
  NeedFocus: Boolean = False);
//#UC START# *47CD679F00D4_48D3BD0A02D7_var*
var
 l_IDX: Integer;
//#UC END# *47CD679F00D4_48D3BD0A02D7_var*
begin
//#UC START# *47CD679F00D4_48D3BD0A02D7_impl*
 l_IDX := DeleteValue(aView, aControl);
 if NeedFocus then
  SetFocus(Get_Fields(l_IDX));
//#UC END# *47CD679F00D4_48D3BD0A02D7_impl*
end;//TevReq.DeleteField

procedure TevReq.InsertToModel(const aView: InevView;
  const aControl: IevEditorControl;
  aChild: Tl3Variant;
  NeedFocus: Boolean = False;
  anAdd: Boolean = False);
//#UC START# *47CD69A301F3_48D3BD0A02D7_var*
var
 l_Para: InevPara;  
//#UC END# *47CD69A301F3_48D3BD0A02D7_var*
begin
//#UC START# *47CD69A301F3_48D3BD0A02D7_impl*
 if aChild.QT(InevPara, l_Para) then 
 begin
  AddValue(aView, aControl, l_Para, True, anAdd);
  if NeedFocus then 
   SetFocus(LastField);
 end; 
//#UC END# *47CD69A301F3_48D3BD0A02D7_impl*
end;//TevReq.InsertToModel

procedure TevReq.DeleteFromModel(const aView: InevView;
  const aControl: IevEditorControl;
  NeedFocus: Boolean = False);
//#UC START# *47CD69CD0294_48D3BD0A02D7_var*
var
 l_IDX: Integer;
//#UC END# *47CD69CD0294_48D3BD0A02D7_var*
begin
//#UC START# *47CD69CD0294_48D3BD0A02D7_impl*
 l_IDX := DeleteValue(aView, aControl, True);
 if NeedFocus then
  SetFocus(Get_Fields(l_IDX));
//#UC END# *47CD69CD0294_48D3BD0A02D7_impl*
end;//TevReq.DeleteFromModel

procedure TevReq.InitModel(const aTag: InevPara;
  AddValues: Boolean;
  anIndexField: Integer;
  anIndexCtrl: Integer);
//#UC START# *47CD6E090090_48D3BD0A02D7_var*
var
 l_ComponentList: TevEditorControlList;
 l_FirstEditField: IevEditorControlField;
 l_EditField: IevEditorControlField;

 function GetChildControl(const aChild: InevPara; Index: Integer): Boolean;
 var
  l_ControlType : TevControlType;
  l_Class       : RevControlClass;
  l_ContTag     : InevPara;
  l_ED          : IevEditorControl;
 begin
  Result := True;
  l_ContTag := aChild.AsList[0]; //Одна ячека таблицы - один виджет
  try
   with l_ContTag do
    if AsObject.IsKindOf(k2_typControlPara) then
    begin
     if AsObject.Attr[k2_tiType].IsValid then
      l_ControlType := TevControlType(l_ContTag.AsObject.IntA[k2_tiType])
     else
      l_ControlType := ev_ctLabel;
     if (l_ControlType <> ev_ctUnknown) then
     begin
      l_Class := GetControlClass(l_ControlType);
      Assert(l_Class <> TevControl, 'Используется неизвестный класс виджет!');
      l_ED := l_Class.Make(l_ContTag);
      try 
       if (l_ControlType in evEditControls) then
       begin
        if Supports(l_ED, IevEditorControlField, l_EditField) then
        begin
         if AddValues and (anIndexField > -1) then
          f_FieldsList.Insert(anIndexField, l_EditField)
         else
          f_FieldsList.Add(l_EditField);
        end;//Supports(l_ED, IevEditorControlField, l_FirstEditField)

        if (l_FirstEditField = nil) then
        begin
         if Assigned(l_EditField) then
          l_FirstEditField := l_EditField;
        end//l_FirstEditField = nil
        else
        begin
         l_ComponentList.Add(l_ED);
         l_FirstEditField.InitOtherField(l_ED);
         l_ED.Field := l_FirstEditField;
        end;//l_FirstEditField = nil
       end//l_ControlType in evEditControls
       else
       begin
        l_ComponentList.Add(l_ED);                  
        l_ED.Field := l_FirstEditField;      
        {$IFDEF TEST_MODEL}       
        l_ED.InitBoolProperty(k2_tiVisible, True);//Для режима отладки все виджеты должны быть видны
        {$ELSE}
        //Заплатка         
        if (l_ED.ControlType = ev_ctButton) or (l_ED.ControlType = ev_ctStateButton) then
         l_ED.InitBoolProperty(k2_tiVisible, False);
        {$ENDIF TEST_MODEL} 
       end;//l_ControlType in evEditControls 
       if AddValues and (anIndexField > -1) then
        f_ControlsList.Insert(anIndexCtrl + Index, l_ED) 
       else
        f_ControlsList.Add(l_ED);
      finally
       l_ED := nil;
      end;//try..finally
     end//if (l_ControlType <> ev_ctUnknown) then
     else
      l_ContTag.AsObject.BoolW[k2_tiEnabled, nil] := False;
    end;//if IsKindOf(k2_typControlBlock)
  finally
   l_ContTag := nil;
  end;//try..finally
 end;//GetChildLine

var
 i       : Integer;
 l_Count : Integer;
 l_Label : IevEditorControlLabel;
//#UC END# *47CD6E090090_48D3BD0A02D7_var*
begin
//#UC START# *47CD6E090090_48D3BD0A02D7_impl*
 l_ComponentList := TevEditorControlList.Make;
 try
  with aTag do
   if AsObject.IsValid then
    AsList.IterateParaF(nevL2PIA(@GetChildControl));
  Assert(l_FirstEditField <> nil, 'Нет ни одного поля редактора. ');
  if (l_FirstEditField = nil) then
   Exit;
  l_Count := l_ComponentList.Count - 1;
  for i := 0 to l_Count do
   l_ComponentList[i].Field := l_FirstEditField;
  l_FirstEditField.ChildList.AssignList(l_ComponentList);
  if AddValues then
  begin
   if Supports(l_FirstEditField.ChildList[0], IevEditorControlLabel, l_Label) then
    try
     l_Label.Caption := nil;
     l_Label.InitBoolProperty(k2_tiVisible, False);     
    finally   
     l_Label := nil;
    end;//trt..finally  
  end//AddValues
  else
  if (l_FirstEditField.ChildList.Count <> 0) then
   l3Set(f_ReqCaption, l_FirstEditField.ChildList[0].Caption)
 finally
  l_FirstEditField := nil;
  l_EditField := nil;
  l3Free(l_ComponentList);
 end;//try..finally  
//#UC END# *47CD6E090090_48D3BD0A02D7_impl*
end;//TevReq.InitModel

function TevReq.CheckEdit(const aField: IevEditorControlField): Boolean;
//#UC START# *47CD6E2403C9_48D3BD0A02D7_var*
var
 ML : IevModelListener;
//#UC END# *47CD6E2403C9_48D3BD0A02D7_var*
begin
//#UC START# *47CD6E2403C9_48D3BD0A02D7_impl*
 ML := Get_ModelListener;
 if ML <> nil then
 begin
  Result := ML.CheckValue(aField);
  //f_IsValid := Result;
 end 
 else
  Result := False; 
//#UC END# *47CD6E2403C9_48D3BD0A02D7_impl*
end;//TevReq.CheckEdit

procedure TevReq.UpdateState(const aField: IevEditorControlField;
  const anOp: InevOp);
//#UC START# *47CD6E3401B9_48D3BD0A02D7_var*
var
 i            : Integer;
 l_Index      : Integer;
 l_Count      : Integer;
 l_Cal        : IevEditorCalendarField;
 l_Field      : IevEditorControlField;
 l_BTNControl : IevEditorControlButton;
 l_LBLControl : IevEditorControlLabel;
//#UC END# *47CD6E3401B9_48D3BD0A02D7_var*
begin
//#UC START# *47CD6E3401B9_48D3BD0A02D7_impl*
  if Supports(aField, IevEditorCalendarField, l_Cal) then
   try      
    if not l_Cal.IsStart then 
     l_Cal.GetOtherField.QueryInterface(IevEditorControlField, l_Field)
    else 
     l_Field := aField; 
   finally
    l_Cal := nil;
   end
  else
   l_Field := aField;
  //Аккуратно со следующим кодом: для календаря в качестве массива полей может
  //использоваться массив поля "С:", а для проверки значений поле "По:"
  try
   l_Count := l_Field.ChildList.Count;
   l_Index := f_FieldsList.IndexOf(l_Field);
   for i := l_Count - 1 downto 0 do
    if Supports(l_Field.ChildList[i], IevEditorControlButton, l_BTNControl) then
     try
      {$IFNDEF TEST_MODEL}
      Case l_BTNControl.GetButtonType of
       ev_btDelete:
        l_BTNControl.Visible := (not aField.IsClear or (l_Index > 0))
        and evIsSomeFieldFilled(aField.Req, true);
       ev_btAdd:
        l_BTNControl.Visible := CheckEdit(aField) and (l_Index = f_FieldsList.Count - 1)
         and not aField.IsFieldEmpty and IsMulti  and aField.Valid;
       ev_btLogical:
       begin
        l_BTNControl.Visible := not aField.IsFieldEmpty and CanVisibleLogicBtn;
        if l_BTNControl.Visible then
         l_BTNControl.Enabled := LogicBtnEnabled;
       end;//ev_btLogical
      end;//l_BTNControl.GetButtonType
      {$ENDIF TEST_MODEL} 
     finally
      l_BTNControl := nil;
     end
    else    
     if (i = 0) and Supports(l_Field.ChildList[i], IevEditorControlLabel, l_LBLControl) then
      try
       if l_Index = 0 then
       begin
        l_LBLControl.RestoreCaption;
        l_LBLControl.Visible := True;    
       end      
       else
        l_LBLControl.Visible := False; 
      finally 
       l_LBLControl := nil;
      end; 
  finally
   l_Field := nil;
  end;  
//#UC END# *47CD6E3401B9_48D3BD0A02D7_impl*
end;//TevReq.UpdateState

function TevReq.Get_ModelListener: IevModelListener;
//#UC START# *47CD6E5E00F6_48D3BD0A02D7get_var*
var
 l_QC : IevQueryCard;
//#UC END# *47CD6E5E00F6_48D3BD0A02D7get_var*
begin
//#UC START# *47CD6E5E00F6_48D3BD0A02D7get_impl*
 l_QC := Get_QueryCard;
{$IFNDEF TEST_MODEL}
 if (l_QC <> nil) AND (l_QC.AdapterModel <> nil) then
  Result := l_QC.AdapterModel.ModelListener(Self)
 else
{$ENDIF TEST_MODEL} 
  Result := nil; 
//#UC END# *47CD6E5E00F6_48D3BD0A02D7get_impl*
end;//TevReq.Get_ModelListener

function TevReq.Get_Fields(Index: Integer): IevEditorControlField;
//#UC START# *47CD6E870081_48D3BD0A02D7get_var*
//#UC END# *47CD6E870081_48D3BD0A02D7get_var*
begin
//#UC START# *47CD6E870081_48D3BD0A02D7get_impl*
 Result := f_FieldsList[Index];
//#UC END# *47CD6E870081_48D3BD0A02D7get_impl*
end;//TevReq.Get_Fields

function TevReq.Get_ReqName: Il3CString;
//#UC START# *47CD6EB4017D_48D3BD0A02D7get_var*
//#UC END# *47CD6EB4017D_48D3BD0A02D7get_var*
begin
//#UC START# *47CD6EB4017D_48D3BD0A02D7get_impl*
 Para.AsObject.Attr[k2_tiReqID].QI(Il3CString, Result);
//#UC END# *47CD6EB4017D_48D3BD0A02D7get_impl*
end;//TevReq.Get_ReqName

function TevReq.Get_ReqCaption: Il3CString;
//#UC START# *47CD6EC502B1_48D3BD0A02D7get_var*
//#UC END# *47CD6EC502B1_48D3BD0A02D7get_var*
begin
//#UC START# *47CD6EC502B1_48D3BD0A02D7get_impl*
 if (f_ReqCaption = nil) then
  Result := nil
 else
 if not l3IOk(f_ReqCaption.QueryInterface(Il3CString, Result)) then
  Assert(false);
//#UC END# *47CD6EC502B1_48D3BD0A02D7get_impl*
end;//TevReq.Get_ReqCaption

procedure TevReq.SetFocus(const aField: IevEditorControlField;
  aAtEnd: Boolean = False);
//#UC START# *47CD6EE402F8_48D3BD0A02D7_var*
//#UC END# *47CD6EE402F8_48D3BD0A02D7_var*
begin
//#UC START# *47CD6EE402F8_48D3BD0A02D7_impl*
 with Get_QueryCard do
 begin
  GetDocumentContainer.SetCursorToPara(aField.Para, aAtEnd, False);
  SetCurrPara(aField.Para);
  RememberState(aField);
 end;//with Get_QueryCard
//#UC END# *47CD6EE402F8_48D3BD0A02D7_impl*
end;//TevReq.SetFocus

function TevReq.FirstField: IevEditorControlField;
//#UC START# *47CD6EF701E4_48D3BD0A02D7_var*
//#UC END# *47CD6EF701E4_48D3BD0A02D7_var*
begin
//#UC START# *47CD6EF701E4_48D3BD0A02D7_impl*
 Result := f_FieldsList.First;
//#UC END# *47CD6EF701E4_48D3BD0A02D7_impl*
end;//TevReq.FirstField

function TevReq.LastField: IevEditorControlField;
//#UC START# *47CD6F0502BD_48D3BD0A02D7_var*
//#UC END# *47CD6F0502BD_48D3BD0A02D7_var*
begin
//#UC START# *47CD6F0502BD_48D3BD0A02D7_impl*
 Result := f_FieldsList.Last;
//#UC END# *47CD6F0502BD_48D3BD0A02D7_impl*
end;//TevReq.LastField

function TevReq.Get_Group: IevQueryGroup;
//#UC START# *47CD6F3B0317_48D3BD0A02D7get_var*
var
 l_Group : Tl3Variant;
//#UC END# *47CD6F3B0317_48D3BD0A02D7get_var*
begin
//#UC START# *47CD6F3B0317_48D3BD0A02D7get_impl*
 Result := nil;
 if (f_Group = nil) then
  if evInPara(Para.AsObject, k2_typControlsBlock, l_Group) then
   l_Group.SetRef(f_Group)
  else
   Exit;
 if (f_Group <> nil) AND f_Group.IsValid then
  f_Group.QT(IevQueryGroup, Result)
  // - хранение f_Group необходимо - это ЗАПЛАТКА, т.к. строка может удалится из таблицы, но все еще хранится в реквизите
 else
  Result := nil;
//#UC END# *47CD6F3B0317_48D3BD0A02D7get_impl*
end;//TevReq.Get_Group

function TevReq.Get_QueryCard: IevQueryCard;
//#UC START# *47CD6F770022_48D3BD0A02D7get_var*
var
 l_QG : IevQueryGroup;
//#UC END# *47CD6F770022_48D3BD0A02D7get_var*
begin
//#UC START# *47CD6F770022_48D3BD0A02D7get_impl*
 l_QG := Get_Group;
 if (l_QG <> nil) then
  Result := l_QG.QueryCard
 else
  Result := nil;
//#UC END# *47CD6F770022_48D3BD0A02D7get_impl*
end;//TevReq.Get_QueryCard

procedure TevReq.ClearLogicValue;
//#UC START# *47CD74B90340_48D3BD0A02D7_var*
var
 l_Button   : IevEditorControlButton;
 l_StateBtn : IevEditorStateButton;
//#UC END# *47CD74B90340_48D3BD0A02D7_var*
begin
//#UC START# *47CD74B90340_48D3BD0A02D7_impl*
 l_Button := FirstField.FindButton(ev_btLogical);
 if l_Button <> nil then
  if Supports(l_Button, IevEditorStateButton, l_StateBtn) then
   l_StateBtn.CurrentIndex := l_StateBtn.ImageIndex + Self.Get_DefStateIndex;
//#UC END# *47CD74B90340_48D3BD0A02D7_impl*
end;//TevReq.ClearLogicValue

procedure TevReq.EscPressed(const aField: IevEditorFieldWithTree);
//#UC START# *47CD74C203DC_48D3BD0A02D7_var*
var
 ML : IevAdapterModel;
//#UC END# *47CD74C203DC_48D3BD0A02D7_var*
begin
//#UC START# *47CD74C203DC_48D3BD0A02D7_impl*
 if (Get_QueryCard = nil) then
  ML := nil
 else
  ML := Get_QueryCard.AdapterModel;
 if (ML <> nil) then
  ML.EscPressed(aField);
//#UC END# *47CD74C203DC_48D3BD0A02D7_impl*
end;//TevReq.EscPressed

function TevReq.NeedAsterisk: Boolean;
//#UC START# *47CD74D802DF_48D3BD0A02D7_var*
//#UC END# *47CD74D802DF_48D3BD0A02D7_var*
begin
//#UC START# *47CD74D802DF_48D3BD0A02D7_impl*
 Result := Para.AsObject.BoolA[k2_tiNumList];
//#UC END# *47CD74D802DF_48D3BD0A02D7_impl*
end;//TevReq.NeedAsterisk

function TevReq.GetTreeFromAdapter: InevSimpleTree;
//#UC START# *47CD74ED0166_48D3BD0A02D7_var*
var
 ML : IevAdapterModel;
//#UC END# *47CD74ED0166_48D3BD0A02D7_var*
begin
//#UC START# *47CD74ED0166_48D3BD0A02D7_impl*
 if (Get_QueryCard = nil) then
  ML := nil
 else
  ML := Get_QueryCard.AdapterModel;
 if (ML <> nil) then
  Result := ML.GetTreeFromAdapter(Get_ReqName)
 else
  Result := nil;
//#UC END# *47CD74ED0166_48D3BD0A02D7_impl*
end;//TevReq.GetTreeFromAdapter

function TevReq.IsMulti: Boolean;
//#UC START# *47CD750202FD_48D3BD0A02D7_var*
//#UC END# *47CD750202FD_48D3BD0A02D7_var*
begin
//#UC START# *47CD750202FD_48D3BD0A02D7_impl*
 Result := Para.AsObject.BoolA[k2_tiMulty];
//#UC END# *47CD750202FD_48D3BD0A02D7_impl*
end;//TevReq.IsMulti

procedure TevReq.HyperLinkClick;
//#UC START# *47CD75160008_48D3BD0A02D7_var*
//#UC END# *47CD75160008_48D3BD0A02D7_var*
begin
//#UC START# *47CD75160008_48D3BD0A02D7_impl*
 Get_ModelListener.HyperLinkClick;
//#UC END# *47CD75160008_48D3BD0A02D7_impl*
end;//TevReq.HyperLinkClick

function TevReq.Get_DefStateIndex: Integer;
//#UC START# *47CD75890059_48D3BD0A02D7get_var*
//#UC END# *47CD75890059_48D3BD0A02D7get_var*
begin
//#UC START# *47CD75890059_48D3BD0A02D7get_impl*
 Result := Para.AsObject.IntA[k2_tiStateIndex];
//#UC END# *47CD75890059_48D3BD0A02D7get_impl*
end;//TevReq.Get_DefStateIndex

procedure TevReq.Set_DefStateIndex(aValue: Integer);
//#UC START# *47CD75890059_48D3BD0A02D7set_var*
//#UC END# *47CD75890059_48D3BD0A02D7set_var*
begin
//#UC START# *47CD75890059_48D3BD0A02D7set_impl*
 Para.AsObject.IntA[k2_tiStateIndex] := aValue;
//#UC END# *47CD75890059_48D3BD0A02D7set_impl*
end;//TevReq.Set_DefStateIndex

function TevReq.IsContext: Boolean;
//#UC START# *47CD759702B8_48D3BD0A02D7_var*
//#UC END# *47CD759702B8_48D3BD0A02D7_var*
begin
//#UC START# *47CD759702B8_48D3BD0A02D7_impl*
 Result := TevReqKind(Para.AsObject.IntA[k2_tiReqKind]) = ev_rkContext;
//#UC END# *47CD759702B8_48D3BD0A02D7_impl*
end;//TevReq.IsContext

function TevReq.GetNode(anIndex: Integer): InevSimpleNode;
//#UC START# *47CD75A9029C_48D3BD0A02D7_var*
//#UC END# *47CD75A9029C_48D3BD0A02D7_var*
begin
//#UC START# *47CD75A9029C_48D3BD0A02D7_impl*
 Result := Get_QueryCard.GetNode(anIndex);
//#UC END# *47CD75A9029C_48D3BD0A02D7_impl*
end;//TevReq.GetNode

function TevReq.Get_HistoryList: Il3StringsEx;
//#UC START# *47CD75C30157_48D3BD0A02D7get_var*
{$If not Defined(Admin) AND not Defined(Monitorings)}
var
 ML : IevAdapterModel;
{$IfEnd} 
//#UC END# *47CD75C30157_48D3BD0A02D7get_var*
begin
//#UC START# *47CD75C30157_48D3BD0A02D7get_impl*
 {$If not Defined(Admin) AND not Defined(Monitorings)}
 if (Get_QueryCard = nil) then
  ML := nil
 else
  ML := Get_QueryCard.AdapterModel;
 if ML <> nil then
  Result := ML.HistoryList
 else
  Result := nil;
 {$Else}
 Result := nil; 
 {$IfEnd}
//#UC END# *47CD75C30157_48D3BD0A02D7get_impl*
end;//TevReq.Get_HistoryList

function TevReq.Get_StartDate: TDateTime;
//#UC START# *47CD76B60268_48D3BD0A02D7get_var*
var
 l_Cal: IevEditorCalendarField;
//#UC END# *47CD76B60268_48D3BD0A02D7get_var*
begin
//#UC START# *47CD76B60268_48D3BD0A02D7get_impl*
 if Supports(FirstField, IevEditorCalendarField, l_Cal) then
  try
   Result := l_Cal.aDate;
  finally
   l_Cal := nil;
  end
 else
  Result := NullDate;
//#UC END# *47CD76B60268_48D3BD0A02D7get_impl*
end;//TevReq.Get_StartDate

procedure TevReq.Set_StartDate(aValue: TDateTime);
//#UC START# *47CD76B60268_48D3BD0A02D7set_var*
var
 l_Cal: IevEditorCalendarField;
//#UC END# *47CD76B60268_48D3BD0A02D7set_var*
begin
//#UC START# *47CD76B60268_48D3BD0A02D7set_impl*
 if Supports(FirstField, IevEditorCalendarField, l_Cal) then
  try
   l_Cal.aDate := aValue;
  finally
   l_Cal := nil;
  end; 
//#UC END# *47CD76B60268_48D3BD0A02D7set_impl*
end;//TevReq.Set_StartDate

function TevReq.Get_EndDate: TDateTime;
//#UC START# *47CD76C40235_48D3BD0A02D7get_var*
var
 l_Cal: IevEditorCalendarField;
//#UC END# *47CD76C40235_48D3BD0A02D7get_var*
begin
//#UC START# *47CD76C40235_48D3BD0A02D7get_impl*
 if Supports(FirstField, IevEditorCalendarField, l_Cal) then
  try
   Result := l_Cal.GetOtherField.aDate;
  finally
   l_Cal := nil;
  end
 else 
  Result := NullDate;  
//#UC END# *47CD76C40235_48D3BD0A02D7get_impl*
end;//TevReq.Get_EndDate

procedure TevReq.Set_EndDate(aValue: TDateTime);
//#UC START# *47CD76C40235_48D3BD0A02D7set_var*
var
 l_Cal: IevEditorCalendarField;
//#UC END# *47CD76C40235_48D3BD0A02D7set_var*
begin
//#UC START# *47CD76C40235_48D3BD0A02D7set_impl*
 if Supports(FirstField, IevEditorCalendarField, l_Cal) then
  try
   l_Cal.GetOtherField.aDate := aValue;
  finally
   l_Cal := nil;
  end; 
//#UC END# *47CD76C40235_48D3BD0A02D7set_impl*
end;//TevReq.Set_EndDate

function TevReq.Get_Code: Il3CString;
//#UC START# *47CD76DE0101_48D3BD0A02D7get_var*
var
 l_Field: IevEditorPhoneField;
//#UC END# *47CD76DE0101_48D3BD0A02D7get_var*
begin
//#UC START# *47CD76DE0101_48D3BD0A02D7get_impl*
 if Supports(FirstField, IevEditorPhoneField, l_Field) then
  try
   Result := l_Field.Text;
  finally
   l_Field := nil;
  end
 else
  Result := nil;
//#UC END# *47CD76DE0101_48D3BD0A02D7get_impl*
end;//TevReq.Get_Code

procedure TevReq.Set_Code(const aValue: Il3CString);
//#UC START# *47CD76DE0101_48D3BD0A02D7set_var*
var
 l_Field: IevEditorPhoneField;
//#UC END# *47CD76DE0101_48D3BD0A02D7set_var*
begin
//#UC START# *47CD76DE0101_48D3BD0A02D7set_impl*
 if Supports(FirstField, IevEditorPhoneField, l_Field) then
  try
   l_Field.Text := aValue;
  finally
   l_Field := nil;
  end;
//#UC END# *47CD76DE0101_48D3BD0A02D7set_impl*
end;//TevReq.Set_Code

function TevReq.Get_Number: Il3CString;
//#UC START# *47CD76E9008F_48D3BD0A02D7get_var*
var
 l_Field: IevEditorPhoneField;
//#UC END# *47CD76E9008F_48D3BD0A02D7get_var*
begin
//#UC START# *47CD76E9008F_48D3BD0A02D7get_impl*
 if Supports(FirstField, IevEditorPhoneField, l_Field) then
  try
   Result := l_Field.GetOtherField.Text;
  finally
   l_Field := nil;
  end
 else
  Result := nil;
//#UC END# *47CD76E9008F_48D3BD0A02D7get_impl*
end;//TevReq.Get_Number

procedure TevReq.Set_Number(const aValue: Il3CString);
//#UC START# *47CD76E9008F_48D3BD0A02D7set_var*
var
 l_Field: IevEditorPhoneField;
//#UC END# *47CD76E9008F_48D3BD0A02D7set_var*
begin
//#UC START# *47CD76E9008F_48D3BD0A02D7set_impl*
 if Supports(FirstField, IevEditorPhoneField, l_Field) then
  try
   l_Field.GetOtherField.Text := aValue;
  finally
   l_Field := nil;
  end;
//#UC END# *47CD76E9008F_48D3BD0A02D7set_impl*
end;//TevReq.Set_Number

function TevReq.GetPromptTreeFromAdapter: InevSimpleTree;
//#UC START# *486C76EE0211_48D3BD0A02D7_var*
var
 ML : IevAdapterModel;
//#UC END# *486C76EE0211_48D3BD0A02D7_var*
begin
//#UC START# *486C76EE0211_48D3BD0A02D7_impl*
 if (Get_QueryCard = nil) then
  ML := nil
 else
  ML := Get_QueryCard.AdapterModel;
 if (ML <> nil) then
  Result := ML.GetPromptTreeFromAdapter
 else
  Result := nil;
//#UC END# *486C76EE0211_48D3BD0A02D7_impl*
end;//TevReq.GetPromptTreeFromAdapter

procedure TevReq.NotifyContextWrong;
//#UC START# *4885BB8A005E_48D3BD0A02D7_var*
var
 ML : IevAdapterModel;
//#UC END# *4885BB8A005E_48D3BD0A02D7_var*
begin
//#UC START# *4885BB8A005E_48D3BD0A02D7_impl*
 if (Get_QueryCard = nil) then
  ML := nil
 else
  ML := Get_QueryCard.AdapterModel;
 if (ML <> nil) then
  ML.NotifyContextWrong;
//#UC END# *4885BB8A005E_48D3BD0A02D7_impl*
end;//TevReq.NotifyContextWrong

procedure TevReq.Cleanup;
//#UC START# *479731C50290_48D3BD0A02D7_var*
var
 l_Index   : Integer;
 l_Row     : Integer;
 l_Cleared : Boolean;
//#UC END# *479731C50290_48D3BD0A02D7_var*
begin
//#UC START# *479731C50290_48D3BD0A02D7_impl*
 l_Cleared := false;
 if (Para <> nil) and Para.AsObject.IsValid then
 begin
  with Para.AsObject.Owner do
   if IsValid then
   begin
    l_Cleared := true;
    // - здесь вычищаем ссылку на данный реквизит из всех строк таблицы
    for l_Index := 0 to Pred(ChildrenCount) do
     with Child[l_Index] do
      if HasSubAtom(k2_tiModelControl) then
      // - проверка, чтобы в WevReqRow.GetAtomData не попадать
       if l3IEQ(Self, IUnknown(IntA[k2_tiModelControl])) then
        AttrW[k2_tiModelControl, nil] := nil;
   end;//IsValid
 end;//Para <> nil..
 if not l_Cleared AND (f_Group <> nil) then
 begin
  // - это очистка на тот случай когда держим уже удаленный параграф - и у него уже нет Owner'а
  with f_Group do
   for l_Index := 0 to Pred(ChildrenCount) do
    with Child[l_Index] do
     for l_Row := 0 to Pred(ChildrenCount) do
      with Child[l_Row] do
       if HasSubAtom(k2_tiModelControl) then
       // - проверка, чтобы в WevReqRow.GetAtomData не попадать
        if l3IEQ(Self, IUnknown(IntA[k2_tiModelControl])) then
         AttrW[k2_tiModelControl, nil] := nil;
 end;//not l_Cleared
 FreeAndNil(f_Group);
 l3Free(f_ReqCaption);
 l3Free(f_ControlsList);
 l3Free(f_FieldsList);
 inherited;
//#UC END# *479731C50290_48D3BD0A02D7_impl*
end;//TevReq.Cleanup

constructor TevReq.Create(const aPara: InevPara);
//#UC START# *47CFE07602FE_48D3BD0A02D7_var*
//#UC END# *47CFE07602FE_48D3BD0A02D7_var*
begin
//#UC START# *47CFE07602FE_48D3BD0A02D7_impl*
 inherited;
 f_FieldsList := TevEditorControlFieldList.Make;
 f_ControlsList := TevEditorControlList.Make;
 InitModel(aPara, False, -1, -1);
 aPara.AsObject.IntA[k2_tiModelControl] := Integer(IevReq(Self));
//#UC END# *47CFE07602FE_48D3BD0A02D7_impl*
end;//TevReq.Create

end.