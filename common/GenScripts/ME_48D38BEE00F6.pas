unit evDropCalendarControl;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evDropCalendarControl.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evDropControl
 , evQueryCardInt
 , evQueryCardDropControlsInt
 , l3Interfaces
 , nevTools
 , nevBase
;

type
 TevDropCalendarControl = class(TevDropControl, IevEditorCalendarField, IevDropCalendar)
  private
   f_OtherField: Pointer;
    {* Ссылка на другое поле даты }
   f_IsStart: Boolean;
    {* Признак того, что дата задает начало интервала }
   f_Date: TDateTime;
    {* Дата в формате TDateTime, чтобы не делать лишние преобразования }
   f_MaskText: Il3CString;
  protected
   procedure CheckText(const Value: Il3CString);
    {* Аналог _TextChange, но для произвольной строки }
   procedure AnalyzeText;
    {* Расширение даты, если введены только день и месяц. }
   function IsBlank: Boolean;
    {* Поле пустое, т.е. равно шаблону. }
   procedure ClearField;
    {* Очищает только самое поле. ClearText - очищает оба поля сразу. }
   function IsStart: Boolean;
    {* Контрол хранит начальную дату интервала. }
   function GetOtherField: IevEditorCalendarField;
    {* Другой контрол. }
   procedure ApplyDate(Value: TDateTime);
    {* Передаёт выбранную дату в календарь. }
   procedure ChooseDate(Sender: TObject);
   procedure CancelDate(Sender: TObject);
   function Get_aDate: TDateTime;
   procedure Set_aDate(aValue: TDateTime);
   procedure DoDrop(const aPoint: TPoint;
    AInvert: Boolean;
    AWidth: Integer;
    ByUser: Boolean); override;
    {* Вываливает выпадающий виджет по указанным координатам }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoTextChange(const aView: InevView;
    const aPara: InevPara;
    const anOp: InevOp); override;
   procedure AfterSetText(const Value: Il3CString); override;
   function GetSelectAllOnFocus: Boolean; override;
   function GetIsClear: Boolean; override;
   procedure DoInitOtherField(const aValue: IevEditorControl;
    aIsStart: Boolean); override;
   procedure DoClearText; override;
   procedure DoCheckDataText; override;
   function DoAnalyzeString(const aValue: Il3CString;
    aPos: Integer;
    out aRslt: Il3CString): Boolean; override;
   function GetIsFieldEmpty: Boolean; override;
  public
   constructor Create(const aPara: InevPara); override;
 end;//TevDropCalendarControl

implementation

uses
 l3ImplUses
 , l3String
 , l3Date
 , l3Base
 , SysUtils
 , DateUtils
 , evControlParaTools
;

procedure TevDropCalendarControl.CheckText(const Value: Il3CString);
 {* Аналог _TextChange, но для произвольной строки }
//#UC START# *48D393020203_48D38BEE00F6_var*
var
 l_Correct: Boolean;
//#UC END# *48D393020203_48D38BEE00F6_var*
begin
//#UC START# *48D393020203_48D38BEE00F6_impl*
 l_Correct := TryStrToDate(l3Str(Value), f_Date);
 Set_Valid(l_Correct or IsBlank);
 if not l_Correct then 
  f_Date := NullDate;
//#UC END# *48D393020203_48D38BEE00F6_impl*
end;//TevDropCalendarControl.CheckText

procedure TevDropCalendarControl.AnalyzeText;
 {* Расширение даты, если введены только день и месяц. }
//#UC START# *47CD7E9202C3_48D38BEE00F6_var*
var
 l_Text  : string;
 l_Day   : Integer;
 l_Month : Integer;
 l_Date  : TDateTime;
//#UC END# *47CD7E9202C3_48D38BEE00F6_var*
begin
//#UC START# *47CD7E9202C3_48D38BEE00F6_impl*
 l_Text  := l3Str(Get_Caption);
 if TryStrToInt(Copy(l_Text, 1, 2), l_Day) and
   TryStrToInt(Copy(l_Text, 4, 2), l_Month) then
  if TryEncodeDate(YearOf(Date()), l_Month, l_Day, l_Date) then
   Set_aDate(l_Date);
