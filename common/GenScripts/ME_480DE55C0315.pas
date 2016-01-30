unit afwMultiDocumentPreview;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwMultiDocumentPreview.pas"
// Стереотип: "SimpleClass"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , afwInterfaces
 , afwDocumentPreviewList
 , afwTypes
 , l3Interfaces
 , l3Core
;

type
 TafwMultiDocumentPreview = class(Tl3CacheableBase, IafwDocumentPreview, IafwMultiDocumentPreview)
  private
   f_Docs: TafwDocumentPreviewList;
   f_Printer: IafwPrinter;
  protected
   function GetDocumentName: IafwCString; virtual;
   function DocumentName: IafwCString;
    {* имя документа для preview. }
   function InProcess: Boolean;
    {* идет процесс? }
   function InPagesCounting: Boolean;
    {* сейчас в процессе подсчета страниц? }
   function InUpdate: Boolean;
    {* находимся в процессе построения preview? }
   function InPrinting: Boolean;
    {* находимся в процессе построения печати? }
   procedure Update(const aPanel: IafwPreviewPanel);
    {* установить preview на панель для отображения. }
   procedure Print(anInterval: TafwPagesInterval = afwTypes.afw_piAll;
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
    {* канва отсутствует, но будет передалываться }
   procedure SetCurrentPage(const aCursor: IUnknown);
    {* устанавливает курсор на текущую страницу. }
   procedure SetCurrentPagePara(aParaID: Integer);
    {* устанавливает курсор на текущую страницу. }
   procedure SetCurrentPageNumber(aPageNumber: Integer);
    {* устанавливает курсор на текущую страницу. }
   function CurrentPage: Integer;
    {* текущая страница для печати. }
   function HasCurrentPage: Boolean;
    {* установлена ли текущая страница. }
   function pm_GetPrinter: IafwPrinter;
   procedure pm_SetPrinter(const aValue: IafwPrinter);
   function pm_GetHasText: Boolean;
   procedure AddDocument(const aDocument: IafwDocumentPreview);
    {* Добавляет документ в пачку. }
   function Get_DocCount: Integer;
   function pm_GetPagesInfo: TafwPagesInfo;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make: IafwMultiDocumentPreview; reintroduce;
    {* создает экземпляр класса в виде интерфейса IafwMultiDocumentPreview. }
 end;//TafwMultiDocumentPreview

implementation

uses
 l3ImplUses
 , l3Printer
 , SysUtils
;

class function TafwMultiDocumentPreview.Make: IafwMultiDocumentPreview;
 {* создает экземпляр класса в виде интерфейса IafwMultiDocumentPreview. }
var
 l_Inst : TafwMultiDocumentPreview;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TafwMultiDocumentPreview.Make

function TafwMultiDocumentPreview.GetDocumentName: IafwCString;
//#UC START# *480DE6420179_480DE55C0315_var*
//#UC END# *480DE6420179_480DE55C0315_var*
begin
//#UC START# *480DE6420179_480DE55C0315_impl*
 Result := nil;
//#UC END# *480DE6420179_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.GetDocumentName

function TafwMultiDocumentPreview.DocumentName: IafwCString;
 {* имя документа для preview. }
//#UC START# *473D8C450198_480DE55C0315_var*
//#UC END# *473D8C450198_480DE55C0315_var*
begin
//#UC START# *473D8C450198_480DE55C0315_impl*
 Result := GetDocumentName;
//#UC END# *473D8C450198_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.DocumentName

function TafwMultiDocumentPreview.InProcess: Boolean;
 {* идет процесс? }
//#UC START# *473D8C5C0187_480DE55C0315_var*
var
 l_Index : Integer;
//#UC END# *473D8C5C0187_480DE55C0315_var*
begin
//#UC START# *473D8C5C0187_480DE55C0315_impl*
 Result := false;
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   if f_Docs[l_Index].InProcess then
   begin
    Result := true;
    break;
   end;//f_Docs.InProcess
//#UC END# *473D8C5C0187_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.InProcess

function TafwMultiDocumentPreview.InPagesCounting: Boolean;
 {* сейчас в процессе подсчета страниц? }
//#UC START# *473D8C6C0266_480DE55C0315_var*
var
 l_Index : Integer;
//#UC END# *473D8C6C0266_480DE55C0315_var*
begin
//#UC START# *473D8C6C0266_480DE55C0315_impl*
 Result := false;
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   if f_Docs[l_Index].InPagesCounting then
   begin
    Result := true;
    break;
   end;//f_Docs.InPagesCounting
//#UC END# *473D8C6C0266_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.InPagesCounting

function TafwMultiDocumentPreview.InUpdate: Boolean;
 {* находимся в процессе построения preview? }
//#UC START# *473D8C7C01B5_480DE55C0315_var*
var
 l_Index : Integer;
//#UC END# *473D8C7C01B5_480DE55C0315_var*
begin
//#UC START# *473D8C7C01B5_480DE55C0315_impl*
 Result := false;
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   if f_Docs[l_Index].InUpdate then
   begin
    Result := true;
    break;
   end;//f_Docs.InUpdate
//#UC END# *473D8C7C01B5_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.InUpdate

function TafwMultiDocumentPreview.InPrinting: Boolean;
 {* находимся в процессе построения печати? }
//#UC START# *473D8C90022C_480DE55C0315_var*
var
 l_Index : Integer;
//#UC END# *473D8C90022C_480DE55C0315_var*
begin
//#UC START# *473D8C90022C_480DE55C0315_impl*
 Result := false;
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   if f_Docs[l_Index].InPrinting then
   begin
    Result := true;
    break;
   end;//f_Docs.InPrinting
//#UC END# *473D8C90022C_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.InPrinting

procedure TafwMultiDocumentPreview.Update(const aPanel: IafwPreviewPanel);
 {* установить preview на панель для отображения. }
//#UC START# *473D8CA002D9_480DE55C0315_var*
//#UC END# *473D8CA002D9_480DE55C0315_var*
begin
//#UC START# *473D8CA002D9_480DE55C0315_impl*
 Assert(false);
//#UC END# *473D8CA002D9_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.Update

procedure TafwMultiDocumentPreview.Print(anInterval: TafwPagesInterval = afwTypes.afw_piAll;
 const aRange: Il3RangeManager = nil;
 aCopies: Integer = 1;
 const aFileName: AnsiString = '';
 aCollate: Boolean = True);
 {* напечатать на принтер. }
//#UC START# *473D8CAF028B_480DE55C0315_var*
var
 l_Index : Integer;
//#UC END# *473D8CAF028B_480DE55C0315_var*
begin
//#UC START# *473D8CAF028B_480DE55C0315_impl*
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   f_Docs[l_Index].Print(anInterval, aRange, aCopies, aFileName, aCollate);
//#UC END# *473D8CAF028B_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.Print

procedure TafwMultiDocumentPreview.Stop(aWnd: THandle = 0);
 {* остановит процесс построение preview/печати. }
//#UC START# *473D8CE9007C_480DE55C0315_var*
var
 l_Index : Integer;
//#UC END# *473D8CE9007C_480DE55C0315_var*
begin
//#UC START# *473D8CE9007C_480DE55C0315_impl*
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   f_Docs[l_Index].Stop(aWnd);
//#UC END# *473D8CE9007C_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.Stop

function TafwMultiDocumentPreview.Stopped: Boolean;
 {* процесс остановлен? }
//#UC START# *473D8CF80037_480DE55C0315_var*
var
 l_Index : Integer;
//#UC END# *473D8CF80037_480DE55C0315_var*
begin
//#UC START# *473D8CF80037_480DE55C0315_impl*
 Result := false;
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   if f_Docs[l_Index].Stopped then
   begin
    Result := true;
    break;
   end;//f_Docs.Stopped
//#UC END# *473D8CF80037_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.Stopped

function TafwMultiDocumentPreview.CloseRequested: Boolean;
 {* при остановке процесса был запрос на закрытие превью }
//#UC START# *473D8D0A01D7_480DE55C0315_var*
var
 l_Index : Integer;
//#UC END# *473D8D0A01D7_480DE55C0315_var*
begin
//#UC START# *473D8D0A01D7_480DE55C0315_impl*
 Result := true;
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   if f_Docs[l_Index].CloseRequested then
    exit;
 Result := false;
//#UC END# *473D8D0A01D7_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.CloseRequested

function TafwMultiDocumentPreview.PreviewResetting: Boolean;
 {* канва отсутствует, но будет передалываться }
//#UC START# *473D8D1E01B8_480DE55C0315_var*
var
 l_Index : Integer;
//#UC END# *473D8D1E01B8_480DE55C0315_var*
begin
//#UC START# *473D8D1E01B8_480DE55C0315_impl*
 Result := false;
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   if f_Docs[l_Index].PreviewResetting then
   begin
    Result := true;
    break;
   end;//f_Docs.PreviewResetting
//#UC END# *473D8D1E01B8_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.PreviewResetting

procedure TafwMultiDocumentPreview.SetCurrentPage(const aCursor: IUnknown);
 {* устанавливает курсор на текущую страницу. }
//#UC START# *473D8D3800B1_480DE55C0315_var*
//#UC END# *473D8D3800B1_480DE55C0315_var*
begin
//#UC START# *473D8D3800B1_480DE55C0315_impl*
 // ничего не делаем
//#UC END# *473D8D3800B1_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.SetCurrentPage

procedure TafwMultiDocumentPreview.SetCurrentPagePara(aParaID: Integer);
 {* устанавливает курсор на текущую страницу. }
//#UC START# *473D8D4A019D_480DE55C0315_var*
//#UC END# *473D8D4A019D_480DE55C0315_var*
begin
//#UC START# *473D8D4A019D_480DE55C0315_impl*
 // ничего не делаем
//#UC END# *473D8D4A019D_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.SetCurrentPagePara

procedure TafwMultiDocumentPreview.SetCurrentPageNumber(aPageNumber: Integer);
 {* устанавливает курсор на текущую страницу. }
//#UC START# *473D8D5D032B_480DE55C0315_var*
//#UC END# *473D8D5D032B_480DE55C0315_var*
begin
//#UC START# *473D8D5D032B_480DE55C0315_impl*
 // ничего не делаем
//#UC END# *473D8D5D032B_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.SetCurrentPageNumber

function TafwMultiDocumentPreview.CurrentPage: Integer;
 {* текущая страница для печати. }
//#UC START# *473D8D72010F_480DE55C0315_var*
//#UC END# *473D8D72010F_480DE55C0315_var*
begin
//#UC START# *473D8D72010F_480DE55C0315_impl*
 Result := -1;
//#UC END# *473D8D72010F_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.CurrentPage

function TafwMultiDocumentPreview.HasCurrentPage: Boolean;
 {* установлена ли текущая страница. }
//#UC START# *473D8D830163_480DE55C0315_var*
//#UC END# *473D8D830163_480DE55C0315_var*
begin
//#UC START# *473D8D830163_480DE55C0315_impl*
 Result := false;
//#UC END# *473D8D830163_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.HasCurrentPage

function TafwMultiDocumentPreview.pm_GetPrinter: IafwPrinter;
//#UC START# *473D8D9500C9_480DE55C0315get_var*
//#UC END# *473D8D9500C9_480DE55C0315get_var*
begin
//#UC START# *473D8D9500C9_480DE55C0315get_impl*
 if (f_Printer = nil) then
  f_Printer := Tl3Printer.Make;
 Result := f_Printer;
//#UC END# *473D8D9500C9_480DE55C0315get_impl*
end;//TafwMultiDocumentPreview.pm_GetPrinter

procedure TafwMultiDocumentPreview.pm_SetPrinter(const aValue: IafwPrinter);
//#UC START# *473D8D9500C9_480DE55C0315set_var*
var
 l_Index : Integer;  
//#UC END# *473D8D9500C9_480DE55C0315set_var*
begin
//#UC START# *473D8D9500C9_480DE55C0315set_impl*
 f_Printer := aValue;
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   f_Docs[l_Index].Printer := aValue;
//#UC END# *473D8D9500C9_480DE55C0315set_impl*
end;//TafwMultiDocumentPreview.pm_SetPrinter

function TafwMultiDocumentPreview.pm_GetHasText: Boolean;
//#UC START# *473D8DB10141_480DE55C0315get_var*
//#UC END# *473D8DB10141_480DE55C0315get_var*
begin
//#UC START# *473D8DB10141_480DE55C0315get_impl*
 Result := not f_Docs.Empty;
//#UC END# *473D8DB10141_480DE55C0315get_impl*
end;//TafwMultiDocumentPreview.pm_GetHasText

procedure TafwMultiDocumentPreview.AddDocument(const aDocument: IafwDocumentPreview);
 {* Добавляет документ в пачку. }
//#UC START# *47FB296803AD_480DE55C0315_var*
//#UC END# *47FB296803AD_480DE55C0315_var*
begin
//#UC START# *47FB296803AD_480DE55C0315_impl*
 if (aDocument <> nil) then
 begin
  if (f_Docs = nil) then
   f_Docs := TafwDocumentPreviewList.Make;
  aDocument.Printer := pm_GetPrinter;
  f_Docs.Add(aDocument);
 end;//aDocument <> nil
//#UC END# *47FB296803AD_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.AddDocument

function TafwMultiDocumentPreview.Get_DocCount: Integer;
//#UC START# *48902EA0010E_480DE55C0315get_var*
//#UC END# *48902EA0010E_480DE55C0315get_var*
begin
//#UC START# *48902EA0010E_480DE55C0315get_impl*
 if Assigned(f_Docs) then
  Result := f_Docs.Count
 else
  Result := 0;
//#UC END# *48902EA0010E_480DE55C0315get_impl*
end;//TafwMultiDocumentPreview.Get_DocCount

function TafwMultiDocumentPreview.pm_GetPagesInfo: TafwPagesInfo;
//#UC START# *4CC6A6FF0362_480DE55C0315get_var*
var
 l_Index : Integer;
//#UC END# *4CC6A6FF0362_480DE55C0315get_var*
begin
//#UC START# *4CC6A6FF0362_480DE55C0315get_impl*
 Result := TafwPagesInfo_Z;
 if (f_Docs <> nil) then
  for l_Index := f_Docs.Lo to f_Docs.Hi do
   Result := Result.Add(f_Docs[l_Index].PagesInfo);
//#UC END# *4CC6A6FF0362_480DE55C0315get_impl*
end;//TafwMultiDocumentPreview.pm_GetPagesInfo

procedure TafwMultiDocumentPreview.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_480DE55C0315_var*
//#UC END# *479731C50290_480DE55C0315_var*
begin
//#UC START# *479731C50290_480DE55C0315_impl*
 f_Printer := nil;
 FreeAndNil(f_Docs);
 inherited;
//#UC END# *479731C50290_480DE55C0315_impl*
end;//TafwMultiDocumentPreview.Cleanup

end.
