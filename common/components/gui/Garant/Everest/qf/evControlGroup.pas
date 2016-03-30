unit evControlGroup;
 {* Группа реквизитов (блок параграфов) }

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evControlGroup.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevControlGroup" MUID: (48DB819600D8)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , evReqList
 , evDescriptionReqList
 , nevTools
 , l3Interfaces
 , evdTypes
 , nevBase
;

type
 TevControlGroup = class(TevCustomControlTool, IevCustomEditorControl, IevQueryGroup)
  {* Группа реквизитов (блок параграфов) }
  private
   f_ReqList: TevReqList;
    {* Список реквизитов для каждой группы (IevReq) }
   f_DescriptionList: TevDescriptionReqList;
    {* Список описаний для каждой группы (IevDescriptionReq) }
   f_QueryCard: Pointer;
    {* Указатель на контейнер всех виджетов, групп и атрибутов. IevQueryCard }
  protected
   function IsMultiline: Boolean;
    {* Контрол содержит несколько строк и поддерживает перемещение по ним 
          с помощью стрелок (к меткам это не относится). }
   function GetControlIterator: IevControlIterator;
    {* Интерфейс "навигатора" по контролам. }
   procedure InitBoolProperty(aIdent: Integer;
    aValue: Boolean);
    {* Для установки начальных значений (не используется передача данных для 
         процессора операций). }
   procedure UpperChange;
    {* Обработчик изменения состояния кнопок. }
   function Get_ControlName: Tl3WString;
   procedure Set_ControlName(const aValue: Tl3WString);
   function Get_ControlType: TevControlType;
   function Get_Visible: Boolean;
   procedure Set_Visible(aValue: Boolean);
   function Get_Upper: Boolean;
   procedure Set_Upper(aValue: Boolean);
   procedure ClickOnDisabledLabel;
   procedure AfterCollapsed;
    {* Обработчик события сворачивания группы. }
   function CanCollapsed: Boolean;
    {* Проверка может ли группа свернуться. }
   function LMouseBtnDown(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState;
    const aMap: InevMap): Boolean;
    {* Обработка нажания на левую кнопку мыши. }
   function LMouseBtnUp(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState): Boolean;
   function FindDescriptionReq(const aReqName: Tl3WString): IevDescriptionReq;
    {* Возвращает реквизит по имени. }
   procedure InitModel(const aTag: InevPara);
    {* Инициализация модели. }
   function LastReq: IevReq;
    {* Последний реквизт в группе. }
   function FirstReq: IevReq;
    {* Первый реквизит в группе. }
   function GetNextReq(const aReq: IevReq): IevReq;
    {* Возвращает следующий реквизит. }
   function GetPrevReq(const aReq: IevReq): IevReq;
    {* Возвращает предыдущий реквизит. }
   function Get_Req(Index: Integer): IevReq;
   function Get_ReqCount: Integer;
   function Get_DescriptionReq(Index: Integer): IevDescriptionReq;
   function Get_DescriptionReqCount: Integer;
   function Get_GroupName: Il3CString;
   function Get_Expanded: Boolean;
   procedure Set_Expanded(aValue: Boolean);
   function Get_QueryCard: IevQueryCard;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make(const aValue: InevPara;
    const aQueryAdapter: IevQueryCard): IevQueryGroup; reintroduce;
   constructor Create(const aValue: InevPara;
    const aQueryAdapter: IevQueryCard); reintroduce;
 end;//TevControlGroup

implementation

uses
 l3ImplUses
 , k2Tags
 , l3Types
 , l3Base
 , k2OpMisc
 , l3String
 , evReq
 , evDescriptionReq
 , nevFacade
 , ReqRow_Const
;

class function TevControlGroup.Make(const aValue: InevPara;
 const aQueryAdapter: IevQueryCard): IevQueryGroup;
var
 l_Inst : TevControlGroup;
begin
 l_Inst := Create(aValue, aQueryAdapter);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevControlGroup.Make

