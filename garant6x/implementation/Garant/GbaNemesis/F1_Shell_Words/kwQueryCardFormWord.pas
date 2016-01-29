unit kwQueryCardFormWord;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Shell Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/kwQueryCardFormWord.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ��������� ������::F1 Shell Words::F1 Shell Words::TkwQueryCardFormWord
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
  Classes
  {$If not defined(Admin)}
  ,
  PrimQueryCard_Form
  {$IfEnd} //not Admin
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwFormFromControlWord
  {$IfEnd} //not NoScripts AND not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwQueryCardFormWord = {abstract} class(TkwFormFromControlWord)
 protected
 // realized methods
    {$If not defined(NoScripts) AND not defined(NoVCL)}
   procedure DoForm(aForm: TForm;
     const aCtx: TtfwContext); override;
    {$IfEnd} //not NoScripts AND not NoVCL
 protected
 // protected methods
   procedure DoQueryCardForm(aForm: TPrimQueryCardForm;
     const aCtx: TtfwContext); virtual; abstract;
 end;//TkwQueryCardFormWord
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwQueryCardFormWord

{$If not defined(NoScripts) AND not defined(NoVCL)}
procedure TkwQueryCardFormWord.DoForm(aForm: TForm;
  const aCtx: TtfwContext);
//#UC START# *4EB25DE00396_4F69AE35012F_var*
//#UC END# *4EB25DE00396_4F69AE35012F_var*
begin
//#UC START# *4EB25DE00396_4F69AE35012F_impl*
 DoQueryCardForm(aForm As TPrimQueryCardForm, aCtx);
//#UC END# *4EB25DE00396_4F69AE35012F_impl*
end;//TkwQueryCardFormWord.DoForm
{$IfEnd} //not NoScripts AND not NoVCL

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwQueryCardFormWord
 TkwQueryCardFormWord.RegisterClass;
{$IfEnd} //not NoScripts

end.