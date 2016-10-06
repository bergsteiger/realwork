unit arRemoteSaveDocumentHelper;

// Модуль: "w:\archi\source\projects\Archi\Processing\arRemoteSaveDocumentHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarRemoteSaveDocumentHelper" MUID: (57CFC14E01DF)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arCustomSaveDocumentHelper
 {$If NOT Defined(Nemesis)}
 , csUploadDocStream
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
 , l3MarshalledTypes
;

type
 TarRemoteSaveDocumentHelper = class(TarCustomSaveDocumentHelper)
  private
   f_Message: TcsUploadDocStream;
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
    anIsObjTopic: Boolean); reintroduce;
   function SaveDoc: Boolean; override;
   procedure HandleException; override;
 end;//TarRemoteSaveDocumentHelper
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , SysUtils
 , evdNativeWriter
 , dt_Types
 {$If NOT Defined(Nemesis)}
 , csUploadDocStreamReply
 {$IfEnd} // NOT Defined(Nemesis)
 , ArchiUserRequestManager
 , arDocAttributesMixer
 , daDataProvider
 //#UC START# *57CFC14E01DFimpl_uses*
 //#UC END# *57CFC14E01DFimpl_uses*
;

constructor TarRemoteSaveDocumentHelper.Create(aFamily: TdaFamilyID;
 anID: TdaDocID;
 aClass: TdaDocType;
 aPart: Tm3DocPartSelector;
 ParseToDB: Boolean;
 NeedSaveText: Boolean;
 IsClassChanged: Boolean;
 anIsObjTopic: Boolean);
//#UC START# *57CFDE7701E9_57CFC14E01DF_var*
//#UC END# *57CFDE7701E9_57CFC14E01DF_var*
begin
//#UC START# *57CFDE7701E9_57CFC14E01DF_impl*
 inherited Create;

 f_Message := TcsUploadDocStream.Create;
 f_Message.UserID := GlobalDataProvider.UserID;
 f_Message.IsObjTopic := anIsObjTopic;
 f_Message.DocFamily := aFamily;
 f_Message.DocID := anID;
 f_Message.DocPart := aPart;
 f_Message.ParseToDB := ParseToDB;
 f_Message.IsClassChanged := IsClassChanged;
 f_Message.NeedSaveText := NeedSaveText;
 f_Message.DocClass := aClass;
 Filer := MakeFilerForMessage(f_Message.Data);

 f_Generator := nil;
 TevdNativeWriter.SetTo(f_Generator);
 with TevdNativeWriter(f_Generator) do
 begin
  Filer := Self.Filer;
  Binary := true;
 end;
//#UC END# *57CFDE7701E9_57CFC14E01DF_impl*
end;//TarRemoteSaveDocumentHelper.Create

function TarRemoteSaveDocumentHelper.SaveDoc: Boolean;
//#UC START# *57E270CF032F_57CFC14E01DF_var*
//#UC END# *57E270CF032F_57CFC14E01DF_var*
begin
//#UC START# *57E270CF032F_57CFC14E01DF_impl*
 Result := ArchiRequestManager.UploadDocStream(f_Message);
 FreeAndNil(f_Message);
//#UC END# *57E270CF032F_57CFC14E01DF_impl*
end;//TarRemoteSaveDocumentHelper.SaveDoc

procedure TarRemoteSaveDocumentHelper.HandleException;
//#UC START# *57E270DD0210_57CFC14E01DF_var*
//#UC END# *57E270DD0210_57CFC14E01DF_var*
begin
//#UC START# *57E270DD0210_57CFC14E01DF_impl*
// Do nothing;
//#UC END# *57E270DD0210_57CFC14E01DF_impl*
end;//TarRemoteSaveDocumentHelper.HandleException

procedure TarRemoteSaveDocumentHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57CFC14E01DF_var*
//#UC END# *479731C50290_57CFC14E01DF_var*
begin
//#UC START# *479731C50290_57CFC14E01DF_impl*
 FreeAndNil(f_Message);
 inherited;
//#UC END# *479731C50290_57CFC14E01DF_impl*
end;//TarRemoteSaveDocumentHelper.Cleanup
{$IfEnd} // Defined(AppClientSide)

end.