constructor TevControlGroup.Create(const aValue: InevPara;
 const aQueryAdapter: IevQueryCard);
//#UC START# *48DB8D660301_48DB819600D8_var*
//#UC END# *48DB8D660301_48DB819600D8_var*
begin
//#UC START# *48DB8D660301_48DB819600D8_impl*
 inherited Create(aValue);
 f_ReqList := TevReqList.Make;
 f_DescriptionList := TevDescriptionReqList.Make;
 f_QueryCard := Pointer(aQueryAdapter);
 aValue.AsObject.IntA[k2_tiModelControl] := Long(IevQueryGroup(Self));
//#UC END# *48DB8D660301_48DB819600D8_impl*
end;//TevControlGroup.Create

function TevControlGroup.IsMultiline: Boolean;
 {* Контрол содержит несколько строк и поддерживает перемещение по ним 
          с помощью стрелок (к меткам это не относится). }
//#UC START# *47CD5E7A027B_48DB819600D8_var*
//#UC END# *47CD5E7A027B_48DB819600D8_var*
begin
//#UC START# *47CD5E7A027B_48DB819600D8_impl*
 Result := False;
//#UC END# *47CD5E7A027B_48DB819600D8_impl*
end;//TevControlGroup.IsMultiline

function TevControlGroup.GetControlIterator: IevControlIterator;
 {* Интерфейс "навигатора" по контролам. }
//#UC START# *47CD5E9B031F_48DB819600D8_var*
//#UC END# *47CD5E9B031F_48DB819600D8_var*
begin
//#UC START# *47CD5E9B031F_48DB819600D8_impl*
 Result := IevQueryCard(f_QueryCard).GetControlIterator(Self);
//#UC END# *47CD5E9B031F_48DB819600D8_impl*
end;//TevControlGroup.GetControlIterator

procedure TevControlGroup.InitBoolProperty(aIdent: Integer;
 aValue: Boolean);
 {* Для установки начальных значений (не используется передача данных для 
         процессора операций). }
//#UC START# *47CD5EB4005D_48DB819600D8_var*
//#UC END# *47CD5EB4005D_48DB819600D8_var*
begin
//#UC START# *47CD5EB4005D_48DB819600D8_impl*
 Para.AsObject.BoolW[aIdent, nil] := aValue;
//#UC END# *47CD5EB4005D_48DB819600D8_impl*
end;//TevControlGroup.InitBoolProperty

procedure TevControlGroup.UpperChange;
 {* Обработчик изменения состояния кнопок. }
//#UC START# *47CD5EC10294_48DB819600D8_var*
//#UC END# *47CD5EC10294_48DB819600D8_var*
begin
//#UC START# *47CD5EC10294_48DB819600D8_impl*
 Get_QueryCard.UpperChange(Self);
//#UC END# *47CD5EC10294_48DB819600D8_impl*
end;//TevControlGroup.UpperChange

function TevControlGroup.Get_ControlName: Tl3WString;
//#UC START# *47CD5EE900F7_48DB819600D8get_var*
//#UC END# *47CD5EE900F7_48DB819600D8get_var*
begin
//#UC START# *47CD5EE900F7_48DB819600D8get_impl*
 Result := Para.AsObject.PCharLenA[k2_tiName];
//#UC END# *47CD5EE900F7_48DB819600D8get_impl*
end;//TevControlGroup.Get_ControlName

procedure TevControlGroup.Set_ControlName(const aValue: Tl3WString);
//#UC START# *47CD5EE900F7_48DB819600D8set_var*
//#UC END# *47CD5EE900F7_48DB819600D8set_var*
begin
//#UC START# *47CD5EE900F7_48DB819600D8set_impl*
 Para.AsObject.PCharLenW[k2_tiName, nil] := Tl3PCharLen(aValue);
//#UC END# *47CD5EE900F7_48DB819600D8set_impl*
end;//TevControlGroup.Set_ControlName

