unit ListKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/ListKeywordsPack.pas"
// �����: 31.08.2009 20:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::WorkWithList::View::List::List$FP::ListKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� List
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  List_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  nscDocumentListTreeView
  {$If defined(Nemesis)}
  ,
  nscReminder
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscRemindersLine
  {$IfEnd} //Nemesis
  ,
  tfwPropertyLike,
  l3TreeInterfaces,
  bsTypes
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
  Tkw_Form_List = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� List
----
*������ �������������*:
[code]
'aControl' �����::List TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_List

// start class Tkw_Form_List

class function Tkw_Form_List.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::List';
end;//Tkw_Form_List.GetWordNameForRegister

function Tkw_Form_List.GetString: AnsiString;
 {-}
begin
 Result := 'efList';
end;//Tkw_Form_List.GetString

type
  Tkw_List_Control_RemindersLine = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� RemindersLine
----
*������ �������������*:
[code]
�������::RemindersLine TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_List_Control_RemindersLine

// start class Tkw_List_Control_RemindersLine

class function Tkw_List_Control_RemindersLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::RemindersLine';
end;//Tkw_List_Control_RemindersLine.GetWordNameForRegister

function Tkw_List_Control_RemindersLine.GetString: AnsiString;
 {-}
begin
 Result := 'RemindersLine';
end;//Tkw_List_Control_RemindersLine.GetString

class procedure Tkw_List_Control_RemindersLine.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscRemindersLine);
end;//Tkw_List_Control_RemindersLine.RegisterInEngine

type
  Tkw_List_Control_RemindersLine_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� RemindersLine
----
*������ �������������*:
[code]
�������::RemindersLine:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_List_Control_RemindersLine_Push

// start class Tkw_List_Control_RemindersLine_Push

procedure Tkw_List_Control_RemindersLine_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RemindersLine');
 inherited;
end;//Tkw_List_Control_RemindersLine_Push.DoDoIt

class function Tkw_List_Control_RemindersLine_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::RemindersLine:push';
end;//Tkw_List_Control_RemindersLine_Push.GetWordNameForRegister

type
  Tkw_List_Control_remListFiltered = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� remListFiltered
----
*������ �������������*:
[code]
�������::remListFiltered TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_List_Control_remListFiltered

// start class Tkw_List_Control_remListFiltered

class function Tkw_List_Control_remListFiltered.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::remListFiltered';
end;//Tkw_List_Control_remListFiltered.GetWordNameForRegister

function Tkw_List_Control_remListFiltered.GetString: AnsiString;
 {-}
begin
 Result := 'remListFiltered';
end;//Tkw_List_Control_remListFiltered.GetString

class procedure Tkw_List_Control_remListFiltered.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_List_Control_remListFiltered.RegisterInEngine

type
  Tkw_List_Control_remListFiltered_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� remListFiltered
----
*������ �������������*:
[code]
�������::remListFiltered:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_List_Control_remListFiltered_Push

// start class Tkw_List_Control_remListFiltered_Push

procedure Tkw_List_Control_remListFiltered_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('remListFiltered');
 inherited;
end;//Tkw_List_Control_remListFiltered_Push.DoDoIt

class function Tkw_List_Control_remListFiltered_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::remListFiltered:push';
end;//Tkw_List_Control_remListFiltered_Push.GetWordNameForRegister

type
  Tkw_List_Control_remListModified = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� remListModified
----
*������ �������������*:
[code]
�������::remListModified TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_List_Control_remListModified

// start class Tkw_List_Control_remListModified

class function Tkw_List_Control_remListModified.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::remListModified';
end;//Tkw_List_Control_remListModified.GetWordNameForRegister

function Tkw_List_Control_remListModified.GetString: AnsiString;
 {-}
begin
 Result := 'remListModified';
end;//Tkw_List_Control_remListModified.GetString

class procedure Tkw_List_Control_remListModified.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_List_Control_remListModified.RegisterInEngine

type
  Tkw_List_Control_remListModified_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� remListModified
