unit NOT_FINISHED_DocIntf;

// Модуль: "w:\archi\source\projects\Archi\Editor\NOT_FINISHED_DocIntf.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "DocIntf" MUID: (4E0072C40154)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arTextOfDocument
 , daTypes
 , dt_Types
;

type
 TarCustomDocument = class
  protected
   function GetTextOfDocumentClass: RarTextOfDocument; virtual; abstract;
 end;//TarCustomDocument

 TarSprDocument = class(TarCustomDocument)
  protected
   function GetTextOfDocumentClass: RarTextOfDocument; override;
 end;//TarSprDocument

 TarDocument = class(TarCustomDocument)
  protected
   function GetTextOfDocumentClass: RarTextOfDocument; override;
 end;//TarDocument

 TDocAddr = record
  FamID: TdaFamilyID;
  DocID: TDocID;
 end;//TDocAddr
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , evOutTextParaEliminator
 , arRemoteSaveDocumentHelper
 , arSpravkaTextOfDocument
 //#UC START# *4E0072C40154impl_uses*
 //#UC END# *4E0072C40154impl_uses*
;

function TarSprDocument.GetTextOfDocumentClass: RarTextOfDocument;
//#UC START# *4E007EF703CE_4E00742A00F5_var*
//#UC END# *4E007EF703CE_4E00742A00F5_var*
begin
//#UC START# *4E007EF703CE_4E00742A00F5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E007EF703CE_4E00742A00F5_impl*
end;//TarSprDocument.GetTextOfDocumentClass

function TarDocument.GetTextOfDocumentClass: RarTextOfDocument;
//#UC START# *4E007EF703CE_4E00743901FC_var*
//#UC END# *4E007EF703CE_4E00743901FC_var*
begin
//#UC START# *4E007EF703CE_4E00743901FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E007EF703CE_4E00743901FC_impl*
end;//TarDocument.GetTextOfDocumentClass
{$IfEnd} // Defined(AppClientSide)

end.
