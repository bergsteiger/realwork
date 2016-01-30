unit kwPopEditorParaCoordsToScreen;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaCoordsToScreen.pas"
// ���������: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwParaCoordsToScreen
 , l3Units
 , nevTools
;

type
 TkwPopEditorParaCoordsToScreen = {final} class(TkwParaCoordsToScreen)
  protected
   function GetPoint(const aMap: InevMap): Tl3Point; override;
    {* ���������� �����, �� ������� ����� ������������������. }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorParaCoordsToScreen
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwPopEditorParaCoordsToScreen.GetPoint(const aMap: InevMap): Tl3Point;
 {* ���������� �����, �� ������� ����� ������������������. }
//#UC START# *4C3C927B027E_4EEB66D703A9_var*
//#UC END# *4C3C927B027E_4EEB66D703A9_var*
begin
//#UC START# *4C3C927B027E_4EEB66D703A9_impl*
 Result := l3Point(aMap.Bounds.Left, aMap.Bounds.Top);
//#UC END# *4C3C927B027E_4EEB66D703A9_impl*
end;//TkwPopEditorParaCoordsToScreen.GetPoint

class function TkwPopEditorParaCoordsToScreen.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ParaCoordsToScreen';
end;//TkwPopEditorParaCoordsToScreen.GetWordNameForRegister

initialization
 TkwPopEditorParaCoordsToScreen.RegisterInEngine;
 {* ����������� pop_editor_ParaCoordsToScreen }
{$IfEnd} // NOT Defined(NoScripts)

end.
