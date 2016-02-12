unit kwLoadFromFile;
 {* ��������� ���� � ����� ��������� ������ TPrimTextLoadForm. 
*������:* ���_����� LoadFromFile
*����������:* ������ ���������� ��� ������ DailyTests � ���������� ��������� form:Needs. ��� ����� ����� �������� ��� ���� - ����� ������������� �������� ���� � ������ ��� ������. }

// ������: "w:\common\components\rtl\Garant\Keywords4Daily\kwLoadFromFile.pas"
// ���������: "ScriptKeyword"

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 _LoadUnits_Parent_ = TtfwRegisterableWord;
 {$Include w:\common\components\gui\Garant\Daily\LoadUnits.imp.pas}
 TkwLoadFromFile = {final} class(_LoadUnits_)
  {* ��������� ���� � ����� ��������� ������ TPrimTextLoadForm. 
*������:* ���_����� LoadFromFile
*����������:* ������ ���������� ��� ������ DailyTests � ���������� ��������� form:Needs. ��� ����� ����� �������� ��� ���� - ����� ������������� �������� ���� � ������ ��� ������. }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwLoadFromFile
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , PrimTextLoad_Form
 , Document_Const
;

{$Include w:\common\components\gui\Garant\Daily\LoadUnits.imp.pas}

procedure TkwLoadFromFile.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_509A5CCB022A_var*
var
 l_Form     : TObject;
 l_FileName : String;
//#UC END# *4DAEEDE10285_509A5CCB022A_var*
begin
//#UC START# *4DAEEDE10285_509A5CCB022A_impl*
 if aCtx.rEngine.IsTopObj then
 begin
  l_Form := aCtx.rEngine.PopObj;
  if aCtx.rEngine.IsTopString then
  begin
   l_FileName := aCtx.rEngine.PopDelphiString;
   l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
   with (l_Form as TPrimTextLoadForm) do
   begin
    LoadManager.FileName := l_FileName;
    LoadManager.Load(TextSource, k2_typDocument);
    AfterLoad;
   end // with (aForm as TPrimTextLoadForm) do
  end
  else
   Assert(False, '�� ������ �������� �����!');
 end // if aCtx.rEngine.IsTopObj then
 else
  Assert(False, '�� ������ ����� ��� �������� ������!');
//#UC END# *4DAEEDE10285_509A5CCB022A_impl*
end;//TkwLoadFromFile.DoDoIt

class function TkwLoadFromFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'LoadFromFile';
end;//TkwLoadFromFile.GetWordNameForRegister

initialization
 TkwLoadFromFile.RegisterInEngine;
 {* ����������� LoadFromFile }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(NoVCM)

end.
