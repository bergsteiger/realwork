unit RubricatorKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Rubricator }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Rubricator\RubricatorKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Rubricator_Module
 , nscTreeViewWithAdapterDragDrop
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , nscSimpleEditor
 {$If Defined(Nemesis)}
 , nscTextSource
 {$IfEnd} // Defined(Nemesis)
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
 Tkw_Form_Rubricator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Rubricator
----
*������ �������������*:
[code]
'aControl' �����::Rubricator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Rubricator

 Tkw_Rubricator_Control_RubricatorList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RubricatorList
----
*������ �������������*:
[code]
�������::RubricatorList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Control_RubricatorList

 Tkw_Rubricator_Control_RubricatorList_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RubricatorList
----
*������ �������������*:
[code]
�������::RubricatorList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_RubricatorList_Push

 Tkw_Rubricator_Control_TopPanel = {final} class(TtfwControlString)
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
 end;//Tkw_Rubricator_Control_TopPanel

 Tkw_Rubricator_Control_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TopPanel
----
*������ �������������*:
[code]
�������::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_TopPanel_Push

 Tkw_Rubricator_Control_PaintBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� PaintBox
----
*������ �������������*:
[code]
�������::PaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Control_PaintBox

 Tkw_Rubricator_Control_PaintBox_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� PaintBox
----
*������ �������������*:
[code]
�������::PaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_PaintBox_Push

 Tkw_Rubricator_Control_NewDocLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NewDocLabel
----
*������ �������������*:
[code]
�������::NewDocLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Control_NewDocLabel

 Tkw_Rubricator_Control_NewDocLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NewDocLabel
----
*������ �������������*:
[code]
�������::NewDocLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_NewDocLabel_Push

 Tkw_Rubricator_Control_DelimiterPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� DelimiterPanel
----
*������ �������������*:
[code]
�������::DelimiterPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Control_DelimiterPanel

 Tkw_Rubricator_Control_DelimiterPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� DelimiterPanel
----
*������ �������������*:
[code]
�������::DelimiterPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Rubricator_Control_DelimiterPanel_Push

 Tkw_Rubricator_Component_ExampleTextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ExampleTextSource
----
*������ �������������*:
[code]
���������::ExampleTextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Rubricator_Component_ExampleTextSource

 TkwEfRubricatorRubricatorList = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.RubricatorList
