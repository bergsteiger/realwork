unit CheckListBoxWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$VT"
// ������: "CheckListBoxWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VT::vtControlsFromStackWords::CheckListBoxWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces
  {$If not defined(NoVCL)}
  ,
  CheckLst
  {$IfEnd} //not NoVCL
  ,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopCheckListBoxGetChecked = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:CheckListBox:GetChecked
[panel]anIndex aCheckBoxList pop:CheckListBox:GetChecked
anIndex - ������ CheckBox'�
aCheckBoxList  - �������
���������� True, ���� ������� ������� � False - ���� ���.[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anIndex aCheckListBox pop:CheckListBox:GetChecked >>> l_Boolean
[code]  }
 private
 // private methods
   function GetChecked(const aCtx: TtfwContext;
    aCheckListBox: TCheckListBox;
    anIndex: Integer): Boolean;
     {* ���������� ����� ������� pop:CheckListBox:GetChecked }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCheckListBoxGetChecked

// start class TkwPopCheckListBoxGetChecked

function TkwPopCheckListBoxGetChecked.GetChecked(const aCtx: TtfwContext;
  aCheckListBox: TCheckListBox;
  anIndex: Integer): Boolean;
//#UC START# *5C7C4E6C6645_61EE94402745_var*
//#UC END# *5C7C4E6C6645_61EE94402745_var*
begin
//#UC START# *5C7C4E6C6645_61EE94402745_impl*
 Result := aCheckListBox.Checked[anIndex];
//#UC END# *5C7C4E6C6645_61EE94402745_impl*
end;//TkwPopCheckListBoxGetChecked.GetChecked

procedure TkwPopCheckListBoxGetChecked.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCheckListBox : TCheckListBox;
 l_anIndex : Integer;
begin
 try
  l_aCheckListBox := TCheckListBox(aCtx.rEngine.PopObjAs(TCheckListBox));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCheckListBox: TCheckListBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((GetChecked(aCtx, l_aCheckListBox, l_anIndex)));
end;//TkwPopCheckListBoxGetChecked.DoDoIt

class function TkwPopCheckListBoxGetChecked.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:CheckListBox:GetChecked';
end;//TkwPopCheckListBoxGetChecked.GetWordNameForRegister

function TkwPopCheckListBoxGetChecked.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopCheckListBoxGetChecked.GetResultTypeInfo

function TkwPopCheckListBoxGetChecked.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopCheckListBoxGetChecked.GetAllParamsCount

function TkwPopCheckListBoxGetChecked.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCheckListBox), TypeInfo(Integer)]);
end;//TkwPopCheckListBoxGetChecked.ParamsTypes

type
 TkwPopCheckListBoxSetChecked = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:CheckListBox:SetChecked
[panel]aValue anIndex aCheckBoxList pop:CheckListBox:SetChecked
anIndex - ������ CheckBox'�
aCheckBoxList  - �������
�������� �������, ���� aValue = True � ���������� �������, ���� aValue = False[panel]
*������:*
[code]
 aValue anIndex aCheckListBox pop:CheckListBox:SetChecked
[code]  }
 private
 // private methods
   procedure SetChecked(const aCtx: TtfwContext;
    aCheckListBox: TCheckListBox;
    anIndex: Integer;
    aValue: Boolean);
     {* ���������� ����� ������� pop:CheckListBox:SetChecked }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCheckListBoxSetChecked

// start class TkwPopCheckListBoxSetChecked

procedure TkwPopCheckListBoxSetChecked.SetChecked(const aCtx: TtfwContext;
  aCheckListBox: TCheckListBox;
  anIndex: Integer;
  aValue: Boolean);
//#UC START# *AEDB5415872F_CA2863D28A34_var*
//#UC END# *AEDB5415872F_CA2863D28A34_var*
begin
//#UC START# *AEDB5415872F_CA2863D28A34_impl*
 aCheckListBox.Checked[anIndex] := aValue;
