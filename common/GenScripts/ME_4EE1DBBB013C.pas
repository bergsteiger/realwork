unit tfwInteger;
 {* ������� ������ ��� ���������� ���� � �������. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwInteger.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwInteger" MUID: (4EE1DBBB013C)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , TypInfo
 , tfwScriptingInterfaces
;

type
 TtfwInteger = {abstract} class(TtfwRegisterableWord)
  {* ������� ������ ��� ���������� ���� � �������. }
  protected
   function GetInteger: Integer; virtual;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TtfwInteger
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Except
 , l3Base
;

function TtfwInteger.GetInteger: Integer;
//#UC START# *4EE1DC8903BB_4EE1DBBB013C_var*
//#UC END# *4EE1DC8903BB_4EE1DBBB013C_var*
begin
//#UC START# *4EE1DC8903BB_4EE1DBBB013C_impl*
 Result := 0;
 Assert(false);
//#UC END# *4EE1DC8903BB_4EE1DBBB013C_impl*
end;//TtfwInteger.GetInteger

procedure TtfwInteger.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EE1DBBB013C_var*
//#UC END# *4DAEEDE10285_4EE1DBBB013C_var*
begin
//#UC START# *4DAEEDE10285_4EE1DBBB013C_impl*
 aCtx.rEngine.PushInt(GetInteger);
//#UC END# *4DAEEDE10285_4EE1DBBB013C_impl*
end;//TtfwInteger.DoDoIt

function TtfwInteger.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4EE1DBBB013C_var*
//#UC END# *551544E2001A_4EE1DBBB013C_var*
begin
//#UC START# *551544E2001A_4EE1DBBB013C_impl*
 Result := TypeInfo(Integer);
//#UC END# *551544E2001A_4EE1DBBB013C_impl*
end;//TtfwInteger.GetResultTypeInfo

initialization
 TtfwInteger.RegisterClass;
 {* ����������� TtfwInteger }
{$IfEnd} // NOT Defined(NoScripts)

end.