function TevControlGroup.Get_ControlType: TevControlType;
//#UC START# *47CD5F19011F_48DB819600D8get_var*
//#UC END# *47CD5F19011F_48DB819600D8get_var*
begin
//#UC START# *47CD5F19011F_48DB819600D8get_impl*
 Result := ev_ctCollapsedPanel;
//#UC END# *47CD5F19011F_48DB819600D8get_impl*
end;//TevControlGroup.Get_ControlType

function TevControlGroup.Get_Visible: Boolean;
//#UC START# *47CD5F3B03CA_48DB819600D8get_var*
//#UC END# *47CD5F3B03CA_48DB819600D8get_var*
begin
//#UC START# *47CD5F3B03CA_48DB819600D8get_impl*
 Result := True;
//#UC END# *47CD5F3B03CA_48DB819600D8get_impl*
end;//TevControlGroup.Get_Visible

procedure TevControlGroup.Set_Visible(aValue: Boolean);
//#UC START# *47CD5F3B03CA_48DB819600D8set_var*
//#UC END# *47CD5F3B03CA_48DB819600D8set_var*
begin
//#UC START# *47CD5F3B03CA_48DB819600D8set_impl*
 Assert(false);
//#UC END# *47CD5F3B03CA_48DB819600D8set_impl*
end;//TevControlGroup.Set_Visible

function TevControlGroup.Get_Upper: Boolean;
//#UC START# *47CD5F4F015B_48DB819600D8get_var*
//#UC END# *47CD5F4F015B_48DB819600D8get_var*
begin
//#UC START# *47CD5F4F015B_48DB819600D8get_impl*
 Result := Para.AsObject.BoolA[k2_tiUpper];
//#UC END# *47CD5F4F015B_48DB819600D8get_impl*
end;//TevControlGroup.Get_Upper

procedure TevControlGroup.Set_Upper(aValue: Boolean);
//#UC START# *47CD5F4F015B_48DB819600D8set_var*
//#UC END# *47CD5F4F015B_48DB819600D8set_var*
begin
//#UC START# *47CD5F4F015B_48DB819600D8set_impl*
 Para.AsObject.BoolW[k2_tiUpper, nil] := aValue;
//#UC END# *47CD5F4F015B_48DB819600D8set_impl*
end;//TevControlGroup.Set_Upper

procedure TevControlGroup.ClickOnDisabledLabel;
//#UC START# *47CD7F53034B_48DB819600D8_var*
//#UC END# *47CD7F53034B_48DB819600D8_var*
begin
//#UC START# *47CD7F53034B_48DB819600D8_impl*
 (Get_QueryCard As InevControlListener).HideDroppedControl(True);
//#UC END# *47CD7F53034B_48DB819600D8_impl*
end;//TevControlGroup.ClickOnDisabledLabel

procedure TevControlGroup.AfterCollapsed;
 {* Обработчик события сворачивания группы. }
//#UC START# *47CD7F8D00E8_48DB819600D8_var*
//#UC END# *47CD7F8D00E8_48DB819600D8_var*
begin
//#UC START# *47CD7F8D00E8_48DB819600D8_impl*
 Get_QueryCard.AfterCollapsed(Self);
//#UC END# *47CD7F8D00E8_48DB819600D8_impl*
end;//TevControlGroup.AfterCollapsed

function TevControlGroup.CanCollapsed: Boolean;
 {* Проверка может ли группа свернуться. }
//#UC START# *47CD7F9F006A_48DB819600D8_var*
var
 i       : Integer;
 l_Count : Integer;
//#UC END# *47CD7F9F006A_48DB819600D8_var*
begin
//#UC START# *47CD7F9F006A_48DB819600D8_impl*
 Result := Para.AsObject.BoolA[k2_tiFlat];
 //                   ^ http://mdp.garant.ru/pages/viewpage.action?pageId=119473683&focusedCommentId=119473946#comment-119473946
 if Result then
 begin
  l_Count := f_ReqList.Count - 1;
  for i := 0 to l_Count do
   if not Get_Req(i).IsEmpty then
   begin
    Result := False;
    Break;
   end;
  end;
