unit K275780190;
 {* [RequestLink:275780190]. }

// ������: "w:\common\components\rtl\Garant\Archi_Tests\K275780190.pas"
// ���������: "TestCase"
// ������� ������: "K275780190" MUID: (4E2EB2D50291)
// ��� ����: "TK275780190"

{$Include w:\common\components\rtl\Garant\Archi_Tests\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , TextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , PrimTextLoad_Form
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TK275780190 = class({$If NOT Defined(NoVCM)}
 TTextViaEditorProcessor
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* [RequestLink:275780190]. }
  protected
   {$If NOT Defined(NoVCM)}
   procedure Process(aForm: TPrimTextLoadForm); override;
    {* ���������� ������� ��������� ������ }
   {$IfEnd} // NOT Defined(NoVCM)
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
 end;//TK275780190
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , k2Tags
 , TestFrameWork
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 //#UC START# *4E2EB2D50291impl_uses*
 //#UC END# *4E2EB2D50291impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TK275780190.Process(aForm: TPrimTextLoadForm);
 {* ���������� ������� ��������� ������ }
//#UC START# *4BE13147032C_4E2EB2D50291_var*
//#UC END# *4BE13147032C_4E2EB2D50291_var*
begin
//#UC START# *4BE13147032C_4E2EB2D50291_impl*
 aForm.Text.Document.Int64A[k2_tiMDPPageID] := $FAFAFAFAFEFEFEFE;
//#UC END# *4BE13147032C_4E2EB2D50291_impl*
end;//TK275780190.Process

function TK275780190.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'Tags';
end;//TK275780190.GetFolder

function TK275780190.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '4E2EB2D50291';
end;//TK275780190.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TK275780190.Suite);
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)
end.
