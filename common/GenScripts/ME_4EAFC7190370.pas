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
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSetActivePage
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

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

class function TkwSetActivePage.GetWordNameForRegister: AnsiString;
begin
 Result := '����_���������:�������_��_�������';
end;//TkwSetActivePage.GetWordNameForRegister

initialization
 TkwSetActivePage.RegisterInEngine;
 {* ����������� TkwSetActivePage }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