----
*������ �������������*:
[code]
�������::remListModified:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_List_Control_remListModified_Push

// start class Tkw_List_Control_remListModified_Push

procedure Tkw_List_Control_remListModified_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('remListModified');
 inherited;
end;//Tkw_List_Control_remListModified_Push.DoDoIt

class function Tkw_List_Control_remListModified_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::remListModified:push';
end;//Tkw_List_Control_remListModified_Push.GetWordNameForRegister

type
  Tkw_List_Control_remTimeMachineWarning = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� remTimeMachineWarning
----
*������ �������������*:
[code]
�������::remTimeMachineWarning TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_List_Control_remTimeMachineWarning

// start class Tkw_List_Control_remTimeMachineWarning

class function Tkw_List_Control_remTimeMachineWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::remTimeMachineWarning';
end;//Tkw_List_Control_remTimeMachineWarning.GetWordNameForRegister

function Tkw_List_Control_remTimeMachineWarning.GetString: AnsiString;
 {-}
begin
 Result := 'remTimeMachineWarning';
end;//Tkw_List_Control_remTimeMachineWarning.GetString

class procedure Tkw_List_Control_remTimeMachineWarning.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscReminder);
end;//Tkw_List_Control_remTimeMachineWarning.RegisterInEngine

type
  Tkw_List_Control_remTimeMachineWarning_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� remTimeMachineWarning
----
*������ �������������*:
[code]
�������::remTimeMachineWarning:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_List_Control_remTimeMachineWarning_Push

// start class Tkw_List_Control_remTimeMachineWarning_Push

procedure Tkw_List_Control_remTimeMachineWarning_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('remTimeMachineWarning');
 inherited;
end;//Tkw_List_Control_remTimeMachineWarning_Push.DoDoIt

class function Tkw_List_Control_remTimeMachineWarning_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::remTimeMachineWarning:push';
end;//Tkw_List_Control_remTimeMachineWarning_Push.GetWordNameForRegister

type
  Tkw_List_Control_EmptyListEditor = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� EmptyListEditor
----
*������ �������������*:
[code]
�������::EmptyListEditor TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_List_Control_EmptyListEditor

// start class Tkw_List_Control_EmptyListEditor

class function Tkw_List_Control_EmptyListEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EmptyListEditor';
end;//Tkw_List_Control_EmptyListEditor.GetWordNameForRegister

function Tkw_List_Control_EmptyListEditor.GetString: AnsiString;
 {-}
begin
 Result := 'EmptyListEditor';
end;//Tkw_List_Control_EmptyListEditor.GetString

class procedure Tkw_List_Control_EmptyListEditor.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEditor);
end;//Tkw_List_Control_EmptyListEditor.RegisterInEngine

type
  Tkw_List_Control_EmptyListEditor_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� EmptyListEditor
----
*������ �������������*:
[code]
�������::EmptyListEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_List_Control_EmptyListEditor_Push

// start class Tkw_List_Control_EmptyListEditor_Push

procedure Tkw_List_Control_EmptyListEditor_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EmptyListEditor');
 inherited;
end;//Tkw_List_Control_EmptyListEditor_Push.DoDoIt

class function Tkw_List_Control_EmptyListEditor_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::EmptyListEditor:push';
end;//Tkw_List_Control_EmptyListEditor_Push.GetWordNameForRegister

type
  Tkw_List_Control_ListPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ListPanel
----
*������ �������������*:
[code]
�������::ListPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_List_Control_ListPanel

// start class Tkw_List_Control_ListPanel

class function Tkw_List_Control_ListPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ListPanel';
end;//Tkw_List_Control_ListPanel.GetWordNameForRegister

function Tkw_List_Control_ListPanel.GetString: AnsiString;
 {-}
begin
 Result := 'ListPanel';
end;//Tkw_List_Control_ListPanel.GetString

class procedure Tkw_List_Control_ListPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_List_Control_ListPanel.RegisterInEngine

type
  Tkw_List_Control_ListPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ListPanel
