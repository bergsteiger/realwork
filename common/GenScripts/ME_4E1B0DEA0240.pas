unit kwPopEditorRepaintAndCheckWithEtalon;
 {* *Описание:*
Перерисовывает редактор сохраняя данные об отриосванном для тестов. Пересовка вызвается принудительно. Все отрисованные до этого данные стираются! Создается файл с именем NNN.shapes - где NNN - номер теста (Внимание! Имя теста дожно начинаться с TK) . Если до этого не существовало эталона, то он создается. О чем сообщается в конце выполнеия теста. Если эталон уже существовал, то производится сравнение новой версии файла с эталоном. Если сравнение не прошло, то об этом будет сообщено (тест будет считаться не прошедшим) и будет вызвана внешняя программа сравнения файлов.
*Формат:*
[code]
anEditor pop:editor:RepaintCheckWithEtalon 
[code]
где anEditor - указатель на редактор, в котором нужно вызвать перерисовку.
*Пример:*
[code]
focused:control:push pop:editor:RepaintCheckWithEtalon 
[code]
Вызывает перисовку в редакторе, где находится фокус. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwPopEditorRepaintAndCheckWithEtalon.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
 , nevTools
 , nevShapesPaintedSpy
;

type
 _kwCheckWithEtalonCommon_Parent_ = TkwEditorFromStackWord;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\kwCheckWithEtalonCommon.imp.pas}
 TkwPopEditorRepaintAndCheckWithEtalon = class(_kwCheckWithEtalonCommon_)
  {* *Описание:*
Перерисовывает редактор сохраняя данные об отриосванном для тестов. Пересовка вызвается принудительно. Все отрисованные до этого данные стираются! Создается файл с именем NNN.shapes - где NNN - номер теста (Внимание! Имя теста дожно начинаться с TK) . Если до этого не существовало эталона, то он создается. О чем сообщается в конце выполнеия теста. Если эталон уже существовал, то производится сравнение новой версии файла с эталоном. Если сравнение не прошло, то об этом будет сообщено (тест будет считаться не прошедшим) и будет вызвана внешняя программа сравнения файлов.
*Формат:*
[code]
anEditor pop:editor:RepaintCheckWithEtalon 
[code]
где anEditor - указатель на редактор, в котором нужно вызвать перерисовку.
*Пример:*
[code]
focused:control:push pop:editor:RepaintCheckWithEtalon 
[code]
Вызывает перисовку в редакторе, где находится фокус. }
  protected
   procedure DoWithEditor(const aCtx: TtfwContext;
    anEditor: TevCustomEditorWindow); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwPopEditorRepaintAndCheckWithEtalon
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , StrUtils
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

{$Include w:\common\components\rtl\Garant\ScriptEngine\kwCheckWithEtalonCommon.imp.pas}

procedure TkwPopEditorRepaintAndCheckWithEtalon.DoWithEditor(const aCtx: TtfwContext;
 anEditor: TevCustomEditorWindow);
//#UC START# *4F4CB81200CA_4E1B0DEA0240_var*
//#UC END# *4F4CB81200CA_4E1B0DEA0240_var*
begin
//#UC START# *4F4CB81200CA_4E1B0DEA0240_impl*
 anEditor.View.ClearShapes;
 ExecuteWithEditor(aCtx, anEditor);
//#UC END# *4F4CB81200CA_4E1B0DEA0240_impl*
end;//TkwPopEditorRepaintAndCheckWithEtalon.DoWithEditor

class function TkwPopEditorRepaintAndCheckWithEtalon.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:editor:RepaintAndCheckWithEtalon';
end;//TkwPopEditorRepaintAndCheckWithEtalon.GetWordNameForRegister

initialization
 TkwPopEditorRepaintAndCheckWithEtalon.RegisterInEngine;
 {* Регистрация pop_editor_RepaintAndCheckWithEtalon }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
