unit arDirectMultiClearAttributesHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arDirectMultiClearAttributesHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarDirectMultiClearAttributesHelper" MUID: (57EA225C02AA)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , arCustomMultiClearAttributesHelper
 , l3IDList
 , daTypes
 , l3DatLst
;

type
 TarDirectMultiClearAttributesHelper = class(TarCustomMultiClearAttributesHelper)
  private
   f_RejectedList: Il3IDList;
   f_FamilyID: TdaFamilyID;
   f_DocsToLock: Il3IDList;
   f_RIghtsNeeded: LongInt;
   f_Selected: TdaDictionaryTypeArray;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFamilyID: TdaFamilyID;
    const aDocsToLock: Il3IDList;
    RIghtsNeeded: LongInt;
    const aSelected: TdaDictionaryTypeArray); reintroduce;
   procedure ClearAttributes; override;
   function HasRejectedDocs: Boolean; override;
   procedure FillRejectedList(aList: Tl3StringDataList); override;
 end;//TarDirectMultiClearAttributesHelper

implementation

uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_LinkServ
 {$IfEnd} // NOT Defined(Nemesis)
 , arLockUtils
 {$If NOT Defined(Nemesis)}
 , dt_Doc
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Lock
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Types
 //#UC START# *57EA225C02AAimpl_uses*
 //#UC END# *57EA225C02AAimpl_uses*
;

constructor TarDirectMultiClearAttributesHelper.Create(aFamilyID: TdaFamilyID;
 const aDocsToLock: Il3IDList;
 RIghtsNeeded: LongInt;
 const aSelected: TdaDictionaryTypeArray);
//#UC START# *57EA3F54035E_57EA225C02AA_var*
//#UC END# *57EA3F54035E_57EA225C02AA_var*
begin
//#UC START# *57EA3F54035E_57EA225C02AA_impl*
 inherited Create;
 f_FamilyID := aFamilyID;
 f_DocsToLock := aDocsToLock;
 f_RightsNeeded := RightsNeeded;
 f_Selected := aSelected;
 f_RejectedList := l3MakeIDList;
//#UC END# *57EA3F54035E_57EA225C02AA_impl*
end;//TarDirectMultiClearAttributesHelper.Create

procedure TarDirectMultiClearAttributesHelper.ClearAttributes;
//#UC START# *57EA229201FE_57EA225C02AA_var*
var
 l_LockHandles : Il3IDList;
 l_IDSab : ISab;
 l_AttrLogged: Boolean;
 l_IDX: Integer;
//#UC END# *57EA229201FE_57EA225C02AA_var*
begin
//#UC START# *57EA229201FE_57EA225C02AA_impl*
 l_LockHandles  := l3MakeIDList;
 LockServer.BatchLockDoc(f_FamilyID, f_DocsToLock, f_RightsNeeded,
  l_LockHandles, f_RejectedList);
 try
  if (f_DocsToLock <> nil) and (f_DocsToLock.Count > 0) then
  begin
   l_IDSab := MakeValueSet(DocumentServer(f_FamilyID).FileTbl, fId_Fld, f_DocsToLock);
   try
    l_AttrLogged := False;
    for l_IDX := Low(f_Selected) to High(f_Selected) do
    begin
     LinkServer(f_FamilyID).Links[f_Selected[l_IDX]].DelAllLinkItems(l_IDSab);
     case f_Selected[l_IDX] of
      da_dlPrefixes,
      da_dlClasses  : LinkServer(f_FamilyID).LogBook.PutLogRecToDocs(l_IDSab, acClassWork);
      da_dlKeyWords : LinkServer(f_FamilyID).LogBook.PutLogRecToDocs(l_IDSab, acKWWork);
     else
      if not l_AttrLogged then
      begin
       LinkServer(f_FamilyID).LogBook.PutLogRecToDocs(l_IDSab, acAttrWork);
       l_AttrLogged := True;
      end;
     end;{case}
    end;{for}
   finally
    l_IDSab := nil;
   end;
  end;
 finally
  LockServer.BatchUnlockDoc(f_FamilyID, l_LockHandles);
 end;
//#UC END# *57EA229201FE_57EA225C02AA_impl*
end;//TarDirectMultiClearAttributesHelper.ClearAttributes

function TarDirectMultiClearAttributesHelper.HasRejectedDocs: Boolean;
//#UC START# *57EA22B10150_57EA225C02AA_var*
//#UC END# *57EA22B10150_57EA225C02AA_var*
begin
//#UC START# *57EA22B10150_57EA225C02AA_impl*
 Result := f_RejectedList.Count > 0;
//#UC END# *57EA22B10150_57EA225C02AA_impl*
end;//TarDirectMultiClearAttributesHelper.HasRejectedDocs

procedure TarDirectMultiClearAttributesHelper.FillRejectedList(aList: Tl3StringDataList);
//#UC START# *57EA22C201D1_57EA225C02AA_var*
var
 l_IDX: Integer;
//#UC END# *57EA22C201D1_57EA225C02AA_var*
begin
//#UC START# *57EA22C201D1_57EA225C02AA_impl*
 for l_IDX := 0 to Pred(f_RejectedList.Count) do
  AddToDenyList(f_FamilyID, f_RejectedList[l_IDX], aList, True);
//#UC END# *57EA22C201D1_57EA225C02AA_impl*
end;//TarDirectMultiClearAttributesHelper.FillRejectedList

procedure TarDirectMultiClearAttributesHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57EA225C02AA_var*
//#UC END# *479731C50290_57EA225C02AA_var*
begin
//#UC START# *479731C50290_57EA225C02AA_impl*
 f_RejectedList := nil;
 f_DocsToLock := nil;
 inherited;
//#UC END# *479731C50290_57EA225C02AA_impl*
end;//TarDirectMultiClearAttributesHelper.Cleanup

end.
