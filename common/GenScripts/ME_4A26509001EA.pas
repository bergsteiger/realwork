unit evCustomEditorWindowModelPart;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
 , nevTools
 , Messages
 , Classes
 , l3ProtoObject
 , l3ControlFontService
 , l3Interfaces
 , Controls
;

type
 TevCustomEditorWindowModelPartFontInfo = class(Tl3ProtoObject, Il3ControlFontService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//TevCustomEditorWindowModelPartFontInfo
 
 TevCustomEditorWindowModelPart = class(TevCustomEditorWindow)
  {* Часть TevCustomEditorWindow, перенесённая на модель }
  procedure ClearUpper;
   {* Очистить информацию о попадании мыши в HotSpot }
  procedure WMNCMouseLeave(var Msg: TMessage);
  procedure WMNCMouseMove(var Msg: TWMNCMouseMove);
 end;//TevCustomEditorWindowModelPart
 
implementation

uses
 l3ImplUses
 , nevGUIInterfaces
 , SysUtils
 , l3Base
 , Windows
 , l3MinMax
 , TtfwClassRef_Proxy
;

end.
