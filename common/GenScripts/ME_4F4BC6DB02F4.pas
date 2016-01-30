unit kwForwardDeclarationHolder;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwForwardDeclarationHolder.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
;

type
 TkwForwardDeclarationHolder = class(TtfwWord)
  private
   f_Holded: TtfwWord;
    {* Поле для свойства Holded }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aHolded: TtfwWord); reintroduce;
   function GetRef(const aCtx: TtfwContext): TtfwWord; override;
   function WordName: Il3CString; override;
  public
   property Holded: TtfwWord
    read f_Holded;
 end;//TkwForwardDeclarationHolder
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

constructor TkwForwardDeclarationHolder.Create(aHolded: TtfwWord);
//#UC START# *52D405B300E2_4F4BC6DB02F4_var*
//#UC END# *52D405B300E2_4F4BC6DB02F4_var*
begin
//#UC START# *52D405B300E2_4F4BC6DB02F4_impl*
 inherited Create;
 f_Holded := aHolded;
//#UC END# *52D405B300E2_4F4BC6DB02F4_impl*
end;//TkwForwardDeclarationHolder.Create

procedure TkwForwardDeclarationHolder.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F4BC6DB02F4_var*
//#UC END# *4DAEEDE10285_4F4BC6DB02F4_var*
begin
//#UC START# *4DAEEDE10285_4F4BC6DB02F4_impl*
 RunnerAssert(f_Holded <> nil, 'Невалидная ссылка на слово', aCtx);
 f_Holded.DoIt(aCtx);
//#UC END# *4DAEEDE10285_4F4BC6DB02F4_impl*
end;//TkwForwardDeclarationHolder.DoDoIt

procedure TkwForwardDeclarationHolder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F4BC6DB02F4_var*
//#UC END# *479731C50290_4F4BC6DB02F4_var*
begin
//#UC START# *479731C50290_4F4BC6DB02F4_impl*
 f_Holded := nil;
 inherited;
//#UC END# *479731C50290_4F4BC6DB02F4_impl*
end;//TkwForwardDeclarationHolder.Cleanup

function TkwForwardDeclarationHolder.GetRef(const aCtx: TtfwContext): TtfwWord;
//#UC START# *558D2BCA0324_4F4BC6DB02F4_var*
//#UC END# *558D2BCA0324_4F4BC6DB02F4_var*
begin
//#UC START# *558D2BCA0324_4F4BC6DB02F4_impl*
 //Result := inherited GetRef(aCtx);
 Result := f_Holded;
 Result := Result.GetRef(aCtx);
//#UC END# *558D2BCA0324_4F4BC6DB02F4_impl*
end;//TkwForwardDeclarationHolder.GetRef

function TkwForwardDeclarationHolder.WordName: Il3CString;
//#UC START# *55AFD7DA0258_4F4BC6DB02F4_var*
//#UC END# *55AFD7DA0258_4F4BC6DB02F4_var*
begin
//#UC START# *55AFD7DA0258_4F4BC6DB02F4_impl*
 Result := f_Holded.WordName;
//#UC END# *55AFD7DA0258_4F4BC6DB02F4_impl*
end;//TkwForwardDeclarationHolder.WordName

initialization
 TkwForwardDeclarationHolder.RegisterClass;
 {* Регистрация TkwForwardDeclarationHolder }
{$IfEnd} // NOT Defined(NoScripts)

end.