//#UC END# *AEDB5415872F_CA2863D28A34_impl*
end;//TkwPopCheckListBoxSetChecked.SetChecked

procedure TkwPopCheckListBoxSetChecked.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCheckListBox : TCheckListBox;
 l_anIndex : Integer;
 l_aValue : Boolean;
begin
 try
  l_aCheckListBox := TCheckListBox(aCtx.rEngine.PopObjAs(TCheckListBox));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCheckListBox: TCheckListBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetChecked(aCtx, l_aCheckListBox, l_anIndex, l_aValue);
end;//TkwPopCheckListBoxSetChecked.DoDoIt

class function TkwPopCheckListBoxSetChecked.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:CheckListBox:SetChecked';
end;//TkwPopCheckListBoxSetChecked.GetWordNameForRegister

function TkwPopCheckListBoxSetChecked.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopCheckListBoxSetChecked.GetResultTypeInfo

function TkwPopCheckListBoxSetChecked.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2 + 1;
end;//TkwPopCheckListBoxSetChecked.GetAllParamsCount

function TkwPopCheckListBoxSetChecked.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCheckListBox), TypeInfo(Integer), TypeInfo(Boolean)]);
end;//TkwPopCheckListBoxSetChecked.ParamsTypes

type
 TkwPopCheckListBoxUncheckAll = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:CheckListBox:UncheckAll
[panel]aCheckBoxList pop:CheckListBox:UncheckAll
��������� ������� � ���� ������� ��������.[panel]
*������:*
[code]
 aCheckListBox pop:CheckListBox:UncheckAll
[code]  }
 private
 // private methods
   procedure UncheckAll(const aCtx: TtfwContext;
    aCheckListBox: TCheckListBox);
     {* ���������� ����� ������� pop:CheckListBox:UncheckAll }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCheckListBoxUncheckAll

// start class TkwPopCheckListBoxUncheckAll

procedure TkwPopCheckListBoxUncheckAll.UncheckAll(const aCtx: TtfwContext;
  aCheckListBox: TCheckListBox);
//#UC START# *9D7C5A3CC63F_CC902BB857AE_var*
var
 i: Integer;
//#UC END# *9D7C5A3CC63F_CC902BB857AE_var*
begin
//#UC START# *9D7C5A3CC63F_CC902BB857AE_impl*
 for i := 0 to aCheckListBox.Count - 1 do
  aCheckListBox.Checked[i] := False;
//#UC END# *9D7C5A3CC63F_CC902BB857AE_impl*
end;//TkwPopCheckListBoxUncheckAll.UncheckAll

procedure TkwPopCheckListBoxUncheckAll.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCheckListBox : TCheckListBox;
begin
 try
  l_aCheckListBox := TCheckListBox(aCtx.rEngine.PopObjAs(TCheckListBox));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCheckListBox: TCheckListBox : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 UncheckAll(aCtx, l_aCheckListBox);
end;//TkwPopCheckListBoxUncheckAll.DoDoIt

class function TkwPopCheckListBoxUncheckAll.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:CheckListBox:UncheckAll';
end;//TkwPopCheckListBoxUncheckAll.GetWordNameForRegister

function TkwPopCheckListBoxUncheckAll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopCheckListBoxUncheckAll.GetResultTypeInfo

function TkwPopCheckListBoxUncheckAll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopCheckListBoxUncheckAll.GetAllParamsCount

function TkwPopCheckListBoxUncheckAll.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TCheckListBox)]);
end;//TkwPopCheckListBoxUncheckAll.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_CheckListBox_GetChecked
 TkwPopCheckListBoxGetChecked.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_CheckListBox_SetChecked
 TkwPopCheckListBoxSetChecked.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_CheckListBox_UncheckAll
 TkwPopCheckListBoxUncheckAll.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TCheckListBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCheckListBox));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts

end.