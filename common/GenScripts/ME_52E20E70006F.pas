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
  {* Формат:
[code]
aFileName ImageEnViewer:SaveBitmap
[code]
где aFileName - имя файла, куда сохранять. }
  procedure DoWithImageEn(aControl: TImageEnView;
   const aCtx: TtfwContext);
 end;//TkwImageEnViewerSaveBitmap
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
