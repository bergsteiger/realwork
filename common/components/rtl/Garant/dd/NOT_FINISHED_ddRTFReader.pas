unit NOT_FINISHED_ddRTFReader;

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_ddRTFReader.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddRTFReader" MUID: (4C971BD4031B)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddCustomRTFReader
 , destNorm
 , ddDocumentAtom
;

type
 TddRTFReader = class(TddCustomRTFReader)
  protected
   function GetdestNormClass: RdestNorm; virtual;
  public
   procedure BeforeClosePara(const aPara: TddDocumentAtom;
    var aNewStyle: Integer); override;
   procedure AddFooterHyperlink; override;
   procedure FootNoteSymbol; override;
 end;//TddRTFReader

implementation

uses
 l3ImplUses
 //#UC START# *4C971BD4031Bimpl_uses*
 //#UC END# *4C971BD4031Bimpl_uses*
;

function TddRTFReader.GetdestNormClass: RdestNorm;
//#UC START# *56BB204702E6_4C971BD4031B_var*
//#UC END# *56BB204702E6_4C971BD4031B_var*
begin
//#UC START# *56BB204702E6_4C971BD4031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *56BB204702E6_4C971BD4031B_impl*
end;//TddRTFReader.GetdestNormClass

procedure TddRTFReader.BeforeClosePara(const aPara: TddDocumentAtom;
 var aNewStyle: Integer);
//#UC START# *534F8F4D0317_4C971BD4031B_var*
//#UC END# *534F8F4D0317_4C971BD4031B_var*
begin
//#UC START# *534F8F4D0317_4C971BD4031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *534F8F4D0317_4C971BD4031B_impl*
end;//TddRTFReader.BeforeClosePara

procedure TddRTFReader.AddFooterHyperlink;
//#UC START# *5624D5E80387_4C971BD4031B_var*
//#UC END# *5624D5E80387_4C971BD4031B_var*
begin
//#UC START# *5624D5E80387_4C971BD4031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5624D5E80387_4C971BD4031B_impl*
end;//TddRTFReader.AddFooterHyperlink

procedure TddRTFReader.FootNoteSymbol;
//#UC START# *562616AD01DF_4C971BD4031B_var*
//#UC END# *562616AD01DF_4C971BD4031B_var*
begin
//#UC START# *562616AD01DF_4C971BD4031B_impl*
 !!! Needs to be implemented !!!
//#UC END# *562616AD01DF_4C971BD4031B_impl*
end;//TddRTFReader.FootNoteSymbol

end.
