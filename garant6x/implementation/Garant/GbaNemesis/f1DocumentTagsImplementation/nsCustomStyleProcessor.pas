unit nsCustomStyleProcessor;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\f1DocumentTagsImplementation\nsCustomStyleProcessor.pas"
// Стереотип: "ServiceImplementation"
// Элемент модели: "TnsCustomStyleProcessor" MUID: (53AC08C900D0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , evCustomStyleManager
 , evdTypes
 , afwNavigation
 , l3Variant
 , nevTools
;

type
 TnsCustomStyleProcessor = {final} class(Tl3ProtoObject, IevCustomStyleManager)
  private
   procedure ReadLinkInfo(aSeg: Tl3Variant;
    const aPara: InevPara);
   function GetLinkAddress(aSeg: Tl3Variant): TevAddress;
  protected
   function pm_GetLinkViewKind(aSeg: Tl3Variant): TevLinkViewKind;
   procedure pm_SetLinkViewKind(aSeg: Tl3Variant;
    aValue: TevLinkViewKind);
  public
   function IsAbolishedDocumentLink(aSeg: Tl3Variant;
    const aPara: InevPara): Boolean;
   function IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
   class function Instance: TnsCustomStyleProcessor;
    {* Метод получения экземпляра синглетона TnsCustomStyleProcessor }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  protected
   property LinkViewKind[aSeg: Tl3Variant]: TevLinkViewKind
    read pm_GetLinkViewKind
    write pm_SetLinkViewKind;
 end;//TnsCustomStyleProcessor

implementation