//#UC END# *47CD7E9202C3_48D38BEE00F6_impl*
end;//TevDropCalendarControl.AnalyzeText

function TevDropCalendarControl.IsBlank: Boolean;
 {* Поле пустое, т.е. равно шаблону. }
//#UC START# *47CD7EA10137_48D38BEE00F6_var*
//#UC END# *47CD7EA10137_48D38BEE00F6_var*
begin
//#UC START# *47CD7EA10137_48D38BEE00F6_impl*
 Result := l3EmptyOrAllCharsInCharSet(l3PCharLen(Get_Caption), [' ', {$IfDef XE}FormatSettings.{$EndIf}DateSeparator]);
//#UC END# *47CD7EA10137_48D38BEE00F6_impl*
end;//TevDropCalendarControl.IsBlank

procedure TevDropCalendarControl.ClearField;
 {* Очищает только самое поле. ClearText - очищает оба поля сразу. }
//#UC START# *47CD7EB10267_48D38BEE00F6_var*
//#UC END# *47CD7EB10267_48D38BEE00F6_var*
begin
//#UC START# *47CD7EB10267_48D38BEE00F6_impl*
 SetText(f_MaskText);
 f_Date := NullDate;
//#UC END# *47CD7EB10267_48D38BEE00F6_impl*
end;//TevDropCalendarControl.ClearField

function TevDropCalendarControl.IsStart: Boolean;
 {* Контрол хранит начальную дату интервала. }
//#UC START# *47CD7EBD03AD_48D38BEE00F6_var*
//#UC END# *47CD7EBD03AD_48D38BEE00F6_var*
begin
//#UC START# *47CD7EBD03AD_48D38BEE00F6_impl*
 Result := f_IsStart;
//#UC END# *47CD7EBD03AD_48D38BEE00F6_impl*
end;//TevDropCalendarControl.IsStart

function TevDropCalendarControl.GetOtherField: IevEditorCalendarField;
 {* Другой контрол. }
//#UC START# *47CD7ECC0365_48D38BEE00F6_var*
//#UC END# *47CD7ECC0365_48D38BEE00F6_var*
begin
//#UC START# *47CD7ECC0365_48D38BEE00F6_impl*
 Result := IevEditorCalendarField(f_OtherField);
//#UC END# *47CD7ECC0365_48D38BEE00F6_impl*
end;//TevDropCalendarControl.GetOtherField

procedure TevDropCalendarControl.ApplyDate(Value: TDateTime);
 {* Передаёт выбранную дату в календарь. }
//#UC START# *47CEA11502B7_48D38BEE00F6_var*
//#UC END# *47CEA11502B7_48D38BEE00F6_var*
begin
//#UC START# *47CEA11502B7_48D38BEE00F6_impl*
 DropContainer.ApplyDate(Value);
//#UC END# *47CEA11502B7_48D38BEE00F6_impl*
end;//TevDropCalendarControl.ApplyDate

procedure TevDropCalendarControl.ChooseDate(Sender: TObject);
//#UC START# *47CEA18C01CD_48D38BEE00F6_var*
//#UC END# *47CEA18C01CD_48D38BEE00F6_var*
begin
//#UC START# *47CEA18C01CD_48D38BEE00F6_impl*
 DropContainer.ChooseDate(Sender);
//#UC END# *47CEA18C01CD_48D38BEE00F6_impl*
end;//TevDropCalendarControl.ChooseDate

procedure TevDropCalendarControl.CancelDate(Sender: TObject);
//#UC START# *47CEA19600DE_48D38BEE00F6_var*
//#UC END# *47CEA19600DE_48D38BEE00F6_var*
begin
//#UC START# *47CEA19600DE_48D38BEE00F6_impl*
 HideControl;
//#UC END# *47CEA19600DE_48D38BEE00F6_impl*
end;//TevDropCalendarControl.CancelDate

