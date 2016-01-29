unit kwPopEditorCheckWithEtalon;

interface

uses
 l3IntfUses
 , tfwWordWorker
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
;

type
 TkwPopEditorCheckWithEtalon = class(TtfwWordWorker)
  {* *Описание:*
Перерисовывает редактор сохраняя данные об отриосванном для тестов. Сохранение данных об отрисовке вызвается только после выполения функции. Создается файл с именем NNN.shapes - где NNN - номер теста (Внимание! Имя теста дожно начинаться с TK) . Если до этого не существовало эталона, то он создается. О чем сообщается в конце выполнеия теста. Если эталон уже существовал, то производится сравнение новой версии файла с эталоном. Если сравнение не прошло, то об этом будет сообщено (тест будет считаться не прошедшим) и будет вызвана внешняя программа сравнения файлов.
*Формат:*
[code]
anEditor pop:editor:CheckWithEtalon aProc
[code]
где anEditor - указатель на редактор, в котором нужно проверить отрисовку. aProc - процедура, вызывающая отрисовку.
*Пример:*
[code]
focused:control:push pop:editor:CheckWithEtalon "Разделить ячейки таблицы"
[code]
Проверяет отрисовку в редакторе, где находится фокус после выполнения функции "Разделить ячейки таблицы". }
  function CompiledWorkerClass(const aCtx: TtfwContext): RkwCompiledWordWorker;
 end;//TkwPopEditorCheckWithEtalon
 
implementation

uses
 l3ImplUses
 , kwCompiledCheckWithEtalon
;

end.