//#UC END# *47CD7F9F006A_48DB819600D8_impl*
end;//TevControlGroup.CanCollapsed

function TevControlGroup.LMouseBtnDown(const aView: InevControlView;
 const aTextPara: InevPara;
 const aPt: TnevPoint;
 const Keys: TevMouseState;
 const aMap: InevMap): Boolean;
 {* Обработка нажания на левую кнопку мыши. }
//#UC START# *47CD7FF40330_48DB819600D8_var*
//#UC END# *47CD7FF40330_48DB819600D8_var*
begin
//#UC START# *47CD7FF40330_48DB819600D8_impl*
 (Get_QueryCard As InevControlListener).HideDroppedControl(True);
 Result := True;
//#UC END# *47CD7FF40330_48DB819600D8_impl*
end;//TevControlGroup.LMouseBtnDown

function TevControlGroup.LMouseBtnUp(const aView: InevControlView;
 const aTextPara: InevPara;
 const aPt: TnevPoint;
 const Keys: TevMouseState): Boolean;
//#UC START# *47CD802F02AE_48DB819600D8_var*
//#UC END# *47CD802F02AE_48DB819600D8_var*
begin
//#UC START# *47CD802F02AE_48DB819600D8_impl*
 Result := True;
 if Get_Expanded and not CanCollapsed then
  Exit;
 with Para do
  AsObject.BoolW[k2_tiCollapsed, k2StartOp(aView.Control.Processor)] :=
   not AsObject.BoolA[k2_tiCollapsed];
 AfterCollapsed;
 Para.AsObject.BoolW[k2_tiChecked, nil] := False;
 Set_Upper(False);
//#UC END# *47CD802F02AE_48DB819600D8_impl*
end;//TevControlGroup.LMouseBtnUp

function TevControlGroup.FindDescriptionReq(const aReqName: Tl3WString): IevDescriptionReq;
 {* Возвращает реквизит по имени. }
//#UC START# *47CD806B02F2_48DB819600D8_var*
var
 i       : Integer;
 l_Count : Integer;
 l_Req   : IevDescriptionReq;
//#UC END# *47CD806B02F2_48DB819600D8_var*
begin
//#UC START# *47CD806B02F2_48DB819600D8_impl*
 Result := nil;
 l_Count := f_DescriptionList.Count - 1;
 for i := l_Count downto 0 do
 begin
  l_Req := f_DescriptionList[i];
  try
   if l3Same(l_Req.ReqName, aReqName, true) then
   begin
    Result := l_Req;
    Break;
   end;//l3Same(l_Req.ReqName, aReqName, true)
  finally
   l_Req := nil;
  end;//try..finally
 end;//for i
//#UC END# *47CD806B02F2_48DB819600D8_impl*
end;//TevControlGroup.FindDescriptionReq

procedure TevControlGroup.InitModel(const aTag: InevPara);
 {* Инициализация модели. }
//#UC START# *47CD807D0057_48DB819600D8_var*
var
 l_OldReqName: array [Boolean] of string;
 l_ReqList   : TevReqList;
 l_DescriptionList: TevDescriptionReqList;

 function GetChildLine(const aChild: InevPara; Index: Long): Bool;
 var
  l_CL      : IevReq;
  l_Name    : String;
  l_ReqKind : TevReqKind;
  l_Enabled : Boolean;
 begin
  Result := True;
  with aChild do
   if AsObject.IsKindOf(k2_typReqRow) then
   begin
    l_Name := aChild.AsObject.Attr[k2_tiReqID].AsString;
    l_ReqKind := TevReqKind(aChild.AsObject.IntA[k2_tiReqKind]);
    l_Enabled := l_ReqKind <> ev_rkDescription;
    aChild.AsObject.BoolW[k2_tiEnabled, nil] := l_Enabled;
    if l_Enabled then
    begin
     if (l_Name = l_OldReqName[true]) then
     begin
      l_CL := l_ReqList.Last;
      try
       l_CL.InitModel(aChild, True, -1, -1);
      finally
       l_CL := nil;
      end;//try..finally
     end//l_Name = l_OldReqName[true]
     else
     begin
      l_OldReqName[true] := l_Name;
      l_ReqList.Add(TevReq.Make(aChild));
     end;//l_Name = l_OldReqName[true]
    end//l_Enabled
    else
    begin
     if (l_Name = l_OldReqName[false]) then
      Assert(False,'Allow only one control for description')
     else
     begin
      l_OldReqName[false] := l_Name;
      l_DescriptionList.Add(TevDescriptionReq.Make(aChild));
     end;//l_Name = l_OldReqName[false]
    end;//l_Enabled
   end;//if IsKindOf(k2_typControlBlock)
 end;//GetChildLine

