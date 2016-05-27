unit KeyboardInputPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\KeyboardInputPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "KeyboardInputPack" MUID: (50195665016F)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
 , kwKey
 , kwHardKey
 , kwKeyDown
 , kwKeyUp
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TKeyboardInputPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 end;//TKeyboardInputPackResNameGetter

class function TKeyboardInputPackResNameGetter.ResName: AnsiString;
begin
 Result := 'KeyboardInputPack';
end;//TKeyboardInputPackResNameGetter.ResName

{$R KeyboardInputPack.res}

initialization
 TKeyboardInputPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
