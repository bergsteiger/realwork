unit arDirectMultiModifyDocsHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arDirectMultiModifyDocsHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarDirectMultiModifyDocsHelper" MUID: (57DBBB3500CE)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , arCustomMultiModifyDocsHelper
 , l3MarshalledTypes
 , daTypes
 , l3IDList
 , l3DatLst
;

type
 TarDirectMultiModifyDocsHelper = class(TarCustomMultiModifyDocsHelper)
  public
   constructor Create(OperType: TOperActionType;
    aFamily: TdaFamilyID;
    anAnouncedDate: TDateTime;
    const aDocIDList: Il3IDList); reintroduce;
   procedure ModifyDocs; override;
   function HasLockedDocs: Boolean; override;
   procedure FillLockedList(aList: Tl3StringDataList); override;
 end;//TarDirectMultiModifyDocsHelper

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_IFltr
 {$IfEnd} // NOT Defined(Nemesis)
 , evdNativeWriter
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Types
 {$If NOT Defined(Nemesis)}
 , dt_Doc
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Const
 , arVAnouncedBlackList
 {$If NOT Defined(Nemesis)}
 , dt_LinkServ
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Date
 , arIZM
 , arLockUtils
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , arDocAttributesMixer
 //#UC START# *57DBBB3500CEimpl_uses*
 //#UC END# *57DBBB3500CEimpl_uses*
;

constructor TarDirectMultiModifyDocsHelper.Create(OperType: TOperActionType;
 aFamily: TdaFamilyID;
 anAnouncedDate: TDateTime;
 const aDocIDList: Il3IDList);
//#UC START# *57DF8D6100EC_57DBBB3500CE_var*
//#UC END# *57DF8D6100EC_57DBBB3500CE_var*
begin
//#UC START# *57DF8D6100EC_57DBBB3500CE_impl*
 inherited Create(aFamily, anAnouncedDate);
 f_Generator := TGroupOpFilter.Create(nil);
 with TGroupOpFilter(f_Generator) do
 begin
  Family := FamilyID;
  //CurDocID := DocInfo.DocID;
  InternalFormat := True;
  //ExcludeAttr := []; //CctAllAttributes - [ctHLink, ctSub];
  ExcludeMainRec := false; //True;
  case OperType of
   atAdd    : SaveMode := smAttrAdd;
   atDelete : SaveMode := smAttrDel;
  end;

  SetDocIDList(aDocIDList);

  ExcludeAttr := []; //CctAllAttributes - [ctHLink, ctSub];

  //NeedEventforEraseAttrRec := [ctKW];
  //OnEraseAttrRecords := evntOnEraseAttrRecords;
 end;
 TGroupOpFilter(f_Generator).StartCachingData;
(*
 begin
  f_Message := TcsMultiModifyDocs.Create;
  TevdNativeWriter.SetTo(f_Generator);
  f_Filer := MakeFilerForMessage(f_Message.Data);
  TevdNativeWriter(f_Generator).Filer := f_Filer;
 end;
*)
//#UC END# *57DF8D6100EC_57DBBB3500CE_impl*
end;//TarDirectMultiModifyDocsHelper.Create

procedure TarDirectMultiModifyDocsHelper.ModifyDocs;
//#UC START# *57E254A501FA_57DBBB3500CE_var*

 procedure ProcessForAnoncedList(const aDocIDList : Il3IDList);
 var
  lSab : ISab;
  lTypeSab : ISab;
  lTypeSabCursor : ISabCursor;
  I : TUserType;
 begin
  if (aDocIDList = nil) or aDocIDList.Empty then Exit;
  lSab := MakeValueSet(DocumentServer(FamilyID).FileTbl, fId_Fld, aDocIDList);
  lSab.RecordsByKey;

  lTypeSab := MakeEmptyValueSab(lSab, fUserType_Fld);
  lTypeSabCursor := lTypeSab.MakeSabCursor([fUserType_Fld]);
  for I := low(TUserType) to high(TUserType) do
   if I in utFullFeatureDocTypes then
    lTypeSabCursor.AddItem(@I);
  lTypeSabCursor := nil;
  lTypeSab.InvertSab;
  lTypeSab.RecordsByKey;
  lSab.SubtractSab(lTypeSab);

  lSab.ValuesOfKey(fId_Fld);

  FilterbyVAnouncedAccGroupsBlackList(lSab);

  LinkServer(FamilyID).LogBook.PutLogRecToDocs(lSab, acAnonced, 0, DateTimeToStDate(AnouncedDate));
 end;

 procedure ProcessForIZMList(Const aDocIDList : Il3IDList);
 var
  lSab : ISab;
 begin
  if  (aDocIDList = nil) or aDocIDList.Empty then Exit;
  lSab := MakeValueSet(DocumentServer(FamilyID).FileTbl, fId_Fld, aDocIDList);
  GetIZMChecker.CheckoutForIZM(lSab);
 end;

//#UC END# *57E254A501FA_57DBBB3500CE_var*
begin
//#UC START# *57E254A501FA_57DBBB3500CE_impl*
 TGroupOpFilter(f_Generator).DoneCachingData;
 if WasException then
  Exit;
 ProcessForAnoncedList(TGroupOpFilter(f_Generator).DocIDList_forAnonced);
 ProcessForIZMList(TGroupOpFilter(f_Generator).DocIDList_forIZM);
//#UC END# *57E254A501FA_57DBBB3500CE_impl*
end;//TarDirectMultiModifyDocsHelper.ModifyDocs

function TarDirectMultiModifyDocsHelper.HasLockedDocs: Boolean;
//#UC START# *57E256520079_57DBBB3500CE_var*
//#UC END# *57E256520079_57DBBB3500CE_var*
begin
//#UC START# *57E256520079_57DBBB3500CE_impl*
 Result := Assigned(TGroupOpFilter(f_Generator).RejectedDocsID) and not TGroupOpFilter(f_Generator).RejectedDocsID.Empty;
//#UC END# *57E256520079_57DBBB3500CE_impl*
end;//TarDirectMultiModifyDocsHelper.HasLockedDocs

procedure TarDirectMultiModifyDocsHelper.FillLockedList(aList: Tl3StringDataList);
//#UC START# *57E256910017_57DBBB3500CE_var*
var
 l_IDX: Integer;
//#UC END# *57E256910017_57DBBB3500CE_var*
begin
//#UC START# *57E256910017_57DBBB3500CE_impl*
 if Assigned(TGroupOpFilter(f_Generator).RejectedDocsID) then
  for l_IDX := 0 to TGroupOpFilter(f_Generator).RejectedDocsID.Count - 1 do
   AddToDenyList(FamilyID, TGroupOpFilter(f_Generator).RejectedDocsID[l_IDX], aList, True)
//#UC END# *57E256910017_57DBBB3500CE_impl*
end;//TarDirectMultiModifyDocsHelper.FillLockedList

end.
