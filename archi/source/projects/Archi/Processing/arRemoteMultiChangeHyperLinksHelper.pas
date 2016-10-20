unit arRemoteMultiChangeHyperLinksHelper;

// Модуль: "w:\archi\source\projects\Archi\Processing\arRemoteMultiChangeHyperLinksHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarRemoteMultiChangeHyperLinksHelper" MUID: (58049CD70263)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arCustomMultiChangeHyperLinksHelper
 {$If NOT Defined(Nemesis)}
 , csMultiChangeHyperLinks
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiChangeHyperLinksReply
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TarRemoteMultiChangeHyperLinksHelper = class(TarCustomMultiChangeHyperLinksHelper)
  private
   f_Message: TcsMultiChangeHyperLinks;
   f_Reply: TcsMultiChangeHyperLinksReply;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFamilyID: TdaFamilyID;
    anOldDocID: TdaDocID;
    aNewDocID: TdaDocID;
    const aDocsList: ISab); reintroduce;
   procedure ModifyDocs; override;
 end;//TarRemoteMultiChangeHyperLinksHelper
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , SysUtils
 , ArchiUserRequestManager
 {$If NOT Defined(Nemesis)}
 , ncsMessage
 {$IfEnd} // NOT Defined(Nemesis)
 , daDataProvider
 //#UC START# *58049CD70263impl_uses*
 //#UC END# *58049CD70263impl_uses*
;

constructor TarRemoteMultiChangeHyperLinksHelper.Create(aFamilyID: TdaFamilyID;
 anOldDocID: TdaDocID;
 aNewDocID: TdaDocID;
 const aDocsList: ISab);
//#UC START# *58049D7C000C_58049CD70263_var*
//#UC END# *58049D7C000C_58049CD70263_var*
begin
//#UC START# *58049D7C000C_58049CD70263_impl*
 inherited Create;
 f_Reply := nil;
 f_Message := TcsMultiChangeHyperLinks.Create;
 f_Message.UserID := GlobalDataProvider.UserID;
 f_Message.FamilyID := aFamilyID;
 f_Message.OldDocID := anOldDocID;
 f_Message.NewDocID := aNewDocID;
 dtCopyValuesSabToList(aDocsList, f_Message.DocumentIDList);
//#UC END# *58049D7C000C_58049CD70263_impl*
end;//TarRemoteMultiChangeHyperLinksHelper.Create

procedure TarRemoteMultiChangeHyperLinksHelper.ModifyDocs;
//#UC START# *5800CDDF0090_58049CD70263_var*
var
 l_Reply: TncsReply;
//#UC END# *5800CDDF0090_58049CD70263_var*
begin
//#UC START# *5800CDDF0090_58049CD70263_impl*
 l_Reply := ArchiRequestManager.SendRequestWithReply(f_Message);
 if (l_Reply = nil) or not (l_Reply is TcsMultiChangeHyperLinksReply) then
  raise Exception.Create('Нет связи с сервером');
 f_Reply := l_Reply as TcsMultiChangeHyperLinksReply;
 if not f_Reply.IsSuccess then
  raise Exception.Create(f_Reply.ErrorMessage);
//#UC END# *5800CDDF0090_58049CD70263_impl*
end;//TarRemoteMultiChangeHyperLinksHelper.ModifyDocs

procedure TarRemoteMultiChangeHyperLinksHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_58049CD70263_var*
//#UC END# *479731C50290_58049CD70263_var*
begin
//#UC START# *479731C50290_58049CD70263_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_58049CD70263_impl*
end;//TarRemoteMultiChangeHyperLinksHelper.Cleanup
{$IfEnd} // Defined(AppClientSide)

end.
