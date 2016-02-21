unit evEditControl;
 {* Базовый класс поля редактора }

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evEditControl.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evControl
 , evQueryCardInt
 , evEditorControlList
 , l3Interfaces
 , nevTools
 , nevBase
;

type
 TevEditControl = class(TevControl, IevEditorControlField)
  {* Базовый класс поля редактора }
  private
   f_ChildList: TevEditorControlList;
    {* Список дочерних виджетов }
   f_ErrorColor: Boolean;
    {* Цвет ошибочного кода }
   f_IsOtherFieldInited: Boolean;
  protected
   procedure DoSynchronizeSelectedValueWithText; virtual;
   function GetHasOtherField: Boolean; virtual;
   procedure AfterSetText(const Value: Il3CString); virtual;
   function GetSelectAllOnFocus: Boolean; virtual;
   function GetIsClear: Boolean; virtual;
   procedure DoInitOtherField(const aValue: IevEditorControl;
    aIsStart: Boolean); virtual;
   procedure DoClearText; virtual;
   procedure DoCheckDataText; virtual;
   function DoAnalyzeString(const aValue: Il3CString;
    aPos: Integer;
    out aRslt: Il3CString): Boolean; virtual;
   function GetIsFieldEmpty: Boolean; virtual;
   procedure CheckDataText;
    {* Проверяет введенный текст на корректность. }
   function AnalyzeString(const aValue: Il3CString;
    aPos: Integer;
    out aRslt: Il3CString): Boolean;
    {* Анализ добавленной строки, если нужно, то убирает лишние символы или разбивает строку на несколько. }
   function IsClear: Boolean;
    {* Функция возвращает призна того, что поле пустое (вынесено специально 
          для обновления кнопок!). Для реквизитов дат проверяет оба поля дат! }
   procedure InitOtherField(const aValue: IevEditorControl;
    aIsStart: Boolean = True);
    {* Для реквизитов с двумя полями. Используется для полей дат. }
   function IsFieldEmpty: Boolean;
    {* Проверяет является ли поле пустым (или содержит значение по умолчанию). }
   function FindButton(aButtonType: TevButtonType): IevEditorControlButton;
    {* Возвращает кнопку для поля. }
   procedure ClearText;
    {* Очищает поле редактора. }
   function SelectAllOnFocus: Boolean;
    {* Надо ли выделять поле при фокусировании. }
   function Get_Text: Il3CString;
   procedure Set_Text(const aValue: Il3CString);
   function Get_ErrorColor: Boolean;
   procedure Set_ErrorColor(aValue: Boolean);
   function Get_Valid: Boolean;
   procedure Set_Valid(aValue: Boolean);
   function Get_ChildList: IevEditorControlList;
   function DoLMouseBtnUp(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState;
    anInPara: Boolean): Boolean; override;
   function DoLMouseBtnDown(const aView: InevControlView;
    const aTextPara: InevPara;
    const aPt: TnevPoint;
    const Keys: TevMouseState;
    anInPara: Boolean;
    const aMap: InevMap): Boolean; override;
   procedure SynchronizeSelectedValueWithText;
   function HasOtherField: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure SetText(const Value: Il3CString); override;
   procedure DoTextChange(const aView: InevView;
    const aPara: InevPara;
    const anOp: InevOp); override;
  public
   constructor Create(const aPara: InevPara); override;
 end;//TevEditControl

implementation

uses
 l3ImplUses
 , l3Base
 , l3String
 , k2Tags
 , l3Chars
 , SysUtils
;

procedure TevEditControl.DoSynchronizeSelectedValueWithText;
//#UC START# *4E93093B00C1_48D2409102B7_var*
//#UC END# *4E93093B00C1_48D2409102B7_var*
begin
//#UC START# *4E93093B00C1_48D2409102B7_impl*
 // - ничео не делаем
//#UC END# *4E93093B00C1_48D2409102B7_impl*
end;//TevEditControl.DoSynchronizeSelectedValueWithText

function TevEditControl.GetHasOtherField: Boolean;
//#UC START# *501686490090_48D2409102B7_var*
//#UC END# *501686490090_48D2409102B7_var*
begin
//#UC START# *501686490090_48D2409102B7_impl*
 Result := f_IsOtherFieldInited;
