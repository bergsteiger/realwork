unit kwIniRecSetZoom;
 {* IniRec:SetZoom }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwIniRecSetZoom.pas"
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
 TkwIniRecSetZoom = class(TtfwRegisterableWord)
  {* IniRec:SetZoom }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIniRecSetZoom
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwIniRecSetZoom.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E83072D01FF_var*
//#UC END# *4DAEEDE10285_4E83072D01FF_var*
begin
//#UC START# *4DAEEDE10285_4E83072D01FF_impl*
 if aCtx.rEngine.IsTopInt then
  ArIniRecSetZoom(aCtx.rEngine.PopInt)
 else
  Assert(False, '�������� Zoom ������ ���� � ���� �����!');
//#UC END# *4DAEEDE10285_4E83072D01FF_impl*
end;//TkwIniRecSetZoom.DoDoIt

class function TkwIniRecSetZoom.GetWordNameForRegister: AnsiString;
begin
 Result := 'IniRec:SetZoom';
end;//TkwIniRecSetZoom.GetWordNameForRegister

initialization
 TkwIniRecSetZoom.RegisterInEngine;
 {* ����������� TkwIniRecSetZoom }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
