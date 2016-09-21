unit arMultiModifyDocsHelper;

// Модуль: "w:\archi\source\projects\Archi\Processing\arMultiModifyDocsHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarMultiModifyDocsHelper" MUID: (57DBBB3500CE)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , k2TagGen
 , l3Filer
 {$If NOT Defined(Nemesis)}
 , csMultiModifyDocs
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
 , l3MarshalledTypes
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , l3DatLst
;

type
 TarMultiModifyDocsHelper = class(Tl3ProtoObject)
  private
   f_Filer: Tl3CustomFiler;
   f_Message: TcsMultiModifyDocs;
   f_DirectAccessMode: Boolean;
   f_WasException: Boolean;
   f_FamilyID: TdaFamilyID;
   f_AnouncedDate: TDateTime;
   f_Generator: Tk2TagGenerator;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aDirectAccess: Boolean;
    OperType: TOperActionType;
    aFamily: TdaFamilyID;
    anAnouncedDate: TDateTime;
    const aDocIDList: ISab); reintroduce;
   procedure SignalException;
   function HasLockedDocs: Boolean;
   procedure FillLockedList(aList: Tl3StringDataList);
   procedure ModifyDocs;
  public
   property Generator: Tk2TagGenerator
    read f_Generator;
 end;//TarMultiModifyDocsHelper
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , dt_IFltr
 {$IfEnd} // NOT Defined(Nemesis)
 , evdNativeWriter
 , arDocAttributesMixer
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , l3IDList
 {$If NOT Defined(Nemesis)}
 , csMultiModifyDocsReply
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Types
 {$If NOT Defined(Nemesis)}
 , dt_Doc
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Const
 , arVAnouncedBlackList
 {$If Defined(Archi) AND NOT Defined(Nemesis)}
 , dt_LinkServ
 {$IfEnd} // Defined(Archi) AND NOT Defined(Nemesis)
 , l3Date
 , arIZM
 , arLockUtils
 //#UC START# *57DBBB3500CEimpl_uses*
 //#UC END# *57DBBB3500CEimpl_uses*
;

constructor TarMultiModifyDocsHelper.Create(aDirectAccess: Boolean;
 OperType: TOperActionType;
 aFamily: TdaFamilyID;
 anAnouncedDate: TDateTime;
 const aDocIDList: ISab);
//#UC START# *57DF8D6100EC_57DBBB3500CE_var*
var
 lDocIDList : Il3IDList;
//#UC END# *57DF8D6100EC_57DBBB3500CE_var*
begin
//#UC START# *57DF8D6100EC_57DBBB3500CE_impl*
 inherited Create;
 f_DirectAccessMode := aDirectAccess;
 f_WasException := False;
 f_FamilyID := aFamily;
 f_AnouncedDate := anAnouncedDate;
 f_Generator := nil;
 if f_DirectAccessMode then
 begin
  f_Generator := TGroupOpFilter.Create(nil);
  with TGroupOpFilter(f_Generator) do
  begin
   Family := aFamily;
   //CurDocID := DocInfo.DocID;
   InternalFormat := True;
   //ExcludeAttr := []; //CctAllAttributes - [ctHLink, ctSub];
   ExcludeMainRec := false; //True;
   case OperType of
    atAdd    : SaveMode := smAttrAdd;
    atDelete : SaveMode := smAttrDel;
   end;

   lDocIDList := dtMakeSortedIDListBySab(aDocIdList);
   SetDocIDList(lDocIDList);

   ExcludeAttr := []; //CctAllAttributes - [ctHLink, ctSub];

   //NeedEventforEraseAttrRec := [ctKW];
   //OnEraseAttrRecords := evntOnEraseAttrRecords;
  end; 
  TGroupOpFilter(f_Generator).StartCachingData;
 end
 else
 begin
  f_Message := TcsMultiModifyDocs.Create;
  TevdNativeWriter.SetTo(f_Generator);
  f_Filer := MakeFilerForMessage(f_Message.Data);
  TevdNativeWriter(f_Generator).Filer := f_Filer;
 end;
//#UC END# *57DF8D6100EC_57DBBB3500CE_impl*
end;//TarMultiModifyDocsHelper.Create

