unit kwTextFormGetDocumentID;
 {* Возвращает идентификатор текущего открытого документа }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Shell_Words\kwTextFormGetDocumentID.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "TkwTextFormGetDocumentID" MUID: (4F1942440116)

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwExTextFormWord
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , ExText_Form
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , tfwScriptingInterfaces
;

type
 TkwTextFormGetDocumentID = class(TkwExTextFormWord)
  {* Возвращает идентификатор текущего открытого документа }
  protected
   procedure DoTextForm(aForm: TExTextForm;
    const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTextFormGetDocumentID
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nsConst
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TExTextFormHack = class({$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 TExTextForm
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 )
 end;//TExTextFormHack

procedure TkwTextFormGetDocumentID.DoTextForm(aForm: TExTextForm;
 const aCtx: TtfwContext);
//#UC START# *4DCA5B340360_4F1942440116_var*
var
 l_ID : Integer;
//#UC END# *4DCA5B340360_4F1942440116_var*
begin
//#UC START# *4DCA5B340360_4F1942440116_impl*
 l_ID := 0;
 try
  if (TExTextFormHack(aForm).Document <> nil) then
   l_ID := TExTextFormHack(aForm).Document.GetInternalId{ + c_InternalDocShift};
 finally
  aCtx.rEngine.PushInt(l_ID);
 end;//try..finally
//#UC END# *4DCA5B340360_4F1942440116_impl*
end;//TkwTextFormGetDocumentID.DoTextForm

class function TkwTextFormGetDocumentID.GetWordNameForRegister: AnsiString;
begin
 Result := 'textform:GetDocumentID';
end;//TkwTextFormGetDocumentID.GetWordNameForRegister

initialization
 TkwTextFormGetDocumentID.RegisterInEngine;
 {* Регистрация TkwTextFormGetDocumentID }
{$IfEnd} // NOT Defined(NoScripts)

end.