----
*������ �������������*:
[code]
�������::ListPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_List_Control_ListPanel_Push

// start class Tkw_List_Control_ListPanel_Push

procedure Tkw_List_Control_ListPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ListPanel');
 inherited;
end;//Tkw_List_Control_ListPanel_Push.DoDoIt

class function Tkw_List_Control_ListPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ListPanel:push';
end;//Tkw_List_Control_ListPanel_Push.GetWordNameForRegister

type
  Tkw_List_Control_tvList = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� tvList
----
*������ �������������*:
[code]
�������::tvList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_List_Control_tvList

// start class Tkw_List_Control_tvList

class function Tkw_List_Control_tvList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvList';
end;//Tkw_List_Control_tvList.GetWordNameForRegister

function Tkw_List_Control_tvList.GetString: AnsiString;
 {-}
begin
 Result := 'tvList';
end;//Tkw_List_Control_tvList.GetString

class procedure Tkw_List_Control_tvList.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscDocumentListTreeView);
end;//Tkw_List_Control_tvList.RegisterInEngine

type
  Tkw_List_Control_tvList_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� tvList
----
*������ �������������*:
[code]
�������::tvList:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_List_Control_tvList_Push

// start class Tkw_List_Control_tvList_Push

procedure Tkw_List_Control_tvList_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('tvList');
 inherited;
end;//Tkw_List_Control_tvList_Push.DoDoIt

class function Tkw_List_Control_tvList_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::tvList:push';
end;//Tkw_List_Control_tvList_Push.GetWordNameForRegister

type
  Tkw_List_Control_cfList = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� cfList
----
*������ �������������*:
[code]
�������::cfList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_List_Control_cfList

// start class Tkw_List_Control_cfList

class function Tkw_List_Control_cfList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::cfList';
end;//Tkw_List_Control_cfList.GetWordNameForRegister

function Tkw_List_Control_cfList.GetString: AnsiString;
 {-}
begin
 Result := 'cfList';
end;//Tkw_List_Control_cfList.GetString

class procedure Tkw_List_Control_cfList.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_List_Control_cfList.RegisterInEngine

type
  Tkw_List_Control_cfList_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� cfList
----
*������ �������������*:
[code]
�������::cfList:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_List_Control_cfList_Push

// start class Tkw_List_Control_cfList_Push

procedure Tkw_List_Control_cfList_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cfList');
 inherited;
end;//Tkw_List_Control_cfList_Push.DoDoIt

class function Tkw_List_Control_cfList_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::cfList:push';
end;//Tkw_List_Control_cfList_Push.GetWordNameForRegister

type
  TkwEfListRemindersLine = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefList.RemindersLine
[panel]������� RemindersLine ����� TefList[panel]
*��� ����������:* TnscRemindersLine
*������:*
[code]
OBJECT VAR l_TnscRemindersLine
 aefList .TefList.RemindersLine >>> l_TnscRemindersLine
[code]  }
  private
  // private methods
   function RemindersLine(const aCtx: TtfwContext;
     aefList: TefList): TnscRemindersLine;
     {* ���������� ����� ������� .TefList.RemindersLine }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListRemindersLine

// start class TkwEfListRemindersLine

function TkwEfListRemindersLine.RemindersLine(const aCtx: TtfwContext;
  aefList: TefList): TnscRemindersLine;
 {-}
begin
 Result := aefList.RemindersLine;
end;//TkwEfListRemindersLine.RemindersLine

procedure TkwEfListRemindersLine.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefList : TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RemindersLine(aCtx, l_aefList)));
end;//TkwEfListRemindersLine.DoDoIt

class function TkwEfListRemindersLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefList.RemindersLine';
end;//TkwEfListRemindersLine.GetWordNameForRegister

procedure TkwEfListRemindersLine.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� RemindersLine', aCtx);
end;//TkwEfListRemindersLine.SetValuePrim

function TkwEfListRemindersLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscRemindersLine);
end;//TkwEfListRemindersLine.GetResultTypeInfo

function TkwEfListRemindersLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListRemindersLine.GetAllParamsCount

function TkwEfListRemindersLine.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListRemindersLine.ParamsTypes

type
  TkwEfListRemListFiltered = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefList.remListFiltered
[panel]������� remListFiltered ����� TefList[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aefList .TefList.remListFiltered >>> l_TnscReminder
[code]  }
  private
  // private methods
   function RemListFiltered(const aCtx: TtfwContext;
     aefList: TefList): TnscReminder;
     {* ���������� ����� ������� .TefList.remListFiltered }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListRemListFiltered

// start class TkwEfListRemListFiltered

function TkwEfListRemListFiltered.RemListFiltered(const aCtx: TtfwContext;
  aefList: TefList): TnscReminder;
 {-}
begin
 Result := aefList.remListFiltered;
end;//TkwEfListRemListFiltered.RemListFiltered

procedure TkwEfListRemListFiltered.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefList : TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RemListFiltered(aCtx, l_aefList)));
end;//TkwEfListRemListFiltered.DoDoIt

class function TkwEfListRemListFiltered.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefList.remListFiltered';
end;//TkwEfListRemListFiltered.GetWordNameForRegister

procedure TkwEfListRemListFiltered.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� remListFiltered', aCtx);
end;//TkwEfListRemListFiltered.SetValuePrim

function TkwEfListRemListFiltered.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwEfListRemListFiltered.GetResultTypeInfo

function TkwEfListRemListFiltered.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListRemListFiltered.GetAllParamsCount

function TkwEfListRemListFiltered.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListRemListFiltered.ParamsTypes

type
  TkwEfListRemListModified = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefList.remListModified
[panel]������� remListModified ����� TefList[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aefList .TefList.remListModified >>> l_TnscReminder
[code]  }
  private
  // private methods
   function RemListModified(const aCtx: TtfwContext;
     aefList: TefList): TnscReminder;
     {* ���������� ����� ������� .TefList.remListModified }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListRemListModified

// start class TkwEfListRemListModified

function TkwEfListRemListModified.RemListModified(const aCtx: TtfwContext;
  aefList: TefList): TnscReminder;
 {-}
begin
 Result := aefList.remListModified;
end;//TkwEfListRemListModified.RemListModified

procedure TkwEfListRemListModified.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefList : TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RemListModified(aCtx, l_aefList)));
end;//TkwEfListRemListModified.DoDoIt

class function TkwEfListRemListModified.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefList.remListModified';
end;//TkwEfListRemListModified.GetWordNameForRegister

procedure TkwEfListRemListModified.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� remListModified', aCtx);
end;//TkwEfListRemListModified.SetValuePrim

function TkwEfListRemListModified.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwEfListRemListModified.GetResultTypeInfo

function TkwEfListRemListModified.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListRemListModified.GetAllParamsCount

function TkwEfListRemListModified.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListRemListModified.ParamsTypes

type
  TkwEfListRemTimeMachineWarning = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefList.remTimeMachineWarning
[panel]������� remTimeMachineWarning ����� TefList[panel]
*��� ����������:* TnscReminder
*������:*
[code]
OBJECT VAR l_TnscReminder
 aefList .TefList.remTimeMachineWarning >>> l_TnscReminder
[code]  }
  private
  // private methods
   function RemTimeMachineWarning(const aCtx: TtfwContext;
     aefList: TefList): TnscReminder;
     {* ���������� ����� ������� .TefList.remTimeMachineWarning }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListRemTimeMachineWarning

// start class TkwEfListRemTimeMachineWarning

function TkwEfListRemTimeMachineWarning.RemTimeMachineWarning(const aCtx: TtfwContext;
  aefList: TefList): TnscReminder;
 {-}
begin
 Result := aefList.remTimeMachineWarning;
end;//TkwEfListRemTimeMachineWarning.RemTimeMachineWarning

