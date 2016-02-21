unit kwSubdescriptorGetDrawType;
 {* �������� � ���� ��� ����������� ����� � ���� ������ �����.
������:
[code]
aSubDescrObj subdescriptor:GetDrawType
[code] }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwSubdescriptorGetDrawType.pas"
// ���������: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSubDescriptorFromStackWord
 , evSubPn
 , tfwScriptingInterfaces
;

type
 TkwSubdescriptorGetDrawType = {final} class(TkwSubDescriptorFromStackWord)
  {* �������� � ���� ��� ����������� ����� � ���� ������ �����.
������:
[code]
aSubDescrObj subdescriptor:GetDrawType
[code] }
  protected
   procedure DoWithSubDescriptor(aControl: TevSubDescriptor;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwSubdescriptorGetDrawType
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

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
begin
 Result := 'subdescriptor:GetDrawType';
end;//TkwSubdescriptorGetDrawType.GetWordNameForRegister

initialization
 TkwSubdescriptorGetDrawType.RegisterInEngine;
 {* ����������� subdescriptor_GetDrawType }
{$IfEnd} // NOT Defined(NoScripts)

end.
