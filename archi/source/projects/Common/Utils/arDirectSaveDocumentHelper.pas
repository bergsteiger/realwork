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
 !!! Needs to be implemented !!!
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
 !!! Needs to be implemented !!!
//#UC END# *57CFF0F8008A_57E2715500C8_impl*
end;//TarDirectSaveDocumentHelper.BuildDocSavePipe

function TarDirectSaveDocumentHelper.SaveDoc: Boolean;
//#UC START# *57E270CF032F_57E2715500C8_var*
//#UC END# *57E270CF032F_57E2715500C8_var*
begin
//#UC START# *57E270CF032F_57E2715500C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E270CF032F_57E2715500C8_impl*
end;//TarDirectSaveDocumentHelper.SaveDoc

procedure TarDirectSaveDocumentHelper.HandleException;
//#UC START# *57E270DD0210_57E2715500C8_var*
//#UC END# *57E270DD0210_57E2715500C8_var*
begin
//#UC START# *57E270DD0210_57E2715500C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E270DD0210_57E2715500C8_impl*
end;//TarDirectSaveDocumentHelper.HandleException

procedure TarDirectSaveDocumentHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E2715500C8_var*
//#UC END# *479731C50290_57E2715500C8_var*
begin
//#UC START# *479731C50290_57E2715500C8_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_57E2715500C8_impl*
end;//TarDirectSaveDocumentHelper.Cleanup

end.
