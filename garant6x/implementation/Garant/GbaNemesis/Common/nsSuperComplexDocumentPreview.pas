unit nsSuperComplexDocumentPreview;
 {* ѕредварительный просмотр печати составного документа. }

// $Id: nsSuperComplexDocumentPreview.pas,v 1.9 2013/04/24 09:35:55 lulin Exp $

// $Log: nsSuperComplexDocumentPreview.pas,v $
// Revision 1.9  2013/04/24 09:35:55  lulin
// - портируем.
//
// Revision 1.8  2010/10/26 13:02:49  lulin
// {RequestLink:237503905}.
//
// Revision 1.7  2010/07/02 10:16:58  oman
// - fix: {RequestLink:222036047}
//
// Revision 1.6  2009/09/28 10:33:13  lulin
// - переносим примесь дл€ обработки переключени€ закладок в более правильное место.
//
// Revision 1.1  2009/09/14 11:28:32  lulin
// - выводим пути и дл€ незавершЄнных модулей.
//
// Revision 1.4  2009/02/10 19:03:55  lulin
// - <K>: 133891247. ¬ычищаем морально устаревший модуль.
//
// Revision 1.3  2009/02/10 17:45:11  lulin
// - <K>: 133891247. ¬ыдел€ем интерфейсы Preview.
//
// Revision 1.2  2008/12/12 19:19:09  lulin
// - <K>: 129762414.
//
// Revision 1.1  2008/07/30 10:43:45  oman
// - new: ћодификаци€ диалога печати ( -104432770)
//
//

{$Include nsDefine.inc}

interface

uses
  l3Interfaces,

  afwInterfaces,

  vcmBase,

  l3IID,
  afwTypes,
  afwPreviewNotifierPtrList,

  PreviewInterfaces
  ;

type
 TnsSuperComplexDocumentPreviewArray = array [TnsSuperPreviewKind] of IafwComplexDocumentPreview;
  {*  }

 TnsSuperComplexDocumentPreview = class(TvcmCacheableBase,
                                        IafwDocumentPreview,
                                        IafwPreviewNotifier,
                                        IafwComplexDocumentPreview,
                                        IafwPreviewNotificationSource,
                                        InsSuperComplexDocumentPreview)
  {* ѕредварительный просмотр печати составного документа. }
 private
 // private fields
   f_SuperKind: TnsSuperPreviewKind;
   f_Printer : IafwPrinter;
   f_Previews : TnsSuperComplexDocumentPreviewArray;
   f_PreviewSubscribers : TafwPreviewNotifierPtrList;
 private
 // private methods
   procedure CheckPrinter(aSuperKind: TnsSuperPreviewKind);
   procedure CheckContent(aSuperKind: TnsSuperPreviewKind);
   procedure SetSuperContent(aSuperKind: TnsSuperPreviewKind;
    const aValue: IafwComplexDocumentPreview);
 protected
 // realized methods
   procedure ContentChanged;
     {* —одержимое preview изменилось. }
   function DocumentName: IafwCString;
     {* им€ документа дл€ preview. }
   function InProcess: Boolean;
     {* идет процесс? }
   function InPagesCounting: Boolean;
     {* сейчас в процессе подсчета страниц? }
   function InUpdate: Boolean;
     {* находимс€ в процессе построени€ preview? }
   function InPrinting: Boolean;
     {* находимс€ в процессе построени€ печати? }
   procedure Update(const aPanel: IafwPreviewPanel);
     {* установить preview на панель дл€ отображени€. }
   procedure Print(anInterval: TafwPagesInterval = afw_piAll;
    const aRange: Il3RangeManager = nil;
    aCopies: Integer = 1;
    const aFileName: AnsiString = '';
    aCollate: Boolean = True);
     {* напечатать на принтер. }
   procedure Stop(aWnd: THandle = 0);
     {* остановит процесс построение preview/печати. }
   function Stopped: Boolean;
     {* процесс остановлен? }
   function CloseRequested: Boolean;
     {* при остановке процесса был запрос на закрытие превью }
   function PreviewResetting: Boolean;
     {* канва отсутствует, но будет передалыватьс€ }
   procedure SetCurrentPage(const aCursor: IUnknown);
     {* устанавливает курсор на текущую страницу. }
   procedure SetCurrentPagePara(aParaID: Integer);
     {* устанавливает курсор на текущую страницу. }
   procedure SetCurrentPageNumber(aPageNumber: Integer);
     {* устанавливает курсор на текущую страницу. }
   function CurrentPage: Integer;
     {* текуща€ страница дл€ печати. }
   function HasCurrentPage: Boolean;
     {* установлена ли текуща€ страница. }
   function pm_GetPrinter: IafwPrinter;
   procedure pm_SetPrinter(const aValue: IafwPrinter);
   function pm_GetPagesInfo: TafwPagesInfo;
   function pm_GetHasText: Boolean;
   function pm_GetContentKind: TafwPreviewContentKind;
   procedure pm_SetContentKind(aValue: TafwPreviewContentKind);
   function Current: IafwDocumentPreview;
   function Document: IafwDocumentPreview;
   procedure SetDocument(const aDocument: IafwDocumentPreview);
   function Selection: IafwDocumentPreview;
   procedure SetSelection(const aSelection: IafwDocumentPreview);
   function Info: IafwDocumentPreview;
   procedure SetInfo(const anInfo: IafwDocumentPreview);
   procedure Subscribe(const aNotifier: IafwPreviewNotifier);
   procedure UnSubscribe(const aNotifier: IafwPreviewNotifier);

   function Get_SuperCurrent: IafwComplexDocumentPreview;
   function Get_DocumentTitles: IafwComplexDocumentPreview;
   procedure Set_DocumentTitles(const aDocumentTitles: IafwComplexDocumentPreview);
   function Get_DocumentTexts: IafwComplexDocumentPreview;
   procedure Set_DocumentTexts(const aDocumentTexts: IafwComplexDocumentPreview);
   function pm_GetSuperContentKind: TnsSuperPreviewKind;
   procedure pm_SetSuperContentKind(aValue: TnsSuperPreviewKind);
 protected
 // overridden protected methods
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
   procedure Cleanup; override;
     {* ‘ункци€ очистки полей объекта. }
 public
 // public methods
   constructor Create(const aDocumentTitles: IafwComplexDocumentPreview;
    const aDocumentTexts: IafwComplexDocumentPreview); reintroduce;
   class function Make(const aDocumentTitles: IafwComplexDocumentPreview;
    const aDocumentTexts: IafwComplexDocumentPreview = nil): InsSuperComplexDocumentPreview; reintroduce;
 end;//TnsSuperComplexDocumentPreview

