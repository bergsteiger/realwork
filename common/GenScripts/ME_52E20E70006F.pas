unit kwImageEnViewerSaveBitmap;

interface

uses
 l3IntfUses
 , kwImageEnControl
 , imageenview
 , tfwScriptingInterfaces
;

type
 TkwImageEnViewerSaveBitmap = class(TkwImageEnControl)
  {* ������:
[code]
aFileName ImageEnViewer:SaveBitmap
[code]
��� aFileName - ��� �����, ���� ���������. }
  procedure DoWithImageEn(aControl: TImageEnView;
   const aCtx: TtfwContext);
 end;//TkwImageEnViewerSaveBitmap
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