procedure TkwEfListRemTimeMachineWarning.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefList : TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RemTimeMachineWarning(aCtx, l_aefList)));
end;//TkwEfListRemTimeMachineWarning.DoDoIt

class function TkwEfListRemTimeMachineWarning.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefList.remTimeMachineWarning';
end;//TkwEfListRemTimeMachineWarning.GetWordNameForRegister

procedure TkwEfListRemTimeMachineWarning.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� remTimeMachineWarning', aCtx);
end;//TkwEfListRemTimeMachineWarning.SetValuePrim

function TkwEfListRemTimeMachineWarning.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscReminder);
end;//TkwEfListRemTimeMachineWarning.GetResultTypeInfo

function TkwEfListRemTimeMachineWarning.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListRemTimeMachineWarning.GetAllParamsCount

function TkwEfListRemTimeMachineWarning.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListRemTimeMachineWarning.ParamsTypes

type
  TkwEfListEmptyListEditor = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefList.EmptyListEditor
[panel]������� EmptyListEditor ����� TefList[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aefList .TefList.EmptyListEditor >>> l_TnscEditor
[code]  }
  private
  // private methods
   function EmptyListEditor(const aCtx: TtfwContext;
     aefList: TefList): TnscEditor;
     {* ���������� ����� ������� .TefList.EmptyListEditor }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListEmptyListEditor

// start class TkwEfListEmptyListEditor

function TkwEfListEmptyListEditor.EmptyListEditor(const aCtx: TtfwContext;
  aefList: TefList): TnscEditor;
 {-}
begin
 Result := aefList.EmptyListEditor;
end;//TkwEfListEmptyListEditor.EmptyListEditor

procedure TkwEfListEmptyListEditor.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefList : TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EmptyListEditor(aCtx, l_aefList)));
end;//TkwEfListEmptyListEditor.DoDoIt

class function TkwEfListEmptyListEditor.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefList.EmptyListEditor';
end;//TkwEfListEmptyListEditor.GetWordNameForRegister

procedure TkwEfListEmptyListEditor.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� EmptyListEditor', aCtx);
end;//TkwEfListEmptyListEditor.SetValuePrim

function TkwEfListEmptyListEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEditor);
end;//TkwEfListEmptyListEditor.GetResultTypeInfo

function TkwEfListEmptyListEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListEmptyListEditor.GetAllParamsCount

function TkwEfListEmptyListEditor.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListEmptyListEditor.ParamsTypes

type
  TkwEfListListPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefList.ListPanel
[panel]������� ListPanel ����� TefList[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefList .TefList.ListPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ListPanel(const aCtx: TtfwContext;
     aefList: TefList): TvtPanel;
     {* ���������� ����� ������� .TefList.ListPanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListListPanel

// start class TkwEfListListPanel

function TkwEfListListPanel.ListPanel(const aCtx: TtfwContext;
  aefList: TefList): TvtPanel;
 {-}
begin
 Result := aefList.ListPanel;
end;//TkwEfListListPanel.ListPanel

procedure TkwEfListListPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefList : TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ListPanel(aCtx, l_aefList)));
end;//TkwEfListListPanel.DoDoIt

class function TkwEfListListPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefList.ListPanel';
end;//TkwEfListListPanel.GetWordNameForRegister

procedure TkwEfListListPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ListPanel', aCtx);
end;//TkwEfListListPanel.SetValuePrim

function TkwEfListListPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfListListPanel.GetResultTypeInfo

function TkwEfListListPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListListPanel.GetAllParamsCount

function TkwEfListListPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListListPanel.ParamsTypes

type
  TkwEfListTvList = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefList.tvList
[panel]������� tvList ����� TefList[panel]
*��� ����������:* TnscDocumentListTreeView
*������:*
[code]
OBJECT VAR l_TnscDocumentListTreeView
 aefList .TefList.tvList >>> l_TnscDocumentListTreeView
[code]  }
  private
  // private methods
   function TvList(const aCtx: TtfwContext;
     aefList: TefList): TnscDocumentListTreeView;
     {* ���������� ����� ������� .TefList.tvList }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListTvList

