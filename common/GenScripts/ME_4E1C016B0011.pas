unit DrawOutputSupport.imp;

interface

uses
 l3IntfUses
 , nevShapesPaintedSpy
 , evCustomEditorWindow
 , nevTools
;

type
 _DrawOutputSupport_ = class(InevShapesLogger)
  {* Поддержка сохранения информации об отрисованном в файл для последующего сравнение с эталоном. }
  procedure SaveDrawing(const aText: TevCustomEditorWindow);
   {* Сохранить информацию об отрисованном. }
  procedure DoRepaint(aText: TevCustomEditorWindow);
  function DoOpenLog(const aView: InevView): AnsiString;
  procedure DoCloseLog(const aLogName: AnsiString);
  function OpenLog(const aView: InevView): AnsiString;
  procedure CloseLog(const aLogName: AnsiString);
  function LogScreen(const aView: InevView): Boolean;
 end;//_DrawOutputSupport_
 
implementation

uses
 l3ImplUses
;

end.
