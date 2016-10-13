unit arDirectMultiOperationHelper;

// Модуль: "w:\archi\source\projects\Common\Utils\arDirectMultiOperationHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TarDirectMultiOperationHelper" MUID: (57ED158F01BB)

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

uses
 l3IntfUses
 , arCustomMultiOperationHelper
 , l3LongintList
 , l3DatLst
;

type
 TarDirectMultiOperationHelper = class(TarCustomMultiOperationHelper)
  private
   f_ErrorList: Tl3LongintList;
   f_ProcessedDocsCount: Integer;
  private
   procedure DoGroupTouch;
   procedure DoTouchIZM;
   procedure DoChangeKeywords;
   procedure DoSetClonePublishedIn;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure ModifyDocs; override;
   function HasErrorDocs: Boolean; override;
   procedure FillErrorDocsList(aList: Tl3StringDataList); override;
   function ProcessedDocsCount: Integer; override;
 end;//TarDirectMultiOperationHelper

implementation

uses
 l3ImplUses
 , l3MarshalledTypes
 {$If NOT Defined(Nemesis)}
 , dt_LinkServ
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_Types
 , SewerPipe
 , l3FileUtils
 {$If NOT Defined(Nemesis)}
 , dt_Serv
 {$IfEnd} // NOT Defined(Nemesis)
 , dt_AttrSchema
 , SysUtils
 {$If NOT Defined(Nemesis)}
 , dt_Doc
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , dtIntf
 {$IfEnd} // NOT Defined(Nemesis)
 , daTypes
 , HT_Const
 , dt_Const
 {$If NOT Defined(Nemesis)}
 , dt_Sab
 {$IfEnd} // NOT Defined(Nemesis)
 , arIZM
 //#UC START# *57ED158F01BBimpl_uses*
 , ddKTExtractor
 , ddDocNameUpdateFilter
 , Dt_aTbl
 , DT_Misc
 , DT_Link
 //#UC END# *57ED158F01BBimpl_uses*
;

const
 sKTFilename = 'kthemes.csv';

procedure TarDirectMultiOperationHelper.DoGroupTouch;
//#UC START# *57EE39E001C8_57ED158F01BB_var*
//#UC END# *57EE39E001C8_57ED158F01BB_var*
begin
//#UC START# *57EE39E001C8_57ED158F01BB_impl*
 LinkServer(FamilyID).LogBook.PutLogRecToDocs(DocsList, acAttrWork);
//#UC END# *57EE39E001C8_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.DoGroupTouch

procedure TarDirectMultiOperationHelper.DoTouchIZM;
//#UC START# *57EE3A50011C_57ED158F01BB_var*
var
 l_IZMIDs : ISab;
 l_Value : Byte;
//#UC END# *57EE3A50011C_57ED158F01BB_var*
begin
//#UC START# *57EE3A50011C_57ED158F01BB_impl*
 f_ProcessedDocsCount := GetIZMChecker.CheckoutForIZM(DocsList, l_IZMIDs);
 if f_ProcessedDocsCount > 0 then
 begin
  LinkServer(FamilyID).LogBook.PutLogRecToDocs(l_IZMIDs, acAttrWork);
  l_Value := Byte(utIzm);
  l_IZMIDs.RecordsByKey;
  l_IZMIDs.ModifyRecs(fUserType_Fld, l_Value);
 end;
//#UC END# *57EE3A50011C_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.DoTouchIZM

procedure TarDirectMultiOperationHelper.DoChangeKeywords;
//#UC START# *57EE3A5C035A_57ED158F01BB_var*
var
 l_OutPipe  : TSewerPipe;
 l_KTFilter : TddKTExtractorTermFilter;
 l_DocNameFilter: TddDocNameUpdateFilter;
 l_Filename: AnsiString;
//#UC END# *57EE3A5C035A_57ED158F01BB_var*
begin
//#UC START# *57EE3A5C035A_57ED158F01BB_impl*
 l_Filename := ConcatDirName(GlobalHtServer.Family[FamilyID].Path, sKTFilename);
 LoadKTScan(l_Filename);
 l_OutPipe := TSewerPipe.Create;
 try
  l_OutPipe.ExportDocument:= True;
  l_OutPipe.Attributes := cAllMainRecData;
  l_OutPipe.ExportDocTypes := [dtText];
  l_KTFilter := TddKTExtractorTermFilter.Create;
  try
   l_OutPipe.Writer := l_KTFilter;
   l_DocNameFilter := TddDocNameUpdateFilter.Create;
   try
    l_KTFilter.Generator := l_DocNameFilter;

    l_OutPipe.DocSab := DocsList;
    DocumentServer(FamilyID).FileTbl.StartCaching([roUpdate]);
    try
     l_OutPipe.Execute;
     LinkServer(FamilyID).LogBook.PutLogRecToDocs(DocsList, acAttrWork);
    finally
     DocumentServer(FamilyID).FileTbl.StopCaching;
    end;
   finally
    FreeAndNil(l_DocNameFilter);
   end;
  finally
   FreeAndNil(l_KTFilter);
  end;
 finally
  FreeAndNil(l_OutPipe);
 end;
//#UC END# *57EE3A5C035A_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.DoChangeKeywords

