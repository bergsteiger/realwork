unit ListAnalizeKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ListAnalize }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\List\Forms\ListAnalizeKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ListAnalizeKeywordsPack" MUID: (4E36959002CA_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ListAnalize_Form
 , tfwControlString
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4E36959002CA_Packimpl_uses*
 //#UC END# *4E36959002CA_Packimpl_uses*
;

type
 Tkw_Form_ListAnalize = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ListAnalize
----
*������ �������������*:
[code]�����::ListAnalize TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ListAnalize

function Tkw_Form_ListAnalize.GetString: AnsiString;
begin
 Result := 'ListAnalizeForm';
end;//Tkw_Form_ListAnalize.GetString

class procedure Tkw_Form_ListAnalize.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TListAnalizeForm);
end;//Tkw_Form_ListAnalize.RegisterInEngine

class function Tkw_Form_ListAnalize.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ListAnalize';
end;//Tkw_Form_ListAnalize.GetWordNameForRegister

initialization
 Tkw_Form_ListAnalize.RegisterInEngine;
 {* ����������� Tkw_Form_ListAnalize }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TListAnalizeForm));
 {* ����������� ���� TListAnalizeForm }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
