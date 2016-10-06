unit arRemoteMultiClearAttributesHelper;

// Модуль: "w:\archi\source\projects\Archi\Processing\arRemoteMultiClearAttributesHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarRemoteMultiClearAttributesHelper" MUID: (57EBA2190344)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , arCustomMultiClearAttributesHelper
 {$If NOT Defined(Nemesis)}
 , csMultiClearAttributes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csMultiClearAttributesReply
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , l3DatLst
;

type
 TarRemoteMultiClearAttributesHelper = class(TarCustomMultiClearAttributesHelper)
  private
   f_Message: TcsMultiClearAttributes;
   f_Reply: TcsMultiClearAttributesReply;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aFamilyID: TdaFamilyID;
    const aDocsToLock: ISab;
    RIghtsNeeded: LongInt;
    const aSelected: TdaDictionaryTypeArray); reintroduce;
   procedure ClearAttributes; override;
   function HasRejectedDocs: Boolean; override;
   procedure FillRejectedList(aList: Tl3StringDataList); override;
 end;//TarRemoteMultiClearAttributesHelper
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , SysUtils
 , ArchiUserRequestManager
 {$If NOT Defined(Nemesis)}
 , ncsMessage
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , evdTasksHelpers
 , daDataProvider
 //#UC START# *57EBA2190344impl_uses*
 //#UC END# *57EBA2190344impl_uses*
;

constructor TarRemoteMultiClearAttributesHelper.Create(aFamilyID: TdaFamilyID;
 const aDocsToLock: ISab;
 RIghtsNeeded: LongInt;
 const aSelected: TdaDictionaryTypeArray);
//#UC START# *57EBA29A024A_57EBA2190344_var*
var
 l_IDX: Integer;
 l_Helper: AttributesHelper;
//#UC END# *57EBA29A024A_57EBA2190344_var*
begin
//#UC START# *57EBA29A024A_57EBA2190344_impl*
 inherited Create;
 f_Reply := nil;
 f_Message := TcsMultiClearAttributes.Create;
 f_Message.UserID := GlobalDataProvider.UserID;
 f_Message.FamilyID := aFamilyID;
 dtCopyValuesSabToList(aDocsToLock, f_Message.DocIDList);
 f_Message.RightsNeeded := RightsNeeded;
 l_Helper := f_Message.Attributes;
 for l_IDX := Low(aSelected) to High(aSelected) do
  l_Helper.Add(Ord(aSelected[l_IDX]));
//#UC END# *57EBA29A024A_57EBA2190344_impl*
end;//TarRemoteMultiClearAttributesHelper.Create

procedure TarRemoteMultiClearAttributesHelper.ClearAttributes;
//#UC START# *57EA229201FE_57EBA2190344_var*
var
 l_Reply: TncsReply;
//#UC END# *57EA229201FE_57EBA2190344_var*
begin
//#UC START# *57EA229201FE_57EBA2190344_impl*
 l_Reply := ArchiRequestManager.SendRequestWithReply(f_Message);
 if (l_Reply = nil) or not (l_Reply is TcsMultiClearAttributesReply) then
  raise Exception.Create('Нет связи с сервером');
 f_Reply := l_Reply as TcsMultiClearAttributesReply;
 if not f_Reply.IsSuccess then
  raise Exception.Create(f_Reply.ErrorMessage);
//#UC END# *57EA229201FE_57EBA2190344_impl*
end;//TarRemoteMultiClearAttributesHelper.ClearAttributes

function TarRemoteMultiClearAttributesHelper.HasRejectedDocs: Boolean;
//#UC START# *57EA22B10150_57EBA2190344_var*
//#UC END# *57EA22B10150_57EBA2190344_var*
begin
//#UC START# *57EA22B10150_57EBA2190344_impl*
 Result := f_Reply.RejectedIDList.Count > 0;
//#UC END# *57EA22B10150_57EBA2190344_impl*
end;//TarRemoteMultiClearAttributesHelper.HasRejectedDocs

procedure TarRemoteMultiClearAttributesHelper.FillRejectedList(aList: Tl3StringDataList);
//#UC START# *57EA22C201D1_57EBA2190344_var*
var
 l_ID: Cardinal;
 l_Str: AnsiString;
 l_IDX: Integer;
//#UC END# *57EA22C201D1_57EBA2190344_var*
begin
//#UC START# *57EA22C201D1_57EBA2190344_impl*
 aList.Clear;
 aList.DataSize := SizeOf(l_ID);
 for l_IDX := 0 to f_Reply.RejectedIDList.Count - 1 do
 begin
  f_Reply.RejectedIDList.GetValue(l_IDX, l_ID, l_Str);
  aList.AddStr(l_Str, @l_ID);
 end;
//#UC END# *57EA22C201D1_57EBA2190344_impl*
end;//TarRemoteMultiClearAttributesHelper.FillRejectedList

procedure TarRemoteMultiClearAttributesHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57EBA2190344_var*
//#UC END# *479731C50290_57EBA2190344_var*
begin
//#UC START# *479731C50290_57EBA2190344_impl*
 FreeAndNil(f_Message);
 FreeAndNil(f_Reply);
 inherited;
//#UC END# *479731C50290_57EBA2190344_impl*
end;//TarRemoteMultiClearAttributesHelper.Cleanup
{$IfEnd} // Defined(AppClientSide)

end.