//#UC END# *47CD807D0057_48DB819600D8_var*
begin
//#UC START# *47CD807D0057_48DB819600D8_impl*
 l_OldReqName[False] := '';
 l_OldReqName[True] := '';
 l_DescriptionList := f_DescriptionList;
 l_ReqList := f_ReqList;
 with aTag do
  if AsObject.IsValid then
   AsList.IterateParaF(nevL2PIA(@GetChildLine));
//#UC END# *47CD807D0057_48DB819600D8_impl*
end;//TevControlGroup.InitModel

function TevControlGroup.LastReq: IevReq;
 {* Последний реквизт в группе. }
//#UC START# *47CD80890115_48DB819600D8_var*
//#UC END# *47CD80890115_48DB819600D8_var*
begin
//#UC START# *47CD80890115_48DB819600D8_impl*
 Result := f_ReqList.Last;
//#UC END# *47CD80890115_48DB819600D8_impl*
end;//TevControlGroup.LastReq

function TevControlGroup.FirstReq: IevReq;
 {* Первый реквизит в группе. }
//#UC START# *47CD8097030D_48DB819600D8_var*
//#UC END# *47CD8097030D_48DB819600D8_var*
begin
//#UC START# *47CD8097030D_48DB819600D8_impl*
 Result := f_ReqList.First;
//#UC END# *47CD8097030D_48DB819600D8_impl*
end;//TevControlGroup.FirstReq

function TevControlGroup.GetNextReq(const aReq: IevReq): IevReq;
 {* Возвращает следующий реквизит. }
//#UC START# *47CD80A80368_48DB819600D8_var*
var
 l_Index: Integer;
//#UC END# *47CD80A80368_48DB819600D8_var*
begin
//#UC START# *47CD80A80368_48DB819600D8_impl*
 Result := nil;
 if (f_ReqList.Last <> aReq) then 
 begin
  l_Index := f_ReqList.IndexOf(aReq) + 1;
  if l_Index < f_ReqList.Count then
   Result := f_ReqList[l_Index];
 end; 
//#UC END# *47CD80A80368_48DB819600D8_impl*
end;//TevControlGroup.GetNextReq

function TevControlGroup.GetPrevReq(const aReq: IevReq): IevReq;
 {* Возвращает предыдущий реквизит. }
//#UC START# *47CD80D8028A_48DB819600D8_var*
var
 l_Index: Integer;
//#UC END# *47CD80D8028A_48DB819600D8_var*
begin
//#UC START# *47CD80D8028A_48DB819600D8_impl*
 Result := nil;
 if (f_ReqList.First <> aReq) then 
 begin
  l_Index := f_ReqList.IndexOf(aReq) - 1;
  if l_Index >= 0 then 
   Result := f_ReqList[l_Index];
 end; 
//#UC END# *47CD80D8028A_48DB819600D8_impl*
end;//TevControlGroup.GetPrevReq

function TevControlGroup.Get_Req(Index: Integer): IevReq;
//#UC START# *47CD80EB0376_48DB819600D8get_var*
//#UC END# *47CD80EB0376_48DB819600D8get_var*
begin
//#UC START# *47CD80EB0376_48DB819600D8get_impl*
 Result := f_ReqList[Index];
