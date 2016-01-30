unit kwPopEditorResizeTableColumn;
 {* Изменить размер колонки таблицы. Пример:
[code]   aDelta aCol aRow editor:ResizeTableColumn [code]
[panel]
 * aCol - номер ячейки, которую тянем
 * aRow - номер строки
 * aDelta - смещение колонки (положительное - вправо, отрицательное - влево).
[panel] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumn.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackTableColumnResize
;

type
 TkwPopEditorResizeTableColumn = class(TkwEditorFromStackTableColumnResize)
  {* Изменить размер колонки таблицы. Пример:
[code]   aDelta aCol aRow editor:ResizeTableColumn [code]
[panel]
 * aCol - номер ячейки, которую тянем
 * aRow - номер строки
 * aDelta - смещение колонки (положительное - вправо, отрицательное - влево).
[panel] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorResizeTableColumn
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

class function TkwPopEditorResizeTableColumn.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ResizeTableColumn';
end;//TkwPopEditorResizeTableColumn.GetWordNameForRegister

initialization
 TkwPopEditorResizeTableColumn.RegisterInEngine;
 {* Регистрация pop_editor_ResizeTableColumn }
{$IfEnd} // NOT Defined(NoScripts)

end.
