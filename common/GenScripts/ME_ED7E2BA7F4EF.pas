unit QueryCardKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� QueryCard }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\QueryCardKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CommonSearch_Module
 , evQueryCardEditor
 , evTextSource
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_QueryCard = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� QueryCard
----
*������ �������������*:
[code]
'aControl' �����::QueryCard TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_QueryCard

 Tkw_QueryCard_Control_Editor = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Editor
----
*������ �������������*:
[code]
�������::Editor TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_QueryCard_Control_Editor

 Tkw_QueryCard_Control_Editor_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Editor
----
*������ �������������*:
[code]
�������::Editor:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_QueryCard_Control_Editor_Push

 Tkw_QueryCard_Component_TextSource = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TextSource
----
*������ �������������*:
[code]
���������::TextSource TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_QueryCard_Component_TextSource

 TkwEnQueryCardEditor = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenQueryCard.Editor
[panel]������� Editor ����� TenQueryCard[panel]
*��� ����������:* TevQueryCardEditor
*������:*
[code]
OBJECT VAR l_TevQueryCardEditor
 aenQueryCard .TenQueryCard.Editor >>> l_TevQueryCardEditor
[code]  }
  private
   function Editor(const aCtx: TtfwContext;
    aenQueryCard: TenQueryCard): TevQueryCardEditor;
    {* ���������� ����� ������� .TenQueryCard.Editor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnQueryCardEditor

 TkwEnQueryCardTextSource = {final} class(TtfwPropertyLike)
  {* ����� ������� .TenQueryCard.TextSource
[panel]������� TextSource ����� TenQueryCard[panel]
*��� ����������:* TevTextSource
*������:*
[code]
OBJECT VAR l_TevTextSource
 aenQueryCard .TenQueryCard.TextSource >>> l_TevTextSource
[code]  }
  private
   function TextSource(const aCtx: TtfwContext;
    aenQueryCard: TenQueryCard): TevTextSource;
    {* ���������� ����� ������� .TenQueryCard.TextSource }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnQueryCardTextSource

class function Tkw_Form_QueryCard.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::QueryCard';
end;//Tkw_Form_QueryCard.GetWordNameForRegister

function Tkw_Form_QueryCard.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C2D191C98445_var*
//#UC END# *4DDFD2EA0116_C2D191C98445_var*
begin
//#UC START# *4DDFD2EA0116_C2D191C98445_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C2D191C98445_impl*
end;//Tkw_Form_QueryCard.GetString

class function Tkw_QueryCard_Control_Editor.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Editor';
end;//Tkw_QueryCard_Control_Editor.GetWordNameForRegister

function Tkw_QueryCard_Control_Editor.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8CE82345456D_var*
//#UC END# *4DDFD2EA0116_8CE82345456D_var*
begin
//#UC START# *4DDFD2EA0116_8CE82345456D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8CE82345456D_impl*
end;//Tkw_QueryCard_Control_Editor.GetString

class procedure Tkw_QueryCard_Control_Editor.RegisterInEngine;
//#UC START# *52A086150180_8CE82345456D_var*
//#UC END# *52A086150180_8CE82345456D_var*
begin
//#UC START# *52A086150180_8CE82345456D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8CE82345456D_impl*
end;//Tkw_QueryCard_Control_Editor.RegisterInEngine

procedure Tkw_QueryCard_Control_Editor_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9E7B525F6E2E_var*
//#UC END# *4DAEEDE10285_9E7B525F6E2E_var*
begin
//#UC START# *4DAEEDE10285_9E7B525F6E2E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9E7B525F6E2E_impl*
end;//Tkw_QueryCard_Control_Editor_Push.DoDoIt

class function Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Editor:push';
end;//Tkw_QueryCard_Control_Editor_Push.GetWordNameForRegister

class function Tkw_QueryCard_Component_TextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::TextSource';
end;//Tkw_QueryCard_Component_TextSource.GetWordNameForRegister

function Tkw_QueryCard_Component_TextSource.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_55FA1BAB0123_var*
//#UC END# *4DDFD2EA0116_55FA1BAB0123_var*
begin
//#UC START# *4DDFD2EA0116_55FA1BAB0123_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_55FA1BAB0123_impl*
end;//Tkw_QueryCard_Component_TextSource.GetString

class procedure Tkw_QueryCard_Component_TextSource.RegisterInEngine;
//#UC START# *52A086150180_55FA1BAB0123_var*
//#UC END# *52A086150180_55FA1BAB0123_var*
begin
//#UC START# *52A086150180_55FA1BAB0123_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_55FA1BAB0123_impl*
end;//Tkw_QueryCard_Component_TextSource.RegisterInEngine

function TkwEnQueryCardEditor.Editor(const aCtx: TtfwContext;
 aenQueryCard: TenQueryCard): TevQueryCardEditor;
 {* ���������� ����� ������� .TenQueryCard.Editor }
//#UC START# *0A4C485022C3_C531EBC72793_var*
//#UC END# *0A4C485022C3_C531EBC72793_var*
begin
//#UC START# *0A4C485022C3_C531EBC72793_impl*
 !!! Needs to be implemented !!!
//#UC END# *0A4C485022C3_C531EBC72793_impl*
end;//TkwEnQueryCardEditor.Editor

procedure TkwEnQueryCardEditor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C531EBC72793_var*
//#UC END# *4DAEEDE10285_C531EBC72793_var*
begin
//#UC START# *4DAEEDE10285_C531EBC72793_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C531EBC72793_impl*
end;//TkwEnQueryCardEditor.DoDoIt

class function TkwEnQueryCardEditor.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenQueryCard.Editor';
end;//TkwEnQueryCardEditor.GetWordNameForRegister

procedure TkwEnQueryCardEditor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwEnQueryCardEditor.SetValuePrim

function TkwEnQueryCardEditor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevQueryCardEditor);
end;//TkwEnQueryCardEditor.GetResultTypeInfo