[panel]������� RubricatorList ����� TefRubricator[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aefRubricator .TefRubricator.RubricatorList >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function RubricatorList(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .TefRubricator.RubricatorList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorRubricatorList

 TkwEfRubricatorTopPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.TopPanel
[panel]������� TopPanel ����� TefRubricator[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefRubricator .TefRubricator.TopPanel >>> l_TvtPanel
[code]  }
  private
   function TopPanel(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TvtPanel;
    {* ���������� ����� ������� .TefRubricator.TopPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorTopPanel

 TkwEfRubricatorPaintBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.PaintBox
[panel]������� PaintBox ����� TefRubricator[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aefRubricator .TefRubricator.PaintBox >>> l_TPaintBox
[code]  }
  private
   function PaintBox(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TPaintBox;
    {* ���������� ����� ������� .TefRubricator.PaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorPaintBox

 TkwEfRubricatorNewDocLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.NewDocLabel
[panel]������� NewDocLabel ����� TefRubricator[panel]
*��� ����������:* TnscSimpleEditor
*������:*
[code]
OBJECT VAR l_TnscSimpleEditor
 aefRubricator .TefRubricator.NewDocLabel >>> l_TnscSimpleEditor
[code]  }
  private
   function NewDocLabel(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TnscSimpleEditor;
    {* ���������� ����� ������� .TefRubricator.NewDocLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorNewDocLabel

 TkwEfRubricatorDelimiterPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.DelimiterPanel
[panel]������� DelimiterPanel ����� TefRubricator[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefRubricator .TefRubricator.DelimiterPanel >>> l_TvtPanel
[code]  }
  private
   function DelimiterPanel(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TvtPanel;
    {* ���������� ����� ������� .TefRubricator.DelimiterPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorDelimiterPanel

 TkwEfRubricatorExampleTextSource = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefRubricator.ExampleTextSource
[panel]������� ExampleTextSource ����� TefRubricator[panel]
*��� ����������:* TnscTextSource
*������:*
[code]
OBJECT VAR l_TnscTextSource
 aefRubricator .TefRubricator.ExampleTextSource >>> l_TnscTextSource
[code]  }
  private
   function ExampleTextSource(const aCtx: TtfwContext;
    aefRubricator: TefRubricator): TnscTextSource;
    {* ���������� ����� ������� .TefRubricator.ExampleTextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfRubricatorExampleTextSource

class function Tkw_Form_Rubricator.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Rubricator';
end;//Tkw_Form_Rubricator.GetWordNameForRegister

function Tkw_Form_Rubricator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7E3C9BABAC38_var*
//#UC END# *4DDFD2EA0116_7E3C9BABAC38_var*
begin
//#UC START# *4DDFD2EA0116_7E3C9BABAC38_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7E3C9BABAC38_impl*
end;//Tkw_Form_Rubricator.GetString

class function Tkw_Rubricator_Control_RubricatorList.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RubricatorList';
end;//Tkw_Rubricator_Control_RubricatorList.GetWordNameForRegister

function Tkw_Rubricator_Control_RubricatorList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_53F5CD3C8862_var*
//#UC END# *4DDFD2EA0116_53F5CD3C8862_var*
begin
//#UC START# *4DDFD2EA0116_53F5CD3C8862_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_53F5CD3C8862_impl*
end;//Tkw_Rubricator_Control_RubricatorList.GetString

class procedure Tkw_Rubricator_Control_RubricatorList.RegisterInEngine;
//#UC START# *52A086150180_53F5CD3C8862_var*
//#UC END# *52A086150180_53F5CD3C8862_var*
begin
//#UC START# *52A086150180_53F5CD3C8862_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_53F5CD3C8862_impl*
end;//Tkw_Rubricator_Control_RubricatorList.RegisterInEngine

procedure Tkw_Rubricator_Control_RubricatorList_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B128CAA72BC5_var*
//#UC END# *4DAEEDE10285_B128CAA72BC5_var*
begin
//#UC START# *4DAEEDE10285_B128CAA72BC5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B128CAA72BC5_impl*
end;//Tkw_Rubricator_Control_RubricatorList_Push.DoDoIt

class function Tkw_Rubricator_Control_RubricatorList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RubricatorList:push';
end;//Tkw_Rubricator_Control_RubricatorList_Push.GetWordNameForRegister

class function Tkw_Rubricator_Control_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TopPanel';
end;//Tkw_Rubricator_Control_TopPanel.GetWordNameForRegister

function Tkw_Rubricator_Control_TopPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D49DC7413DAD_var*
//#UC END# *4DDFD2EA0116_D49DC7413DAD_var*
begin
//#UC START# *4DDFD2EA0116_D49DC7413DAD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D49DC7413DAD_impl*
end;//Tkw_Rubricator_Control_TopPanel.GetString

class procedure Tkw_Rubricator_Control_TopPanel.RegisterInEngine;
//#UC START# *52A086150180_D49DC7413DAD_var*
//#UC END# *52A086150180_D49DC7413DAD_var*
begin
//#UC START# *52A086150180_D49DC7413DAD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D49DC7413DAD_impl*
end;//Tkw_Rubricator_Control_TopPanel.RegisterInEngine

procedure Tkw_Rubricator_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_979DF29ED3D8_var*
//#UC END# *4DAEEDE10285_979DF29ED3D8_var*
begin
//#UC START# *4DAEEDE10285_979DF29ED3D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_979DF29ED3D8_impl*
end;//Tkw_Rubricator_Control_TopPanel_Push.DoDoIt

class function Tkw_Rubricator_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TopPanel:push';
end;//Tkw_Rubricator_Control_TopPanel_Push.GetWordNameForRegister

class function Tkw_Rubricator_Control_PaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PaintBox';
end;//Tkw_Rubricator_Control_PaintBox.GetWordNameForRegister

function Tkw_Rubricator_Control_PaintBox.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3528D0FACC76_var*
//#UC END# *4DDFD2EA0116_3528D0FACC76_var*
begin
//#UC START# *4DDFD2EA0116_3528D0FACC76_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3528D0FACC76_impl*
end;//Tkw_Rubricator_Control_PaintBox.GetString

class procedure Tkw_Rubricator_Control_PaintBox.RegisterInEngine;
//#UC START# *52A086150180_3528D0FACC76_var*
//#UC END# *52A086150180_3528D0FACC76_var*
begin
//#UC START# *52A086150180_3528D0FACC76_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3528D0FACC76_impl*
end;//Tkw_Rubricator_Control_PaintBox.RegisterInEngine

procedure Tkw_Rubricator_Control_PaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E55FE733F7B5_var*
//#UC END# *4DAEEDE10285_E55FE733F7B5_var*
begin
//#UC START# *4DAEEDE10285_E55FE733F7B5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E55FE733F7B5_impl*
end;//Tkw_Rubricator_Control_PaintBox_Push.DoDoIt

class function Tkw_Rubricator_Control_PaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PaintBox:push';
end;//Tkw_Rubricator_Control_PaintBox_Push.GetWordNameForRegister

class function Tkw_Rubricator_Control_NewDocLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewDocLabel';
end;//Tkw_Rubricator_Control_NewDocLabel.GetWordNameForRegister

function Tkw_Rubricator_Control_NewDocLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_04A96CC65C4F_var*
//#UC END# *4DDFD2EA0116_04A96CC65C4F_var*
begin
//#UC START# *4DDFD2EA0116_04A96CC65C4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_04A96CC65C4F_impl*
end;//Tkw_Rubricator_Control_NewDocLabel.GetString

class procedure Tkw_Rubricator_Control_NewDocLabel.RegisterInEngine;
//#UC START# *52A086150180_04A96CC65C4F_var*
//#UC END# *52A086150180_04A96CC65C4F_var*
begin
//#UC START# *52A086150180_04A96CC65C4F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_04A96CC65C4F_impl*
end;//Tkw_Rubricator_Control_NewDocLabel.RegisterInEngine

procedure Tkw_Rubricator_Control_NewDocLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_844BA391680A_var*
//#UC END# *4DAEEDE10285_844BA391680A_var*
begin
//#UC START# *4DAEEDE10285_844BA391680A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_844BA391680A_impl*
end;//Tkw_Rubricator_Control_NewDocLabel_Push.DoDoIt

class function Tkw_Rubricator_Control_NewDocLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NewDocLabel:push';
end;//Tkw_Rubricator_Control_NewDocLabel_Push.GetWordNameForRegister

class function Tkw_Rubricator_Control_DelimiterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DelimiterPanel';
end;//Tkw_Rubricator_Control_DelimiterPanel.GetWordNameForRegister

function Tkw_Rubricator_Control_DelimiterPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D1EF8D79BAEA_var*
//#UC END# *4DDFD2EA0116_D1EF8D79BAEA_var*
begin
//#UC START# *4DDFD2EA0116_D1EF8D79BAEA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D1EF8D79BAEA_impl*
end;//Tkw_Rubricator_Control_DelimiterPanel.GetString

class procedure Tkw_Rubricator_Control_DelimiterPanel.RegisterInEngine;
//#UC START# *52A086150180_D1EF8D79BAEA_var*
//#UC END# *52A086150180_D1EF8D79BAEA_var*
begin
//#UC START# *52A086150180_D1EF8D79BAEA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D1EF8D79BAEA_impl*
end;//Tkw_Rubricator_Control_DelimiterPanel.RegisterInEngine

procedure Tkw_Rubricator_Control_DelimiterPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_09AA1137EEA9_var*
//#UC END# *4DAEEDE10285_09AA1137EEA9_var*
begin
//#UC START# *4DAEEDE10285_09AA1137EEA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_09AA1137EEA9_impl*
end;//Tkw_Rubricator_Control_DelimiterPanel_Push.DoDoIt

class function Tkw_Rubricator_Control_DelimiterPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DelimiterPanel:push';
end;//Tkw_Rubricator_Control_DelimiterPanel_Push.GetWordNameForRegister

class function Tkw_Rubricator_Component_ExampleTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::ExampleTextSource';
end;//Tkw_Rubricator_Component_ExampleTextSource.GetWordNameForRegister

function Tkw_Rubricator_Component_ExampleTextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_BEFACEDB7B42_var*
//#UC END# *4DDFD2EA0116_BEFACEDB7B42_var*
begin
//#UC START# *4DDFD2EA0116_BEFACEDB7B42_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_BEFACEDB7B42_impl*
end;//Tkw_Rubricator_Component_ExampleTextSource.GetString

class procedure Tkw_Rubricator_Component_ExampleTextSource.RegisterInEngine;
//#UC START# *52A086150180_BEFACEDB7B42_var*
//#UC END# *52A086150180_BEFACEDB7B42_var*
begin
//#UC START# *52A086150180_BEFACEDB7B42_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_BEFACEDB7B42_impl*
end;//Tkw_Rubricator_Component_ExampleTextSource.RegisterInEngine

function TkwEfRubricatorRubricatorList.RubricatorList(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .TefRubricator.RubricatorList }
//#UC START# *35E40604D335_570087BEBDE5_var*
//#UC END# *35E40604D335_570087BEBDE5_var*
begin
//#UC START# *35E40604D335_570087BEBDE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *35E40604D335_570087BEBDE5_impl*
end;//TkwEfRubricatorRubricatorList.RubricatorList

procedure TkwEfRubricatorRubricatorList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_570087BEBDE5_var*
//#UC END# *4DAEEDE10285_570087BEBDE5_var*
begin
//#UC START# *4DAEEDE10285_570087BEBDE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_570087BEBDE5_impl*
end;//TkwEfRubricatorRubricatorList.DoDoIt

class function TkwEfRubricatorRubricatorList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.RubricatorList';
end;//TkwEfRubricatorRubricatorList.GetWordNameForRegister

procedure TkwEfRubricatorRubricatorList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_570087BEBDE5_var*
//#UC END# *52D00B00031A_570087BEBDE5_var*
begin
//#UC START# *52D00B00031A_570087BEBDE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_570087BEBDE5_impl*
end;//TkwEfRubricatorRubricatorList.SetValuePrim

function TkwEfRubricatorRubricatorList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_570087BEBDE5_var*
//#UC END# *551544E2001A_570087BEBDE5_var*
begin
//#UC START# *551544E2001A_570087BEBDE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_570087BEBDE5_impl*
end;//TkwEfRubricatorRubricatorList.GetResultTypeInfo

function TkwEfRubricatorRubricatorList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_570087BEBDE5_var*
//#UC END# *559687E6025A_570087BEBDE5_var*
begin
//#UC START# *559687E6025A_570087BEBDE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_570087BEBDE5_impl*
end;//TkwEfRubricatorRubricatorList.GetAllParamsCount

function TkwEfRubricatorRubricatorList.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_570087BEBDE5_var*
//#UC END# *5617F4D00243_570087BEBDE5_var*
begin
//#UC START# *5617F4D00243_570087BEBDE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_570087BEBDE5_impl*
end;//TkwEfRubricatorRubricatorList.ParamsTypes

function TkwEfRubricatorTopPanel.TopPanel(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TvtPanel;
 {* ���������� ����� ������� .TefRubricator.TopPanel }
//#UC START# *DC9218F55E88_64EE419069C8_var*
//#UC END# *DC9218F55E88_64EE419069C8_var*
begin
//#UC START# *DC9218F55E88_64EE419069C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *DC9218F55E88_64EE419069C8_impl*
end;//TkwEfRubricatorTopPanel.TopPanel

procedure TkwEfRubricatorTopPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_64EE419069C8_var*
//#UC END# *4DAEEDE10285_64EE419069C8_var*
begin
//#UC START# *4DAEEDE10285_64EE419069C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_64EE419069C8_impl*
end;//TkwEfRubricatorTopPanel.DoDoIt

class function TkwEfRubricatorTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.TopPanel';
end;//TkwEfRubricatorTopPanel.GetWordNameForRegister

procedure TkwEfRubricatorTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_64EE419069C8_var*
//#UC END# *52D00B00031A_64EE419069C8_var*
begin
//#UC START# *52D00B00031A_64EE419069C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_64EE419069C8_impl*
end;//TkwEfRubricatorTopPanel.SetValuePrim

function TkwEfRubricatorTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_64EE419069C8_var*
//#UC END# *551544E2001A_64EE419069C8_var*
begin
//#UC START# *551544E2001A_64EE419069C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_64EE419069C8_impl*
end;//TkwEfRubricatorTopPanel.GetResultTypeInfo

function TkwEfRubricatorTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_64EE419069C8_var*
//#UC END# *559687E6025A_64EE419069C8_var*
begin
//#UC START# *559687E6025A_64EE419069C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_64EE419069C8_impl*
end;//TkwEfRubricatorTopPanel.GetAllParamsCount

function TkwEfRubricatorTopPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_64EE419069C8_var*
//#UC END# *5617F4D00243_64EE419069C8_var*
begin
//#UC START# *5617F4D00243_64EE419069C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_64EE419069C8_impl*
end;//TkwEfRubricatorTopPanel.ParamsTypes

function TkwEfRubricatorPaintBox.PaintBox(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TPaintBox;
 {* ���������� ����� ������� .TefRubricator.PaintBox }
//#UC START# *0EE13301A267_741A23B47FE2_var*
//#UC END# *0EE13301A267_741A23B47FE2_var*
begin
//#UC START# *0EE13301A267_741A23B47FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *0EE13301A267_741A23B47FE2_impl*
end;//TkwEfRubricatorPaintBox.PaintBox

procedure TkwEfRubricatorPaintBox.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_741A23B47FE2_var*
//#UC END# *4DAEEDE10285_741A23B47FE2_var*
begin
//#UC START# *4DAEEDE10285_741A23B47FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_741A23B47FE2_impl*
end;//TkwEfRubricatorPaintBox.DoDoIt

class function TkwEfRubricatorPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.PaintBox';
end;//TkwEfRubricatorPaintBox.GetWordNameForRegister

procedure TkwEfRubricatorPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_741A23B47FE2_var*
//#UC END# *52D00B00031A_741A23B47FE2_var*
begin
//#UC START# *52D00B00031A_741A23B47FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_741A23B47FE2_impl*
end;//TkwEfRubricatorPaintBox.SetValuePrim

function TkwEfRubricatorPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_741A23B47FE2_var*
//#UC END# *551544E2001A_741A23B47FE2_var*
begin
//#UC START# *551544E2001A_741A23B47FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_741A23B47FE2_impl*
end;//TkwEfRubricatorPaintBox.GetResultTypeInfo

function TkwEfRubricatorPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_741A23B47FE2_var*
//#UC END# *559687E6025A_741A23B47FE2_var*
begin
//#UC START# *559687E6025A_741A23B47FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_741A23B47FE2_impl*
end;//TkwEfRubricatorPaintBox.GetAllParamsCount

function TkwEfRubricatorPaintBox.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_741A23B47FE2_var*
//#UC END# *5617F4D00243_741A23B47FE2_var*
begin
//#UC START# *5617F4D00243_741A23B47FE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_741A23B47FE2_impl*
end;//TkwEfRubricatorPaintBox.ParamsTypes

function TkwEfRubricatorNewDocLabel.NewDocLabel(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TnscSimpleEditor;
 {* ���������� ����� ������� .TefRubricator.NewDocLabel }
//#UC START# *49F1E974AC9C_88E2B9AA0F4C_var*
//#UC END# *49F1E974AC9C_88E2B9AA0F4C_var*
begin
//#UC START# *49F1E974AC9C_88E2B9AA0F4C_impl*
 !!! Needs to be implemented !!!
//#UC END# *49F1E974AC9C_88E2B9AA0F4C_impl*
end;//TkwEfRubricatorNewDocLabel.NewDocLabel

procedure TkwEfRubricatorNewDocLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_88E2B9AA0F4C_var*
//#UC END# *4DAEEDE10285_88E2B9AA0F4C_var*
begin
//#UC START# *4DAEEDE10285_88E2B9AA0F4C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_88E2B9AA0F4C_impl*
end;//TkwEfRubricatorNewDocLabel.DoDoIt

class function TkwEfRubricatorNewDocLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.NewDocLabel';
end;//TkwEfRubricatorNewDocLabel.GetWordNameForRegister

procedure TkwEfRubricatorNewDocLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_88E2B9AA0F4C_var*
//#UC END# *52D00B00031A_88E2B9AA0F4C_var*
begin
//#UC START# *52D00B00031A_88E2B9AA0F4C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_88E2B9AA0F4C_impl*
end;//TkwEfRubricatorNewDocLabel.SetValuePrim

function TkwEfRubricatorNewDocLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_88E2B9AA0F4C_var*
//#UC END# *551544E2001A_88E2B9AA0F4C_var*
begin
//#UC START# *551544E2001A_88E2B9AA0F4C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_88E2B9AA0F4C_impl*
end;//TkwEfRubricatorNewDocLabel.GetResultTypeInfo

function TkwEfRubricatorNewDocLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_88E2B9AA0F4C_var*
//#UC END# *559687E6025A_88E2B9AA0F4C_var*
begin
//#UC START# *559687E6025A_88E2B9AA0F4C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_88E2B9AA0F4C_impl*
end;//TkwEfRubricatorNewDocLabel.GetAllParamsCount

function TkwEfRubricatorNewDocLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_88E2B9AA0F4C_var*
//#UC END# *5617F4D00243_88E2B9AA0F4C_var*
begin
//#UC START# *5617F4D00243_88E2B9AA0F4C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_88E2B9AA0F4C_impl*
end;//TkwEfRubricatorNewDocLabel.ParamsTypes

function TkwEfRubricatorDelimiterPanel.DelimiterPanel(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TvtPanel;
 {* ���������� ����� ������� .TefRubricator.DelimiterPanel }
//#UC START# *6A8F9E5AF861_25E8A124FE5E_var*
//#UC END# *6A8F9E5AF861_25E8A124FE5E_var*
begin
//#UC START# *6A8F9E5AF861_25E8A124FE5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *6A8F9E5AF861_25E8A124FE5E_impl*
end;//TkwEfRubricatorDelimiterPanel.DelimiterPanel

procedure TkwEfRubricatorDelimiterPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_25E8A124FE5E_var*
//#UC END# *4DAEEDE10285_25E8A124FE5E_var*
begin
//#UC START# *4DAEEDE10285_25E8A124FE5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_25E8A124FE5E_impl*
end;//TkwEfRubricatorDelimiterPanel.DoDoIt

class function TkwEfRubricatorDelimiterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.DelimiterPanel';
end;//TkwEfRubricatorDelimiterPanel.GetWordNameForRegister

procedure TkwEfRubricatorDelimiterPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_25E8A124FE5E_var*
//#UC END# *52D00B00031A_25E8A124FE5E_var*
begin
//#UC START# *52D00B00031A_25E8A124FE5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_25E8A124FE5E_impl*
end;//TkwEfRubricatorDelimiterPanel.SetValuePrim

function TkwEfRubricatorDelimiterPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_25E8A124FE5E_var*
//#UC END# *551544E2001A_25E8A124FE5E_var*
begin
//#UC START# *551544E2001A_25E8A124FE5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_25E8A124FE5E_impl*
end;//TkwEfRubricatorDelimiterPanel.GetResultTypeInfo

function TkwEfRubricatorDelimiterPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_25E8A124FE5E_var*
//#UC END# *559687E6025A_25E8A124FE5E_var*
begin
//#UC START# *559687E6025A_25E8A124FE5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_25E8A124FE5E_impl*
end;//TkwEfRubricatorDelimiterPanel.GetAllParamsCount

function TkwEfRubricatorDelimiterPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_25E8A124FE5E_var*
//#UC END# *5617F4D00243_25E8A124FE5E_var*
begin
//#UC START# *5617F4D00243_25E8A124FE5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_25E8A124FE5E_impl*
end;//TkwEfRubricatorDelimiterPanel.ParamsTypes

function TkwEfRubricatorExampleTextSource.ExampleTextSource(const aCtx: TtfwContext;
 aefRubricator: TefRubricator): TnscTextSource;
 {* ���������� ����� ������� .TefRubricator.ExampleTextSource }
//#UC START# *3B46B1476857_7906F7EBF729_var*
//#UC END# *3B46B1476857_7906F7EBF729_var*
begin
//#UC START# *3B46B1476857_7906F7EBF729_impl*
 !!! Needs to be implemented !!!
//#UC END# *3B46B1476857_7906F7EBF729_impl*
end;//TkwEfRubricatorExampleTextSource.ExampleTextSource

procedure TkwEfRubricatorExampleTextSource.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7906F7EBF729_var*
//#UC END# *4DAEEDE10285_7906F7EBF729_var*
begin
//#UC START# *4DAEEDE10285_7906F7EBF729_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7906F7EBF729_impl*
end;//TkwEfRubricatorExampleTextSource.DoDoIt

class function TkwEfRubricatorExampleTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefRubricator.ExampleTextSource';
end;//TkwEfRubricatorExampleTextSource.GetWordNameForRegister

procedure TkwEfRubricatorExampleTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7906F7EBF729_var*
//#UC END# *52D00B00031A_7906F7EBF729_var*
begin
//#UC START# *52D00B00031A_7906F7EBF729_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7906F7EBF729_impl*
end;//TkwEfRubricatorExampleTextSource.SetValuePrim

function TkwEfRubricatorExampleTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7906F7EBF729_var*
//#UC END# *551544E2001A_7906F7EBF729_var*
begin
//#UC START# *551544E2001A_7906F7EBF729_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7906F7EBF729_impl*
end;//TkwEfRubricatorExampleTextSource.GetResultTypeInfo

function TkwEfRubricatorExampleTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_7906F7EBF729_var*
//#UC END# *559687E6025A_7906F7EBF729_var*
begin
//#UC START# *559687E6025A_7906F7EBF729_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_7906F7EBF729_impl*
end;//TkwEfRubricatorExampleTextSource.GetAllParamsCount

function TkwEfRubricatorExampleTextSource.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7906F7EBF729_var*
//#UC END# *5617F4D00243_7906F7EBF729_var*
begin
//#UC START# *5617F4D00243_7906F7EBF729_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7906F7EBF729_impl*
end;//TkwEfRubricatorExampleTextSource.ParamsTypes

initialization
 Tkw_Form_Rubricator.RegisterInEngine;
 {* ����������� Tkw_Form_Rubricator }
 Tkw_Rubricator_Control_RubricatorList.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_RubricatorList }
 Tkw_Rubricator_Control_RubricatorList_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_RubricatorList_Push }
 Tkw_Rubricator_Control_TopPanel.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_TopPanel }
 Tkw_Rubricator_Control_TopPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_TopPanel_Push }
 Tkw_Rubricator_Control_PaintBox.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_PaintBox }
 Tkw_Rubricator_Control_PaintBox_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_PaintBox_Push }
 Tkw_Rubricator_Control_NewDocLabel.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_NewDocLabel }
 Tkw_Rubricator_Control_NewDocLabel_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_NewDocLabel_Push }
 Tkw_Rubricator_Control_DelimiterPanel.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_DelimiterPanel }
 Tkw_Rubricator_Control_DelimiterPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Control_DelimiterPanel_Push }
 Tkw_Rubricator_Component_ExampleTextSource.RegisterInEngine;
 {* ����������� Tkw_Rubricator_Component_ExampleTextSource }
 TkwEfRubricatorRubricatorList.RegisterInEngine;
 {* ����������� efRubricator_RubricatorList }
 TkwEfRubricatorTopPanel.RegisterInEngine;
 {* ����������� efRubricator_TopPanel }
 TkwEfRubricatorPaintBox.RegisterInEngine;
 {* ����������� efRubricator_PaintBox }
 TkwEfRubricatorNewDocLabel.RegisterInEngine;
 {* ����������� efRubricator_NewDocLabel }
 TkwEfRubricatorDelimiterPanel.RegisterInEngine;
 {* ����������� efRubricator_DelimiterPanel }
 TkwEfRubricatorExampleTextSource.RegisterInEngine;
 {* ����������� efRubricator_ExampleTextSource }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefRubricator));
 {* ����������� ���� Rubricator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscSimpleEditor));
 {* ����������� ���� TnscSimpleEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTextSource));
 {* ����������� ���� TnscTextSource }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
