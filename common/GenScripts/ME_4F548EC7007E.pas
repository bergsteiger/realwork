unit kwPopEditorSelectColumn;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorSelectColumn = class(TkwEditorFromStackWord)
  {* *Формат:* aColID anEditorControl pop:editor:SelectCells
*Описание:* Выделяет колонку таблицы. Курсор должен уже находится в таблице. Положение курсора в таблице не имеет значения. Параметры aColID - Integer
*Пример:*
[code] 
2 focused:control:push pop:editor:SelectCells
[code] 
*Результат:* Выделяет вторую колонку. }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorSelectColumn
 
implementation

uses
 l3ImplUses
 , evCursorTools
;

end.
