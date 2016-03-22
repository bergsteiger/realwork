unit kwSaveWithOtherExtention;
 {* *������:*  ���������� SaveWithOtherExtention
*��������:*  ��������� ������� �������� ���� � ��������� ��� ��� �� ������, �� � ������ ����������, �������� ����� �������� "����������" 
 *������:*
 [code]
'.nsr' SaveWithOtherExtention
 [code]
*���������:* �������� ���� � ��������� ����� �������� � ����������� nsr (� ��������������� � ������ NSRC, ���� �����). }

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwSaveWithOtherExtention.pas"
// ���������: "ScriptKeyword"
// ������� ������: "SaveWithOtherExtention" MUID: (512DD336009D)
// ��� ����: "TkwSaveWithOtherExtention"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwSaveWithOtherExtention = {final} class(TtfwRegisterableWord)
  {* *������:*  ���������� SaveWithOtherExtention
*��������:*  ��������� ������� �������� ���� � ��������� ��� ��� �� ������, �� � ������ ����������, �������� ����� �������� "����������" 
 *������:*
 [code]
'.nsr' SaveWithOtherExtention
 [code]
*���������:* �������� ���� � ��������� ����� �������� � ����������� nsr (� ��������������� � ������ NSRC, ���� �����). }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSaveWithOtherExtention
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
 , SysUtils
;

procedure TkwSaveWithOtherExtention.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_512DD336009D_var*
var
 l_FileExt  : String;
 l_FileName : String;
//#UC END# *4DAEEDE10285_512DD336009D_var*
begin
//#UC START# *4DAEEDE10285_512DD336009D_impl*
 if aCtx.rEngine.IsTopString then
 begin
  l_FileExt := aCtx.rEngine.PopDelphiString;
  l_FileName := ChangeFileExt(aCtx.rStreamFactory.Filename, l_FileExt);
  l_FileName := ExtractFileName(l_FileName);
  l_FileName := aCtx.rCaller.ResolveInputFilePath(l_FileName);
  SaveDocumentAs(l_FileName);
 end // if aCtx.rEngine.IsTopString then
 else
  Assert(False, '�� ������ ����� ����������!');
//#UC END# *4DAEEDE10285_512DD336009D_impl*
end;//TkwSaveWithOtherExtention.DoDoIt

class function TkwSaveWithOtherExtention.GetWordNameForRegister: AnsiString;
begin
 Result := 'SaveWithOtherExtention';
end;//TkwSaveWithOtherExtention.GetWordNameForRegister

initialization
 TkwSaveWithOtherExtention.RegisterInEngine;
 {* ����������� SaveWithOtherExtention }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
