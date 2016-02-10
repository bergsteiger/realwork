unit ChatWindowKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ChatWindow }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\ChatWindowKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseChat_Module
 , vtProportionalPanel
 , vtSizeablePanel
 {$If Defined(Nemesis)}
 , nscChatMemo
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_ChatWindow = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ChatWindow
----
*������ �������������*:
[code]
'aControl' �����::ChatWindow TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ChatWindow

 Tkw_ChatWindow_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ChatWindow_Control_BackgroundPanel

 Tkw_ChatWindow_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_BackgroundPanel_Push

 Tkw_ChatWindow_Control_BottomPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BottomPanel
----
*������ �������������*:
[code]
�������::BottomPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ChatWindow_Control_BottomPanel

 Tkw_ChatWindow_Control_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BottomPanel
----
*������ �������������*:
[code]
�������::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_BottomPanel_Push

 Tkw_ChatWindow_Control_BottomEditor = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BottomEditor
----
*������ �������������*:
[code]
�������::BottomEditor TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ChatWindow_Control_BottomEditor

 Tkw_ChatWindow_Control_BottomEditor_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BottomEditor
----
*������ �������������*:
[code]
�������::BottomEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_BottomEditor_Push

 Tkw_ChatWindow_Control_TopPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TopPanel
----
*������ �������������*:
[code]
�������::TopPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ChatWindow_Control_TopPanel

 Tkw_ChatWindow_Control_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TopPanel
----
*������ �������������*:
[code]
�������::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_TopPanel_Push

 Tkw_ChatWindow_Control_HistoryEditor = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� HistoryEditor
----
*������ �������������*:
[code]
�������::HistoryEditor TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ChatWindow_Control_HistoryEditor

 Tkw_ChatWindow_Control_HistoryEditor_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HistoryEditor
----
*������ �������������*:
[code]
�������::HistoryEditor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ChatWindow_Control_HistoryEditor_Push

 TkwChatWindowFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TChatWindowForm.BackgroundPanel
[panel]������� BackgroundPanel ����� TChatWindowForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aChatWindowForm .TChatWindowForm.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TChatWindowForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChatWindowFormBackgroundPanel

 TkwChatWindowFormBottomPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TChatWindowForm.BottomPanel
