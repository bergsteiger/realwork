unit kwPopEditorParaHome;
 {* � ������ ��������� }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorParaHome.pas"
// ���������: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackCursorWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
;

type
 TkwPopEditorParaHome = {final} class(TkwEditorFromStackCursorWord)
  {* � ������ ��������� }
  protected
   procedure DoCursor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow;
    const aPoint: InevBasePoint); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorParaHome
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwPopEditorParaHome.DoCursor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow;
 const aPoint: InevBasePoint);
//#UC START# *50B8BCDF0093_4F73173A01D7_var*
//#UC END# *50B8BCDF0093_4F73173A01D7_var*
begin
//#UC START# *50B8BCDF0093_4F73173A01D7_impl*
 aPoint.MostInner.Move(anEditor.View, ev_ocParaHome);
//#UC END# *50B8BCDF0093_4F73173A01D7_impl*
end;//TkwPopEditorParaHome.DoCursor

class function TkwPopEditorParaHome.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ParaHome';
end;//TkwPopEditorParaHome.GetWordNameForRegister

initialization
 TkwPopEditorParaHome.RegisterInEngine;
 {* ����������� pop_editor_ParaHome }
{$IfEnd} // NOT Defined(NoScripts)

end.