procedure TarDirectMultiOperationHelper.DoSetClonePublishedIn;
//#UC START# *57EE3A710357_57ED158F01BB_var*
var
 l_LinkList: ISab;
 l_BadDocList: ISab;
 l_BadLinkList: ISab;
 l_AccProc: TdtRecAccessProc;
 lpSetCloneStub: Pointer;

 function lpSetClone(gRecNo  : LongInt; fpRecord: Pointer) : MFUNC_RET;
 begin
  Result := MFUNC_SUCCESS;
  PPublishLinkRec(fpRecord)^.Flags := PPublishLinkRec(fpRecord)^.Flags or pinfClone;
 end;

//#UC END# *57EE3A710357_57ED158F01BB_var*
begin
//#UC START# *57EE3A710357_57ED158F01BB_impl*

 l_LinkList := MakeSabCopy(DocsList);
 l_LinkList.ValuesOfKey(fId_Fld);
 l_LinkList.TransferToPhoto(lnkDocIDFld, LinkServer(FamilyID)[atPublisheds]);
 l_LinkList.RecordsByKey;

 // теперь найдём список всех линков, которых больше двух к одному документу
 l_BadDocList := MakeSabCopy(l_LinkList);
 l_BadDocList.ValuesOfKeyByCount(lnkDocIDFld);
 //BadDocList.ValuesOfKey(1);

 l_BadLinkList := MakeSabCopy(l_BadDocList);

 l_BadDocList.TransferToPhoto(fId_Fld, DocumentServer(FamilyID).FileTbl);
 l_BadDocList.RecordsByKey; // саб со списком "плохих" документов (для отчёта)

 l_BadLinkList.TransferToPhoto(lnkDocIDFld, LinkServer(FamilyID)[atPublisheds]);
 l_BadLinkList.RecordsByKey; // саб со списком "плохих" линков, чтобы выкинуть из списка обработки

 // вычитаем результаты
 l_LinkList.SubtractSab(l_BadLinkList);
 l_BadLinkList := nil;

 // правим поле Flags
 lpSetCloneStub := HTStub3(@lpSetClone);
 try
  l_LinkList.ModifyRecs(lpSetCloneStub);
 finally
  HTStubFree(lpSetCloneStub);
 end;

 if l_BadDocList.Count > 0 then
  dtCopyValuesSabToList(l_BadDocList, f_ErrorList);
 // выводим список документов, у которых больше одного источника опубликования => нельзя ставить пометку
//#UC END# *57EE3A710357_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.DoSetClonePublishedIn

procedure TarDirectMultiOperationHelper.ModifyDocs;
//#UC START# *57ED15AC02A7_57ED158F01BB_var*
//#UC END# *57ED15AC02A7_57ED158F01BB_var*
begin
//#UC START# *57ED15AC02A7_57ED158F01BB_impl*
 case Operation of
  ar_moGroupTouch: DoGroupTouch;
  ar_moTouchIZM: DoTouchIZM;
  ar_moChangeKeywords: DoChangeKeywords;
  ar_moSetClonePublishedin: DoSetClonePublishedin;
 else
  Assert(False);
 end;
//#UC END# *57ED15AC02A7_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.ModifyDocs

function TarDirectMultiOperationHelper.HasErrorDocs: Boolean;
//#UC START# *57FB778D0148_57ED158F01BB_var*
//#UC END# *57FB778D0148_57ED158F01BB_var*
begin
//#UC START# *57FB778D0148_57ED158F01BB_impl*
 Result := f_ErrorList.Count > 0;
//#UC END# *57FB778D0148_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.HasErrorDocs

procedure TarDirectMultiOperationHelper.FillErrorDocsList(aList: Tl3StringDataList);
//#UC START# *57FB77AB0147_57ED158F01BB_var*
var
 l_IDX: Integer;
 l_ImpId: TdaDocID;
 l_Msg: AnsiString;
//#UC END# *57FB77AB0147_57ED158F01BB_var*
begin
//#UC START# *57FB77AB0147_57ED158F01BB_impl*
 for l_IDX := 0 to Pred(f_ErrorList.Count) do
 begin
  l_ImpId := f_ErrorList[l_IDX];
  l_Msg := IntToStr(l_ImpId);
  aList.AddStr(l_Msg, @l_ImpId);
 end; 
//#UC END# *57FB77AB0147_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.FillErrorDocsList

function TarDirectMultiOperationHelper.ProcessedDocsCount: Integer;
//#UC START# *57FDE80903AE_57ED158F01BB_var*
//#UC END# *57FDE80903AE_57ED158F01BB_var*
begin
//#UC START# *57FDE80903AE_57ED158F01BB_impl*
 Result := f_ProcessedDocsCount;
//#UC END# *57FDE80903AE_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.ProcessedDocsCount

procedure TarDirectMultiOperationHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57ED158F01BB_var*
//#UC END# *479731C50290_57ED158F01BB_var*
begin
//#UC START# *479731C50290_57ED158F01BB_impl*
 FreeAndNil(f_ErrorList);
 inherited;
//#UC END# *479731C50290_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.Cleanup

procedure TarDirectMultiOperationHelper.InitFields;
//#UC START# *47A042E100E2_57ED158F01BB_var*
//#UC END# *47A042E100E2_57ED158F01BB_var*
begin
//#UC START# *47A042E100E2_57ED158F01BB_impl*
 f_ErrorList := Tl3LongintList.Make;
 f_ProcessedDocsCount := 0;
//#UC END# *47A042E100E2_57ED158F01BB_impl*
end;//TarDirectMultiOperationHelper.InitFields

end.
