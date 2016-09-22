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
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , l3DatLst
;

type
 TarDirectMultiModifyDocsHelper = class(TarCustomMultiModifyDocsHelper)
  public
   constructor Create(aDirectAccess: Boolean;
    OperType: TOperActionType;
    aFamily: TdaFamilyID;
    anAnouncedDate: TDateTime;
    const aDocIDList: ISab); reintroduce;
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
 , arDocAttributesMixer
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , l3IDList
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

constructor TarDirectMultiModifyDocsHelper.Create(aDirectAccess: Boolean;
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
end;//TarDirectMultiModifyDocsHelper.Create

procedure TarDirectMultiModifyDocsHelper.ModifyDocs;
//#UC START# *57E254A501FA_57DBBB3500CE_var*
//#UC END# *57E254A501FA_57DBBB3500CE_var*
begin
//#UC START# *57E254A501FA_57DBBB3500CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E254A501FA_57DBBB3500CE_impl*
end;//TarDirectMultiModifyDocsHelper.ModifyDocs

function TarDirectMultiModifyDocsHelper.HasLockedDocs: Boolean;
//#UC START# *57E256520079_57DBBB3500CE_var*
//#UC END# *57E256520079_57DBBB3500CE_var*
begin
//#UC START# *57E256520079_57DBBB3500CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E256520079_57DBBB3500CE_impl*
end;//TarDirectMultiModifyDocsHelper.HasLockedDocs

procedure TarDirectMultiModifyDocsHelper.FillLockedList(aList: Tl3StringDataList);
//#UC START# *57E256910017_57DBBB3500CE_var*
//#UC END# *57E256910017_57DBBB3500CE_var*
begin
//#UC START# *57E256910017_57DBBB3500CE_impl*
 !!! Needs to be implemented !!!
//#UC END# *57E256910017_57DBBB3500CE_impl*
end;//TarDirectMultiModifyDocsHelper.FillLockedList

end.