function TevDropCalendarControl.Get_aDate: TDateTime;
//#UC START# *47CEA19F031D_48D38BEE00F6get_var*
//#UC END# *47CEA19F031D_48D38BEE00F6get_var*
begin
//#UC START# *47CEA19F031D_48D38BEE00F6get_impl*
 Result := f_Date;
//#UC END# *47CEA19F031D_48D38BEE00F6get_impl*
end;//TevDropCalendarControl.Get_aDate

procedure TevDropCalendarControl.Set_aDate(aValue: TDateTime);
//#UC START# *47CEA19F031D_48D38BEE00F6set_var*
//#UC END# *47CEA19F031D_48D38BEE00F6set_var*
begin
//#UC START# *47CEA19F031D_48D38BEE00F6set_impl*
 f_Date := aValue;
 if f_Date <> NullDate then
  SetText(l3CStr(FormatDateTime(DropContainer.DateFormat, aValue)))
 else 
  SetText(f_MaskText);
//#UC END# *47CEA19F031D_48D38BEE00F6set_impl*
end;//TevDropCalendarControl.Set_aDate

procedure TevDropCalendarControl.DoDrop(const aPoint: TPoint;
 AInvert: Boolean;
 AWidth: Integer;
 ByUser: Boolean);
 {* Вываливает выпадающий виджет по указанным координатам }
//#UC START# *48D37D66029A_48D38BEE00F6_var*
//#UC END# *48D37D66029A_48D38BEE00F6_var*
begin
//#UC START# *48D37D66029A_48D38BEE00F6_impl*
 DropContainer.DoDrop(aPoint, AInvert, AWidth, ByUser);
//#UC END# *48D37D66029A_48D38BEE00F6_impl*
end;//TevDropCalendarControl.DoDrop

procedure TevDropCalendarControl.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48D38BEE00F6_var*
//#UC END# *479731C50290_48D38BEE00F6_var*
begin
//#UC START# *479731C50290_48D38BEE00F6_impl*
 f_MaskText := nil;
 f_OtherField := nil;
 inherited;
//#UC END# *479731C50290_48D38BEE00F6_impl*
end;//TevDropCalendarControl.Cleanup

constructor TevDropCalendarControl.Create(const aPara: InevPara);
//#UC START# *47CFE07602FE_48D38BEE00F6_var*
//#UC END# *47CFE07602FE_48D38BEE00F6_var*
begin
//#UC START# *47CFE07602FE_48D38BEE00F6_impl*
 inherited;
 f_Date := NullDate;
 f_MaskText := evMakeDateMaskText;
//#UC END# *47CFE07602FE_48D38BEE00F6_impl*
end;//TevDropCalendarControl.Create

procedure TevDropCalendarControl.DoTextChange(const aView: InevView;
 const aPara: InevPara;
 const anOp: InevOp);
//#UC START# *48D14C0E023E_48D38BEE00F6_var*
//#UC END# *48D14C0E023E_48D38BEE00F6_var*
begin
//#UC START# *48D14C0E023E_48D38BEE00F6_impl*
 CheckText(Get_Caption);
 inherited;
 //CheckText(Text);
//#UC END# *48D14C0E023E_48D38BEE00F6_impl*
end;//TevDropCalendarControl.DoTextChange

procedure TevDropCalendarControl.AfterSetText(const Value: Il3CString);
//#UC START# *48D247CA0077_48D38BEE00F6_var*
//#UC END# *48D247CA0077_48D38BEE00F6_var*
begin
//#UC START# *48D247CA0077_48D38BEE00F6_impl*
 CheckText(Value);
 inherited;
//#UC END# *48D247CA0077_48D38BEE00F6_impl*
end;//TevDropCalendarControl.AfterSetText

function TevDropCalendarControl.GetSelectAllOnFocus: Boolean;
//#UC START# *48D249F00054_48D38BEE00F6_var*
//#UC END# *48D249F00054_48D38BEE00F6_var*
begin
//#UC START# *48D249F00054_48D38BEE00F6_impl*
 Result := True;
