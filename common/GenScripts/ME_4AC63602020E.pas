unit PrimDocNumberQuery_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimDocNumberQuery_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimDocNumberQuery" MUID: (4AC63602020E)
// ��� ����: "TPrimDocNumberQueryForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , NavigationInterfaces
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , vtCheckBox
 , l3Interfaces
;

type
 TPrimDocNumberQueryForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_Label1: TvtLabel;
    {* ���� ��� �������� Label1 }
   f_edNumber: TnscComboBox;
    {* ���� ��� �������� edNumber }
   f_cbInternal: TvtCheckBox;
    {* ���� ��� �������� cbInternal }
  protected
   f_Results: InsOpenDocOnNumberData;
  protected
   function Save: Boolean;
   procedure LoadHistory(const aHistory: Il3CString);
   procedure SaveHistory(aLastNumber: LongInt;
    var aHistory: AnsiString);
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   class function Make(const aData: InsOpenDocOnNumberData); reintroduce;
  public
   property Label1: TvtLabel
    read f_Label1;
    {* ����� ���������: }
   property edNumber: TnscComboBox
    read f_edNumber;
   property cbInternal: TvtCheckBox
    read f_cbInternal;
    {* ���������� ����� � ���� }
 end;//TPrimDocNumberQueryForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsUtils
 , nsTypes
 , SysUtils
 , bsTypesNew
 , l3String
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
const
 c_HistoryFormat = 'DDDDDDDDDD';
 c_HistoryCapacity = 10;

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
 // �������� ��������� � ���������� ��������
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

class function TPrimDocNumberQueryForm.Make(const aData: InsOpenDocOnNumberData);
var
 l_Inst : TPrimDocNumberQueryForm;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimDocNumberQueryForm.Make

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

procedure TPrimDocNumberQueryForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_4AC63602020E_var*
//#UC END# *49803F5503AA_4AC63602020E_var*
begin
//#UC START# *49803F5503AA_4AC63602020E_impl*
 inherited;
 Position := poScreenCenter;
//#UC END# *49803F5503AA_4AC63602020E_impl*
end;//TPrimDocNumberQueryForm.DoInit

procedure TPrimDocNumberQueryForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
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

procedure TPrimDocNumberQueryForm.ClearFields;
begin
 f_Results := nil;
 inherited;
end;//TPrimDocNumberQueryForm.ClearFields

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimDocNumberQueryForm);
 {* ����������� PrimDocNumberQuery }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
