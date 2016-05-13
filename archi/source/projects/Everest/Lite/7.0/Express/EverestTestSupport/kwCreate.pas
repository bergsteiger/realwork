unit kwCreate;
 {* *Формат:*  Create
*Описание:* Создает новый документ в редакторе.
 *Пример:*
 [code]
Create
 [code]
 *Результат:* Будет создан новый документ. }

// Модуль: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\kwCreate.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "Create" MUID: (512D9C2D013F)
// Имя типа: "TkwCreate"

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwCreate = {final} class(TtfwRegisterableWord)
  {* *Формат:*  Create
*Описание:* Создает новый документ в редакторе.
 *Пример:*
 [code]
Create
 [code]
 *Результат:* Будет создан новый документ. }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwCreate
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EverestLiteAdapter
;

class function TkwCreate.GetWordNameForRegister: AnsiString;
begin
 Result := 'Create';
end;//TkwCreate.GetWordNameForRegister

procedure TkwCreate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_512D9C2D013F_var*
//#UC END# *4DAEEDE10285_512D9C2D013F_var*
begin
//#UC START# *4DAEEDE10285_512D9C2D013F_impl*
 CreateNewDocument;
//#UC END# *4DAEEDE10285_512D9C2D013F_impl*
end;//TkwCreate.DoDoIt

initialization
 TkwCreate.RegisterInEngine;
 {* Регистрация Create }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