implementation

uses
  SysUtils,
  l3Printer,
  l3Base
  ;

// start class TnsSuperComplexDocumentPreview

procedure TnsSuperComplexDocumentPreview.CheckPrinter(aSuperKind: TnsSuperPreviewKind);
begin
 if (f_Previews[aSuperKind] <> nil) then
  f_Previews[aSuperKind].Printer := pm_GetPrinter;
end;

procedure TnsSuperComplexDocumentPreview.CheckContent(aSuperKind: TnsSuperPreviewKind);
begin
 if f_SuperKind = aSuperKind then
  ContentChanged;
end;

procedure TnsSuperComplexDocumentPreview.SetSuperContent(aSuperKind: TnsSuperPreviewKind;
  const aValue: IafwComplexDocumentPreview);
var
 l_Source: IafwPreviewNotificationSource;
begin
 if f_Previews[aSuperKind] = aValue then Exit;
 if Supports(f_Previews[aSuperKind], IafwPreviewNotificationSource, l_Source) then
  l_Source.UnSubscribe(Self);
 f_Previews[aSuperKind] := aValue;
 if Supports(f_Previews[aSuperKind], IafwPreviewNotificationSource, l_Source) then
  l_Source.Subscribe(Self);
 CheckPrinter(aSuperKind);
 CheckContent(aSuperKind);
end;

constructor TnsSuperComplexDocumentPreview.Create(const aDocumentTitles: IafwComplexDocumentPreview;
    const aDocumentTexts: IafwComplexDocumentPreview);
begin
 inherited Create;
 SetSuperContent(ns_spkDocumentTitles, aDocumentTitles);
 SetSuperContent(ns_spkDocumentTexts, aDocumentTexts);
 f_SuperKind := ns_spkDocumentTitles;
 pm_GetPrinter;
 // - это чтобы присвоить один принтервсем част€м
end;

class function TnsSuperComplexDocumentPreview.Make(const aDocumentTitles: IafwComplexDocumentPreview;
    const aDocumentTexts: IafwComplexDocumentPreview = nil): InsSuperComplexDocumentPreview;
var
 l_Inst : TnsSuperComplexDocumentPreview;
begin
 l_Inst := Create(aDocumentTitles, aDocumentTexts);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnsSuperComplexDocumentPreview.ContentChanged;
var
 l_Idx: Integer;
