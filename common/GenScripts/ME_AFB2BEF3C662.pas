unit DictionKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Diction }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\DictionKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Diction_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
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
 Tkw_Form_Diction = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Diction
----
*������ �������������*:
[code]
'aControl' �����::Diction TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Diction

 Tkw_Diction_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_Diction_Control_BackgroundPanel

 Tkw_Diction_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_BackgroundPanel_Push

 Tkw_Diction_Control_ContextFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Diction_Control_ContextFilter

 Tkw_Diction_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_ContextFilter_Push

 Tkw_Diction_Control_WordsTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WordsTree
----
*������ �������������*:
[code]
�������::WordsTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Diction_Control_WordsTree

 Tkw_Diction_Control_WordsTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WordsTree
----
*������ �������������*:
[code]
�������::WordsTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_WordsTree_Push

 TkwEnDictionBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenDiction.BackgroundPanel
[panel]������� BackgroundPanel ����� TenDiction[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aenDiction .TenDiction.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aenDiction: TenDiction): TvtPanel;
    {* ���������� ����� ������� .TenDiction.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDictionBackgroundPanel

 TkwEnDictionContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenDiction.ContextFilter
[panel]������� ContextFilter ����� TenDiction[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aenDiction .TenDiction.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aenDiction: TenDiction): TnscContextFilter;
    {* ���������� ����� ������� .TenDiction.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDictionContextFilter

 TkwEnDictionWordsTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenDiction.WordsTree
[panel]������� WordsTree ����� TenDiction[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenDiction .TenDiction.WordsTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function WordsTree(const aCtx: TtfwContext;
    aenDiction: TenDiction): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TenDiction.WordsTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDictionWordsTree

class function Tkw_Form_Diction.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Diction';
end;//Tkw_Form_Diction.GetWordNameForRegister

function Tkw_Form_Diction.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_13CB70E95F1B_var*
//#UC END# *4DDFD2EA0116_13CB70E95F1B_var*
begin
//#UC START# *4DDFD2EA0116_13CB70E95F1B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_13CB70E95F1B_impl*
end;//Tkw_Form_Diction.GetString

class function Tkw_Diction_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_Diction_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Diction_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5FC0994E2F9E_var*
//#UC END# *4DDFD2EA0116_5FC0994E2F9E_var*
begin
//#UC START# *4DDFD2EA0116_5FC0994E2F9E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5FC0994E2F9E_impl*
end;//Tkw_Diction_Control_BackgroundPanel.GetString

class procedure Tkw_Diction_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_5FC0994E2F9E_var*
//#UC END# *52A086150180_5FC0994E2F9E_var*
begin
//#UC START# *52A086150180_5FC0994E2F9E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5FC0994E2F9E_impl*
end;//Tkw_Diction_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_Diction_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_98F39DD7DA47_var*
//#UC END# *4DAEEDE10285_98F39DD7DA47_var*
begin
//#UC START# *4DAEEDE10285_98F39DD7DA47_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_98F39DD7DA47_impl*
end;//Tkw_Diction_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Diction_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_Diction_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_Diction_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_Diction_Control_ContextFilter.GetWordNameForRegister

function Tkw_Diction_Control_ContextFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D8E741EFA38A_var*
//#UC END# *4DDFD2EA0116_D8E741EFA38A_var*
begin
//#UC START# *4DDFD2EA0116_D8E741EFA38A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D8E741EFA38A_impl*
end;//Tkw_Diction_Control_ContextFilter.GetString

class procedure Tkw_Diction_Control_ContextFilter.RegisterInEngine;
//#UC START# *52A086150180_D8E741EFA38A_var*
//#UC END# *52A086150180_D8E741EFA38A_var*
begin
//#UC START# *52A086150180_D8E741EFA38A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D8E741EFA38A_impl*
end;//Tkw_Diction_Control_ContextFilter.RegisterInEngine

procedure Tkw_Diction_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C4366A10CBC7_var*
//#UC END# *4DAEEDE10285_C4366A10CBC7_var*
begin
//#UC START# *4DAEEDE10285_C4366A10CBC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C4366A10CBC7_impl*
end;//Tkw_Diction_Control_ContextFilter_Push.DoDoIt

class function Tkw_Diction_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_Diction_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_Diction_Control_WordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WordsTree';
end;//Tkw_Diction_Control_WordsTree.GetWordNameForRegister

function Tkw_Diction_Control_WordsTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_625384791C6F_var*
//#UC END# *4DDFD2EA0116_625384791C6F_var*
begin
//#UC START# *4DDFD2EA0116_625384791C6F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_625384791C6F_impl*
end;//Tkw_Diction_Control_WordsTree.GetString

class procedure Tkw_Diction_Control_WordsTree.RegisterInEngine;
//#UC START# *52A086150180_625384791C6F_var*
//#UC END# *52A086150180_625384791C6F_var*
begin
//#UC START# *52A086150180_625384791C6F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_625384791C6F_impl*
end;//Tkw_Diction_Control_WordsTree.RegisterInEngine

procedure Tkw_Diction_Control_WordsTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E8445581EFE7_var*
//#UC END# *4DAEEDE10285_E8445581EFE7_var*
begin
//#UC START# *4DAEEDE10285_E8445581EFE7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E8445581EFE7_impl*
end;//Tkw_Diction_Control_WordsTree_Push.DoDoIt

class function Tkw_Diction_Control_WordsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WordsTree:push';
end;//Tkw_Diction_Control_WordsTree_Push.GetWordNameForRegister

function TkwEnDictionBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aenDiction: TenDiction): TvtPanel;
 {* ���������� ����� ������� .TenDiction.BackgroundPanel }
//#UC START# *8CA40CE18A4E_B2258800EAED_var*
//#UC END# *8CA40CE18A4E_B2258800EAED_var*
begin
//#UC START# *8CA40CE18A4E_B2258800EAED_impl*
 !!! Needs to be implemented !!!
//#UC END# *8CA40CE18A4E_B2258800EAED_impl*
end;//TkwEnDictionBackgroundPanel.BackgroundPanel

procedure TkwEnDictionBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B2258800EAED_var*
//#UC END# *4DAEEDE10285_B2258800EAED_var*
begin
//#UC START# *4DAEEDE10285_B2258800EAED_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B2258800EAED_impl*
end;//TkwEnDictionBackgroundPanel.DoDoIt

class function TkwEnDictionBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenDiction.BackgroundPanel';
end;//TkwEnDictionBackgroundPanel.GetWordNameForRegister

procedure TkwEnDictionBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwEnDictionBackgroundPanel.SetValuePrim

function TkwEnDictionBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnDictionBackgroundPanel.GetResultTypeInfo

function TkwEnDictionBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDictionBackgroundPanel.GetAllParamsCount

function TkwEnDictionBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnDictionBackgroundPanel.ParamsTypes

function TkwEnDictionContextFilter.ContextFilter(const aCtx: TtfwContext;
 aenDiction: TenDiction): TnscContextFilter;
 {* ���������� ����� ������� .TenDiction.ContextFilter }
//#UC START# *6271F0C92E13_B4EC4D5AF267_var*
//#UC END# *6271F0C92E13_B4EC4D5AF267_var*
begin
//#UC START# *6271F0C92E13_B4EC4D5AF267_impl*
 !!! Needs to be implemented !!!
//#UC END# *6271F0C92E13_B4EC4D5AF267_impl*
end;//TkwEnDictionContextFilter.ContextFilter

procedure TkwEnDictionContextFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B4EC4D5AF267_var*
//#UC END# *4DAEEDE10285_B4EC4D5AF267_var*
begin
//#UC START# *4DAEEDE10285_B4EC4D5AF267_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B4EC4D5AF267_impl*
end;//TkwEnDictionContextFilter.DoDoIt

class function TkwEnDictionContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenDiction.ContextFilter';
end;//TkwEnDictionContextFilter.GetWordNameForRegister

procedure TkwEnDictionContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwEnDictionContextFilter.SetValuePrim

function TkwEnDictionContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnDictionContextFilter.GetResultTypeInfo

function TkwEnDictionContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDictionContextFilter.GetAllParamsCount

function TkwEnDictionContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnDictionContextFilter.ParamsTypes

function TkwEnDictionWordsTree.WordsTree(const aCtx: TtfwContext;
 aenDiction: TenDiction): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TenDiction.WordsTree }
//#UC START# *EF711B8690BD_ED3545E875CA_var*
//#UC END# *EF711B8690BD_ED3545E875CA_var*
begin
//#UC START# *EF711B8690BD_ED3545E875CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *EF711B8690BD_ED3545E875CA_impl*
end;//TkwEnDictionWordsTree.WordsTree

procedure TkwEnDictionWordsTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ED3545E875CA_var*
//#UC END# *4DAEEDE10285_ED3545E875CA_var*
begin
//#UC START# *4DAEEDE10285_ED3545E875CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ED3545E875CA_impl*
end;//TkwEnDictionWordsTree.DoDoIt

class function TkwEnDictionWordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenDiction.WordsTree';
end;//TkwEnDictionWordsTree.GetWordNameForRegister

procedure TkwEnDictionWordsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwEnDictionWordsTree.SetValuePrim

function TkwEnDictionWordsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnDictionWordsTree.GetResultTypeInfo

function TkwEnDictionWordsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDictionWordsTree.GetAllParamsCount

function TkwEnDictionWordsTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnDictionWordsTree.ParamsTypes

initialization
 Tkw_Form_Diction.RegisterInEngine;
 {* ����������� Tkw_Form_Diction }
 Tkw_Diction_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_Diction_Control_BackgroundPanel }
 Tkw_Diction_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Diction_Control_BackgroundPanel_Push }
 Tkw_Diction_Control_ContextFilter.RegisterInEngine;
 {* ����������� Tkw_Diction_Control_ContextFilter }
 Tkw_Diction_Control_ContextFilter_Push.RegisterInEngine;
 {* ����������� Tkw_Diction_Control_ContextFilter_Push }
 Tkw_Diction_Control_WordsTree.RegisterInEngine;
 {* ����������� Tkw_Diction_Control_WordsTree }
 Tkw_Diction_Control_WordsTree_Push.RegisterInEngine;
 {* ����������� Tkw_Diction_Control_WordsTree_Push }
 TkwEnDictionBackgroundPanel.RegisterInEngine;
 {* ����������� enDiction_BackgroundPanel }
 TkwEnDictionContextFilter.RegisterInEngine;
 {* ����������� enDiction_ContextFilter }
 TkwEnDictionWordsTree.RegisterInEngine;
 {* ����������� enDiction_WordsTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenDiction));
 {* ����������� ���� Diction }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
