unit kwPopEditorSelectCellsVertical;
 {* *Формат:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCellsVertical
*Описание:* Выделяет диапазон ячеек с помощью мыши начиная от начальной (aStartCell, aRowCell) до конечной (aFinishCell, aFinishRow). Курсор должен уже находится в таблице. Положение курсора в таблице не имеет значения. Параметры aStartCell aStartRow aFinshCell aFinishRow - Integer
*Пример:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCellsVertical
[code] 
*Результат:* Выделяет диапазон ячеек в таблице от (0, 0) до (2, 2) у текущего редактора.
*Примечание:* В каждой ячейке должен быть только один параграф, иначе выделение будет неправильным.
*Примечание 2:* Текст в начальной ячейке должен быть выровнен по левому краю. Иначе  появится сообщение об ошибке. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorSelectCellsVertical.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_SelectCellsVertical" MUID: (4F6044140356)
// Имя типа: "TkwPopEditorSelectCellsVertical"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwSelectCellsWord
;

type
 TkwPopEditorSelectCellsVertical = {final} class(TkwSelectCellsWord)
  {* *Формат:* aStartCell aStartRow aFinshCell aFinishRow anEditorControl pop:editor:SelectCellsVertical
*Описание:* Выделяет диапазон ячеек с помощью мыши начиная от начальной (aStartCell, aRowCell) до конечной (aFinishCell, aFinishRow). Курсор должен уже находится в таблице. Положение курсора в таблице не имеет значения. Параметры aStartCell aStartRow aFinshCell aFinishRow - Integer
*Пример:*
[code] 
0 0 2 2 focused:control:push pop:editor:SelectCellsVertical
[code] 
*Результат:* Выделяет диапазон ячеек в таблице от (0, 0) до (2, 2) у текущего редактора.
*Примечание:* В каждой ячейке должен быть только один параграф, иначе выделение будет неправильным.
*Примечание 2:* Текст в начальной ячейке должен быть выровнен по левому краю. Иначе  появится сообщение об ошибке. }
  protected
   function IsVertical: Boolean; override;
    {* При выделении мышь движется сверху вниз. }
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorSelectCellsVertical
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

function TkwPopEditorSelectCellsVertical.IsVertical: Boolean;
 {* При выделении мышь движется сверху вниз. }
//#UC START# *4F6042D20081_4F6044140356_var*
//#UC END# *4F6042D20081_4F6044140356_var*
begin
//#UC START# *4F6042D20081_4F6044140356_impl*
 Result := True;
//#UC END# *4F6042D20081_4F6044140356_impl*
end;//TkwPopEditorSelectCellsVertical.IsVertical

class function TkwPopEditorSelectCellsVertical.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:SelectCellsVertical';
end;//TkwPopEditorSelectCellsVertical.GetWordNameForRegister

initialization
 TkwPopEditorSelectCellsVertical.RegisterInEngine;
 {* Регистрация pop_editor_SelectCellsVertical }
{$IfEnd} // NOT Defined(NoScripts)

end.
