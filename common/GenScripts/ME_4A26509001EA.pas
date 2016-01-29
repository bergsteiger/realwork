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
   {* ��������� ������ ��������� ���������� ��� ��� }
  function GetFont(aControl: TControl): Il3FontInfo;
 end;//TevCustomEditorWindowModelPartFontInfo
 
 TevCustomEditorWindowModelPart = class(TevCustomEditorWindow)
  {* ����� TevCustomEditorWindow, ����������� �� ������ }
  procedure ClearUpper;
   {* �������� ���������� � ��������� ���� � HotSpot }
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