function TkwEnQueryCardEditor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnQueryCardEditor.GetAllParamsCount

function TkwEnQueryCardEditor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnQueryCardEditor.ParamsTypes

function TkwEnQueryCardTextSource.TextSource(const aCtx: TtfwContext;
 aenQueryCard: TenQueryCard): TevTextSource;
 {* ���������� ����� ������� .TenQueryCard.TextSource }
//#UC START# *C8E4304B9C34_88CF64489AF4_var*
//#UC END# *C8E4304B9C34_88CF64489AF4_var*
begin
//#UC START# *C8E4304B9C34_88CF64489AF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *C8E4304B9C34_88CF64489AF4_impl*
end;//TkwEnQueryCardTextSource.TextSource

procedure TkwEnQueryCardTextSource.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_88CF64489AF4_var*
//#UC END# *4DAEEDE10285_88CF64489AF4_var*
begin
//#UC START# *4DAEEDE10285_88CF64489AF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_88CF64489AF4_impl*
end;//TkwEnQueryCardTextSource.DoDoIt

class function TkwEnQueryCardTextSource.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenQueryCard.TextSource';
end;//TkwEnQueryCardTextSource.GetWordNameForRegister

procedure TkwEnQueryCardTextSource.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwEnQueryCardTextSource.SetValuePrim

function TkwEnQueryCardTextSource.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TevTextSource);
end;//TkwEnQueryCardTextSource.GetResultTypeInfo

function TkwEnQueryCardTextSource.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnQueryCardTextSource.GetAllParamsCount

function TkwEnQueryCardTextSource.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnQueryCardTextSource.ParamsTypes

initialization
 Tkw_Form_QueryCard.RegisterInEngine;
 {* ����������� Tkw_Form_QueryCard }
 Tkw_QueryCard_Control_Editor.RegisterInEngine;
 {* ����������� Tkw_QueryCard_Control_Editor }
 Tkw_QueryCard_Control_Editor_Push.RegisterInEngine;
 {* ����������� Tkw_QueryCard_Control_Editor_Push }
 Tkw_QueryCard_Component_TextSource.RegisterInEngine;
 {* ����������� Tkw_QueryCard_Component_TextSource }
 TkwEnQueryCardEditor.RegisterInEngine;
 {* ����������� enQueryCard_Editor }
 TkwEnQueryCardTextSource.RegisterInEngine;
 {* ����������� enQueryCard_TextSource }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenQueryCard));
 {* ����������� ���� QueryCard }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevQueryCardEditor));
 {* ����������� ���� TevQueryCardEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevTextSource));
 {* ����������� ���� TevTextSource }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
