unit arDocAttributesMixer;

// Модуль: "w:\archi\source\projects\Common\Utils\arDocAttributesMixer.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "arDocAttributesMixer" MUID: (57C52AA20128)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , l3Filer
 , daTypes
 , k2Base
 , l3MarshalledTypes
 , m4DocumentAddress
 , nevInternalInterfaces
 , k2SizedMemoryPool
 , m3DBInterfaces
;

procedure BuildDocLoadPipe(aDocFamily: TdaFamilyID;
 aDocID: TdaDocID;
 anIsObjTopic: Boolean;
 aDocumentType: Tk2Type;
 aDocPart: Tm3DocPartSelector;
 aLevel: Integer;
 WithAttr: Boolean;
 DocPartSel: TDocPartSelector;
 aFoundSelector: Tm4Addresses;
 var aGen: Tk2TagGenerator;
 var theFiler: Tl3CustomFiler);
function MakeFilerForMessage(aData: Tk2RawData): Tl3CustomFiler;
function MakeFilerForDB(aFamilyID: TdaFamilyID;
 aDocID: TdaDocID = 0;
 aDocPart: Tm3DocPartSelector = m3_defDocPart;
 aLevel: Integer = 0): Tl3CustomFiler;

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_EFltr
 {$IfEnd} // NOT Defined(Nemesis)
 , ddFixFilter
 , ddExtObjectSupport
 , arFiltersUtils
 , evOutTextParaEliminator
 , evTagsListFilter
 , Document_Const
 , k2Tags
 , arDocObjectMixer
 , arFoundSelectionFilter
 , evdBadEVDToEmptyDocumentTranslator
 , daDataProvider
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
 , m3DBFiler
 {$If NOT Defined(Nemesis)}
 , dt_TblCacheDef
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Interfaces
 //#UC START# *57C52AA20128impl_uses*
 //#UC END# *57C52AA20128impl_uses*
;

procedure BuildDocLoadPipe(aDocFamily: TdaFamilyID;
 aDocID: TdaDocID;
 anIsObjTopic: Boolean;
 aDocumentType: Tk2Type;
 aDocPart: Tm3DocPartSelector;
 aLevel: Integer;
 WithAttr: Boolean;
 DocPartSel: TDocPartSelector;
 aFoundSelector: Tm4Addresses;
 var aGen: Tk2TagGenerator;
 var theFiler: Tl3CustomFiler);
//#UC START# *57C52ADD007E_57C52AA20128_var*
//#UC END# *57C52ADD007E_57C52AA20128_var*
begin
//#UC START# *57C52ADD007E_57C52AA20128_impl*
 if WithAttr then
 begin
  TExportFilter.SetTo(aGen, aDocFamily, aDocID, true, false, emLoad, DocPartSel);
 end;

 if WithAttr then
  TddWrongTagFixFilter.SetTo(aGen, false);

 if aDocPart = m3_dsMain then
 begin
  if not anIsObjTopic then
  begin
   //TRecalcHLinksFilter.SetTo(G, aDocFamily, aDocID);
    TddExtObjInserter.SetTo(aGen);
    evLinkTableFilters(aGen, False);
    TevOutTextParaEliminator.SetTo(aGen);
  end
  else
  begin
   TarDocObjectMixer.SetTo(aGen);
  end;
 end;

 //TddKTExtractorFilter.SetTo(aGen);
 if aFoundSelector <> nil then
  TarFoundSelectionFilter.SetTo(aGen, aFoundSelector);

 TFixInternalNumberHandleFilter.SetTo(aGen, aDocID); // гарантированно кладет DocInfo.DocID в InternalHandle
 TevTagsListFilter.SetTo(aGen, TevTagsListFilter.MakeAttrList(k2_typDocument, [k2_tiEditableParts, k2_tiExternalHandle]));
 TevdBadEVDToEmptyDocumentTranslator.SetTo(aGen, aDocumentType, GlobalDataProvider.BaseLanguage[aDocFamily].LanguageID);

 theFiler := MakeFilerForDB(aDocFamily, aDocID, aDocPart, aLevel);
//#UC END# *57C52ADD007E_57C52AA20128_impl*
end;//BuildDocLoadPipe

function MakeFilerForMessage(aData: Tk2RawData): Tl3CustomFiler;
//#UC START# *57D7AD260299_57C52AA20128_var*
var
 l_ComStream: IStream;
//#UC END# *57D7AD260299_57C52AA20128_var*
begin
//#UC START# *57D7AD260299_57C52AA20128_impl*
 l_ComStream := aData as IStream;
 try
  Result := Tl3CustomFiler.Create(nil);
  Result.COMStream := l_ComStream;
 finally
  l_ComStream := nil;
 end;
//#UC END# *57D7AD260299_57C52AA20128_impl*
end;//MakeFilerForMessage

function MakeFilerForDB(aFamilyID: TdaFamilyID;
 aDocID: TdaDocID = 0;
 aDocPart: Tm3DocPartSelector = m3_defDocPart;
 aLevel: Integer = 0): Tl3CustomFiler;
//#UC START# *57D7B69902C0_57C52AA20128_var*
var
 l_DB: Im3DB;
//#UC END# *57D7B69902C0_57C52AA20128_var*
begin
//#UC START# *57D7B69902C0_57C52AA20128_impl*
 l_DB := dtGetDB(aFamilyID);
 try
  Result := Tm3DBFiler.Create(l_DB, aDocID, aDocPart, aLevel);
 finally
  l_DB := nil;
 end;//try..finally
//#UC END# *57D7B69902C0_57C52AA20128_impl*
end;//MakeFilerForDB

end.
