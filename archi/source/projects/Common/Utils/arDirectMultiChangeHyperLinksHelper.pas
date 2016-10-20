unit arDirectMultiChangeHyperLinksHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arDirectMultiChangeHyperLinksHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarDirectMultiChangeHyperLinksHelper" MUID: (5800D0530303)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , arCustomMultiChangeHyperLinksHelper
 , daTypes
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TarDirectMultiChangeHyperLinksHelper = class(TarCustomMultiChangeHyperLinksHelper)
  private
   f_FamilyID: TdaFamilyID;
   f_OldDocID: TdaDocID;
   f_NewDocID: TdaDocID;
   f_DOcumentIDList: ISab;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFamilyID: TdaFamilyID;
    anOldDocID: TdaDocID;
    aNewDocID: TdaDocID;
    const aDocsList: ISab); reintroduce;
   procedure ModifyDocs; override;
 end;//TarDirectMultiChangeHyperLinksHelper

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_LinkServ
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Doc
 {$IfEnd} // NOT Defined(Nemesis)
 , l3Except
 , arConst
 , dt_Const
 , dt_Types
 //#UC START# *5800D0530303impl_uses*
 //#UC END# *5800D0530303impl_uses*
;

constructor TarDirectMultiChangeHyperLinksHelper.Create(aFamilyID: TdaFamilyID;
 anOldDocID: TdaDocID;
 aNewDocID: TdaDocID;
 const aDocsList: ISab);
//#UC START# *5800D1A400DD_5800D0530303_var*
//#UC END# *5800D1A400DD_5800D0530303_var*
begin
//#UC START# *5800D1A400DD_5800D0530303_impl*
 inherited Create;
 f_FamilyID := aFamilyID;
 f_OldDocID := anOldDocID;
 f_NewDocID := aNewDocID;
 f_DOcumentIDList := aDocsList;
//#UC END# *5800D1A400DD_5800D0530303_impl*
end;//TarDirectMultiChangeHyperLinksHelper.Create

procedure TarDirectMultiChangeHyperLinksHelper.ModifyDocs;
//#UC START# *5800CDDF0090_5800D0530303_var*
var
 lSaveDocNum : TdaDocID;
//#UC END# *5800CDDF0090_5800D0530303_var*
begin
//#UC START# *5800CDDF0090_5800D0530303_impl*
  lSaveDocNum := f_OldDocID;
// 2147483647  
  f_OldDocID := LinkServer(f_FamilyID).Renum.ConvertToRealNumber(f_OldDocID);
  if f_OldDocID <= 0 then
   raise El3NoLoggedException.CreateFmt(sidWrongDocID, [lSaveDocNum]);
  LinkServer(f_FamilyID).Renum.GetRNumber(f_NewDocID);

  LinkServer(f_FamilyID).HLinkTbl.ChangeDestAddr(f_OldDocID, f_NewDocID, cAnySubId, f_DocumentIDList);

  if not Assigned(f_DocumentIDList) then
   Exit;

  //преобразуем f_DocumentIDList что бы вместо ID справок были ID доков
  DocumentServer(f_FamilyID).FileTbl.SprIDs2DocIDs(f_DocumentIDList);

  LinkServer(f_FamilyID).LogBook.PutLogRecToDocs(f_DocumentIDList, acHLWork);
//#UC END# *5800CDDF0090_5800D0530303_impl*
end;//TarDirectMultiChangeHyperLinksHelper.ModifyDocs

procedure TarDirectMultiChangeHyperLinksHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5800D0530303_var*
//#UC END# *479731C50290_5800D0530303_var*
begin
//#UC START# *479731C50290_5800D0530303_impl*
 f_DocumentIDList := nil;
 inherited;
//#UC END# *479731C50290_5800D0530303_impl*
end;//TarDirectMultiChangeHyperLinksHelper.Cleanup

end.