[panel]������� BottomPanel ����� TChatWindowForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aChatWindowForm .TChatWindowForm.BottomPanel >>> l_TvtSizeablePanel
[code]  }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TChatWindowForm.BottomPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChatWindowFormBottomPanel

 TkwChatWindowFormBottomEditor = {final} class(TtfwPropertyLike)
  {* ����� ������� .TChatWindowForm.BottomEditor
[panel]������� BottomEditor ����� TChatWindowForm[panel]
*��� ����������:* TnscChatMemo
*������:*
[code]
OBJECT VAR l_TnscChatMemo
 aChatWindowForm .TChatWindowForm.BottomEditor >>> l_TnscChatMemo
[code]  }
  private
   function BottomEditor(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TnscChatMemo;
    {* ���������� ����� ������� .TChatWindowForm.BottomEditor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChatWindowFormBottomEditor

 TkwChatWindowFormTopPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TChatWindowForm.TopPanel
[panel]������� TopPanel ����� TChatWindowForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aChatWindowForm .TChatWindowForm.TopPanel >>> l_TvtPanel
[code]  }
  private
   function TopPanel(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TvtPanel;
    {* ���������� ����� ������� .TChatWindowForm.TopPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChatWindowFormTopPanel

 TkwChatWindowFormHistoryEditor = {final} class(TtfwPropertyLike)
  {* ����� ������� .TChatWindowForm.HistoryEditor
[panel]������� HistoryEditor ����� TChatWindowForm[panel]
*��� ����������:* TnscChatMemo
*������:*
[code]
OBJECT VAR l_TnscChatMemo
 aChatWindowForm .TChatWindowForm.HistoryEditor >>> l_TnscChatMemo
[code]  }
  private
   function HistoryEditor(const aCtx: TtfwContext;
    aChatWindowForm: TChatWindowForm): TnscChatMemo;
    {* ���������� ����� ������� .TChatWindowForm.HistoryEditor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChatWindowFormHistoryEditor

class function Tkw_Form_ChatWindow.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ChatWindow';
end;//Tkw_Form_ChatWindow.GetWordNameForRegister

function Tkw_Form_ChatWindow.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_88D90519F69F_var*
//#UC END# *4DDFD2EA0116_88D90519F69F_var*
begin
//#UC START# *4DDFD2EA0116_88D90519F69F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_88D90519F69F_impl*
end;//Tkw_Form_ChatWindow.GetString

class function Tkw_ChatWindow_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_ChatWindow_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_ChatWindow_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2D19DF3F2084_var*
//#UC END# *4DDFD2EA0116_2D19DF3F2084_var*
begin
//#UC START# *4DDFD2EA0116_2D19DF3F2084_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2D19DF3F2084_impl*
end;//Tkw_ChatWindow_Control_BackgroundPanel.GetString

class procedure Tkw_ChatWindow_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_2D19DF3F2084_var*
//#UC END# *52A086150180_2D19DF3F2084_var*
begin
//#UC START# *52A086150180_2D19DF3F2084_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2D19DF3F2084_impl*
end;//Tkw_ChatWindow_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_ChatWindow_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_33101E96BE4D_var*
//#UC END# *4DAEEDE10285_33101E96BE4D_var*
begin
//#UC START# *4DAEEDE10285_33101E96BE4D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_33101E96BE4D_impl*
end;//Tkw_ChatWindow_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_ChatWindow_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_ChatWindow_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_ChatWindow_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomPanel';
end;//Tkw_ChatWindow_Control_BottomPanel.GetWordNameForRegister

function Tkw_ChatWindow_Control_BottomPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6BC16C8C8A54_var*
//#UC END# *4DDFD2EA0116_6BC16C8C8A54_var*
begin
//#UC START# *4DDFD2EA0116_6BC16C8C8A54_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6BC16C8C8A54_impl*
end;//Tkw_ChatWindow_Control_BottomPanel.GetString

class procedure Tkw_ChatWindow_Control_BottomPanel.RegisterInEngine;
//#UC START# *52A086150180_6BC16C8C8A54_var*
//#UC END# *52A086150180_6BC16C8C8A54_var*
begin
//#UC START# *52A086150180_6BC16C8C8A54_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6BC16C8C8A54_impl*
end;//Tkw_ChatWindow_Control_BottomPanel.RegisterInEngine

procedure Tkw_ChatWindow_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5B68C8EDDA53_var*
//#UC END# *4DAEEDE10285_5B68C8EDDA53_var*
begin
//#UC START# *4DAEEDE10285_5B68C8EDDA53_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5B68C8EDDA53_impl*
end;//Tkw_ChatWindow_Control_BottomPanel_Push.DoDoIt

class function Tkw_ChatWindow_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomPanel:push';
end;//Tkw_ChatWindow_Control_BottomPanel_Push.GetWordNameForRegister

class function Tkw_ChatWindow_Control_BottomEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomEditor';
end;//Tkw_ChatWindow_Control_BottomEditor.GetWordNameForRegister

function Tkw_ChatWindow_Control_BottomEditor.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C2B976DA6A88_var*
//#UC END# *4DDFD2EA0116_C2B976DA6A88_var*
begin
//#UC START# *4DDFD2EA0116_C2B976DA6A88_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C2B976DA6A88_impl*
end;//Tkw_ChatWindow_Control_BottomEditor.GetString

class procedure Tkw_ChatWindow_Control_BottomEditor.RegisterInEngine;
//#UC START# *52A086150180_C2B976DA6A88_var*
//#UC END# *52A086150180_C2B976DA6A88_var*
begin
//#UC START# *52A086150180_C2B976DA6A88_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C2B976DA6A88_impl*
end;//Tkw_ChatWindow_Control_BottomEditor.RegisterInEngine

procedure Tkw_ChatWindow_Control_BottomEditor_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_630DFB965025_var*
//#UC END# *4DAEEDE10285_630DFB965025_var*
begin
//#UC START# *4DAEEDE10285_630DFB965025_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_630DFB965025_impl*
end;//Tkw_ChatWindow_Control_BottomEditor_Push.DoDoIt

class function Tkw_ChatWindow_Control_BottomEditor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BottomEditor:push';
end;//Tkw_ChatWindow_Control_BottomEditor_Push.GetWordNameForRegister

class function Tkw_ChatWindow_Control_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TopPanel';
end;//Tkw_ChatWindow_Control_TopPanel.GetWordNameForRegister

function Tkw_ChatWindow_Control_TopPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_37EF8F0FDA0E_var*
//#UC END# *4DDFD2EA0116_37EF8F0FDA0E_var*
begin
//#UC START# *4DDFD2EA0116_37EF8F0FDA0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_37EF8F0FDA0E_impl*
end;//Tkw_ChatWindow_Control_TopPanel.GetString

class procedure Tkw_ChatWindow_Control_TopPanel.RegisterInEngine;
//#UC START# *52A086150180_37EF8F0FDA0E_var*
//#UC END# *52A086150180_37EF8F0FDA0E_var*
begin
//#UC START# *52A086150180_37EF8F0FDA0E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_37EF8F0FDA0E_impl*
end;//Tkw_ChatWindow_Control_TopPanel.RegisterInEngine

procedure Tkw_ChatWindow_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B0CB3AF1B442_var*
//#UC END# *4DAEEDE10285_B0CB3AF1B442_var*
begin
//#UC START# *4DAEEDE10285_B0CB3AF1B442_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B0CB3AF1B442_impl*
end;//Tkw_ChatWindow_Control_TopPanel_Push.DoDoIt

class function Tkw_ChatWindow_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TopPanel:push';
end;//Tkw_ChatWindow_Control_TopPanel_Push.GetWordNameForRegister

class function Tkw_ChatWindow_Control_HistoryEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HistoryEditor';
end;//Tkw_ChatWindow_Control_HistoryEditor.GetWordNameForRegister

function Tkw_ChatWindow_Control_HistoryEditor.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_09895AAC4DF2_var*
//#UC END# *4DDFD2EA0116_09895AAC4DF2_var*
begin
//#UC START# *4DDFD2EA0116_09895AAC4DF2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_09895AAC4DF2_impl*
end;//Tkw_ChatWindow_Control_HistoryEditor.GetString

class procedure Tkw_ChatWindow_Control_HistoryEditor.RegisterInEngine;
//#UC START# *52A086150180_09895AAC4DF2_var*
//#UC END# *52A086150180_09895AAC4DF2_var*
begin
//#UC START# *52A086150180_09895AAC4DF2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_09895AAC4DF2_impl*
end;//Tkw_ChatWindow_Control_HistoryEditor.RegisterInEngine

procedure Tkw_ChatWindow_Control_HistoryEditor_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0F36F099F236_var*
//#UC END# *4DAEEDE10285_0F36F099F236_var*
begin
//#UC START# *4DAEEDE10285_0F36F099F236_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0F36F099F236_impl*
end;//Tkw_ChatWindow_Control_HistoryEditor_Push.DoDoIt

class function Tkw_ChatWindow_Control_HistoryEditor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HistoryEditor:push';
end;//Tkw_ChatWindow_Control_HistoryEditor_Push.GetWordNameForRegister

function TkwChatWindowFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TChatWindowForm.BackgroundPanel }
//#UC START# *05B3B214C8D1_82D5B8204902_var*
//#UC END# *05B3B214C8D1_82D5B8204902_var*
begin
//#UC START# *05B3B214C8D1_82D5B8204902_impl*
 !!! Needs to be implemented !!!
//#UC END# *05B3B214C8D1_82D5B8204902_impl*
end;//TkwChatWindowFormBackgroundPanel.BackgroundPanel

procedure TkwChatWindowFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_82D5B8204902_var*
//#UC END# *4DAEEDE10285_82D5B8204902_var*
begin
//#UC START# *4DAEEDE10285_82D5B8204902_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_82D5B8204902_impl*
end;//TkwChatWindowFormBackgroundPanel.DoDoIt

class function TkwChatWindowFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.BackgroundPanel';
end;//TkwChatWindowFormBackgroundPanel.GetWordNameForRegister

procedure TkwChatWindowFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_82D5B8204902_var*
//#UC END# *52D00B00031A_82D5B8204902_var*
begin
//#UC START# *52D00B00031A_82D5B8204902_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_82D5B8204902_impl*
end;//TkwChatWindowFormBackgroundPanel.SetValuePrim

function TkwChatWindowFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwChatWindowFormBackgroundPanel.GetResultTypeInfo

function TkwChatWindowFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormBackgroundPanel.GetAllParamsCount

function TkwChatWindowFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_82D5B8204902_var*
//#UC END# *5617F4D00243_82D5B8204902_var*
begin
//#UC START# *5617F4D00243_82D5B8204902_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_82D5B8204902_impl*
end;//TkwChatWindowFormBackgroundPanel.ParamsTypes

function TkwChatWindowFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TChatWindowForm.BottomPanel }
//#UC START# *DC5A020588E8_D5379CFED623_var*
//#UC END# *DC5A020588E8_D5379CFED623_var*
begin
//#UC START# *DC5A020588E8_D5379CFED623_impl*
 !!! Needs to be implemented !!!
//#UC END# *DC5A020588E8_D5379CFED623_impl*
end;//TkwChatWindowFormBottomPanel.BottomPanel

procedure TkwChatWindowFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D5379CFED623_var*
//#UC END# *4DAEEDE10285_D5379CFED623_var*
begin
//#UC START# *4DAEEDE10285_D5379CFED623_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D5379CFED623_impl*
end;//TkwChatWindowFormBottomPanel.DoDoIt

class function TkwChatWindowFormBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.BottomPanel';
end;//TkwChatWindowFormBottomPanel.GetWordNameForRegister

procedure TkwChatWindowFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D5379CFED623_var*
//#UC END# *52D00B00031A_D5379CFED623_var*
begin
//#UC START# *52D00B00031A_D5379CFED623_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D5379CFED623_impl*
end;//TkwChatWindowFormBottomPanel.SetValuePrim

function TkwChatWindowFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwChatWindowFormBottomPanel.GetResultTypeInfo

function TkwChatWindowFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormBottomPanel.GetAllParamsCount

function TkwChatWindowFormBottomPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D5379CFED623_var*
//#UC END# *5617F4D00243_D5379CFED623_var*
begin
//#UC START# *5617F4D00243_D5379CFED623_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D5379CFED623_impl*
end;//TkwChatWindowFormBottomPanel.ParamsTypes

function TkwChatWindowFormBottomEditor.BottomEditor(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TnscChatMemo;
 {* ���������� ����� ������� .TChatWindowForm.BottomEditor }
//#UC START# *F93287EDD337_3AAF433A3259_var*
//#UC END# *F93287EDD337_3AAF433A3259_var*
begin
//#UC START# *F93287EDD337_3AAF433A3259_impl*
 !!! Needs to be implemented !!!
//#UC END# *F93287EDD337_3AAF433A3259_impl*
end;//TkwChatWindowFormBottomEditor.BottomEditor

procedure TkwChatWindowFormBottomEditor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3AAF433A3259_var*
//#UC END# *4DAEEDE10285_3AAF433A3259_var*
begin
//#UC START# *4DAEEDE10285_3AAF433A3259_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3AAF433A3259_impl*
end;//TkwChatWindowFormBottomEditor.DoDoIt

class function TkwChatWindowFormBottomEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.BottomEditor';
end;//TkwChatWindowFormBottomEditor.GetWordNameForRegister

procedure TkwChatWindowFormBottomEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3AAF433A3259_var*
//#UC END# *52D00B00031A_3AAF433A3259_var*
begin
//#UC START# *52D00B00031A_3AAF433A3259_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3AAF433A3259_impl*
end;//TkwChatWindowFormBottomEditor.SetValuePrim

function TkwChatWindowFormBottomEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscChatMemo);
end;//TkwChatWindowFormBottomEditor.GetResultTypeInfo

function TkwChatWindowFormBottomEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormBottomEditor.GetAllParamsCount

function TkwChatWindowFormBottomEditor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3AAF433A3259_var*
//#UC END# *5617F4D00243_3AAF433A3259_var*
begin
//#UC START# *5617F4D00243_3AAF433A3259_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3AAF433A3259_impl*
end;//TkwChatWindowFormBottomEditor.ParamsTypes

function TkwChatWindowFormTopPanel.TopPanel(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TvtPanel;
 {* ���������� ����� ������� .TChatWindowForm.TopPanel }
//#UC START# *A50A29D9164A_D0DB504BE24E_var*
//#UC END# *A50A29D9164A_D0DB504BE24E_var*
begin
//#UC START# *A50A29D9164A_D0DB504BE24E_impl*
 !!! Needs to be implemented !!!
//#UC END# *A50A29D9164A_D0DB504BE24E_impl*
end;//TkwChatWindowFormTopPanel.TopPanel

procedure TkwChatWindowFormTopPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D0DB504BE24E_var*
//#UC END# *4DAEEDE10285_D0DB504BE24E_var*
begin
//#UC START# *4DAEEDE10285_D0DB504BE24E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D0DB504BE24E_impl*
end;//TkwChatWindowFormTopPanel.DoDoIt

class function TkwChatWindowFormTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.TopPanel';
end;//TkwChatWindowFormTopPanel.GetWordNameForRegister

procedure TkwChatWindowFormTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D0DB504BE24E_var*
//#UC END# *52D00B00031A_D0DB504BE24E_var*
begin
//#UC START# *52D00B00031A_D0DB504BE24E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D0DB504BE24E_impl*
end;//TkwChatWindowFormTopPanel.SetValuePrim

function TkwChatWindowFormTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwChatWindowFormTopPanel.GetResultTypeInfo

function TkwChatWindowFormTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormTopPanel.GetAllParamsCount

function TkwChatWindowFormTopPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D0DB504BE24E_var*
//#UC END# *5617F4D00243_D0DB504BE24E_var*
begin
//#UC START# *5617F4D00243_D0DB504BE24E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D0DB504BE24E_impl*
end;//TkwChatWindowFormTopPanel.ParamsTypes

function TkwChatWindowFormHistoryEditor.HistoryEditor(const aCtx: TtfwContext;
 aChatWindowForm: TChatWindowForm): TnscChatMemo;
 {* ���������� ����� ������� .TChatWindowForm.HistoryEditor }
//#UC START# *BF57BFCE9BB9_75D7C1A3BFCB_var*
//#UC END# *BF57BFCE9BB9_75D7C1A3BFCB_var*
begin
//#UC START# *BF57BFCE9BB9_75D7C1A3BFCB_impl*
 !!! Needs to be implemented !!!
//#UC END# *BF57BFCE9BB9_75D7C1A3BFCB_impl*
end;//TkwChatWindowFormHistoryEditor.HistoryEditor

procedure TkwChatWindowFormHistoryEditor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_75D7C1A3BFCB_var*
//#UC END# *4DAEEDE10285_75D7C1A3BFCB_var*
begin
//#UC START# *4DAEEDE10285_75D7C1A3BFCB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_75D7C1A3BFCB_impl*
end;//TkwChatWindowFormHistoryEditor.DoDoIt

class function TkwChatWindowFormHistoryEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChatWindowForm.HistoryEditor';
end;//TkwChatWindowFormHistoryEditor.GetWordNameForRegister

procedure TkwChatWindowFormHistoryEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_75D7C1A3BFCB_var*
//#UC END# *52D00B00031A_75D7C1A3BFCB_var*
begin
//#UC START# *52D00B00031A_75D7C1A3BFCB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_75D7C1A3BFCB_impl*
end;//TkwChatWindowFormHistoryEditor.SetValuePrim

function TkwChatWindowFormHistoryEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscChatMemo);
end;//TkwChatWindowFormHistoryEditor.GetResultTypeInfo

function TkwChatWindowFormHistoryEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChatWindowFormHistoryEditor.GetAllParamsCount

function TkwChatWindowFormHistoryEditor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_75D7C1A3BFCB_var*
//#UC END# *5617F4D00243_75D7C1A3BFCB_var*
begin
//#UC START# *5617F4D00243_75D7C1A3BFCB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_75D7C1A3BFCB_impl*
end;//TkwChatWindowFormHistoryEditor.ParamsTypes

initialization
 Tkw_Form_ChatWindow.RegisterInEngine;
 {* ����������� Tkw_Form_ChatWindow }
 Tkw_ChatWindow_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_BackgroundPanel }
 Tkw_ChatWindow_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_BackgroundPanel_Push }
 Tkw_ChatWindow_Control_BottomPanel.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_BottomPanel }
 Tkw_ChatWindow_Control_BottomPanel_Push.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_BottomPanel_Push }
 Tkw_ChatWindow_Control_BottomEditor.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_BottomEditor }
 Tkw_ChatWindow_Control_BottomEditor_Push.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_BottomEditor_Push }
 Tkw_ChatWindow_Control_TopPanel.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_TopPanel }
 Tkw_ChatWindow_Control_TopPanel_Push.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_TopPanel_Push }
 Tkw_ChatWindow_Control_HistoryEditor.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_HistoryEditor }
 Tkw_ChatWindow_Control_HistoryEditor_Push.RegisterInEngine;
 {* ����������� Tkw_ChatWindow_Control_HistoryEditor_Push }
 TkwChatWindowFormBackgroundPanel.RegisterInEngine;
 {* ����������� ChatWindowForm_BackgroundPanel }
 TkwChatWindowFormBottomPanel.RegisterInEngine;
 {* ����������� ChatWindowForm_BottomPanel }
 TkwChatWindowFormBottomEditor.RegisterInEngine;
 {* ����������� ChatWindowForm_BottomEditor }
 TkwChatWindowFormTopPanel.RegisterInEngine;
 {* ����������� ChatWindowForm_TopPanel }
 TkwChatWindowFormHistoryEditor.RegisterInEngine;
 {* ����������� ChatWindowForm_HistoryEditor }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChatWindowForm));
 {* ����������� ���� ChatWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscChatMemo));
 {* ����������� ���� TnscChatMemo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
