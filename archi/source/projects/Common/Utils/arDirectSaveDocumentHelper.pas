unit arDirectSaveDocumentHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arDirectSaveDocumentHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarDirectSaveDocumentHelper" MUID: (57E2715500C8)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , arCustomSaveDocumentHelper
 , daTypes
 , l3MarshalledTypes
 {$If NOT Defined(Nemesis)}
 , dt_IFltr
 {$IfEnd} // NOT Defined(Nemesis)
 , nevInternalInterfaces
;

type
 TarDirectSaveDocumentHelper = class(TarCustomSaveDocumentHelper)
  private
   f_NeedOpenFiler: Boolean;
  private
   procedure BuildDocSavePipe(aDocFamily: TdaFamilyID;
    aDocID: TdaDocID;
    anIsObjTopic: Boolean;
    aEraseNotify: TdtOnEraseAttrRecords;
    var aGen: Tk2TagGenerator);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFamily: TdaFamilyID;
    anID: TdaDocID;
    aClass: TdaDocType;
    aPart: Tm3DocPartSelector;
    ParseToDB: Boolean;
    NeedSaveText: Boolean;
    IsClassChanged: Boolean;
    aEraseNotify: TdtOnEraseAttrRecords;
    anIsObjTopic: Boolean); reintroduce;
   function SaveDoc: Boolean; override;
   procedure HandleException; override;
 end;//TarDirectSaveDocumentHelper

implementation

uses
 l3ImplUses
 , dt_Types
 , l3Types
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
 , m3DBInterfaces
 , m3DBFiler
 , evdNativeWriter
 , arDocAttributesMixer
 , ddExtObjectSupport
 {$If NOT Defined(Nemesis)}
 , dt_TblCacheDef
 {$IfEnd} // NOT Defined(Nemesis)
 //#UC START# *57E2715500C8impl_uses*
 //#UC END# *57E2715500C8impl_uses*
;

constructor TarDirectSaveDocumentHelper.Create(aFamily: TdaFamilyID;
 anID: TdaDocID;
 aClass: TdaDocType;
 aPart: Tm3DocPartSelector;
 ParseToDB: Boolean;
 NeedSaveText: Boolean;
 IsClassChanged: Boolean;
 aEraseNotify: TdtOnEraseAttrRecords;
 anIsObjTopic: Boolean);
//#UC START# *57E272BE029B_57E2715500C8_var*
//#UC END# *57E272BE029B_57E2715500C8_var*
begin
//#UC START# *57E272BE029B_57E2715500C8_impl*
 inherited Create;
 Filer := MakeFilerForDB(aFamily, anID, aPart);
 Filer.Mode := l3_fmReadWrite;
 f_NeedOpenFiler := (aClass <> dtNone) and NeedSaveText;
 if f_NeedOpenFiler then
  Filer.Open;
 if IsClassChanged and (Tm3DBFiler(Filer).Part <> nil) then
  Tm3DBFiler(Filer).Part.Info := Tm3DBDocumentInfo_C(ord(aClass));

 f_Generator := nil;
 if NeedSaveText then
 begin
  TevdNativeWriter.SetTo(f_Generator);
  with TevdNativeWriter(f_Generator) do
  begin
   Filer := Self.Filer;
   Binary := true;
  end;
 end;

 if ParseToDB then
  BuildDocSavePipe(aFamily, anID, anIsObjTopic, aEraseNotify, f_Generator);
//#UC END# *57E272BE029B_57E2715500C8_impl*
end;//TarDirectSaveDocumentHelper.Create

procedure TarDirectSaveDocumentHelper.BuildDocSavePipe(aDocFamily: TdaFamilyID;
 aDocID: TdaDocID;
 anIsObjTopic: Boolean;
 aEraseNotify: TdtOnEraseAttrRecords;
 var aGen: Tk2TagGenerator);
//#UC START# *57CFF0F8008A_57E2715500C8_var*
//#UC END# *57CFF0F8008A_57E2715500C8_var*
begin
//#UC START# *57CFF0F8008A_57E2715500C8_impl*
 if not (anIsObjTopic) then
 begin
  //TddImageHandleInsertFilter.SetTo(aGen);
  // - этот функционал переехал в TddSavedObjectsList и TddExtObjExtractor
  TddExtObjExtractor.SetTo(aGen);
 end;
 //else
 // TarDocObjectAdder.SetTo(G, TarDocObject(anAdditionalData));

  // устанавливает фильтр, который укладывает данные в СУБД
  with TDBFilter(TDocSaveDBFilter.SetTo(aGen)) do
  begin
   Family := aDocFamily;
   CurDocID := aDocID;
   InternalFormat := True;
   SaveMode := smSave;
   ExcludeAttr := CctAllAttributes; // рассчитывается через k2_tiEditablePartsв TDocSaveDBFilter,
                                    // если k2_tiEditableParts не придет атрибуты записываться не будут
   ExcludeMainRec := True;          // см. выше

   NeedEventforEraseAttrRec := [ctKW];
   OnEraseAttrRecords := aEraseNotify;
  end;
//#UC END# *57CFF0F8008A_57E2715500C8_impl*
end;//TarDirectSaveDocumentHelper.BuildDocSavePipe

function TarDirectSaveDocumentHelper.SaveDoc: Boolean;
//#UC START# *57E270CF032F_57E2715500C8_var*
//#UC END# *57E270CF032F_57E2715500C8_var*
begin
//#UC START# *57E270CF032F_57E2715500C8_impl*
 if f_NeedOpenFiler then
  Filer.Close;
 f_NeedOpenFiler := False;
 Result := True;
//#UC END# *57E270CF032F_57E2715500C8_impl*
end;//TarDirectSaveDocumentHelper.SaveDoc

procedure TarDirectSaveDocumentHelper.HandleException;
//#UC START# *57E270DD0210_57E2715500C8_var*
//#UC END# *57E270DD0210_57E2715500C8_var*
begin
//#UC START# *57E270DD0210_57E2715500C8_impl*
 if Filer.Opened then
  Filer.Rollback;
//#UC END# *57E270DD0210_57E2715500C8_impl*
end;//TarDirectSaveDocumentHelper.HandleException

procedure TarDirectSaveDocumentHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E2715500C8_var*
//#UC END# *479731C50290_57E2715500C8_var*
begin
//#UC START# *479731C50290_57E2715500C8_impl*
 if f_NeedOpenFiler then
  Filer.Close;
 inherited;
//#UC END# *479731C50290_57E2715500C8_impl*
end;//TarDirectSaveDocumentHelper.Cleanup

end.