//#UC END# *48D249F00054_48D38BEE00F6_impl*
end;//TevDropCalendarControl.GetSelectAllOnFocus

function TevDropCalendarControl.GetIsClear: Boolean;
//#UC START# *48D24A66039B_48D38BEE00F6_var*
//#UC END# *48D24A66039B_48D38BEE00F6_var*
begin
//#UC START# *48D24A66039B_48D38BEE00F6_impl*
 Result := IsFieldEmpty and IsBlank and GetOtherField.IsFieldEmpty 
   and GetOtherField.IsBlank;
//#UC END# *48D24A66039B_48D38BEE00F6_impl*
end;//TevDropCalendarControl.GetIsClear

procedure TevDropCalendarControl.DoInitOtherField(const aValue: IevEditorControl;
 aIsStart: Boolean);
//#UC START# *48D24AA202D1_48D38BEE00F6_var*
var
 l_Cal: IevEditorCalendarField; 
//#UC END# *48D24AA202D1_48D38BEE00F6_var*
begin
//#UC START# *48D24AA202D1_48D38BEE00F6_impl*
 inherited;
 if l3IOk(aValue.QueryInterface(IevEditorCalendarField, l_Cal)) then
 try
  f_OtherField := Pointer(l_Cal);
  if aIsStart then //чтобы не возникало бесконечных циклов 
   IevEditorCalendarField(f_OtherField).InitOtherField(Self, False);
  f_IsStart := aIsStart;
 finally
  l_Cal := nil;
 end;
//#UC END# *48D24AA202D1_48D38BEE00F6_impl*
end;//TevDropCalendarControl.DoInitOtherField

procedure TevDropCalendarControl.DoClearText;
//#UC START# *48D24C9F02F5_48D38BEE00F6_var*
var
 l_EditorDate: IevEditorCalendarField;
//#UC END# *48D24C9F02F5_48D38BEE00F6_var*
begin
//#UC START# *48D24C9F02F5_48D38BEE00F6_impl*
 SetText(f_MaskText);
 f_Date := NullDate;
 l_EditorDate := IevEditorCalendarField(f_OtherField);
 l_EditorDate.Text := f_MaskText;
 l_EditorDate.aDate := NullDate;
 Set_Valid(True);
//#UC END# *48D24C9F02F5_48D38BEE00F6_impl*
end;//TevDropCalendarControl.DoClearText

procedure TevDropCalendarControl.DoCheckDataText;
//#UC START# *48D24F2302F2_48D38BEE00F6_var*
//#UC END# *48D24F2302F2_48D38BEE00F6_var*
begin
//#UC START# *48D24F2302F2_48D38BEE00F6_impl*
 CheckText(Get_Caption);
//#UC END# *48D24F2302F2_48D38BEE00F6_impl*
end;//TevDropCalendarControl.DoCheckDataText

function TevDropCalendarControl.DoAnalyzeString(const aValue: Il3CString;
 aPos: Integer;
 out aRslt: Il3CString): Boolean;
//#UC START# *48D24F5F02BF_48D38BEE00F6_var*
//#UC END# *48D24F5F02BF_48D38BEE00F6_var*
begin
//#UC START# *48D24F5F02BF_48D38BEE00F6_impl*
 Result := True;
//#UC END# *48D24F5F02BF_48D38BEE00F6_impl*
end;//TevDropCalendarControl.DoAnalyzeString

function TevDropCalendarControl.GetIsFieldEmpty: Boolean;
//#UC START# *48D24FA901F4_48D38BEE00F6_var*
//#UC END# *48D24FA901F4_48D38BEE00F6_var*
begin
//#UC START# *48D24FA901F4_48D38BEE00F6_impl*
 Result := f_Date = NullDate;
//#UC END# *48D24FA901F4_48D38BEE00F6_impl*
end;//TevDropCalendarControl.GetIsFieldEmpty

end.