begin
 if Assigned(f_PreviewSubscribers) then
  for l_Idx := f_PreviewSubscribers.Hi downto f_PreviewSubscribers.Lo do
   f_PreviewSubscribers[l_Idx].ContentChanged;
end;

function TnsSuperComplexDocumentPreview.DocumentName: IafwCString;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := nil
 else
  Result := f_Previews[f_SuperKind].DocumentName;
end;

function TnsSuperComplexDocumentPreview.InProcess: Boolean;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := false
 else
  Result := f_Previews[f_SuperKind].InProcess;
end;

function TnsSuperComplexDocumentPreview.InPagesCounting: Boolean;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := false
 else
  Result := f_Previews[f_SuperKind].InPagesCounting;
end;

function TnsSuperComplexDocumentPreview.InUpdate: Boolean;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := false
 else
  Result := f_Previews[f_SuperKind].InUpdate;
end;

function TnsSuperComplexDocumentPreview.InPrinting: Boolean;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := false
 else
  Result := f_Previews[f_SuperKind].InPrinting;
end;

procedure TnsSuperComplexDocumentPreview.Update(const aPanel: IafwPreviewPanel);
begin
 if (f_Previews[f_SuperKind] <> nil) then
  f_Previews[f_SuperKind].Update(aPanel);
end;

procedure TnsSuperComplexDocumentPreview.Print(anInterval: TafwPagesInterval = afw_piAll;
  const aRange: Il3RangeManager = nil;
  aCopies: Integer = 1;
  const aFileName: AnsiString = '';
  aCollate: Boolean = True);
begin
 if (f_Previews[f_SuperKind] <> nil) then
  f_Previews[f_SuperKind].Print(anInterval, aRange, aCopies, aFileName, aCollate);
end;

procedure TnsSuperComplexDocumentPreview.Stop(aWnd: THandle = 0);
begin
 if (f_Previews[f_SuperKind] <> nil) then
  f_Previews[f_SuperKind].Stop(aWnd);
end;

function TnsSuperComplexDocumentPreview.Stopped: Boolean;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := false
 else
  Result := f_Previews[f_SuperKind].Stopped;
end;

function TnsSuperComplexDocumentPreview.CloseRequested: Boolean;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := true
 else
  Result := f_Previews[f_SuperKind].CloseRequested;
end;

function TnsSuperComplexDocumentPreview.PreviewResetting: Boolean;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := false
 else
  Result := f_Previews[f_SuperKind].PreviewResetting;
end;

procedure TnsSuperComplexDocumentPreview.SetCurrentPage(const aCursor: IUnknown);
begin
 if (f_Previews[f_SuperKind] <> nil) then
  f_Previews[f_SuperKind].SetCurrentPage(aCursor);
end;

procedure TnsSuperComplexDocumentPreview.SetCurrentPagePara(aParaID: Integer);
begin
 if (f_Previews[f_SuperKind] <> nil) then
  f_Previews[f_SuperKind].SetCurrentPagePara(aParaID);
end;

procedure TnsSuperComplexDocumentPreview.SetCurrentPageNumber(aPageNumber: Integer);
begin
 if (f_Previews[f_SuperKind] <> nil) then
  f_Previews[f_SuperKind].SetCurrentPageNumber(aPageNumber);
end;

function TnsSuperComplexDocumentPreview.CurrentPage: Integer;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := 0
 else
  Result := f_Previews[f_SuperKind].CurrentPage;
end;

function TnsSuperComplexDocumentPreview.HasCurrentPage: Boolean;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := false
 else
  Result := f_Previews[f_SuperKind].HasCurrentPage;
end;

function TnsSuperComplexDocumentPreview.pm_GetPrinter: IafwPrinter;
begin
 if (f_Printer = nil) then
  pm_SetPrinter(Tl3Printer.Make);
 Result := f_Printer;
end;

procedure TnsSuperComplexDocumentPreview.pm_SetPrinter(const aValue: IafwPrinter);
var
 l_IDX: TnsSuperPreviewKind;
begin
 if (f_Printer <> aValue) then
 begin
  f_Printer := aValue;
  for l_Idx := Low(TnsSuperPreviewKind) to High(TnsSuperPreviewKind) do
   CheckPrinter(l_Idx);
 end;//f_Printer <> aValue
end;

function TnsSuperComplexDocumentPreview.pm_GetPagesInfo: TafwPagesInfo;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := TafwPagesInfo_E
 else
  Result := f_Previews[f_SuperKind].PagesInfo;
