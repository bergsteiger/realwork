unit kwMouseMiddleDown;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwMouseMiddleDown.pas"
// ���������: "ScriptKeyword"
// ������� ������: "Mouse_MiddleDown" MUID: (4F967CF70162)
// ��� ����: "TkwMouseMiddleDown"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwMouseUpDownSupport
;

type
 TkwMouseMiddleDown = {final} class(TkwMouseUpDownSupport)
  protected
   function GetMouseEventFlag: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMouseMiddleDown
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
;

function TkwMouseMiddleDown.GetMouseEventFlag: Integer;
//#UC START# *4F967BED0186_4F967CF70162_var*
//#UC END# *4F967BED0186_4F967CF70162_var*
begin
//#UC START# *4F967BED0186_4F967CF70162_impl*
 Result := MOUSEEVENTF_MIDDLEDOWN;
//#UC END# *4F967BED0186_4F967CF70162_impl*
end;//TkwMouseMiddleDown.GetMouseEventFlag

class function TkwMouseMiddleDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'Mouse:MiddleDown';
end;//TkwMouseMiddleDown.GetWordNameForRegister

initialization
 TkwMouseMiddleDown.RegisterInEngine;
 {* ����������� Mouse_MiddleDown }
{$IfEnd} // NOT Defined(NoScripts)

end.
