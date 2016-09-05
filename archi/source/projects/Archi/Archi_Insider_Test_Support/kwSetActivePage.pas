unit kwSetActivePage;
 {* *������:* ID_������� ����_���������:�������_��_�������
*��������:* ������ �������� ������� � ������� ID_�������.
*����������:*
 ��������� � �������� ������� ��������� � �����:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\ArchiControls.script"
[code] }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwSetActivePage.pas"
// ���������: "ScriptKeyword"
// ������� ������: "TkwSetActivePage" MUID: (4EAFC7190370)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwSetActivePage = class(TtfwRegisterableWord)
  {* *������:* ID_������� ����_���������:�������_��_�������
*��������:* ������ �������� ������� � ������� ID_�������.
*����������:*
 ��������� � �������� ������� ��������� � �����:
[code]
  w:\archi\source\projects\Archi\TestSet\Dictionary\ArchiControls.script"
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwSetActivePage
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
 //#UC START# *4EAFC7190370impl_uses*
 //#UC END# *4EAFC7190370impl_uses*
;

class function TkwSetActivePage.GetWordNameForRegister: AnsiString;
begin
 Result := '����_���������:�������_��_�������';
end;//TkwSetActivePage.GetWordNameForRegister

procedure TkwSetActivePage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EAFC7190370_var*
//#UC END# *4DAEEDE10285_4EAFC7190370_var*
begin
//#UC START# *4DAEEDE10285_4EAFC7190370_impl*
 if aCtx.rEngine.IsTopInt then
  AcSetActivePage(aCtx.rEngine.PopInt)
 else
  Assert(False, '�� ����� ����� �������!');
//#UC END# *4DAEEDE10285_4EAFC7190370_impl*
end;//TkwSetActivePage.DoDoIt

initialization
 TkwSetActivePage.RegisterInEngine;
 {* ����������� TkwSetActivePage }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
