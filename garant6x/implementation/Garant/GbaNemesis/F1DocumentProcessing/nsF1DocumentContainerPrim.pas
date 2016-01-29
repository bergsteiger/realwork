unit nsF1DocumentContainerPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1DocumentProcessing"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1DocumentProcessing/nsF1DocumentContainerPrim.pas"
// Начат: 17.08.2010 16:10
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::F1DocumentProcessing::F1DocumentContainers::TnsF1DocumentContainerPrim
//
// Базовый контейнер документа для F1
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If defined(Nemesis)}
  ,
  eeDocumentContainer
  {$IfEnd} //Nemesis
  ,
  l3Variant,
  nevTools
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 RnsF1DocumentContainerPrim = class of TnsF1DocumentContainerPrim;

 TnsF1DocumentContainerPrim = class(TeeDocumentContainer)
  {* Базовый контейнер документа для F1 }
 protected
 // overridden protected methods
   function DoFindParaByID(const aDocument: InevObject;
    aParaID: Integer;
    out aPara: InevObject): Boolean; override;
   function DoGetSubEx(anID: Integer;
    aLayerID: Integer): IevSub; override;
 protected
 // protected methods
   function DocumentForFindPara: Tl3Tag; virtual;
   function CanFindParaAsNode: Boolean; virtual;
 end;//TnsF1DocumentContainerPrim
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  LeafPara_Const,
  nsTagNodeToolsNew,
  nsDocumentContainerSub
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsF1DocumentContainerPrim

function TnsF1DocumentContainerPrim.DocumentForFindPara: Tl3Tag;
//#UC START# *506982B0037E_4C6A7C010114_var*
//#UC END# *506982B0037E_4C6A7C010114_var*
begin
//#UC START# *506982B0037E_4C6A7C010114_impl*
 Result := Self.Document;
//#UC END# *506982B0037E_4C6A7C010114_impl*
end;//TnsF1DocumentContainerPrim.DocumentForFindPara

function TnsF1DocumentContainerPrim.CanFindParaAsNode: Boolean;
//#UC START# *4A79B7020303_4C6A7C010114_var*
//#UC END# *4A79B7020303_4C6A7C010114_var*
begin
//#UC START# *4A79B7020303_4C6A7C010114_impl*
 Result := true;
//#UC END# *4A79B7020303_4C6A7C010114_impl*
end;//TnsF1DocumentContainerPrim.CanFindParaAsNode

function TnsF1DocumentContainerPrim.DoFindParaByID(const aDocument: InevObject;
  aParaID: Integer;
  out aPara: InevObject): Boolean;
//#UC START# *47F11C2103DC_4C6A7C010114_var*
var
 l_Para : Tl3Variant;
//#UC END# *47F11C2103DC_4C6A7C010114_var*
begin
//#UC START# *47F11C2103DC_4C6A7C010114_impl*
 if CanFindParaAsNode then
 begin
  Result := false;
  l_Para := nsFindTagByID(DocumentForFindPara, k2_typLeafPara, aParaID);
  if (l_Para <> nil) AND l_Para.IsValid AND
     l_Para.QT(InevPara, aPara, Processor) then
    Result := true;
 end//(f_DocumentInfo <> nil)
 else
  Result := inherited DoFindParaByID(aDocument, aParaID, aPara);
//#UC END# *47F11C2103DC_4C6A7C010114_impl*
end;//TnsF1DocumentContainerPrim.DoFindParaByID

function TnsF1DocumentContainerPrim.DoGetSubEx(anID: Integer;
  aLayerID: Integer): IevSub;
//#UC START# *47F27721012A_4C6A7C010114_var*
//#UC END# *47F27721012A_4C6A7C010114_var*
begin
//#UC START# *47F27721012A_4C6A7C010114_impl*
(* if CanFindParaAsNode then*)
  Result := TnsDocumentContainerSub.Make(Document.AsObject, Processor, anID, aLayerID)
(* else
  Result := inherited DoGetSubEx(anID, aLayerID)*);
//#UC END# *47F27721012A_4C6A7C010114_impl*
end;//TnsF1DocumentContainerPrim.DoGetSubEx

{$IfEnd} //not Admin AND not Monitorings

end.