procedure TarMultiModifyDocsHelper.SignalException;
//#UC START# *57DFBB0803B7_57DBBB3500CE_var*
//#UC END# *57DFBB0803B7_57DBBB3500CE_var*
begin
//#UC START# *57DFBB0803B7_57DBBB3500CE_impl*
 f_WasException := True;
//#UC END# *57DFBB0803B7_57DBBB3500CE_impl*
end;//TarMultiModifyDocsHelper.SignalException

function TarMultiModifyDocsHelper.HasLockedDocs: Boolean;
//#UC START# *57E1086001DB_57DBBB3500CE_var*
//#UC END# *57E1086001DB_57DBBB3500CE_var*
begin
//#UC START# *57E1086001DB_57DBBB3500CE_impl*
 if f_DirectAccessMode then
  Result := TGroupOpFilter(f_Generator).RejectedDocsID.Count > 0
 else
 begin
  Assert(False);
//!! !!! Needs to be implemented !!!
 end;
//#UC END# *57E1086001DB_57DBBB3500CE_impl*
end;//TarMultiModifyDocsHelper.HasLockedDocs

procedure TarMultiModifyDocsHelper.FillLockedList(aList: Tl3StringDataList);
//#UC START# *57E108850183_57DBBB3500CE_var*
var
 l_IDX: Integer;
//#UC END# *57E108850183_57DBBB3500CE_var*
begin
//#UC START# *57E108850183_57DBBB3500CE_impl*
 if f_DirectAccessMode then
  for l_IDX := 0 to Pred(TGroupOpFilter(f_Generator).RejectedDocsID.Count) do
   AddToDenyList(f_FamilyID, TGroupOpFilter(f_Generator).RejectedDocsID[l_IDX], aList, True)
 else
 begin
  Assert(False);
//!! !!! Needs to be implemented !!!
 end;
//#UC END# *57E108850183_57DBBB3500CE_impl*
end;//TarMultiModifyDocsHelper.FillLockedList

procedure TarMultiModifyDocsHelper.ModifyDocs;
//#UC START# *57DBBB9202CC_57DBBB3500CE_var*

 procedure ProcessForAnoncedList(const aDocIDList : Il3IDList);
 var
  lSab : ISab;
  lTypeSab : ISab;
  lTypeSabCursor : ISabCursor;
  I : TUserType;
 begin
  if (aDocIDList = nil) or aDocIDList.Empty then Exit;
  lSab := MakeValueSet(DocumentServer(f_FamilyID).FileTbl, fId_Fld, aDocIDList);
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

  LinkServer(f_FamilyID).LogBook.PutLogRecToDocs(lSab, acAnonced, 0, DateTimeToStDate(f_AnouncedDate));
 end;

 procedure ProcessForIZMList(Const aDocIDList : Il3IDList);
 var
  lSab : ISab;
 begin
  if  (aDocIDList = nil) or aDocIDList.Empty then Exit;
  lSab := MakeValueSet(DocumentServer(f_FamilyID).FileTbl, fId_Fld, aDocIDList);
  GetIZMChecker.CheckoutForIZM(lSab);
 end;

//#UC END# *57DBBB9202CC_57DBBB3500CE_var*
begin
//#UC START# *57DBBB9202CC_57DBBB3500CE_impl*
 if f_DirectAccessMode then
 begin
  TGroupOpFilter(f_Generator).DoneCachingData;
  if f_WasException then
   Exit;
  ProcessForAnoncedList(TGroupOpFilter(f_Generator).DocIDList_forAnonced);
  ProcessForIZMList(TGroupOpFilter(f_Generator).DocIDList_forIZM);
 end
 else
 begin
  Assert(False);
//!! !!! Needs to be implemented !!!
 end;
//#UC END# *57DBBB9202CC_57DBBB3500CE_impl*
end;//TarMultiModifyDocsHelper.ModifyDocs

procedure TarMultiModifyDocsHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57DBBB3500CE_var*
//#UC END# *479731C50290_57DBBB3500CE_var*
begin
//#UC START# *479731C50290_57DBBB3500CE_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Generator);
 FreeAndNil(f_Filer);
 inherited;
//#UC END# *479731C50290_57DBBB3500CE_impl*
end;//TarMultiModifyDocsHelper.Cleanup
{$IfEnd} // Defined(AppClientSide)

end.
