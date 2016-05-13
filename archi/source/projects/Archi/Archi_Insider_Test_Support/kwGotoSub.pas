unit kwGotoSub;
 {* ����_���������:�������_�_����� }

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwGotoSub.pas"
// ���������: "ScriptKeyword"
// ������� ������: "TkwGotoSub" MUID: (4EEF07E80201)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwGotoSub = class(TtfwRegisterableWord)
  {* ����_���������:�������_�_����� }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwGotoSub
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , arArchiTestsAdapter
;

class function TkwGotoSub.GetWordNameForRegister: AnsiString;
begin
 Result := '����_���������:�������_�_�����';
end;//TkwGotoSub.GetWordNameForRegister

procedure TkwGotoSub.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4EEF07E80201_var*
var
 l_Index: Integer;
//#UC END# *4DAEEDE10285_4EEF07E80201_var*
begin
//#UC START# *4DAEEDE10285_4EEF07E80201_impl*
 if aCtx.rEngine.IsTopInt then
  l_Index := aCtx.rEngine.PopInt
 else
  Assert(False, '�� ����� ����� �����!');
 ArGotoSub(l_Index);
//#UC END# *4DAEEDE10285_4EEF07E80201_impl*
end;//TkwGotoSub.DoDoIt

initialization
 TkwGotoSub.RegisterInEngine;
 {* ����������� TkwGotoSub }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
