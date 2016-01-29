unit TPicSizeEditDlgWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Dialogs"
// ������: "w:/archi/source/projects/Common/Dialogs/TPicSizeEditDlgWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$common::Dialogs::Dialogs::TPicSizeEditDlgWordsPack
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
  D_PicSizeEdit,
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
 TkwPopPicSizeEditDlgFake = {final scriptword} class(TtfwRegisterableWord)
  {* ����� ������� pop:PicSizeEditDlg:Fake
*������:*
[code]
 aPicSizeEditDlg pop:PicSizeEditDlg:Fake
[code]  }
 private
 // private methods
   procedure Fake(const aCtx: TtfwContext;
    aPicSizeEditDlg: TPicSizeEditDlg);
     {* ���������� ����� ������� pop:PicSizeEditDlg:Fake }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwPopPicSizeEditDlgFake

// start class TkwPopPicSizeEditDlgFake

procedure TkwPopPicSizeEditDlgFake.Fake(const aCtx: TtfwContext;
  aPicSizeEditDlg: TPicSizeEditDlg);
//#UC START# *CD007FA5CC23_DF6A0ECD8244_var*
//#UC END# *CD007FA5CC23_DF6A0ECD8244_var*
begin
//#UC START# *CD007FA5CC23_DF6A0ECD8244_impl*
 RunnerError('fake-����� ������ ��� ����������� ������ �����', aCtx);
//#UC END# *CD007FA5CC23_DF6A0ECD8244_impl*
end;//TkwPopPicSizeEditDlgFake.Fake

procedure TkwPopPicSizeEditDlgFake.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aPicSizeEditDlg : TPicSizeEditDlg;
begin
 try
  l_aPicSizeEditDlg := TPicSizeEditDlg(aCtx.rEngine.PopObjAs(TPicSizeEditDlg));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aPicSizeEditDlg: TPicSizeEditDlg : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Fake(aCtx, l_aPicSizeEditDlg);
end;//TkwPopPicSizeEditDlgFake.DoDoIt

class function TkwPopPicSizeEditDlgFake.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:PicSizeEditDlg:Fake';
end;//TkwPopPicSizeEditDlgFake.GetWordNameForRegister

function TkwPopPicSizeEditDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopPicSizeEditDlgFake.GetResultTypeInfo
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_PicSizeEditDlg_Fake
 TkwPopPicSizeEditDlgFake.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TPicSizeEditDlg
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPicSizeEditDlg));
{$IfEnd} //not NoScripts

end.