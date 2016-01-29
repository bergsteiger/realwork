unit nevPrintView;

interface

uses
 l3IntfUses
 , nevBaseDetachedView
 , nevTools
 , evdStyles
 , nevBase
;

type
 TnevPrintView = class(TnevBaseDetachedView, InevPrintView)
  {* Область вывода для печати. }
  procedure Create(const aText: InevObject;
   const aCanvas: InevCanvas;
   aHiddenStyles: TevStandardStyles);
  function Make(const aText: InevObject;
   const aCanvas: InevCanvas;
   aHiddenStyles: TevStandardStyles): InevPrintView;
 end;//TnevPrintView
 
implementation

uses
 l3ImplUses
 , l3MinMax
 , evdTypes
 , evTextStyle_Const
 , k2Tags
;

end.
