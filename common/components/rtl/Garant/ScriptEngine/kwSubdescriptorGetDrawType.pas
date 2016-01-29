unit kwSubdescriptorGetDrawType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "kwSubdescriptorGetDrawType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi::ScriptEngine$Everest::SubPanelWords::subdescriptor_GetDrawType
//
// �������� � ���� ��� ����������� ����� � ���� ������ �����.
// ������:
// {code}
// aSubDescrObj subdescriptor:GetDrawType
// {code}
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwSubDescriptorFromStackWord,
  tfwScriptingInterfaces,
  evSubPn
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwSubdescriptorGetDrawType = {final scriptword} class(TkwSubDescriptorFromStackWord)
  {* �������� � ���� ��� ����������� ����� � ���� ������ �����.
������:
[code]
aSubDescrObj subdescriptor:GetDrawType
[code] }
 protected
 // realized methods
   procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
     const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSubdescriptorGetDrawType
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwSubdescriptorGetDrawType

procedure TkwSubdescriptorGetDrawType.DoWithSubDescriptor(aControl: TevSubDescriptor;
  const aCtx: TtfwContext);
//#UC START# *52D65E9502E1_52D65F690396_var*
//#UC END# *52D65E9502E1_52D65F690396_var*
begin
//#UC START# *52D65E9502E1_52D65F690396_impl*
 aCtx.rEngine.PushInt(Ord(aControl.DrawType));
//#UC END# *52D65E9502E1_52D65F690396_impl*
end;//TkwSubdescriptorGetDrawType.DoWithSubDescriptor

class function TkwSubdescriptorGetDrawType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'subdescriptor:GetDrawType';
end;//TkwSubdescriptorGetDrawType.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� subdescriptor_GetDrawType
 TkwSubdescriptorGetDrawType.RegisterInEngine;
{$IfEnd} //not NoScripts

end.