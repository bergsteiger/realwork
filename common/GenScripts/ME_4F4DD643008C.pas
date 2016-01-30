unit kwPopEditorSelectCells;
 {* *Формат:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCells
*Описание:* Выделяет диапазон ячеек с помощью мыши начиная от начальной (aStartCell, aRowCell) до конечной (aFinishCell, aFinishRow). Курсор должен уже находится в таблице. Положение курсора в таблице не имеет значения. Параметры aStartCell aStartRow aFinshCell aFinishRow - Integer
*Пример:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCells
[code] 
*Результат:* Выделяет диапазон ячеек в таблице от (0, 0) до (2, 2) у текущего редактора.
*Примечание:* В каждой ячейке должен быть только один параграф, иначе выделение будет неправильным.
*Примечание 2:* Текст в начальной ячейке должен быть выровнен по левому краю. Иначе  появится сообщение об ошибке. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCells.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSelectCellsWord
;

type
 TkwPopEditorSelectCells = {final} class(TkwSelectCellsWord)
  {* *Формат:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCells
*Описание:* Выделяет диапазон ячеек с помощью мыши начиная от начальной (aStartCell, aRowCell) до конечной (aFinishCell, aFinishRow). Курсор должен уже находится в таблице. Положение курсора в таблице не имеет значения. Параметры aStartCell aStartRow aFinshCell aFinishRow - Integer
*Пример:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCells
[code] 
*Результат:* Выделяет диапазон ячеек в таблице от (0, 0) до (2, 2) у текущего редактора.
*Примечание:* В каждой ячейке должен быть только один параграф, иначе выделение будет неправильным.
*Примечание 2:* Текст в начальной ячейке должен быть выровнен по левому краю. Иначе  появится сообщение об ошибке. }
  protected
   function IsVertical: Boolean; override;
    {* При выделении мышь движется сверху вниз. }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSelectCells
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
;

function TkwPopEditorSelectCells.IsVertical: Boolean;
 {* При выделении мышь движется сверху вниз. }
//#UC START# *4F6042D20081_4F4DD643008C_var*
//#UC END# *4F6042D20081_4F4DD643008C_var*
begin
//#UC START# *4F6042D20081_4F4DD643008C_impl*
 Result := False;
//#UC END# *4F6042D20081_4F4DD643008C_impl*
end;//TkwPopEditorSelectCells.IsVertical

class function TkwPopEditorSelectCells.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SelectCells';
end;//TkwPopEditorSelectCells.GetWordNameForRegister

initialization
 TkwPopEditorSelectCells.RegisterInEngine;
 {* Регистрация pop_editor_SelectCells }
{$IfEnd} // NOT Defined(NoScripts)

end.