end;

function TnsSuperComplexDocumentPreview.pm_GetHasText: Boolean;
begin
 if (f_Previews[f_SuperKind] = nil) then
  Result := false
 else
  Result := f_Previews[f_SuperKind].HasText;
end;

function TnsSuperComplexDocumentPreview.pm_GetContentKind: TafwPreviewContentKind;
begin
 Result := f_Previews[f_SuperKind].ContentKind;
end;

procedure TnsSuperComplexDocumentPreview.pm_SetContentKind(aValue: TafwPreviewContentKind);
begin
 f_Previews[f_SuperKind].ContentKind := aValue;
end;

function TnsSuperComplexDocumentPreview.Current: IafwDocumentPreview;
begin
 Result := f_Previews[f_SuperKind].Current;
end;

function TnsSuperComplexDocumentPreview.Document: IafwDocumentPreview;
begin
 Result := f_Previews[f_SuperKind].Document;
end;

procedure TnsSuperComplexDocumentPreview.SetDocument(const aDocument: IafwDocumentPreview);
begin
 f_Previews[f_SuperKind].SetDocument(aDocument);
end;

function TnsSuperComplexDocumentPreview.Selection: IafwDocumentPreview;
begin
 Result := f_Previews[f_SuperKind].Selection;
end;

procedure TnsSuperComplexDocumentPreview.SetSelection(const aSelection: IafwDocumentPreview);
begin
 f_Previews[f_SuperKind].SetSelection(aSelection);
end;

function TnsSuperComplexDocumentPreview.Info: IafwDocumentPreview;
begin
 Result := f_Previews[f_SuperKind].Info;
end;

procedure TnsSuperComplexDocumentPreview.SetInfo(const anInfo: IafwDocumentPreview);
begin
 f_Previews[f_SuperKind].SetInfo(anInfo);
end;

procedure TnsSuperComplexDocumentPreview.Subscribe(const aNotifier: IafwPreviewNotifier);
begin
 if f_PreviewSubscribers = nil then
  f_PreviewSubscribers := TafwPreviewNotifierPtrList.Make;
 f_PreviewSubscribers.Add(aNotifier);
end;

procedure TnsSuperComplexDocumentPreview.UnSubscribe(const aNotifier: IafwPreviewNotifier);
begin
 f_PreviewSubscribers.Remove(aNotifier);
 if f_PreviewSubscribers.Count = 0 then
  FreeAndNil(f_PreviewSubscribers);
end;

function TnsSuperComplexDocumentPreview.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
begin
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if Supports(f_Previews[f_SuperKind], IID.IID, Obj) then
   Result.SetOk;
end;

procedure TnsSuperComplexDocumentPreview.Cleanup;
var
 l_Idx: TnsSuperPreviewKind;
begin
 FreeAndNil(f_PreviewSubscribers);
 for l_Idx := Low(TnsSuperPreviewKind) to High(TnsSuperPreviewKind) do
  SetSuperContent(l_Idx, nil);
 f_Printer := nil;
 inherited;
end;

function TnsSuperComplexDocumentPreview.pm_GetSuperContentKind: TnsSuperPreviewKind;
begin
 Result := f_SuperKind;
end;

procedure TnsSuperComplexDocumentPreview.pm_SetSuperContentKind(
  aValue: TnsSuperPreviewKind);
begin
 if (f_SuperKind <> aValue) then
 begin
  f_SuperKind := aValue;
  CheckContent(f_SuperKind);
 end;
end;

function TnsSuperComplexDocumentPreview.Get_DocumentTexts: IafwComplexDocumentPreview;
begin
 Result := f_Previews[ns_spkDocumentTexts];
end;

function TnsSuperComplexDocumentPreview.Get_DocumentTitles: IafwComplexDocumentPreview;
begin
 Result := f_Previews[ns_spkDocumentTitles];
end;

procedure TnsSuperComplexDocumentPreview.Set_DocumentTexts(
  const aDocumentTexts: IafwComplexDocumentPreview);
begin
 SetSuperContent(ns_spkDocumentTexts, aDocumentTexts);
end;

procedure TnsSuperComplexDocumentPreview.Set_DocumentTitles(
  const aDocumentTitles: IafwComplexDocumentPreview);
begin
 SetSuperContent(ns_spkDocumentTitles, aDocumentTitles);
end;

function TnsSuperComplexDocumentPreview.Get_SuperCurrent: IafwComplexDocumentPreview;
begin
 Result := f_Previews[f_SuperKind];
end;

end.