unit evControl;
 {* Базовый класс для всех контролов }

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evControl.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , nevTools
 , nevBase
 , l3Interfaces
 , evdTypes
;

type
 TevControl = class(TevCustomControlTool, IevCustomEditorControl, IevEditorControl)
  {* Базовый класс для всех контролов }
  private
   f_Field: Pointer;
  protected
   function GetIsMultiline: Boolean; virtual;
   procedure SetChecked(aValue: Boolean);
   function DoLMouseBtnUp(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState;
    anInPara: Boolean): Boolean; virtual; abstract;
   function DoLMouseBtnDown(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState;
    anInPara: Boolean;
    const aMap: InevMap): Boolean; virtual; abstract;
   procedure DoUpperChange; virtual;
   procedure SetText(const Value: Il3CString); virtual;
   function GetChecked: Boolean;
   procedure DoTextChange(const aView: InevView;
    const aPara: InevPara;
    const anOp: InevOp); virtual;
   procedure DoInsertRow(const aView: InevView); virtual;
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
   function LMouseBtnUp(const aView: InevControlView;
    const aPara: InevPara;
    const aPt: TnevPoint;
    const aKeys: TevMouseState;
    anInPara: Boolean): Boolean;
    {* Обработчик нажатия на левую кнопку мыши. }
   function LMouseBtnDown(const aView: InevControlView;
    const aPara: InevPara;
    const aPt: TnevPoint;
    const aKeys: TevMouseState;
    anInPara: Boolean;
    const aMap: InevMap): Boolean;
    {* Обработчик отпускания левой кнопки мыши. }
   function KeyCommand(const aView: InevControlView;
    aCmd: Word;
    const aPara: InevPara): Boolean;
    {* Обработчик комманд от редактора. }
   procedure RememberState;
    {* Запоминание состояния для всплывающего меню. }
   procedure TextChange(const aView: InevView;
    const aPara: InevPara;
    const anOp: InevOp);
    {* Событие изменения текста в параграфе (внешний вызов). }
   function GetHint(var aValue: Il3CString): Boolean;
    {* Вывод хинта на экран. Если данных нет, то возвращается False. }
   procedure InsertRow(const aView: InevView);
    {* Событие добавления строки к таблице по 'Enter'. }
   procedure SetFocus(aChangePara: Boolean = False);
    {* Передать фокус контролу (выделить с помощью фокусной рамки. }
   function Get_Field: IevEditorControlField;
   procedure Set_Field(const aValue: IevEditorControlField);
   function Get_Req: IevReq;
   function Get_Enabled: Boolean;
   procedure Set_Enabled(aValue: Boolean);
   function Get_MaxLength: Integer;
   function Get_Caption: Il3CString;
  public
   class function Make(const aValue: InevPara): IevEditorControl; reintroduce;
   function DoKeyCommand(const aView: InevControlView;
    aCmd: Word;
    const aTextPara: InevPara): Boolean; virtual;
   constructor Create(const aPara: InevPara); override;
 end;//TevControl

implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , l3Types
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , SysUtils
 , l3InterfacedString
 , l3String
 , ReqRow_Const
 , l3CEmptyStringPrim
 , l3CEmptyString
;

function TevControl.GetIsMultiline: Boolean;
//#UC START# *48D13CED0240_48D13B8D03A3_var*
//#UC END# *48D13CED0240_48D13B8D03A3_var*
begin
//#UC START# *48D13CED0240_48D13B8D03A3_impl*
 Result := false;
//#UC END# *48D13CED0240_48D13B8D03A3_impl*
end;//TevControl.GetIsMultiline

class function TevControl.Make(const aValue: InevPara): IevEditorControl;
var
 l_Inst : TevControl;
begin
 l_Inst := Create(aValue);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevControl.Make

procedure TevControl.SetChecked(aValue: Boolean);
//#UC START# *48D14220033C_48D13B8D03A3_var*
//#UC END# *48D14220033C_48D13B8D03A3_var*
begin
//#UC START# *48D14220033C_48D13B8D03A3_impl*
 Para.AsObject.BoolW[k2_tiChecked, nil] := aValue;
//#UC END# *48D14220033C_48D13B8D03A3_impl*
end;//TevControl.SetChecked

function TevControl.DoKeyCommand(const aView: InevControlView;
 aCmd: Word;
 const aTextPara: InevPara): Boolean;
//#UC START# *48D145B8036A_48D13B8D03A3_var*
//#UC END# *48D145B8036A_48D13B8D03A3_var*
begin
//#UC START# *48D145B8036A_48D13B8D03A3_impl*
 Result := false;
//#UC END# *48D145B8036A_48D13B8D03A3_impl*
end;//TevControl.DoKeyCommand

procedure TevControl.DoUpperChange;
//#UC START# *48D1489102C9_48D13B8D03A3_var*
//#UC END# *48D1489102C9_48D13B8D03A3_var*
begin
//#UC START# *48D1489102C9_48D13B8D03A3_impl*
//#UC END# *48D1489102C9_48D13B8D03A3_impl*
end;//TevControl.DoUpperChange

procedure TevControl.SetText(const Value: Il3CString);
//#UC START# *48D148F7020F_48D13B8D03A3_var*
var
 l_Req : IevReq;
 l_S   : Tl3InterfacedString;
//#UC END# *48D148F7020F_48D13B8D03A3_var*
begin
//#UC START# *48D148F7020F_48D13B8D03A3_impl*
 l_S := Tl3InterfacedString.Make(l3PCharLen(Value));
 try
  l_Req := Get_Req;
  if (l_Req <> nil) then
   Para.Range.Text.Modify.InsertString(nil, l_S, l_Req.QueryCard.GetDocumentContainer.Processor.StartOp, true, [misfSetText])
  else
   Para.Range.Text.Modify.InsertString(nil, l_S, nil, true, [misfSetText]);
 finally
  l3Free(l_S);
 end;//try..finally
//#UC END# *48D148F7020F_48D13B8D03A3_impl*
end;//TevControl.SetText

function TevControl.GetChecked: Boolean;
//#UC START# *48D14B6A01B3_48D13B8D03A3_var*
//#UC END# *48D14B6A01B3_48D13B8D03A3_var*
begin
//#UC START# *48D14B6A01B3_48D13B8D03A3_impl*
 Result := Para.AsObject.BoolA[k2_tiChecked];
//#UC END# *48D14B6A01B3_48D13B8D03A3_impl*
end;//TevControl.GetChecked

procedure TevControl.DoTextChange(const aView: InevView;
 const aPara: InevPara;
 const anOp: InevOp);
//#UC START# *48D14C0E023E_48D13B8D03A3_var*
//#UC END# *48D14C0E023E_48D13B8D03A3_var*
begin
//#UC START# *48D14C0E023E_48D13B8D03A3_impl*
//#UC END# *48D14C0E023E_48D13B8D03A3_impl*
end;//TevControl.DoTextChange

procedure TevControl.DoInsertRow(const aView: InevView);
//#UC START# *48D14FA70154_48D13B8D03A3_var*
//#UC END# *48D14FA70154_48D13B8D03A3_var*
begin
//#UC START# *48D14FA70154_48D13B8D03A3_impl*
//#UC END# *48D14FA70154_48D13B8D03A3_impl*
end;//TevControl.DoInsertRow

function TevControl.IsMultiline: Boolean;
 {* Контрол содержит несколько строк и поддерживает перемещение по ним 
          с помощью стрелок (к меткам это не относится). }
//#UC START# *47CD5E7A027B_48D13B8D03A3_var*
//#UC END# *47CD5E7A027B_48D13B8D03A3_var*
begin
//#UC START# *47CD5E7A027B_48D13B8D03A3_impl*
 Result := GetIsMultiline;
//#UC END# *47CD5E7A027B_48D13B8D03A3_impl*
end;//TevControl.IsMultiline

function TevControl.GetControlIterator: IevControlIterator;
 {* Интерфейс "навигатора" по контролам. }
//#UC START# *47CD5E9B031F_48D13B8D03A3_var*
//#UC END# *47CD5E9B031F_48D13B8D03A3_var*
begin
//#UC START# *47CD5E9B031F_48D13B8D03A3_impl*
 Result := Get_Req.QueryCard.GetControlIterator(Self);
//#UC END# *47CD5E9B031F_48D13B8D03A3_impl*
end;//TevControl.GetControlIterator

procedure TevControl.InitBoolProperty(aIdent: Integer;
 aValue: Boolean);
 {* Для установки начальных значений (не используется передача данных для 
         процессора операций). }
//#UC START# *47CD5EB4005D_48D13B8D03A3_var*
//#UC END# *47CD5EB4005D_48D13B8D03A3_var*
begin
//#UC START# *47CD5EB4005D_48D13B8D03A3_impl*
 Para.AsObject.BoolW[aIdent, nil] := aValue;
//#UC END# *47CD5EB4005D_48D13B8D03A3_impl*
end;//TevControl.InitBoolProperty

procedure TevControl.UpperChange;
 {* Обработчик изменения состояния кнопок. }
//#UC START# *47CD5EC10294_48D13B8D03A3_var*
//#UC END# *47CD5EC10294_48D13B8D03A3_var*
begin
//#UC START# *47CD5EC10294_48D13B8D03A3_impl*
 DoUpperChange;
//#UC END# *47CD5EC10294_48D13B8D03A3_impl*
end;//TevControl.UpperChange

function TevControl.Get_ControlName: Tl3WString;
//#UC START# *47CD5EE900F7_48D13B8D03A3get_var*
//#UC END# *47CD5EE900F7_48D13B8D03A3get_var*
begin
//#UC START# *47CD5EE900F7_48D13B8D03A3get_impl*
 Result := Para.AsObject.PCharLenA[k2_tiName];
//#UC END# *47CD5EE900F7_48D13B8D03A3get_impl*
end;//TevControl.Get_ControlName

procedure TevControl.Set_ControlName(const aValue: Tl3WString);
//#UC START# *47CD5EE900F7_48D13B8D03A3set_var*
//#UC END# *47CD5EE900F7_48D13B8D03A3set_var*
begin
//#UC START# *47CD5EE900F7_48D13B8D03A3set_impl*
 Para.AsObject.PCharLenW[k2_tiName, nil] := Tl3PCharLen(aValue);
//#UC END# *47CD5EE900F7_48D13B8D03A3set_impl*
end;//TevControl.Set_ControlName

function TevControl.Get_ControlType: TevControlType;
//#UC START# *47CD5F19011F_48D13B8D03A3get_var*
//#UC END# *47CD5F19011F_48D13B8D03A3get_var*
begin
//#UC START# *47CD5F19011F_48D13B8D03A3get_impl*
 Result := TevControlType(Para.AsObject.IntA[k2_tiType]);
//#UC END# *47CD5F19011F_48D13B8D03A3get_impl*
end;//TevControl.Get_ControlType

function TevControl.Get_Visible: Boolean;
//#UC START# *47CD5F3B03CA_48D13B8D03A3get_var*
//#UC END# *47CD5F3B03CA_48D13B8D03A3get_var*
begin
//#UC START# *47CD5F3B03CA_48D13B8D03A3get_impl*
 Result := Para.AsObject.BoolA[k2_tiVisible];
//#UC END# *47CD5F3B03CA_48D13B8D03A3get_impl*
end;//TevControl.Get_Visible

procedure TevControl.Set_Visible(aValue: Boolean);
//#UC START# *47CD5F3B03CA_48D13B8D03A3set_var*
var
 l3Op: InevOp;
//#UC END# *47CD5F3B03CA_48D13B8D03A3set_var*
begin
//#UC START# *47CD5F3B03CA_48D13B8D03A3set_impl*
 if aValue = Get_Visible then Exit;
 if aValue then 
  SetChecked(False);
 if Get_Req <> nil then
  l3Op := Get_Req.QueryCard.GetDocumentContainer.Processor.StartOp
 else
  l3Op := nil;
 Para.AsObject.BoolW[k2_tiVisible, l3Op] := aValue;
//#UC END# *47CD5F3B03CA_48D13B8D03A3set_impl*
end;//TevControl.Set_Visible

function TevControl.Get_Upper: Boolean;
//#UC START# *47CD5F4F015B_48D13B8D03A3get_var*
//#UC END# *47CD5F4F015B_48D13B8D03A3get_var*
begin
//#UC START# *47CD5F4F015B_48D13B8D03A3get_impl*
 Result := Para.AsObject.BoolA[k2_tiUpper];
//#UC END# *47CD5F4F015B_48D13B8D03A3get_impl*
end;//TevControl.Get_Upper

procedure TevControl.Set_Upper(aValue: Boolean);
//#UC START# *47CD5F4F015B_48D13B8D03A3set_var*
//#UC END# *47CD5F4F015B_48D13B8D03A3set_var*
begin
//#UC START# *47CD5F4F015B_48D13B8D03A3set_impl*
 Para.AsObject.BoolW[k2_tiUpper, nil] := aValue;
//#UC END# *47CD5F4F015B_48D13B8D03A3set_impl*
end;//TevControl.Set_Upper

function TevControl.LMouseBtnUp(const aView: InevControlView;
 const aPara: InevPara;
 const aPt: TnevPoint;
 const aKeys: TevMouseState;
 anInPara: Boolean): Boolean;
 {* Обработчик нажатия на левую кнопку мыши. }
//#UC START# *47CD77D60195_48D13B8D03A3_var*
//#UC END# *47CD77D60195_48D13B8D03A3_var*
begin
//#UC START# *47CD77D60195_48D13B8D03A3_impl*
 Result := DoLMouseBtnUp(aView, aPara, aPt, aKeys, anInPara);
//#UC END# *47CD77D60195_48D13B8D03A3_impl*
end;//TevControl.LMouseBtnUp

function TevControl.LMouseBtnDown(const aView: InevControlView;
 const aPara: InevPara;
 const aPt: TnevPoint;
 const aKeys: TevMouseState;
 anInPara: Boolean;
 const aMap: InevMap): Boolean;
 {* Обработчик отпускания левой кнопки мыши. }
//#UC START# *47CD78150291_48D13B8D03A3_var*
//#UC END# *47CD78150291_48D13B8D03A3_var*
begin
//#UC START# *47CD78150291_48D13B8D03A3_impl*
 Result := DoLMouseBtnDown(aView, aPara, aPt, aKeys, anInPara, aMap);
//#UC END# *47CD78150291_48D13B8D03A3_impl*
end;//TevControl.LMouseBtnDown

function TevControl.KeyCommand(const aView: InevControlView;
 aCmd: Word;
 const aPara: InevPara): Boolean;
 {* Обработчик комманд от редактора. }
//#UC START# *47CD784A00E0_48D13B8D03A3_var*
//#UC END# *47CD784A00E0_48D13B8D03A3_var*
begin
//#UC START# *47CD784A00E0_48D13B8D03A3_impl*
 Result := DoKeyCommand(aView, aCmd, aPara);
//#UC END# *47CD784A00E0_48D13B8D03A3_impl*
end;//TevControl.KeyCommand

procedure TevControl.RememberState;
 {* Запоминание состояния для всплывающего меню. }
//#UC START# *47CD785F0300_48D13B8D03A3_var*
//#UC END# *47CD785F0300_48D13B8D03A3_var*
begin
//#UC START# *47CD785F0300_48D13B8D03A3_impl*
 Get_Req.RememberState(Self); 
//#UC END# *47CD785F0300_48D13B8D03A3_impl*
end;//TevControl.RememberState

procedure TevControl.TextChange(const aView: InevView;
 const aPara: InevPara;
 const anOp: InevOp);
 {* Событие изменения текста в параграфе (внешний вызов). }
//#UC START# *47CD786D0183_48D13B8D03A3_var*
//#UC END# *47CD786D0183_48D13B8D03A3_var*
begin
//#UC START# *47CD786D0183_48D13B8D03A3_impl*
 DoTextChange(aView, aPara, anOp);
//#UC END# *47CD786D0183_48D13B8D03A3_impl*
end;//TevControl.TextChange

function TevControl.GetHint(var aValue: Il3CString): Boolean;
 {* Вывод хинта на экран. Если данных нет, то возвращается False. }
//#UC START# *47CD788D010B_48D13B8D03A3_var*
var
 l_Req: IevReq;
//#UC END# *47CD788D010B_48D13B8D03A3_var*
begin
//#UC START# *47CD788D010B_48D13B8D03A3_impl*
 l_Req := Get_Req;
 if l_Req <> nil then 
  Result := Get_Req.GetHint(aValue, Self)
 else 
  Result := False; 
//#UC END# *47CD788D010B_48D13B8D03A3_impl*
end;//TevControl.GetHint

procedure TevControl.InsertRow(const aView: InevView);
 {* Событие добавления строки к таблице по 'Enter'. }
//#UC START# *47CD78A001D0_48D13B8D03A3_var*
//#UC END# *47CD78A001D0_48D13B8D03A3_var*
begin
//#UC START# *47CD78A001D0_48D13B8D03A3_impl*
 DoInsertRow(aView);
//#UC END# *47CD78A001D0_48D13B8D03A3_impl*
end;//TevControl.InsertRow

procedure TevControl.SetFocus(aChangePara: Boolean = False);
 {* Передать фокус контролу (выделить с помощью фокусной рамки. }
//#UC START# *47CD78AD0097_48D13B8D03A3_var*
var
 l_Control: InevControl;
//#UC END# *47CD78AD0097_48D13B8D03A3_var*
begin
//#UC START# *47CD78AD0097_48D13B8D03A3_impl*
 l_Control := Get_Req.QueryCard.Editor;
 if l_Control <> nil then 
 with l_Control do
  if (Selection <> nil) then
   Selection.SelectPoint(Para.MakePoint, False);
 Get_Req.QueryCard.RememberFocusControl(Self);
 Get_Req.QueryCard.RememberState(Self);
 if aChangePara then
  Get_Req.QueryCard.ChangePara(Para);
//#UC END# *47CD78AD0097_48D13B8D03A3_impl*
end;//TevControl.SetFocus

function TevControl.Get_Field: IevEditorControlField;
//#UC START# *47CD78CB0304_48D13B8D03A3get_var*
//#UC END# *47CD78CB0304_48D13B8D03A3get_var*
begin
//#UC START# *47CD78CB0304_48D13B8D03A3get_impl*
 Result := IevEditorControlField(f_Field);
//#UC END# *47CD78CB0304_48D13B8D03A3get_impl*
end;//TevControl.Get_Field

procedure TevControl.Set_Field(const aValue: IevEditorControlField);
//#UC START# *47CD78CB0304_48D13B8D03A3set_var*
//#UC END# *47CD78CB0304_48D13B8D03A3set_var*
begin
//#UC START# *47CD78CB0304_48D13B8D03A3set_impl*
 f_Field := Pointer(aValue);
//#UC END# *47CD78CB0304_48D13B8D03A3set_impl*
end;//TevControl.Set_Field

function TevControl.Get_Req: IevReq;
//#UC START# *47CD78FE0254_48D13B8D03A3get_var*
var
 l_Req : Tl3Variant;
//#UC END# *47CD78FE0254_48D13B8D03A3get_var*
begin
//#UC START# *47CD78FE0254_48D13B8D03A3get_impl*
 if evInPara(Para.AsObject, k2_typReqRow, l_Req) AND l_Req.IsValid then
 begin
  if not l_Req.QT(IevReq, Result) then
   Result := nil;
// - http://mdp.garant.ru/pages/viewpage.action?pageId=604485227
//   Assert(false, 'Тег ' + l_Req.TagType.AsString + ' не реализует IevReq');
 end//evInPara(Para, k2_idReqRow, l_Req) AND l_Req.IsValid
 else
  Result := nil;
//#UC END# *47CD78FE0254_48D13B8D03A3get_impl*
end;//TevControl.Get_Req

function TevControl.Get_Enabled: Boolean;
//#UC START# *47CD791D025D_48D13B8D03A3get_var*
//#UC END# *47CD791D025D_48D13B8D03A3get_var*
begin
//#UC START# *47CD791D025D_48D13B8D03A3get_impl*
 Result := Para.AsObject.BoolA[k2_tiEnabled];
//#UC END# *47CD791D025D_48D13B8D03A3get_impl*
end;//TevControl.Get_Enabled

procedure TevControl.Set_Enabled(aValue: Boolean);
//#UC START# *47CD791D025D_48D13B8D03A3set_var*
//#UC END# *47CD791D025D_48D13B8D03A3set_var*
begin
//#UC START# *47CD791D025D_48D13B8D03A3set_impl*
 Para.AsObject.BoolW[k2_tiEnabled, nil] := aValue;
//#UC END# *47CD791D025D_48D13B8D03A3set_impl*
end;//TevControl.Set_Enabled

function TevControl.Get_MaxLength: Integer;
//#UC START# *47CD792F0026_48D13B8D03A3get_var*
//#UC END# *47CD792F0026_48D13B8D03A3get_var*
begin
//#UC START# *47CD792F0026_48D13B8D03A3get_impl*
 Result := Para.AsObject.IntA[k2_tiMaxTextLength];
//#UC END# *47CD792F0026_48D13B8D03A3get_impl*
end;//TevControl.Get_MaxLength

function TevControl.Get_Caption: Il3CString;
//#UC START# *47CD9B8E0009_48D13B8D03A3get_var*
//#UC END# *47CD9B8E0009_48D13B8D03A3get_var*
begin
//#UC START# *47CD9B8E0009_48D13B8D03A3get_impl*
 if not Para.AsObject.Attr[k2_tiText].QI(Il3CString, Result) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=275780351
  Result := Tl3CEmptyString.Instance;
//#UC END# *47CD9B8E0009_48D13B8D03A3get_impl*
end;//TevControl.Get_Caption

constructor TevControl.Create(const aPara: InevPara);
//#UC START# *47CFE07602FE_48D13B8D03A3_var*
//#UC END# *47CFE07602FE_48D13B8D03A3_var*
begin
//#UC START# *47CFE07602FE_48D13B8D03A3_impl*
 inherited;
 aPara.AsObject.IntA[k2_tiModelControl] := Integer(IevEditorControl(Self));
//#UC END# *47CFE07602FE_48D13B8D03A3_impl*
end;//TevControl.Create

end.
