unit TExprEditorWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Dialogs"
// ������: "w:/archi/source/projects/Common/Dialogs/TExprEditorWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$common::Dialogs::Dialogs::TExprEditorWordsPack
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  ExprEditForm,
  tfwRegisterableWord
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
 TkwPopExprEditorFake = {final scriptword} class(TtfwRegisterableWord)
  {* ����� ������� pop:ExprEditor:Fake
*������:*
[code]
 aExprEditor pop:ExprEditor:Fake
[code]  }
 private
 // private methods
   procedure Fake(const aCtx: TtfwContext;
    aExprEditor: TExprEditor);
     {* ���������� ����� ������� pop:ExprEditor:Fake }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwPopExprEditorFake

// start class TkwPopExprEditorFake

procedure TkwPopExprEditorFake.Fake(const aCtx: TtfwContext;
  aExprEditor: TExprEditor);
//#UC START# *F9F482E814E0_1C9135EF778B_var*
//#UC END# *F9F482E814E0_1C9135EF778B_var*
begin
//#UC START# *F9F482E814E0_1C9135EF778B_impl*
 RunnerError('fake-����� ������ ��� ����������� ������ �����', aCtx);
//#UC END# *F9F482E814E0_1C9135EF778B_impl*
end;//TkwPopExprEditorFake.Fake

procedure TkwPopExprEditorFake.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aExprEditor : TExprEditor;
begin
 try
  l_aExprEditor := TExprEditor(aCtx.rEngine.PopObjAs(TExprEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aExprEditor: TExprEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Fake(aCtx, l_aExprEditor);
end;//TkwPopExprEditorFake.DoDoIt

class function TkwPopExprEditorFake.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:ExprEditor:Fake';
end;//TkwPopExprEditorFake.GetWordNameForRegister

function TkwPopExprEditorFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopExprEditorFake.GetResultTypeInfo
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_ExprEditor_Fake
 TkwPopExprEditorFake.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TExprEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TExprEditor));
{$IfEnd} //not NoScripts

end.