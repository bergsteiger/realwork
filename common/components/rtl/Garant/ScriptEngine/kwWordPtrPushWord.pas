unit kwWordPtrPushWord;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwWordPtrPushWord.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwWordPtrWorker
 , tfwScriptingInterfaces
 , l3Interfaces
;

type
 TkwWordPtrPushWord = class(TkwWordPtrWorker)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetRef(const aCtx: TtfwContext): TtfwWord; override;
   function WordName: Il3CString; override;
 end;//TkwWordPtrPushWord
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TkwWordPtrPushWord.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F37AEBB0209_var*
//#UC END# *4DAEEDE10285_4F37AEBB0209_var*
begin
//#UC START# *4DAEEDE10285_4F37AEBB0209_impl*
 aCtx.rEngine.PushObj(f_Word);
//#UC END# *4DAEEDE10285_4F37AEBB0209_impl*
end;//TkwWordPtrPushWord.DoDoIt

function TkwWordPtrPushWord.GetRef(const aCtx: TtfwContext): TtfwWord;
//#UC START# *558D2BCA0324_4F37AEBB0209_var*
//#UC END# *558D2BCA0324_4F37AEBB0209_var*
begin
//#UC START# *558D2BCA0324_4F37AEBB0209_impl*
 Result := f_Word;
 Result := Result.GetRef(aCtx);
//#UC END# *558D2BCA0324_4F37AEBB0209_impl*
end;//TkwWordPtrPushWord.GetRef

function TkwWordPtrPushWord.WordName: Il3CString;
//#UC START# *55AFD7DA0258_4F37AEBB0209_var*
//#UC END# *55AFD7DA0258_4F37AEBB0209_var*
begin
//#UC START# *55AFD7DA0258_4F37AEBB0209_impl*
 Result := f_Word.WordName;
//#UC END# *55AFD7DA0258_4F37AEBB0209_impl*
end;//TkwWordPtrPushWord.WordName

initialization
 TkwWordPtrPushWord.RegisterClass;
 {* Регистрация TkwWordPtrPushWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