//#UC END# *501686490090_48D2409102B7_impl*
end;//TevEditControl.GetHasOtherField

procedure TevEditControl.AfterSetText(const Value: Il3CString);
//#UC START# *48D247CA0077_48D2409102B7_var*
//#UC END# *48D247CA0077_48D2409102B7_var*
begin
//#UC START# *48D247CA0077_48D2409102B7_impl*
 Get_Req.UpdateState(Self, nil);
//#UC END# *48D247CA0077_48D2409102B7_impl*
end;//TevEditControl.AfterSetText

function TevEditControl.GetSelectAllOnFocus: Boolean;
//#UC START# *48D249F00054_48D2409102B7_var*
//#UC END# *48D249F00054_48D2409102B7_var*
begin
//#UC START# *48D249F00054_48D2409102B7_impl*
 Result := not IsFieldEmpty;
//#UC END# *48D249F00054_48D2409102B7_impl*
end;//TevEditControl.GetSelectAllOnFocus

function TevEditControl.GetIsClear: Boolean;
//#UC START# *48D24A66039B_48D2409102B7_var*
//#UC END# *48D24A66039B_48D2409102B7_var*
begin
//#UC START# *48D24A66039B_48D2409102B7_impl*
 Result := IsFieldEmpty;
//#UC END# *48D24A66039B_48D2409102B7_impl*
end;//TevEditControl.GetIsClear

procedure TevEditControl.DoInitOtherField(const aValue: IevEditorControl;
 aIsStart: Boolean);
//#UC START# *48D24AA202D1_48D2409102B7_var*
//#UC END# *48D24AA202D1_48D2409102B7_var*
begin
//#UC START# *48D24AA202D1_48D2409102B7_impl*
//#UC END# *48D24AA202D1_48D2409102B7_impl*
end;//TevEditControl.DoInitOtherField

procedure TevEditControl.DoClearText;
//#UC START# *48D24C9F02F5_48D2409102B7_var*
//#UC END# *48D24C9F02F5_48D2409102B7_var*
begin
//#UC START# *48D24C9F02F5_48D2409102B7_impl*
 SetText(l3CStr(Get_Req.Para.Attr[k2_tiDefaultText].AsWStr));
 Set_Valid(True);
 Get_Req.CheckEdit(Self);
//#UC END# *48D24C9F02F5_48D2409102B7_impl*
end;//TevEditControl.DoClearText

procedure TevEditControl.DoCheckDataText;
//#UC START# *48D24F2302F2_48D2409102B7_var*
//#UC END# *48D24F2302F2_48D2409102B7_var*
begin
//#UC START# *48D24F2302F2_48D2409102B7_impl*
//#UC END# *48D24F2302F2_48D2409102B7_impl*
end;//TevEditControl.DoCheckDataText

function TevEditControl.DoAnalyzeString(const aValue: Il3CString;
 aPos: Integer;
 out aRslt: Il3CString): Boolean;
//#UC START# *48D24F5F02BF_48D2409102B7_var*
//#UC END# *48D24F5F02BF_48D2409102B7_var*
begin
//#UC START# *48D24F5F02BF_48D2409102B7_impl*
 Result := true;
//#UC END# *48D24F5F02BF_48D2409102B7_impl*
end;//TevEditControl.DoAnalyzeString

function TevEditControl.GetIsFieldEmpty: Boolean;
//#UC START# *48D24FA901F4_48D2409102B7_var*
//#UC END# *48D24FA901F4_48D2409102B7_var*
begin
//#UC START# *48D24FA901F4_48D2409102B7_impl*
 Result := l3EmptyOrAllCharsInCharSet(l3PCharLen(Get_Caption), cc_WhiteSpace);
//#UC END# *48D24FA901F4_48D2409102B7_impl*
end;//TevEditControl.GetIsFieldEmpty

procedure TevEditControl.CheckDataText;
 {* Проверяет введенный текст на корректность. }
//#UC START# *47CD7AC60335_48D2409102B7_var*
//#UC END# *47CD7AC60335_48D2409102B7_var*
begin
//#UC START# *47CD7AC60335_48D2409102B7_impl*
 DoCheckDataText;