// start class TkwEfListTvList

function TkwEfListTvList.TvList(const aCtx: TtfwContext;
  aefList: TefList): TnscDocumentListTreeView;
 {-}
begin
 Result := aefList.tvList;
end;//TkwEfListTvList.TvList

procedure TkwEfListTvList.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefList : TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TvList(aCtx, l_aefList)));
end;//TkwEfListTvList.DoDoIt

class function TkwEfListTvList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefList.tvList';
end;//TkwEfListTvList.GetWordNameForRegister

procedure TkwEfListTvList.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� tvList', aCtx);
end;//TkwEfListTvList.SetValuePrim

function TkwEfListTvList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscDocumentListTreeView);
end;//TkwEfListTvList.GetResultTypeInfo

function TkwEfListTvList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListTvList.GetAllParamsCount

function TkwEfListTvList.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListTvList.ParamsTypes

type
  TkwEfListCfList = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefList.cfList
[panel]������� cfList ����� TefList[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aefList .TefList.cfList >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function CfList(const aCtx: TtfwContext;
     aefList: TefList): TnscContextFilter;
     {* ���������� ����� ������� .TefList.cfList }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfListCfList

// start class TkwEfListCfList

function TkwEfListCfList.CfList(const aCtx: TtfwContext;
  aefList: TefList): TnscContextFilter;
 {-}
begin
 Result := aefList.cfList;
end;//TkwEfListCfList.CfList

procedure TkwEfListCfList.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefList : TefList;
begin
 try
  l_aefList := TefList(aCtx.rEngine.PopObjAs(TefList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefList: TefList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CfList(aCtx, l_aefList)));
end;//TkwEfListCfList.DoDoIt

class function TkwEfListCfList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefList.cfList';
end;//TkwEfListCfList.GetWordNameForRegister

procedure TkwEfListCfList.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� cfList', aCtx);
end;//TkwEfListCfList.SetValuePrim

function TkwEfListCfList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEfListCfList.GetResultTypeInfo

function TkwEfListCfList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfListCfList.GetAllParamsCount

function TkwEfListCfList.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefList)]);
end;//TkwEfListCfList.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_List
 Tkw_Form_List.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_RemindersLine
 Tkw_List_Control_RemindersLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_RemindersLine_Push
 Tkw_List_Control_RemindersLine_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_remListFiltered
 Tkw_List_Control_remListFiltered.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_remListFiltered_Push
 Tkw_List_Control_remListFiltered_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_remListModified
 Tkw_List_Control_remListModified.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_remListModified_Push
 Tkw_List_Control_remListModified_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_remTimeMachineWarning
 Tkw_List_Control_remTimeMachineWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_remTimeMachineWarning_Push
 Tkw_List_Control_remTimeMachineWarning_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_EmptyListEditor
 Tkw_List_Control_EmptyListEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_EmptyListEditor_Push
 Tkw_List_Control_EmptyListEditor_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_ListPanel
 Tkw_List_Control_ListPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_ListPanel_Push
 Tkw_List_Control_ListPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_tvList
 Tkw_List_Control_tvList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_tvList_Push
 Tkw_List_Control_tvList_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_cfList
 Tkw_List_Control_cfList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_List_Control_cfList_Push
 Tkw_List_Control_cfList_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efList_RemindersLine
 TkwEfListRemindersLine.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efList_remListFiltered
 TkwEfListRemListFiltered.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efList_remListModified
 TkwEfListRemListModified.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efList_remTimeMachineWarning
 TkwEfListRemTimeMachineWarning.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efList_EmptyListEditor
 TkwEfListEmptyListEditor.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efList_ListPanel
 TkwEfListListPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efList_tvList
 TkwEfListTvList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efList_cfList
 TkwEfListCfList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� List
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefList));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscRemindersLine
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscRemindersLine));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscReminder
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscReminder));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscDocumentListTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscDocumentListTreeView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscContextFilter
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.