unit kwBEGIN;
 {* ��������� ������ BEGIN END � ����� �������. }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwBEGIN.pas"
// ���������: "ScriptKeyword"
// ������� ������: "BEGIN" MUID: (4DB9BB8D0388)
// ��� ����: "TkwBEGIN"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwBeginLikeWord
 , tfwScriptingInterfaces
;

type
 TkwBEGIN = class(TtfwBeginLikeWord)
  {* ��������� ������ BEGIN END � ����� �������. }
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwBEGIN
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwEND
 //#UC START# *4DB9BB8D0388impl_uses*
 //#UC END# *4DB9BB8D0388impl_uses*
;

function TkwBEGIN.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4DB9BB8D0388_var*
//#UC END# *4DB6C99F026E_4DB9BB8D0388_var*
begin
//#UC START# *4DB6C99F026E_4DB9BB8D0388_impl*
 Result := TkwEND;
//#UC END# *4DB6C99F026E_4DB9BB8D0388_impl*
end;//TkwBEGIN.EndBracket

class function TkwBEGIN.GetWordNameForRegister: AnsiString;
begin
 Result := 'BEGIN';
end;//TkwBEGIN.GetWordNameForRegister

initialization
 TkwBEGIN.RegisterInEngine;
 {* ����������� BEGIN }
{$IfEnd} // NOT Defined(NoScripts)

end.
