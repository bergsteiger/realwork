unit NOT_FINISHED_DocIntf;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editor"
// Модуль: "w:/archi/source/projects/Archi/Editor/NOT_FINISHED_DocIntf.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Editor::DocIntf::DocIntf
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  dt_Types,
  arTextOfDocument
  ;

type
 TarCustomDocument = class
 protected
 // protected methods
   function GetTextOfDocumentClass: RarTextOfDocument; virtual; abstract;
 end;//TarCustomDocument

 TarSprDocument = class(TarCustomDocument)
 protected
 // realized methods
   function GetTextOfDocumentClass: RarTextOfDocument; override;
 end;//TarSprDocument

 TarDocument = class(TarCustomDocument)
 protected
 // realized methods
   function GetTextOfDocumentClass: RarTextOfDocument; override;
 end;//TarDocument

 TDocAddr = record
   FamID : TFamilyID;
   DocID : TDocID;
 end;//TDocAddr
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  evOutTextParaEliminator,
  arSpravkaTextOfDocument
  ;

// start class TarSprDocument

function TarSprDocument.GetTextOfDocumentClass: RarTextOfDocument;
//#UC START# *4E007EF703CE_4E00742A00F5_var*
//#UC END# *4E007EF703CE_4E00742A00F5_var*
begin
//#UC START# *4E007EF703CE_4E00742A00F5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E007EF703CE_4E00742A00F5_impl*
end;//TarSprDocument.GetTextOfDocumentClass
// start class TarDocument

function TarDocument.GetTextOfDocumentClass: RarTextOfDocument;
//#UC START# *4E007EF703CE_4E00743901FC_var*
//#UC END# *4E007EF703CE_4E00743901FC_var*
begin
//#UC START# *4E007EF703CE_4E00743901FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E007EF703CE_4E00743901FC_impl*
end;//TarDocument.GetTextOfDocumentClass
{$IfEnd} //AppClientSide

end.