unit UnderControlKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/UnderControl/UnderControlKeywordsPack.pas"
// �����: 29.10.2010 17:08
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ������ � ���������� � ������� ����������::UnderControl::View::UnderControl::UnderControl$FP::UnderControlKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� UnderControl
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
  UnderControl_Form
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  nscTreeViewWithAdapterDragDrop,
  TtfwClassRef_Proxy,
  tfwScriptingInterfaces,
  tfwScriptingTypes
  ;

type
  Tkw_Form_UnderControl = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� UnderControl
----
*������ �������������*:
[code]
'aControl' �����::UnderControl TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_UnderControl

// start class Tkw_Form_UnderControl

class function Tkw_Form_UnderControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::UnderControl';
end;//Tkw_Form_UnderControl.GetWordNameForRegister

function Tkw_Form_UnderControl.GetString: AnsiString;
 {-}
begin
 Result := 'enUnderControl';
end;//Tkw_Form_UnderControl.GetString

type
  Tkw_UnderControl_Control_UnderControlList = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� UnderControlList
----
*������ �������������*:
[code]
�������::UnderControlList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UnderControl_Control_UnderControlList

// start class Tkw_UnderControl_Control_UnderControlList

class function Tkw_UnderControl_Control_UnderControlList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::UnderControlList';
end;//Tkw_UnderControl_Control_UnderControlList.GetWordNameForRegister

function Tkw_UnderControl_Control_UnderControlList.GetString: AnsiString;
 {-}
begin
 Result := 'UnderControlList';
end;//Tkw_UnderControl_Control_UnderControlList.GetString

class procedure Tkw_UnderControl_Control_UnderControlList.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_UnderControl_Control_UnderControlList.RegisterInEngine

type
  Tkw_UnderControl_Control_UnderControlList_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� UnderControlList
----
*������ �������������*:
[code]
�������::UnderControlList:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UnderControl_Control_UnderControlList_Push

// start class Tkw_UnderControl_Control_UnderControlList_Push

procedure Tkw_UnderControl_Control_UnderControlList_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('UnderControlList');
 inherited;
end;//Tkw_UnderControl_Control_UnderControlList_Push.DoDoIt

class function Tkw_UnderControl_Control_UnderControlList_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::UnderControlList:push';
end;//Tkw_UnderControl_Control_UnderControlList_Push.GetWordNameForRegister
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_UnderControl
 Tkw_Form_UnderControl.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_UnderControl_Control_UnderControlList
 Tkw_UnderControl_Control_UnderControlList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_UnderControl_Control_UnderControlList_Push
 Tkw_UnderControl_Control_UnderControlList_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.