unit kwLoadFromFile;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwLoadFromFile = class(TtfwRegisterableWord)
  {* Загружает файл в форму дочернего класса TPrimTextLoadForm. 
*Формат:* имя_файла LoadFromFile
*Примечание:* Создан специально для тестов DailyTests в результате переделок form:Needs. Имя файла можно подавать без пути - будет автоматически добавлен путь к данным для тестов. }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwLoadFromFile
 
implementation

uses
 l3ImplUses
 , PrimTextLoad_Form
 , Document_Const
;

end.
