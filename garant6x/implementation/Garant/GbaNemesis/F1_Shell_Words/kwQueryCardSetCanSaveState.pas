unit kwQueryCardSetCanSaveState;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Shell Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwQueryCardSetCanSaveState.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Shell Words::F1 Shell Words::QueryCard_SetCanSaveState
//
// ������������� ���� ���� ����� �� �������� ������� ������ ��� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwQueryCardFormWord
  {$If not defined(Admin)}
  ,
  PrimQueryCard_Form
  {$IfEnd} //not Admin
  ,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwQueryCardSetCanSaveState = {final scriptword} class(TkwQueryCardFormWord)
  {* ������������� ���� ���� ����� �� �������� ������� ������ ��� ��������� }
 protected
 // realized methods
   procedure DoQueryCardForm(aForm: TPrimQueryCardForm;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwQueryCardSetCanSaveState
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwQueryCardSetCanSaveState

procedure TkwQueryCardSetCanSaveState.DoQueryCardForm(aForm: TPrimQueryCardForm;
  const aCtx: TtfwContext);
//#UC START# *4F69AE600137_4F69AF3E01C0_var*
//#UC END# *4F69AE600137_4F69AF3E01C0_var*
begin
//#UC START# *4F69AE600137_4F69AF3E01C0_impl*
 aForm.CanWriteMgrSettings := aCtx.rEngine.PopBool;
//#UC END# *4F69AE600137_4F69AF3E01C0_impl*
end;//TkwQueryCardSetCanSaveState.DoQueryCardForm

class function TkwQueryCardSetCanSaveState.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'QueryCard:SetCanSaveState';
end;//TkwQueryCardSetCanSaveState.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� QueryCard_SetCanSaveState
 TkwQueryCardSetCanSaveState.RegisterInEngine;
{$IfEnd} //not NoScripts

end.