//#UC END# *47CD7AC60335_48D2409102B7_impl*
end;//TevEditControl.CheckDataText

function TevEditControl.AnalyzeString(const aValue: Il3CString;
 aPos: Integer;
 out aRslt: Il3CString): Boolean;
 {* Анализ добавленной строки, если нужно, то убирает лишние символы или разбивает строку на несколько. }
//#UC START# *47CD7AD60335_48D2409102B7_var*
//#UC END# *47CD7AD60335_48D2409102B7_var*
begin
//#UC START# *47CD7AD60335_48D2409102B7_impl*
 Result := DoAnalyzeString(aValue, aPos, aRslt);
//#UC END# *47CD7AD60335_48D2409102B7_impl*
end;//TevEditControl.AnalyzeString

function TevEditControl.IsClear: Boolean;
 {* Функция возвращает призна того, что поле пустое (вынесено специально 
          для обновления кнопок!). Для реквизитов дат проверяет оба поля дат! }
//#UC START# *47CD7AFA0334_48D2409102B7_var*
//#UC END# *47CD7AFA0334_48D2409102B7_var*
begin
//#UC START# *47CD7AFA0334_48D2409102B7_impl*
 Result := GetIsClear;
//#UC END# *47CD7AFA0334_48D2409102B7_impl*
end;//TevEditControl.IsClear

procedure TevEditControl.InitOtherField(const aValue: IevEditorControl;
 aIsStart: Boolean = True);
 {* Для реквизитов с двумя полями. Используется для полей дат. }
//#UC START# *47CD7B0F0260_48D2409102B7_var*
//#UC END# *47CD7B0F0260_48D2409102B7_var*
begin
//#UC START# *47CD7B0F0260_48D2409102B7_impl*
 f_IsOtherFieldInited := True;
 DoInitOtherField(aValue, aIsStart);
//#UC END# *47CD7B0F0260_48D2409102B7_impl*
end;//TevEditControl.InitOtherField

function TevEditControl.IsFieldEmpty: Boolean;
 {* Проверяет является ли поле пустым (или содержит значение по умолчанию). }
//#UC START# *47CD7B23002F_48D2409102B7_var*
//#UC END# *47CD7B23002F_48D2409102B7_var*
begin
//#UC START# *47CD7B23002F_48D2409102B7_impl*
 Result := GetIsFieldEmpty;
//#UC END# *47CD7B23002F_48D2409102B7_impl*
end;//TevEditControl.IsFieldEmpty

function TevEditControl.FindButton(aButtonType: TevButtonType): IevEditorControlButton;
 {* Возвращает кнопку для поля. }
//#UC START# *47CD7B3301BA_48D2409102B7_var*
var
 i         : Integer;
 l_Count   : Integer;
 l_Control : IevEditorControlButton;
//#UC END# *47CD7B3301BA_48D2409102B7_var*
begin
//#UC START# *47CD7B3301BA_48D2409102B7_impl*
 Result := nil;
 l_Count := f_ChildList.Count - 1;
 for i := l_Count downto 0 do
  if Supports(f_ChildList[i], IevEditorControlButton, l_Control) then
  try
   if l_Control.GetButtonType = aButtonType then
   begin
    Result := l_Control;
    Break;
   end;
  finally
   l_Control := nil;
  end;   
//#UC END# *47CD7B3301BA_48D2409102B7_impl*
end;//TevEditControl.FindButton

procedure TevEditControl.ClearText;
 {* Очищает поле редактора. }
//#UC START# *47CD7B46001C_48D2409102B7_var*
//#UC END# *47CD7B46001C_48D2409102B7_var*
begin
//#UC START# *47CD7B46001C_48D2409102B7_impl*
 DoClearText;
//#UC END# *47CD7B46001C_48D2409102B7_impl*
end;//TevEditControl.ClearText

function TevEditControl.SelectAllOnFocus: Boolean;
 {* Надо ли выделять поле при фокусировании. }
//#UC START# *47CD7B5401A4_48D2409102B7_var*
//#UC END# *47CD7B5401A4_48D2409102B7_var*
begin
//#UC START# *47CD7B5401A4_48D2409102B7_impl*
 Result := GetSelectAllOnFocus;
