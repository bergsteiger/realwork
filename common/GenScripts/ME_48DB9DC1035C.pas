unit evQueryDocumentContainer;

interface

uses
 l3IntfUses
 , nevPrintableDocumentContainer
 , nevTools
 , l3Variant
 , nevDocumentContainer
 , evOpProc
;

type
 TevQueryDocumentContainer = class(TnevPrintableDocumentContainer, InevQueryDocumentContainer)
  procedure Make(aDocument: Tl3Variant);
  procedure Create(aDocument: Tl3Variant);
  function GetCurrPara: Tl3Variant;
  procedure SetCursorToPara(const aPara: InevPara;
   bAtEnd: Boolean;
   aNeedClear: Boolean);
   {* Устанавливает курсор на определенный параграф. }
  procedure ClearCard;
   {* Обработчик очистки КЗ. }
  procedure AfterCollapsed;
  procedure ReleaseListeners;
  procedure LinkListener(const aListener: InevControlListener);
  procedure UnlinkListener(const aListener: InevControlListener);
  function ModelNotify: InevControlListener;
 end;//TevQueryDocumentContainer
 
implementation

uses
 l3ImplUses
 , evQueryCardInt
 , evQueryCardProcessor
 , evControlGenerator
 , evDefaultContext
 , nevBase
;

end.
