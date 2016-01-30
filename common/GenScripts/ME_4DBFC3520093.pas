unit tfwConst;
 {* ��������� ��������. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwConst.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwConstLike
 , tfwScriptingInterfaces
;

type
 TtfwConst = {abstract} class(TtfwConstLike)
  {* ��������� ��������. }
  protected
   function AcceptsKeyWordAfter(const aContext: TtfwContext;
    aWordNumber: Integer): Boolean; override;
 end;//TtfwConst
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TtfwConst.AcceptsKeyWordAfter(const aContext: TtfwContext;
 aWordNumber: Integer): Boolean;
//#UC START# *4DB9B502013D_4DBFC3520093_var*
//#UC END# *4DB9B502013D_4DBFC3520093_var*
begin
//#UC START# *4DB9B502013D_4DBFC3520093_impl*
 //Result := false;
 Result := true;
 // - ���������� ��� �������, ����� ����� ���� �������� CONST XXX true
//#UC END# *4DB9B502013D_4DBFC3520093_impl*
end;//TtfwConst.AcceptsKeyWordAfter

initialization
 TtfwConst.RegisterClass;
 {* ����������� TtfwConst }
{$IfEnd} // NOT Defined(NoScripts)

end.
