unit kwPopEditorRepaintAndCheckWithEtalon;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorRepaintAndCheckWithEtalon = class(TkwEditorFromStackWord)
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
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorRepaintAndCheckWithEtalon
 
implementation

uses
 l3ImplUses
 , SysUtils
 , StrUtils
 , nevTools
;

end.
