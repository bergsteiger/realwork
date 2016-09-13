unit arUploadDocumentHelper;

// Модуль: "w:\archi\source\projects\Archi\Processing\arUploadDocumentHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarUploadDocumentHelper" MUID: (57CFC14E01DF)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , k2TagGen
 , l3Filer
 {$If NOT Defined(Nemesis)}
 , csUploadDocStream
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
 , l3MarshalledTypes
 {$If NOT Defined(Nemesis)}
 , dt_IFltr
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TarUploadDocumentHelper = class(Tl3ProtoObject)
  private
   f_Filer: Tl3CustomFiler;
   f_NeedOpenFiler: Boolean;
   f_Message: TcsUploadDocStream;
   f_Generator: Tk2TagGenerator;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aDirectAccess: Boolean;
    aFamily: TdaFamilyID;
    anID: TdaDocID;
    aClass: TdaDocType;
    aPart: Tm3DocPartSelector;
    ParseToDB: Boolean;
    NeedSaveText: Boolean;
    IsClassChanged: Boolean;
    aEraseNotify: TdtOnEraseAttrRecords;
    anIsObjTopic: Boolean); reintroduce;
   function UploadDoc: Boolean;
   procedure HanldeException;
  public
   property Generator: Tk2TagGenerator
    read f_Generator;
 end;//TarUploadDocumentHelper
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
 , m3DBInterfaces
 , m3DBFiler
 , evdNativeWriter
 , arDocAttributesMixer
 , l3Types
 , dt_Types
 {$If NOT Defined(Nemesis)}
 , csUploadDocStreamReply
 {$IfEnd} // NOT Defined(Nemesis)
 , ArchiUserRequestManager
 //#UC START# *57CFC14E01DFimpl_uses*
 //#UC END# *57CFC14E01DFimpl_uses*
;

constructor TarUploadDocumentHelper.Create(aDirectAccess: Boolean;
 aFamily: TdaFamilyID;
 anID: TdaDocID;
 aClass: TdaDocType;
 aPart: Tm3DocPartSelector;
 ParseToDB: Boolean;
 NeedSaveText: Boolean;
 IsClassChanged: Boolean;
 aEraseNotify: TdtOnEraseAttrRecords;
 anIsObjTopic: Boolean);
//#UC START# *57CFDE7701E9_57CFC14E01DF_var*
//#UC END# *57CFDE7701E9_57CFC14E01DF_var*
begin
//#UC START# *57CFDE7701E9_57CFC14E01DF_impl*
 inherited Create;

 if aDirectAccess then
 begin
  f_Message := nil;
  f_Filer := MakeFilerForDB(aFamily, anID, aPart);
  f_Filer.Mode := l3_fmReadWrite;
  f_NeedOpenFiler := (aClass <> dtNone) and NeedSaveText;
  if f_NeedOpenFiler then
   f_Filer.Open;
  if IsClassChanged and (Tm3DBFiler(f_Filer).Part <> nil) then
   Tm3DBFiler(f_Filer).Part.Info := Tm3DBDocumentInfo_C(ord(aClass));
 end
 else
 begin
  f_Message := TcsUploadDocStream.Create;
  f_Message.IsObjTopic := anIsObjTopic;
  f_Message.DocFamily := aFamily;
  f_Message.DocID := anID;
  f_Message.DocPart := aPart;
  f_Message.ParseToDB := ParseToDB;
  f_Message.IsClassChanged := IsClassChanged;
  f_Message.NeedSaveText := NeedSaveText;
  f_Message.DocClass := aClass;
  f_Filer := MakeFilerForMessage(f_Message.Data);
 end;

 f_Generator := nil;
 if NeedSaveText or not aDirectAccess then
 begin
  TevdNativeWriter.SetTo(f_Generator);
  with TevdNativeWriter(f_Generator) do
  begin
   Filer := f_Filer;
   Binary := true;
  end;
 end;

 if aDirectAccess and ParseToDB then
  BuildDocSavePipe(aFamily, anID, anIsObjTopic, aEraseNotify, f_Generator);
//#UC END# *57CFDE7701E9_57CFC14E01DF_impl*
end;//TarUploadDocumentHelper.Create

function TarUploadDocumentHelper.UploadDoc: Boolean;
//#UC START# *57CFC33E0089_57CFC14E01DF_var*
//#UC END# *57CFC33E0089_57CFC14E01DF_var*
begin
//#UC START# *57CFC33E0089_57CFC14E01DF_impl*
 if f_NeedOpenFiler then
  f_Filer.Close;
 f_NeedOpenFiler := False;
 if Assigned(f_Message) then
 begin
  Result := ArchiRequestManager.UploadDocStream(f_Message);
  FreeAndNil(f_Message);
 end
 else
  Result := True;
//#UC END# *57CFC33E0089_57CFC14E01DF_impl*
end;//TarUploadDocumentHelper.UploadDoc

procedure TarUploadDocumentHelper.HanldeException;
//#UC START# *57D15A640079_57CFC14E01DF_var*
//#UC END# *57D15A640079_57CFC14E01DF_var*
begin
//#UC START# *57D15A640079_57CFC14E01DF_impl*
 if f_Filer.Opened then
  f_Filer.Rollback;
//#UC END# *57D15A640079_57CFC14E01DF_impl*
end;//TarUploadDocumentHelper.HanldeException

procedure TarUploadDocumentHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57CFC14E01DF_var*
//#UC END# *479731C50290_57CFC14E01DF_var*
begin
//#UC START# *479731C50290_57CFC14E01DF_impl*
 if f_NeedOpenFiler then
  f_Filer.Close;
 FreeAndNil(f_Filer);
 FreeAndNil(f_Generator);
 FreeAndNil(f_Message);
 inherited;
//#UC END# *479731C50290_57CFC14E01DF_impl*
end;//TarUploadDocumentHelper.Cleanup
{$IfEnd} // Defined(AppClientSide)

end.
