unit kwPopEditorPrintAcnhor;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , nevTools
 , evCustomEditorWindow
;

type
 TkwPopEditorPrintAcnhor = class(TkwEditorFromStackWord)
  {* *Формат:* aTopAnchor anEditorControl pop:editor:PrintAcnhor
*Описание:* Печатает текущее значение якоря, включая дочерние, позицию, PID параграф и т.п. aTopAnchor - true - верхния якорь, false - нижний якорь.
*Пример:*
[code] 
true focused:control:push pop:editor:PrintAcnhor
[code] 
*Результат:* В засимости от значения поля в будет напечатано значение "true" или "false" }
  procedure SaveAnchor(const aCtx: TtfwContext;
   const anAnchor: InevBasePoint;
   anEditor: TevCustomEditorWindow);
  function CheckBaseLine(const aCtx: TtfwContext;
   const anAnchor: InevBasePoint;
   anEditor: TevCustomEditorWindow): Boolean;
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorPrintAcnhor
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

end.
