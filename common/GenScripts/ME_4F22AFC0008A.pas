unit kwSetExpiredStyle;

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwSetExpiredStyle.pas"
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
 TkwSetExpiredStyle = class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSetExpiredStyle
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestAdapter2
;

procedure TkwSetExpiredStyle.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F22AFC0008A_var*
//#UC END# *4DAEEDE10285_4F22AFC0008A_var*
begin
//#UC START# *4DAEEDE10285_4F22AFC0008A_impl*
 if aCtx.rEngine.IsTopInt then
  aCtx.rEngine.PopInt
 else
  Assert(False, '�� ������ �������� StyleID');
//#UC END# *4DAEEDE10285_4F22AFC0008A_impl*
end;//TkwSetExpiredStyle.DoDoIt

class function TkwSetExpiredStyle.GetWordNameForRegister: AnsiString;
begin
 Result := '����_���������:SetExpiredStyle';
end;//TkwSetExpiredStyle.GetWordNameForRegister

initialization
 TkwSetExpiredStyle.RegisterInEngine;
 {* ����������� TkwSetExpiredStyle }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