uses
 l3ImplUses
 , evdTextStyle_Const
 , k2Tags
 , k2Const
 , DocumentUnit
 , SysUtils
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , Document_Const
 , BaseTypesUnit
 , HyperLink_Const
 {$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 , nscDocumentHistory
 {$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
 , l3Base
 //#UC START# *53AC08C900D0impl_uses*
 //#UC END# *53AC08C900D0impl_uses*
;

var g_TnsCustomStyleProcessor: TnsCustomStyleProcessor = nil;
 {* Экземпляр синглетона TnsCustomStyleProcessor }

procedure TnsCustomStyleProcessorFree;
 {* Метод освобождения экземпляра синглетона TnsCustomStyleProcessor }
begin
 l3Free(g_TnsCustomStyleProcessor);
end;//TnsCustomStyleProcessorFree

function TnsCustomStyleProcessor.pm_GetLinkViewKind(aSeg: Tl3Variant): TevLinkViewKind;
//#UC START# *53AD54E80320_53AC08C900D0get_var*
//#UC END# *53AD54E80320_53AC08C900D0get_var*
begin
//#UC START# *53AD54E80320_53AC08C900D0get_impl*
 Assert(aSeg.IsValid and aSeg.IsKindOf(k2_typHyperLink));
 Result := TevLinkViewKind(aSeg.rAtomEx([k2_tiChildren, k2_tiByIndex, 0]).IntA[k2_tiViewKind]);
//#UC END# *53AD54E80320_53AC08C900D0get_impl*
end;//TnsCustomStyleProcessor.pm_GetLinkViewKind

procedure TnsCustomStyleProcessor.pm_SetLinkViewKind(aSeg: Tl3Variant;
 aValue: TevLinkViewKind);
//#UC START# *53AD54E80320_53AC08C900D0set_var*
//#UC END# *53AD54E80320_53AC08C900D0set_var*
begin
//#UC START# *53AD54E80320_53AC08C900D0set_impl*
 Assert(aSeg.IsValid and aSeg.IsKindOf(k2_typHyperLink));
 with aSeg.rAtomEx([k2_tiChildren, k2_tiByIndex, 0]) do
  if IsValid then
(*   [16:01]  МВ> Че-то в редакторе поломалось:
Project Nemesis.exe raised exception class EAssertionFailed with message 'Невозможно присвоить атрибут в Tk2NullTagImpl (w:\common\components\rtl\Garant\L3\l3Variant.pas, line 1566)'
При открытии документа 890312 *)
   IntA[k2_tiViewKind] := Ord(aValue);
//#UC END# *53AD54E80320_53AC08C900D0set_impl*
end;//TnsCustomStyleProcessor.pm_SetLinkViewKind

procedure TnsCustomStyleProcessor.ReadLinkInfo(aSeg: Tl3Variant;
 const aPara: InevPara);
//#UC START# *53AC3FF3021A_53AC08C900D0_var*
const
 lc_Map: array [TLinkKind] of TevLinkViewKind = (
   ev_lvkInternalInvalid,
   ev_lvkInternalValid,
   ev_lvkExternal,
   ev_lvkInternalAbolished,
   ev_lvkInternalPreactive,
   ev_lvkExternalENO,
   ev_lvkInternalEdition,
   ev_lvkScript
 );
 
var
 l_Doc: IDocument;
 l_DocV: Tl3Variant;
 l_Topic: TTopic;
 l_Addr: TevAddress;
 l_ExtID: Integer;
 l_Link: ILink;
//#UC END# *53AC3FF3021A_53AC08C900D0_var*
begin
//#UC START# *53AC3FF3021A_53AC08C900D0_impl*
 if LinkViewKind[aSeg] = ev_lvkUnknown then
 begin
  l_ExtID := 0;
  l_Addr := GetLinkAddress(aSeg);
  if (l_Addr.TypeID <> CI_TOPIC) then
   Exit;
  if Supports(aPara.DocumentContainer, IDocument, l_Doc) then
  begin
   with l_Topic do
   begin
    rPid.rObjectId := TObjectId(l_Addr.DocID);
    rPid.rClassId := TClassId(l_Addr.TypeID);
    rPosition.rPoint := Cardinal(l_Addr.SubID);
    rPosition.rType := PT_SUB;
   end;
   if l_Topic.rPid.rClassId <> 0 then
   begin
    if evInPara(aPara.AsObject, k2_typDocument, l_DocV) then
     l_ExtID := l_DocV.rLong(k2_tiExternalHandle, -1);

    l_Doc.GetLink(l_ExtID, l_Topic, l_Addr.RevisionID, l_Link);
    LinkViewKind[aSeg] := lc_Map[l_Link.GetKind];
   end;
  end;
 end;
//#UC END# *53AC3FF3021A_53AC08C900D0_impl*
end;//TnsCustomStyleProcessor.ReadLinkInfo

function TnsCustomStyleProcessor.GetLinkAddress(aSeg: Tl3Variant): TevAddress;
//#UC START# *5542334A00E6_53AC08C900D0_var*
const
 evNullAddress: TevAddress = (DocID : -1; SubID : -1);
//#UC END# *5542334A00E6_53AC08C900D0_var*
begin
//#UC START# *5542334A00E6_53AC08C900D0_impl*
 Result := evNullAddress;
 if aSeg.IsValid then
  with aSeg.rAtomEx([k2_tiChildren, k2_tiByIndex, 0]) do
   if IsValid then
   begin
    with Attr[k2_tiDocID] do
     if IsValid
      then Result.DocID := AsLong
      else Result.DocID := 0;
    with Attr[k2_tiSubID] do
     if IsValid
      then Result.SubID := AsLong
      else Result.SubID := 0;
    with Attr[k2_tiType] do
     if IsValid
      then Result.TypeID := AsLong
      else Result.TypeID := ev_defAddressType;
    with Attr[k2_tiRevision] do
     if IsValid
      then Result.RevisionID := AsLong
      else Result.RevisionID := 0;
   end;//IsValid
//#UC END# *5542334A00E6_53AC08C900D0_impl*
end;//TnsCustomStyleProcessor.GetLinkAddress

function TnsCustomStyleProcessor.IsAbolishedDocumentLink(aSeg: Tl3Variant;
 const aPara: InevPara): Boolean;
//#UC START# *391A810FF759_53AC08C900D0_var*
//#UC END# *391A810FF759_53AC08C900D0_var*
begin
//#UC START# *391A810FF759_53AC08C900D0_impl*
 Result := False;
 if aSeg.IsValid then
  if aSeg.IsKindOf(k2_typHyperLink) then
  begin
   ReadLinkInfo(aSeg, aPara);
   Result := LinkViewKind[aSeg] = ev_lvkInternalAbolished;
  end;
//#UC END# *391A810FF759_53AC08C900D0_impl*
end;//TnsCustomStyleProcessor.IsAbolishedDocumentLink

function TnsCustomStyleProcessor.IsVisitedDocumentLink(aSeg: Tl3Variant): Boolean;
//#UC START# *DC1A5D24B383_53AC08C900D0_var*
{$If not defined(Admin) AND not defined(Monitorings)}
var
 l_Addr: TevAddress;
{$ifend}
//#UC END# *DC1A5D24B383_53AC08C900D0_var*
begin
//#UC START# *DC1A5D24B383_53AC08C900D0_impl*
{$If not defined(Admin) AND not defined(Monitorings)}
 if aSeg.IsValid then
  if aSeg.IsKindOf(k2_typHyperLink) then
  begin
   l_Addr := GetLinkAddress(aSeg);
   if (l_Addr.TypeID = CI_TOPIC) then
   begin
    Result := TnscDocumentHistory.Instance.HasDocument(l_Addr.DocID - 100000);
    Exit;
   end;
  end;
{$ifend}
 Result := False;
//#UC END# *DC1A5D24B383_53AC08C900D0_impl*
end;//TnsCustomStyleProcessor.IsVisitedDocumentLink

class function TnsCustomStyleProcessor.Instance: TnsCustomStyleProcessor;
 {* Метод получения экземпляра синглетона TnsCustomStyleProcessor }
begin
 if (g_TnsCustomStyleProcessor = nil) then
 begin
  l3System.AddExitProc(TnsCustomStyleProcessorFree);
  g_TnsCustomStyleProcessor := Create;
 end;
 Result := g_TnsCustomStyleProcessor;
end;//TnsCustomStyleProcessor.Instance

class function TnsCustomStyleProcessor.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsCustomStyleProcessor <> nil;
end;//TnsCustomStyleProcessor.Exists

initialization
 TevCustomStyleManager.Instance.Alien := TnsCustomStyleProcessor.Instance;
 {* Регистрация TnsCustomStyleProcessor }

end.
