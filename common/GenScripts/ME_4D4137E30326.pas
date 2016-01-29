unit SelectOperation.imp;

interface

uses
 l3IntfUses
 , evCustomEditorWindow
;

type
 _SelectOperation_ = class
  {* Поддержка выделения параграфа, документа и т.п. }
  procedure SelectPara(aText: TevCustomEditorWindow);
   {* Выделить параграф целиком }
  procedure SelectDocument(aText: TevCustomEditorWindow);
   {* Выделить документ целиком }
 end;//_SelectOperation_
 
implementation

uses
 l3ImplUses
 , evTypes
;

end.
