unit nevDocumentContainerDecorationRules.imp;

interface

uses
 l3IntfUses
 , nevBase
;

type
 _nevDocumentContainerDecorationRules_ = class
  function GetAllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
  function AllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
   {* Разрешает ли контейтер документа применять указанное декорирование }
 end;//_nevDocumentContainerDecorationRules_
 
implementation

uses
 l3ImplUses
;

end.
