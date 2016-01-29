unit PrimDocNumberQuery_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimDocNumberQuery_Form.pas"
// Начат: 02.10.2009 21:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Работа с документом и списком документов::Document::View::OpenDocumentByNumber::PrimDocNumberQuery
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
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  NavigationInterfaces,
  vtLabel,
  vtCheckBox,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmBase {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimDocNumberQueryForm = {form} class(TvcmEntityForm)
 private
 // private fields
   f_Label1 : TvtLabel;
    {* Поле для свойства Label1}
   f_edNumber : TnscComboBox;
    {* Поле для свойства edNumber}
   f_cbInternal : TvtCheckBox;
    {* Поле для свойства cbInternal}
 protected
  procedure MakeControls; override;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected fields
   f_Results : InsOpenDocOnNumberData;
 protected
 // protected methods
   function Save: Boolean;
   procedure LoadHistory(const aHistory: Il3CString);
   procedure SaveHistory(aLastNumber: LongInt;
     var aHistory: AnsiString);
 public
 // public methods
   class function Make(const aData: InsOpenDocOnNumberData;
     const aParams : IvcmMakeParams = nil;
     aZoneType     : TvcmZoneType = vcm_ztAny;
     aUserType     : TvcmEffectiveUserType = 0;
     aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm; reintroduce;
 public
 // public properties
   property Label1: TvtLabel
     read f_Label1;
     {* Номер документа: }
   property edNumber: TnscComboBox
     read f_edNumber;
   property cbInternal: TvtCheckBox
     read f_cbInternal;
     {* Внутренний номер в базе }
 end;//TPrimDocNumberQueryForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsUtils,
  nsTypes,
  SysUtils,
  bsTypesNew,
  l3String
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a},
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

const
   { DocNumberQuery Const }
  c_HistoryFormat = 'DDDDDDDDDD';
  c_HistoryCapacity = 10;

// start class TPrimDocNumberQueryForm

function TPrimDocNumberQueryForm.Save: Boolean;
//#UC START# *4C863FCD0121_4AC63602020E_var*
var
 l_DocId   : Integer;
 l_PosId   : Integer;
 l_PosType : TDocumentPositionType;
 l_Wrong   : Boolean;
 l_History : String;
//#UC END# *4C863FCD0121_4AC63602020E_var*
begin
//#UC START# *4C863FCD0121_4AC63602020E_impl*
 Result := false;
 nsParseDocumentNumber(edNumber.Text, l_DocId, l_PosId, l_PosType, l_Wrong);
 if l_Wrong then
 begin
  Say(msg_WrongDocumentNumber);
  edNumber.SetFocus;
  Exit;
 end;//l_Wrong
 SaveHistory(l_DocId, l_History);
 // Передаем результат в вызывающую операцию
 if (f_Results <> nil) then
 begin
  f_Results.Done := true;
  f_Results.DocID := l_DocId;
  f_Results.PosID := l_PosID;
  f_Results.PosType := l_PosType;
  f_Results.Internal := cbInternal.Checked;
  f_Results.History := nsCStr(l_History);
 end;//f_Results <> nil
 Result := true;
//#UC END# *4C863FCD0121_4AC63602020E_impl*
end;//TPrimDocNumberQueryForm.Save

procedure TPrimDocNumberQueryForm.LoadHistory(const aHistory: Il3CString);
//#UC START# *51B9E1A00192_4AC63602020E_var*
var
 l_DocNumberHistory: packed array [0..c_HistoryCapacity-1] of Longint;
 I: LongInt;
//#UC END# *51B9E1A00192_4AC63602020E_var*
begin
//#UC START# *51B9E1A00192_4AC63602020E_impl*
 if not l3IsNil(aHistory) then
 begin
  l3FormatStringToRec(l3Str(aHistory), l_DocNumberHistory, c_HistoryFormat);
  for I := 0 to c_HistoryCapacity - 1 do
   if (l_DocNumberHistory[I] <> 0) then
    edNumber.Items.Add(IntToStr(l_DocNumberHistory[I]));
 end;//aHistory <> ''
//#UC END# *51B9E1A00192_4AC63602020E_impl*
end;//TPrimDocNumberQueryForm.LoadHistory

class function TPrimDocNumberQueryForm.Make(const aData: InsOpenDocOnNumberData;
  const aParams : IvcmMakeParams = nil;
  aZoneType     : TvcmZoneType = vcm_ztAny;
  aUserType     : TvcmEffectiveUserType = 0;
  aDataSource   : IvcmFormDataSource = nil): IvcmEntityForm;

 procedure AfterCreate(aForm : TPrimDocNumberQueryForm);
 begin
  with aForm do
  begin
//#UC START# *51B9E27000CD_4AC63602020E_impl*
   if (aData.PosID <> 0) then
   begin
    case aData.PosType of
     dptSub:  edNumber.Text := nsCStr(IntToStr(aData.DocID) + cPosDelimiter + IntToStr(aData.PosID));
     dptPara: edNumber.Text := nsCStr(IntToStr(aData.DocID) + cPosDelimiter + cParaPrefix + IntToStr(aData.PosID));
     dptNone,
     dptMarker,
     dptBookmark,
     dptMark,
     dptDocumentPlace: edNumber.Text := nsCStr(IntToStr(aData.DocID));
    end;
   end
   else
    edNumber.Text := nsCStr(IntToStr(aData.DocID));
   cbInternal.Checked := aData.Internal;
   LoadHistory(aData.History);
   f_Results := aData;
//#UC END# *51B9E27000CD_4AC63602020E_impl*
  end;//with aForm
 end;

var
 l_AC : TvcmInitProc;
 l_ACHack : Pointer absolute l_AC;
begin
 l_AC := l3LocalStub(@AfterCreate);
 try
  Result := inherited Make(aParams, aZoneType, aUserType, nil, aDataSource, vcm_utAny, l_AC);
 finally
  l3FreeLocalStub(l_ACHack);
 end;//try..finally
end;

procedure TPrimDocNumberQueryForm.SaveHistory(aLastNumber: LongInt;
  var aHistory: AnsiString);
//#UC START# *51B9E2AC030D_4AC63602020E_var*
var
 l_DocNumberHistory: packed array [0..c_HistoryCapacity-1] of Longint;
 l_tmpNum,
 l_ArrayPos,
 I: LongInt;
//#UC END# *51B9E2AC030D_4AC63602020E_var*
begin
//#UC START# *51B9E2AC030D_4AC63602020E_impl*
 l3FillChar(l_DocNumberHistory, SizeOf(l_DocNumberHistory));
 l_ArrayPos := 0;

 l_DocNumberHistory[l_ArrayPos] := aLastNumber;
 inc(l_ArrayPos);

 for I := 0 to edNumber.Items.Count - 1 do
  if l_ArrayPos < c_HistoryCapacity then
  begin
   l_tmpNum := StrToInt(edNumber.Items[I].AsString);
   if l_tmpNum <> aLastNumber then
   begin
    l_DocNumberHistory[l_ArrayPos] := l_tmpNum;
    inc(l_ArrayPos);
   end;
  end;

 aHistory := l3RecToFormatString(l_DocNumberHistory, c_HistoryFormat);
//#UC END# *51B9E2AC030D_4AC63602020E_impl*
end;//TPrimDocNumberQueryForm.SaveHistory

{$If not defined(NoVCM)}
procedure TPrimDocNumberQueryForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4AC63602020E_var*
//#UC END# *49803F5503AA_4AC63602020E_var*
begin
//#UC START# *49803F5503AA_4AC63602020E_impl*
 inherited;
 Position := poScreenCenter;
//#UC END# *49803F5503AA_4AC63602020E_impl*
end;//TPrimDocNumberQueryForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimDocNumberQueryForm.InitControls;
//#UC START# *4A8E8F2E0195_4AC63602020E_var*
//#UC END# *4A8E8F2E0195_4AC63602020E_var*
begin
//#UC START# *4A8E8F2E0195_4AC63602020E_impl*
 inherited;

 BorderIcons := [biSystemMenu];
 BorderStyle := bsDialog;
 ClientHeight := 56;
 ClientWidth := 279;

 with Label1 do
 begin
  Left := 8;
  Top := 11;
  AutoSize := False;
  Width := 110;
  Height := 16;
 end;
 with edNumber do
 begin
  Left := 120;
  Top := 8;
  Width := 153;
  Height := 21;
  TabOrder := 0;
 end;
 with cbInternal do
 begin
  Left := 8;
  Top := 34;
  Width := 265;
  Height := 17;
  TabOrder := 1;
 end;
//#UC END# *4A8E8F2E0195_4AC63602020E_impl*
end;//TPrimDocNumberQueryForm.InitControls
{$IfEnd} //not NoVCM

procedure TPrimDocNumberQueryForm.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Results := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TPrimDocNumberQueryForm.ClearFields

procedure TPrimDocNumberQueryForm.MakeControls;
begin
 inherited;
 f_Label1 := TvtLabel.Create(Self);
 f_Label1.Name := 'Label1';
 f_Label1.Parent := Self;
 f_Label1.Caption := 'Номер документа:';
 f_edNumber := TnscComboBox.Create(Self);
 f_edNumber.Name := 'edNumber';
 f_edNumber.Parent := Self;
 f_cbInternal := TvtCheckBox.Create(Self);
 f_cbInternal.Name := 'cbInternal';
 f_cbInternal.Parent := Self;
 f_cbInternal.Caption := 'Внутренний номер в базе';
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimDocNumberQuery
 TtfwClassRef.Register(TPrimDocNumberQueryForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.