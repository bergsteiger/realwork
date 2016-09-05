unit kwPopEditorResizeTableColumnEX;
 {* Изменить размер колонки таблицы. Пример:
[code]   aDelta aKeys aCol aRow editor:ResizeTableColumnEX[code]
[panel]
 * aCol - номер ячейки, которую тянем
 * aRow - номер строки
 * aKeys - клавиша, нажатая при изменении размеров.
 * aDelta - смещение колонки (положительное - вправо, отрицательное - влево).
[panel] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorResizeTableColumnEX.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "pop_editor_ResizeTableColumnEX" MUID: (4E37BEF102EE)
// Имя типа: "TkwPopEditorResizeTableColumnEX"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackTableColumnResize
 , Classes
;

type
 TkwPopEditorResizeTableColumnEX = class(TkwEditorFromStackTableColumnResize)
  {* Изменить размер колонки таблицы. Пример:
[code]   aDelta aKeys aCol aRow editor:ResizeTableColumnEX[code]
[panel]
 * aCol - номер ячейки, которую тянем
 * aRow - номер строки
 * aKeys - клавиша, нажатая при изменении размеров.
 * aDelta - смещение колонки (положительное - вправо, отрицательное - влево).
[panel] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetKeys: TShiftState; override;
 end;//TkwPopEditorResizeTableColumnEX
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingInterfaces
 , evOp
 , CommentPara_Const
 , TextPara_Const
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4E37BEF102EEimpl_uses*
 //#UC END# *4E37BEF102EEimpl_uses*
;

class function TkwPopEditorResizeTableColumnEX.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:ResizeTableColumnEX';
end;//TkwPopEditorResizeTableColumnEX.GetWordNameForRegister

function TkwPopEditorResizeTableColumnEX.GetKeys: TShiftState;
//#UC START# *4E32CA120170_4E37BEF102EE_var*
var
 l_Value: Integer;
//#UC END# *4E32CA120170_4E37BEF102EE_var*
begin
//#UC START# *4E32CA120170_4E37BEF102EE_impl*
 l_Value := ItfwScriptEngine(f_Engine).PopInt;
 case l_Value of
  0: Result := [];
  1: Result := [ssShift];
  2: Result := [ssAlt];
  3: Result := [ssCtrl];
  else
   Assert(False, 'Другие значения не поддерживаются.')
 end;
//#UC END# *4E32CA120170_4E37BEF102EE_impl*
end;//TkwPopEditorResizeTableColumnEX.GetKeys

initialization
 TkwPopEditorResizeTableColumnEX.RegisterInEngine;
 {* Регистрация pop_editor_ResizeTableColumnEX }
{$IfEnd} // NOT Defined(NoScripts)

end.
