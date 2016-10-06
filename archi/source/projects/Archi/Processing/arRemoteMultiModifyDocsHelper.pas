unit arRemoteMultiModifyDocsHelper;

// Модуль: "w:\archi\source\projects\Archi\Processing\arRemoteMultiModifyDocsHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarRemoteMultiModifyDocsHelper" MUID: (57E3A9690059)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arCustomMultiModifyDocsHelper
 {$If NOT Defined(Nemesis)}
 , csMultiModifyDocs
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiModifyDocsReply
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Filer
 , l3MarshalledTypes
 , daTypes
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , l3DatLst
;

type
 TarRemoteMultiModifyDocsHelper = class(TarCustomMultiModifyDocsHelper)
  private
   f_Message: TcsMultiModifyDocs;
   f_Reply: TcsMultiModifyDocsReply;
   f_Filer: Tl3CustomFiler;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(OperType: TOperActionType;
    aFamily: TdaFamilyID;
    anAnouncedDate: TDateTime;
    const aDocIDList: ISab); reintroduce;
   procedure ModifyDocs; override;
   function HasLockedDocs: Boolean; override;
   procedure FillLockedList(aList: Tl3StringDataList); override;
 end;//TarRemoteMultiModifyDocsHelper
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , SysUtils
 , ArchiUserRequestManager
 , arDocAttributesMixer
 , evdNativeWriter
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ncsMessage
 {$IfEnd} // NOT Defined(Nemesis)
 , daDataProvider
 //#UC START# *57E3A9690059impl_uses*
 , daInterfaces
 //#UC END# *57E3A9690059impl_uses*
;

constructor TarRemoteMultiModifyDocsHelper.Create(OperType: TOperActionType;
 aFamily: TdaFamilyID;
 anAnouncedDate: TDateTime;
 const aDocIDList: ISab);
//#UC START# *57E3A9AB035A_57E3A9690059_var*
//#UC END# *57E3A9AB035A_57E3A9690059_var*
begin
//#UC START# *57E3A9AB035A_57E3A9690059_impl*
 inherited Create(aFamily, anAnouncedDate);
 f_Reply := nil;
 f_Message := TcsMultiModifyDocs.Create;
 f_Message.UserID := GlobalDataProvider.UserID;
 f_Message.FamilyID := aFamily;
 f_Message.ActionType := OperType;
 f_Message.AnouncedDate := anAnouncedDate;
 dtCopyValuesSabToList(aDocIDList, f_Message.DocIDList);
 TevdNativeWriter.SetTo(f_Generator);
 f_Filer := MakeFilerForMessage(f_Message.Data);
 TevdNativeWriter(f_Generator).Filer := f_Filer;
//#UC END# *57E3A9AB035A_57E3A9690059_impl*
end;//TarRemoteMultiModifyDocsHelper.Create

procedure TarRemoteMultiModifyDocsHelper.ModifyDocs;
//#UC START# *57E254A501FA_57E3A9690059_var*
var
 l_Reply: TncsReply;
//#UC END# *57E254A501FA_57E3A9690059_var*
begin
//#UC START# *57E254A501FA_57E3A9690059_impl*
 l_Reply := ArchiRequestManager.SendRequestWithReply(f_Message);
 if (l_Reply = nil) or not (l_Reply is TcsMultiModifyDocsReply) then
  raise Exception.Create('Нет связи с сервером');
 f_Reply := l_Reply as TcsMultiModifyDocsReply;
 if not f_Reply.IsSuccess then
  raise Exception.Create(f_Reply.ErrorMessage);
//#UC END# *57E254A501FA_57E3A9690059_impl*
end;//TarRemoteMultiModifyDocsHelper.ModifyDocs

function TarRemoteMultiModifyDocsHelper.HasLockedDocs: Boolean;
//#UC START# *57E256520079_57E3A9690059_var*
//#UC END# *57E256520079_57E3A9690059_var*
begin
//#UC START# *57E256520079_57E3A9690059_impl*
 Result := f_Reply.RejectedIDList.Count > 0;
//#UC END# *57E256520079_57E3A9690059_impl*
end;//TarRemoteMultiModifyDocsHelper.HasLockedDocs

procedure TarRemoteMultiModifyDocsHelper.FillLockedList(aList: Tl3StringDataList);
//#UC START# *57E256910017_57E3A9690059_var*
var
 l_ID: Cardinal;
 l_Str: AnsiString;
 l_IDX: Integer;
//#UC END# *57E256910017_57E3A9690059_var*
begin
//#UC START# *57E256910017_57E3A9690059_impl*
 aList.Clear;
 aList.DataSize := SizeOf(l_ID);
 for l_IDX := 0 to f_Reply.RejectedIDList.Count - 1 do
 begin
  f_Reply.RejectedIDList.GetValue(l_IDX, l_ID, l_Str);
  aList.AddStr(l_Str, @l_ID);
 end;
//#UC END# *57E256910017_57E3A9690059_impl*
end;//TarRemoteMultiModifyDocsHelper.FillLockedList

procedure TarRemoteMultiModifyDocsHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57E3A9690059_var*
//#UC END# *479731C50290_57E3A9690059_var*
begin
//#UC START# *479731C50290_57E3A9690059_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_57E3A9690059_impl*
end;//TarRemoteMultiModifyDocsHelper.Cleanup
{$IfEnd} // Defined(AppClientSide)

end.
