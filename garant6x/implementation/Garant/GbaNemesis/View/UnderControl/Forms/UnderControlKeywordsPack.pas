unit UnderControlKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� UnderControl }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\UnderControlKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "UnderControlKeywordsPack" MUID: (4ABCD2D80364_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , UnderControl_Form
 , tfwControlString
 , kwBynameControlPush
 , tfwScriptingInterfaces
 , nscTreeViewWithAdapterDragDrop
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4ABCD2D80364_Packimpl_uses*
 //#UC END# *4ABCD2D80364_Packimpl_uses*
;

type
 Tkw_Form_UnderControl = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� UnderControl
----
*������ �������������*:
[code]�����::UnderControl TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_UnderControl

 Tkw_UnderControl_Control_UnderControlList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� UnderControlList
----
*������ �������������*:
[code]�������::UnderControlList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UnderControl_Control_UnderControlList

 Tkw_UnderControl_Control_UnderControlList_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� UnderControlList
----
*������ �������������*:
[code]�������::UnderControlList:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UnderControl_Control_UnderControlList_Push

function Tkw_Form_UnderControl.GetString: AnsiString;
begin
 Result := 'enUnderControl';
end;//Tkw_Form_UnderControl.GetString

class procedure Tkw_Form_UnderControl.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TenUnderControl);
end;//Tkw_Form_UnderControl.RegisterInEngine

class function Tkw_Form_UnderControl.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UnderControl';
end;//Tkw_Form_UnderControl.GetWordNameForRegister

function Tkw_UnderControl_Control_UnderControlList.GetString: AnsiString;
begin
 Result := 'UnderControlList';
end;//Tkw_UnderControl_Control_UnderControlList.GetString

class procedure Tkw_UnderControl_Control_UnderControlList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_UnderControl_Control_UnderControlList.RegisterInEngine

class function Tkw_UnderControl_Control_UnderControlList.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UnderControlList';
end;//Tkw_UnderControl_Control_UnderControlList.GetWordNameForRegister

procedure Tkw_UnderControl_Control_UnderControlList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('UnderControlList');
 inherited;
end;//Tkw_UnderControl_Control_UnderControlList_Push.DoDoIt

class function Tkw_UnderControl_Control_UnderControlList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::UnderControlList:push';
end;//Tkw_UnderControl_Control_UnderControlList_Push.GetWordNameForRegister

initialization
 Tkw_Form_UnderControl.RegisterInEngine;
 {* ����������� Tkw_Form_UnderControl }
 Tkw_UnderControl_Control_UnderControlList.RegisterInEngine;
 {* ����������� Tkw_UnderControl_Control_UnderControlList }
 Tkw_UnderControl_Control_UnderControlList_Push.RegisterInEngine;
 {* ����������� Tkw_UnderControl_Control_UnderControlList_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenUnderControl));
 {* ����������� ���� TenUnderControl }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
