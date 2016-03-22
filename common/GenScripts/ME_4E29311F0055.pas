unit kwObjectCreate;
 {* ��������� ��������������� �������� �����-������� ��� ������.
*������:* aClass .Create
aClass - ����� �����.

���� ������ ������ VCM-����� �� �������������� ������� ��������� � ������ �������. }

// ������: "w:\common\components\gui\Garant\VCM\implementation\Scripting\kwObjectCreate.pas"
// ���������: "ScriptKeyword"
// ������� ������: "object_Create" MUID: (4E29311F0055)
// ��� ����: "TkwObjectCreate"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _VCMWord_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}
 TkwObjectCreate = class(_VCMWord_)
  {* ��������� ��������������� �������� �����-������� ��� ������.
*������:* aClass .Create
aClass - ����� �����.

���� ������ ������ VCM-����� �� �������������� ������� ��������� � ������ �������. }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwObjectCreate
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmEntityForm
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmBase
 , vcmForm
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , StdRes
 , afwAnswer
;

{$Include w:\common\components\gui\Garant\VCM\implementation\Scripting\VCMWord.imp.pas}

procedure TkwObjectCreate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E29311F0055_var*
var
 l_Class: TClass;
//#UC END# *4DAEEDE10285_4E29311F0055_var*
begin
//#UC START# *4DAEEDE10285_4E29311F0055_impl*
{$If defined(NoVCM)}
 RunnerAssert(False, 'VCM �� �������������� � ����.', aCtx);
{$ELSE}
 if aCtx.rEngine.IsTopClass then
 begin
  l_Class := aCtx.rEngine.PopClass;
  RunnerAssert(l_Class.InheritsFrom(TvcmEntityForm), '������������ ����� �����', aCtx);
  aCtx.rEngine.PushObj(RvcmEntityForm(l_Class).Make(vcmMakeParams).VCLWinControl As TCustomForm);
 end//aCtx.rEngine.IsTopString
 else
  RunnerAssert(False, '�� ����� ����� �����.', aCtx);
{$IfEnd} //not NoVCM
//#UC END# *4DAEEDE10285_4E29311F0055_impl*
end;//TkwObjectCreate.DoDoIt

class function TkwObjectCreate.GetWordNameForRegister: AnsiString;
begin
 Result := '.Create';
end;//TkwObjectCreate.GetWordNameForRegister

initialization
 TkwObjectCreate.RegisterInEngine;
 {* ����������� object_Create }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