//#UC END# *47CD80EB0376_48DB819600D8get_impl*
end;//TevControlGroup.Get_Req

function TevControlGroup.Get_ReqCount: Integer;
//#UC START# *47CD810E0258_48DB819600D8get_var*
//#UC END# *47CD810E0258_48DB819600D8get_var*
begin
//#UC START# *47CD810E0258_48DB819600D8get_impl*
 Result := f_ReqList.Count;
//#UC END# *47CD810E0258_48DB819600D8get_impl*
end;//TevControlGroup.Get_ReqCount

function TevControlGroup.Get_DescriptionReq(Index: Integer): IevDescriptionReq;
//#UC START# *47CD814902F1_48DB819600D8get_var*
//#UC END# *47CD814902F1_48DB819600D8get_var*
begin
//#UC START# *47CD814902F1_48DB819600D8get_impl*
 Result := f_DescriptionList[Index];
//#UC END# *47CD814902F1_48DB819600D8get_impl*
end;//TevControlGroup.Get_DescriptionReq

function TevControlGroup.Get_DescriptionReqCount: Integer;
//#UC START# *47CD817001B4_48DB819600D8get_var*
//#UC END# *47CD817001B4_48DB819600D8get_var*
begin
//#UC START# *47CD817001B4_48DB819600D8get_impl*
 Result := f_DescriptionList.Count;
//#UC END# *47CD817001B4_48DB819600D8get_impl*
end;//TevControlGroup.Get_DescriptionReqCount

function TevControlGroup.Get_GroupName: Il3CString;
//#UC START# *47CD8184009F_48DB819600D8get_var*
//#UC END# *47CD8184009F_48DB819600D8get_var*
begin
//#UC START# *47CD8184009F_48DB819600D8get_impl*
 Result := l3CStr(Para.AsObject.PCharLenA[k2_tiShortName]);
//#UC END# *47CD8184009F_48DB819600D8get_impl*
end;//TevControlGroup.Get_GroupName

function TevControlGroup.Get_Expanded: Boolean;
//#UC START# *47CD819D0144_48DB819600D8get_var*
//#UC END# *47CD819D0144_48DB819600D8get_var*
begin
//#UC START# *47CD819D0144_48DB819600D8get_impl*
 Result := not Para.AsObject.BoolA[k2_tiCollapsed];
//#UC END# *47CD819D0144_48DB819600D8get_impl*
end;//TevControlGroup.Get_Expanded

procedure TevControlGroup.Set_Expanded(aValue: Boolean);
//#UC START# *47CD819D0144_48DB819600D8set_var*
//#UC END# *47CD819D0144_48DB819600D8set_var*
begin
//#UC START# *47CD819D0144_48DB819600D8set_impl*
 Para.AsObject.BoolW[k2_tiCollapsed, nil] := not aValue;
//#UC END# *47CD819D0144_48DB819600D8set_impl*
end;//TevControlGroup.Set_Expanded

function TevControlGroup.Get_QueryCard: IevQueryCard;
//#UC START# *47CD81C7029A_48DB819600D8get_var*
//#UC END# *47CD81C7029A_48DB819600D8get_var*
begin
//#UC START# *47CD81C7029A_48DB819600D8get_impl*
 Result := IevQueryCard(f_QueryCard);
//#UC END# *47CD81C7029A_48DB819600D8get_impl*
end;//TevControlGroup.Get_QueryCard

procedure TevControlGroup.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48DB819600D8_var*
//#UC END# *479731C50290_48DB819600D8_var*
begin
//#UC START# *479731C50290_48DB819600D8_impl*
 f_QueryCard := nil;  
 l3Free(f_ReqList);
 l3Free(f_DescriptionList);
 inherited;        
//#UC END# *479731C50290_48DB819600D8_impl*
end;//TevControlGroup.Cleanup

end.
