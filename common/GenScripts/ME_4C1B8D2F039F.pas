unit evdCustomHyperlinkCorrector;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , evdInterfaces
 , k2TagGen
 , k2Base
 , l3Variant
;

type
 TevdCustomHyperlinkCorrector = class(TevdLeafParaFilter)
  {* ‘ильтр исправл€ющий адреса ссылок из F1 }
  function SetTo(var theGenerator: Tk2TagGenerator;
   const aConverter: IevdExternalDocNumberToInternal): Pointer;
  function IsNeedCorrection: Boolean;
  function DoCorrectDocID(const aDocID: Integer): Integer;
  function CheckDocIDBeforeCorrection(const aDocID: Integer): Boolean;
 end;//TevdCustomHyperlinkCorrector
 
implementation

uses
 l3ImplUses
 , HyperLink_Const
 , k2Tags
 , evdTypes
 , Document_Const
;

end.