//#UC END# *47CD7B5401A4_48D2409102B7_impl*
end;//TevEditControl.SelectAllOnFocus

function TevEditControl.Get_Text: Il3CString;
//#UC START# *47CD7B6E0380_48D2409102B7get_var*
//#UC END# *47CD7B6E0380_48D2409102B7get_var*
begin
//#UC START# *47CD7B6E0380_48D2409102B7get_impl*
 Result := Get_Caption;
//#UC END# *47CD7B6E0380_48D2409102B7get_impl*
end;//TevEditControl.Get_Text

procedure TevEditControl.Set_Text(const aValue: Il3CString);
//#UC START# *47CD7B6E0380_48D2409102B7set_var*
//#UC END# *47CD7B6E0380_48D2409102B7set_var*
begin
//#UC START# *47CD7B6E0380_48D2409102B7set_impl*
 SetText(aValue);
//#UC END# *47CD7B6E0380_48D2409102B7set_impl*
end;//TevEditControl.Set_Text

function TevEditControl.Get_ErrorColor: Boolean;
//#UC START# *47CD7C1F03E3_48D2409102B7get_var*
//#UC END# *47CD7C1F03E3_48D2409102B7get_var*
begin
//#UC START# *47CD7C1F03E3_48D2409102B7get_impl*
 Result := f_ErrorColor;
//#UC END# *47CD7C1F03E3_48D2409102B7get_impl*
end;//TevEditControl.Get_ErrorColor

procedure TevEditControl.Set_ErrorColor(aValue: Boolean);
//#UC START# *47CD7C1F03E3_48D2409102B7set_var*
//#UC END# *47CD7C1F03E3_48D2409102B7set_var*
begin
//#UC START# *47CD7C1F03E3_48D2409102B7set_impl*
 if f_ErrorColor <> aValue then
 begin
  f_ErrorColor := aValue;
  Set_Valid(not f_ErrorColor);
 end;
//#UC END# *47CD7C1F03E3_48D2409102B7set_impl*
end;//TevEditControl.Set_ErrorColor

function TevEditControl.Get_Valid: Boolean;
//#UC START# *47CD7C2E00E2_48D2409102B7get_var*
//#UC END# *47CD7C2E00E2_48D2409102B7get_var*
begin
//#UC START# *47CD7C2E00E2_48D2409102B7get_impl*
 Result := Para.AsObject.BoolA[k2_tiValid];
//#UC END# *47CD7C2E00E2_48D2409102B7get_impl*
end;//TevEditControl.Get_Valid

procedure TevEditControl.Set_Valid(aValue: Boolean);
//#UC START# *47CD7C2E00E2_48D2409102B7set_var*
//#UC END# *47CD7C2E00E2_48D2409102B7set_var*
begin
//#UC START# *47CD7C2E00E2_48D2409102B7set_impl*
 Para.AsObject.BoolA[k2_tiValid] := aValue;
//#UC END# *47CD7C2E00E2_48D2409102B7set_impl*
end;//TevEditControl.Set_Valid

function TevEditControl.Get_ChildList: IevEditorControlList;
//#UC START# *47CEBBC50272_48D2409102B7get_var*
//#UC END# *47CEBBC50272_48D2409102B7get_var*
begin
//#UC START# *47CEBBC50272_48D2409102B7get_impl*
 Result := f_ChildList;
//#UC END# *47CEBBC50272_48D2409102B7get_impl*
end;//TevEditControl.Get_ChildList

function TevEditControl.DoLMouseBtnUp(const aView: InevControlView;
 const aTextPara: InevPara;
 const aPt: TnevPoint;
 const Keys: TevMouseState;
 anInPara: Boolean): Boolean;
//#UC START# *48D1461101C6_48D2409102B7_var*
//#UC END# *48D1461101C6_48D2409102B7_var*
begin
//#UC START# *48D1461101C6_48D2409102B7_impl*
 Result := True;
//#UC END# *48D1461101C6_48D2409102B7_impl*
end;//TevEditControl.DoLMouseBtnUp

function TevEditControl.DoLMouseBtnDown(const aView: InevControlView;
 const aTextPara: InevPara;
 const aPt: TnevPoint;
 const Keys: TevMouseState;
 anInPara: Boolean;
 const aMap: InevMap): Boolean;
//#UC START# *48D1464501E8_48D2409102B7_var*
//#UC END# *48D1464501E8_48D2409102B7_var*
begin
//#UC START# *48D1464501E8_48D2409102B7_impl*
 Result := False;
//#UC END# *48D1464501E8_48D2409102B7_impl*
end;//TevEditControl.DoLMouseBtnDown

procedure TevEditControl.SynchronizeSelectedValueWithText;
//#UC START# *4E9308B7007B_48D2409102B7_var*
//#UC END# *4E9308B7007B_48D2409102B7_var*
begin
//#UC START# *4E9308B7007B_48D2409102B7_impl*
 DoSynchronizeSelectedValueWithText;
//#UC END# *4E9308B7007B_48D2409102B7_impl*
end;//TevEditControl.SynchronizeSelectedValueWithText

function TevEditControl.HasOtherField: Boolean;
//#UC START# *501685F70342_48D2409102B7_var*
//#UC END# *501685F70342_48D2409102B7_var*
begin
//#UC START# *501685F70342_48D2409102B7_impl*
 Result := GetHasOtherField;
//#UC END# *501685F70342_48D2409102B7_impl*
end;//TevEditControl.HasOtherField

procedure TevEditControl.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48D2409102B7_var*
//#UC END# *479731C50290_48D2409102B7_var*
begin
//#UC START# *479731C50290_48D2409102B7_impl*
 f_IsOtherFieldInited := False;
 l3Free(f_ChildList);
 inherited;
//#UC END# *479731C50290_48D2409102B7_impl*
end;//TevEditControl.Cleanup

constructor TevEditControl.Create(const aPara: InevPara);
//#UC START# *47CFE07602FE_48D2409102B7_var*
//#UC END# *47CFE07602FE_48D2409102B7_var*
begin
//#UC START# *47CFE07602FE_48D2409102B7_impl*
 inherited;
 f_ChildList := TevEditorControlList.Make;
//#UC END# *47CFE07602FE_48D2409102B7_impl*
end;//TevEditControl.Create

procedure TevEditControl.SetText(const Value: Il3CString);
//#UC START# *48D148F7020F_48D2409102B7_var*
var
 l_Req : IevReq;
 l_Value : Il3CString;
 l_Def : Tl3Variant;
//#UC END# *48D148F7020F_48D2409102B7_var*
begin
//#UC START# *48D148F7020F_48D2409102B7_impl*
 l_Value := Value;
 if l3IsNil(l_Value) then
 begin
  l_Req := Get_Req;
  if (l_Req <> nil) then
  begin
   l_Def := l_Req.Para.AsObject.Attr[k2_tiDefaultText];
   if l_Def.IsValid then
   begin
    l_Def := l_Def.CloneTag.AsObject;
    // - чтобы редактирование не испортило значение по-умолчанию
    if not l_Def.Box.QI(Il3CString, l_Value) then
     Assert(false);
   end;//l_Def.IsValid
  end;//l_Req <> nil
 end;//l3IsNil(l_Value)
 if not l3Same(l_Value, Get_Caption) then
 begin
  inherited;
  AfterSetText(l_Value);
 end//not l3Same
 else
 begin
  l_Req := Get_Req;
  if (l_Req <> nil) then
   l_Req.UpdateState(Self, nil);
 end;//not l3Same(l_Value, Get_Caption)
//#UC END# *48D148F7020F_48D2409102B7_impl*
end;//TevEditControl.SetText

procedure TevEditControl.DoTextChange(const aView: InevView;
 const aPara: InevPara;
 const anOp: InevOp);
//#UC START# *48D14C0E023E_48D2409102B7_var*
//#UC END# *48D14C0E023E_48D2409102B7_var*
begin
//#UC START# *48D14C0E023E_48D2409102B7_impl*
 Get_Req.UpdateState(Self, anOp);
 Get_Req.TextChange(aView); 
//#UC END# *48D14C0E023E_48D2409102B7_impl*
end;//TevEditControl.DoTextChange

end.
